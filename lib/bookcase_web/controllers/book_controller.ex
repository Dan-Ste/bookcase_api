defmodule BookcaseWeb.BookController do
  use BookcaseWeb, :controller

  alias Bookcase.Books
  alias Bookcase.Books.Book
  alias JaSerializer.Params

  action_fallback BookcaseWeb.FallbackController

  def index(conn, _params) do
    books = Books.list_books()
    render(conn, "index.json-api", data: books)
  end

  def create(conn, %{"data" => data = %{"type" => "book", "attributes" => book_params}}) do
    attrs = Params.to_attributes(data)
    with {:ok, %Book{} = book} <- Books.create_book(attrs) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", book_path(conn, :show, book))
      |> render("show.json-api", data: book)
    end
  end

  def show(conn, %{"id" => id}) do
    book = Books.get_book!(id)
    render(conn, "show.json-api", data: book)
  end

  def update(conn, %{"id" => id, "data" => data = %{"type" => "book", "attributes" => book_params}}) do
    book = Books.get_book!(id)
    attrs = Params.to_attributes(data)

    with {:ok, %Book{} = book} <- Books.update_book(book, attrs) do
      render(conn, "show.json-api", data: book)
    end
  end

  def delete(conn, %{"id" => id}) do
    book = Books.get_book!(id)
    with {:ok, %Book{}} <- Books.delete_book(book) do
      send_resp(conn, :no_content, "")
    end
  end
end
