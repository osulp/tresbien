# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

ExpenseType.create name: 'Above Per Diem'
Organization.create name: 'The Valley Library', organization_code: '112010', program_code: '30001', fund: '001100'
AccountCode.create name: 'Employee Domestic Travel', code: '39115'
AccountCode.create name: 'Employee International Travel', code: '39615'
AccountCode.create name: 'Non-employee Domestic Travel', code: '39117'
AccountCode.create name: 'Non-employee International Travel', code: '39645'
