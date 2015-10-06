FROM helioncf/ubuntu-core
RUN apt-get update && apt-get install -y \
  nodejs \
  git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev \
  software-properties-common

RUN add-apt-repository --yes ppa:brightbox/ruby-ng && apt-get update

RUN apt-get --assume-yes install \
      ruby-switch \
      ruby2.1 \
      ruby2.1-dev \
      ruby2.1-doc

RUN gem2.1 install bundler

RUN mkdir sentinelcli
COPY ./sentinel/cli/Gemfile ./sentinelcli/Gemfile
RUN cd sentinelcli && bundle install

RUN mkdir sentineldaemon
COPY ./sentinel/daemon/Gemfile ./sentineldaemon/Gemfile

RUN cd sentineldaemon && bundle install
