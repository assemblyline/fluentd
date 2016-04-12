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
