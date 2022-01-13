class Post < ApplicationRecord
  # https://api.rubyonrails.org/v5.2.4.4/classes/ActiveRecord/Enum.html
  enum kind: { post: 0, image: 1, video: 2 }

  belongs_to :user
end
