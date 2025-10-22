val ktorVersion = "3.3.0"
val fuelVersion = "2.3.1"
val iaFellesVersion = "2.0.4"
val kotestVerstion = "6.0.3"
val testcontainersVersion = "1.21.3"
val logbackVersion = "1.5.18"
val logstashLogbackEncoderVersion = "8.1"
val opentelemetryLogbackMdcVersion = "2.16.0-alpha"

plugins {
    // Apply the org.jetbrains.kotlin.jvm Plugin to add support for Kotlin.
    kotlin("jvm") version "2.2.20"
    // Skru json-serialisering
    kotlin("plugin.serialization") version "2.2.20"
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
    implementation("io.micrometer:micrometer-registry-prometheus:1.15.4")

    // Database
    implementation("org.postgresql:postgresql:42.7.7")
    implementation("com.zaxxer:HikariCP:7.0.2")
    implementation("org.flywaydb:flyway-database-postgresql:11.13.0")
    implementation("com.github.seratch:kotliquery:1.9.1")

    // Enklere httpklient
    implementation("com.github.kittinunf.fuel:fuel:$fuelVersion")
    implementation("com.google.code.gson:gson:2.13.2")

    // Kafka
    implementation("org.apache.kafka:kafka-clients:4.1.0")

    // ULID
    implementation("com.github.guepardoapps:kulid:2.0.0.0")

    // Funksjonelle operatorer
    implementation("io.arrow-kt:arrow-core:2.1.2")

    // audit log
    implementation("com.papertrailapp:logback-syslog4j:1.0.0")

    // Felles definisjoner for IA-domenet
    implementation("com.github.navikt:ia-felles:$iaFellesVersion")

    implementation("org.jetbrains.kotlinx:kotlinx-datetime:0.6.2")

    implementation("com.nimbusds:nimbus-jose-jwt:10.5")

    // TEST
    testImplementation("org.jetbrains.kotlin:kotlin-test")

    // Enklere assertions
    testImplementation("io.kotest:kotest-assertions-core:$kotestVerstion")
    testImplementation("io.kotest:kotest-assertions-json:$kotestVerstion")

    // Testcontainers
    testImplementation("org.testcontainers:testcontainers:$testcontainersVersion")
    testImplementation("org.testcontainers:junit-jupiter:$testcontainersVersion")
    testImplementation("org.testcontainers:postgresql:$testcontainersVersion")
    testImplementation("org.testcontainers:kafka:$testcontainersVersion")

    // Http-mocking
    testImplementation("com.github.kittinunf.fuel:fuel-kotlinx-serialization:$fuelVersion")
    testImplementation("org.wiremock:wiremock-standalone:3.13.1")

    // -- validere pdfa
    testImplementation("org.verapdf:validation-model:1.28.2")

    // Autentisering
    testImplementation("no.nav.security:mock-oauth2-server:2.3.0")

    constraints {
        implementation("io.netty:netty-codec-http2") {
            version {
                require("4.2.6.Final")
            }
            because(
                "ktor-server-netty har sårbar versjon",
            )
        }
        implementation("joda-time:joda-time") {
            version {
                require("2.14.0")
            }
            because("kotliquery har sårbar versjon på v2.11.0")
        }
        testImplementation("org.apache.commons:commons-compress") {
            version {
                require("1.28.0")
            }
            because("testcontainers har sårbar versjon")
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

    withType<Test> {
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
