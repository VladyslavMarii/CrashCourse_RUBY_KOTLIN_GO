# Student Class Assignment

## Task Description
This project involves creating a `Student` class in Ruby with specified properties, validations, and methods to manage a list of unique students.

## Requirements

### 1. Properties
The `Student` class should have the following properties:
- `surname`: The student's last name.
- `name`: The student's first name.
- `date_of_birth`: The student's date of birth.

### 2. Class Variable
- `@@students`: A class variable that maintains a list of all unique `Student` instances created.

### 3. Validations
The following validations should be enforced:
- **Date of birth must be in the past**: If a student's date of birth is in the future, an `ArgumentError` should be raised.
- **Prevent duplicate students**: Duplicate entries (students with the same name, surname, and date of birth) should not be added to the `@@students` list.

### 4. Methods
The `Student` class should include the following methods:
- `calculate_age`: Calculates and returns the current age of the student.
- `add_student`: Adds a student to the class list if they are not already present.
- `remove_student`: Removes a student from the class list.
- `self.get_students_by_age(age)`: Returns a list of students who are of the specified age.
- `self.get_students_by_name(name)`: Returns a list of students who have the specified name.

## Note
The class should ensure that each student instance is unique in the `@@students` list, meaning no duplicate students should be added.

---

## Example Usage

```ruby
# Create a student instance
student = Student.new(surname: "Doe", name: "John", date_of_birth: Date.new(2000, 1, 1))

# Add student to the list
Student.add_student(student)

# Calculate the age of the student
age = student.calculate_age

# Remove a student from the list
Student.remove_student(student)

# Find students by age
students_of_age = Student.get_students_by_age(20)

# Find students by name
students_named_john = Student.get_students_by_name("John")
