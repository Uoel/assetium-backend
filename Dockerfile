# ---------- Build stage ----------
FROM eclipse-temurin:21-jdk AS builder

WORKDIR /app

# Copy project files
COPY . .

# Ensure mvnw is executable
RUN chmod +x mvnw

# Build the JAR
RUN ./mvnw clean package -DskipTests

# ---------- Runtime stage ----------
FROM eclipse-temurin:21-jre

WORKDIR /app

# Copy only the built JAR from the builder stage
COPY --from=builder /app/target/*.jar app.jar

# Expose Render port
EXPOSE 8080

# Run the application
CMD ["java", "-jar", "app.jar"]
