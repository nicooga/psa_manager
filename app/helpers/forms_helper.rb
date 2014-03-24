module FormsHelper
  def add_entity_icon(entity)
    icon :plus, t('helpers.form.add', model: entity.model_name.human)
  end
end
