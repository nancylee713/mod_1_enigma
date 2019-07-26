require 'simplecov'
SimpleCov.start do
  add_filter "/test/"
end
require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
require './modules/shift_finder'
require './lib/enigma'
