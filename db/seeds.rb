# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


Customer.create!(
    email: 'user@user.com',
    password: 'abc123',
    last_name: '太郎',
    first_name: '山田',
    last_name_easy: 'タロウ',
    first_name_easy: 'ヤマダ',
    postal_code: '1000014',
    address:  '東京都千代田区永田町1-7-1',
    phone_number: '08012345678',
    is_active: 'true',
)