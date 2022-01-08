class Sample
  def initialize(count, volume, fields, id)
    @count = count
    @volume = volume
    @fields = fields
    @id = id
  end

  attr_accessor :count, :volume, :fields, :id

  def mm2
    (@count / (@fields * 0.00785)).round(3)
  end

  def cc
    (((@count / (@fields * 0.00785)) * 385) / (@volume * 1000)).round(3)
  end

  def print_simple

  end

  def print_full

  end

end

def print_sample(sample_ID, sample_list) #Method that prints a user selected entry from the sample_list array
  40.times {print "-"}
  puts "     \nSample #{sample_ID}"
  puts "     #{sample_list[sample_ID].count} fibers"
  puts "     #{sample_list[sample_ID].fields} fields"
  puts "     #{sample_list[sample_ID].volume} L"
  puts "     #{sample_list[sample_ID].mm2} f/mm2"
  puts "     #{sample_list[sample_ID].cc} f/cc"
  40.times {print "-"}
  puts
end

def print_all_samples(sample_list)          #Prints all the Sample instances in the sample_list array
  all_sample_count = 1                      #Needed to print the correct sample number in each entry
  sample_list.each {|sample|
    40.times {print "-"}
    puts "\nSample #{ sample.id }"
    puts "     #{sample.count} fibers"
    puts "     #{sample.fields} fields"
    puts "     #{sample.volume} L"
    puts "     #{sample.mm2} f/mm2"
    puts "     #{sample.cc} f/cc"
    40.times {print "-"}
    puts
    all_sample_count += 1
  }
end

sample_list = []                            #Initialize the array used to point to the Sample instances

loop do                                     #Main control flow loop
  system("clear")
  puts "What do you want to do? \n1. Enter Samples 2. Look Up Samples 3. Print All Samples  4. Quit"
  print "\n" + "Selection: "
  choice = gets.chomp.downcase


  if choice =~ /1/
    system("clear")
    entry_counter = 0                       #Re-sets the sample entry counter to zero
    sample_list = []                        #Re-assigns the Sample instance array to empty every time user enters data

    puts "Enter number of samples"
    sample_count = gets.chomp.to_i

    while entry_counter < sample_count do   #Control flow loop for sample entry. Will loop as many times as user specifies
                                            #Think about using instance write method to assign the values
      if entry_counter >= 1
        print "Samples: "
        sample_list.each {|sample| print "#{sample.id} "}
        puts
      end

      sample_list << Sample.new(0,0,0,0)    #Append the new Sample instance object to the sample_list array


      puts "Enter Sample ID"
      sample_list[entry_counter].id = gets.chomp
      puts "Enter fiber count"              #User input sent to setter methods for the current Sample instance in the sample array
      sample_list[entry_counter].count = gets.chomp.to_f
      puts "Enter number of fields"
      sample_list[entry_counter].fields = gets.chomp.to_i
      puts "Enter volume collected (L)"
      sample_list[entry_counter].volume = gets.chomp.to_i

      entry_counter += 1                  #Increment the counter
      system("clear")
    end
    puts "Press enter to return to main menu"
    gets.chomp
  elsif choice =~ /2/
    system("clear")
    if sample_list.any?                   #Check if sample array has any items in it
      60.times {print "#"}
      print "\nEnter sample number: "
      sample_lookup = gets.chomp.to_i
      p sample_list
      unless sample_list[sample_lookup]   #Check if the user entry points to a valid array index
        puts "Invalid Entry"
      else
        print_sample(sample_lookup, sample_list)
        2.times {puts}
        puts "Press enter to return to main menu"
        gets.chomp
      end
    else
      puts "\nNo samples found, press enter to continue"
      gets.chomp
      60.times {print "#"}
      2.times {puts}
    end
  elsif choice =~ /3/
    system("clear")
    if sample_list.any?                  #Check if sample array has any items in it
      60.times {print "#"}
      puts
      print_all_samples(sample_list)     #Pass the sample array as argument to the print_all_samples method
      puts "Press enter to return to main menu"
      gets.chomp
    else
      puts "\nNo samples found, press enter to continue"
      gets.chomp
      60.times {print "#"}
      2.times {puts}
    end
  elsif choice =~ /4/
    system("clear")
    break
  else
    system("clear")
    puts "\nInvalid Entry"
    puts
  end
end

#Potential additions:
#Check user input in the sample entry - give an error if entry is not integer or float. Tricky because gets() user input is string by default. This task requires use of Regexp.
#Convert print_sample and print_all_samples methods to class methods for Sample class. I don't want the instances to be able to call the method.
#Be able to store sample arrays in memory(a file) with user defined lookup key
#Use time objects to calculate sample time instead of figuring it out manually and entering it.
