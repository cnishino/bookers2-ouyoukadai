class GroupUser < ApplicationRecord

  belongs_to :group
  belongs_to :use

end
