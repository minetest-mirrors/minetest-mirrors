FROM alpine:3.17.3

RUN apk update --no-cache && apk add git jq

COPY . .
CMD ["/usr/sbin/crond", "-f"]