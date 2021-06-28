FROM ruby:2.5.0
RUN apt-get update -qq && apt-get install -y build-essential libmysqlclient-dev

RUN mkdir /weather_alert
WORKDIR /weather_alert

ADD Gemfile /weather_alert//Gemfile
ADD Gemfile.lock /weather_alert//Gemfile.lock

RUN bundle install
