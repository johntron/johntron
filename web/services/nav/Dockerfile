FROM node:latest AS build-env
ADD . /app
WORKDIR /app

#FROM gcr.io/distroless/nodejs
FROM node:latest
COPY --from=build-env /app /app
WORKDIR /app
CMD ["node", "server.js"]
