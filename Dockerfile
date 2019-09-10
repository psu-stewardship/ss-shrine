FROM ruby:2.6.3 as ruby

WORKDIR /app

ENV TZ=America/New_York

### NodeJS
ENV NODE_VERSION 12.9.1
RUN mkdir /usr/local/nvm
ENV NVM_DIR /usr/local/nvm
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash
ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

RUN . $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

# Install system deps
RUN apt-get update && \
    apt-get install ffmpeg -y 


RUN npm install -g yarn

COPY Gemfile Gemfile.lock /app/
COPY package.json yarn.lock /app/
RUN yarn

RUN gem install bundler

RUN bundle package --all
RUN bundle install 

COPY . /app

RUN aws_bucket=bucket aws_access_key_id=key aws_secret_access_key=access aws_region=us-east-1 rails assets:precompile

CMD ["./entrypoint.sh"]
