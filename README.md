# covid-volunteers

[![CircleCI build status](https://img.shields.io/cirrus/github/helpwithcovid/covid-volunteers?style=plastic)](https://circleci.com/gh/helpwithcovid/covid-volunteers)

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

## Configuration

The following environment variables can be set:

| Environment variable  | Type of value                      | Description                                              |
|-----------------------|------------------------------------|----------------------------------------------------------|
| `ADMINS`              | Email addresses separated by a `,` | Gives admin permissions to the listed accounts           |
| `EXCEPTION_NOTIFIERS` | Email addresses separated by a `,` | Sends technical exceptions to the listed email addresses |
| `EMAIL_ADDRESS`       | Single email address               | Used to contact your team                                |

## Launch app

```
rails server
```

Then go to [http://localhost:3000](http://localhost:3000) to view app

## Running tests

```
rails spec
```

# Contributing

Help is welcome! We are communicating on [Discord](https://discord.gg/875AhXS) in the #hwc-development channel

1. Fork the project
1. Create a branch with your changes
1. Submit a pull request

# License

MIT
