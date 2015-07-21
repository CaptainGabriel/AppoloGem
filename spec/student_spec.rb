require 'rspec'
require 'Appolo/student'

describe 'Student behaviour' do

  it 'should be able to be created like this' do
    student = Student.new(38209)
    student.set_number(38209)

    expect(student.id).to eq 38209
    expect(student.number).to eq 38209
  end
end