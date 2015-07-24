require 'spec_helper'

describe Appolo do


  describe '.get_student_by_id(id)' do
    context 'id equals to 38209' do
        it 'should return an object that contains the following data' do
            student = Appolo.get_student_by_id(38209)
            expect(student.id).to eq 38209
            expect(student.number).to eq 38209
            expect(student.github_username).to eq nil

            expect(student.avatar_url).to be_a_kind_of(AvatarUrl)
            expect(student.links).to be_a_kind_of(Links)

            expect(student.links.type).to eq 'https://adeetc.thothapp.com/api/v1/students'
        end
    end

    context 'id that does not exist' do
        it 'should return nil' do
            student = Appolo.get_student_by_id(0)
            expect(student).to be_nil
        end
    end
  end

  describe '.get_students()' do
      it 'should return an hash with all students as an array'  do
          students = Appolo.get_students()
          expect(students).to be_a_kind_of(Array)
      end
  end

end