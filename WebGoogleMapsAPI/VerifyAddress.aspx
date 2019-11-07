<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true"
    CodeBehind="VerifyAddress.aspx.cs" Inherits="WebGoogleMapsAPI.VerifyAddress" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div>
        <br />
        <a href="Home.aspx">back to home</a>
        <br />
        <h1>Verify Address</h1>
        <span>It'll return TRUE if location type is ROOFTOP or RANGE_INTERPOLATED from google
               else FALSE.</span>
        <br />
        <br />
        <br />
        <br />
        <div>
            <asp:TextBox ID="txtAddress" runat="server" Width="300" Height="25" placeholder="Enter your address"></asp:TextBox>
            <asp:Button ID="btnVerify" runat="server" Text="Verify" Width="100" Height="30" OnClick="btnVerify_Click" />
            <br />
            <br />
            <asp:Label ID="lblMsg" runat="server" Font-Bold="true"></asp:Label>
        </div>
    </div>
</asp:Content>
