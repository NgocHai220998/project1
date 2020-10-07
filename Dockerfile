FROM ruby:2.6.3
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client npm\
  && rm -rf /var/lib/apt/lists/* \
  && curl -o- -L https://yarnpkg.com/install.sh | bash
RUN mkdir /project1
WORKDIR /project1
COPY Gemfile /project1/Gemfile
COPY Gemfile.lock /project1/Gemfile.lock

ENV BUNDLE_PATH=/bundle \
        BUNDLE_BIN=/bundle/bin \
        GEM_HOME=/bundle
ENV PATH="${BUNDLE_BIN}:${PATH}"

RUN bundle check || bundle install --binstubs="$BUNDLE_BIN"

# install yarn
RUN npm install -g yarn
RUN yarn install --check-files
