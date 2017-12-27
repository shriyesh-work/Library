ThinkingSphinx::Index.define :book, with: :real_time do 
  indexes name
  indexes author
  indexes category.name, as: :category
  set_property :enable_star => 1
  set_property :min_infix_len => 3
end