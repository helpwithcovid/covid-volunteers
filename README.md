# covid-volunteers

[![CircleCI build status](https://img.shields.io/cirrus/github/sradu/covid-volunteers?style=plastic)](https://circleci.com/gh/sradu/covid-volunteers)

This repository stores the code for the https://helpwithcovid.com/ website.

The stack is:

- Ruby on Rails 6.0
- Tailwind CSS
- Postgres

# Running app locally

## Dependencies

- ruby `2.6.3`
- bundler `2.1.4`
- postgres

## Installation

Install and start postgresql:
- On macOS, you can use `pg_ctl -D /usr/local/var/postgres start`
- (To stop postgres use `pg_ctl -D /usr/local/var/postgres stop`)

Install dependencies:

```
bundle install
yarn install
```

Setup the database and seed data:

```
rails db:setup
```

## Launch app

```
rails server
```

Then go to [http://localhost:3000](http://localhost:3000) to view app

## Running tests

```
rails spec
```
