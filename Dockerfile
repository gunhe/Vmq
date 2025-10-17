# FROM openjdk:8
# MAINTAINER your_name
# ADD your-app.jar app.jar
# EXPOSE 8080
# ENTRYPOINT ["java", "-jar", "/app.jar"]


# https://github.com/gunhe/Vmq.git

# Stage 1: Build the application
# FROM maven:3.8.4-openjdk-8-slim AS build

FROM maven:3.8.5-openjdk-8 AS build

# VOLUME .m2/repository
WORKDIR /app
COPY . .
COPY ./settings.xml /usr/share/maven/ref/settings.xml
RUN mvn clean package -DskipTests

# Stage 2: Create the final runtime image
# FROM openjdk:11-jre-slim
FROM openjdk:8-jdk-alpine
WORKDIR /app
COPY --from=build /app/target/mq-0.0.1-SNAPSHOT.war /app/app.war
EXPOSE 8005
ENTRYPOINT ["java", "-jar", "/app/app.jar"]

# -v $(HOME)/.m2/repository:/root/.m2/repository
