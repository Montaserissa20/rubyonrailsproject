# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
u1 = User.create!(name: "Alice", email: "alice@example.com", password: "secret", password_confirmation: "secret")
u2 = User.create!(name: "Bob",   email: "bob@example.com",   password: "secret", password_confirmation: "secret")

a1 = Article.create!(title: "Rails API Nedir?", body: "JSON üreten Rails uygulaması...", user: u1)
a2 = Article.create!(title: "Active Record İlişkileri", body: "belongs_to, has_many...", user: u2)

t1 = Tag.create!(name: "rails")
t2 = Tag.create!(name: "api")
t3 = Tag.create!(name: "backend")

a1.tags << [t1, t2]
a2.tags << [t1, t3]

Comment.create!(body: "Harika yazı!", user: u2, article: a1)
Comment.create!(body: "Teşekkürler!", user: u1, article: a2)
