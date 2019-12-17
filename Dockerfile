FROM node:lts-alpine
RUN npm install -g serve
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build
CMD [ "serve", "dist" ]