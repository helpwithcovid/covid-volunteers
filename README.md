# HelpWith

[![CircleCI](https://circleci.com/gh/helpwithcovid/covid-volunteers.svg?style=shield)](https://circleci.com/gh/helpwithcovid/covid-volunteers)

This repository stores the code for the https://helpwithcovid.com/ website.

The stack is:

- Ruby on Rails 6.0
- Tailwind CSS
- Postgres

# One-click deploy to Heroku

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)

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

Then go to [http://localhost:3000](http://localhost:3000) to view app.

## Running tests

```
rails spec
```

## Setting up S3 on AWS

### Create a bucket
1. Create a bucket in the desired region.
2. Set "Block all public access" to true
3. Set CORS Configuration as below

```xml
<!-- CORS Configuration -->
<?xml version="1.0" encoding="UTF-8"?>
<CORSConfiguration xmlns="http://s3.amazonaws.com/doc/2006-03-01/">
<CORSRule>
    <AllowedOrigin>*</AllowedOrigin>
    <AllowedMethod>PUT</AllowedMethod>
    <AllowedHeader>*</AllowedHeader>
</CORSRule>
</CORSConfiguration>
```

### Create a user, group and policy
1. In IAM create a policy for `S3` with the following permissions `s3:PutObject`,`s3:GetObject`,`s3:ListBucket`,`s3:DeleteObject`.
2. Create a group with that policy attached
3. Create a user attached to that group

### Create CloudFront Origin Access Identity

1. On CloudFront admin, select `Origin Access Identity` from the sidebar
2. Click on `Create Origin Identity` and fill in a comment (which will become the name) (`access-identity-helpwithblackequity-images`)

### Create CloudFront distribution
1. Go to CloudFront and click Create distribution
2. In `Origin Domain Name` select your bucket address (helpwithblackequity-images-v1.s3.amazonaws.com)
3. Leave `Origin path` blank
4. You `Origin ID` should be prefilled with the bucket name (S3-helpwithblackequity-images-v1)
5. Select Yes on `Restrict Bucket Access`
6. Select `Use an Existing Identity` on `Origin Access Identity` and select the previously created OAI (`access-identity-helpwithblackequity-images`)

## Installation

See THEMING.md.

# Contributing

Help is welcome! We are communicating on [Discord](https://discord.gg/8nAJfFN) in the #hwc-com-development channel

1. Fork the project
1. Create a branch with your changes
1. Make sure all test are passing by running `bundle exec rails spec`
1. Make sure rubocop is happy by running `bundle exec rubocop` (you can run `bundle exec rubocop -a` to automatically fix errors)
1. Submit a pull request

# License

MIT
