FROM gradle:8.13.2-jdk17 AS build

WORKDIR /app

# Copia os arquivos necessários para build
COPY build.gradle .
COPY settings.gradle .
COPY src ./src
COPY gradle ./gradle

# Compila o projeto e gera o JAR
RUN gradle build --no-daemon


FROM eclipse-temurin:17-jdk-alpine

WORKDIR /app

# Copia o JAR da etapa de build
COPY --from=build /app/build/libs/*.jar app.jar

# Expõe a porta usada pelo Spring Boot
EXPOSE 8080

# Comando para rodar a aplicação
ENTRYPOINT ["java", "-jar", "app.jar"]
