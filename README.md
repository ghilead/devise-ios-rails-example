Open Source Saaskit Rails Backend
=================================

[![Circle CI](https://circleci.com/gh/netguru/saaskit-rails.svg?style=svg)](https://circleci.com/gh/netguru/saaskit-rails)
[![Code Climate](https://codeclimate.com/repos/54734062e30ba07474053280/badges/398895b59d76c0c16cd2/gpa.svg)](https://codeclimate.com/repos/54734062e30ba07474053280/feed)
[![Test Coverage](https://codeclimate.com/repos/54734062e30ba07474053280/badges/398895b59d76c0c16cd2/coverage.svg)](https://codeclimate.com/repos/54734062e30ba07474053280/feed)
[![Dependency](https://img.shields.io/gemnasium/netguru/saaskit-rails.svg)](https://gemnasium.com/netguru/saaskit-rails)

A rails backend for demonstrating how [Saaskit for iOS][ios_saaskit] works.

How to use
==========

After a [successfull installation][#setup] you can use `localhost:3000/doc` to trigger request at some particular endpoints. You can also use some oldschool method with `curl`:

register a user
```bash
$ curl \
-H 'Accept: application/json' \
-H 'Content-Type: application/json' \
-X POST -d '{ "user": { "email": "user@example.com", "password": "1234" } }' \
http://localhost:3000/users
```

in return you will get a newly created user

```json
{
  "id": 2,
  "email": "user@example.com",
  "created_at": "2014-12-09T16:17:46.170Z",
  "updated_at": "2014-12-09T16:17:46.170Z",
  "authentication_token": "2-D9jBtnAPcP8fppzJAL"
}
```

login a user
```bash
$ curl \
-H 'Accept: application/json' \
-H 'Content-Type: application/json' \
-X POST -d '{ "user": { "email": "user@example.com", "password": "1234" } }' \
http://localhost:3000/users/sign_in
```

you will get again the same data:

```json
{
  "id": 2,
  "email": "user@example.com",
  "created_at": "2014-12-09T16:17:46.170Z",
  "updated_at": "2014-12-09T16:17:46.170Z",
  "authentication_token": "2-D9jBtnAPcP8fppzJAL"
}
```

to make request to resources that are only available for registered users, you need to pass email and authentication token in your headers all the time:

```bash
$ curl \
-H 'Accept: application/json' \
-H 'Content-Type: application/json' \
-H 'X-User-Email: user@example.com' \
-H 'X-User-Token: 2-D9jBtnAPcP8fppzJAL' \
-X GET http://localhost:3000/secret_spaces/new
```

response: `{ "id": null, "text": null, "created_at": null, "updated_at": null }`

Here is a complete list of paths:

- Useful Devise paths

>                login - `POST   /users/sign_in`
>                login - `GET    /users/sign_in`
>             register - `POST   /users`
>          update user - `PUT    /users`
>          delete user - `DELETE /users`
> change user password - `PUT    /users/password`
>       password reset - `POST   /users/password`

- Secret Spaces for demonstration purposes

>   index - `GET    /secret_spaces`
>    show - `GET    /secret_spaces/:id`
>     new - `GET    /secret_spaces/new`
>  create - `POST   /secret_spaces`
>    edit - `GET    /secret_spaces/:id/edit`
>  update - `PUT    /secret_spaces/:id`
>  delete - `DELETE /secret_spaces/password/:id`

Requirements
============

| Name |  Version |
| :--: | :---: |
| [Ruby][ruby] | 2.1.5 |
| [Ruby on Rails][rails] | 4.2 |

You can find some guidelines on how to install above [on mac][mac_guidelines] and [on ubuntu][ubuntu_guidelines]

#### Optional (recommended)

- git (mac - `brew install git`, ubuntu - `apt-get install git`)


Setup
=====

- clone repo to your local machine `git clone https://github.com/netguru/saaskit-rails.git ./saaskit-rails`

Database config
---------------

- copy config/database.yml.sample to config/database.yml `cp config/database.yml.sample to config/database.yml`
- fill in your appropriate details in your database.yml config file, example:

```yaml
development:
  adapter: sqlite3
  host: localhost
  database: saaskit_development
  username: saaskit
```

- and create a database:

```bash
rake db:create
rake db:schema:load
rake db:test:prepare
```

- create seed data with `rake db:seed`

this will create:

* users:
    - registered user - ios@example.com / alcatraz

Environment config
------------------

- copy .env.sample to .env `cp .env.sample .env`
- fill your domain name and url - in local environment it's normally `localhost` and `http://localhost:3000` respectively.
- you will need to generate your own `SECRET_KEY_BASE` by running `rake secret` and pasting the output into .env file.
- you can omit Rollbar config in development environment.

Start Server
------------

Before you start app be sure that PostgreSQL is already running. Then start Rails server on default port with `rails server`.

Tests
=====

- you run tests with `rspec`

Other tools
===========

Spring
------

You can use [Spring][spring] to speed up specs, rake tasks and rails commands.

Just add `spring` before commands like `rspec`, `rake`, `rails`

Contribution
============

First, thank you for contributing!

Here a few guidelines to follow:

- we follow [Ruby Style Guide][ruby_style_guides].
- you can use [rubocop][rubocop] which can be easily integrated with popular editors. ([our rubocop config][rubocop_config])
- keep gems up to date - you can use [gemsurance][gemsurance] to check for outdated gems - simply run `bundle exec gemsurance`.
- write tests
- make sure the entire test suite passes
- make sure rubocop passes, our config
- open a pull request on GitHub
- [squash your commits][squash_commits] after receiving feedback

Copyright  2014 © [Netguru][netguru_url], released under the New BSD License

[ruby]: https://www.ruby-lang.org
[rails]: http://www.rubyonrails.org
[postgres]: http://www.postgresql.org
[ios_saaskit]: https://github.com/netguru/saaskit
[mac_guidelines]: https://gorails.com/setup/osx/10.10-yosemite
[ubuntu_guidelines]: https://gorails.com/setup/ubuntu/14.10
[postgres_guidelines]: https://wiki.postgresql.org/wiki/Detailed_installation_guides
[spring]: https://github.com/rails/spring
[ruby_style_guides]: https://github.com/bbatsov/ruby-style-guide
[rubocop]: https://github.com/bbatsov/rubocop
[rubocop_config]: https://github.com/netguru/hound/blob/master/config/rubocop.yml
[gemsurance]: https://github.com/appfolio/gemsurance
[squash_commits]: http://blog.steveklabnik.com/posts/2012-11-08-how-to-squash-commits-in-a-github-pull-request
[netguru_url]: https://netguru.co
