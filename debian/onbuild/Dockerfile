FROM quay.io/assemblyline/fluentd:debian

ONBUILD COPY Gemfile Gemfile.lock ./
ONBUILD RUN install
ONBUILD USER fluent
ONBUILD ENTRYPOINT ["fluentd"]
