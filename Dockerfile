FROM node:latest
WORKDIR /app
COPY . .
RUN npm install
RUN npm install sonarqube-scanner --save-dev
RUN npx sonarqube-scanner
EXPOSE 8000
CMD ["node","app.js"]
