class Usuario < ActiveRecord::Base
  
  validates :nombre, :uniqueness => true,
                     :presence => true 
  
  # Include default devise modules. Others available are:
  # :trackable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :token_accesos, :dependent => :destroy
  has_many :puntuaciones, :dependent => :destroy
  
end
