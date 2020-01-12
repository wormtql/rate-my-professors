FROM node:lts-alpine
RUN npm install -g serve
WORKDIR /app
COPY ./dist ./dist
CMD [ "serve", "dist" ]