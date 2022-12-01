FROM node:16
WORKDIR /home/root
COPY . .
RUN npm install
EXPOSE 3000
CMD [ "yarn", "start" ]
