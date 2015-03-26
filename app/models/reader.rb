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
      self.where(["\"lastName\" like ? or \"firstName\" like ?", search ,search])
    else
      self.all
    end
  
  end
  
  def self.search2(name,schoolFallName,schoolFallGrade,program)
    strings = Array.new
    condition = Array.new
    all=Array.new
    
    if name != ""
      strings.push "\"lastName\" like ? or \"firstName\" like ?"
      condition.push name
      condition.push name 
    end
     if schoolFallName != ""
      strings.push "\"schoolFallName\" like ?"
      condition.push schoolFallName
    end
     if schoolFallGrade != ""
      strings.push "\"schoolFallGrade\" like ?"
      condition.push schoolFallGrade
    end
    if program != ""
      strings.push "\"program\" like ?"
      condition.push program
    end
    
    condition.insert(0,strings.join(" or "))
    puts condition
    

    self.select([:id, :firstName, :lastName, :phoneNumber, :email, :schoolFallName, :schoolFallGrade, :program, :age, :tShirtSize]).where(condition)
  end
  
  def prize
    Prize.select([:level]).where(["\"reader_id\" = ? ", self.id])
  end
  

  def self.as_csv_books(options={})
      
    CSV.generate(options) do |csv|
      collection_books = ["id","firstName","lastName","phoneNumber","email","schoolFallName","schoolFallGrade","program","age","tShirtSize","prize","nbOfBooks"]
      collection = ["id","firstName","lastName","phoneNumber","email","schoolFallName","schoolFallGrade","program","age","tShirtSize"]
  
      csv << collection_books
      
     all.each do |item|
       id = Prize.select(:id).where(reader_id: item.id).to_a #a simple where sends back a activerecord:relation instead of an activerecord
         @prize = Prize.find(id.first)
       attributes = item.attributes.values_at(*collection).push(@prize.level)
       attributes.push(item.books.count)
        csv << (attributes)
        puts item.books.count
      end
    end
  end
  
 ####NOT USED ANYMORE#####
  def self.as_csv_all(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |item|
        csv << item.attributes.values_at(*column_names)
      end
    end
  end
  
  
  
  def self.as_csv(options = {}, collection)
    CSV.generate(options) do |csv|
      csv << collection
      all.each do |item|
        csv << item.attributes.values_at(*collection)
      end
    end
  end
#############
end



