class BookPresenter < BasePresenter
  build_with    :id, :title, :subtitle, :isbn_10, :isbn_13, :description, :released_on, :publisher_id, :author_id,
                :created_at, :updated_at, :cover, :price_cents, :price_currency
  related_to    :publisher, :author
  sort_by       :id, :title, :released_on, :created_at, :updated_at, :price_cents, :price_currency
  filter_by     :id, :title, :isbn_10, :isbn_13, :released_on, :publisher_id,
                :author_id, :price_cents, :price_currency

  def cover
    @object.cover.url.to_s
  end
end
