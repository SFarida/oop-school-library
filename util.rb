module Utilities
  def save_student(id, age, name, has_parent_permission)
    File.open('persons.txt', 'a') do |f|
      f.write "{\"id\": \"#{id}\", \"age\": \"#{age}\", \"has_parent_permission\": \"#{has_parent_permission}\"," \
              "\"name\": \"#{name}\", \"type\": \"student\"} \n"
    end
  end

  def save_teacher(id, age, name, specialization)
    File.open('persons.txt', 'a') do |f|
      f.write "{\"id\": \"#{id}\", \"age\": \"#{age}\", \"specialization\": \"#{specialization}\",  " \
              "\"name\": \"#{name}\", \"type\": \"teacher\"} \n"
    end
  end

  def save_rental(date, person_id, book_title)
    File.open('rentals.txt', 'a') do |f|
      f.write "{\"date\": \"#{date}\", \"person_id\": \"#{person_id}\", \"book_title\": \"#{book_title}\"} \n"
    end
  end
end
