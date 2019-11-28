#!/bin/bash
docker build -t day34/boilerplate-nodejs .
docker run --env-file=.env.example day34/boilerplate-nodejs npm run test