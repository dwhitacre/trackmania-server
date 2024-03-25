#!/usr/bin/env bash

for i in {1..50}; do mysql -u${MYSQL_USER} -p${MYSQL_PASSWORD} -h${MYSQL_HOST} -P${MYSQL_PORT} -e "show databases" && s=0 && break || s=$? && sleep 2; done
if [ ! $s -eq 0 ]; then exit $s; fi

mysql -u${MYSQL_USER} -p${MYSQL_PASSWORD} -h${MYSQL_HOST} -P${MYSQL_PORT} -e "create database pyplanet CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci" || true
