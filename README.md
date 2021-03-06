# Appolo
[![Code Climate](https://codeclimate.com/github/CaptainGabriel/AppoloGem/badges/gpa.svg)](https://codeclimate.com/github/CaptainGabriel/AppoloGem)
[![Gem Version](https://badge.fury.io/rb/appolo.svg)](http://badge.fury.io/rb/appolo)

Ruby gem that provides quick and easy access to the web api of [Thoth WebApp](https://adeetc.thothapp.com)

This project does not intends to show any super efficient or professional programming features since it´s only purpose was for me to learn the language and at the same time to build a ruby gem.

## Installation

Add this line to your application's Gemfile:

```ruby

gem 'Appolo'

```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install Appolo

## Usage

In order to specify which element to get, you can use one of the following
symbols:

* :classes
* :students
* :programs
* :courses
* :lec_semesters
* :teachers

Take a look at the tests for more info.


The following line of code

```ruby

puts Appolo::get_element_by_id(:students,38209)

```

will print the following info about a student with the id 38209:

```

Pedro Almeida - 38209

```

You can also get an instance related to the class with id 409 and
afterwards all the lectures that were given there like this:

```ruby

some_class = Appolo.get_element_by_id(:classes, 409)
all_lectures_now = some_class.lectures

puts all_lectures[0].title
# Aula 01 Introdução às  VMs processo e comparação .Net vs JVM
puts all_lectures[1].title
# Aula 02 Distribuição e ligação de componetes em ambiente Unmanaged
puts all_lectures[2].title
# Aula 03 Características da distribuição e ligação de componentes Managed

```

To get all the students participating in a certain class:

```ruby

some_class = .get_element_by_id(:classes, 409)
participants = some_class.participants

puts participants[0].name
#Humberto Pedro Pinto da Silva

```

For more information, just grab the id and get the specific student

```ruby

id = participants[0].id
student = .get_element_by_id(:students, id)
puts student.short_name
# Humberto Silva

```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/CaptainGabriel/Appolo/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
