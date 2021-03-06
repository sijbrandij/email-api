# README

This application provides an abstraction for sending emails through two email service providers, Mailgun and SendGrid.

If one service goes down, the application can be switched over quickly to the other email service provider.

The application provides a `/email` endpoint, which accepts a json POST request, which triggers a post request to one of the email service providers, which sends the email.

### Ruby version
2.3.1-p112

### System dependencies
- listen (~> 3.0.5)
- pry
- puma (~> 3.0)
- rails (~> 5.0.6)
- rest-client
- spring
- spring-watcher-listen (~> 2.0.0)

### Installation
1. Clone the git repo to your own machine `git clone git@github.com:sijbrandij/email-api.git`
2. `cd email/`
3. `bundle install`
This should install the application on your machine.
To start using the application, start your server by running `bin/rails server` in your terminal.

### Configuration
To send email using Mailgun & SendGrid email services:
- create accounts on both mailgun.com and sendgrid.net
- edit `~/.bashrc` and add the following lines
```
export SERVICE_PROVIDER=MAILGUN
export MAILGUN_API_KEY=https://api:YOUR_API_KEY
export MAILGUN_DOMAIN_NAME=@api.mailgun.net/v3/YOUR_MAILGUN_DOMAINNAME/messages
export SENDGRID_API_KEY=YOUR_API_KEY
export SENDGRID_DOMAIN_NAME=https://api.sendgrid.com/v3/mail/send
```
- run `source ~/.bashrc` in your terminal to load the environment variables

### Database
The application does not use a database.

### How to run the test suite
To run the testsuite, run `bin/rails test` in your terminal.

### Services
EmailDispatch is the service that handles the dispatch of the email to the service provider.
To switch email service providers, simply change the value of `SERVICE_PROVIDER` to SENDGRID

### Rationale
- In choosing a test framework, I stuck to Rails' default test framework MiniTest
- I chose to create Rails app without view logic (it's an API) or database (nothing needs to be persisted) because it wasn't necessary for the task at hand (`rails new my_app --api --skip-active-record`)
- I chose to create a Service Object to send the email, this makes the app easier to test and maintain, and separates that logic from the controller that receives the JSON request. This keeps the controller clean and simple.
- I chose the `rest-client` gem for sending HTTP requests because it is a lightweight gem that provides all the functionality I need for this project.
- I chose the `pry` gem for debugging instead of `byebug` because I am more familiar with it.
- If I had more time, I would want to make sure that the `to` and `from` emails are valid. Since this email application is meant to be consumed by another (I assume internal) application, I would handle the email validation in the other application, where the email is possibly an attribute of a resource. If it is, that means we can use Devise#confirmable to ensure the email address is confirmed, and possibly some other Devise methods that validate the email format. I would not want to use a custom regex, as it is difficult to keep up with the changes in domain names and extensions. In addition, by using Devise#confirmable, we know for certain that the user has access to the email account they submit to our application (and thus will have access to the email we're trying to send them).
- If I had more time, I would implement a way to track which emails were sent successfully, and which were not. I would collect them somewhere (either in a job or send that information back to the application consuming this API), so I can retry them. When the application gets switched over to the other email provider, a job would eventually run and the emails should get delivered (provided the other provider is not encountering issues and there is nothing fundamentally wrong with the data). The jobs could also run on the application that consumes this API.
- If the app were more complex, I would use integration tests to test the app's behavior. Since this app is so simple and all the parts are covered by unit tests, I didn't see a need to add an integration test.
