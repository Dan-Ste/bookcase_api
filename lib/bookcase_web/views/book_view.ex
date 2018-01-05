defmodule BookcaseWeb.BookView do
  use BookcaseWeb, :view
  use JaSerializer.PhoenixView
  
  attributes [
    :description,
    :title,
    :inserted_at,
    :updated_at
  ]  
  
end
