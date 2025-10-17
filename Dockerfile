# FROM openjdk:8
# MAINTAINER your_name
# ADD your-app.jar app.jar
# EXPOSE 8080
# ENTRYPOINT ["java", "-jar", "/app.jar"]


# https://github.com/gunhe/Vmq.git

# Stage 1: Build the application
# FROM maven:3.8.4-openjdk-8-slim AS build

FROM maven:3.8.5-openjdk-8 AS build


VOLUME .m2/repository
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Stage 2: Create the final runtime image
# FROM openjdk:11-jre-slim
FROM openjdk:8-jdk-alpine
WORKDIR /app
COPY --from=build /app/target/*.jar .
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/app.jar"]

# -v $(HOME)/.m2/repository:/root/.m2/repository
