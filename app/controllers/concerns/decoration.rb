module Decoration
  def decorate(object)
    if decorator
      decorator.decorate object
    else
      object.decorate
    end
  end

  def decorate_collection(collection)
    if decorator
      decorator.decorate_collection(collection)
    else
      collection.decorate
    end
  end
end
