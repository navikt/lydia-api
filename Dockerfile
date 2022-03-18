FROM eclipse-temurin:17-alpine

COPY build/libs/lydia-api-all.jar app.jar

ENV TZ="Europe/Oslo"

RUN addgroup -S app && adduser -S -G app app

USER app

CMD ["java", "-jar", "app.jar"]