require "omniauth/strategies/oauth2"

module OmniAuth
  module Strategies
    class Harvest < OmniAuth::Strategies::OAuth2
      option :client_options,
             site: "https://id.getharvest.com",
             authorize_url: "/oauth2/authorize",
             token_url: "/api/v2/oauth2/token"

      uid { raw_info["user"]["id"] }

      info do
        {
          email: raw_info["user"]["email"],
          first_name: raw_info["user"]["first_name"],
          last_name: raw_info["user"]["last_name"],
        }
      end

      extra do
        {
          raw_info: raw_info["accounts"]
        }
      end

      def raw_info
        @raw_info ||= access_token.get("/api/v2/accounts").parsed
      end
    end
  end
end
