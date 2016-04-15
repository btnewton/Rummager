# README

## Production Setup for Heroku deployment
* Built for Ruby 2.2.3 on Rails 4.2.4
* Environment variable for SECRET_KEY_BASE
..* Required by Rails
* SendGrid account for email (used for registration, unlocking and recovery)
* Environment variables for SendGrid SENDGRID_PASSWORD & SENDGRID_PASSWORD
..* SendGrid is the email service used
* Environment variables for Twitter API TWITTER_CONSUMER_KEY & TWITTER_CONSUMER_SECRET
* Postgres database

## Local Setup
* Built for Ruby 2.2.3 on Rails 4.2.4
* Environment variables for Twitter API TWITTER_CONSUMER_KEY & TWITTER_CONSUMER_SECRET
* SQLite3 for local database

## Testing
No additional setup is required. Simply run 'rake test' in the project directory.

## Design

### Authentication
Users must register and confirm their email address before accessing the sites main functionality.  I chose to use Devise authentication because it is very popular (ie has good support) and it makes it easy to set up a complete authentication system.  In addition to the default Devise modules, I added modules for email confirmation and account lockouts.  Although first time Rails developers are advised to create their own authentication system, I chose not to because I have already implemented a similar log in system from scratch in PHP.

### Tweet Caching
I went with a normalized database design for caching tweets and twitter account information.  While normalizing means that the twitter account and tweets table must be joined, there is no duplicate data (by definition), and the tables better represent their respective models and controllers.  There will be duplicate tweets stored if a twitter account does not produce at least 25 tweets between polls. This could be avoided, but the simplicity outweighs the storage benefits that would be gained.  Given more time, I would add an async task for deleting all but the 25 most recent tweets.