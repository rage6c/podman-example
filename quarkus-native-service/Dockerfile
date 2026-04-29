FROM quay.io/quarkus/ubi9-quarkus-mandrel-builder-image:jdk-21 AS builder

USER root
WORKDIR /code

COPY --chown=quarkus:quarkus .mvn/ .mvn/
COPY --chown=quarkus:quarkus mvnw mvnw
COPY --chown=quarkus:quarkus pom.xml pom.xml
COPY --chown=quarkus:quarkus src/ src/

USER quarkus

RUN ./mvnw package -Dnative -DskipTests

FROM quay.io/quarkus/ubi9-quarkus-micro-image:2.0

WORKDIR /work/

COPY --from=builder --chown=1001:root /code/target/*-runner /work/application

EXPOSE 8080
USER 1001

ENTRYPOINT ["./application", "-Dquarkus.http.host=0.0.0.0"]
