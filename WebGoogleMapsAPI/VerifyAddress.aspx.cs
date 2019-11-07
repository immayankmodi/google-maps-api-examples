using System;
using WebGoogleMapsAPI.Classes;

namespace WebGoogleMapsAPI {

    public partial class VerifyAddress : System.Web.UI.Page {
    
        GoogleMapHelper googleMapHelper = new GoogleMapHelper();
        
        protected void Page_Load(object sender, EventArgs e) {

        }

        protected void btnVerify_Click(object sender, EventArgs e) {
            var address = txtAddress.Text.Trim();
            var kvpStatus = googleMapHelper.VerifyAddress(address);
            if (kvpStatus != null && kvpStatus[0].Key == "TRUE") {
                lblMsg.Text = kvpStatus[0].Value;
            } else if (kvpStatus != null && kvpStatus[0].Key == "FALSE") {
                lblMsg.Text = kvpStatus[0].Value;
            }
        }
    }
}