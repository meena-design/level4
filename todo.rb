require "date"
require "active_record"
# this code to be modified ..
# need to add show list , add task , mark as complete methods and self for overdue , due today and due later

class Todo < ActiveRecord ::Base
  def initialize(text, due, complete)
    @text = text
    @due_date = due
    @complete = complete
  end

  def due_today?
    @due_date == Date.today
  end

  def overdue?
    @due_date < Date.today
  end

  def due_later?
    @due_date > Date.today
  end

  def self.overdue
    Todo.where("due_date<?", Date.today)
  end
  def self.due_today
    Todo.where("due_date=?", Date.today)
  end
  def self.due_later
    Todo.where("due_date>?", Date.today)
  end

  def to_displayable_string
    display_status = @complete ? "[X]" : "[ ]"
    display_date = due_today? ? nil : @due_date
    "#{display_status} #{@text} #{display_date}"
  end
end

def self.show_list
  puts "My Todo-list\n\n"

  puts "Overdue\n"
  puts todos_list.overdue.to_displayable_string
  puts "\n\n"

  puts "Due Today\n"
  puts todos_list.due_today.to_displayable_string
  puts "\n\n"

  puts "Due Later\n"
  puts todos_list.due_later.to_displayable_string
  puts "\n\n"
end

def self.add_task(h)
  Todo.create!(todo_text: h[:todo_text], due_date: Date.today + h[:due_in_days], completed: false)
end

def self.mark_as_complete(todo_id)
  record_mark_complete = Todo.find(todo_id)
  record_mark_complete.completed = true
  record_mark_complete.save
end
