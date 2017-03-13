#!/bin/sh
rm -f /etc/dhparam/dh2048.pem.new
openssl dhparam -out /etc/dhparam/dh2048.pem.new 2048 && \
[ -f /etc/dhparam/dh2048.pem.new ] && \
rm -f /etc/dhparam/dh2048.pem && \
mv /etc/dhparam/dh2048.pem.new /etc/dhparam/dh2048.pem && \
/etc/init.d/dhparam disable && \
ln -sf /etc/dhparam/dh2048.pem /etc/dhparam/dh-default.pem && \
rm -f /etc/init.d/dhparam
