class User < ActiveRecord::Base
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_PHONE_REGEX = /\(?([0-9]{3})\)?([ .-]?)([0-9]{4})\2([0-9]{4})/

  validates :login_id, length: { maximum: 50 }, presence: true, format: { with: VALID_EMAIL_REGEX },
                  uniqueness: { case_sensitive: false }, :message => "invalid e-mail address"
  validates_uniqueness_of :login_id, :message => "login id is duplicated. choose another one."
  validates :user_password, length: { minimum: 6, maximum: 50 }, :message => "6 <= password length <= 50"
  validates :name,  presence: true, length: { maximum: 50 }, :message => "name is too long"
  validates_inclusion_of :sex, :in => 0..1, :message => "neither male nor female? are you alien or what?"
  validates :cellphone, length: { maximum: 50 }, format: {with: VALID_PHONE_REGEX }
  validates_inclusion_of :type, :in => 0..2, :message => "choose adequate role." # TODO : not admin role!

  before_create :admin_role_check
  before_create :create_user_id
  before_create :set_subclass

  def admin_role_check
  	if self.type == Util::ADMIN_ROLE && self.login_id != 'admin' then return false end
  end

  def create_user_id
    self.user_id = self.login_id + SecureRandom.urlsafe_base64(nil, false)
  end

  def set_subclass
  	puts case self.role
    when Util::ADMIN_ROLE
      AdminUser.add_user(self.user_id)
    when Util::EVAL_ROLE
      EvalUser.add_user(self.user_id)
    when Util::SUBMIT_ROLE
      SubmitUser.add_user(self.user_id)
    else
      return false
    end
  end
  
end

