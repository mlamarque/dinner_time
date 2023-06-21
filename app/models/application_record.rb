# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  # The below line will allow to return the correct model.first and model.last
  # even though we switched all primary_keys to the uuid type
  # /!\ it only affects .first and .last, it does not order implicitely other
  # calls like model.all /!\
  self.implicit_order_column = "created_at"
end
