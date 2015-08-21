require 'spec_helper'


describe 'Classes behavior' do

  context 'getting all participants with Classes#participants' do
    it 'should return an array of Student objects' do
      class_temp = Appolo.get_class_by_id 386
      participants = class_temp.participants
      expect(participants).to be_a_kind_of(Array)
      expect(participants.count).to be >0
    end
  end

  context 'getting all lectures with Classes#lectures' do
    it 'should return an array of Lecture instances' do
      gamboas_class = Appolo.get_class_by_id 409
      lectures = gamboas_class.lectures
      expect(lectures).to be_a_kind_of Array
      expect(lectures.count).to be >0
    end
  end

  context 'getting an instance of Lecture' do
    it 'should behave like this' do
      gamboas_class = Appolo.get_class_by_id 409
      lectures = gamboas_class.lectures
      lectureOne = lectures[0]
      expect(lectureOne.id).to eq 7171
      expect(lectureOne.title).to eq 'Aula 01 Introdução às  VMs processo e comparação .Net vs JVM'
    end
  end

  context 'getting all resources with #resources' do
    it 'should return an array of Resource instances' do
      gamboas_class = Appolo.get_class_by_id 409
      resources = gamboas_class.resources
      expect(resources).to be_a_kind_of Array
      expect(resources.count).to be >0
    end
  end

end