defmodule ProjectFive.EnrolementsTest do
  use ProjectFive.DataCase

  alias ProjectFive.Enrolements

  describe "enrolments" do
    alias ProjectFive.Enrolements.Enrolment

    import ProjectFive.EnrolementsFixtures

    @invalid_attrs %{year: nil, grade: nil}

    test "list_enrolments/0 returns all enrolments" do
      enrolment = enrolment_fixture()
      assert Enrolements.list_enrolments() == [enrolment]
    end

    test "get_enrolment!/1 returns the enrolment with given id" do
      enrolment = enrolment_fixture()
      assert Enrolements.get_enrolment!(enrolment.id) == enrolment
    end

    test "create_enrolment/1 with valid data creates a enrolment" do
      valid_attrs = %{year: 42, grade: 120.5}

      assert {:ok, %Enrolment{} = enrolment} = Enrolements.create_enrolment(valid_attrs)
      assert enrolment.year == 42
      assert enrolment.grade == 120.5
    end

    test "create_enrolment/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Enrolements.create_enrolment(@invalid_attrs)
    end

    test "update_enrolment/2 with valid data updates the enrolment" do
      enrolment = enrolment_fixture()
      update_attrs = %{year: 43, grade: 456.7}

      assert {:ok, %Enrolment{} = enrolment} = Enrolements.update_enrolment(enrolment, update_attrs)
      assert enrolment.year == 43
      assert enrolment.grade == 456.7
    end

    test "update_enrolment/2 with invalid data returns error changeset" do
      enrolment = enrolment_fixture()
      assert {:error, %Ecto.Changeset{}} = Enrolements.update_enrolment(enrolment, @invalid_attrs)
      assert enrolment == Enrolements.get_enrolment!(enrolment.id)
    end

    test "delete_enrolment/1 deletes the enrolment" do
      enrolment = enrolment_fixture()
      assert {:ok, %Enrolment{}} = Enrolements.delete_enrolment(enrolment)
      assert_raise Ecto.NoResultsError, fn -> Enrolements.get_enrolment!(enrolment.id) end
    end

    test "change_enrolment/1 returns a enrolment changeset" do
      enrolment = enrolment_fixture()
      assert %Ecto.Changeset{} = Enrolements.change_enrolment(enrolment)
    end
  end
end
