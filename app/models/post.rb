class Post < ApplicationRecord
    belongs_to :user

    validates :title, presence: true

    scope :ordered, ->{ order(id: :desc)}

    after_create_commit -> { broadcast_prepend_later_to "posts" }   
    after_update_commit -> { broadcast_replace_later_to "posts" }
    after_destroy_commit -> { broadcast_remove_to "posts" }

    #all those above are are collectively equal to the code below
    # broadcasts_to ->(post) { "posts" }, inserts_by: prepend
end
