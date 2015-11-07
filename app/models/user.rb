class User < ActiveRecord::Base
  #VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_PHONE_REGEX = /\(?([0-9]{3})\)?([ .-]?)([0-9]{4})\2([0-9]{4})/

  #validates :login_id, length: { maximum: 50 }, presence: true, uniqueness: { case_sensitive: false },
  #          format: { with: VALID_EMAIL_REGEX, :message => "invalid e-mail address"}
  validates_uniqueness_of :login_id, :message => "login id is duplicated. choose another one."
  validates :password, length: { minimum: 4, :message => "4 <= password length" }
  validates_inclusion_of :sex, :in => %w(male female), :message => "neither male nor female? are you alien or what?"
  validates :cellphone, length: { maximum: 50 }, format: {with: VALID_PHONE_REGEX }
  validates_inclusion_of :user_type, :in => %w(admin eval submit), :message => "choose adequate role." # TODO : not admin role!

  before_create :admin_role_check
  before_create :create_user_id
  before_create :set_subclass

  def admin_role_check
  	if self.user_type == Util::ADMIN_ROLE && self.login_id != 'admin' then return false end
  end

  def create_user_id
    self.user_id = self.login_id + SecureRandom.urlsafe_base64(nil, false)
  end

  def set_subclass
  	puts case self.user_type
    when Util::ADMIN_ROLE
      return AdminUser.add_user(self.user_id)
    when Util::EVAL_ROLE
      return EvalUser.add_user(self.user_id)
    when Util::SUBMIT_ROLE
      return SubmitUser.add_user(self.user_id)
    else
      return false
    end
  end

  def auth(pw)
    return self.password == pw
  end
end

