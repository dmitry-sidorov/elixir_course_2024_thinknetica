defmodule ProjectFive.EnrolementsTest do
  use ProjectFive.DataCase

  alias ProjectFive.{Courses, Enrolements, Students}
  alias ProjectFive.Courses.Course
  alias ProjectFive.Students.Student

  @students [
    %Student{first_name: "Jose", last_name: "Valim"},
    %Student{first_name: "Steve", last_name: "McConnel"},
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
      Enrolements.create_enrolment(course, student)
      enrolments = Enrolements.list_enrolments()

      assert enrolments
             |> Enum.any?(fn %{course: %{id: course_id}, student: %{id: student_id}} ->
               course_id == course.id and student_id == student.id
             end)
    end
  end

  test "should delete student or course with corresponding enrolments" do
    students = Students.list_students()
    courses = Courses.list_courses()

    for num <- 0..3 do
      course = Enum.at(courses, num)
      student = Enum.at(students, num)
      Enrolements.create_enrolment(course, student)

      case num do
        0 -> Enrolements.create_enrolment(course, Enum.at(students, 1))
        1 -> Enrolements.create_enrolment(Enum.at(courses, 0), student)
        _ -> true
      end
    end

    enrolments_before_delete = Enrolements.list_enrolments()
    course_to_delete = Enum.at(courses, 0)
    student_to_delete = Enum.at(students, 3)

    Courses.delete_course(course_to_delete)
    Students.delete_student(student_to_delete)

    assert Enrolements.list_enrolments() ==
             Enum.reject(enrolments_before_delete, fn %{course: %{id: course_id}} ->
               course_id == course_to_delete.id
             end)
             |> Enum.reject(fn %{student: %{id: student_id}} ->
               student_id == student_to_delete.id
             end)
  end

  # test "delete enrolment" do
  #   assert Enrolements.delete_enrolment(%Student{}, %Course{}) == nil
  # end
end
