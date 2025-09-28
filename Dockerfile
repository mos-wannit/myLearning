FROM ghcr.io/graalvm/native-image-community:24-ol9 AS build

WORKDIR /app

COPY . .

RUN ./mvnw native:compile -Pnative

FROM oraclelinux:9-slim AS app
WORKDIR /app

COPY --from=build /app/target/my-learning-project .
EXPOSE 8080
CMD ["./my-learning-project"]