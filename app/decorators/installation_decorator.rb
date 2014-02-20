class InstallationDecorator < Draper::Decorator
  delegate_all

  def date
    object.date.try :strftime, '%a, %Y %b %d'
  end
end
