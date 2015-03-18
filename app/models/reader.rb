# == Schema Information
#
# Table name: readers
#
#  id                :integer          not null, primary key
#  firstName         :string
#  lastName          :string
#  phoneNumber       :string
#  email             :string
#  schoolFallName    :string
#  schoolFallGrade   :string
#  program           :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  age               :integer
#  tShirtSize        :string
#  newSchoolFallName :string
#  prize             :integer
#

class Reader < ActiveRecord::Base
  #relation to_many books, books gets destroy when the reader is
  has_many :books, dependent: :destroy
  
  validates :firstName, presence: true, length:{maximum:50}
  validates :lastName, presence: true, length:{maximum:50}
  PHONE_NUMBER_REGEX = /(?:(?:\+?1\s*(?:[.-]\s*)?)?(?:(\s*([2-9]1[02-9]|[2-9][02-8]1|[2-9][02-8][02-9]‌​)\s*)|([2-9]1[02-9]|[2-9][02-8]1|[2-9][02-8][02-9]))\s*(?:[.-]\s*)?)([2-9]1[02-9]‌​|[2-9][02-9]1|[2-9][02-9]{2})\s*(?:[.-]\s*)?([0-9]{4})/
 # validates :phoneNumber, format:{ with: PHONE_NUMBER_REGEX }
  EMAIL_REGEX=/[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}/
  validates :email, presence: true, uniqueness: {case_sensitive:false}#, format: { with: EMAIL_REGEX}
  
  def self.search1(search)
    if search
      self.where(['\'lastName\' like ? or \'firstName\' like ?', search ,search])
    else
      self.all
    end
  
  end
  
  def self.search2(name,schoolFallName,schoolFallGrade,prize)
    strings = Array.new
    condition = Array.new
    all=Array.new
    
    if name != ''
      strings.push '\'lastName\' like ? or \'firstName\' like ?'
      condition.push name
      condition.push name 
    end
     if schoolFallName != ''
      strings.push '\'schoolFallName\' like ?'
      condition.push schoolFallName
    end
     if schoolFallGrade != ''
      strings.push '\'schoolFallGrade\' like ?'
      condition.push schoolFallGrade
    end
    if prize != ''
      strings.push '\'prize\' like ?'
      condition.push prize
    end
    
    condition.insert(0,strings.join(" or "))
    self.select([:id, :firstName, :lastName, :phoneNumber, :email, :schoolFallName, :schoolFallGrade, :program, :age, :tShirtSize]).where(condition)
  end




def self.as_csv(options = {})
  CSV.generate(options) do |csv|
    csv << column_names
    all.each do |item|
      csv << item.attributes.values_at(*column_names)
    end
  end
end
end



