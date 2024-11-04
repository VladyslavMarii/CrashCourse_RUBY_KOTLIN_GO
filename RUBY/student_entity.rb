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
    
    def self.remove_student(student)
        @@students.delete(student)
    end

    def calculate_age
        current_date = Date.today

        current_date.year - @date_of_birth.year - ((current_date.mon > @date_of_birth.mon) || (current_date.mon == @date_of_birth.mon && current_date.mday >= @date_of_birth.mday) ? 0 : 1)
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