#!/bin/sh
# Remember to change this info or use letsencrypt.org
openssl req \
        -subj '/C=US/ST=Oregon/L=Portland/CN=www.helloworld.org' \
        -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/nginx.key \
        -out /etc/nginx/ssl/nginx.crt;
cp /config/nginx.conf /etc/nginx/sites-available/default;
/etc/init.d/nginx reload;
cd onionperf;
# onionperf measure --tor=/tor/src/or/tor \
# --tgen=/shadow/src/plugin/shadow-plugin-tgen/build/tgen --twistd=/usr/local/bin/twistd;
twistd --version
/usr/local/bin/twistd -n -l - web  --path /onionperf/onionperf-data/twistd/docroot --port 8090 --mime-type=None
