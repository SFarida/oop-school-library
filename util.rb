module Utilities
  def save_student(id, age, name, has_parent_permission)
    File.open('persons.json', 'a') do |f|
      f.write "{\"id\": \"#{id}\", \"age\": \"#{age}\", \"has_parent_permission\": \"#{has_parent_permission}\"," \
              "\"name\": \"#{name}\", \"type\": \"student\"} \n"
    end
  end

  def save_teacher(id, age, name, specialization)
    File.open('persons.json', 'a') do |f|
      f.write "{\"id\": \"#{id}\", \"age\": \"#{age}\", \"specialization\": \"#{specialization}\",  " \
              "\"name\": \"#{name}\", \"type\": \"teacher\"} \n"
    end
  end

  def save_rental(date, person_id, book_title)
    File.open('rentals.json', 'a') do |f|
      f.write "{\"date\": \"#{date}\", \"person_id\": \"#{person_id}\", \"book_title\": \"#{book_title}\"} \n"
    end
  end

  def save_book(title, author)
    File.open('books.json', 'a') do |f|
      f.write "{ \"title\": \"#{title}\", \"author\": \"#{author}\"} \n"
    end
  end
end
