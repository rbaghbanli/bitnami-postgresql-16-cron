#!/usr/bin/env bash
set -o errexit
tag=ghcr.io/rbaghbanli/bitnami-postgresql-16-cron
docker build -t ${tag} .
docker push ${tag}
