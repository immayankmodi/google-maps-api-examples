<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true"
    CodeBehind="GetListCities.aspx.cs" Inherits="WebGoogleMapsAPI.GetListCities" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div>
        <br />
        <a href="Home.aspx">back to home</a>
        <br />
        <h1>Get List Cities/Places Autocomplete</h1>
        <span>It'll shows place autocomplete.</span>
        <br />
        <br />
        <div>
            <input id="pac-input" class="controls" type="text" placeholder="Enter a location" />
            <div id="type-selector" class="controls">
                <input type="radio" name="type" id="changetype-all" checked="checked" />
                <label for="changetype-all">
                    All</label>
                <input type="radio" name="type" id="changetype-establishment" />
                <label for="changetype-establishment">
                    Establishments</label>
                <input type="radio" name="type" id="changetype-address" />
                <label for="changetype-address">
                    Addresses</label>
                <input type="radio" name="type" id="changetype-geocode" />
                <label for="changetype-geocode">
                    Geocodes</label>
            </div>
            <div id="map" style="width: 100%; height: 400px; margin: 0 auto;">
            </div>
        </div>
    </div>
    <script type="text/javascript">
        function initMap() {
            var map = new google.maps.Map(document.getElementById('map'), {
                center: { lat: -25.363, lng: 131.044 },
                zoom: 13
            });
            var input = /** @type {!HTMLInputElement} */(document.getElementById('pac-input'));

            var types = document.getElementById('type-selector');
            map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);
            map.controls[google.maps.ControlPosition.TOP_LEFT].push(types);

            var autocomplete = new google.maps.places.Autocomplete(input);
            autocomplete.bindTo('bounds', map);

            var infowindow = new google.maps.InfoWindow();
            var marker = new google.maps.Marker({
                map: map,
                anchorPoint: new google.maps.Point(0, -29)
            });

            autocomplete.addListener('place_changed', function () {
                infowindow.close();
                marker.setVisible(false);
                var place = autocomplete.getPlace();
                if (!place.geometry) {
                    window.alert("Autocomplete's returned place contains no geometry");
                    return;
                }

                // If the place has a geometry, then present it on a map.
                if (place.geometry.viewport) {
                    map.fitBounds(place.geometry.viewport);
                } else {
                    map.setCenter(place.geometry.location);
                    map.setZoom(17);  // Why 17? Because it looks good.
                }
                marker.setIcon(/** @type {google.maps.Icon} */({
                    url: place.icon,
                    size: new google.maps.Size(71, 71),
                    origin: new google.maps.Point(0, 0),
                    anchor: new google.maps.Point(17, 34),
                    scaledSize: new google.maps.Size(35, 35)
                }));
                marker.setPosition(place.geometry.location);
                marker.setVisible(true);

                var address = '';
                if (place.address_components) {
                    address = [
                        (place.address_components[0] && place.address_components[0].short_name || ''),
                        (place.address_components[1] && place.address_components[1].short_name || ''),
                        (place.address_components[2] && place.address_components[2].short_name || '')
                    ].join(' ');
                }

                infowindow.setContent('<div><strong>' + place.name + '</strong><br>' + address);
                infowindow.open(map, marker);
            });

            // Sets a listener on a radio button to change the filter type on Places
            // Autocomplete.
            function setupClickListener(id, types) {
                var radioButton = document.getElementById(id);
                radioButton.addEventListener('click', function () {
                    autocomplete.setTypes(types);
                });
            }

            setupClickListener('changetype-all', []);
            setupClickListener('changetype-address', ['address']);
            setupClickListener('changetype-establishment', ['establishment']);
            setupClickListener('changetype-geocode', ['geocode']);
        }
    </script>
    <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?signed_in=true&libraries=places&callback=initMap"
        async defer></script>
</asp:Content>
