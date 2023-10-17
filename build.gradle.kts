plugins {
    // Apply the org.jetbrains.kotlin.jvm Plugin to add support for Kotlin.
    kotlin("jvm") version "1.9.10"
    // Skru json-serialisering
    kotlin("plugin.serialization") version "1.9.10"
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
    val ktorVersion = "2.3.5"
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
    implementation("ch.qos.logback:logback-classic:1.4.11")
    implementation("net.logstash.logback:logstash-logback-encoder:7.4")
    implementation("io.ktor:ktor-server-call-id:$ktorVersion")
    implementation("io.ktor:ktor-server-call-logging:$ktorVersion")

    // metrics
    implementation("io.ktor:ktor-server-metrics-micrometer:$ktorVersion")
    implementation("io.micrometer:micrometer-registry-prometheus:1.11.5")

    // Database
    implementation("org.postgresql:postgresql:42.6.0")
    implementation("com.zaxxer:HikariCP:5.0.1")
    implementation("org.flywaydb:flyway-core:9.22.2")
    implementation("com.github.seratch:kotliquery:1.9.0")

    // Enklere httpklient
    implementation("com.github.kittinunf.fuel:fuel:$fuelVersion")
    implementation("com.google.code.gson:gson:2.10.1")

    // Kafka
    implementation("org.apache.kafka:kafka-clients:3.6.0")

    // ULID
    implementation("com.github.guepardoapps:kulid:2.0.0.0")

    // Funksjonelle operatorer
    implementation("io.arrow-kt:arrow-core:1.2.1")

    // audit log
    implementation("com.papertrailapp:logback-syslog4j:1.0.0")

    // Felles definisjoner for IA-domenet
    implementation("com.github.navikt:ia-felles:0.0.6")

    implementation("org.jetbrains.kotlinx:kotlinx-datetime:0.4.1")

    // TEST
    testImplementation("org.jetbrains.kotlin:kotlin-test")

    // Enklere assertions
    val kotestVerstion = "5.7.2"
    testImplementation("io.kotest:kotest-assertions-core:$kotestVerstion")
    testImplementation("io.kotest:kotest-assertions-json:$kotestVerstion")

    // Testcontainers
    val testcontainersVersion = "1.19.1"
    testImplementation("org.testcontainers:testcontainers:$testcontainersVersion")
    testImplementation("org.testcontainers:junit-jupiter:$testcontainersVersion")
    testImplementation("org.testcontainers:postgresql:$testcontainersVersion")
    testImplementation("org.testcontainers:kafka:$testcontainersVersion")

    // Http-mocking
    testImplementation("com.github.kittinunf.fuel:fuel-kotlinx-serialization:$fuelVersion")
    testImplementation("com.github.tomakehurst:wiremock-standalone:3.0.1")


    // Autentisering
    testImplementation("no.nav.security:mock-oauth2-server:2.0.0")
    implementation("com.nimbusds:nimbus-jose-jwt:9.36")

    constraints {
        implementation("net.minidev:json-smart") {
            version {
                require("2.5.0")
            }
            because("From Kotlin version: 1.7.20 -> Earlier versions of json-smart package are vulnerable to Denial of Service (DoS) due to a StackOverflowError when parsing a deeply nested JSON array or object.")
        }
    }
}

application {
    // Define the main class for the application.
    mainClass.set("no.nav.lydia.AppKt")
}

tasks {
    shadowJar {
        manifest {
            attributes(Pair("Main-Class", "no.nav.lydia.AppKt"))
        }
    }

    withType<Test>{
        dependsOn(shadowJar)
    }
}

kotlin {
    jvmToolchain(17)
}
