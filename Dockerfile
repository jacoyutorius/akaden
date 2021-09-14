FROM ruby:3.0.2-alpine

WORKDIR /app
COPY Gemfile /app/
RUN bundle