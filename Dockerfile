FROM alpine:3.6
MAINTAINER Wilson Valencia <wilval7126@gmail.com>

# Install base packages
RUN apk update && apk upgrade

# Install ruby and ruby-bundler
RUN apk add ruby-dev build-base ruby ruby-bundler bash 

# Clean APK cache
RUN rm -rf /var/cache/apk/*

RUN mkdir /usr/app
WORKDIR /usr/app

COPY Gemfile /usr/app/ 
COPY Gemfile.lock /usr/app/ 

RUN bundle install

COPY . /usr/app
