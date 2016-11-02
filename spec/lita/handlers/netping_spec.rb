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

    it 'returns a success if the target is pingable via HTTP' do
      send_command('ping http example.com')
      expect(replies.last).to eq('example.com responded to ping')
    end

    it 'returns a success if the target is pingable via TCP' do
      send_command('ping tcp 127.0.0.1:6379')
      expect(replies.last).to eq('127.0.0.1:6379 responded to ping')
    end

    it 'returns a success if the target is pingable via TCP as a URI' do
      send_command('ping tcp://127.0.0.1:6379')
      expect(replies.last).to eq('tcp://127.0.0.1:6379 responded to ping')
    end

    it 'returns a failure if the target is not pingable' do
      send_command('ping unknownhost.local')
      expect(replies.last).to eq('unknownhost.local did not respond to ping')
    end

    it 'returns a failure if the protocol is not supported' do
      send_command('ping xmpp://jabber.org')
      expect(replies.last).to eq('xmpp is not a supported protocol')
    end
  end
end
