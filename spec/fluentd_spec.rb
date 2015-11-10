require 'serverspec'

describe 'FluentD' do
  let(:bundle) { Bundler.new(self) }

  it 'has the correct ruby' do
    expect(command('ruby -v').stdout.split('p').first.split[1]).to eq '2.2.3'
  end

  it 'installs the correct fluentd' do
    expect(command('bin/fluentd --version').stdout.chomp).to eq 'fluentd 0.12.17'
  end

  describe file('bin/fluentd') do
    it { should be_executable }
  end

  it 'installs all the fluentd plugins we need' do
    expect(bundle.packages['fluent-plugin-aws-elasticsearch-service']).to eq '0.1.3'
    expect(bundle.packages['fluent-plugin-kubernetes_metadata_filter']).to eq '0.13.0'
    expect(bundle.packages['fluent-plugin-json-in-json']).to eq '0.1.4'
  end

  describe file('/etc/fluent/fluent.conf') do
    it { should exist }
    it { should be_file }
  end

  class Bundler
    def initialize(context)
      @context = context
    end

    def packages
      Hash[
        context
          .command('bundle list')
          .stdout
          .split("\n")[1..-1]
          .map(&:split)
          .map { |a| [a[1], a[-1][1..-2]] }
      ]
    end

    private

    attr_reader :context
  end
end
