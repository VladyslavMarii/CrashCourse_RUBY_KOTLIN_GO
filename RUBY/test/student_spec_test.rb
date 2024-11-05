require 'minitest/autorun'
require 'minitest/spec'
require 'date'
require_relative '../student_entity'

describe Student do 
    let(:student) {Student.new("Cristiano", "Ronaldo", Date.new(1985, 2, 5))}
    let(:current_date){Date.today}

    before do
        Student.add_student(student)
    end

    after do 
        Student.class_variable_set(:@@students, Set.new)
    end

    describe '#initialize' do
        it "student name creation check" do 
            expect(student.name).must_equal 'Cristiano'
        end

        it "student surname creation check" do 
            expect(student.surname).must_equal 'Ronaldo'
        end

        it "student date creation check" do 
            expect(student.date_of_birth).must_equal Date.new(1985, 2, 5)
        end
    end

    describe '#duplicate_student' do
        it "add duplicate student" do
            Student.add_student(student)
            Student.add_student(student)
            expect(Student.class_variable_get(:@@students).size).must_equal 1
        end
    end

    describe '#invalid_date_of_birth' do
        it "raises error on invalid student creatiion" do
            expect{Student.new("Leo", "Kaleo", Date.today+2 )}.must_raise ArgumentError
        end
    end

    describe '#add_student' do
        it "adding valid student" do
            add_student = Student.new("Harry", "Kane", Date.new(1999, 12, 4))
            Student.add_student(add_student)
            expect(Student.class_variable_get(:@@students)).must_include add_student
        end
    end

    describe '#remove_student' do
        it "removing existed student" do 
            Student.remove_student(student)
            expect(Student.class_variable_get(:@@students)).wont_include student

        end
    end

    describe '#calculate_age_before_birthday' do
        it "calculate age for student before birthday" do
            age = Student.new("Vini", "Junior", Date.new(current_date.year - 20, current_date.mon, current_date.mday) + 1).calculate_age
            expect(age).must_equal 19
        end
    end

    describe '#calculate_age_on_birthday' do
        it "calculate age for student on birthday" do 
            age = Student.new("Vini", "Junior", Date.new(current_date.year - 20, current_date.mon, current_date.mday)).calculate_age
            expect(age). must_equal 20
        end
    end

    describe '#calculate_age_after_birthday' do
        it "calculate age for student after birthday" do 
            age = Student.new("Vini", "Junior", Date.new(current_date.year - 20, current_date.mon, current_date.mday) - 1).calculate_age
            expect(age).must_equal 20
        end
    end    

    describe '#get_student_by_age' do
        it "gets student by age" do 
            age = Date.today.year - 1985 - ((Date.today < Date.new(Date.today.year, 3, 5)) ? 1 : 0)
            student_by_age = Student.get_students_by_age(age)
            expect(student_by_age).must_equal [student]
        end
    end

    describe '#get_student_by_name' do 
        it "gets student by name" do
            expect(Student.get_students_by_name('Cristiano')).must_equal [student]
        end
    end
end