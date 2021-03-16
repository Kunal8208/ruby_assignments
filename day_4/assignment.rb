module Crud

  def displayMenu
    print "1. Insert \n2. Update \n3. Delete \n4. Display \n5. Exit \n     Enter your choice:  "
  end

  def insert(array)
    array << self.accept
  end

  def update(array, userid)
    record = array.select{|hash| hash["id"] == userid}
    record[0].each do |k,v|
      puts "#{k} => #{v}"
      print "Update ? (Y/N): "
      case gets.chomp
      when 'Y'||'y'
        print "Enter new value for #{k}: "
        record[0][k]=gets.chomp
        puts "Value of #{k} updated to #{v}...."
      end
    end
    puts "Updated Record is :: #{record}"
  end

  def delete(array, userid)
    array.delete_if{|hash| hash["id"] == userid}
  end

  def retrieve(array)
    array.each{|hash| puts hash}
  end

end



class User
  attr_accessor :id, :name, :age
  
  include Crud

  def accept
    userHash=Hash.new
    print "Enter id: "
    userHash["id"] = gets.chomp.to_i
    print "Enter Name: "
    userHash["name"] = gets.chomp
    print "Enter Age: "
    userHash["age"] = gets.chomp.to_i
    return userHash
  end

end

class Address
  attr_accessor :user, :city, :state, :pin
  
  include Crud
  
  def accept
    addressHash=Hash.new
    print "Enter User Id: "
    addressHash["userid"] = gets.chomp
    print "Enter city: "
    addressHash["city"] = gets.chomp
    print "Enter state: "
    addressHash["state"] = gets.chomp
    print "Enter pin Code: "
    addressHash["pin"] = gets.chomp
    return addressHash
  end
end

class Main
  user_arr=Array.new
  address_arr=Array.new

  extend Crud

  while 1
    print "\n\n1. User \n2. Address \n3. Exit \n     Enter your choice:  "
    case gets.chomp.to_i
    when 1
      displayMenu
      case gets.chomp.to_i
        when 1
          u = User.new
          u.insert(user_arr)
        when 2
          print "Enter user id: "
          update(user_arr, gets.chomp.to_i)
        when 3
          print "Enter user id: "
          delete(user_arr, gets.chomp.to_i)
        when 4
          retrieve(user_arr)
        when 5
          break
      end
    when 2
      displayMenu
      case gets.chomp.to_i
        when 1
          a=Address.new
          a.insert(address_arr)
        when 2
          print "Enter user id: "
          update(address_arr, gets.chomp.to_i)
        when 3
          print "Enter user id: "
          delete(address_arr, gets.chomp.to_i)
        when 4
          retrieve(address_arr)
        when 5
          break
      end

    when 3
      break
    end
  end

end
