# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
defmodule ProjectFive.Seeds do
  alias Ecto.Repo
  alias ProjectFive.{Courses, Students}
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

  def call do
    seed_students()
    seed_courses()
  end

  defp seed_students do
    for student <- @students do
      Repo.insert!(student)
    end
  end

  defp seed_courses do
    for course <- @courses do
      Repo.insert!(student)
    end
  end
end
