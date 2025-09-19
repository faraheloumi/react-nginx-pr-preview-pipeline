#!/bin/bash
PR_NUM=$1
docker stop pr-$PR_NUM || true
docker rm pr-$PR_NUM || true
rm /etc/nginx/sites-enabled/pr-$PR_NUM.conf
sudo nginx -s reload
docker rmi ghcr.io/<user>/<repo>/web:pr-$PR_NUM || true
