require "serverspec"

describe "FluentD" do
  before(:all) do
    set :os, family: :debian
    set :backend, :docker
    set :docker_image, "quay.io/assemblyline/fluentd:example-debian"
  end

  let(:gems) do
    Hash[
      command("gem list")
        .stdout
        .split("\n").map do |gem|
          gem.tr(")","").split(" (")
        end
    ]
  end

  it "has the correct version of fluentd" do
    expect(gems["fluentd"]).to eq "0.14.13"
  end

  it "has the correct version of the plugins we want" do
    expect(gems["fluent-plugin-systemd"]).to eq "0.2.0"
    expect(gems["fluent-plugin-s3"]).to eq "1.0.0.rc2"
  end
end
