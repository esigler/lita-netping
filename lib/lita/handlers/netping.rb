module Lita
  module Handlers
    class Netping < Handler
      route(
        /^ping(\s+(?<proto>\S+))?\s(?<target>\S+)/,
        :ping,
        command: true,
        help: {
          t('help.ping.syntax') => t('help.ping.desc')
        }
      )

      def ping(response)
        proto  = response.match_data['proto'] || 'icmp'
        target = response.match_data['target']

        # Update the protocol based on the target
        proto = URI(target).scheme if target.match /^(\S+):\/\/\S+/

        unless ['http', 'icmp', 'tcp'].include?(proto.downcase)
          response.reply(t('ping.unsupported', proto: proto))
          return false
        end

        response.reply(format(target, ping_target(proto.downcase, target)))
      end

      private

      def format(host, result)
        if result
          t('ping.success', host: host)
        else
          t('ping.fail', host: host)
        end
      end

      def ping_target(proto, target)
        # dissect the target to get the hostname and port
        if target.match /^(\S+):\/\/\S+/
          uri = URI(target)
          host = uri.host
          port = uri.port
        elsif target.match /:[0-9]+$/
          host, _, port = target.rpartition(':')
        else
          host = target
          port = nil
        end

        case proto
        when 'http'
          # With HTTP, we can just pass the target
          p = Net::Ping::HTTP.new(target)
          p.ping
        when 'icmp'
          # The default
          p = Net::Ping::External.new(host)
          p.ping(host, 1, 1, 1)
        when 'tcp'
          p = port ? Net::Ping::TCP.new(host, port) : Net::Ping::TCP.new(host)
          p.ping
        end
      end
    end

    Lita.register_handler(Netping)
  end
end
