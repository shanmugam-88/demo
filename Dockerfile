FROM maven:3.6.3-openjdk-11-slim AS build

ADD pom.xml /
RUN mvn dependency:resolve
RUN mvn dependency:resolve-plugins

ADD . /
RUN mvn clean install -DskipTests

FROM openjdk:11.0.12-slim
COPY --from=build /target/demo*.jar main.jar
ENTRYPOINT ["java","-jar","main.jar"]
EXPOSE 8080