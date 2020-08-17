class User < ApplicationRecord
    has_many :events_created, foreign_key: :creator_id, class_name: "Event"
end
