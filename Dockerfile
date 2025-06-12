FROM eclipse-temurin:17-jdk-jammy

# Create non-root user and group
RUN groupadd -r appgroup && useradd -r -g appgroup appuser

# Set working directory
WORKDIR /app

# Copy the JAR
COPY target/spring-petclinic-3.5.0-SNAPSHOT.jar app.jar

# Change file ownership
RUN chown -R appuser:appgroup /app

# Switch to non-root user
USER appuser

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]
