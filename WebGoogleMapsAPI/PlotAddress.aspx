<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true"
    CodeBehind="PlotAddress.aspx.cs" Inherits="WebGoogleMapsAPI.PlotAddress" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div>
        <br />
        <a href="Home.aspx">back to home</a>
        <br />
        <h1>PlotAddress/PlotAddresses (with location markers)</h1>
        <span>It'll create red marker on specified location. Provide multiple list of location
               to create muliple markers on the map.</span>
        <br />
        <br />
        <div>
            <%--<asp:TextBox ID="txtWidth" runat="server" Width="100" Height="25" ClientIDMode="Static"
                    TextMode="Number" placeholder="Enter width (int)"></asp:TextBox>
               <asp:TextBox ID="txtHeight" runat="server" Width="100" Height="25" ClientIDMode="Static"
                    TextMode="Number" placeholder="Enter height (int)"></asp:TextBox>--%>
            <asp:CheckBox ID="chkStyled" runat="server" Text="Use multiple markers for multiple locations?"
                Checked="false" ClientIDMode="Static" />
            <asp:Button ID="btnRender" runat="server" Text="Render" Width="100" Height="30" OnClientClick="LoadMapWithMultipleMarkers(); return false;" />
            <br />
            <br />
            <div id="googleMap" style="width: 100%; height: 350px; margin: 0 auto;">
            </div>
        </div>
    </div>
    <script type="text/javascript" src="http://maps.googleapis.com/maps/api/js"></script>
    <script type="text/javascript">
        var map;
        function InitializeMap() {
            var myLatlng = new google.maps.LatLng(-25.363, 131.044);
            var mapProp = {
                center: myLatlng,
                zoom: 10,
                mapTypeId: google.maps.MapTypeId.ROADMAP
            };
            map = new google.maps.Map(document.getElementById("googleMap"), mapProp);

            var contentString = '<div id="content">' +
                '<div id="siteNotice">' +
                '</div>' +
                '<h1 id="firstHeading" class="firstHeading">Uluru</h1>' +
                '<div id="bodyContent">' +
                '<p><b>Uluru</b>, also referred to as <b>Ayers Rock</b>, is a large ' +
                'sandstone rock formation in the southern part of the ' +
                'Northern Territory, central Australia. It lies 335&#160;km (208&#160;mi) ' +
                'south west of the nearest large town, Alice Springs; 450&#160;km ' +
                '(280&#160;mi) by road. Kata Tjuta and Uluru are the two major ' +
                'features of the Uluru - Kata Tjuta National Park. Uluru is ' +
                'sacred to the Pitjantjatjara and Yankunytjatjara, the ' +
                'Aboriginal people of the area. It has many springs, waterholes, ' +
                'rock caves and ancient paintings. Uluru is listed as a World ' +
                'Heritage Site.</p>' +
                '<p>Attribution: Uluru, <a href="https://en.wikipedia.org/w/index.php?title=Uluru&oldid=297882194">' +
                'https://en.wikipedia.org/w/index.php?title=Uluru</a> ' +
                '(last visited June 22, 2009).</p>' +
                '</div>' +
                '</div>';

            var infowindow = new google.maps.InfoWindow({
                content: contentString
            });

            var marker = new google.maps.Marker({
                position: myLatlng,
                map: map,
                title: "Test Marker on My Location"
            });

            marker.addListener('click', function () {
                infowindow.open(map, marker);
            });
        }
        google.maps.event.addDomListener(window, 'load', InitializeMap);
    </script>
    <script src="Script/mapwithmarker.js" type="text/javascript"></script>
    <script type="text/javascript">
        function LoadMapWithMultipleMarkers() {
            //http://www.dotnetbull.com/2013/06/multiple-marker-with-labels-in-google.html
            var markers = [
                {
                    "title": 'Gombak Setia',
                    "lat": '3.218937',
                    "lng": '101.7167931',
                    "description": 'Gombak Setia, Kuala Lumpur, Wilayah Persekutuan Kuala Lumpur, 53100'
                },
                {
                    "title": 'Jalan Desa Melawati',
                    "lat": '3.2331742',
                    "lng": '101.7061447',
                    "description": 'Jalan Desa Melawati, Kuala Lumpur, Wilayah Persekutuan Kuala Lumpur, 53100'
                },
                {
                    "title": 'Jalan Intan (Gombak)',
                    "lat": '3.22317',
                    "lng": '101.71588',
                    "description": 'Jalan Intan (Gombak), Kuala Lumpur, Wilayah Persekutuan Kuala Lumpur, 53100'
                },
                {
                    "title": 'Jalan Madrasah',
                    "lat": '3.218515',
                    "lng": '101.717801',
                    "description": 'Jalan Madrasah, Kuala Lumpur, Wilayah Persekutuan Kuala Lumpur, 53100'
                }
            ];

            var myLatlng = new google.maps.LatLng(markers[0].lat, markers[0].lng);
            var mapProp = {
                center: myLatlng,
                zoom: 13,
                mapTypeId: google.maps.MapTypeId.ROADMAP
            };
            map = new google.maps.Map(document.getElementById("googleMap"), mapProp);

            var infoWindow = new google.maps.InfoWindow();
            for (i = 1; i <= markers.length; i++) {
                var letter = String.fromCharCode("A".charCodeAt(0) + i - 1);
                var data = markers[i - 1]
                var myLatlng = new google.maps.LatLng(data.lat, data.lng);

                var marker = new google.maps.Marker({
                    position: myLatlng,
                    map: map,
                    title: data.title,
                    icon: "http://maps.google.com/mapfiles/marker" + letter + ".png"
                });

                (function (marker, data) {
                    google.maps.event.addListener(marker, "click", function (e) {
                        infoWindow.setContent(data.description);
                        infoWindow.open(map, marker);
                    });
                })(marker, data);
            }
        }
    </script>
</asp:Content>
