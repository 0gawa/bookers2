class Group < ApplicationRecord
    has_many :group_users, dependent: :destroy
    belongs_to :owner, class_name: 'User'
    has_many :users, through: :group_users
    
    has_one_attached :group_image

    validates :name, presence: true, length: { maximum: 20 }
    validates :introduction, length: { maximum: 140 }

    def is_owned_by?(user)
      owner.id == user.id
    end

    def include_user?(user)
      group_users.exists?(user_id: user.id)
    end

    def get_group_image(weight, height)
        unless self.group_image.attached?
          file_path = Rails.root.join('app/assets/images/no_image.jpg')
          group_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
        end
        self.group_image.variant(resize_to_fill: [weight,height]).processed
    end
end
