# README

* Ruby version: 2.7.1

# How to run?
1. clone the repository using the command:
```
git clone git@github.com:victorpolicastro/github-api.git
```
2. After clonning it, if you don't have ruby 2.7.1, install it;
3. Run the command `bundle` to install the project's gems;
4. Run `rails db:reset` to create a database and to run all migrations;
5. Create a file at `config/`` named `application.yml`;
6. Create a ENV VAR named `GITHUB_API` with the value `'https://api.github.com/search/repositories'`. It should look like this:
```
GITHUB_API: 'https://api.github.com/search/repositories'
```
7. Run `rails s` to start server.

# How to run the specs?
1. Run `rspec` to run all specs.

# How to run Rubocop?
1. Run `rubocop` to see all rubocop offences.

# Endpoint documentation
You can access the documentation [HERE]<https://documenter.getpostman.com/view/6395540/T1LV94XS?version=latest#intro>

# Production
You can find the api on http://github-repository-finder-00.herokuapp.com (yes, it's a bad name, but all the other ones were taken :'()

# TODO
Resolve the remaining offenses from Rubocop
