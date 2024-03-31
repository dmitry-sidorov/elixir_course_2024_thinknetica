defmodule ProjectFive.EnrolementsTest do
  use ProjectFive.DataCase

  alias ProjectFive.{Courses, Enrolements, Students}
  alias ProjectFive.Courses.Course
  alias ProjectFive.Students.Student

  @students [
    %Student{first_name: "Jose", last_name: "Valim"},
    %Student{first_name: "Steve", last_name: "McConnel"},
    %Student{first_name: "David", last_name: "Hanson"},
    %Student{first_name: "Yukihiro", last_name: "Matsumoto"},
    %Student{first_name: "Joe", last_name: "Armstrong"}
  ]

  @courses [
    %Course{title: "Elixir", description: "Learn Elixir, Ecto, Phoenix"},
    %Course{title: "Erlang", description: "Learn Erlang, GenServer, Actor model"},
    %Course{title: "Java", description: "Learn Java, Spring, PostgresQL"},
    %Course{title: "Ruby", description: "Learn Ruby, Ruby on Rails, ActiveRecord"}
  ]

  def seed_entities do
    seed_students()
    seed_courses()
  end

  defp seed_students do
    for student <- @students do
      student
      |> Map.from_struct()
      |> Students.create_student()
    end
  end

  defp seed_courses do
    for course <- @courses do
      course
      |> Map.from_struct()
      |> Courses.create_course()
    end
  end

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(ProjectFive.Repo)
    seed_entities()
  end

  for num <- 0..3 do
    @tag num: num
    test "should add student to the course #{num}", %{num: num} do
      course = Courses.list_courses() |> Enum.at(num)
      student = Students.list_students() |> Enum.at(num)
      Courses.add_student(course, student)
      enrolments = Enrolements.list_enrolments()

      assert enrolments
             |> Enum.any?(fn %{course: %{id: course_id}, student: %{id: student_id}} ->
               course_id == course.id and student_id == student.id
             end)
    end
  end

  for num <- 0..3 do
    @tag num: num
    test "should add course to selected student #{num}", %{num: num} do
      student = Students.list_students() |> Enum.at(num)
      course = Courses.list_courses() |> Enum.at(num)
      Students.add_course(student, course)
      enrolments = Enrolements.list_enrolments()

      assert enrolments
             |> Enum.any?(fn %{course: %{id: course_id}, student: %{id: student_id}} ->
               course_id == course.id and student_id == student.id
             end)
    end
  end
end
