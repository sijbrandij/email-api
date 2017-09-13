# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version
2.3.1p112

* System dependencies

* Configuration

* Database
The application does not use a database

* How to run the test suite
The testsuite is built in MiniTest. To run the entire testsuite, run `bin/rails test` in your terminal.

* Services (job queues, cache servers, search engines, etc.)
Mailgun email service
- create account
- edit `~/.bashrc` and add the following lines
1. export MAILGUN_API_KEY=YOUR_API_KEY
1. export MAILGUN_DOMAIN_NAME=YOUR_MAILGUN_DOMAINNAME
- run `source ~/.bashrc` in your terminal to load the environment variables


* Deployment instructions

* Rationale
- I have stuck to most Rails conventions (use MiniTest, which is built-in test engine)
- I chose to create a Service Object to send the email, this makes it easier to test and maintain, and separates that logic from the controller that receives the JSON request
- 