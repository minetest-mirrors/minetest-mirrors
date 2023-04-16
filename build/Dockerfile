FROM alpine:3.17.3
ARG ACCESS_TOKEN

# deps
RUN apk update --no-cache && apk add git jq

# access token
RUN echo "${ACCESS_TOKEN}" > /access_token

COPY . .
CMD ["/usr/sbin/crond", "-f"]