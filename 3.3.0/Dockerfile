FROM node:4.7-alpine

MAINTAINER Cedric Hurst <cedric@spantree.net>

ENV REVEAL_VERSION 3.3.0

WORKDIR /usr/src/slides

RUN apk -U add \
    ruby \
    su-exec \
 && apk -U add --virtual build-dependencies \
    alpine-sdk \
    python \
 && gem install --no-document sass \
 && npm install -g \
    bower \
    generator-reveal \
    grunt-cli \
    node-sass \
    npm-cache \
    yo \
 && curl -L "https://github.com/hakimel/reveal.js/tarball/${REVEAL_VERSION}" | tar xvz  \
 && npm-cache install \
 && apk del build-dependencies \
 && rm -rf /var/cache/apk/*

EXPOSE 9000

COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["grunt", "serve"]
