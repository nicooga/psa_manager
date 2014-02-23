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

  def prepare_resource(r)
    decorate(r)
  end

  def prepare_collection(c)
    decorate_collection(c)
  end
end
