user = User.where(email: "vidosrd@gmail.com").first_or_initialize
user.update!(
  password: "Kriger1977",
  password_confirmation: "Kriger1977"
)

#100.times do |i|
3.times do |i|
  #Novine.create(
    #title: Faker::Music.band,
    #title: Faker::Lorem.sentences(number: 1),
    #body: Faker::Lorem.paragraph(sentences_count: 5),
    #image: Faker::Avatar.image)
  #Article.create title: "Article #{i}", body: "Hello world"
  #BlogPost.create title: "Blog #{i}",
  Blog.create(
    #title: Faker::Lorem.sentences(number: 1),#Music.blog,
    #body: Faker::Lorem.paragraph(sentences_count: 5),
    category_id: 4
  #)
    #title: "Javascript #{i}",
    #body: "Hello world",
    #publish: Time.current,
    #category_id: 3
  )
end
