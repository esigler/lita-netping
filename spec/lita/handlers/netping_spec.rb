require 'spec_helper'

describe Lita::Handlers::Netping, lita_handler: true do
  it do
    is_expected.to route_command('ping example.com').to(:ping)
  end

  describe '#ping' do
    it 'returns a success if the target is pingable' do
      send_command('ping example.com')
      expect(replies.last).to eq('example.com responded to ping')
    end

    it 'returns a failure if the target is not pingable' do
      send_command('ping unknownhost.local')
      expect(replies.last).to eq('unknownhost.local did not respond to ping')
    end
  end
end
