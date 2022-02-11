FROM navikt/java:17 as base
COPY build/libs/lydia-api-all.jar app.jar
FROM base as local
ENV JAVA_OPTS="${JAVA_OPTS} -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=*:5005"