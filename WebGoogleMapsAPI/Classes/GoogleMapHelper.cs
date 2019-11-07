using System;
using System.Collections.Generic;
using System.Xml.Linq;
using System.Net;

namespace WebGoogleMapsAPI.Classes {

    public class GoogleMapHelper {

        private static string apiKey = "YOUR_API_KEY";
        private static string addressAPI = "https://maps.googleapis.com/maps/api/geocode/xml?address={0}&key=" + apiKey  + "&sensor=false";

        public XElement GetGoogleMapsAPIResponse(string requestUri) {
            XElement resGeocode = null;

            try {
                var request = WebRequest.Create(requestUri);
                var response = request.GetResponse();
                var xdoc = XDocument.Load(response.GetResponseStream());
                resGeocode = xdoc.Element("GeocodeResponse").Element("result");
            } catch (Exception ex) {
                string error = ex.Message;
            }

            return resGeocode;
        }

        public List<KeyValuePair<string, string>> VerifyAddress(string address) {
            List<KeyValuePair<string, string>> kvpStatus = new List<KeyValuePair<string, string>>();

            try {
                string requestUri = string.Format(addressAPI, Uri.EscapeDataString(address));
                XElement result = GetGoogleMapsAPIResponse(requestUri);
                string location_type = result.Element("geometry").Element("location_type").Value;
                if (!string.IsNullOrEmpty(location_type)) {
                    if ((location_type.ToUpper() == "ROOFTOP") || (location_type.ToUpper() == "RANGE_INTERPOLATED")) {
                        kvpStatus.Insert(0, new KeyValuePair<string, string>("TRUE", "Location Type is: " + location_type + " which should be TRUE as per provided address"));
                    } else {
                        kvpStatus.Insert(0, new KeyValuePair<string, string>("FALSE", "Location Type is: " + location_type + " which should be FALSE as per provided address"));
                    }
                } else {
                    kvpStatus.Insert(0, new KeyValuePair<string, string>("FALSE", "Not able to verify this address"));
                }
            } catch (Exception ex) {
                string error = ex.Message;
                kvpStatus.Insert(0, new KeyValuePair<string, string>("FALSE", "Google can't find the address"));
            }

            return kvpStatus;
        }

        public List<KeyValuePair<string, string>> GetGeocode(string address) {
            List<KeyValuePair<string, string>> kvpLatAndLon = new List<KeyValuePair<string, string>>();

            try {
                string requestUri = string.Format(addressAPI, Uri.EscapeDataString(address));
                XElement result = GetGoogleMapsAPIResponse(requestUri);
                var locationElement = result.Element("geometry").Element("location");
                if (locationElement != null) {
                    var lat = locationElement.Element("lat");
                    var lng = locationElement.Element("lng");

                    //kvpLatAndLon.Insert(0, new KeyValuePair<string, string>("Latitude", lat.Value));
                    //kvpLatAndLon.Insert(1, new KeyValuePair<string, string>("Longitude", lng.Value));

                    string msg = "Latitude is " + lat.Value + " and Longitude is " + lng.Value + " for provided address";
                    kvpLatAndLon.Insert(0, new KeyValuePair<string, string>("TRUE", msg));
                } else {
                    kvpLatAndLon.Insert(0, new KeyValuePair<string, string>("FALSE", "Not able to get Latitude and Longitude for this address"));
                }
            } catch (Exception ex) {
                string error = ex.Message;
                kvpLatAndLon.Insert(0, new KeyValuePair<string, string>("FALSE", "Google can't find the address"));
            }

            return kvpLatAndLon;
        }
    }
}