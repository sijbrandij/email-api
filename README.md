# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version
2.3.1p112

* System dependencies
listen (~> 3.0.5)
pry
puma (~> 3.0)
rails (~> 5.0.6)
rest-client
spring
spring-watcher-listen (~> 2.0.0)

* Configuration

* Database
The application does not use a database

* How to run the test suite
The testsuite is built in MiniTest. To run the entire testsuite, run `bin/rails test` in your terminal.

* Services (job queues, cache servers, search engines, etc.)
Mailgun & SendGrid email services
- create accounts on both mailgun.com and sendgrid.net
- edit `~/.bashrc` and add the following lines
1. export SERVICE_PROVIDER=MAILGUN
1. export MAILGUN_API_KEY=YOUR_API_KEY
1. export MAILGUN_DOMAIN_NAME=YOUR_MAILGUN_DOMAINNAME
1. export SENDGRID_API_KEY=YOUR_API_KEY
1. export SENDGRID_DOMAIN_NAME=https://api.sendgrid.com/v3/mail/send
- run `source ~/.bashrc` in your terminal to load the environment variables

To switch email service providers, simply change the value of `SERVICE_PROVIDER` to SENDGRID

* Rationale
- I have stuck to most Rails conventions (use MiniTest, which is built-in test engine)
- I chose to create a Service Object to send the email, this makes it easier to test and maintain, and separates that logic from the controller that receives the JSON request
- 