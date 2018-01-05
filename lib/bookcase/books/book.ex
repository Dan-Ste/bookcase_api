defmodule Bookcase.Books.Book do
  use Ecto.Schema
  import Ecto.Changeset
  alias Bookcase.Books.Book


  schema "books" do
    field :description, :string
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(%Book{} = book, attrs) do
    book
    |> cast(attrs, [
      :title,
      :description,
      
    ])
    |> validate_required([
      :title,
      :description,
      
    ])
  end
end
