FROM ruby:2.6.0
RUN apt-get update \
    && apt-get install -y locales vim \
    && locale-gen ja_JP.UTF-8
ENV LANG ja_JP.UTF-8
ENV LANGUAGE ja_JP:ja
ENV LC_ALL=ja_JP.UTF-8
RUN localedef -f UTF-8 -i ja_JP ja_JP.utf8

RUN mkdir /weather_alert
WORKDIR /weather_alert

ADD Gemfile /weather_alert/Gemfile
ADD Gemfile.lock /weather_alert/Gemfile.lock

RUN bundle install
