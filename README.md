Verify Address, Plot Address, Render Custom Map with Custom CSS, Get Geocode, Get List Cites using Google Maps API in .NET

1. VerifyAddress(string Address)
==> returns ROOFTOP or APPROXIMATE from google and you have to resolve to TRUE or FALSE.

2. GetGeocode(string Address)
==> returns Geocode coordinates Longitude and Latitude

3. GetListCities(string Address)
==> you give it a value for example of
        "Los" - and it will return a list of valid cities that start with Los
        "Los A" - then it will return Los Angeles as a city
        google has an API that you give it a string and it returns a list of potential cities

4. Render()
==> render function does not need to have widht or height, if we put the function in Initialize.

5. Render(int width, int height)
==> and it will create the HTML that will display the Google map on an asp page

6. Initialize(string css, int width, int height)
==>  where  "css" is the location of hte css file that will be used to DECORATE the google map

If you want to combine them 4, 5 & 6 OR do same in one task i.e 7

7. Render(string css, int width, int height)

8. PlotAddress(float longitude, float latitude)
==>  THIS FUNCTION will put an icon on the map for that location.

9. PlotAddresses(string listLongLat)
==>  listLongLat = LONG,LAT|LONG2,LAT2|LONG3,LAT3     (separated by | each pair)