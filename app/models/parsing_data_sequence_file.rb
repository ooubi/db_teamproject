class ParsingDataSequenceFile < ActiveRecord::Base
  validates_numericality_of :null_ratio, inclusion: { :greater_than_or_equal_to => 0.0, :less_than_or_equal_to => 1.0, :message => "invalid null ratio"}
  validates_numericality_of :total_tuple_num, inclusion: { :greater_than_or_equal_to => 0, :message => "invalid tuple count"}
  validates_numericality_of :dup_tuple_num, inclusion: { :greater_than_or_equal_to => 0, :message => "invalid tuple count"}

  def self.change_score(pdsf_id, score)
  	pdsf = find_by(:pdsf_id => pdsf_id)
  	pdsf.score = score
  	return pdsf.save!
  end

  def self.get_user_infos(pdsf_id)
  	convert = Convert.find_by(:pdsf_id => pdsf_id)
  	unless convert.nil?
  	  submit = Submit.find_by(:odf_id => convert.odf_id)
  	  unless submit.nil?
  	  	user = User.find_by(:user_id => submit.user_id)
  	  	unless user.nil?
  	  	  return user.user_id, user.name
  	  	end
  	  end
  	end
  	return nil, nil
  end

  def self.get_task_id(pdsf_id)
  	convert = Convert.find_by(:pdsf_id => pdsf_id)
  	unless convert.nil?
  	  implement_odt = ImplementOdt.find_by(:odf_id => convert.odf_id)
  	  unless implement_odt.nil?
  	  	specify = Specify.find_by(:odt_id => implement_odt.odt_id)
  	  	unless specify.nil?
  	  	  return specify.task_id
  	  	end
  	  end
  	end
  	return nil
  end

  def self.get_rows(pdsf_id)
  	pdsf = find_by(:pdsf_id => pdsf_id)
  	unless pdsf.nil?
  	  lines = [pdsf.file].pack("b*").split('\n') 
  	  if lines.size >= 1
  	  	return lines[1...lines.size]
  	  else
  	  	return []
  	  end
  	end
  	return nil
  end

end
