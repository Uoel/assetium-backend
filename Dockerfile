# Use Java 21 base image
FROM eclipse-temurin:21-jdk

# Set working directory inside container
WORKDIR /app

# Copy everything
COPY . .

# Make mvnw executable
RUN chmod +x mvnw

# Build the app (skip tests for faster deploys)
RUN ./mvnw clean package -DskipTests

# Expose the port Render will bind to
EXPOSE 8080

# Run the jar
CMD ["java", "-jar", "target/*.jar"]
