#!/bin/bash
docker pull ghcr.io/<user>/<repo>/web:latest
docker stop base-web || true
docker rm base-web || true
docker run -d --name base-web -p 30000:80 ghcr.io/<user>/<repo>/web:latest
