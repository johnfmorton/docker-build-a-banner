ARG TAG=16-alpine
FROM node:$TAG

EXPOSE 8080/tcp 8889/tcp

WORKDIR /app

# Install dependencies
RUN set -eux; \
    npm install -g yo \
    && \
    npm install gulp-cli -g \
    && \
    npm install -g generator-buildabanner \
    && \
    # Fix permissions, ref: https://github.com/keystonejs/keystone-classic/issues/1566
    mkdir -p /root/.config/configstore \
    && \
    mkdir -p /root/.config/insight-nodejs \
    && \
    chmod -R g+rwx /root /root/.config \
    && \
    mkdir -p /usr/lib/node_modules/ \
    && \
    chmod -R g+rwx /usr/lib/node_modules/


CMD ["/bin/sh"]

# CMD ["/usr/local/bin/yo"]
