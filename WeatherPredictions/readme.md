# Weather Predictions

### Assumptions and comments
- In the spec 'latitude' was spelled as 'lattitude', this was corrected.
- The /:location_id/:date and /:postal_code/:date routes could eventually mix, when the 
  location IDs reach 4 digits, but there were no requirements for the ID to be of alphanumeric
  characters in the spec. Naturally in a real application, we would have had a different
  endpoint for the postal code, but we had to match the spec in this case.


### Installation instructions
- On setting up the environment run the following:
rake db:migrate
rake app:create_weather_stations # This will take a little while
rails s

- Wait for the server to parse the first measurements, then you can access the routes specified in the spec