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
            expect(student.program).to be_a_kind_of(Program)

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
      it 'should return an Hash (id,object) with all students'  do
          students = Appolo.get_students()
          expect(students).to be_a_kind_of(Hash)
          expect(students.count).to be >0
      end
  end

  describe '.get_teachers()' do
    it 'should return an Hash (id,object) with all the teachers' do
      teachers = Appolo.get_teachers()
      expect(teachers).to be_a_kind_of(Hash)
      expect(teachers.count).to be >0
    end
  end

  describe '.get_classes()' do
    it 'should return an Hash (id,object) with all the teachers' do
      classes = Appolo.get_classes
      expect(classes).to be_a_kind_of Hash
      expect(classes.count).to be >0
    end
  end

  describe '.get_programs()' do
    it 'should return an Hash (id,object) with all the programs' do
      programs = Appolo.get_programs
      expect(programs).to be_a_kind_of Hash
      expect(programs.count).to be >0
    end
  end

  describe '.get_courses()' do
    it 'should return an Hash (id,object) with all the courses' do
      courses = Appolo.get_courses
      expect(courses).to be_a_kind_of Hash
      expect(courses.count).to be >0
    end
  end

  describe '.get_lective_semesters()' do
    it 'should return an Hash (id,object) with all the lective semesters' do
      lective_sem = Appolo.get_lective_semesters
      expect(lective_sem).to be_a_kind_of Hash
      expect(lective_sem.count).to be >0
    end
  end


end