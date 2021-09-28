<%@ Control Language="C#" AutoEventWireup="true" CodeFile="LiveLocation.ascx.cs"
    Inherits="HomeCollection_Controls_LiveLocation" %>
<%--<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script>
--%>
<script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDuJSgokrFo24PBgVEDjkdaW-xaECQJEp4&v=3&sensor=true&libraries=places"></script>

<script src="../HomeCollection/js/markerclusterer.js" type="text/javascript"></script>

<script src="https://polyfill.io/v3/polyfill.min.js?features=default" type="text/javascript"></script>

<%--  <script src="//code.jquery.com/jquery-1.12.3.js"></script>--%>

<script src="https://cdn.datatables.net/1.10.12/js/jquery.dataTables.min.js " type="text/javascript"></script>

<link href="https://cdn.datatables.net/1.10.12/css/jquery.dataTables.min.css" rel="stylesheet"
    type="text/css" />
<%--<script type="text/javascript" src="../HomeCollection/js/data.js"></script>
<script type="text/javascript" src="../HomeCollection/js/Pheblom.js"></script>

<script type="text/javascript" src="../HomeCollection/js/Booking.js"></script>--%>

<script type="text/javascript" src="../HomeCollection/js/markerclustererplus.min.js"></script>

<script src="Script/jquery.min.js" type="text/javascript"></script>

<script src="Script/jquery.dataTables.min.js" type="text/javascript"></script>

<style type="text/css">
    #map-container
    {
        padding: 6px;
        border-width: 1px;
        border-style: solid;
        border-color: #ccc #ccc #999 #ccc;
        -webkit-box-shadow: rgba(64, 64, 64, 0.5) 0 2px 5px;
        -moz-box-shadow: rgba(64, 64, 64, 0.5) 0 2px 5px;
        box-shadow: rgba(64, 64, 64, 0.1) 0 2px 5px;
        width: 700px;
    }
    #map
    {
        width: 690px;
        height: 410px;
    }
    #actions
    {
        list-style: none;
        padding: 0;
    }
    #inline-actions
    {
        padding-top: 10px;
    }
    .item
    {
        margin-left: 20px;
    }
    .custom-clustericon
    {
        background: var(--cluster-color);
        color: #FFF;
        border-radius: 100%;
        font-weight: bold;
        font-size: 15px;
        display: flex;
        align-items: center;
    }
    .custom-clustericon::before, .custom-clustericon::after
    {
        /* content: '';*/
        display: block;
        position: absolute;
        width: 100%;
        height: 100%;
        transform: translate(-50%, -50%);
        top: 50%;
        left: 50%;
        background: var(--cluster-color);
        opacity: 0.2;
        border-radius: 100%;
    }
    .custom-clustericon::before
    {
        padding: 7px;
    }
    .custom-clustericon::after
    {
        padding: 14px;
    }
    .custom-clustericon-1
    {
        --cluster-color: #00A2D3;
    }
    .custom-clustericon-2
    {
        --cluster-color: #FF9B00;
    }
    .custom-clustericon-3
    {
        --cluster-color: #FF6969;
    }
</style>
<script type="text/javascript">

    $(document).ready(function() { 
     function Loginauth() {

        var url = "https://13.233.79.89/api/auth";
        var auth = {
            "mobileNumber": "0147852369",
            "token": "!Pass123",
            "device": {
                "metaData": "WebDevice",
                "deviceType": "WEB",
                "width": 0,
                "height": 0
            }
        };
        $.ajax({

            type: "POST",

            url: url,
            contentType: "application/json; charset=utf-8",
            data: JSON.stringify(auth),
            dataType: "json",
            async: true,
            paging: true,

            processData: false,

                success: OnSucclogin,
                failure: function(data) {
                //  alert(data.d);
                ValidationWindow('Fail to access the GeoLocation', 'Information');
                  //  alert("Fail to access the GeoLocation");
                },
                error: function(data) {
                ValidationWindow('Fail to access the GeoLocation', 'Information');
            //    alert("Fail to access the GeoLocation");
                  //  alert(data.d);
                }
            });

        function OnSucclogin(data) {
            debugger
            var resauth = [];
            resauth = data.data.authToken;
            // Store
            localStorage.setItem("authToken", resauth);
        }
    }
});
function Loginauth() {

    var url = "https://13.233.79.89/api/auth";
    var auth = {
        "mobileNumber": "0147852369",
        "token": "!Pass123",
        "device": {
            "metaData": "WebDevice",
            "deviceType": "WEB",
            "width": 0,
            "height": 0
        }
    };
    $.ajax({

        type: "POST",

        url: url,
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify(auth),
        dataType: "json",
        async: true,
        paging: true,

        processData: false,

        success: OnSucclogin,
        failure: function(data) {
        //  alert(data.d);
        ValidationWindow('Fail to access the GeoLocation', 'Information');
     //   alert("Fail to access the GeoLocation");
        },
        error: function(data) {
        //  alert(data.d);
        ValidationWindow('Fail to access the GeoLocation', 'Information');
      //  alert("Fail to access the GeoLocation");
        }
    });

    function OnSucclogin(data) {
        debugger
        var resauth = [];
        resauth = data.data.authToken;
        // Store
        localStorage.setItem("authToken", resauth);
    }
}
</script>
<script type="text/javascript">
    $(document).ready(function() {
    $('#btnSearch').on('click', GetBookingInfo);
		
     function Loginauth() {

        var url = "https://13.233.79.89/api/auth";
        var auth = {
            "mobileNumber": "0147852369",
            "token": "!Pass123",
            "device": {
                "metaData": "WebDevice",
                "deviceType": "WEB",
                "width": 0,
                "height": 0
            }
        };
        $.ajax({

            type: "POST",

            url: url,
            contentType: "application/json; charset=utf-8",
            data: JSON.stringify(auth),
            dataType: "json",
            async: true,
            paging: true,

            processData: false,

            success: OnSucclogin,
            failure: function(data) {
              ValidationWindow('Fail to access the GeoLocation', 'Information');
           //  alert("Fail to access the GeoLocation");
               // alert(data.d);
            },
            error: function(data) {
              ValidationWindow('Fail to access the GeoLocation', 'Information');
        //     alert("Fail to access the GeoLocation");
              //  alert(data.d);
            }
        });

        function OnSucclogin(data) {
            debugger
            var resauth = [];
            resauth = data.data.authToken;
            // Store
            localStorage.setItem("authToken", resauth);
        }
    }
        var map;
        function initMap() {
            map = new google.maps.Map(document.getElementById('map'), {
                center: { latitude: 13.011180, longitude: 80.214365 },
                zoom: 8
            });
            var geocoder = new google.maps.Geocoder();

            geocodeAddress(geocoder, map);
        }
        if (document.readyState !== 'complete') {Loginauth();
            window.addEventListener('load', function() { Loginauth(); initialize(); });
            
        }
        else {
            initMap();
            Loginauth();
        }

    });
  function geocodeAddress(geocoder, resultsMap) {
        var address=document.getElementById("<%=locationpincode.ClientID %>").value;
         var imageUrl = "../HomeCollection/images/1.png"; 
           
          var markerImage = new google.maps.MarkerImage(
          imageUrl,
          new google.maps.Size(24, 32)
        );
        geocoder.geocode(
          {
            address: address
          },
          (results, status) => {
            if (status === "OK") {
              resultsMap.setCenter(results[0].geometry.location);
              new google.maps.Marker({
                map: resultsMap,
                icon: markerImage,
                position: results[0].geometry.location
              });
            } 
//else {
//              alert(
//                "Geocode was not successful for the following reason: " + status
//              );
//            }
          }
        );
        
      }

</script>

<script type="text/javascript">
var styles = [
        [
          {
              url: "../HomeCollection/images/people35.png",
              height: 35,
              width: 35,
              anchor: [16, 0],
              textColor: "#ff00ff",
              textSize: 10
          },
          {
              url: "../HomeCollection/images/people45.png",
              height: 45,
              width: 45,
              anchor: [24, 0],
              textColor: "#ff0000",
              textSize: 11
          },
          {
              url: "../HomeCollection/images/people55.png",
              height: 55,
              width: 55,
              anchor: [32, 0],
              textColor: "#ffffff",
              textSize: 12
          }
        ],
        [
          {
              url: "../HomeCollection/images/conv30.png",
              height: 27,
              width: 30,
              anchor: [3, 0],
              textColor: "#ff00ff",
              textSize: 10
          },
          {
              url: "../HomeCollection/images/conv40.png",
              height: 36,
              width: 40,
              anchor: [6, 0],
              textColor: "#ff0000",
              textSize: 11
          },
          {
              url: "../HomeCollection/images/conv50.png",
              width: 50,
              height: 45,
              anchor: [8, 0],
              textSize: 12
          }
        ],
        [
          {
              url: "../HomeCollection/images/heart30.png",
              height: 26,
              width: 30,
              anchor: [4, 0],
              textColor: "#ff00ff",
              textSize: 10
          },
          {
              url: "../HomeCollection/images/heart40.png",
              height: 35,
              width: 40,
              anchor: [8, 0],
              textColor: "#ff0000",
              textSize: 11
          },
          {
              url: "../HomeCollection/images/heart50.png",
              width: 50,
              height: 44,
              anchor: [12, 0],
              textSize: 12
          }
        ],
        [
          {
              url: "../HomeCollection/images/m1.png",
              height: 26,
              width: 30,
              anchor: [4, 0],
              textColor: "#ff0066",
              textSize: 12
          },
          {
              url: "../HomeCollection/images/m2.png",
              height: 35,
              width: 40,
              anchor: [8, 0],
              textColor: "#ff0000",
              textSize: 12
          },
          {
              url: "../HomeCollection/images/m3.png",
              width: 50,
              height: 44,
              anchor: [12, 0],
              textSize: 12
          },
          {
              url: "../HomeCollection/images/m4.png",
              height: 35,
              width: 40,
              anchor: [8, 0],
              textColor: "#ff0000",
              textSize: 12
          },
          {
              url: "../HomeCollection/images/m5.png",
              width: 50,
              height: 44,
              anchor: [12, 0],
              textSize: 12
          }
        ]
      ];


          var markerClusterer = null;
             var chdmarkerClusterer = null;
          function refreshMap() {
              if (markerClusterer) {
                  markerClusterer.clearMarkers();
              }
               if (chdmarkerClusterer) {
                  chdmarkerClusterer.clearMarkers();
              }
          }
          var markers = [];
           var marker =null;

           function initialize() {
               Loginauth();
               var geocoder = new google.maps.Geocoder();

               var mapOptions = {

                   zoom: 12,
                   center: new google.maps.LatLng(13.067439, 80.237617),
                   mapTypeId: google.maps.MapTypeId.ROADMAP


               };


               map = new google.maps.Map(document.getElementById("map"), mapOptions);
           Loginauth();
               geocodeAddress(geocoder, map);
          Loginauth();
               // Retrieve
               var authtok = localStorage.getItem("authToken");
               var url = "https://13.233.79.89/api/user/location/lastKnown";
               var auth = "Bearer " + authtok;
               $.ajax({

              type: "GET",

              url: url,
              contentType: "application/json; charset=utf-8",

              dataType: "json",
              async: true,
              paging: true,
              headers: {
                  Authorization: auth

              },

                   context: document.body,
                   success: OnSuccloc,
                   failure: function(data) {
                       // alert(data.d);
                       Loginauth();
                   },
                   error: function(data) {
                     //  alert("Select the Today Registered Phlebo");
                         Loginauth();
                   }
               });
               function OnSuccloc(data) {
                   debugger
                   var res = [];
                   res = data.data;


                   datas = res;
                   var gmarkers = [];
            
                      
                   for (i = 0; i < data.data.PhleboLocInfo.length; i++) {
                       var latude = datas.PhleboLocInfo[i].latitude;
                       var latlngs = {
                           lat: parseFloat(datas.PhleboLocInfo[i].latitude),
                           lng: parseFloat(datas.PhleboLocInfo[i].longitude)
                       };
                       var lngitude = datas.PhleboLocInfo[i].longitude;
                       var myLatlng = new google.maps.LatLng(datas.PhleboLocInfo[i].latitude,
            datas.PhleboLocInfo[i].longitude);

                       localStorage.setItem("latude", latude);
                       localStorage.setItem("lngitude", lngitude);
                       // Store
                   //    localStorage.setItem("LoginID", datas.PhleboLocInfo[i].LoginID);
                       localStorage.setItem("Phleboid", datas.PhleboLocInfo[i].LoginID);
                       var infowindow = new google.maps.InfoWindow();
                       //    var geocoder = new google.maps.Geocoder();
                       var imageUrl = "../HomeCollection/images/p6.png";

                       var markerImagephleboloc = new google.maps.MarkerImage(
          imageUrl,
          new google.maps.Size(24, 32)
        );
                       map = new google.maps.Map(document.getElementById("map"), {
                           zoom: 11,
                           center: myLatlng
                       });
                       	var Logdetails = "<b>PhleboLocationInfo Details:</b> <br />Login ID : " + datas.PhleboLocInfo[i].LoginID + "<br />" + "Phlebo Name : " + datas.PhleboLocInfo[i].display_name ;//+ "<br />" + "Patient Address : " + beach.Address
                     	var Logdetailstitle = "PhleboLocationInfo Details: Login ID : " + datas.PhleboLocInfo[i].LoginID + " Phlebo Name : " + datas.PhleboLocInfo[i].display_name ;//+ "<br />" + "Patient Address : " + beach.Address
                       marker = new google.maps.Marker({
                           suppressMarkers: true,
                           position: myLatlng,
                           title: Logdetailstitle,
                           map: map,
                           icon: markerImagephleboloc
                       });
                    
                       // Store
                       marker.setMap(map);
                       (function(marker, datas) {


                   // Attaching a click event to the current marker
                   google.maps.event.addListener(marker, "click", function(e) {
                     
                       infowindow.open(map, marker,datas);

                   

                           });


                       })(marker, datas); // collecting all marker
                       gmarkers.push(marker);

                       (function(i, marker) {
                        
                          google.maps.event.addListener(marker, 'click', function() {

                          // Retrieve
                          var LoginID = localStorage.getItem("Phleboid");
                          var pheboadd = localStorage.getItem("pheboadd");
                          if (!infowindow) {
                              infowindow = new google.maps.infowindow();
                          }
                          marker.setIcon("../HomeCollection/images/star.png");

                          infowindow.setContent(Logdetails);
                     //   infowindow.setContent("<b>PhleboLocationInfo Details:</b> <br />Login ID : " + datas.PhleboLocInfo[i].LoginID + "<br />" + "Phlebo Name : " + datas.PhleboLocInfo[i].display_name );
                          infowindow.open(map, marker);

                          geocodeLatLngparent(geocoder, map, infowindow);

                          function geocodeLatLngparent(geocoder, map, infowindow) {
                           
                           geocoder.geocode({ location: myLatlng }, (resultsloc, statusloc) => {
  if (statusloc === "OK") {
  if (resultsloc[0]) {
   localStorage.setItem("pheboadd", resultsloc[0].formatted_address);
  }//statusloc
  }//resultsloc


});
//geocoder parent




                           } //geocodeLatLngparent
                           
                                                           map.setZoom(11);
                                map.setCenter(marker.getPosition());
                                 var txtBookingNumber = document.getElementById("<%=txtBookingNumber.ClientID %>").value;
                                if (txtBookingNumber === undefined || txtBookingNumber === '') {

                                    var txtBookingNumber = 0;
                                }
                                  $.ajax({
                                    type: "POST",
                                    url: "../HCService.asmx/GetHCMapBookingDetails",

                                    contentType: "application/json; charset=utf-8",
                                    data: "{UserID:" + datas.PhleboLocInfo[i].LoginID + ",BookingNumber:" + txtBookingNumber + "}",

                                    dataType: "json",
                                    async: true,
                                    paging: true,

                                    context: document.body,
                                    success: OnSuccessPhe,
                                    failure: function(respphe) {
                                         ValidationWindow('Unable to Get Booking Data at Present'); //alert(respphe.d);
                                    },
                                    error: function(respphe) {
                                         ValidationWindow('Unable to Get Booking Data at Present'); //alert(respphe.d);responstable fixResponsTable
                                    }
                                }); // booking ajax all
                                
                                 function OnSuccessPhe(respphe) {
                                    var BookIDPh = [];
                                    var fltPhel = [];
                                    if (respphe.d.length > 0) {
                                     fltPhel = respphe.d;
                                        BookIDPh = fltPhel;
                                        	var pheboadd=localStorage.getItem("pheboadd");
                                        	 $("#Phobl").append('<table id="demoTable" class="gridView  w-100p " cellspacing="0" width="100%"><thead> <tr><th>' +
                            '<asp:Label ID="lblSampleCollection" runat="server" Text="Sample Collection" colspan="2"></asp:Label>' +
                       '</th><th style="background-color: #fffffe!important;color:#000000!important;" colspan="2">' + BookIDPh[0].Remarks + '</th><th><asp:Label ID="lblPhoName" runat="server" Text="Current Location"></asp:Label></th> <th  style="background-color: #fffffe!important;color:#000000!important;" colspan="3">' + pheboadd + '</th></tr>'
                     + '<tr><th><asp:Label ID="lblsno" runat="server" Text="Sl.No." ></asp:Label> </th>'
                       + '<th> <asp:Label ID="lblBookingID" runat="server" Text="Booking ID "  ></asp:Label></th>'
                            + '<th><asp:Label ID="lblPatientName" runat="server" Text="Patient Name "></asp:Label> </th>'
                            + '<th> <asp:Label ID="lblMobileNumber" runat="server" Text="Mobile Number " ></asp:Label> </th>'
                            + '<th><asp:Label ID="lblLocation" runat="server" Text="Location"></asp:Label>  </th>'
                            + '<th> <asp:Label ID="lblSampleCollectionTime" runat="server" Text="Sample Collection Time" ></asp:Label> </th>'
                            + '<th> <asp:Label ID="lblStatus" runat="server" Text="Status"  ></asp:Label>  </th>' +
                        '                    </tr> </thead></table>');
                       $('#demoTable').DataTable({

                           //   paging: false,
                           "retrieve": true,

                           "data": BookIDPh,
                           "bJQueryUI": true,
                           "bDestroy": true,
                           "columns": [
                            { "data": "id", render: function(data, type, row, meta) {
                                return meta.row + meta.settings._iDisplayStart + 1;
                            }
                            },
      { "data": "BookingID" },
      { "data": "Name" },
       { "data": "MobileNumber" },

       { "data": "Address" },
                         { "data": "SampleCollectionTime" ,  "render": function (data) {
                           var date = new Date(parseInt(data.substr(6)));
                            var month = date.getMonth() + 1;
                            var hours = date.getHours() ; // gives the value in 24 hours format
                            var AmOrPm = hours >= 12 ? 'PM' : 'AM';
                            hours = (hours % 12) || 12;
                             return date.getDate() + "/" + (month.length > 1 ? month : "0" + month) + "/" + date.getFullYear() + "&nbsp;&nbsp;" +(date.getHours() < 10 ? ("0"+date.getHours()) : date.getHours())+ ":"+(date.getMinutes() < 10 ? ("0"+date.getMinutes()) : date.getMinutes()+ ":"+ "0" + hours + " "+ AmOrPm); 

                             //return date;
                         } 
                         },

                           { "data": "Status" },
                             ],"columnDefs": [
            { 'width': 200, 'targets': 0 },{
     'targets': "_all",
     'orderable': false
 }
        ], "order": false,
                                  
                              "oLanguage": {
                                 "sProcessing": "Fetching Data, Please wait..."
                             }      });

                       /// end of datatable constructor


    //newbooking marker
                       setMarkers(map);
                        function setMarkers(map) {
                           var geocoder;
                              var image = {
                               url: "../HomeCollection/images/h4.png",
                               //  "https://developers.google.com/maps/documentation/javascript/examples/full/images/beachflag.png",
                               // This marker is 20 pixels wide by 32 pixels high.
                               size: new google.maps.Size(20, 32),
                               // The origin for this image is (0, 0).
                               origin: new google.maps.Point(0, 0),
                               // The anchor for this image is the base of the flagpole at (0, 32).
                               anchor: new google.maps.Point(0, 32)
                           }; // Shapes define the clickable region of the icon. The type defines an HTML
                           // <area> element 'poly' which traces out a polygon as a series of X,Y points.
                           // The final coordinate closes the poly by connecting to the first coordinate.

                           var shape = {
                               coords: [1, 1, 1, 20, 18, 20, 18, 1],
                               type: "poly"
                           };
                           var beach =[];
                           	var address1=[];
                              var geocoderchp = new google.maps.Geocoder();
                                   var chdgmarkers=[];
                             for (var j = 0; j< BookIDPh.length; j++) {
                             
                              geocoder = new google.maps.Geocoder();
                               
                               // Store
          
                              	 beach = BookIDPh[j];
							var BookingNos = String(beach.BookingID);
							var BookingNo = beach.BookingID;
							var address = beach.Address;
                               //marker
                                
                           
	geocodeAddressp(geocoderchp, map);
	function geocodeAddressp(geocoderchp, resultsMapp) {
	var details = "<b>Booking Details:</b> <br />Booking ID : " + String(beach.BookingID) + "<br />" + "Patient Name : " + beach.Name ;//+ "<br />" + "Patient Address : " + beach.Address

	 localStorage.setItem("booknumber", String(beach.BookingID));
//address1 = BookIDPh[i].Address + "," + BookIDPh[i].City + "," + BookIDPh[i].State + "," + BookIDPh[i].Country + "," + BookIDPh[i].PostalCode;
address1 = beach.Address + "," + beach.City + "," + beach.State + "," + beach.Country + "," + beach.PostalCode;
var bookid=beach.BookingID;

geocoderchp.geocode({
				address: address1
			}, function (res, sta) {
			
			if (sta === "OK") {
					debugger
					resultsMapp.setCenter(res[0].geometry.location);
					posp = res[0].geometry.location;
				
					var marker= new google.maps.Marker({
						map: resultsMapp,
						icon:image,
						   position: res[0].geometry.location,
					
						  suppressMarkers: true,
						     zIndex: j

					});
					var infowindow = new google.maps.InfoWindow();
							var directionsService = new google.maps.DirectionsService();
							var directionsRenderer = new google.maps.DirectionsRenderer();
					 (function(marker, beach) {


                   // Attaching a click event to the current marker
                   google.maps.event.addListener(marker, "click", function(e) {
                     
                       infowindow.open(map, marker,beach);

                   

                   });
      
                  
               })(marker, beach);// collecting all marker child
               gmarkers.push(marker);   
               
                (function(j, marker) {
                
                 google.maps.event.addListener(marker, 'click', function() {
                
	debugger
	var filteredValue = BookIDPh.filter(function (item) {
				return item.BookingID == bookid;
			});
									var beachBook = []; 
							beachBook= filteredValue;
                    if (!infowindow) {
                           infowindow = new google.maps.infowindow();
                       }
                    
   var booknumber = localStorage.getItem("booknumber");  
     marker.setIcon(null);
                       infowindow.setContent(details);

                       infowindow.open(map, marker);


                       map.setZoom(8);
                       map.setCenter(marker.getPosition());
                    //   marker.setIcon(null);
                   //  var LoginID = localStorage.getItem("LoginID");  
                  //   var pheboadd=localStorage.getItem("pheboadd");
                       $.ajax({
				type: "POST",
				 url: "../HCService.asmx/GetHCMapBookingHistDetails",
             
                contentType: "application/json; charset=utf-8",
                 data: "{UserID:" + LoginID + ",BookingNumber:" + bookid + "}",
           
                dataType: "json",
                async: true,
                paging: true,
			
				context: document.body,
				success: OnSuccess,
				failure: function (resp) {
					 alert("Unable to Get Booking Data at Present");//alert(resp.d);
				},
				error: function (resp) {
					 alert("Unable to Get Booking Data at Present");//alert(resp.d);
				}
			});
			
			//sucess booking
                   	function OnSuccess(resp) {
			debugger
			var result = [];
			result = JSON.stringify(resp);
			var flt=[];
flt=resp.d;
var BookID = [];
BookID=flt;
var address = BookID[0].Address + "," + BookID[0].City + "," + BookID[0].State + "," + BookID[0].Country + "," + BookID[0].PostalCode;
var date = new Date(parseInt(BookID[0].SampleCollectionTime.substr(6)));
function checkZero(data){
  if(data.length === 1){
    data = "00" + data;
  }
  return data;
}
   var hours = date.getHours() ; // gives the value in 24 hours format
                            var AmOrPm = hours >= 12 ? 'PM' : 'AM';
                            hours = (hours % 12) || 12;
var dt = checkZero(date.getDate())+"/"+checkZero((date.getMonth()+1))+"/"+checkZero(date.getFullYear())+ " " + checkZero(date.getHours()) + ":" + checkZero(date.getMinutes()) + ":" +  hours + " "+ AmOrPm;
			     $('#Phobl').hide();
			$('#demoTable').hide();
			$('#BookingHistory').show();
			$("#BookingHistory").empty();
			$("#BookingHistory").append('<table id="BookHistory" class="gridView responstable w-100p fixResponsTable" cellspacing="0" width="100%"><thead> <tr><th>' +
				'<asp:Label ID="Lab1" runat="server" Text="Sample Collection"></asp:Label>' +
				'</th><th style="background: #fff!important;color: #000000;width:30%;">' + BookID[0].Remarks + '</th><th><asp:Label ID="Labl2" runat="server" Text="Current Location"></asp:Label></th> <th style="background-color: #ffffff!important;color: #000000;">' + pheboadd + ' </th></tr>' +
				'<tr><th><asp:Label ID="Lab4" runat="server" Text="Booking ID "></asp:Label></th>' +
				'<th style="background-color: #fffffe!important;color: #000000;width:30%;">' + BookID[0].BookingID + '</th>' +
				' <th><asp:Label ID="Labl5" runat="server" Text="Patient Name "></asp:Label> </th>' +
				'<th style="background-color:  #fffffe!important;color: #000000">' + BookID[0].Name + '</th> </tr>' +
				'<tr><th><asp:Label ID="Labl6" runat="server" Text="Mobile Number "></asp:Label></th>' +
				' <th style="background-color:  #fffffe!important;color: #000000;width:30%;">' + BookID[0].MobileNumber + '</th>' +
				'<th><asp:Label ID="Lab8" runat="server" Text="Sample Collection Time"></asp:Label></th>' +
				'<th style="background-color:  #fffffe!important;color: #000000">' + dt + '</th> </tr>' +
				'<tr><th><asp:Label ID="Labl3" runat="server" Text="Sl.No. " style="width:10px;"></asp:Label> </th>' +
				'<th><asp:Label ID="Labl10" runat="server" Text="Description" style="width:30%;"></asp:Label></th>' +
				' <th> <asp:Label ID="Labl11" runat="server" Text="TimeStamp"></asp:Label></th>' +

				'<th> <asp:Label ID="Labbl9" runat="server" Text="Status" ></asp:Label>   </th>' +
				'                    </tr> </thead></table>');


			$('#BookHistory').DataTable({

			// "bProcessing": true,
    "sAutoWidth": false,
    "bDestroy":true,
    "sPaginationType": "bootstrap", // full_numbers
    "iDisplayStart ": 10,
    "iDisplayLength": 10,
    "bPaginate": false, //hide pagination
    "bFilter": false, //hide Search bar
    "bInfo": false, // hide showing entries
			
				"searching": false,
				"retrieve": true,
 "paging":   false,
        "ordering": false,
        "info":     false,
				"data": BookID,
				// "bJQueryUI": true,
				"bDestroy": true,
			//	"processing": true,
				"columns": [{
						"data": "id",
						render: function (data, type, row, meta) {
							return meta.row + meta.settings._iDisplayStart + 1;
						}
					},
					{
						"data": "Reason"
					},
					{
						  "data": "SampleCollectionTime" ,  "render": function (data) {
                            var date = new Date(parseInt(data.substr(6)));
                            var month = date.getMonth() + 1;
                             var hours = date.getHours() ; // gives the value in 24 hours format
                            var AmOrPm = hours >= 12 ? 'PM' : 'AM';
                            hours = (hours % 12) || 12;
                            return date.getDate() + "/" + (month.length > 1 ? month : "0" + month) + "/" + date.getFullYear() + "&nbsp;&nbsp;" +(date.getHours() < 10 ? ("0"+date.getHours()) : date.getHours())+ ":"+(date.getMinutes() < 10 ? ("0"+date.getMinutes()) : date.getMinutes()+ ":"+ "0" + hours + " "+ AmOrPm) ; 
                            //return date;
                        }
                        },
					{
						"data": "Status"
					},

				],


				"oLanguage": {
					"sProcessing": "Fetching Data, Please wait..."
//					"searchPanes": {
//						emptyPanes: 'There are no panes to display. :/'
					//}
				}
			});
			//table
			
			var geocoderchd = new google.maps.Geocoder();
	geocodeAddressd(geocoderchd, map);

				function geocodeAddressd(geocoderchd, resultsMapch) {
	var address = BookID[0].Address + "," + BookID[0].City + "," + BookID[0].State + "," + BookID[0].Country + "," + BookID[0].PostalCode;
	
	geocoderchd.geocode({
				address: address
			}, function (resu, statd) {
				if (statd === "OK") {
					debugger
					resultsMapch.setCenter(resu[0].geometry.location);
				var poss = resu[0].geometry.location;
		 // Store
            localStorage.setItem("myLatlngchld", poss);
         	 var icon = {
                               url: "../HomeCollection/images/h3.png",
                               //  "https://developers.google.com/maps/documentation/javascript/examples/full/images/beachflag.png",
                               // This marker is 20 pixels wide by 32 pixels high.
                               size: new google.maps.Size(20, 32),
                               // The origin for this image is (0, 0).
                               origin: new google.maps.Point(0, 0),
                               // The anchor for this image is the base of the flagpole at (0, 32).
                               anchor: new google.maps.Point(0, 32)
                           };
					var marker = new google.maps.Marker({
						map: resultsMapch,
						//icon: '../HomeCollection/images/h3.png',
						//icon: icon,
						   position: resu[0].geometry.location,
						title: address,
						  suppressMarkers: true

					});
					 
					//   marker.setIcon("../HomeCollection/images/h3.png");
					  directionsRenderer.setMap(map);
					      CalandDisplay(directionsService, directionsRenderer);
					}//if (statd === "OK") 
					else {
					alert("Geocode was not successful for the following reason: " + statd);
				}//ifelse (statd === "OK")
	
         	var waypts = [];//origin to destination via waypoints
		//waypts.push({location: 'indore', stopover: true});
		// Retrieve
            	var myLatlngsource = localStorage.getItem("myLatlngsource");
		// Retrieve
		
           
            	var myLatlngchld = localStorage.getItem("myLatlngchld");
	function CalandDisplay(directionsService, directionsRenderer) {
									var selectedMode = "DRIVING";
									directionsService.route({
											origin: myLatlng, //{ lat: 37.77, lng: -122.447 },
											destination: poss, //{ lat: 37.768, lng: -122.511 },
											// Note that Javascript allows us to access the constant
											// using square brackets and a string value as its
											// "property."
											// @ts-ignore
											waypoints: waypts,
											travelMode: google.maps.TravelMode[selectedMode]
										},
										(respone, stats) => {
											if (stats == google.maps.DirectionsStatus.OK) {
												new google.maps.DirectionsRenderer({
													map: map,
													directions: respone,
													suppressMarkers: true
												});

												var leg = respone.routes[0].legs[0];
												makeMarker(leg.start_location, icons.start, marker.title, map);
												makeMarker(leg.end_location, icons.end, marker.title, map);
												localStorage.setItem("autouserid", datas.PhleboLocInfo[i].LoginID);
autoUpdate();
										
										
										}//if (stats == google.maps.DirectionsStatus.OK)
										else {
												alert("Unable to retrive route");
											}////if (stats == google.maps.DirectionsStatus.OK)
										
										});//directionsService.route({
            	
            	
            	}//function CalandDisplay(directionsService, directionsRenderer)
            	
            		//Childmarker
            		//parent  marker directionsService

								function makeMarker(position, icon, title, map) {
									new google.maps.Marker({
										position: position,
										map: map,
										icon: icon,
										title: title
									});
								}

								var icons = {
									start: new google.maps.MarkerImage(
										// URL
										//  'https://maps.google.com/mapfiles/ms/micons/blue.png',
										//  '../HomeCollection/images/star.png',
										'',
										// (width,height)
										new google.maps.Size(44, 32),
										// The origin point (x,y)
										new google.maps.Point(0, 0),
										// The anchor point (x,y)
										new google.maps.Point(22, 32)),
									end: new google.maps.MarkerImage(
										// URL
										//  'http://maps.google.com/mapfiles/ms/micons/green.png',
										'',
										//  '../HomeCollection/images/h3.png',
										// (width,height)
										new google.maps.Size(44, 32),
										// The origin point (x,y)
										new google.maps.Point(0, 0),
										// The anchor point (x,y)
										new google.maps.Point(22, 32))
								};
			
			});//geocoderchd.geocode({				address: address			}, function (resu, statd) 
	
	
	
	
	
	}//	function geocodeAddressd(geocoderchd, resultsMapch)
			
			
	   } 
                                //OnSuccess(resp) GetHCHistMapBookingDetails
                
                 });                   // earch child marker click
               
                      })(j, marker);   // earch child marker
					
					}//(sta === "OK")
					else {
					  ValidationWindow('Geocode was not successful for the following reason:' + sta, 'Information');
				//	alert("Geocode was not successful for the following reason: " + sta);
				}////ifelse (sta === "OK")
			
			});
	
	}// geocodeAddressp(geocoderchp, resultsMapp)
                             
                             }//for (var j = 0; j < BookIDPh.length; j++)
   
  
  
  
  
    }//setMarkers(map) function

  
 
                                 
                                   } //respphe.d.length if cond 
                                   else
                                   {
                                     ValidationWindow('No Bookings Alloted for Today', 'Information');
                                   //alert("No Bookings Alloted for Today");
                                   
                                   }
                                 
                                  } 
                                //OnSuccessPhe GetHCMapBookingDetails

                          
                          
                          

                      });                   // earch parent marker click
                        
                        

                    })(i, marker);   // earch parent marker

                        
                        
                        
                        
                        
 
                    } //forloop parent marker
                
                   
                      refreshMap();
           var zoom = parseInt(12, 20);
           var size = parseInt(40, 10);
           var style = parseInt(3, 10);
           zoom = zoom == -1 ? null : zoom;
           size = size == -1 ? null : size;
           style = style == -1 ? null : style;
          
           markerClusterer = new MarkerClusterer(map, gmarkers , {
               maxZoom: zoom,
               gridSize: size,
               styles: styles[style],
               clusterClass: style === 3 ? 'custom-clustericon' : undefined
           });
           function clearClusters(e) {
               e.preventDefault();
               e.stopPropagation();
               markerClusterer.clearMarkers();
           }
      

               }// parent marker OnSuccloc api location
           }//initialize
           </script>

<script type = "text/javascript" >
//	$(document).ready(function () {
//		
//});



//getBookinginfo
function GetBookingInfo() {
    debugger
    Loginauth();
 //    alert($('#<%=lblid.ClientID%>').text());
    // document.getElementById("<%=lblid.ClientID %>").addEventListener("click", function(event) {
//  event.preventDefault(); //stop default action of the link button, to allow script to execute
 
  //getValue('0|' + selectedVal);
//});
  //   var e = document.getElementById("ddlTechni");  
//var selectedLocation = e.options[e.selectedIndex].value; 
//$('#Phobl').hide();
//			$('#demoTable').hide();
//			$('#demoTable').empty();
//			$('#BookingHistory').hide();
//			$("#BookingHistory").empty();
//alert(selectedVal);


         var map;
    var phoaddress=[];
    var phaddmar=[];
    var posu;
    	var directionsService = new google.maps.DirectionsService();
		var directionsRenderer = new google.maps.DirectionsRenderer();
    if ($('#ddlTechni').val()!=undefined)
    {
    var UserID=$('#ddlTechni').val();
    }
    else{
    var UserID=0;
    }
    var txtBookingNumber = document.getElementById("<%=txtBookingNumber.ClientID %>").value;
    if (txtBookingNumber !== "") {
    //parent marker
     //var phoddress=[];
					var markerClusterer = null;
						var markerClustererchd = null;

		function refreshMap() {
			if (markerClusterer) {
				markerClusterer.clearMarkers();
			}
			if (markerClustererchd) {
				markerClustererchd.clearMarkers();
			}
		}
		var markers = [];


		var infoWindow = new google.maps.InfoWindow();


		

		var imageUrl = "../HomeCollection/images/star.png";

		var markerImage = new google.maps.MarkerImage(
			imageUrl,
			new google.maps.Size(24, 32)
		);
		var gmarkers = [];


		var mapOptions = {

			zoom: 12,
			center: new google.maps.LatLng(13.067439, 80.237617),
			mapTypeId: google.maps.MapTypeId.ROADMAP


		};
var map = new google.maps.Map(document.getElementById("map"), mapOptions);
			//ajax of parent marker
	//	var jsonObjects =data;
            	//$(function () {
            	
            	$.ajax({
				type: "POST",
				 url: "../HCService.asmx/GetHCMapBookingDetails",
             
                contentType: "application/json; charset=utf-8",
                 data: "{UserID:" + UserID + ",BookingNumber:" + txtBookingNumber + "}",
            
                dataType: "json",
                async: true,
                paging: true,
			
				context: document.body,
				success: OnSuccessBook,
				failure: function (respk) {
				  ValidationWindow('Unable to Get Booking Data at Present', 'Information');
				// alert("Unable to Get Booking Data at Present");//	alert(respk.d);
				},
				error: function (respk) {
				ValidationWindow('Unable to Get Booking Data at Present', 'Information');
					// alert("Unable to Get Booking Data at Present");//alert(respk.d);
				}
			});
            	
            	 	function OnSuccessBook(respk) { 
           	debugger
         //  	alert(JSON.stringify(respk));
           	var userbook = [];
           	userbook = respk.d[0].LoginID;
          // 	alert(userbook);
         localStorage.setItem("phename", respk.d[0].remarks);
            	// Retrieve
            	var authtok = localStorage.getItem("authToken");
            	
            	
            	
           		var url = "https://13.233.79.89/api/user/location/lastKnown";
           		var auth="Bearer " + authtok;//"Bearer eyJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJBRE1JTiIsInN1YiI6IkF1dGhUb2tlbiIsImV4cCI6MTU5NjgxNjMzNywiaWF0IjoxNTk2NzI5OTM3LCJqdGkiOiJiNTgyNzRkZS05MjQwLTRjYzAtYWUyOS1iZDZjY2VkZTA4ZTYifQ.tjDw4056frlV9vEIk7JJd7i1SYwoK13qrqnpJH1Rebc";
			$.ajax({
				
				type: "GET",
				//url: "../HCService.asmx/GetHCMapBookingHistDetails",
              	url: url,
                contentType: "application/json; charset=utf-8",
             //   data: data,//JSON.stringify(jsonObjects) ,// "{pUserID'" + pUserID + "}",
                dataType: "json",
                async: true,
                paging: true,
                	headers: {
					Authorization: auth
				//	orgcode: "LIMSAPI"

				},
			
				context: document.body,
				success: OnSucc,
				failure: function (data) {
				//	alert(data.d);
					  Loginauth();
				},
				error: function (data) {
				ValidationWindow('Select the Today Registered Phlebo', 'Information');
					//alert("Select the Today Registered Phlebo");
					 // Loginauth();
				}
			});
	//	});
//            
           	function OnSucc(data) { 
           	debugger
        //   	alert(JSON.stringify(data));
          // 	}
		//			debugger
//			//ajax of parent marker
//			
//  
//  
//  
//};
//geolocation parent marker
//var countKey = Object.keys(data.PhleboLocInfo).length;
//alert(countKey);
//alert(data.PhleboLocInfo.length());
//$.parseJSON(data).length);
			//var fltPhel=[];
//fltPhel=data.d;
//alert(fltPhel.length);
//data=data.PhleboLocInfo;
//alert(data.Count);
var res =[];
res=data.data.PhleboLocInfo;

var filteredValue = res.filter(function (item) {
				return item.LoginID == userbook;
			});
			
		//	alert(filteredValue);
			

		//	var BookID = [];
			
			//To See Output Result as Array
//BookID = resp;
			data = filteredValue;


//for (k = 1; k < data.Count; k++) {
//var PhleboUser = parseInt(data.PhleboLocInfo[k].LoginID);
//alert(PhleboUser);
debugger
//if (PhleboUser=== userbook)
//{

			
				var geocoder = new google.maps.Geocoder();
            geocodeLatLng(geocoder, map, infoWindow);
	//	var data=resp1;
	//	alert(data);
			function geocodeLatLng(geocoder, map, infoWindow) {
			debugger
//  var input = document.getElementById("latlng").value;
 // var latlngStr = input.split(",", 2);
//  var myLatlng = {
//    lat: parseFloat(data.PhleboLocInfo[0].latitude),
//    lng: parseFloat(data.PhleboLocInfo[0].longitude)
//  };
   var myLatlng = {
    lat: parseFloat(data[0].latitude),
    lng: parseFloat(data[0].longitude)
  };
  geocoder.geocode({ location: myLatlng }, (results, status) => {
    if (status === "OK") {
      if (results[0]) {
      	debugger
        map.setZoom(11);
     //   var UserID=parseInt(data.PhleboLocInfo[0].LoginID);
         var UserID=parseInt(data[0].LoginID);
           var phename = localStorage.getItem("phename");   	
  // 	var name = "<br />User ID : " + UserID + "<br />" + "Phlebo Name : " + data.PhleboLocInfo[0].display_name;
	var name = "<br />User ID : " + UserID + "<br />" + "Phlebo Name : " + phename;
	var nametitle="PhleboLocationInfo :  " + " Login ID :" + UserID + " Phlebo Name :" + phename;
        var marker = new google.maps.Marker({
          position: myLatlng,
          map: map,
          //	title: "PhleboLocInfo : " + "\n\n" + "User ID : " + UserID + "\n" + "Phlebo Name :" + data.PhleboLocInfo[0].display_name,
          	 //	title: "<b>PhleboLocationInfo : </b><br/>" + "\n\n" +  "Login ID :" + UserID + "\n\n<br/>" +  "Phlebo Name :" + phename,
          	 //		title: "PhleboLocInfo : " + "\n\n" + "User ID : " + UserID + "\n" + "Phlebo Name :" + phename,
          	 title:nametitle,
				zIndex: 3,
				suppressMarkers: true,
				   icon: markerImage
        });
         var phebladdress=[];
         phebladdress=results[0].formatted_address;
       // alert(add);
      // $("#phoaddress").val(add);
     
        phaddmar=phebladdress;
      //  window.value=phebladdress;
     //   alert(phoadd);
      //  alert(phoaddress);
      //  phoaddress=results[0].formatted_address;
       // alert(add);
      // $("#phoaddress").val(add);
        
        
        
        infoWindow.setContent(results[0].formatted_address);
      //  infoWindow.open(map, marker);
        	(function (marker, data) {


				// Attaching a click event to the current marker
				google.maps.event.addListener(marker, "click", function (e) {

					infoWindow.open(map, marker, data);


				});


			})(marker, data);
			gmarkers.push(marker);
			//booking ajax  "pUserID=" + UserID +"&BookingNumber=" + txtBookingNumber,
	//	$(function () {
	//var UserID=0;
			$.ajax({
				type: "POST",
				 url: "../HCService.asmx/GetHCMapBookingHistDetails",
             
                contentType: "application/json; charset=utf-8",
                 data: "{UserID:" + UserID + ",BookingNumber:" + txtBookingNumber + "}",
             //   data:"{pUserID:" + UserID + ",BookingNumber:" + txtBookingNumber + "}",
                dataType: "json",
                async: true,
                paging: true,
			
				context: document.body,
				success: OnSuccess,
				failure: function (resp) {
				

  ValidationWindow('Unable to Get Booking Data at Present', 'Information');
					// alert("Unable to Get Booking Data at Present");//alert(resp.d);
				},
				error: function (resp) {
				  ValidationWindow('Unable to Get Booking Data at Present', 'Information');

				//	 alert("Unable to Get Booking Data at Present");//alert(resp.d);
				}
			});
	//	}); // booking ajax
		
		//sucess booking
			function OnSuccess(resp) {
			debugger
			//alert(resp);
			var result = [];
			result = JSON.stringify(resp);
			
			// alert(result);
			var BookingNumber = document.querySelector("input[id*='txtBookingNumber']");
			var flt=[];
flt=resp.d;
			var filteredValue = flt.filter(function (item) {
				return item.BookingID == BookingNumber.value;
			});
			
		//	alert(filteredValue);
			

			var BookID = [];
			
			//To See Output Result as Array
//BookID = resp;
			BookID = filteredValue;
//alert(BookID);
			var address = BookID[0].Address + "," + BookID[0].City + "," + BookID[0].State + "," + BookID[0].Country + "," + BookID[0].PostalCode;
var date = new Date(parseInt(BookID[0].SampleCollectionTime.substr(6)));
function checkZero(data){
  if(data.length == 1){
    data = "0" + data;
  }
  return data;
}
//var dt = checkZero(date.getDate())+"/"+checkZero((date.getMonth()+1))+"/"+checkZero(date.getFullYear())+ " " + checkZero(date.getHours()) + ":" + checkZero(date.getMinutes()) + ":" +checkZero(date.getSeconds());
 var hours = date.getHours() ; // gives the value in 24 hours format
                            var AmOrPm = hours >= 12 ? 'PM' : 'AM';
                            hours = (hours % 12) || 12;
var dt = checkZero(date.getDate())+"/"+checkZero((date.getMonth()+1))+"/"+checkZero(date.getFullYear())+ " " + checkZero(date.getHours()) + ":" + checkZero(date.getMinutes()) + ":" +  hours + " "+ AmOrPm;
	var geocoderch = new google.maps.Geocoder();
	geocodeAddress(geocoderch, map);
function geocodeAddress(geocoderch, resultsMap) {
			//	var address = BookID.d[0].Address + "," + BookID.d[0].City + "," + BookID.d[0].State + "," + BookID.d[0].Country + "," + BookID.d[0].PostalCode;
		//	var address1 = 'No 14, 10th Cross Street 1st Ext, AGS Colony, Velachery, Chennai, Tamil Nadu 600042';
			geocoderch.geocode({
				address: address
			}, function (result, stat) {
				if (stat === "OK") {
					debugger
					//  alert(results[0].geometry.location);
					resultsMap.setCenter(result[0].geometry.location);
					pos = result[0].geometry.location;
					//  var json = pos.lat()+pos.lng();
					//  $('#pos').val(results[0].geometry.location);
					//   alert(pos);
					var markerchld = new google.maps.Marker({
						map: resultsMap,
						icon: '../HomeCollection/images/h3.png',
						   position: result[0].geometry.location,
						title: address,
						  suppressMarkers: true

					});
					//                        obj = { lat: markerchld.position.lat(),
					//                            lng: markerchld.position.lng()
					//                        };
					//                        $('#lat').val(obj.lat);
					//                        $('#lng').val(obj.lng);
					directionsRenderer.setMap(map);
					CalandDisplay(directionsService, directionsRenderer);
					// calRoute();

				} else {
				  ValidationWindow('Geocode was not successful for the following reason: '+ stat, 'Information');

				//	alert("Geocode was not successful for the following reason: " + stat);
				}
			});
			}

			
	//table
	var phoaddress= document.getElementById("<%=TextBox1.ClientID %>");
			$('#Phobl').hide();
			$('#demoTable').hide();
			$('#BookingHistory').show();
			$("#BookingHistory").empty();
			$("#BookingHistory").append('<table id="BookHistory" class="gridView responstable w-100p fixResponsTable" cellspacing="0" width="100%"><thead> <tr><th>' +
				'<asp:Label ID="La1" runat="server" Text="Sample Collection"></asp:Label>' +
				'</th><th style="background: #fff!important;color: #000000!important;width:30%;">' + BookID[0].Remarks + '</th><th><asp:Label ID="Lal2" runat="server" Text="Current Location"></asp:Label></th> <th style="background-color: #ffffff!important;color: #000000!important;">' + phaddmar + ' </th></tr>' +
				'<tr><th><asp:Label ID="La4" runat="server" Text="Booking ID "></asp:Label></th>' +
				'<th style="background-color: #fffffe!important;color: #000000;width:30%;">' + BookID[0].BookingID + '</th>' +
				' <th><asp:Label ID="Lal5" runat="server" Text="Patient Name "></asp:Label> </th>' +
				'<th style="background-color:  #fffffe!important;color: #000000">' + BookID[0].Name + '</th> </tr>' +
				'<tr><th><asp:Label ID="Lal6" runat="server" Text="Mobile Number "></asp:Label></th>' +
				' <th style="background-color:  #fffffe!important;color: #000000;width:30%;">' + BookID[0].MobileNumber + '</th>' +
				'<th><asp:Label ID="Lal8" runat="server" Text="Sample Collection Time"></asp:Label></th>' +
				'<th style="background-color:  #fffffe!important;color: #000000">' + dt + '</th> </tr>' +
				'<tr><th><asp:Label ID="Lal3" runat="server" Text="Sl.No. " style="width:10px;"></asp:Label> </th>' +
				'<th><asp:Label ID="Lal10" runat="server" Text="Description" style="width:30%;"></asp:Label></th>' +
				' <th> <asp:Label ID="Lal11" runat="server" Text="TimeStamp"></asp:Label></th>' +

				'<th> <asp:Label ID="Labl9" runat="server" Text="Status" ></asp:Label>   </th>' +
				'                    </tr> </thead></table>');


			$('#BookHistory').DataTable({
 // "bProcessing": true,
    "sAutoWidth": false,
    "bDestroy":true,
    "sPaginationType": "bootstrap", // full_numbers
    "iDisplayStart ": 10,
    "iDisplayLength": 10,
    "bPaginate": false, //hide pagination
    "bFilter": false, //hide Search bar
    "bInfo": false, // hide showing entries
			
				"searching": false,
				"retrieve": true,
 "paging":   false,
        "ordering": false,
        "info":     false,
				"data": BookID,
				// "bJQueryUI": true,
				"bDestroy": true,
			//	"processing": true,
			"columnDefs": [
  //  { className: 'text-right', targets: [0, 2, 3] },
    { className: 'text-center', targets: [3] },
  ], 
				"columns": [{
						"data": "id",
						render: function (data, type, row, meta) {
							return meta.row + meta.settings._iDisplayStart + 1;
						}
					},
					{
						"data": "Reason"
					},
					{
						  "data": "SampleCollectionTime" ,  "render": function (data) {
                            var date = new Date(parseInt(data.substr(6)));
                            var month = date.getMonth() + 1;
                            var hours = date.getHours() ; // gives the value in 24 hours format
                            var AmOrPm = hours >= 12 ? 'PM' : 'AM';
                            hours = (hours % 12) || 12;
                            return date.getDate() + "/" + (month.length > 1 ? month : "0" + month) + "/" + date.getFullYear() + "&nbsp;&nbsp;" +(date.getHours() < 10 ? ("0"+date.getHours()) : date.getHours())+ ":"+(date.getMinutes() < 10 ? ("0"+date.getMinutes()) : date.getMinutes()+ ":"+  hours + " "+ AmOrPm) ; 
                            //return date;
                          //  return date.getDate() + "/" + (month.length > 1 ? month : "0" + month) + "/" + date.getFullYear() + "&nbsp;&nbsp;" +(date.getHours() < 10 ? ("0"+date.getHours()) : date.getHours())+ ":"+(date.getMinutes() < 10 ? ("0"+date.getMinutes()) : date.getMinutes()) ; 
                            //return date;
                        }
                        },
					{
						"data": "Status"
					},

				],


				"oLanguage": {
					"sProcessing": "Fetching Data, Please wait...",
					"searchPanes": {
						emptyPanes: 'There are no panes to display. :/'
					}
				}
			});
			//table
	
	
			};//success booking
			
      } else {
      				  ValidationWindow('No results found', 'Information');

      //  window.alert("No results found");
      }
    } else {
    				  ValidationWindow('Geocoder failed due to: ' + status, 'Information');

    //  window.alert("Geocoder failed due to: " + status);
    }
  });
  


			
			
	
	

		//for (i = 0; i < 1; i++) {


		//	var latude = data.PhleboLocInfo[i].latitude;
		//	var lngitude = data.PhleboLocInfo[i].longitude;

		//	var myLatlng = new google.maps.LatLng(data.PhleboLocInfo[i].latitude,
		//		data.PhleboLocInfo[i].longitude);


		//	var name = "<br />User ID : " + String(data.PhleboLocInfo[i].pk) + "<br />" + "Phlebo Name : " + data.PhleboLocInfo[i].display_name;
//			var marker = new google.maps.Marker({
//				  position: myLatlng,
//				map: map,
//				title: "PhleboLocInfo : " + "\n\n" + "User ID : " + String(data.PhleboLocInfo[i].pk) + "\n" + "Phlebo Name :" + data.PhleboLocInfo[i].display_name,
//				zIndex: 3,
//				suppressMarkers: true,
//				   icon: markerImage,
//			
//				//clickable: true
//			});
			


		


		


	
			
			//parent marker


			
			

//childmarker
	
		
	

		

  var myLatlng = {
    lat: parseFloat(data[0].latitude),
    lng: parseFloat(data[0].longitude)
  };
  var waypts = [];//origin to destination via waypoints
		//waypts.push({location: 'indore', stopover: true});
  // 	var name = "<br />User ID : " + String(data[0].LoginID) + "<br />" + "Phlebo Name : " + BookID[0].Remarks;
		function CalandDisplay(directionsService, directionsRenderer) {
			var selectedMode = "DRIVING";
			directionsService.route({
					origin: myLatlng, //{ lat: 37.77, lng: -122.447 },
					destination: pos, //{ lat: 37.768, lng: -122.511 },
					// Note that Javascript allows us to access the constant
					// using square brackets and a string value as its
					// "property."
					// @ts-ignore
					waypoints: waypts,
					travelMode: google.maps.TravelMode[selectedMode]
				},
				(respone, stats) => {
					if (stats == google.maps.DirectionsStatus.OK) {
						new google.maps.DirectionsRenderer({
							map: map,
							directions: respone,
							suppressMarkers: true
						});
						if (marker != null) { //already set marker to clear
							marker.setMap(null);
							marker = null;
						}
						var leg = respone.routes[0].legs[0];
						makeMarker(leg.start_location, icons.start, name, map);
						makeMarker(leg.end_location, icons.end, "", map);
						localStorage.setItem("autouserid", data[0].LoginID);
autoUpdate();
					} else {
					  ValidationWindow('Unable to retrive route', 'Information');
						//alert("Unable to retrive route");
					}


				});
				
		}
		  }
//parent geolocation
	//	}//if userid check
	//	}//for loop
}//func resp1
}//userid booklist
		//Childmarker
		//source and designation directionsService

		function makeMarker(position, icon, title, map) {
			new google.maps.Marker({
				position: position,
				map: map,
				icon: icon,
				title: title
			});
		}

		var icons = {
			start: new google.maps.MarkerImage(
				// URL
				//  'http://maps.google.com/mapfiles/ms/micons/blue.png',
			//	'../HomeCollection/images/star.png',
			'',
				// (width,height)
				new google.maps.Size(44, 32),
				// The origin point (x,y)
				new google.maps.Point(0, 0),
				// The anchor point (x,y)
				new google.maps.Point(22, 32)),
			end: new google.maps.MarkerImage(
				// URL
				//  'http://maps.google.com/mapfiles/ms/micons/green.png',
			//	'../HomeCollection/images/h3.png',
			'',
				// (width,height)
				new google.maps.Size(44, 32),
				// The origin point (x,y)
				new google.maps.Point(0, 0),
				// The anchor point (x,y)
				new google.maps.Point(22, 32))
		};

//source and designation directionsService



    }

    else {
    //Jazz
  debugger
  /*** General***/
   Loginauth();
  var phebladdress=[];
   var selectedVal = document.getElementById("<%=ddlTechni.ClientID %>").value;
 var markerClusterer = null;

		function refreshMap() {
			if (markerClusterer) {
				markerClusterer.clearMarkers();
			}
		}
		var markers = [];
		var mapOptions = {

			zoom: 12,
			center: new google.maps.LatLng(13.067439, 80.237617),
			mapTypeId: google.maps.MapTypeId.ROADMAP


		};
		var geocoder = new google.maps.Geocoder();
		var infoWindow = new google.maps.InfoWindow();


		var map = new google.maps.Map(document.getElementById("map"), mapOptions);

		var imageUrl = "../HomeCollection/images/p6.png";

		var markerImage = new google.maps.MarkerImage(
			imageUrl,
			new google.maps.Size(24, 32)
		);
		var gmarkers = [];
		
		/*** General ***/
		
		//booking
		
		 if (document.getElementById("<%=ddlTechni.ClientID %>").value !=undefined)
    {
    var UserID=document.getElementById("<%=ddlTechni.ClientID %>").value;
    }
    else{
    var UserID=0;
    }
    var txtBookingNumber = document.getElementById("<%=txtBookingNumber.ClientID %>").value;
    if (txtBookingNumber===undefined ||txtBookingNumber==='')
    {
  
    var txtBookingNumber=0;
    }	
    	$.ajax({
				type: "POST",
				 url: "../HCService.asmx/GetHCMapBookingDetails",
             
                contentType: "application/json; charset=utf-8",
                 data: "{UserID:" + UserID + ",BookingNumber:" + txtBookingNumber + "}",
             //   data:"{pUserID:" + UserID + ",BookingNumber:" + txtBookingNumber + "}",
                dataType: "json",
                async: true,
                paging: true,
			
				context: document.body,
				success: OnSuccessPhbe,
				failure: function (resppheb) {
				ValidationWindow('Unable to Get Booking Data at Present', 'Information');
					// alert("Unable to Get Booking Data at Present");//alert(resppheb.d);
				},
				error: function (resppheb) {
				ValidationWindow('Unable to Get Booking Data at Present', 'Information');
				//	 alert("Unable to Get Booking Data at Present");//alert(resppheb.d);
				}
			});// booking ajax all
			
			function OnSuccessPhbe(resppheb) {
				var fltPhelb=[];
				if (resppheb.d.length>0)
				{
fltPhelb=resppheb.d;
BookIDPhb=fltPhelb;

var filteredValue = BookIDPhb.filter(function (item) {
				return item.UserID == UserID;
			});
		var loginID=filteredValue[0].LoginID;
			 // Store
            localStorage.setItem("LoginID",loginID );

			
			}
		
		
		
		//booking
		
		
		
		
		
		
		
		
		
		/**** ajax *****/
			
		// Retrieve
            	var authtok = localStorage.getItem("authToken");
				var url = "https://13.233.79.89/api/user/location/lastKnown";
           		var auth="Bearer "+ authtok; //eyJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJBRE1JTiIsInN1YiI6IkF1dGhUb2tlbiIsImV4cCI6MTU5NzEyNDA3NCwiaWF0IjoxNTk3MDM3Njc0LCJqdGkiOiJiNTgyNzRkZS05MjQwLTRjYzAtYWUyOS1iZDZjY2VkZTA4ZTYifQ.QTlBTBsxbkUg5yZa4aKIsg7Hg4fIAkmSztBG9M5RCOM";
			$.ajax({
				
				type: "GET",
				//url: "../HCService.asmx/GetHCMapBookingHistDetails",
              	url: url,
                contentType: "application/json; charset=utf-8",
             //   data: data,//JSON.stringify(jsonObjects) ,// "{pUserID'" + pUserID + "}",
                dataType: "json",
                async: true,
                paging: true,
                	headers: {
					Authorization: auth
				//	orgcode: "LIMSAPI"

				},
			
				context: document.body,
				success: OnSucc,
				failure: function (data) {
				 Loginauth();
					//alert(data.d);
					
				},
				error: function (data) {
				// Loginauth();
				ValidationWindow('Select the Today Registered Phlebo', 'Information');
					//alert("Select the Today Registered Phlebo");
					// Loginauth();
				}
			});
	//	});
//            
           	function OnSucc(data) { 
           	debugger
		
		
		var res =[];
res=data.data.PhleboLocInfo;
var loginiduser = localStorage.getItem("LoginID");
var filteredValue = res.filter(function (item) {
				return item.LoginID == loginiduser;
			});
			
		//	alert(filteredValue);
			

		//	var BookID = [];
			
			//To See Output Result as Array
//BookID = resp;
			data = filteredValue;

		
		
		
	
		
		
		
		
		
		/*** Parent MArker **/
		var geocoder = new google.maps.Geocoder();
            geocodeLatLng(geocoder, map, infoWindow);
          
          function geocodeLatLng(geocoder, map, infoWindow) {
			debugger
//  var input = document.getElementById("latlng").value;
 // var latlngStr = input.split(",", 2);
  var myLatlng = {
    lat: parseFloat(data[0].latitude),
    lng: parseFloat(data[0].longitude)
  };
   geocoder.geocode({ location: myLatlng }, (results, status) => {
    if (status === "OK") {
     if (results[0]) {
      	debugger
      //  map.setZoom(11);
   //	var name = "<br />User ID : " + String(data[0].UserID) + "<br />" + "Phlebo Name : " + data[0].display_name;
//   	var mapOptions = {

//			zoom: 12,
//			center: new google.maps.LatLng(13.067439, 80.237617),
//			mapTypeId: google.maps.MapTypeId.ROADMAP


//		};
//	var map = new google.maps.Map(document.getElementById("map"), mapOptions);
//resultsPhMapp.setCenter(myLatlng.geometry.location);
map.setCenter(myLatlng);
var titles= "PhleboLocationInfo : " + " Login ID :" + data[0].LoginID + " Phlebo Name :" + data[0].display_name;
        var markerp = new google.maps.Marker({
   //    zoom:11,
    //    center:new google.maps.LatLng(myLatlng),
        
        	          position: myLatlng,
         // centre:myLatlng,
          map: map,
          //	title: "PhleboLocInfo : " + "\n\n" + "User ID : " + String(data[0].UserID) + "\n" + "Phlebo Name :" + data[0].display_name,
          		title:titles,
				zIndex: 3,
			
				suppressMarkers: true,
				   icon: markerImage,
				    zoomControl: false
        });
         phebladdress=results[0].formatted_address;
       // alert(add);
      // $("#phoaddress").val(add);
        map.setZoom(11);
        phoaddress=phebladdress;
                    localStorage.setItem("phebladdress", phebladdress);
        
    //    document.getElementById("lbltxt").value  = results[0].formatted_address;
        
        infoWindow.setContent(results[0].formatted_address);
        
        (function (markerp, data) {
        
        google.maps.event.addListener(markerp, "click", function (e) {
        
        infoWindow.open(map, markerp, data);
					
					markerp.setIcon("../HomeCollection/images/star.png");

					infoWindow.setContent("<b>PhleboLocationInfo : </b><br/>" + "\n\n" + "Login ID :" + data[0].LoginID + "\n\n<br/>" + "Phlebo Name :" + data[0].display_name);
					
                    map.setCenter(markerp.getPosition());
                    
                    $('#Phobl').show();
					$('#demoTable').empty();
					$('#Phobl').empty();
					$('#BookingHistory').hide();
					//  $('#trdemotable').empty();
					var myObj = [];
					myObj = data[0];
                     if (document.getElementById("<%=ddlTechni.ClientID %>").value !=undefined)
    {
    var UserID=document.getElementById("<%=ddlTechni.ClientID %>").value;
    }
    else{
    var UserID=0;
    }
    var txtBookingNumber = document.getElementById("<%=txtBookingNumber.ClientID %>").value;
    if (txtBookingNumber===undefined ||txtBookingNumber==='')
    {
  
    var txtBookingNumber=0;
    }
    var loginiduser = localStorage.getItem("LoginID");	
    	$.ajax({
				type: "POST",
				 url: "../HCService.asmx/GetHCMapBookingDetails",
             
                contentType: "application/json; charset=utf-8",
                 data: "{UserID:" + UserID + ",BookingNumber:" + txtBookingNumber + "}",
             //   data:"{pUserID:" + UserID + ",BookingNumber:" + txtBookingNumber + "}",
                dataType: "json",
                async: true,
                paging: true,
			
				context: document.body,
				success: OnSuccessPhe,
				failure: function (respphe) {
				
  ValidationWindow('Unable to Get Booking Data at Present', 'Information');
				//	 alert("Unable to Get Booking Data at Present");//alert(respphe.d);
				},
				error: function (respphe) {
				
  ValidationWindow('Unable to Get Booking Data at Present', 'Information');
				//	 alert("Unable to Get Booking Data at Present");//alert(respphe.d);
				}
			});// booking ajax all
			
			function OnSuccessPhe(respphe) {
			
			var pheoadd=document.getElementById('<%= this.phoaddress.ClientID %>');// document.getElementById("phoaddress").innerHTML 
	var UserID=document.getElementById("<%=ddlTechni.ClientID %>").value;
			var fltPhel=[];
			if (respphe.d.length>0)
			{
fltPhel=respphe.d;
BookIDPh=fltPhel;

// Retrieve
            	var phoaddress = localStorage.getItem("phebladdress");
$("#Phobl").append('<table id="demoTable" class="gridView responstable w-100p fixResponsTable" cellspacing="0" width="100%"><thead> <tr><th>' +
						'<asp:Label ID="LblSampleColl" runat="server" Text="Sample Collection" ></asp:Label>' +
						'</th><th style="background-color: #fffffe!important;color: #000000!important;" colspan="3">' + BookIDPh[0].Remarks + '</th><th><asp:Label ID="LblPhoNam" runat="server" Text="Current Location"></asp:Label></th> <th  style="background-color: #fffffe!important;color: #000000!important;" colspan="2">' + phoaddress + '</th></tr>' +
						'<tr><th><asp:Label ID="Lblso" runat="server" Text="Sl.No. " style="width:5px;"></asp:Label> </th>' +
						'<th> <asp:Label ID="LblBookID" runat="server" Text="Booking ID " style="width:5px;"></asp:Label></th>' +
						'<th><asp:Label ID="LblPatName" runat="server" Text="Patient Name "></asp:Label> </th>' +
						'<th> <asp:Label ID="LblMobNumber" runat="server" Text="Mobile Number "></asp:Label> </th>' +
						'<th><asp:Label ID="LblLoc" runat="server" Text="Location"></asp:Label>  </th>' +
						'<th> <asp:Label ID="LblSampleCollTime" runat="server" Text="Sample Collection Time"></asp:Label> </th>' +
						'<th> <asp:Label ID="LblStat" runat="server" Text="Status"></asp:Label>  </th>' +
						'                    </tr> </thead></table>');
						
						
						
						
						$('#demoTable').DataTable({

						   "paging": true,
						   "lengthMenu": [5,10, 25, 50, 75, 100 ],
"pageLength": 3,
						"retrieve": true,
"searching": false,
						"data": BookIDPh,
						"bJQueryUI": true,
						"bDestroy": true,
						"columns": [{
								"data": "id",
								render: function (data, type, row, meta) {
									return meta.row + meta.settings._iDisplayStart + 1;
								}
							},
							{
								"data": "BookingID"
							},
							{
								"data": "Name"
							},
							{
								"data": "MobileNumber"
							},

							{
								"data": "Address"
							},
							  { "data": "SampleCollectionTime" ,  "render": function (data) {
                           
 var date = new Date(parseInt(data.substr(6)));
                            var month = date.getMonth() + 1;
                              var hours = date.getHours() ; // gives the value in 24 hours format
                            var AmOrPm = hours >= 12 ? 'PM' : 'AM';
                            hours = (hours % 12) || 12;
                             return date.getDate() + "/" + (month.length > 1 ? month : "0" + month) + "/" + date.getFullYear() + "&nbsp;&nbsp;" +(date.getHours() < 10 ? ("0"+date.getHours()) : date.getHours())+ ":"+(date.getMinutes() < 10 ? ("0"+date.getMinutes()) : date.getMinutes()+ ":"+ "0" + hours + " "+ AmOrPm) ; 
                            //return date;
                        }},
							{
								"data": "Status"
							},
						],
						"oLanguage": {
							"sProcessing": "Fetching Data, Please wait..."
						}
					});/// end of datatable constructor
//newbooking marker
					setMarkers(map);
					function setMarkers(map) {
					var geocoder;
						// Adds markers to the map.
						// Marker sizes are expressed as a Size of X,Y where the origin of the image
						// (0,0) is located in the top left of the image.
						// Origins, anchor positions and coordinates of the marker increase in the X
						// direction to the right and in the Y direction down.
						var image = {
							url: "../HomeCollection/images/h4.png",
							//  "https://developers.google.com/maps/documentation/javascript/examples/full/images/beachflag.png",
							// This marker is 20 pixels wide by 32 pixels high.
							size: new google.maps.Size(20, 32),
							// The origin for this image is (0, 0).
							origin: new google.maps.Point(0, 0),
							// The anchor for this image is the base of the flagpole at (0, 32).
							anchor: new google.maps.Point(0, 32)
						}; // Shapes define the clickable region of the icon. The type defines an HTML
						// <area> element 'poly' which traces out a polygon as a series of X,Y points.
						// The final coordinate closes the poly by connecting to the first coordinate.

						var shape = {
							coords: [1, 1, 1, 20, 18, 20, 18, 1],
							type: "poly"
						};
						
							var beach =[];
						for (var i = 0; i < BookIDPh.length; i++) {
						
						geocoder = new google.maps.Geocoder();
							 beach = BookIDPh[i];
							var BookingNos = String(beach.BookingID);
							var BookingNo = beach.BookingID;
							var address = beach.Address;
						

							var geocoderchp = new google.maps.Geocoder();
	geocodeAddressp(geocoderchp, map);
	function geocodeAddressp(geocoderchp, resultsMapp) {
		var details = "<br />Booking ID : " + String(beach.BookingID) + "<br />" + "Patient Name : " + beach.Name ;//+ "<br />" + "Patient Address : " + beach.Address
	var address1=[];
address1 = beach.Address + "," + beach.City + "," + beach.State + "," + beach.Country + "," + beach.PostalCode;
var bookid=beach.BookingID;
geocoderchp.geocode({
				address: address1
			}, function (res, sta) {
			if (sta === "OK") {
					debugger
					resultsMapp.setCenter(res[0].geometry.location);
					posp = res[0].geometry.location;
					//  var json = pos.lat()+pos.lng();
					//  $('#pos').val(results[0].geometry.location);
					//   alert(pos);
					var marker= new google.maps.Marker({
						map: resultsMapp,
						icon:image,
						   position: res[0].geometry.location,
						title: address1,
						  suppressMarkers: true

					});
					
					var infowindow = new google.maps.InfoWindow();
							var directionsService = new google.maps.DirectionsService();
							var directionsRenderer = new google.maps.DirectionsRenderer();
					
					
					(function (i, marker) {
							debugger
						
							
							google.maps.event.addListener(marker, 'click', function () {
								debugger
								var filteredValue = BookIDPh.filter(function (item) {
				return item.BookingID == bookid;
			});
									var beachBook = []; 
							beachBook= filteredValue;
							
							
								if (!infowindow) {
										infowindow = new google.maps.InfoWindow();
									}
									 marker.setIcon(null);
								//	marker.setIcon("../HomeCollection/images/h3.png");
									infowindow.setContent(details);

									infowindow.open(map, marker);
									var date = new Date(parseInt(beachBook[0].SampleCollectionTime.substr(6)));
								
							//	var date = new Date(parseInt(beach.SampleCollectionTime));
function checkZero(data){
  if(data.length === 1){
    data = "0" + data;
  }
  return data;
}
  var hours = date.getHours() ; // gives the value in 24 hours format
                            var AmOrPm = hours >= 12 ? 'PM' : 'AM';
                            hours = (hours % 12) || 12;
var bookno = beachBook[0].BookingID;
var dt = checkZero(date.getDate())+"/"+checkZero((date.getMonth()+1))+"/"+checkZero(date.getFullYear())+ " " + checkZero(date.getHours()) + ":" + checkZero(date.getMinutes())  + ":" + "0" + hours + " "+ AmOrPm;


$.ajax({
				type: "POST",
				 url: "../HCService.asmx/GetHCMapBookingHistDetails",
             
                contentType: "application/json; charset=utf-8",
                 data: "{UserID:" + loginiduser + ",BookingNumber:" + bookno + "}",
             //   data:"{pUserID:" + UserID + ",BookingNumber:" + txtBookingNumber + "}",
                dataType: "json",
                async: true,
                paging: true,
			
				context: document.body,
				success: OnSuccess,
				failure: function (resp) {
				 alert("Unable to Get Booking Data at Present");//	alert(resp.d);
				},
				error: function (resp) {
				 alert("Unable to Get Booking Data at Present");//	alert(resp.d);
				}
			});
			
			//sucess booking
			function OnSuccess(resp) {
			debugger
			
			var result = [];
			result = JSON.stringify(resp);
			
			// alert(result);
			var BookingNumber = document.querySelector("input[id*='txtBookingNumber']");
			var flt=[];
flt=resp.d;
var BookID = [];
BookID=flt;
var address = BookID[0].Address + "," + BookID[0].City + "," + BookID[0].State + "," + BookID[0].Country + "," + BookID[0].PostalCode;
var date = new Date(parseInt(BookID[0].SampleCollectionTime.substr(6)));
function checkZero(data){
  if(data.length === 1){
    data = "00" + data;
  }
  return data;
}
 var hours = date.getHours() ; // gives the value in 24 hours format
                            var AmOrPm = hours >= 12 ? 'PM' : 'AM';
                            hours = (hours % 12) || 12;
var dt = checkZero(date.getDate())+"/"+checkZero((date.getMonth()+1))+"/"+checkZero(date.getFullYear())+ " " + checkZero(date.getHours()) + ":" + checkZero(date.getMinutes()) + ":" +checkZero(date.getSeconds())+ ":" + "0" + hours + " "+ AmOrPm;
var geocoderchd = new google.maps.Geocoder();
	geocodeAddressd(geocoderchd, map);
	function geocodeAddressd(geocoderchd, resultsMapch) {
	var address = BookID[0].Address + "," + BookID[0].City + "," + BookID[0].State + "," + BookID[0].Country + "," + BookID[0].PostalCode;
	
		geocoderchd.geocode({
				address: address
			}, function (resu, statd) {
			if (statd === "OK") {
					debugger
					resultsMapch.setCenter(resu[0].geometry.location);
				var poss = resu[0].geometry.location;
				//	alert(posu)
			//	 posu=JSON.stringify(poss);
			//	alert(posu);
			//marker.setIcon(null);
		//	marker.setIcon("../Homecollection/images/h3.png");
					var marker = new google.maps.Marker({
						map: resultsMapch,
					//	icon: '../HomeCollection/images/h3.png',
						icon: '',
						   position: resu[0].geometry.location,
						title: address,
						  suppressMarkers: true

					});
					//	marker.setIcon(null);
						//var directionsService = new google.maps.DirectionsService();
						//	var directionsRenderer = new google.maps.DirectionsRenderer();
			//	marker.setIcon("../Homecollection/images/h3.png");
					
					//table
//	var phoadd=document.getElementById("<%=phoaddress.ClientID %>").value;
			$('#Phobl').hide();
			$('#demoTable').hide();
			$('#BookingHistory').show();
			$("#BookingHistory").empty();
			$("#BookingHistory").append('<table id="BookHistory" class="gridView responstable w-100p fixResponsTable" cellspacing="0" width="100%"><thead> <tr><th>' +
				'<asp:Label ID="Lab11" runat="server" Text="Sample Collection"></asp:Label>' +
				'</th><th style="background: #fff!important;color: #000000!important;width:30%;">' + BookID[0].Remarks + '</th><th><asp:Label ID="Labl21" runat="server" Text="Current Location"></asp:Label></th> <th style="background-color: #ffffff!important;color: #000000!important;">' + phoaddress + ' </th></tr>' +
				'<tr><th><asp:Label ID="Lab41" runat="server" Text="Booking ID "></asp:Label></th>' +
				'<th style="background-color: #fffffe!important;color: #000000;width:30%;">' + BookID[0].BookingID + '</th>' +
				' <th><asp:Label ID="Labl51" runat="server" Text="Patient Name "></asp:Label> </th>' +
				'<th style="background-color:  #fffffe!important;color: #000000">' + BookID[0].Name + '</th> </tr>' +
				'<tr><th><asp:Label ID="Labl61" runat="server" Text="Mobile Number "></asp:Label></th>' +
				' <th style="background-color:  #fffffe!important;color: #000000;width:30%;">' + BookID[0].MobileNumber + '</th>' +
				'<th><asp:Label ID="Lab81" runat="server" Text="Sample Collection Time"></asp:Label></th>' +
				'<th style="background-color:  #fffffe!important;color: #000000">' + dt + '</th> </tr>' +
				'<tr><th><asp:Label ID="Labl31" runat="server" Text="Sl.No. " style="width:10px;"></asp:Label> </th>' +
				'<th><asp:Label ID="Labl101" runat="server" Text="Description" style="width:30%;"></asp:Label></th>' +
				' <th> <asp:Label ID="Labl111" runat="server" Text="TimeStamp"></asp:Label></th>' +

				'<th> <asp:Label ID="Labbl91" runat="server" Text="Status" ></asp:Label>   </th>' +
				'                    </tr> </thead></table>');


			$('#BookHistory').DataTable({

			// "bProcessing": true,
    "sAutoWidth": false,
    "bDestroy":true,
    "sPaginationType": "bootstrap", // full_numbers
    "iDisplayStart ": 10,
    "iDisplayLength": 10,
    "bPaginate": false, //hide pagination
    "bFilter": false, //hide Search bar
    "bInfo": false, // hide showing entries
			
				"searching": false,
				"retrieve": true,
 "paging":   false,
        "ordering": false,
        "info":     false,
				"data": BookID,
				// "bJQueryUI": true,
				"bDestroy": true,
			//	"processing": true,
				"columns": [{
						"data": "id",
						render: function (data, type, row, meta) {
							return meta.row + meta.settings._iDisplayStart + 1;
						}
					},
					{
						"data": "Reason"
					},
					{
						  "data": "SampleCollectionTime" ,  "render": function (data) {
                            var date = new Date(parseInt(data.substr(6)));
                            var month = date.getMonth() + 1;
                             var hours = date.getHours() ; // gives the value in 24 hours format
                            var AmOrPm = hours >= 12 ? 'PM' : 'AM';
                            hours = (hours % 12) || 12;
                            return date.getDate() + "/" + (month.length > 1 ? month : "0" + month) + "/" + date.getFullYear() + "&nbsp;&nbsp;" +(date.getHours() < 10 ? ("0"+date.getHours()) : date.getHours())+ ":"+(date.getMinutes() < 10 ? ("0"+date.getMinutes()) : date.getMinutes()+ ":"+ "0" + hours + " "+ AmOrPm) ; 
                            //return date;
                        }
                        },
					{
						"data": "Status"
					},

				],


				"oLanguage": {
					"sProcessing": "Fetching Data, Please wait..."
//					"searchPanes": {
//						emptyPanes: 'There are no panes to display. :/'
					//}
				}
			});
			//table
	
						directionsRenderer.setMap(map);
					CalandDisplayl(directionsService, directionsRenderer);
					// var myLatlng = new google.maps.LatLng(data.PhleboLocInfo[0].latitude,
          //  data.PhleboLocInfo[0].longitude);
          
						
					
					}//if (statd === "OK") 
					else {
					alert("Geocode was not successful for the following reason: " + statd);
				}//ifelse (statd === "OK") 
					var waypts = [];//origin to destination via waypoints
		//waypts.push({location: 'indore', stopover: true});
			  function CalandDisplayl(directionsService, directionsRenderer) {
						var selectedMode = "DRIVING";
						var myLatlng = {
    lat: parseFloat(data[0].latitude),
   lng: parseFloat(data[0].longitude)
  };
	var	myLatlngchld=posu;
  //var myLatlngchld = parseFloat(posu);
						//	marker.setIcon(null);
						debugger
						directionsService.route({
											origin: myLatlng, //{ lat: 37.77, lng: -122.447 },
											destination: resu[0].geometry.location, //{ lat: 37.768, lng: -122.511 },
											// Note that Javascript allows us to access the constant
											// using square brackets and a string value as its
											// "property."
											// @ts-ignore
											//	waypoints: waypts,
											travelMode: google.maps.TravelMode[selectedMode]
										},
										(respone, stats) => {
										
										if (stats == google.maps.DirectionsStatus.OK) {
												new google.maps.DirectionsRenderer({
													map: map,
													directions: respone,
													suppressMarkers: true
												});

												var leg = respone.routes[0].legs[0];
												makeMarker(leg.start_location, icons.start, markerp.title, map);
												makeMarker(leg.end_location, icons.end,  marker.title, map);
													localStorage.setItem("autouserid", loginiduser);
autoUpdate();
											} //if
											else {
												alert("Unable to retrive route");
											}//stats
											
									
										});//directionsService.
						
						
						}//CalandDisplay
		
			
			
			
			});//	geocoderchd.geocode
	
	
	
	}//function geocodeAddressd(geocoderchd, resultsMapch) 
			
			
			}//function OnSuccess(resp)


								
								});//google.maps.event.addListener(marker, 
							
							
							})(i, marker);//(function (i, marker)
					
					function makeMarker(position, icon, title, map) {
									new google.maps.Marker({
										position: position,
										map: map,
										icon: icon,
										title: title
									});
								}// makeMarker
								var icons = {
									start: new google.maps.MarkerImage(
										
										//  '../HomeCollection/images/star.png',
										'',
										// (width,height)
										new google.maps.Size(44, 32),
										// The origin point (x,y)
										new google.maps.Point(0, 0),
										// The anchor point (x,y)
										new google.maps.Point(22, 32)),
									end: new google.maps.MarkerImage(
										// URL
										//  'http://maps.google.com/mapfiles/ms/micons/green.png',
									//	 '../HomeCollection/images/h3.png',
									'',
										new google.maps.Size(44, 32),
										// The origin point (x,y)
										new google.maps.Point(0, 0),
										// The anchor point (x,y)
										new google.maps.Point(22, 32))
								};
					
					}//if (sta === "OK")
					else {
					
  ValidationWindow('Geocode was not successful for the following reason:'+ sta, 'Information');
				//	alert("Geocode was not successful for the following reason: " + sta);
				}////ifelse (sta === "OK")
			
			
			});//geocoderchp.geocode({ home marker list

	
	
	}//function geocodeAddressp(geocoderchp, resultsMapp) 
						
						}//for (var i = 0; i < BookIDPh.length; i++)
					
					}//function setMarkers(map) 
					
			}
			else
			{
			ValidationWindow('Bookings not alloted today for this Phlebo', 'Information');
			//alert("Bookings not alloted today for this Phlebo");
			}
			}//function OnSuccessPhe(respphe)
			
                    
        
        
        
        });//google.maps.event.addListener(markerp
        
        })(markerp, data);//(function (markerp, data)
			gmarkers.push(markerp);
      /***/
        refreshMap();
		var zoom = parseInt(12, 20);
		var size = parseInt(40, 10);
		var style = parseInt(3, 10);
		zoom = zoom == -1 ? null : zoom;
		size = size == -1 ? null : size;
		style = style == -1 ? null : style;

		markerClusterer = new MarkerClusterer(map, gmarkers, {
			maxZoom: zoom,
			gridSize: size,
			styles: styles[style],
			clusterClass: style === 3 ? 'custom-clustericon' : undefined
		});

		function clearClusters(e) {
			e.preventDefault();
			e.stopPropagation();
			markerClusterer.clearMarkers();
		}

		function clearMarkers() {
			for (var i = 0; i < cmarkers.length; i++) {
				cmarkers[i].setMap(null);
			}
			cmarkers = [];
		}
		
      /***/
        
        
        
        }//if result[0] ok
        else {
          ValidationWindow('No results found', 'Information');
       // window.alert("No results found");
      }//ifelse result[0] ok
    
    }//if status ok
    else {
      ValidationWindow('Geocoder failed due to:'+ status, 'Information');
    //  window.alert("Geocoder failed due to: " + status);
    }//ifelse status ok
   
   });//geocoder Parent marker kocation
  
  }//geocodeLatLng PArentMArker
	 
    }
//    else
//    {
//    alert("Booking not alloted for this Phlebo today");
//    }
  }//	function OnSucc(data)  phelo
    
    
    
}//else if
}//getBoking info


//	 var myLatlng = {
//    lat: parseFloat(datas.PhleboLocInfo[0].latitude),
//    lng: parseFloat(datas.PhleboLocInfo[0].longitude)
//  };
	function autoUpdate() {
	Loginauth();
	// Retrieve
            	var authtok = localStorage.getItem("authToken");
            	
            	
            	var UserLoginID = localStorage.getItem("autouserid");
           		var url = "https://13.233.79.89/api/user/"+UserLoginID+"/location/lastKnown?externalId=true";
           		var auth="Bearer " + authtok;//"Bearer eyJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJBRE1JTiIsInN1YiI6IkF1dGhUb2tlbiIsImV4cCI6MTU5NjgxNjMzNywiaWF0IjoxNTk2NzI5OTM3LCJqdGkiOiJiNTgyNzRkZS05MjQwLTRjYzAtYWUyOS1iZDZjY2VkZTA4ZTYifQ.tjDw4056frlV9vEIk7JJd7i1SYwoK13qrqnpJH1Rebc";
			$.ajax({
				
				type: "GET",
				//url: "../HCService.asmx/GetHCMapBookingHistDetails",
              	url: url,
                contentType: "application/json; charset=utf-8",
             //   data: "externalId=" + "true",
                dataType: "json",
                async: true,
                paging: true,
                	headers: {
					Authorization: auth
				//	orgcode: "LIMSAPI"

				},
			
				context: document.body,
				success: OnSucc,
				failure: function (data) {
					//alert(data.d);
					  Loginauth();
				},
				error: function (data) {
				ValidationWindow('Select the Today Registered Phlebo', 'Information');
					//alert("Select the Today Registered Phlebo");
					  Loginauth();
				}
			});
	//	});
//            
           	function OnSucc(data) { 
           	debugger
  navigator.geolocation.getCurrentPosition(function(position) {  
    var newPoint = new google.maps.LatLng(parseFloat(data.data.PhleboLocInfo[0].latitude), 
                                          parseFloat(data.data.PhleboLocInfo[0].longitude));

    if (marker) {
      // Marker already created - Move it
      marker.setPosition(newPoint);
    }
    else {
      // Marker does not exist - Create it
      marker = new google.maps.Marker({
        position: newPoint,
        map: map
      });
    }

    // Center the map on the new position
    map.setCenter(newPoint);
  }); 

  // Call the autoUpdate() function every 5 seconds
  setTimeout(autoUpdate, 120000);
  }
}


</script>



<table id="Table1" runat="server" width="100%">
    <tr>
        <td id="Td1" runat="server" width="50%">
            <table id="btnSearchArea" class="dataheader3 w-100p" runat="server" width="50%" style="border: none;">
                <tr id="Tr7" runat="server" class="w-100p">
                    <td id="Td44" runat="server">
                        <asp:Label ID="lblTechni" runat="server" Text="Technician"></asp:Label>
                    </td>
                    <td id="Td45" runat="server">
                        <asp:DropDownList ID="ddlTechni" runat="server" ClientIDMode="Static" CssClass="ddlsmall" OnSelectedIndexChanged = "OnSelectedIndexChanged">
                            <asp:ListItem Text="--Select All--" Value="0"></asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td id="tdBookingNo1" runat="server">
                      
                        <asp:Label ID="lblBookno" runat="server" Text="Booking Number"></asp:Label>
                    </td>
                    <td id="tdBookingNo2" runat="server">
                       
                        <asp:TextBox ID="txtBookingNumber" CssClass="Txtboxsmall" runat="server" MaxLength="250"
                           ></asp:TextBox>
                    </td>
                    <td id="Td48" runat="server">
                        <asp:Button ID="btnClear" runat="server" Text="Clear" CssClass="btn" Style="margin-left: 0px"
                             />
                           
                          <asp:Button ID="btnSearch" CssClass="btn" Text="Search"  runat="server" OnClientClick="GetBookingInfo();return false;"
                             />
                             <input type="text" class="form-control input-sm" name="lat" id="lat" hidden/>


<input type="text" class="form-control input-sm" name="lng" id="lng" hidden/>
                    </td>
                </tr>
            </table>
        </td>
        <td>
        </td>
    </tr>
    <tr>
        <td id="Td2" runat="server">
            <br />
            <div id="map-container">
                <div id="map" style="border: 5px solid #5E5454;" />
            </div>
             <div id="warnings-panel"></div>
        </td>
        <td align="center">
     
            <div id="Phobl">
            
            </div>
            <div id="BookingHistory">
            </div>
        </td>
    </tr>
    <tr><td align="right" ></td>
<td><b><asp:label id="lbltxt" runat="server"/></b></td>
</tr>
<tr><td align="right"></td>
<td><b><asp:label id="lblid" runat="server"/> <asp:TextBox ID="TextBox1" CssClass="Txtboxsmall" runat="server" MaxLength="250" Visible=false
                           ></asp:TextBox></b></td>
</tr>
</table>
<input id="hdnOrgID" type="hidden" value="0" runat="server" />
<input id="mymarkerdomid" type="hidden" value="0" runat="server" />
<input id="poslat" type="hidden" value="0" runat="server" />
<input id="poslng" type="hidden" value="0" runat="server" />
<input id="phoaddress" type="hidden" value="" runat="server" />
<input id="locationpincode" type="hidden" value="" runat="server" />


