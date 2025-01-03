FROM node:20-alpine AS builder

WORKDIR /app
COPY package.json ./

RUN npm install @redocly/cli -g

COPY . .

RUN npx redocly build-docs openapi.yaml -o /dist/index.html

FROM nginx:alpine

COPY --from=builder /dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]