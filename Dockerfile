FROM google/debian:wheezy

RUN apt-get update -y && apt-get install --no-install-recommends -y -q curl
RUN mkdir /nodejs && curl http://nodejs.org/dist/v0.12.2/node-v0.12.2-linux-x64.tar.gz | tar xvzf - -C /nodejs --strip-components=1

ENV PATH $PATH:/nodejs/bin
ENV NODE_ENV production

WORKDIR /app
COPY webpack.config.js package.json index.js /app/
RUN npm install 

COPY dist/ /app/dist/
COPY src/ /app/src/
RUN npm install webpack coffee-jsx-loader coffee-loader &&\
    npm run build &&\
    npm remove webpack coffee-jsx-loader coffee-loader

ENV PORT 8080
EXPOSE 8080

CMD ["/nodejs/bin/npm", "start"]
