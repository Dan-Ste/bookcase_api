# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Bookcase.Repo.insert!(%Bookcase.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias Bookcase.Repo  
alias Bookcase.Books.Book

[
  %Book{
    title: "Some",
    description: "Some description"
  },
  %Book{
    title: "Another",
    description: "Another discription"
  }
] |> Enum.each(&Repo.insert!(&1))