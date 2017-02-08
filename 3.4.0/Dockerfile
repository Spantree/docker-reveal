FROM node:4.7-alpine

MAINTAINER Cedric Hurst <cedric@spantree.net>

ENV REVEAL_VERSION 3.4.0
ENV NPM_CACHE_DIR /var/cache/npm

WORKDIR /usr/src/slides

RUN apk -U add \
    git \
    python \
    ruby \
    su-exec \
 && apk -U add --virtual build-dependencies \
    alpine-sdk \
 && gem install --no-document sass \
 && npm install -g \
    bower \
    generator-reveal \
    grunt-cli \
    node-sass \
    npm-cache \
    yo \
 && curl -L "https://github.com/hakimel/reveal.js/tarball/${REVEAL_VERSION}" | tar xvz \
 && mkdir -p $NPM_CACHE_DIR \
 && chown -R node $NPM_CACHE_DIR \
 && npm-cache install \
 && apk del build-dependencies \
 && rm -rf /var/cache/apk/*

EXPOSE 9000

COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["grunt", "serve"]
