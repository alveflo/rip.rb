#!/usr/bin/env/ruby -w
require 'open-uri'
load 'cliparser.rb'

parser = Cliparser.new
args = parser.parse(ARGV)

