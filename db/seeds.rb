# db/seeds.rb

puts "Nettoyage de la base de données..."
Flat.destroy_all

puts "Création de 30 appartements avec descriptions HTML 100% aléatoires..."

unsplash_ids = [
  "1564013799919-ab600027ffc6", "1512917774080-9991f1c4c750", "1600585154340-be6161a56a0c",
  "1600596542815-ffad4c1539a9", "1600607687939-ce8a6c25118c", "1600210492486-724fe5c67fb0",
  "1600566753376-12c8ab7fb75b", "1580587771525-78b9dba3b914", "1513694203232-719a280e022f",
  "1484154218962-a197022b5858", "1502672260266-1c1ef2d93688", "1522708323590-d24dbb6b0267",
  "1560448204-e02f11c3d0e2", "1502005229762-fc1b2b812ca5", "1493809842364-78817add7ffb",
  "1545324418-cc1a3fa10c00", "1585412727339-54e4bae3bbf9", "1537726235470-8504e3beef77",
  "1505691938895-1758d7feb511", "1554995207-c18c203602cb", "1568605114967-8130f3a36994",
  "1570129477492-45c003edd2be", "1605276374104-dee2a0ed3cd6", "1598228723793-52759bba2457",
  "1512915922686-57c11dde9b6b", "1613490493576-7fde63acd811", "1613977257363-707ba9348227",
  "1516455590571-18256e5bb9ff", "1507089947368-19c1da9775ae", "1602941525421-8f8b81d3edbb"
]

30.times do |i|
  adjectives = [ "Magnifique", "Superbe", "Charmant", "Cosy", "Grand", "Chaleureux", "Moderne" ]
  home_types = [ "Studio", "Appartement", "Loft", "Duplex", "Penthouse", "Maison de ville", "Villa" ]
  name = "#{adjectives.sample} #{home_types.sample} au cœur de #{Faker::Address.city}"

  # On pioche un ID dans notre liste (on utilise le modulo pour être sûr de ne pas déborder si on change le nombre)
  photo_id = unsplash_ids[i % unsplash_ids.length]

  # Construction de l'URL officielle robuste
  image_url = "https://images.unsplash.com/photo-#{photo_id}?auto=format&fit=crop&w=1200&q=80"

  # 1. On génère plusieurs paragraphes de texte aléatoire sous forme de tableau
  paragraphs = Faker::Lorem.paragraphs(number: 3)

  # 2. On génère 3 mots-clés aléatoires pour la liste à puces
  features = Faker::Lorem.words(number: 3)

  # 3. On assemble le tout dynamiquement dans un bloc HTML
  html_description = <<~HTML
    <p>#{paragraphs[0]}</p>

    <p><strong>#{Faker::Company.bs.capitalize}</strong>. #{paragraphs[1]}</p>

    <ul>
      <li>✨ #{features[0].capitalize}</li>
      <li>🚀 #{features[1].capitalize}</li>
      <li>🏡 #{features[2].capitalize}</li>
    </ul>

    <p>#{paragraphs[2]}</p>
  HTML

  Flat.create!(
    name: name,
    address: Faker::Address.full_address,
    description: html_description,
    price_per_night: rand(45..250),
    number_of_guests: rand(1..6),
    picture_url: image_url
  )
end

puts "Terminé ! 30 appartements uniques créés."
