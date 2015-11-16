class User < ActiveRecord::Base
  #VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_PHONE_REGEX = /\(?([0-9]{3})\)?([ .-]?)([0-9]{4})\2([0-9]{4})/

  #validates :login_id, length: { maximum: 50 }, presence: true, uniqueness: { case_sensitive: false },
  #          format: { with: VALID_EMAIL_REGEX, :message => "invalid e-mail address"}
  validates_uniqueness_of :login_id, :message => "login id is duplicated. choose another one."
  validates :password, length: { minimum: 4, :message => "4 <= password length" }
  validates_inclusion_of :sex, :in => %w(male female), :message => "neither male nor female? are you alien or what?"
  validates :cellphone, length: { maximum: 50 }, format: {with: VALID_PHONE_REGEX }

  before_create :admin_role_check
  before_create :set_subclass

  def admin_role_check
    if self.is_admin && self.login_id != 'admin' then return false end
  end

  def set_subclass
    if self.is_admin
      return AdminUser.add_user(self.user_id)
    elsif self.is_eval
      return EvalUser.add_user(self.user_id)
    elsif self.is_submit
      return SubmitUser.add_user(self.user_id)
    else
      return false
    end
  end

  def self.update_user(user_params)
    temp_user = find(user_params[:user_id])
    return temp_user.update_attributes(user_params)
  end

  def auth(pw)
    return self.password == pw
  end

  def self.is_admin()
    return AdminUser.find_by(:user_id => self.user_id).exists?
  end
end

