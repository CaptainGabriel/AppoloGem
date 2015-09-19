require 'spec_helper'


describe 'Classes behavior' do

  context 'getting all participants with Classes#participants' do
    it 'should return an array of Student objects' do
      class_temp = Appolo.get_element_by_id(:classes, 386)
      participants = class_temp.participants
      expect(participants).to be_a_kind_of(Array)
      expect(participants.count).to be >0
      participants.each { |part| expect(part).to be_a_kind_of Student }
    end
  end

  context 'getting all lectures with Classes#lectures' do
    it 'should return an array of Lecture instances' do
      gamboas_class = Appolo.get_element_by_id(:classes, 409)
      lectures = gamboas_class.lectures
      expect(lectures).to be_a_kind_of Array
      expect(lectures.count).to be >0
      lectures.each { |lec| expect(lec).to be_a_kind_of Lecture }
    end
  end
  
  context 'getting all resources with #resources' do
    it 'should return an array of Resource instances' do
      gamboas_class = Appolo.get_element_by_id(:classes, 409)
      resources = gamboas_class.resources
      expect(resources).to be_a_kind_of Array
      expect(resources.count).to be >0
      resources.each { |res| expect(res).to be_a_kind_of Resource }
    end
  end

end