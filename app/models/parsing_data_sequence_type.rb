class ParsingDataSequenceType < ActiveRecord::Base
  validates_numericality_of :null_ratio, :greater_than_or_equal_to => 0.0, :less_than_or_equal_to => 1.0, :message => "invalid null ratio"
  validates_numericality_of :total_tuple_num, :greater_than_or_equal_to => 0, :message => "invalid tuple count"
  validates_numericality_of :dup_tuple_num, :greater_than_or_equal_to => 0, :message => "invalid tuple count"
end
