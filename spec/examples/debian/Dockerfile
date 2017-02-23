FROM quay.io/assemblyline/fluentd:debian-onbuild

# We have copy this to somewhere were the fluent user can write
# for the tests to run, as they put stuff in ./tmp
RUN cp -r /var/lib/gems/2.3.0/gems/fluentd-0.14.13 /home/fluent
WORKDIR /home/fluent/fluentd-0.14.13

# We have patched this so it runs against the installed fluentd
COPY test_fluentd.rb test/command/

# These files depend on git and are not for production use anyway
# so they are patched / removed.
COPY Rakefile .
RUN rm test/command/test_plugin_generator.rb

ENTRYPOINT []
CMD rake test TESTOPTS="-v"
