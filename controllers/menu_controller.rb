 require_relative "../models/address_book"
 require_relative "../models/entry"

 class MenuController
   attr_accessor :address_book

   def initialize
     @address_book = AddressBook.new
   end

   def main_menu
     puts "Main Menu - #{@address_book.entries.count} entries"
     puts "1 - View all entries"
     puts "2 - Create an entry"
     puts "3 - Search for an entry"
     puts "4 - Import entries from a CSV"
     puts "5 - View Entry Number n"
     puts "6 - Exit"
     print "Enter your selection: "

     selection = gets.to_i
     puts "You picked #{selection}"

    case selection
      when 1
     	system "clear"
     	view_all_entries
     	main_menu
      when 2
      	system "clear"
      	create_entry
      	main_menu
  	  when 3
  	  	system "clear"
  	  	search_entries
  	  	main_menu
  	  when 4
  	  	system "clear"
  	  	read_csv
  	  	main_menu
  	  when 5
  	  	system "clear"
  	  	entry_number
  	  	main_menu
  	  when 6
  	  	puts "Goodbye!"

  	  	exit(0)

  	  else
  	  	system "clear"
  	  	puts "Sorry, that is not a valid input"
  	  	main_menu
  	  end
  	end

    def entry_submenu(entry)
      puts "\nn - Next Entry"
      puts "d - Delete Entry"
      puts "e - Edit this Entry"
      puts "m - Return to Main Menu"

      selection = $stdin.gets.chomp

      case selection
        when "n"
        when "d"
          delete_entry
        when "e"
          edit_entry(entry)
          entry_submenu(entry)
        when "m"
          system "clear"
          main_menu
        else
          system "clear"
          puts "#{selection} is not a valid input"
          entry_submenu(entry)
      end
    end

  	def view_all_entries
  	  @address_book.entries.each do
  	  system "clear"
  	  puts entry.to_s
      entry_submenu(entry)
  	  end

  	system "clear"
  	puts "End of Entries"
  	end

  	def create_entry
  	  system "clear"
  	  puts "New AddressBloc Entry"
  	  print "Name: "
  	  name = gets.chomp
  	  print "Phone Number: "
  	  phone = gets.chomp
  	  print "Email: "
  	  email = gets.chomp
  	  n = 0
  	  entry_number = n += 1

  	  @address_book.add_entry(name, phone, email)

  	  system "clear"
  	  puts "New entry created!"
  	end

    def search_entries
      print "Search by name: "
      name = gets.chomp
      match = @address_book.binary_search(name)
      system "clear"

      if match
        puts match.to_s
        search_submenu(match)
      else
        puts "No match found."
      end
    end

    def search_submenu(entry)
      puts "\nd - Delete this Entry"
      puts "e - Edit this Entry"
      puts "m - Return to Main Menu"

      selection = gets.chomp

      case selection
      when "d"
        system "clear"
        delete_entry(entry)
        main_menu
      when "e"
        edit_entry(entry)
        system "clear"
        main_menu
      when "m"
        system "clear"
        main_menu
      else
        system "clear"
        puts "#{selection} is not a valid input."
        puts entry.to_s
        search_submenu(entry)
      end
    end

  	def read_csv
      print "Enter CSV file to import: "
      file_name = gets.chomp

      if file_name.empty?
        system "clear"
        puts "No CSV file read"
        main_menu
      end

      begin
        entry_count = @address_book.import_from_csv(file_name)
        system "clear"
        puts "#{entry_count} new entries added from #{file_name}"

      rescue
        puts "#{file_name} is not a valid CSV file, please enter the name of a valid CSV file."
        read_csv
      end
  	end

  	def entry_submenu(entry)
  	  puts "n - next entry"
  	  puts "d - delete entry"
  	  puts "e - edit this entry"
  	  puts "m - return to main menu"

  	  selection = gets.chomp

  	  case selection
  	    when "n"
  	    when "d"
  	    when "e"
  	    when "m"
  	      system "clear"
  	      main_menu
  	    else
  	      system "clear"
  	      puts "#{selection} is not a valid input!"
  	      entries_submenu(entry)
  	  end
  	end

  	def entry_number(entry)
  	  system "clear"
  	  puts "Select an Entry Number"
  	  print "Entry #: "
  	  entry = gets.chomp
  	  entry.each do |num|
  	  	if num === n
  	  		system "clear"
  	  		entry_submenu(entry)
  	  	else
  	  	  system "clear"
  	  	  puts "#{entry} is not a valid input!"
  	  	  entries_submenu(entry)
  	  	end
  	  end
  	end

    def delete_entry(entry)
      @address_book.entries.delete(entry)
      puts "#{entry_name} has been deleted"
    end

    def edit(entry)
      print "Updated name: "
      name = gets.chomp
      print "Updated phone number: "
      phone_number = gets.chomp
      print "Updated Email: "
      email = gets.chomp

      entry.name = name if !name.empty?
      entry.phone_number = phone_number if !phone_number.empty?
      entry.email = email if !email.empty?
      system "clear"
      puts "Updated entry!"
      puts entry
    end
  end
