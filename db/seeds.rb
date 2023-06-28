# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
puts "destroying old data"
Dinosaur.destroy_all
Cage.destroy_all
Species.destroy_all
puts "generating data"
carnivores = ["Tyrannosaurus", "Velociraptor", "Spinosaurus", "Megalosaurus"]
carnivores.each do |species|
    species_db = Species.where(name: species, diet: "carnivore").first_or_create
    FactoryBot.create_list(:cage, 10, capacity: 20)
    FactoryBot.create_list(:dinosaur, 5, cage: Cage.order("RANDOM()").limit(1).first, species: species_db)
end

puts "carnivores done"

herbivores = ["Brachiosaurus", "Stegosaurus", "Ankylosaurus", "Triceratops"]
herbivores.each do |species|
    species_db = Species.where(name: species, diet: "herbivore").first_or_create
    FactoryBot.create_list(:cage, 10, capacity: 20)
    FactoryBot.create_list(:dinosaur, 5, cage: Cage.order("RANDOM()").limit(1).first, species: species_db)
end

puts "herbivores done"
