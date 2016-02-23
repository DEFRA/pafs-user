# Grant Web Portal Beta

## Introduction

The Grant Web Portal Beta runs on Ruby on Rails using Ruby 2.3.0 and Rails 4.2.5.1. For the database we will be using PostgreSQL 9.4

## Getting Started

[Installing Rails on OSX](https://gorails.com/setup/osx/10.11-el-capitan)
[Installing Rails on Linux](http://railsapps.github.io/installrubyonrails-ubuntu.html)

[Installing PostgreSQL](https://wiki.postgresql.org/wiki/Detailed_installation_guides)
*Note: make certain to install libpq-dev to ensure that the beta application will setup correctly*

After cloning the repository, run the following:

```
bundle exec rake db:setup

```

This should install all of the gems you require, set up the files you need and set up the databases.

To run the application, run the following command:

```
bundle exec rails s
```

The site should then be available on localhost:3000

# Useful links

[Ordnance Survey Openspaces playground](http://www.ordnancesurvey.co.uk/business-and-government/help-and-support/web-services/code-playground.html)
