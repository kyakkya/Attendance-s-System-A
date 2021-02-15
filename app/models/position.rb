class Position < ApplicationRecord
     validates :place_num, uniqueness: true, allow_blank: true
end
