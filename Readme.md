# README

## To start project:
- bundle install
- rails db:create
- rails db:migrate
- yarn install (for Webpacker)
- rails assets:precompile
- rails s

### To run tests:
- rspec

## Alternative setup with Docker, docker-compose and dip
### Requirements
* [Docker](https://docs.docker.com/install/)
* [Docker Compose](https://docs.docker.com/compose/install/)
* [DIP](https://github.com/bibendi/dip)

### To build images and start server
- dip provision
- dip up

### To run tests
- dip rspec







