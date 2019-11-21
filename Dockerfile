FROM node:10
WORKDIR "/app"
COPY ./package.json ./
RUN npm install
COPY . .
RUN npm run test

EXPOSE $SERVER_PORT
CMD ["sh", "-c", "npm run $APP_ENV"]