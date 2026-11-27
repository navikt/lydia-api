package no.nav.lydia.ki.gcp

import com.google.auth.oauth2.GoogleCredentials
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext

fun interface GoogleTokenProvider {
    suspend fun hentToken(): String
}

class AdcTokenProvider : GoogleTokenProvider {
    companion object {
        private const val CLOUD_PLATFORM_SCOPE = "https://www.googleapis.com/auth/cloud-platform"
    }

    private val credentials =
        GoogleCredentials.getApplicationDefault().createScoped(CLOUD_PLATFORM_SCOPE)

    override suspend fun hentToken(): String =
        withContext(Dispatchers.IO) {
            credentials.refreshIfExpired()
            checkNotNull(credentials.accessToken?.tokenValue) { "Mangler access token fra Google" }
        }
}
