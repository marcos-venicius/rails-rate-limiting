# Implement rate limiting

## Running the app

```bash
docker compose up -d --build
```

now, open your browser on [http://localhost:3000/foo](http://localhost:3000/foo).

## Testing

```bash
bundle install
```

```bash
rspec -f d
```

**note that you have to up your docker compose to run the tests**

## How it works?

Ok, we have installed one essential gem called `redis`.

This gem will allow us to manipulate a [redis](https://redis.io/) database.

Why redis?

Redis is a `key:value` in-memory database, what it mans? it means that is so fast!
**really fast**

Having in mind that we'll store thousands (or even more) requests per second and each request will access the redis database we really need a fast access (read and write).

You can use another database you prefer, but redis is the most common use.

So, every request that is made is first handled by my `rate_limiting` method on [application controller](./app/controllers/application_controller.rb)

He gets the remote ip from the client that is requesting and uses it as a key to store the requests count.
So, every requests is stored to this key.

Note that this key have an expire time `THROTTLE_TIME_WINDOW` that is located at [throttle.rb](./config/initializers/throttle.rb),
and also have a `THROTTLE_MAX_REQUESTS` that is located at the same file.

It means that `THROTTLE_MAX_REQUESTS` requests will be allowed in a window of `THROTTLE_TIME_WINDOW` seconds.
