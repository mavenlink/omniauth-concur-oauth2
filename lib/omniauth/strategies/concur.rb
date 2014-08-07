require 'omniauth-oauth2'

OAuth2::Response.register_parser(:custom_xml, ['text/xml', 'application/rss+xml', 'application/rdf+xml', 'application/atom+xml']) do |body|
  MultiXml.parse(body).deep_transform_keys{ |key| key.to_s.downcase } rescue body
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
      option :token_params, { :parse => :custom_xml }
    end
  end
end
