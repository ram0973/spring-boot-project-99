#FROM eclipse-temurin:21-jdk
FROM bellsoft/liberica-openjdk-debian:23.0.1
#FROM openjdk:21-jdk
#ARG JAR_FILE=app-0.0.1-SNAPSHOT.jar
#COPY ${JAR_FILE} app.jar
#ENTRYPOINT ["java","-jar","/app.jar"]


RUN apt-get update && apt-get install -yq make unzip

WORKDIR /backend

COPY gradle gradle
COPY build.gradle.kts .
COPY settings.gradle.kts .
COPY gradlew .

#RUN ./gradlew --no-daemon dependencies

#COPY lombok.config .
COPY src src

#COPY --from=frontend /frontend/dist /backend/src/main/resources/static

RUN ./gradlew --no-daemon build

ENV JAVA_OPTS "-Xmx512M -Xms512M"
EXPOSE 8080

CMD java -jar build/libs/app-0.0.1-SNAPSHOT.jar