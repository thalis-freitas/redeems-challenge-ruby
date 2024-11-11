class SizeOptionSerializer < ActiveModel::Serializer
  attributes :id, :size

  def size
    I18n.t("activerecord.attributes.size_option.size.#{object.size}")
  end
end
