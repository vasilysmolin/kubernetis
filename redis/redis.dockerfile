FROM redis:6-alpine

COPY ./configs/redis.conf /redis.conf
