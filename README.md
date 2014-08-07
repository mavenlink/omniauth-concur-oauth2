# OmniAuth Concur Strategy

This gem is an OmniAuth 2.0+ Strategy for the [Concur API](https://developer.concur.com/api-documentation/oauth-20-0).

*This gem has only been tested with Concur's [Web Flow](https://developer.concur.com/api-documentation/oauth-20-0/web-flow).  If you are using one of their other flow's, feel free to submit a pull request with any changes that are needed.*

## Usage

Add the strategy to your `Gemfile`:

```ruby
gem 'omniauth-concur-oauth2'
```

Then integrate the strategy into your middleware:

```ruby
use OmniAuth::Builder do
  provider :concur, 'consumer_key', 'consumer_secret', { scope: "LIST_OFF_APIS", callback_path: "/auth/concur/callback" }
end
```

In Rails, create a new file under config/initializers called omniauth.rb to plug the strategy into your middleware stack.

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :Concur, 'consumer_key', 'consumer_secret', { scope: "LIST_OFF_APIS", callback_path: "/auth/concur/callback" }
end
```

You must have a consumer key and secret, which are created when you register your Partner Application.

For additional information about OmniAuth, visit [OmniAuth wiki](https://github.com/intridea/omniauth/wiki).

## License

See [License](https://github.com/ascot21/omniauth-concur-oauth2/blob/master/LICENSE) for details.