FROM node:latest
ENV PORT 8080
EXPOSE 8080

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
COPY package.json .
COPY . .
RUN npm ci

CMD npm start
