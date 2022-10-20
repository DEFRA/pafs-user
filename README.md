[![CI](https://github.com/DEFRA/pafs-user/actions/workflows/ci.yml/badge.svg)]((https://github.com/DEFRA/pafs-user/actions/workflows/ci.yml))

# Project Application and Funding Service

The Project Application and Funding Service (PAFS) is used by regional management authorities to apply for funding for flood and coastal risk management projects.

This service is not currently released but is intended to replace the existing method soon. The key difference is that it will have been developed in accordance with the [Digital by Default service standard](https://www.gov.uk/service-manual/digital-by-default), putting user needs first and delivered iteratively.

The application sends emails using the Send-grid e-mail service.

## PAFS Documentation
For a full breakdown of the PAFS documentation, technical and non technical please click the [link](https://aimspd.sharepoint.com/sites/pwa_dev/AIMS%20Project%20Delivery%20Collaboration/_layouts/15/guestaccess.aspx?docid=08fcc88cb3f7c45b48a274bf0ea4132f5&authkey=AWuSgciHOQlICM9DP0JtdRA)

## Development Environment

### Install global system dependencies

The following system dependencies are required, regardless of how you install the development environment.

* [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
* [git-flow](https://github.com/nvie/gitflow/wiki/Installation)

### Obtain the source code

Clone the repository, copying the project into a working directory:

    git clone https://github.com/EnvironmentAgency/pafs-user.git
    cd pafs-user

We use "git flow" to manage development and features branches.
To initialise git flow for the project, you need to run:

    git checkout -t origin/master
    git flow init # choose the defaults
    git checkout develop

See the [Wiki page on Git Flow](https://github.com/EnvironmentAgency/waste-exemptions/wiki/Git-Flow),
for more information about our branching strategy.

### Local Installation

#### Local system dependencies

* [Ruby 3.1.2](https://www.ruby-lang.org) (e.g. via [RVM](https://rvm.io) or [Rbenv](https://github.com/sstephenson/rbenv/blob/master/README.md))
* [Postgresql](http://www.postgresql.org/download)
* [Phantomjs](https://github.com/teampoltergeist/poltergeist#installing-phantomjs) (test specs)

#### Application gems _(local)_

Run the following to download the app dependencies ([rubygems](https://www.ruby-lang.org/en/libraries/))

    cd <pafs-project-directory>
    gem install bundler
    bundle install
    
#### .env configuration file

The project uses the [dotenv](https://github.com/bkeepers/dotenv) gem which allows enviroment variables to be loaded from a ```.env``` configuration file in the project root.

Duplicate ```./dotenv.example``` and rename the copy as ```./.env```. Open it and update SECRET_KEY_BASE and settings for database, email etc. - Secret Key base can be anything
    

#### Databases _(local)_

There are several databases per environment, therefore, ensure you run the following:

    bundle exec rake db:create:all
    bundle exec rake pafs_core:install:migrations
    bundle exec rake db:migrate
    bundle config local.pafs_core /path/to/local/pafs_core
    bundle
    

    OLD bundle exec rake db:migrate db:seed

#### Start the service _(local)_

To start the service locally simply run:

    bundle exec rails server

You can then access the web site at http://localhost:3000

#### Intercepting email in development

You can use mailcatcher to trap and view outgoing email.

Make sure you have the following in your `.env` or `.env.development` file:

    SECRET_KEY_BASE=''
    DATABASE_USERNAME=''
    DATABASE_PASSWORD=''
    DEVISE_USER_SEPARATE_DB=''
    DEVISE_MAILER_SENDER=''
    AIRBRAKE_HOST=''
    AIRBRAKE_PROJECT_KEY=''
    GOOGLE_ANALYTICS_ID=''
    EMAIL_USERNAME=''
    EMAIL_PASSWORD=''
    EMAIL_APP_DOMAIN=''
    EMAIL_HOST=''
    EMAIL_PORT=''
    ENABLE_USER_AREAS=''

Start mailcatcher with `$ mailcatcher` and navigate to
[http://127.0.0.1:1080](http://127.0.0.1:1080) in your browser.

Note that [mail_safe](https://github.com/myronmarston/mail_safe) maybe also be running in which
case any development email will seem to be sent to your global git config email address.

#### Setting an known state for our environments

There are times when we require our environments to be cleared of projects and put into a known state.
This is typical when we require that the service has no proposals, or their associated data.

The following command (`bundle exec projects:delete_all`) will remove all proposals from the service, leaving the existing users and their associated area's intact.

## Quality

We use tools like [rubocop](https://github.com/bbatsov/rubocop), [brakeman](https://github.com/presidentbeef/brakeman), and [i18n-tasks](https://github.com/glebm/i18n-tasks) to help maintain quality, reusable code. Rather than running them manually we automate it via GitHub actions.

## Tests

We use [RSpec](http://rspec.info/) for unit testing, and intend to use [Cucumber](https://github.com/cucumber/cucumber-rails) for our acceptance testing.

### Test database seeding

Before executing the tests for the first time, you will need to seed the database:

    bundle exec rake db:seed RAILS_ENV=test

To execute the unit tests simply enter:

    rspec

As this point we have no acceptance tests but when we do they can be executed using:

    cucumber
    
### Production debugging

#### Rails console
To launch a rails console on a deployed server, the environment variables might need to be loaded from a different directory

For example:
`. ../../.exportedenv && RAILS_ENV=production bundle exec rails console`

#### Logging
Currently (15 Jun 2021), no logs are written to the `production.log`. This should be fixed.

#### File upload errors
When the file upload fails, the user sees a 'cookies' error. This might come from an `InvalidAuthenticityToken`, which might also come from a Clam AV error.
It's worth checking that the Clam AV service is running: https://github.com/franckverrot/clamav-client#ping--boolean

## Contributing to this project

If you have an idea you'd like to contribute please log an issue.

All contributions should be submitted via a pull request.

## License

THIS INFORMATION IS LICENSED UNDER THE CONDITIONS OF THE OPEN GOVERNMENT LICENCE found at:

http://www.nationalarchives.gov.uk/doc/open-government-licence/version/3

The following attribution statement MUST be cited in your products and applications when using this information.

> Contains public sector information licensed under the Open Government license v3

### About the license

The Open Government Licence (OGL) was developed by the Controller of Her Majesty's Stationery Office (HMSO) to enable information providers in the public sector to license the use and re-use of their information under a common open licence.

It is designed to encourage use and re-use of information freely and flexibly, with only a few conditions.
