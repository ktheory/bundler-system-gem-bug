#!/usr/bin/env ruby

require 'bundler/setup'
require 'minitest/autorun'
require 'minitest/pride'

class BundlerSystemGemBug < MiniTest::Unit::TestCase
  def test_should_require_minitest_version_from_gemfile
    assert_equal '4.7.5', MiniTest::Unit::VERSION
  end
end
