module Draper
  class CollectionDecorator
    delegate :current_page, :total_pages,
      :limit_value, :model_name, :total_count,
      :offset_value, :last_page?, :page, :model_name, :proxy_association
  end
end
