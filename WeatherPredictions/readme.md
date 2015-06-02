# Weather Predictions

### Assumptions and comments
- In the spec 'latitude' was spelled as 'lattitude', this was corrected.
- The /:location_id/:date and /:postal_code/:date routes could eventually mix, when the 
  location IDs reach 4 digits, but there were no requirements for the ID to be of alphanumeric
  characters in the spec. Naturally in a real application, we would have had a different
  endpoint for the postal code, but we had to match the spec in this case.
- The 'Predict Weather' form uses the Google Geocoder API and accepts any query that would normally work in Google Maps, which means that a postal code query for "3000" will need to be more specific, e.g. "3000, VIC, Australia"

### Installation instructions
**When setting up the application run the following:**

    bundle install
    rake db:create
    rake db:migrate
    rake app:create_weather_stations -- This will take a little while
    rails s

**Wait for the server to parse the first measurements, then you can access the routes specified in the spec**

All HTML routes are avilable from "http://localhost:3000/weather/locations"