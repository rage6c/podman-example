FROM registry.access.redhat.com/ubi9/openjdk-17 AS builder

USER 0

WORKDIR /workspace

RUN microdnf install -y gzip tar \
    && microdnf clean all

COPY .mvn/ .mvn/
COPY --chmod=0755 mvnw mvnw
COPY mvnw.cmd mvnw.cmd
COPY pom.xml pom.xml
COPY src/ src/

RUN ./mvnw -DskipTests package

FROM registry.access.redhat.com/ubi9/openjdk-17-runtime

WORKDIR /deployments

COPY --from=builder /workspace/target/spring-service-0.0.1-SNAPSHOT.jar /deployments/app.jar

EXPOSE 8080

ENV SERVER_PORT=8080

ENTRYPOINT ["sh", "-c", "mkdir -p /logs/spring-service && exec java -jar /deployments/app.jar"]
