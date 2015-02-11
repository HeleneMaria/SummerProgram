# == Schema Information
#
# Table name: readers
#
#  id              :integer          not null, primary key
#  firstName       :string
#  lastName        :string
#  phoneNumber     :string
#  email           :string
#  schoolFallName  :string
#  schoolFallGrade :string
#  program         :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Reader < ActiveRecord::Base
  
  validates :firstName, presence: true, length:{maximum:50}
  validates :lastName, presence: true, length:{maximum:50}
  PHONE_NUMBER_REGEX = /(?:(?:\+?1\s*(?:[.-]\s*)?)?(?:(\s*([2-9]1[02-9]|[2-9][02-8]1|[2-9][02-8][02-9]‌​)\s*)|([2-9]1[02-9]|[2-9][02-8]1|[2-9][02-8][02-9]))\s*(?:[.-]\s*)?)([2-9]1[02-9]‌​|[2-9][02-9]1|[2-9][02-9]{2})\s*(?:[.-]\s*)?([0-9]{4})/
 # validates :phoneNumber, format:{ with: PHONE_NUMBER_REGEX }
  EMAIL_REGEX=/[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}/
  validates :email, presence: true, uniqueness: {case_sensitive:false}#, format: { with: EMAIL_REGEX}
end

