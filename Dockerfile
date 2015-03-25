FROM ubuntu:14.04

RUN apt-get update

# Add brightbox ppa
RUN apt-get install -y software-properties-common && \
  apt-add-repository -y ppa:brightbox/ruby-ng && \
  apt-get update

# Install ruby2.1, which comes with minitest 4.7.5
RUN apt-get install -y ruby2.1

# Install ruby-minitest package (5.2.1)
RUN apt-get install ruby-minitest

# Install bundler
RUN gem install bundler -v 1.9.1 --no-ri --no-rdoc

# Add Gemfile and script
ADD . /

# package gems in /vendor/cache
RUN bundle package

# Install gems with --deployment to /bundle
RUN bundle install --deployment --path /bundle

# Run the test script
RUN /system-gem-bug.rb
