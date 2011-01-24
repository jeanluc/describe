# == Schema Information
# Schema version: 20110121140708
#
# Table name: biblios
#
#  id          :integer         not null, primary key
#  notice_id   :integer
#  title       :string(255)
#  description :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

class Biblio < ActiveRecord::Base
  
  belongs_to :notice
  
  attr_accessible :title, :description
  
  validates :title, :presence => true
  
end
