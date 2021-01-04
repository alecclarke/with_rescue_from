# WithRescueFrom

Rescue exceptions raised from given methods with ActiveSupport::Rescuable's [rescue_from](https://api.rubyonrails.org/classes/ActiveSupport/Rescuable/ClassMethods.html#method-i-rescue_from).

WithRescueFrom conveniently provides [rescue_from](https://api.rubyonrails.org/classes/ActiveSupport/Rescuable/ClassMethods.html#method-i-rescue_from) handling for given methods by wrapping each method with ActiveSupport::Rescuable's [rescue_with_handler](https://api.rubyonrails.org/classes/ActiveSupport/Rescuable.html#method-i-rescue_with_handler) exception handling.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'with_rescue_from'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install with_rescue_from

## Usage

```ruby
require 'with_rescue_from'

class Foo
  include ActiveSupport::Rescuable
  include WithRescueFrom

  with_rescue_from :bar

  rescue_from StandardError do |e|
    ...
  end

  def bar
    ... # StandardError exceptions raised here will be handled in rescue_from
  end

  def baz
    ... # StandardError exceptions raised here won't be handled in rescue_from
  end
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install `with_rescue_from` onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/alecclarke/with_rescue_from.


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
