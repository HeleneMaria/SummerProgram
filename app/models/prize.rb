# == Schema Information
#
# Table name: prizes
#
#  id         :integer          not null, primary key
#  level      :integer
#  reader_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#


class Prize < ActiveRecord::Base
    belongs_to :reader
end
