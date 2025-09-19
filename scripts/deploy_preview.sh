#!/bin/bash
PR_NUM=$1
PORT=$2
docker pull ghcr.io/<user>/<repo>/web:pr-$PR_NUM
docker stop pr-$PR_NUM || true
docker rm pr-$PR_NUM || true
docker run -d --name pr-$PR_NUM -p $PORT:80 ghcr.io/<user>/<repo>/web:pr-$PR_NUM
# générer config NGINX pour ce PR
cp nginx/pr-template.conf /etc/nginx/sites-enabled/pr-$PR_NUM.conf
sed -i "s/PR_HOSTNAME/pr-$PR_NUM.farah.duckdns.org/g" /etc/nginx/sites-enabled/pr-$PR_NUM.conf
sed -i "s/PR_PORT/$PORT/g" /etc/nginx/sites-enabled/pr-$PR_NUM.conf
sudo nginx -s reload