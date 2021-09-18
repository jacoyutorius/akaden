FROM ruby:3.0.2-alpine

RUN apk update
RUN apk add build-base libxml2-dev libxslt-dev

WORKDIR /app
COPY Gemfile* /app/
RUN bundle