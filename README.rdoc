# README

## Production Setup for Heroku deployment
* Built for Ruby 2.2.3
* Environment variable for SECRET_KEY_BASE (Rails requirement)
..* Required by Rails
* Environment variables for SendGrid SENDGRID_PASSWORD & SENDGRID_PASSWORD
..* SendGrid is the email service used
* Environment variables for Twitter API TWITTER_CONSUMER_KEY & TWITTER_CONSUMER_SECRET
..* Also required for dev environment

* There are no services

* Configuration

* Database creation

* Database initialization

* How to run the test suite





## Design

### Authentication
Although first time Rails developers are advised to create an authentication system from scratch, I decided to use Devise, having already created a log in system from scratch that had password hashing (encryption, salf and pepper), password recovery, automatic lockouts, email confirmation and a "remember me" option in PHP.