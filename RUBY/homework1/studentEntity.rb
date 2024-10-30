require 'date'
require 'set'

class Student   
    attr_reader :name, :surname, :date_of_birth
    @@students = Set.new

    def initialize(name, surname, date_of_birth)
        if date_of_birth >= Date.today
            raise ArgumentError, 'Invalid date of birth for student'
        end
        @name = name
        @surname = surname
        @date_of_birth = date_of_birth
    end

    def self.add_student(student)
        @@students.add(student)
    end
    
    def remove_student()
        @@students.delete(self)
    end

    def calculate_age()
        age = Date.today.year - @date_of_birth.year
        age - (Date.today.mon > @date_of_birth.mon || Date.today.mon == @date_of_birth.mon && Date.today.day > @date_of_birth.day ? 1 : 0)
            
    end

    def self.get_students_by_age(age)
        @@students.select { |student| student.calculate_age == age }
    end

    def self.get_students_by_name(name)
        @@students.select { |student| student.name == name }
    end

    def eql?(other)
        @name == other.name && @surname == other.surname && @date_of_birth == other.date_of_birth
    end

    def hash
        @name.hash ^ @surname.hash ^ @date_of_birth.hash
    end
end