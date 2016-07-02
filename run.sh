#!/bin/sh
sed -i -e "s/cookiesSecret: 'secret'/cookiesSecret: '$COOKIES_SECRET'/g" \
       -e "s/host: 'localhost'/host: '$DB_HOST'/g" \
       -e "s/user: 'root'/user: '$DB_USER'/g" \
       -e "s/password: ''/password: '$DB_PASSWORD'/g" \
       -e "s/database: 'jvforum'/database: '$DATABASE'/g" \
       -e "s/googleAnalyticsId: ''/googleAnalyticsId: '$GOOGLE_ANALYTICS_ID'/g" \
       -e "s/useCloudFlare: false/useCloudFlare: $CLOUDFLARE/g" \
       -e "s/maxSimultaneousRequests: 30/maxSimultaneousRequests: $MAX_SIMULTANEOUS_REQUESTS/g" \
       config/development.js

chown -R $UID:$GID .
su-exec $UID:$GID npm start
