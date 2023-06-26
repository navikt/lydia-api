plugins {
    // Apply the org.jetbrains.kotlin.jvm Plugin to add support for Kotlin.
    kotlin("jvm") version "1.8.21"
    // Skru json-serialisering
    kotlin("plugin.serialization") version "1.8.21"
    // For å bygge
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
    val ktorVersion = "2.3.1"
    val fuelVersion = "2.3.1"

    // Align versions of all Kotlin components
    implementation(platform("org.jetbrains.kotlin:kotlin-bom"))

    // Use the Kotlin JDK 8 standard library.
    implementation("org.jetbrains.kotlin:kotlin-stdlib-jdk8")

    // ktor
    implementation("io.ktor:ktor-server-core:$ktorVersion")
    implementation("io.ktor:ktor-server-netty:$ktorVersion")
    implementation("io.ktor:ktor-serialization:$ktorVersion")
    implementation("io.ktor:ktor-server-auth:$ktorVersion")
    implementation("io.ktor:ktor-server-auth-jwt:$ktorVersion")
    implementation("io.ktor:ktor-server-content-negotiation:$ktorVersion")
    implementation("io.ktor:ktor-serialization-kotlinx-json:$ktorVersion")
    implementation("io.ktor:ktor-server-status-pages:$ktorVersion")
    implementation("ch.qos.logback:logback-classic:1.4.7")
    implementation("net.logstash.logback:logstash-logback-encoder:7.3")
    implementation("io.ktor:ktor-server-call-id:$ktorVersion")
    implementation("io.ktor:ktor-server-call-logging:$ktorVersion")

    // metrics
    implementation("io.ktor:ktor-server-metrics-micrometer:$ktorVersion")
    implementation("io.micrometer:micrometer-registry-prometheus:1.11.0")

    // Database
    implementation("org.postgresql:postgresql:42.6.0")
    implementation("com.zaxxer:HikariCP:5.0.1")
    implementation("org.flywaydb:flyway-core:9.19.1")
    implementation("com.github.seratch:kotliquery:1.9.0")

    // Enklere httpklient
    implementation("com.github.kittinunf.fuel:fuel:$fuelVersion")
    implementation("com.google.code.gson:gson:2.10.1")

    // Kafka
    implementation("org.apache.kafka:kafka-clients:3.4.1")

    // ULID
    implementation("com.github.guepardoapps:kulid:2.0.0.0")

    // Funksjonelle operatorer
    implementation("io.arrow-kt:arrow-core:1.1.5")

    // audit log
    implementation("com.papertrailapp:logback-syslog4j:1.0.0")

    // featuretoggling med unleash
    implementation("io.getunleash:unleash-client-java:8.0.0")

    // Felles definisjoner for IA-domenet
    implementation("com.github.navikt:ia-felles:0.0.5")

    implementation("org.jetbrains.kotlinx:kotlinx-datetime:0.4.0")

    // TEST
    testImplementation("org.jetbrains.kotlin:kotlin-test")

    // Enklere assertions
    val kotestVerstion = "5.6.2"
    testImplementation("io.kotest:kotest-assertions-core:$kotestVerstion")
    testImplementation("io.kotest:kotest-assertions-json:$kotestVerstion")

    // Testcontainers
    val testcontainersVersion = "1.17.6"
    testImplementation("org.testcontainers:testcontainers:$testcontainersVersion")
    testImplementation("org.testcontainers:junit-jupiter:$testcontainersVersion")
    testImplementation("org.testcontainers:postgresql:$testcontainersVersion")
    testImplementation("org.testcontainers:kafka:$testcontainersVersion")

    // Http-mocking
    testImplementation("com.github.kittinunf.fuel:fuel-kotlinx-serialization:$fuelVersion")
    testImplementation("com.github.tomakehurst:wiremock-jre8-standalone:2.35.0")


    // Autentisering
    testImplementation("no.nav.security:mock-oauth2-server:0.5.8")
    implementation("com.nimbusds:nimbus-jose-jwt:9.31")

    constraints {
        implementation("net.minidev:json-smart:2.4.11") {
            because("From Kotlin version: 1.7.20 -> Earlier versions of json-smart package are vulnerable to Denial of Service (DoS) due to a StackOverflowError when parsing a deeply nested JSON array or object.")
        }
    }
}

application {
    // Define the main class for the application.
    mainClass.set("no.nav.lydia.AppKt")
}

tasks{
    shadowJar {
        manifest {
            attributes(Pair("Main-Class", "no.nav.lydia.AppKt"))
        }
    }

    withType<Test>{
        dependsOn(shadowJar)
    }
}
