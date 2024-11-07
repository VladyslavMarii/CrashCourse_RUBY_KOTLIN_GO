require "./student_entity"

if __FILE__ == $0  
  begin
    puts "Attempting to add a student with an invalid date of birth..."
    student1 = Student.new("John", "Doe", Date.today + 1) 
    Student.add_student(student1)
  rescue ArgumentError => e
    puts "Error encountered: #{e.message}"
  ensure
    puts "Now demonstrating remaining valid operations..."
  
    # Adding valid students directly
    student2 = Student.new("Jane", "Smith", Date.new(2000, 5, 15))
    Student.add_student(student2)
    puts "Added student: #{student2.name} #{student2.surname}, born on #{student2.date_of_birth}"

    student3 = Student.new("Tom", "Johnson", Date.new(1995, 8, 24))
    Student.add_student(student3)
    puts "Added student: #{student3.name} #{student3.surname}, born on #{student3.date_of_birth}"

    student4 = Student.new("Alice", "Williams", Date.new(1992, 1, 30))
    Student.add_student(student4)
    puts "Added student: #{student4.name} #{student4.surname}, born on #{student4.date_of_birth}"

    student5 = Student.new("Bob", "Taylor", Date.new(1998, 12, 5))
    Student.add_student(student5)
    puts "Added student: #{student5.name} #{student5.surname}, born on #{student5.date_of_birth}"

    student6 = Student.new("Eve", "Brown", Date.new(1999, 6, 20))
    Student.add_student(student6)
    puts "Added student: #{student6.name} #{student6.surname}, born on #{student6.date_of_birth}"

    # Attempting to add a duplicate student
    puts "Attempting to add Jane Smith again..."
    
    Student.add_student(student2) 
    puts "Jane Smith added again (no duplicate check in Set)."

    # Demonstrating get_students_by_age
    puts "Getting students who are 24 years old:"
    students_24 = Student.get_students_by_age(24)
    students_24.each do |student|
      puts "#{student.name} #{student.surname} is 24 years old."
    end

    # Demonstrating get_students_by_name
    puts "Searching for students with the name 'Jane':"
    students_named_jane = Student.get_students_by_name("Jane")
    students_named_jane.each do |student|
      puts "Found student: #{student.name} #{student.surname}, born on #{student.date_of_birth}"
    end

    # Demonstrating remove_student
    puts "Removing Jane Smith from the list of students..."
    Student.remove_student(student2)
    puts "Jane Smith removed."

    # Verifying that Jane Smith has been removed
    puts "Verifying removal by searching for Jane Smith:"
    students_named_jane_after_removal = Student.get_students_by_name("Jane")
    if students_named_jane_after_removal.empty?
      puts "No students named Jane found after removal."
    else
      students_named_jane_after_removal.each do |student|
        puts "Found student: #{student.name} #{student.surname}, born on #{student.date_of_birth}"
      end
    end
  end 
end