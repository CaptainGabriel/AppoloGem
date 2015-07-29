#!/usr/bin/env ruby

require 'Appolo'

def any_key
  puts '<<any key to continue>>'
  gets
end

puts 'This program shows how this gem can be used by you.'

any_key

puts 'To start, let\'s get one student.'
puts 'We can get students by their ID so let\'s use the ID \'38209\':'
any_key
puts 'You can type \'puts Appolo::get_student_by_id 38209\' and we get:'
puts '<<' + Appolo.get_student_by_id(38209).to_s + '>>'
any_key

puts 'Now, let\'s get some teachers at once.'
puts 'You can do it by typing \'Appolo::get_teachers.each {|teacher| puts teacher}\''
puts 'and you will see something like:'
puts '1 - Carlos Guedes : cguedes@cc.isel.ipl.pt'
puts '2 - Ezequiel Conde : ezeq@cc.isel.ipl.pt'
puts '3 - Miguel Gamboa Carvalho : mcarvalho@cc.isel.ipl.pt'
puts '...'
any_key

puts 'Simple, right ? :)'
