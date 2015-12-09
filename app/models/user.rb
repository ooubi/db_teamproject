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
  after_save :set_subclass

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

  def self.update_score(user_id, score, pdsf_id, is_passed)
    adv = 10
    disadv = 5
    null_ratio_threshold = 0.2
    dup_ratio_threshold = 0.5
    user = find_by(:user_id => user_id)
    score = user.score
    if is_passed
      dup_ratio, avg_null_ratio = ParsingDataSequenceFile.get_summary_ratios(pdsf_id)
      if avg_null_ratio >= null_ratio_threshold || dup_ratio >= dup_ratio_threshold
        score -= disadv
      end
      score += adv
      return user.update_attributes(:score => score)
    else 
      score -= disadv 
      return user.update_attributes(:score => score)
    end
  end

  def self.get_user_all_infos(user_search)
    if user_search != nil
      @user_all_infos = get_category_all_infos(user_search[:search_category], user_search[:search_content])
    else
      @user_all_infos = all
    end
  end

  def auth(pw)
    return self.password == pw
  end

  def self.is_admin()
    return AdminUser.find_by(:user_id => self.user_id).exists?
  end

  private
    def self.get_category_all_infos(search_category, search_content)
      puts case search_category
      when 'role'
        return get_role_all_infos(search_content)
      when 'age'
        return get_age_all_infos(search_content)
      when 'sex'
        return where(:sex => search_content)
      when 'task'
        return get_task_all_infos(search_content)
      when 'id'
        return where(:login_id => search_content)
      else
        return nil
      end
    end

    def self.get_role_all_infos(search_content)
      puts case search_content
      when 'admin'
        return where(:is_admin => true)
      when 'eval'
        return where(:is_eval => true)
      when 'submit'
        return where(:is_submit => true)
      else
        return nil
      end
    end

    def self.get_age_all_infos(search_content)
      begin
        age_all_infos = []
          for u in all
            if is_in_age(u.birthdate, search_content.to_i)
              age_all_infos << u
            end
          end
        return age_all_infos
      rescue ArgumentError
        return nil
      end
    end

    def self.get_task_all_infos(search_content)
      begin
        user_infos = []
        participates = Participate.where(:task_id => search_content.to_i)
        if participates != nil
          for participate in participates
            user_infos << find_by(:user_id => participate.user_id)
          end
        end
        return user_infos
      rescue ArgumentError
        return nil
      end      
    end

    def self.is_in_age(dob, target_age)
      current_year = (Time.now.strftime "%Y").to_i
      age = current_year - dob.year + 1
      return age / 10 == target_age / 10
    end
end

