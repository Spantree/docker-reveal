FROM node:4.7-alpine

MAINTAINER Cedric Hurst <cedric@spantree.net>

ENV REVEAL_VERSION 3.4.0
ENV NPM_CACHE_DIR /var/cache/npm

WORKDIR /usr/src/slides

RUN apk --no-cache add \
    git \
    ruby \
    su-exec \
    ruby-dev \
    libffi-dev \
 && apk --no-cache add --virtual build-dependencies \
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
 && apk del build-dependencies libffi-dev ruby-dev

ONBUILD ADD package.json /usr/src/slides
ONBUILD RUN npm install
ONBUILD ADD bower.json /usr/src/slides
ONBUILD ADD .bowerrc /usr/src/slides
ONBUILD RUN bower install --allow-root
ONBUILD ADD . /usr/src/slides
ONBUILD RUN grunt build

EXPOSE 9000

CMD ["grunt", "serve"]
