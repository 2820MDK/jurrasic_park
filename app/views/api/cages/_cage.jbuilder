json.id cage.id
json.name cage.name
json.capacity cage.capacity
json.has_power cage.has_power
json.dinosaurs do
    json.array! cage.dinosaurs do |dinosaur|
        json.partial! 'api/dinosaurs/dinosaur', dinosaur: dinosaur
    end
end
