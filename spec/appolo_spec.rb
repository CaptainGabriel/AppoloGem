require 'spec_helper'

describe Appolo do

  describe 'getting all students' do
    it 'should return an Hash (id,object) with all students'  do
      students = Appolo.get_set_of_elements(:students)
      expect(students).to be_a_kind_of Hash
      expect(students.count).to be > 0
      students.values.each do |val|
        expect(val).to_not be_nil
      end
    end
  end

  describe 'getting all teachers' do
    it 'should return an Hash (id,object) with all the teachers' do
      teachers = Appolo.get_set_of_elements(:teachers)
      expect(teachers).to be_a_kind_of(Hash)
      expect(teachers.count).to be >0
      teachers.values.each do |val|
        expect(val).to_not be_nil
      end
    end
  end

  describe 'getting all classes' do
    it 'should return an Hash (id,object) with all the teachers' do
      classes = Appolo.get_set_of_elements(:classes)
      expect(classes).to be_a_kind_of Hash
      expect(classes.count).to be >0
      classes.values.each do |val|
        expect(val).to_not be_nil
      end
    end
  end

  describe 'getting all programs' do
    it 'should return an Hash (id,object) with all the programs' do
      programs = Appolo.get_set_of_elements(:programs)
      expect(programs).to be_a_kind_of Hash
      expect(programs.count).to be >0
      programs.values.each do |val|
        expect(val).to_not be_nil
      end
    end
  end

  describe 'getting all courses' do
    it 'should return an Hash (id,object) with all the courses' do
      courses = Appolo.get_set_of_elements(:courses)
      expect(courses).to be_a_kind_of Hash
      expect(courses.count).to be >0
      courses.values.each do |val|
        expect(val).to_not be_nil
      end
    end
  end

  describe 'getting all semesters' do
    it 'should return an Hash (id,object) with all the lective semesters' do
      lective_sem = Appolo.get_set_of_elements(:lec_semesters)
      expect(lective_sem).to be_a_kind_of Hash
      expect(lective_sem.count).to be >0
      lective_sem.values.each do |val|
        expect(val).to_not be_nil
      end
    end
  end

  describe '.get_student_by_id(id)' do
    context 'id equals to 38209' do
        it 'should return an object that contains the following data' do
            student = Appolo.get_element_by_id(:students, 38209)
            expect(student).to have_attributes id: 38209, number: 38209, github_username: nil

            expect(student.avatar_url).to be_a_kind_of(AvatarUrl)
            expect(student.links).to be_a_kind_of(Links)
            expect(student.program).to be_a_kind_of(Program)

            expect(student.links.type).to eql 'https://adeetc.thothapp.com/api/v1/students'
        end
    end

    context 'id that does not exist' do
        it 'should return an empty instance' do
            student = Appolo.get_element_by_id(:students, 0)
            expect(student).to be_a_kind_of Exception
            expect(student).to have_attributes http_code: 404
        end
    end

  end

  describe '.get_teacher_by_id(id)' do
    context 'Valid id' do
        it 'should return an object that contains the following data' do
          teacher = Appolo.get_element_by_id(:teachers, 1)
          expect(teacher).to have_attributes id: 1, number: 1647, short_name: 'Carlos Guedes'

          expect(teacher.avatar_url).to be_a_kind_of(AvatarUrl)
          expect(teacher.links).to be_a_kind_of(Links)
          expect(teacher.links.type).to eq 'https://adeetc.thothapp.com/api/v1/teachers'
        end
    end

    context 'Invalid id' do
        it 'should return nil when the id is not valid' do
          teacher = Appolo.get_element_by_id(:teachers, -1)
          expect(teacher).to be_a_kind_of Exception
          expect(teacher).to have_attributes http_code: 404
        end
    end
  end

  describe '.get_class_by_id(id)' do
    context 'Valid id' do
      it 'must return an object like this' do
        class_temp = Appolo.get_element_by_id(:classes, 387)
        expect(class_temp).to have_attributes id: 387, full_name: 'AED / 1415v / LI31N', course_unit_short_name: 'AED'
        expect(class_temp).to have_attributes short_name: 'LI31N', course_unit_id: 38

        expect(class_temp.links).to be_a_kind_of(Links)
        expect(class_temp.main_teacher).to be_a_kind_of(Teacher)
      end
    end

    context 'Invalid ID' do
      it 'must return exception when the id is not valid' do
        class_temp = Appolo.get_element_by_id(:classes, 1010)
        expect(class_temp).to be_a_kind_of Exception
        expect(class_temp).to have_attributes http_code: 404
      end
    end
  end

  describe '.get_program_by_id(id)' do
    context 'Valid id' do
      it 'should return an object like this' do
        single_program = Appolo.get_element_by_id(:programs, 1)
        expect(single_program).to have_attributes id: 1, short_name: 'LEIC'
        expect(single_program.links).to be_a_kind_of(Links)
        expect(single_program.course_units).to be_a_kind_of(Array)
      end
    end

    context 'Invalid id' do
      it 'must return exception when the id is not valid' do
        prog = Appolo.get_element_by_id(:programs, -1)
        expect(prog).to be_a_kind_of Exception
        expect(prog).to have_attributes http_code: 404
      end
    end
  end

end