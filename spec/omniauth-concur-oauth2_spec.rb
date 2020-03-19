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

  describe ':concur_xml response parser' do
    let(:parser) { OAuth2::Response.class_variable_get(:@@parsers)[:concur_xml] }

    it 'parse correctly' do
      data = <<-XML
        <Access_Token>
          <Instance_Url>https://www.concursolutions.com/</Instance_Url>
          <Token>foobar</Token>
          <Expiration_date>1/13/2017 5:02:12 PM</Expiration_date>
          <Refresh_Token>barbaz</Refresh_Token>
        </Access_Token>
      XML
      expected = {
          'access_token' => 'foobar',
          'expires_at' => DateTime.parse('2017-1-13 17:02:12'),
          'refresh_token' => 'barbaz',
          'instance_url' => 'https://www.concursolutions.com/',
      }
      expect(parser.call(data)).to eq(expected)
    end

    context "when it gets some XML that doesn't match what we expect from concur" do
      it 'parses the XML' do
        data = <<-XML
          <Foo>my xml</Foo>
        XML
        expect(parser.call(data)).to eq({ 'Foo' => 'my xml' })
      end
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
