# == Schema Information
# Schema version: 20110124192851
#
# Table name: resources
#
#  id                    :integer         not null, primary key
#  technicalRequirements :string(255)
#  url                   :string(255)
#  title                 :string(255)
#  format                :string(255)
#  notice_id             :integer
#  created_at            :datetime
#  updated_at            :datetime
#

class Resource < ActiveRecord::Base
  
  belongs_to :notice
  
  attr_accessible :title, :url, :format, :technicalRequirements
  
  validates :url, :presence => true
    
end
