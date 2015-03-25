## What's this about?

`bundle install --deployment` does not install builtin gems (like minitest,
json) in the bundler path even if they're in `vendor/cache`.

Other system gems can pre-empt them in the load path, causing bundler to require
a version contrary to one in `Gemfile.lock`.

The expected behavior is that `bundle install --deployment` would also install
builtin gems to the path to better ensure the version in Gemfile.lock is loaded.

### How does this POC show the problem:

The Gemfile is locked to minitest `= 4.7.5`, which is also in `vendor/cache`.

The `ruby2.1` deb package installs minitest 4.7.5 to `/usr/lib/ruby/2.1.0`.

The `ruby-minitest` deb package installs minitest 5.2.1 to
`/usr/lib/ruby/vendor_ruby`.

Since the minitest 5.2.1 load path comes earlier 4.7.5, requiring minitest loads
5.2.1 instead of 4.7.5.

## How to run:

Clone this repo and run `docker build .`

Load path:
```
# ruby -rbundler/setup -e 'puts $:'
/usr/lib/ruby/gems/2.1.0/gems/minitest-4.7.5/lib
/var/lib/gems/2.1.0/gems/bundler-1.9.1/lib/gems/bundler-1.9.1/lib
/var/lib/gems/2.1.0/gems/bundler-1.9.1/lib
/usr/local/lib/site_ruby/2.1.0
/usr/local/lib/x86_64-linux-gnu/site_ruby
/usr/local/lib/site_ruby
/usr/lib/ruby/vendor_ruby/2.1.0
/usr/lib/x86_64-linux-gnu/ruby/vendor_ruby/2.1.0
/usr/lib/ruby/vendor_ruby
/usr/lib/ruby/2.1.0
/usr/lib/x86_64-linux-gnu/ruby/2.1.0
```
