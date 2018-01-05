defmodule BookcaseWeb.BookControllerTest do
  use BookcaseWeb.ConnCase

  alias Bookcase.Books
  alias Bookcase.Books.Book
  alias Bookcase.Repo

  @create_attrs %{
    description: "some description",
    title: "some title",
  }
  @update_attrs %{
    description: "some updated description",
    title: "some updated title",
  }
  @invalid_attrs %{
    description: nil,
    title: nil,
  }

  def fixture(:book) do
    {:ok, book} = Books.create_book(@create_attrs)
    book
  end
  
  defp dasherize_keys(attrs) do
    Enum.map(attrs, fn {k, v} -> {JaSerializer.Formatter.Utils.format_key(k), v} end)
    |> Enum.into(%{})
  end

  
  defp relationships do
    %{}
  end

  setup %{conn: conn} do
    conn = conn
      |> put_req_header("accept", "application/vnd.api+json")
      |> put_req_header("content-type", "application/vnd.api+json")

    {:ok, conn: conn}
  end

  describe "index" do
    test "lists all books", %{conn: conn} do
      conn = get conn, book_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create book" do
    test "renders book when data is valid", %{conn: conn} do
      conn1 = post conn, book_path(conn, :create), %{
        "meta" => %{},
        "data" => %{
          "type" => "book",
          "attributes" => dasherize_keys(@create_attrs),
          "relationships" => relationships()
        }
      }
      assert %{"id" => id} = json_response(conn1, 201)["data"]

      conn2 = get conn, book_path(conn, :show, id)
      data = json_response(conn2, 200)["data"]
      assert data["id"] == "#{id}"
      assert data["type"] == "book"
      assert data["attributes"]["description"] == @create_attrs.description
      assert data["attributes"]["title"] == @create_attrs.title
      
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, book_path(conn, :create), %{
        "meta" => %{},
        "data" => %{
          "type" => "book",
          "attributes" => dasherize_keys(@invalid_attrs),
          "relationships" => relationships()
        }
      }
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update book" do
    setup [:create_book]

    test "renders book when data is valid", %{conn: conn, book: %Book{id: id} = book} do
      conn1 = put conn, book_path(conn, :update, book), %{
        "meta" => %{},
        "data" => %{
          "type" => "book",
          "id" => "#{book.id}",
          "attributes" => dasherize_keys(@update_attrs),
          "relationships" => relationships()
        }
      }
      data = json_response(conn1, 200)["data"]
      assert data["id"] == "#{id}"
      assert data["type"] == "book"
      assert data["attributes"]["description"] == @update_attrs.description
      assert data["attributes"]["title"] == @update_attrs.title
      

      conn2 = get conn, book_path(conn, :show, id)
      data = json_response(conn2, 200)["data"]
      assert data["id"] == "#{id}"
      assert data["type"] == "book"
      assert data["attributes"]["description"] == @update_attrs.description
      assert data["attributes"]["title"] == @update_attrs.title
      
    end

    test "renders errors when data is invalid", %{conn: conn, book: book} do
      conn = put conn, book_path(conn, :update, book), %{
      "meta" => %{},
      "data" => %{
        "type" => "book",
        "id" => "#{book.id}",
        "attributes" => dasherize_keys(@invalid_attrs),
        "relationships" => relationships()
      }
    }
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete book" do
    setup [:create_book]

    test "deletes chosen book", %{conn: conn, book: book} do
      conn1 = delete conn, book_path(conn, :delete, book)
      assert response(conn1, 204)
      assert_error_sent 404, fn ->
        get conn, book_path(conn, :show, book)
      end
    end
  end

  defp create_book(_) do
    book = fixture(:book)
    {:ok, book: book}
  end
end
