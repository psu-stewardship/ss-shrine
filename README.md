# Scholarsphere Shrine

This is just a test app that we're using to test using Shrine.

## Sidekiq

In another terminal window:

    bundle exec sidekiq

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

* Local development (OS X) - Full Stack
```bash 
brew cask install docker 

docker-compose build
docker-compose up -d 
```
* Local Development (OS X) - Dependancies Only
```
docker-compose up db minio -d 
rails s

```

* Local s3 with Minio
```
add s3_endpoint=http://minio:9001 to s3.env, or application.yml
map `minio` to `127.0.0.1`
    - sudo vi /private/etc/hosts
    ``` 127.0.0.1     minio```
    OR
    - https://addons.mozilla.org/en-US/firefox/addon/livehosts/
Initialize the bucket (first time only)
docker-compose exec minio mkdir -p /data/shrine (where 'shrine' is bucket name)
```
