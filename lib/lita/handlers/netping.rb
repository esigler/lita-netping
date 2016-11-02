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
        proto = URI(target).scheme if target =~ %r{^(\S+)://\S+}

        if valid_protocol?(proto)
          response.reply(format(target, ping_target(proto.downcase, target)))
        else
          response.reply(t('ping.unsupported', proto: proto))
        end
      end

      private

      def extract_host_and_port(target)
        if target =~ %r{^(\S+)://\S+}
          host = URI(target).host
          port = URI(target).port
        elsif target =~ /:[0-9]+$/
          host, _, port = target.rpartition(':')
        else
          host = target
          port = nil
        end
        [host, port]
      end

      def format(host, result)
        if result
          t('ping.success', host: host)
        else
          t('ping.fail', host: host)
        end
      end

      def ping_target(proto, target)
        # dissect the target to get the hostname and port
        host, port = extract_host_and_port(target)

        case proto
        when 'http'
          # With HTTP, we can just pass the target
          p = Net::Ping::HTTP.new(target)
        when 'icmp'
          # The default
          p = Net::Ping::External.new(host)
        when 'tcp'
          p = Net::Ping::TCP.new(host, port)
        end
        proto == 'icmp' ? p.ping(host, 1, 1, 1) : p.ping
      end

      def valid_protocol?(proto)
        %w(http icmp tcp).include?(proto.downcase)
      end
    end

    Lita.register_handler(Netping)
  end
end
