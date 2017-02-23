# Assemblyline
## FluentD

A base image to build your own Fluentd Container.

## Usage

1) Create a `Gemfile` with fluentd and any plugins you need.

```ruby
source "https://rubygems.org"

gem "fluentd", "0.14.13"

gem "fluent-plugin-systemd", "~> 0.2"
```

2) run `bundle install` to create a `Gemfile.lock`, thus locking the exact version
of all plugins and thier dependencies.

3) Create a `Dockerfile`

```Dockerfile
FROM quay.io/assemblyline/fluentd:1.0-onbuild
COPY config/* /etc/fluent/conf.d/
```

The ONBUILD instructions copy `Gemfile` and `Gemfile.lock` into your image,
and installs everything correctly.

Then its up to you to copy your configuration into place. Or provide it at runtime.

> The base image ships with a /etc/fluent/fluent.conf file that loads config from /etc/fluent/conf.d/. You may want to copy/mount multiple config files there. Or if your needs are simple you could just overide /etc/fluent/fluent.conf.

4) `docker build && docker push` FTW
