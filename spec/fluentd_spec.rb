require "serverspec"

describe "FluentD" do
  before(:all) do
    set :os, family: :debian
    set :backend, :docker
    set :docker_image, ENV["DOCKER_IMAGE"]
  end

  let(:env) do
    Hash[
      command("env")
        .stdout
        .split("\n")
        .map { |e| e.split("=") }
    ]
  end

  it "has the correct ruby" do
    expect(command("ruby -v").stdout.split("p").first.split[1]).to eq "2.3.3"
  end

  it "installs jemalloc" do
    expect(env["LD_PRELOAD"]).to match "libjemalloc"

    jemalloc = file(env["LD_PRELOAD"])
    expect(jemalloc).to exist
    expect(jemalloc).to be_file
    expect(jemalloc).to be_readable
    expect(jemalloc).to be_executable
  end

  # runtime dependencies
  %w(ruby libsystemd0 ca-certificates).each do |pkg|
    describe package(pkg) do
      it { should be_installed }
    end
  end

  # build dependencies
  %w(make gcc g++ libc-dev ruby-dev wget bzip2).each do |pkg|
    describe package(pkg) do
      it { should_not be_installed }
    end
  end
end
