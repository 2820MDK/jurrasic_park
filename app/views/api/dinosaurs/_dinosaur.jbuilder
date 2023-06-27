json.id dinosaur.id
json.name dinosaur.name
json.species do
  json.partial! 'api/species/species', species: dinosaur.species
end
json.cage dinosaur.cage.try(:name)
