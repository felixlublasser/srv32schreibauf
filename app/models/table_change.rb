class TableChange < ApplicationRecord
  include ActiveModel::Serialization

  belongs_to :table
end
