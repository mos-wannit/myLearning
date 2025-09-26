# Stage 1: The Build Stage
# Use a GraalVM native-image image with the necessary build tools.
FROM ghcr.io/graalvm/native-image-community:24-ol9 AS build

# Set the working directory
WORKDIR /app

# Copy your application source code
COPY . .

# Build the native executable
RUN ./mvnw native:compile -Pnative

# Stage 2: The Runtime Stage
# Use a minimal base image to run the final executable.
# scratch is a great choice for the smallest possible image.
FROM oraclelinux:9-slim AS app
# Set working directory in final image
WORKDIR /app

# Copy the native executable from the build stage.
# The executable is located in the `target` directory.
COPY --from=build /app/target/my-learning-project .
#COPY --from=build /app/target/my-learning-project /my-learning-project

EXPOSE 8080
# Run the executable when the container starts
#CMD ["ls"]
CMD ["./my-learning-project"]
#RUN ["sh","-c","./my-learning-project"]m