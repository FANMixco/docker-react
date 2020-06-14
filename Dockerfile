#get linux copy
FROM node:alpine as builder

WORKDIR '/app'

#copy json file first
COPY package.json .

#install dependencies
RUN npm install

#copy all repos (source code)
COPY . .

RUN npm run build

#app/build <--- final folder

#start new phase -- run
FROM nginx

#copy from a different stage
COPY --from=builder /app/build /usr/share/nginx/html
