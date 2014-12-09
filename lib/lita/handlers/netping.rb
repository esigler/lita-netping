module Lita
  module Handlers
    class Netping < Handler
      route(
        /^ping\s(?<target>.+)/,
        :ping,
        command: true,
        help: {
          t('help.ping.syntax') => t('help.ping.desc')
        }
      )

      def ping(response)
        target = response.match_data['target']

        response.reply(format(target, ping_target(target)))
      end

      private

      def format(host, result)
        if result
          t('ping.success', host: host)
        else
          t('ping.fail', host: host)
        end
      end

      def ping_target(host)
        Net::Ping::External.new(host).ping
      end
    end

    Lita.register_handler(Netping)
  end
end
