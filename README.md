# capistrano-db-mirror

[![Gem Version][gem-image]][gem-link]
[![Dependency Status][deps-image]][deps-link]
[![Build Status][build-image]][build-link]
[![Coverage Status][cov-image]][cov-link]
[![Code Climate][gpa-image]][gpa-link]

Mirror DB from Remote.

## Installation

Add the capistrano-db-mirror gem to your Gemfile.

```ruby
gem "capistrano-db-mirror"
```

And run `bundle install`.

## Usage

Require `capistrano/db-mirror` in your `Capfile`.

```ruby
require `capistrano/db-mirror`
```

Then execute the cap task.

```bash
$ cap [env] db:mirror
```

Here, env is the enviornment you deploy and it can be ommited for default env.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new [Pull Request](../../pull/new/master)

## Copyright

Copyright (c) 2014 Daisuke Taniwaki. See [LICENSE](LICENSE) for details.




[gem-image]:   https://badge.fury.io/rb/capistrano-db-mirror.svg
[gem-link]:    http://badge.fury.io/rb/capistrano-db-mirror
[build-image]: https://secure.travis-ci.org/kaizenplatform/capistrano-db-mirror.png
[build-link]:  http://travis-ci.org/kaizenplatform/capistrano-db-mirror
[deps-image]:  https://gemnasium.com/kaizenplatform/capistrano-db-mirror.svg
[deps-link]:   https://gemnasium.com/kaizenplatform/capistrano-db-mirror
[cov-image]:   https://codeclimate.com/github/kaizenplatform/capistrano-db-mirror/badges/coverage.svg
[cov-link]:    https://codeclimate.com/github/kaizenplatform/capistrano-db-mirror
[gpa-image]:   https://codeclimate.com/github/kaizenplatform/capistrano-db-mirror.png
[gpa-link]:    https://codeclimate.com/github/kaizenplatform/capistrano-db-mirror

