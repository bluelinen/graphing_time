https://github.com/EverlyWell/backend-challenge
# Installation

## Installing dependencies
1. `bundle install`
1. Create a bit.ly access token
    * Save it as an environment variable `BITLY_TOKEN`
## Setting up the database
1. `rails neo4j:install`
1. `rails neo4j:migrate`
* Note: Please refer to [the Neo4j.rb setup docs](https://neo4jrb.readthedocs.io/en/v10.0.1/Setup.html) if there is any issue

## Notes
* This was built on ruby 2.6.5

# Running tests
`rspec`
* NOTE: I didn't have time to set up both a test db and a dev db. Currently the test db uses the dev db and wipes all the data after every test

# Running
`rails s`

# Notes

* With set up time, this took me about 5 and a half hours to complete.
* Set up was more difficult as it was the first time I've used neo4j.
* I ran out of time for additional tests and this README, but I didn't feel comfortable not including the README.
* I couldn't use the google link shortener because it is deprecated according to [their blog post](https://developers.googleblog.com/2018/03/transitioning-google-url-shortener.html). I used bit.ly instead, which was recommended on above blog post.
* After reading the instructions, it felt like it fit one of the use cases of a graphing database. While I didn't use any of the features (because of the specification to write my own search), I wanted to keep it because my custom search can easily be replaced with the neo4j search and path features, making searching faster.