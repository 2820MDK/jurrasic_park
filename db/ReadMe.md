# Basics
- Rails 7 Jurrasic Park Restful API Application (Postgres DB) with an Rspec Testing Suite

# Set Up Instructions
Run `bundle install` to install all the dependencies.

Then run `bundle exec rake db:create && bundle exec rake db:migrate` to run the migrations.

Then run `bundle exec rake db:seed` to give yourself a good amount of example data.

Finally run `bundle exec rails s` to start the server.

You may also run the test suite via `bundle exec rspec`.

# API
For each of Cages, Species, and Dinosaurs -> there are index, create, show, update, destroy action. 
These were done in a restful API way and will respond to JSON. I used JBuilder to build out my JSON Schema.

# Tasks Completed
- All requests should respond with the correct HTTP status codes and a response, if necessary, representing either the success or error conditions.
- Each dinosaur must have a name.
- Each dinosaur is considered an herbivore or a carnivore, depending on its species.
- Carnivores can only be in a cage with other dinosaurs of the same species.
- Each dinosaur must have a species (See enumerated list below, feel free to add others).
- Herbivores cannot be in the same cage as carnivores.
- Use Carnivore dinosaurs like Tyrannosaurus, Velociraptor, Spinosaurus and Megalosaurus.
- Use Herbivores like Brachiosaurus, Stegosaurus, Ankylosaurus and Triceratops.

Bonus
- Cages have a maximum capacity for how many dinosaurs it can hold.
- Cages know how many dinosaurs are contained.
- Cages have a power status of ACTIVE or DOWN.
- Cages cannot be powered off if they contain dinosaurs.
- Dinosaurs cannot be moved into a cage that is powered down.
- Must be able to query a listing of dinosaurs in a specific cage.
- When querying dinosaurs or cages they should be filterable on their attributes (Cages on their power status and dinosaurs on species).
- Automated tests that ensure the business logic implemented is correct.
