<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true"
    CodeBehind="Render.aspx.cs" Inherits="WebGoogleMapsAPI.Render" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div>
        <br />
        <a href="Home.aspx">back to home</a>
        <br />
        <h1>Initialize/Render</h1>
        <span>It'll create the HTML map on the page. We can render with our custom css, height,
               width etc.</span>
        <br />
        <br />
        <div>
            <asp:TextBox ID="txtWidth" runat="server" Width="100" Height="25" ClientIDMode="Static"
                TextMode="Number" placeholder="Enter width (int)"></asp:TextBox>
            <asp:TextBox ID="txtHeight" runat="server" Width="100" Height="25" ClientIDMode="Static"
                TextMode="Number" placeholder="Enter height (int)"></asp:TextBox>
            <asp:CheckBox ID="chkStyled" runat="server" Text="Use custom styled map?" Checked="false"
                ClientIDMode="Static" />
            <asp:Button ID="btnRender" runat="server" Text="Render" Width="100" Height="30" OnClientClick="LoadCustomMap(); return false;" />
            <br />
            <br />
            <div id="googleMap" style="width: 100%; height: 250px; margin: 0 auto;">
            </div>
        </div>
    </div>
    <script type="text/javascript" src="http://maps.googleapis.com/maps/api/js"></script>
    <script type="text/javascript">
        var map;
        function InitializeMap() {
            var mapProp = {
                center: new google.maps.LatLng(51.508742, -0.120850),
                zoom: 10,
                mapTypeId: google.maps.MapTypeId.ROADMAP
            };
            map = new google.maps.Map(document.getElementById("googleMap"), mapProp);
            if (navigator.geolocation) {
                navigator.geolocation.getCurrentPosition(function (position) {
                    initialLocation = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);
                    map.setCenter(initialLocation);
                });
            }
        }
        google.maps.event.addDomListener(window, 'load', InitializeMap);

        function InitializeCustomStyledMap() {
            var styles = [
                {
                    featureType: 'water',
                    elementType: 'geometry.fill',
                    stylers: [
                        { color: '#adc9b8' }
                    ]
                }, {
                    featureType: 'landscape.natural',
                    elementType: 'all',
                    stylers: [
                        { hue: '#809f80' },
                        { lightness: -35 }
                    ]
                }
            ];

            var options = {
                mapTypeControlOptions: {
                    mapTypeIds: ['Styled']
                },
                center: new google.maps.LatLng(51.508742, -0.120850),
                zoom: 10,
                disableDefaultUI: true,
                mapTypeId: 'Styled'
            };
            var div = document.getElementById('googleMap');
            var map = new google.maps.Map(div, options);
            if (navigator.geolocation) {
                navigator.geolocation.getCurrentPosition(function (position) {
                    initialLocation = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);
                    map.setCenter(initialLocation);
                });
            }
            var styledMapType = new google.maps.StyledMapType(styles, { name: 'Styled' });
            map.mapTypes.set('Styled', styledMapType);
        }

        function LoadCustomMap() {
            var width = $('#txtWidth').val();
            var height = $('#txtHeight').val();
            $('div#googleMap').width(parseInt(width));
            $('div#googleMap').height(parseInt(height));
            //google.maps.event.trigger(map, "resize");
            if ($("#chkStyled").is(":checked")) {
                InitializeCustomStyledMap();
            } else {
                InitializeMap();
            }
        }
    </script>
</asp:Content>
