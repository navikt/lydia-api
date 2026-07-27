package no.nav.lydia.helper

import io.ktor.client.HttpClient
import io.ktor.client.call.body
import io.ktor.client.engine.cio.CIO
import io.ktor.client.request.bearerAuth
import io.ktor.client.request.request
import io.ktor.client.request.setBody
import io.ktor.client.statement.bodyAsText
import io.ktor.http.ContentType
import io.ktor.http.HttpMethod
import io.ktor.http.contentType
import kotlinx.coroutines.runBlocking
import kotlinx.serialization.InternalSerializationApi
import kotlinx.serialization.KSerializer
import kotlinx.serialization.builtins.ListSerializer
import kotlinx.serialization.json.Json
import kotlinx.serialization.serializer
import java.net.URI
import java.net.URL

internal val testHttpClient = HttpClient(CIO)

private val json = Json { ignoreUnknownKeys = true }

internal fun String.toAsciiUrl(): String = URI(this).toASCIIString()

class TestRequest(
    private val method: HttpMethod,
    private val url: String,
) {
    private var authToken: String? = null
    private var bodyContent: String? = null

    inner class AuthExtension {
        fun bearer(token: String) = this@TestRequest.also { it.authToken = token }
    }

    fun authentication() = AuthExtension()

    fun jsonBody(json: String) = apply { bodyContent = json }

    internal fun executeBlocking(): Triple<Int, String, String> =
        runBlocking {
            val response = testHttpClient.request(url.toAsciiUrl()) {
                this.method = this@TestRequest.method
                authToken?.let { bearerAuth(it) }
                bodyContent?.let {
                    contentType(ContentType.Application.Json)
                    setBody(it)
                }
            }
            Triple(response.status.value, response.status.description, response.bodyAsText())
        }

    internal fun executeBlockingByteArray(): Triple<Int, String, ByteArray> =
        runBlocking {
            val response = testHttpClient.request(url.toAsciiUrl()) {
                this.method = this@TestRequest.method
                authToken?.let { bearerAuth(it) }
                bodyContent?.let {
                    contentType(ContentType.Application.Json)
                    setBody(it)
                }
            }
            Triple(response.status.value, response.status.description, response.body())
        }

    internal fun toRequestInfo() = TestHttpClientRequestInfo(methodValue = method.value, urlValue = url.toAsciiUrl())
}

data class TestHttpClientRequestInfo(
    private val methodValue: String,
    private val urlValue: String,
) {
    val method: String = methodValue
    val url: URL = URI(urlValue).toURL()
}

class TestHttpClientBody(
    private val text: String,
) {
    fun asString(contentType: String): String = text
}

class TestHttpClientResponse(
    val statusCode: Int,
    val statusDescription: String,
    private val bodyText: String,
) {
    val isSuccessful: Boolean get() = statusCode in 200..299

    fun body(): TestHttpClientBody = TestHttpClientBody(bodyText)
}

class TestHttpClientError(
    val bodyText: String,
    val statusCode: Int,
    val statusDescription: String,
    val cause: Exception? = null,
) {
    val message: String get() = "HTTP $statusCode $statusDescription: $bodyText"
    val response: TestHttpClientResponse = TestHttpClientResponse(statusCode = statusCode, statusDescription = statusDescription, bodyText = bodyText)

    fun stackTraceToString(): String = cause?.stackTraceToString() ?: message
}

sealed class TestResult<T> {
    data class Success<T>(
        val value: T,
    ) : TestResult<T>()

    data class Failure<T>(
        val error: TestHttpClientError,
    ) : TestResult<T>()

    fun <R> fold(
        success: (T) -> R,
        failure: (TestHttpClientError) -> R,
    ): R =
        when (this) {
            is Success -> success(value)
            is Failure -> failure(error)
        }

    fun get(): T =
        when (this) {
            is Success -> value
            is Failure -> throw error.cause ?: Exception(error.message)
        }

    override fun toString(): String =
        when (this) {
            is Success -> "Success($value)"
            is Failure -> "Failure(${error.message})"
        }
}

class TestResponseTriple<T>(
    requestInfo: TestHttpClientRequestInfo,
    statusCode: Int,
    statusDescription: String,
    bodyText: String,
    result: TestResult<T>,
) {
    val first = requestInfo
    val second = TestHttpClientResponse(statusCode = statusCode, statusDescription = statusDescription, bodyText = bodyText)
    val third = result

    operator fun component1() = first

    operator fun component2() = second

    operator fun component3() = third
}

fun <T : Any> TestRequest.responseObject(serializer: KSerializer<T>): TestResponseTriple<T> {
    val (statusCode, statusDescription, body) = executeBlocking()
    val result = if (statusCode in 200..299) {
        try {
            TestResult.Success(json.decodeFromString(serializer, body))
        } catch (e: Exception) {
            TestResult.Failure(TestHttpClientError(bodyText = body, statusCode = statusCode, statusDescription = statusDescription, cause = e))
        }
    } else {
        TestResult.Failure(TestHttpClientError(bodyText = body, statusCode = statusCode, statusDescription = statusDescription))
    }
    return TestResponseTriple(requestInfo = toRequestInfo(), statusCode = statusCode, statusDescription = statusDescription, bodyText = body, result = result)
}

fun TestRequest.responseString(): TestResponseTriple<String> {
    val (statusCode, statusDescription, body) = executeBlocking()
    val result =
        if (statusCode in 200..299) {
            TestResult.Success(body)
        } else {
            TestResult.Failure(error = TestHttpClientError(bodyText = body, statusCode = statusCode, statusDescription = statusDescription))
        }
    return TestResponseTriple(requestInfo = toRequestInfo(), statusCode = statusCode, statusDescription = statusDescription, bodyText = body, result = result)
}

fun TestRequest.responseByteArray(): TestResponseTriple<ByteArray> {
    val (statusCode, statusDescription, body) = executeBlockingByteArray()
    val bodyText = body.decodeToString()
    val result =
        if (statusCode in 200..299) {
            TestResult.Success(body)
        } else {
            TestResult.Failure(error = TestHttpClientError(bodyText = bodyText, statusCode = statusCode, statusDescription = statusDescription))
        }
    return TestResponseTriple(
        requestInfo = toRequestInfo(),
        statusCode = statusCode,
        statusDescription = statusDescription,
        bodyText = bodyText,
        result = result,
    )
}

@OptIn(InternalSerializationApi::class)
inline fun <reified T : Any> TestRequest.tilSingelRespons() = responseObject(T::class.serializer())

@OptIn(InternalSerializationApi::class)
inline fun <reified T : Any> TestRequest.tilListeRespons() = responseObject(ListSerializer(T::class.serializer()))
