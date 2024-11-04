require 'minitest/autorun'
require 'minitest/reporters'
require 'date'
require 'set'
require_relative "../student_entity"


Minitest::Reporters.use! [
Minitest::Reporters::HtmlReporter.new(
reports_dir: '/test/reports',
report_filename: 'test_results.html'
)
]

# Multiple reporters
Minitest::Reporters.use! [
Minitest::Reporters::HtmlReporter.new,
Minitest::Reporters::JUnitReporter.new
]

class StudentTest < Minitest::Test

    def setup
        @student1 = Student.new('Boris', 'Barbaris', Date.new(2000, 1, 1))
        @student2 = Student.new('Tomas', 'Layton', Date.new(2000, Date.today.mon, Date.today.day))
        @student3 = Student.new('Tomas', 'Valtyk', Date.new(1998, 12, 31))

        Student.add_student(@student1)
        Student.add_student(@student2)
        Student.add_student(@student3)
    end

    def test_initialize
        assert_equal 'Boris', @student1.name
        assert_equal 'Barbaris', @student1.surname
        assert_equal Date.new(2000, 1, 1), @student1.date_of_birth
    end

    def test_duplicate_student
        @students = Set.new

        Student.add_student(@student1)

        @students.add(@student1)
        @students.add(@student2)
        @students.add(@student3)
       
        assert_equal @students, Student.class_variable_get(:@@students)
    end

    def test_invalid_date_of_birth
        assert_raises ArgumentError do
            Student.new('Anna', 'Sapolska', Date.today+30)
        end
        assert_raises ArgumentError do
            Student.new('Ganna', 'Sapolska', Date.today)
        end
    end

    def test_add_student
        add_student = Student.new("John", "Cena", Date.new(1999, 3, 3))
        Student.add_student(add_student)
        assert_includes Student.class_variable_get(:@@students), add_student
    end

    def test_remove_student
        Student.remove_student(@student1)
        refute_includes Student.class_variable_get(:@@students), @student1
    end

    def test_calculate_age_for_student1
        expected_age = Date.today.year - 2000
        assert_equal expected_age, @student1.calculate_age
    end
      
    def test_calculate_age_for_student2
        expected_age = Date.today.year - 2000
        assert_equal expected_age, @student2.calculate_age
    end
    
    def test_calculate_age_for_student3
        expected_age = Date.today.year - 1998 - ((Date.today < Date.new(Date.today.year, 12, 31)) ? 1 : 0)
        assert_equal expected_age, @student3.calculate_age
    end

    def test_get_students_by_age
        expected_age = Date.today.year - 2000
        actual_students = Student.get_students_by_age(expected_age)
        assert_equal [@student1, @student2], actual_students
        refute_equal @student3, actual_students
    end

    def test_get_students_by_name
        actual_students = Student.get_students_by_name('Tomas')
        assert_equal [@student2, @student3], actual_students
    end

    def teardown        
        Student.class_variable_set(:@@students, Set.new)
    end
end