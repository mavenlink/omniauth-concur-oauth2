require 'omniauth-oauth2'
require 'active_support'
require 'active_support/core_ext'

OAuth2::Response.register_parser(:concur_xml, ['text/xml', 'application/rss+xml', 'application/rdf+xml', 'application/atom+xml']) do |body|
  parsed = MultiXml.parse(body).deep_transform_keys { |key| key.to_s.downcase }
  if parsed.key?('access_token')
    access_token = parsed['access_token']
    {
        'access_token' => access_token['token'],
        'expires_at' => DateTime.strptime(access_token['expiration_date'], "%m/%d/%Y %l:%M:%S %p"),
        'refresh_token' => access_token['refresh_token'],
        'instance_url' => access_token['instance_url'],
    }
  else
    OAuth2::Response.class_variable_get(:@@parsers)[:xml].call(body)
  end
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
