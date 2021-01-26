class Student

  attr_reader :id
  attr_accessor :name, :grade

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]  
  def initialize(name, grade, id=nil)
    @name = name
    @grade = grade
    @id = id
  end

  def save
    query = "INSERT INTO students (name, grade) VALUES (?, ?);"
    DB[:conn].execute(query, self.name, self.grade)
    @id = DB[:conn].execute("SELECT * FROM students ORDER BY id DESC;")[0][0]
  end

  def self.create_table
    query = "CREATE TABLE students ( id INTEGER PRIMARY KEY, name TEXT, grade INTEGER );"
    DB[:conn].execute(query)
  end

  def self.create(hash)
    name = hash[:name]
    grade = hash[:grade]

    student = Student.new(name, grade)

    student.save

    student
  end

  def self.drop_table
    query = "DROP TABLE students;"
    DB[:conn].execute(query)
  end
  
end
