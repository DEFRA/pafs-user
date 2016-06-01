# Play nice with Ruby 3 (and rubocop)
# frozen_string_literal: true

class UserArea < ActiveRecord::Base
  belongs_to :user
  belongs_to :area, class_name: "PafsCore::Area", foreign_key: :area_id

  validates_presence_of :user_id, :area_id
  validates_uniqueness_of :user_id, scope: :area_id
end
