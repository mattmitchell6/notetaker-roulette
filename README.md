# PaymentIntents API boilerplate

A basic Sinatra boilerplate for Stripe Checkout

## Using this demo

This demo is written in Ruby with the Sinatra framework. To get started, clone the repository locally and run bundler to install dependencies:

```
git clone https://github.com/mattmitchell6/stripe-checkout-demo.git && cd stripe-checkout-demo
bundle install
```

Add your Stripe secret / publishable keys to the .env file (rename sample.env to .env).

Run the application locally:

```
shotgun server.rb
```

Navigate to [http://localhost:9393](http://localhost:9393) to view the index page.
