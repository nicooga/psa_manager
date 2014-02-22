module Statusable
  extend ActiveSupport::Concern

  module ClassMethods
    def has_statuses(*statuses)
      opts = { column_name: :status }.merge(statuses.extract_options!)

      statuses.each do |s|
        class_attribute opts[:column_name].to_s.pluralize
        self.send("#{opts[:column_name].to_s.pluralize}=", statuses)

        define_method(:"#{s}?") { self.status.to_sym == s }
        define_method(:"not_#{s}?") { self.status.to_sym != s }

        scope s, -> { where opts[:column_name] => s }
        scope :"not_#{s}", -> { where.not opts[:column_name] => s }
      end
    end
  end
end
