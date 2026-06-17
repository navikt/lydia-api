import org.jetbrains.kotlin.gradle.tasks.KotlinCompile

val ktorVersion = "3.5.0"
val fuelVersion = "2.3.1"
val iaFellesVersion = "2.0.6"
val kotestVerstion = "6.1.11"
val testcontainersVersion = "2.0.5"
val logbackVersion = "1.5.34"
val logstashLogbackEncoderVersion = "9.0"
val opentelemetryLogbackMdcVersion = "2.28.1-alpha"

plugins {
    // Apply the org.jetbrains.kotlin.jvm Plugin to add support for Kotlin.
    kotlin("jvm") version "2.3.21"
    // Skru json-serialisering
    kotlin("plugin.serialization") version "2.3.21"
    // Apply the application plugin to add support for building a CLI application in Java.
    id("application")
}

repositories {
    // Use Maven Central for resolving dependencies.
    mavenCentral()
    maven("https://jitpack.io")
}

dependencies {
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
    // Logger
    implementation("ch.qos.logback:logback-classic:$logbackVersion")
    implementation("net.logstash.logback:logstash-logback-encoder:$logstashLogbackEncoderVersion")
    implementation("io.opentelemetry.instrumentation:opentelemetry-logback-mdc-1.0:$opentelemetryLogbackMdcVersion")

    implementation("io.ktor:ktor-server-call-id:$ktorVersion")
    implementation("io.ktor:ktor-server-call-logging:$ktorVersion")
    implementation("io.ktor:ktor-client-cio:$ktorVersion")
    implementation("io.ktor:ktor-client-content-negotiation:$ktorVersion")
    implementation("io.ktor:ktor-client-encoding:$ktorVersion")

    // metrics
    implementation("io.ktor:ktor-server-metrics-micrometer:$ktorVersion")
    implementation("io.micrometer:micrometer-registry-prometheus:1.16.5")

    // Database
    implementation("org.postgresql:postgresql:42.7.11")
    implementation("com.zaxxer:HikariCP:7.0.2")
    implementation("org.flywaydb:flyway-database-postgresql:12.8.1")
    implementation("com.github.seratch:kotliquery:1.9.1")

    // Enklere httpklient
    implementation("com.github.kittinunf.fuel:fuel:$fuelVersion")
    implementation("com.google.code.gson:gson:2.14.0")

    // Kafka
    implementation("at.yawk.lz4:lz4-java:1.11.0")
    implementation("org.apache.kafka:kafka-clients:4.3.0") {
        // "Fikser CVE-2025-12183 - lz4-java >1.8.1 har sårbar versjon (transitive dependency fra kafka-clients:4.1.0)"
        exclude("org.lz4", "lz4-java")
    }

    // ULID
    implementation("com.github.guepardoapps:kulid:2.0.0.0")

    // Funksjonelle operatorer
    implementation("io.arrow-kt:arrow-core:2.2.3")

    // audit log
    implementation("com.papertrailapp:logback-syslog4j:1.0.0")

    // Felles definisjoner for IA-domenet
    implementation("com.github.navikt:ia-felles:$iaFellesVersion")

    implementation("org.jetbrains.kotlinx:kotlinx-datetime:0.8.0-0.6.x-compat")

    implementation("com.nimbusds:nimbus-jose-jwt:10.9.1")

    // TEST
    testImplementation("org.jetbrains.kotlin:kotlin-test")

    // Enklere assertions
    testImplementation("io.kotest:kotest-assertions-core:$kotestVerstion")
    testImplementation("io.kotest:kotest-assertions-json:$kotestVerstion")

    // Testcontainers
    testImplementation("org.testcontainers:testcontainers:$testcontainersVersion")
    testImplementation("org.testcontainers:testcontainers-junit-jupiter:$testcontainersVersion")
    testImplementation("org.testcontainers:testcontainers-postgresql:$testcontainersVersion")
    testImplementation("org.testcontainers:testcontainers-kafka:$testcontainersVersion")

    // Http-mocking
    testImplementation("com.github.kittinunf.fuel:fuel-kotlinx-serialization:$fuelVersion")
    testImplementation("org.wiremock:wiremock-standalone:3.13.2")

    // Autentisering
    testImplementation("no.nav.security:mock-oauth2-server:4.0.0")

    constraints {
        implementation("com.fasterxml.jackson.core:jackson-core") {
            version { require("2.21.3") }
            because("versjoner < 2.21.1 har sårbarhet. inkludert i ktor-server-auth:3.4.0")
        }
        implementation("tools.jackson.core:jackson-core") {
            version { require("3.1.3") }
            because("versjoner <= 3.1.0 har sårbarhet. inkludert i logstash-logback-encoder:9.0")
        }
        implementation("io.netty:netty-codec-http2") {
            version {
                require("4.2.13.Final")
            }
            because(
                "ktor-server-netty har sårbar versjon",
            )
        }
        implementation("joda-time:joda-time") {
            version {
                require("2.14.2")
            }
            because("kotliquery har sårbar versjon på v2.11.0")
        }
        testImplementation("org.apache.commons:commons-compress") {
            version {
                require("1.28.0")
            }
            because("testcontainers har sårbar versjon")
        }
        testImplementation("org.bouncycastle:bcprov-jdk18on") {
            version {
                require("1.84")
            }
            because(
                "versjoner < 1.84 har sårbarhet. inkludert i no.nav.security:mock-oauth2-server:3.0.3",
            )
        }
        testImplementation("org.bouncycastle:bcpkix-jdk18on") {
            version {
                require("1.84")
            }
            because(
                "versjoner < 1.84 har sårbarhet. inkludert i no.nav.security:mock-oauth2-server:3.0.3",
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
    withType<Test> {
        dependsOn(installDist)
        useJUnit {
            if (!project.hasProperty("lokalDbDump")) {
                excludeCategories("no.nav.lydia.CommandLineOnlyTest")
            }
        }
    }
}

kotlin {
    jvmToolchain(21)
}
val compileKotlin: KotlinCompile by tasks
compileKotlin.compilerOptions {
    freeCompilerArgs.set(listOf("-Xcontext-parameters"))
}
