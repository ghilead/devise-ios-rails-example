Open Source Saaskit Rails Backend
=================================

[![Circle CI](https://circleci.com/gh/netguru/saaskit-rails.svg?style=svg)](https://circleci.com/gh/netguru/saaskit-rails) [![Code Climate](https://codeclimate.com/repos/54734062e30ba07474053280/badges/398895b59d76c0c16cd2/gpa.svg)](https://codeclimate.com/repos/54734062e30ba07474053280/feed) [![Test Coverage](https://codeclimate.com/repos/54734062e30ba07474053280/badges/398895b59d76c0c16cd2/coverage.svg)](https://codeclimate.com/repos/54734062e30ba07474053280/feed)

A rails backend for demonstrating how [Saaskit for iOS][ios_saaskit] works.

Requirements
============

- Ruby 2.1.5 & Rails 4.2
- Postgres 9.3

You can find some guidelines on how to install above [on mac][mac_guidelines] and [on ubuntu][ubuntu_guidelines]

#### Optional (recommended)

- git (mac - `brew install git`, ubuntu - `apt-get install git`)


Setup
-----

- clone repo to your local machine `git clone https://github.com/netguru/saaskit-rails.git ./saaskit-rails`
- setup [database config](#user-content-database-config)
- setup [environment variables](#user-content-environment-variables)
- run server `rails server`


Database config
---------------

- install postgres on your machine - [installation guide][postgres_guidelines]
- create your postgres user for development env `createuser -d -P saaskit`
- create database for development env `createdb -O saaskit saaskit_development` and for test env `createdb -O saaskit saaskit_test`
- copy config/database.yml.sample to config/database.yml
- fill in your appropriate details in your database.yml config file
- run `spring rake db:setup`

Environment variables
---------------------

- copy .env.sample to .env
- fill your domain name and url - in local environment it's normally `localhost` and `http://localhost:3000` respectively.
- You will need to generate your own `SECRET_KEY_BASE` by running `spring rake secret` and pasting the output into .env file.
- You can omit Rollbar config in development environment.

[ios_saaskit]: https://github.com/netguru/saaskit
[mac_guidelines]: https://gorails.com/setup/osx/10.10-yosemite
[ubuntu_guidelines]: https://gorails.com/setup/ubuntu/14.10
[postgres_guidelines]: https://wiki.postgresql.org/wiki/Detailed_installation_guides
