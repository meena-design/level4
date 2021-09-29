require "date"
require "active_record"

class Todo < ActiveRecord::Base
  def due_today?
    due_date == Date.today
  end

  def self.overdue
    where("due_date < ?", Date.today)
  end

  def self.due_today
    where("due_date = ?", Date.today)
  end

  def self.due_later
    where("due_date > ?", Date.today)
  end

  def to_displayable_string
    display_status = completed ? "[X]" : "[ ]"
    display_date = due_today? ? nil : due_date
    "#{id}. #{display_status} #{todo_text} #{display_date}"
  end

  def self.show_list
    puts "My Todo-list\n\n"

    puts "Overdue\n"
    overdue.each do |todo|
            puts todo.to_displayable_string
    end
    puts "\n\n"

    puts "Due Today\n"

    due_today.each do |todo|
      puts todo.to_displayable_string
    end

    puts "\n\n"

    puts "Due Later\n"
    due_later.each do |todo|
      puts todo.to_displayable_string
    end


    puts "\n\n"
  end

  def self.add_task(h)
    create!(todo_text: h[:todo_text], due_date: Date.today + h[:due_in_days], completed: false)
  end

  def self.mark_as_complete(todo_id)
    record_mark_complete = Todo.find(todo_id)
    record_mark_complete.completed = true
    record_mark_complete.save
  end
end
