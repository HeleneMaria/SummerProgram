# == Schema Information
#
# Table name: books
#
#  id         :integer          not null, primary key
#  title      :string
#  reader_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Book < ActiveRecord::Base
  belongs_to :reader
end
