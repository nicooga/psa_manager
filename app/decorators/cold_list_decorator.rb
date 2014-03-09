class ColdListDecorator < Draper::Decorator
  include ActionView::Helpers::TagHelper
  delegate_all

  Call.statuses.each do |sts|
    define_method :"#{sts}_calls_count" do
      content_tag :span,
        object.send(:"#{sts}_calls_count"),
        class: 'badge'
    end
  end

  def responsible
    object.responsible.decorate
  end
end
