require 'omniauth-oauth2'
require 'active_support/core_ext'

OAuth2::Response.register_parser(:concur_xml, ['text/xml', 'application/rss+xml', 'application/rdf+xml', 'application/atom+xml']) do |body|
  parsed = MultiXml.parse(body).deep_transform_keys{ |key| key.to_s.downcase }['access_token']
  {
    'access_token' => parsed['token'],
    'expires_at' => parsed['expiration_date'].to_datetime,
    'refresh_token' => parsed['refresh_token'],
    'instance_url' => parsed['instance_url'],
  }
end

module OmniAuth
  module Strategies
    class Concur < OmniAuth::Strategies::OAuth2
      option :name, 'concur'
      option :client_options, {
        :site => 'https://www.concursolutions.com',
        :authorize_url => '/net2/oauth2/Login.aspx',
        :token_url => '/net2/oauth2/GetAccessToken.ashx',
        :token_method => :get,
        :access_url => '/net2/oauth2/Access.ashx',
      }
      option :token_params, { :parse => :concur_xml }
    end
  end
end
