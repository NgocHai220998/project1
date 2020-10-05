FROM ruby:2.6.3
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client npm\
  && rm -rf /var/lib/apt/lists/* \
  && curl -o- -L https://yarnpkg.com/install.sh | bash
RUN mkdir /project1
WORKDIR /project1
COPY Gemfile /project1/Gemfile
COPY Gemfile.lock /project1/Gemfile.lock
RUN bundle install
# install yarn
RUN npm install -g yarn
RUN yarn install --check-files
