# covid-volunteers

[![CircleCI build status](https://img.shields.io/cirrus/github/helpwithcovid/covid-volunteers?style=plastic)](https://circleci.com/gh/helpwithcovid/covid-volunteers)

This repository stores the code for the https://helpwithcovid.com/ website.

The stack is:

- Ruby on Rails 6.0
- Tailwind CSS
- Postgres

# Table of contents
- [covid-volunteers](#covid-volunteers)
- [Table of contents](#table-of-contents)
- [Running app locally](#running-app-locally)
  - [Setup](#setup)
    - [Dependencies](#dependencies)
    - [macOS ruby setup](#macos-ruby-setup)
    - [Postgres](#postgres)
    - [Project setup](#project-setup)
  - [Launch app](#launch-app)
  - [Running tests](#running-tests)
  - [Common problems in dev](#common-problems-in-dev)
    - [Page layout broken](#page-layout-broken)
    - [Captcha not working](#captcha-not-working)
    - [Emails not sending](#emails-not-sending)
- [Contributing](#contributing)
- [License](#license)

# Running app locally

## Setup

### Dependencies

- ruby `2.6.3`
- bundler `2.1.4`
- postgres

### macOS ruby setup

```bash
brew install rbenv 
brew install postgresql
rbenv init
echo 'eval "$(rbenv init -)"' >> ~/.zshrc 
# source profile or restart shell, then:
rbenv install 2.6.3
rbenv local 2.6.3
gem install bundler
gem install rails
rbenv rehash
```

### Postgres

Install and start postgresql:
- On macOS, you can use `pg_ctl -D /usr/local/var/postgres start`
- (To stop postgres use `pg_ctl -D /usr/local/var/postgres stop`)


### Project setup 

Install dependencies:

```
bundle install
yarn install
```

Setup the database and seed data:

```
rails db:setup
```

Create a `.env` file with the following:
```
SMTP_USERNAME=project-email@gmail.com
SMTP_PASSWORD=email-account-password
SMTP_NOREPLY=no-reply@domain.com
```

Replace the text to the right of the `=` with the correct values.

## Launch app

```
rails server
```

Then go to [http://localhost:3000](http://localhost:3000) to view app

## Running tests

```
rails spec
```
## Common problems in dev

### Page layout broken

Error text: `Webpacker can't find stylesheets...`

Remove `node_modules`, `yarn.lock` and `package-lock.json`. Run `yarn` to reinstall all frontend dependencies and try running the rails server again. Alternatively you can remove `node_modules` only and try `yarn install --frozen-lockfile`.

### Captcha not working 

Try using `localhost:3000` to run the site rather than `127.0.0.1`. 

### Emails not sending

By default, emails are not sent when running in development, but you can make them work: Copy all the `mailer` settings from `config/production.rb` into `config/development.rb`. 

# Contributing

Help is welcome! We are communicating on [Discord](https://discord.gg/875AhXS) in the #hwc-development channel

1. Fork the project
1. Create a branch with your changes
1. Submit a pull request

# License

MIT
