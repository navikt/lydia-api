plugins {
    // Apply the org.jetbrains.kotlin.jvm Plugin to add support for Kotlin.
    kotlin("jvm") version "1.6.10"
    // Skru json-serialisering
    kotlin("plugin.serialization") version "1.6.10"
    // For å bygge
    id("com.github.johnrengelman.shadow") version "7.1.2"

    // Apply the application plugin to add support for building a CLI application in Java.
    application
}

repositories {
    // Use Maven Central for resolving dependencies.
    mavenCentral()
}

dependencies {
    val ktorVersion = "1.6.7"
    val fuelVersion = "2.3.1"
    val testcontainersVersion = "1.16.3"

    // Align versions of all Kotlin components
    implementation(platform("org.jetbrains.kotlin:kotlin-bom"))

    // Use the Kotlin JDK 8 standard library.
    implementation("org.jetbrains.kotlin:kotlin-stdlib-jdk8")

    // This dependency is used by the application.
    implementation("com.google.guava:guava:31.0.1-jre")

    // ktor
    implementation("io.ktor:ktor-server-core:$ktorVersion")
    implementation("io.ktor:ktor-server-netty:$ktorVersion")
    implementation("io.ktor:ktor-serialization:$ktorVersion")
    implementation("io.ktor:ktor-auth:$ktorVersion")
    implementation("io.ktor:ktor-auth-jwt:$ktorVersion")
    implementation("ch.qos.logback:logback-classic:1.2.10")
    implementation("net.logstash.logback:logstash-logback-encoder:7.0.1")

    // metrics
    implementation("io.ktor:ktor-metrics-micrometer:$ktorVersion")
    implementation("io.micrometer:micrometer-registry-prometheus:1.8.2")

    // Database
    implementation("org.postgresql:postgresql:42.3.1")
    implementation("com.zaxxer:HikariCP:5.0.1")
    implementation("org.flywaydb:flyway-core:8.4.3")
    implementation("com.github.seratch:kotliquery:1.6.0")

    // Enklere httpklient
    implementation("com.github.kittinunf.fuel:fuel:$fuelVersion")
    implementation("com.google.code.gson:gson:2.8.9")

    // Kafka
    implementation("org.apache.kafka:kafka-clients:2.8.0")

    // TEST
    testImplementation("io.ktor:ktor-server-test-host:$ktorVersion")
    testImplementation("org.jetbrains.kotlin:kotlin-test")

    // Enklere assertions
    val kotestVerstion = "5.1.0"
    testImplementation("io.kotest:kotest-assertions-core:$kotestVerstion")
    testImplementation("io.kotest:kotest-assertions-json:$kotestVerstion")

    // Testcontainers
    testImplementation("org.testcontainers:testcontainers:$testcontainersVersion")
    testImplementation("org.testcontainers:junit-jupiter:$testcontainersVersion")
    testImplementation("org.testcontainers:postgresql:$testcontainersVersion")
    testImplementation("org.testcontainers:kafka:$testcontainersVersion")


    // Http-mocking
    testImplementation("com.github.kittinunf.fuel:fuel-gson:$fuelVersion")
    testImplementation("com.github.tomakehurst:wiremock-jre8-standalone:2.32.0")


    // Autentisering
    testImplementation("no.nav.security:mock-oauth2-server:0.4.1")

}

testing {
    suites {
        // Configure the built-in test suite
        val test by getting(JvmTestSuite::class) {
            // Use Kotlin Test test framework
            useKotlinTest()
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
