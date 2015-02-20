namespace :db do
  desc "Fill database with sample readers"
  task populate: :environment do
    Reader.create!(firstName:"first", lastName:"last", phoneNumber:"000000000", email:"first.last@gmail.com", schoolFallName:"School A", schoolFallGrade:"10", program:"teen", age:"12", tShirtSize:"XS")
    99.times do |n|
      firstName="first-#{n+1}"
      lastName="last-#{n+1}"
      if n<10
       phoneNumber="00000000#{n+1}"
      else
        phoneNumber="0000000#{n+1}"
      end
      email="#{firstName}.#{lastName}@gmail.com"
      schoolFallName="School A"
      schoolFallGrade="10"
      program="Teen program"
      age="12"
      tShirtSize="XS"
      
      Reader.create!(firstName:firstName, lastName:lastName, phoneNumber:phoneNumber, email:email,
       schoolFallName:schoolFallName, schoolFallGrade:schoolFallGrade, program:program, age:age, tShirtSize:tShirtSize)
  
    
    end
  end
end