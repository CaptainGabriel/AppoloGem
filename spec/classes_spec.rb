require 'rspec'
require 'Appolo'

describe 'getting all participants with Classes#participants' do
  it 'should return an array of Student objects' do
    class_temp = Appolo::get_class_by_id 386
    participants = class_temp.participants
    expect(participants).to be_a_kind_of(Array)
    expect(participants.count).to be >0
  end
end