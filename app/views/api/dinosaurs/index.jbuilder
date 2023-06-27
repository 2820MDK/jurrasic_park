json.array! @dinosaurs do |dinosaur|
  json.partial! 'api/dinosaurs/dinosaur', dinosaur: dinosaur
end
