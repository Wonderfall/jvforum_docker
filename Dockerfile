FROM wonderfall/node:6.2

ENV UID=991 \
    GID=991 \
    COOKIES_SECRET=secret \
    DB_HOST=localhost \
    DB_USER=root \
    DB_PASSWORD=password \
    DATABASE=jvforum  \
    GOOGLE_ANALYTICS_ID='' \
    CLOUDFLARE=false \
    MAX_SIMULTANEOUS_REQUESTS=30

WORKDIR /jvforum

RUN echo "@commuedge https://nl.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories \
 && apk -U add git su-exec tzdata tini@commuedge \
 && cp /usr/share/zoneinfo/Europe/Brussels /etc/localtime \
 && echo "Europe/Brussels" > /etc/timezone \
 && git clone https://github.com/dieulot/jvforum.git . \
 && npm install \
 && cp config/example.js config/development.js \
 && apk del git tzdata \
 && rm -f /var/cache/apk/*

COPY run.sh /usr/local/bin/run.sh

RUN chmod +x /usr/local/bin/run.sh

EXPOSE 3000

CMD ["/sbin/tini","--","run.sh"]
