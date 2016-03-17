# Assemblyline
## FluentD

A docker container with fluentd and some usefull plugins for CoreOS/Kubernetes use on AWS.

Take a look at the example dir, for an example of shipping kubenetes and systemd logs
to the AWS Elasticsearch Service.

## Build your own

Install assemblyline-cli

```
gem install assemblyline-cli
```

Build it

```
assemblyline build .
```

This will build the container and run some tests...

If you are not bothered about testing and don't want to bother with assemblyline, you may do this:

```
mv templates/Dockerfile.erb Dockerfile
docker build .
```
