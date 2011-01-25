# == Schema Information
# Schema version: 20110121140708
#
# Table name: notices
#
#  id         :integer         not null, primary key
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class Notice < ActiveRecord::Base
  
  belongs_to :user
  has_one :biblio, :dependent => :destroy
  has_many :resources, :dependent => :destroy
  
  accepts_nested_attributes_for :biblio
  accepts_nested_attributes_for :resources
  
  validates :user,    :presence => true
  validates :biblio,  :presence => true
  
  default_scope :order => 'notices.created_at DESC'
    
end
