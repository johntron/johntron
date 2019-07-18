FROM node:latest

EXPOSE 80
RUN mkdir -p /app
WORKDIR /app
COPY package.json .
RUN npm install
COPY src/ src/
ENTRYPOINT ["npm", "start"]