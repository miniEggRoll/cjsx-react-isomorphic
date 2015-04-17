FROM google/debian:wheezy

RUN apt-get update -y && apt-get install --no-install-recommends -y -q curl python build-essential git ca-certificates
RUN mkdir /nodejs && curl http://nodejs.org/dist/v0.11.16/node-v0.11.16-linux-x64.tar.gz | tar xvzf - -C /nodejs --strip-components=1

ENV PATH $PATH:/nodejs/bin

WORKDIR /app
COPY dist/ /app/dist/
COPY src/ /app/src/
COPY webpack.config.js package.json index.js /app/
RUN npm install && npm run build

ENV PORT 8080
EXPOSE 8080

CMD ["/nodejs/bin/npm", "start"]
