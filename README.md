# TermiChunk ![Build Status](https://github.com/kevinstuffandthings/termichunk/actions/workflows/ruby.yml/badge.svg) [![Gem Version](https://badge.fury.io/rb/termichunk.svg)](https://badge.fury.io/rb/termichunk)

Take large chunks of text that might otherwise run together, and organize them neatly within your terminal output.

Originally developed for [Simulmedia](https://simulmedia.com).

## Installation
Add this line to your application's Gemfile:

```ruby
# update with the version of your choice
gem 'termichunk'
```

And then execute:

```bash
$ bundle install
```

Or install it yourself as:

```bash
$ gem install termichunk
```

## Usage
Create reports. Nest them within each other. Bring sanity to your outputs.

```ruby
report = TermiChunk::Report.new(title: 'My Report')
report << 'Line one goes in here'
report << 'Another line here!'
puts report

┌─[ My Report ]──────────
│ Line one goes in here
│ Another line here!
└─[ My Report ]──────────

puts(TermiChunk::Report.new(title: 'AMAZING', padding: 1) do |parent|
  parent << 'I can write some stuff here'
  parent << report
end)

┌─[ AMAZING ]────────────────────
│
│  I can write some stuff here
│
│  ┌─[ My Report ]──────────
│  │ Line one goes in here
│  │ Another line here!
│  └─[ My Report ]──────────
│
│
└─[ AMAZING ]────────────────────
```

# Problems?
Please submit an [issue](https://github.com/kevinstuffandthings/termichunk/issues).
We'll figure out how to get you up and running with TermiChunk as smoothly as possible.
