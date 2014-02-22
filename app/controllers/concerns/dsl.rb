module DSL
  extend ActiveSupport::Concern

  def permit_params(*args)
    self.permited_params_keys ||= args
  end

  def decorate_with(decorator)
    self.decorator = decorator
  end
end
