<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true"
    CodeBehind="Home.aspx.cs" Inherits="WebGoogleMapsAPI.Home" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div>
        <h1>Google Maps API Functions</h1>
        <br />
        <div>
            <ul>
                <li><a href="VerifyAddress.aspx">Verify Address</a></li>
                <li><a href="GetGeocode.aspx">Get Geocode</a></li>
                <li><a href="GetListCities.aspx">Get List Cities/Places Autocomplete</a></li>
                <li><a href="Render.aspx">Initialize/Render</a></li>
                <li><a href="PlotAddress.aspx">PlotAddress/PlotAddresses (with location markers)</a></li>
            </ul>
        </div>
    </div>
    <script src="http://maps.google.com/maps/api/js?sensor=false" type="text/javascript"></script>
    <script src="Script/GoogleMapsWrapper.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            var isValid = GoogleMaps.VerifyAddress("122 Flinders St, Darlinghurst, NSW, Australia");
            console.log(isValid);
        });
    </script>
</asp:Content>
