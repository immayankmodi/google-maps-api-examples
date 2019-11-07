/**
Google Map Wrapper
**/
GoogleMaps = {
    _map: document.getElementById('map'),
    VerifyAddress: function (address) {
        //this._map.innerText = address;
        var isValid = false;
        if (address.length == 0) {
            return false;
        }
        address = address.replace(/\n/g, "");
        var geo = new google.maps.Geocoder();
        geo.geocode({ 'address': address }, function (results, status) {
            //console.log(results);
            if (status == google.maps.GeocoderStatus.OK) {
                console.log(results[0].geometry.location_type);
                var location_type = results[0].geometry.location_type.toUpperCase();
                if ((location_type == "ROOFTOP") || (location_type == "RANGE_INTERPOLATED")) {
                    console.log(true);
                    isValid = true;
                } else {
                    console.log(false);
                    isValid = false;
                }
            }
        });
        return isValid;
    }
}

