class FormBase
  extend ActiveModel::Naming

  include ActiveModel::Conversion
  include ActiveModel::Serialization
  include ActiveModel::Validations

  def initialize(attributes = {})
    return unless attributes.present?

    attributes.each do |name, value|
      send("#{name}=", value) if respond_to? name.to_sym
    end
  end

  def persisted?
    false
  end
end