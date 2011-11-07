# Evelpidon Validators (for Rails / ActiveModel / ActiveRecord)

Collection of various ActiveModel validators, alongside their client side implementation
as ClientSideValidations::Middleware (see [ClientSideValidations](https://github.com/bcardarella/client_side_validations)
for more info). Client side validations are optional and are enabled only if the client_side_validations gem is
already loaded.

## Validators

* Different
* Less
* More

## Installation

### Bundler

Add on your Gemfile :

```ruby
gem 'evelpidon_validators'
```

### By hand

On the console :

```bash
gem install evelpidon_validators
```

On your code :

```ruby
require 'evelpidon_validators'
```

## Usage

Validators are *not* automatically loaded. You can require the validators you need either explicitly one-by-one
or all of them. So for example :

```ruby
# Load only "Greater than" and "Less than" validators :
require 'evelpidon_validators/greater'
require 'evelpidon_validators/less'
```

or

```ruby
# Load everything
require 'evelpidon_validators/all'
```

### Enable client side validations support

Client-side validations work out of the box with Rails 3.1 (through the asset pipeline) :

- Configure / initialize ClientSideValidations (gem, js, etc...) per it's documentation.
- Require the 'evelpidon_validators' js. This will be served through the asset pipeline

So for example the following should work :

```
//= require rails.validations
//= require evelpidon_validators
```

## TODOs

* Better documentation
* Gather other useful validations found around the net...

## Note on Patches/Pull Requests

* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally (not really...).
* Commit, do not mess with gemspec, version, or history.
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send a pull request. Bonus points for topic branches.

## Author(s)

* [Nikos Dimitrakopoulos](http://github.com/nikosd)
* [Eric Cohen](http://github.com/eirc)

## Copyright

* Copyrignt (c) 2011 [E-Travel S.A.](http://www.airtickets24.com)
* Copyrignt (c) 2011 [Fraudpointer.com](http://www.fraudpointer.com)

## License

Evelpidon Validators are released under the MIT license.
See [LICENSE](/e-travel/evelpidon_validators/blob/master/LICENSE) for more details.
