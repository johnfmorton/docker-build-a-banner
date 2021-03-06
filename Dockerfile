ARG TAG=16-alpine
FROM node:$TAG

## Expose 8080 for the web server and 35729 for the LiveReload service
EXPOSE 8080/tcp 35729/tcp

WORKDIR /app

# Add alians for a better .zsh shell
ADD files-to-include/.zshrc /root/.zshrc
ADD files-to-include/insight-yo.json /root/.config/insight-nodejs/insight-yo.json

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
    chmod -R g+rwx /usr/lib/node_modules/ \
    && \
    # Add .zsh shell
    apk add --no-cache zsh \
    # Clean out directories that don't need to be part of the image
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# It might seem strange to have a Dockerfile with a CMD that runs a shell,
# but running yo by itself would exit the container after the banner is set up
# CMD ["/usr/local/bin/yo", "buildabanner"]
# Building a banner is a multiple step process, so you will want to rung
# gulp and gulp build in the process of creating your banner. This
# is why the default CMD is ["/bin/zsh"], which I prefer over ["/bin/sh"]

CMD ["/bin/zsh"]
