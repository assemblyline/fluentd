VERSION = "1.0.0"
REPO    = "quay.io/assemblyline/fluentd"
FLAVOUR = "debian"
IMAGE   = ENV["DOCKER_IMAGE"] = "#{REPO}:#{FLAVOUR}"

def buildstamp
  @buildstamp ||= DateTime.now.strftime("%FT%H%M%S")
end

def tags
  parts = VERSION.split(".")
  [
    [parts[0]],
    parts[0..1],
    parts[0..2],
    parts[0..2] + [buildstamp],
  ].map do |version|
    "#{REPO}:#{FLAVOUR}-#{version.join(".")}"
  end
end

task :build do
  Dir.chdir(FLAVOUR) do
    sh "docker build -t #{IMAGE} ."
    Dir.chdir("onbuild") do
      sh "docker build -t #{IMAGE}-onbuild ."
    end
  end
end

task tag: :build do
  tags.each do |tag|
    sh "docker tag #{IMAGE} #{tag}"
    sh "docker tag #{IMAGE}-onbuild #{tag}-onbuild"
  end
end

task examples: :build do
  Dir["spec/examples/*"].each do |dir|
    Dir.chdir(dir) do
      example = dir.split("/").last
      sh "docker build -t #{REPO}:example-#{example} ."
    end
  end
end

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)
task spec: :examples

task fluentd_tests: :examples do
  sh "docker run #{REPO}:example-debian"
end

task release: :default do
  # Check that git is clean
  sh "git diff --exit-code"
  # Check that everything staged is commited
  sh "git diff-index --quiet --cached HEAD"

  # Tag the version
  sh "git tag -m \"Version #{VERSION}\" v#{VERSION}"
  sh "git push"
  sh "git push --tags"

  # push tagged images
  tags.each do |tag|
    sh "docker push #{tag}"
    sh "docker push #{tag}-onbuild"
  end

  # push unversioned images
  sh "docker push #{IMAGE}"
  sh "docker push #{IMAGE}-onbuild"
end

task default: [:spec, :fluentd_tests]
