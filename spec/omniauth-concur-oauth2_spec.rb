require 'spec_helper'

describe OmniAuth::Strategies::Concur do
  let(:request) { double('Request', :params => {}, :cookies => {}, :env => {}) }

  subject do
    args = ['appid', 'secret', @options || {}].compact
    OmniAuth::Strategies::Concur.new(*args).tap do |strategy|
      allow(strategy).to receive(:request) {
        request
      }
    end
  end

  describe 'client options' do
    it 'should have correct name' do
      expect(subject.options.name).to eq('concur')
    end

    it 'should have correct site' do
      expect(subject.options.client_options.site).to eq('https://www.concursolutions.com')
    end

    it 'should have correct authorize url' do
      expect(subject.options.client_options.authorize_url).to eq('/net2/oauth2/Login.aspx')
    end

    it 'should have correct token url' do
      expect(subject.options.client_options.token_url).to eq('/net2/oauth2/GetAccessToken.ashx')
    end
  end

end