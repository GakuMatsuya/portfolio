# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.create!(
  email: "hoge-hoge@hoge.com", 
  password: "111111"
)

#商品に持たせるジャンル情報を、配列でまとめて作成
Genre.create!(
  [
    {name: "BEER"},
    {name: "WHISKY/WHISKEY"},
    {name: "WINE"},
    {name: "SAKE"},
    {name: "LIQUEUR"}
  ]
)

#管理者側の動作確認のため、テストユーザを作成。ユーザー登録機能実装後に削除
User.create!(
  email: "fuka510830@gmail.com",
  name: "ふーか",
  password: "19970616",
  introduction: "よろしくお願いします"
  )