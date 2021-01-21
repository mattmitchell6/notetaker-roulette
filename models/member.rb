# members.rb
class Member < ActiveRecord::Base
  mount_uploader :image, ImageUploader
end