defmodule Bookcase.Repo.Migrations.CreateBooks do
  use Ecto.Migration


  # Remember to set the add options for each field.
  # ex: primary_key, default, null, size, precision, scale.
  # Also remember to set the value for on_delete and on_update references options 
  # ex: :nothing, :delete_all, :nilify_all, :restrict
  def change do
    create table(:books) do
      add :title, :string
      add :description, :string

      timestamps()
    end

  end
end
