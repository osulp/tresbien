# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

attributes = [{ name: 'Above Per Diem'}]
attributes.each do |attrs|
  ExpenseType.where(attrs).first_or_create
end

attributes = [{ name: 'The Valley Library', organization_code: '112010', program_code: '30001', fund: '001100', vendor_payment_address: 'VP/1'}]
attributes.each do |attrs|
  Organization.create(attrs) unless Organization.exists?(name: attrs[:name])
end

attributes = [
  { name: 'Employee Domestic Travel', code: '39115'} ,
  { name: 'Employee International Travel', code: '39615'} ,
  { name: 'Non-Employee Domestic Travel', code: '39117'} ,
  { name: 'Non-Employee International Travel', code: '39645'}
]
attributes.each do |attrs|
  AccountCode.create(attrs) unless AccountCode.exists?(name: attrs[:name])
end

attributes = [
  { name: 'Mileage Rate', value: '0.535'},
  { name: 'Contact Email', value: 'don.frier@oregonstate.edu'}
]
attributes.each do |attrs|
  ApplicationConfiguration.create(attrs) unless ApplicationConfiguration.exists?(name: attrs[:name])
end
