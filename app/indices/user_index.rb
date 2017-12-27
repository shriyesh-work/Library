ThinkingSphinx::Index.define :user, with: :real_time do 
  indexes firstname
  indexes lastname
  indexes username
  set_property :enable_star => 1
  set_property :min_infix_len => 3
end