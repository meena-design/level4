require "./connect_db.rb"
require "./todo.rb"
connect_db!
Todo.show_list
# the above line to be activated the below lines should be removed here
#displayable_list = Todo.all.map {|todo| todo.to_displayable_string }
#puts displayable_list
