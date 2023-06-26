json.array! @cages do |cage|
    json.partial! 'api/cages/cage', cage: cage
end