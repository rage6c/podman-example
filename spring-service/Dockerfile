FROM registry.access.redhat.com/ubi9/openjdk-17 AS builder

WORKDIR /workspace

COPY .mvn/ .mvn/
COPY mvnw mvnw
COPY mvnw.cmd mvnw.cmd
COPY pom.xml pom.xml
COPY src/ src/

RUN chmod +x mvnw && ./mvnw -DskipTests package

FROM registry.access.redhat.com/ubi9/openjdk-17-runtime

WORKDIR /deployments

COPY --from=builder /workspace/target/spring-service-0.0.1-SNAPSHOT.jar /deployments/app.jar

EXPOSE 8080

ENV SERVER_PORT=8080

ENTRYPOINT ["java", "-jar", "/deployments/app.jar"]
