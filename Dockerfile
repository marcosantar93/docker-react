FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# just with a new from we know the previous stage has finished

FROM nginx
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html

# the default nginx startup command would start nginx for us
# so we don't need some CMD [...]