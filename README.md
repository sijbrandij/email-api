# README

This application provides an abstraction for sending emails through two email service providers, Mailgun and SendGrid.
If one service goes down, the application can be switched over quickly to the other email service provider.
The application provides a '/email' endpoint, which accepts a json POST request, which triggers a post request to one of the email service providers, which sends the email.

### Ruby version
2.3.1p112

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
Mailgun & SendGrid email services
- create accounts on both mailgun.com and sendgrid.net
- edit `~/.bashrc` and add the following lines
```
export SERVICE_PROVIDER=MAILGUN
export MAILGUN_API_KEY=YOUR_API_KEY
export MAILGUN_DOMAIN_NAME=YOUR_MAILGUN_DOMAINNAME
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
- I have stuck to most Rails conventions (use MiniTest, which is built-in test engine)
- I chose to create a Service Object to send the email, this makes it easier to test and maintain, and separates that logic from the controller that receives the JSON request. This keeps the controller clean and simple.
- If this were a production application, I would want to make sure that the `to` and `from` emails are valid. Since this email application is meant to be consumed by another (I assume internal) application, I would handle the email validation in the other application, where the email is possibly an attribute of a resource. If it is, that means we can use Devise#confirmable to ensure the email address is confirmed, and possibly some other Devise methods that validate the email format. I would not want to use a custom regex, as it is difficult to keep up with the changes in domain names and extensions. In addition, by using Devise#confirmable, we know for certain that the user has access to the email account they submit to our application (and thus will have access to the email we're trying to send them).
- If I had more time, I would implement a method that tracks which emails were sent successfully, and which were not. I would collect them somewhere (possibly a job), so I can rerun them. When the application gets switched over to the other email provider, the jobs will eventually run and the emails should get delivered (provided the other provider is not encountering issues and there is nothing fundamentally wrong with the data).
