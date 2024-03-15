plugins {
    // Apply the org.jetbrains.kotlin.jvm Plugin to add support for Kotlin.
    kotlin("jvm") version "1.9.22"
    // Skru json-serialisering
    kotlin("plugin.serialization") version "1.9.22"
    // For å bygge fatjar
    id("com.github.johnrengelman.shadow") version "8.1.1"
    // Apply the application plugin to add support for building a CLI application in Java.
    application
}

repositories {
    // Use Maven Central for resolving dependencies.
    mavenCentral()
    maven("https://jitpack.io")
}

dependencies {
    val ktorVersion = "2.3.8"
    val fuelVersion = "2.3.1"

    implementation(kotlin("stdlib"))

    // Align versions of all Kotlin components
    implementation(platform("org.jetbrains.kotlin:kotlin-bom"))

    // ktor
    implementation("io.ktor:ktor-server-core:$ktorVersion")
    implementation("io.ktor:ktor-server-netty:$ktorVersion")
    implementation("io.ktor:ktor-serialization:$ktorVersion")
    implementation("io.ktor:ktor-server-auth:$ktorVersion")
    implementation("io.ktor:ktor-server-auth-jwt:$ktorVersion")
    implementation("io.ktor:ktor-server-content-negotiation:$ktorVersion")
    implementation("io.ktor:ktor-serialization-kotlinx-json:$ktorVersion")
    implementation("io.ktor:ktor-server-status-pages:$ktorVersion")
    implementation("ch.qos.logback:logback-classic:1.4.14")
    implementation("net.logstash.logback:logstash-logback-encoder:7.4")
    implementation("io.ktor:ktor-server-call-id:$ktorVersion")
    implementation("io.ktor:ktor-server-call-logging:$ktorVersion")
    implementation("io.ktor:ktor-client-cio:$ktorVersion")
    implementation("io.ktor:ktor-client-content-negotiation:$ktorVersion")
    implementation("io.ktor:ktor-client-encoding:$ktorVersion")


    // metrics
    implementation("io.ktor:ktor-server-metrics-micrometer:$ktorVersion")
    implementation("io.micrometer:micrometer-registry-prometheus:1.12.2")

    // Database
    implementation("org.postgresql:postgresql:42.7.1")
    implementation("com.zaxxer:HikariCP:5.1.0")
    implementation("org.flywaydb:flyway-database-postgresql:10.7.1")
    implementation("com.github.seratch:kotliquery:1.9.0")

    // Enklere httpklient
    implementation("com.github.kittinunf.fuel:fuel:$fuelVersion")
    implementation("com.google.code.gson:gson:2.10.1")

    // Kafka
    implementation("org.apache.kafka:kafka-clients:3.6.1")

    // ULID
    implementation("com.github.guepardoapps:kulid:2.0.0.0")

    // Funksjonelle operatorer
    implementation("io.arrow-kt:arrow-core:1.2.1")

    // audit log
    implementation("com.papertrailapp:logback-syslog4j:1.0.0")

    // Felles definisjoner for IA-domenet
    implementation("com.github.navikt:ia-felles:0.0.6")

    implementation("org.jetbrains.kotlinx:kotlinx-datetime:0.5.0")

    implementation("com.nimbusds:nimbus-jose-jwt:9.37.3")

    // TEST
    testImplementation("org.jetbrains.kotlin:kotlin-test")

    // Enklere assertions
    val kotestVerstion = "5.8.0"
    testImplementation("io.kotest:kotest-assertions-core:$kotestVerstion")
    testImplementation("io.kotest:kotest-assertions-json:$kotestVerstion")

    // Testcontainers
    val testcontainersVersion = "1.19.7"
    testImplementation("org.testcontainers:testcontainers:$testcontainersVersion")
    constraints { implementation("org.apache.commons:commons-compress"){
        version{
            require("1.26.1")
        }
        because("In testcontainers(1.19.5) commons-compress was downgraded to v1.24.0, but v1.20-1.25 are vulnerable to a Denial of Service (DoS) attack via a crafted ZIP file, which is due to an infinite loop in the ZipArchiveInputStream class.")
    } }
    testImplementation("org.testcontainers:junit-jupiter:$testcontainersVersion")
    testImplementation("org.testcontainers:postgresql:$testcontainersVersion")
    testImplementation("org.testcontainers:kafka:$testcontainersVersion")

    // Http-mocking
    testImplementation("com.github.kittinunf.fuel:fuel-kotlinx-serialization:$fuelVersion")
    testImplementation("org.wiremock:wiremock-standalone:3.3.1")


    // Autentisering
    testImplementation("no.nav.security:mock-oauth2-server:2.1.1")

    constraints {
        implementation("net.minidev:json-smart") {
            version {
                require("2.5.0")
            }
            because("From Kotlin version: 1.7.20 -> Earlier versions of json-smart package are vulnerable to Denial of Service (DoS) due to a StackOverflowError when parsing a deeply nested JSON array or object.")
        }
        implementation("io.netty:netty-codec-http2") {
            version {
                require("4.1.106.Final")
            }
            because("Affected versions < 4.1.101.Final are vulnerable to HTTP/2 Rapid Reset Attack")
        }
        testImplementation("com.jayway.jsonpath:json-path") {
            version {
                require("2.9.0")
            }
            because(
                """
                json-path v2.8.0 was discovered to contain a stack overflow via the Criteria.parse() method.
                introdusert gjennom io.kotest:kotest-assertions-json:5.8.0
                """.trimIndent()
            )
        }
    }
}

application {
    // Define the main class for the application.
    mainClass.set("no.nav.lydia.AppKt")
}

val lokalDbDump: String by project
tasks {
    shadowJar {
        mergeServiceFiles()
        manifest {
            attributes(Pair("Main-Class", "no.nav.lydia.AppKt"))
        }
    }

    withType<Test>{
        dependsOn(shadowJar)
        useJUnit {
            if (!project.hasProperty("lokalDbDump")) {
                excludeCategories("no.nav.lydia.CommandLineOnlyTest")
            }
        }
    }
}

kotlin {
    jvmToolchain(17)
}
