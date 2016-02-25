# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  deleted_at             :datetime
#  first_name             :string           default(""), not null
#  last_name              :string           default(""), not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  acts_as_paranoid

  has_many :exercises, dependent: :destroy

  validates :first_name, presence: true
  validates :last_name, presence: true
  self.per_page = 5

  def full_name
    "#{first_name} #{last_name}"
  end

  def self.search_by_name(name)
    if name
      names_array = name.split(' ')
      if names_array.size == 1
        where('first_name LIKE ? or last_name LIKE ?',
        "%#{names_array[0]}%", "%#{names_array[0]}%").order(:first_name)
      else
        where('first_name LIKE ? or first_name LIKE ? or last_name LIKE ? or last_name LIKE ?',
          "%#{names_array[0]}%", "%#{names_array[1]}%", "%#{names_array[0]}%",
          "%#{names_array[1]}%").order(:first_name)
      end
    else
      User.all
    end
  end

end
