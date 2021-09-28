<%@ Control Language="C#" AutoEventWireup="true" CodeFile="TrfScan.ascx.cs" Inherits="CommonControls_TrfScan" %>
<%--<script type="text/javascript" src="../Scripts/scanner.js"></script>--%>
<table class="dataheaderInvCtrl w-20p searchPanel" style="background-color: White;">
    <tr class="Duecolor h-22 a-center">
        <td class="w-90p" colspan="16">
            <asp:Label ID="lblpatdet" runat="server" Font-Bold="True" Text="TRF Scan" meta:resourcekey="lblpatdetResource1"></asp:Label>
        </td>
        <td class="w-10p">
       <img id="img1" class="scannerimg"  onclick="onscanclick();" src="../Images/icons8-scanner-30.png"  alt="Close" style=" cursor:pointer; text-align: center;background-color: #eff3f6;" />
    </td>
    </tr>
<%--    <tr>
    <td style="text-align:center;background-color: #eff3f6;"  >
    <%--<input type="button" value="Scan Docs" id="btnScanner" onclick="onscanclick();" />
 <label id="btnScanner"  style="text-decoration:underline; cursor:pointer;" onclick="onscanclick();"> Scan Docs  </label>
   <img id="img2"  onclick="onscanclick();" src="../Images/icons8-scanner-30.png"  alt="Close" style="cursor: pointer;" />
                    
    </td>
    </tr>
     <button type="button" onclick="scanToJpg();">Scan</button>--%>
</table>
<style type="text/css">

.abtn
{ 
width:180px;
margin-top:5px;
margin-left:30px;
font-size:14px;
height:35px;
}
img .scannerimg:hover
{
    background-color:red;
    }

</style>

<ajc:ModalPopupExtender ID="ModalPopupExtender2" runat="server" BackgroundCssClass="modalBackground"
    DynamicServicePath="" TargetControlID="hidForModel" CancelControlID="imgPopupCloseAliqout"
    PopupControlID="PanelAliqout">
</ajc:ModalPopupExtender>
<asp:Panel ID="PanelAliqout" BorderWidth="1px" runat="server" Width="600px" Height="400px"
    CssClass="modalPopup dataheaderPopup" Style="display: block; z-index: 999;" meta:resourcekey="PanelAliqoutResource1">
    <table width="100%">
    <tr>
            <td>
            </td>
            <td align="right">
                <img id="imgPopupCloseAliqout" src="../Images/dialog_close_button.png" runat="server"
                    alt="Close" style="cursor: pointer;" />
            </td>
        </tr>
        <tr>
            <td>
                <div id="dwtcontrolContainer">
                </div>
            </td>
            <td>
                <ul style="list-style: none;">
                    <li >
                        <input type="button" class="btn abtn" value="ScanImage" onclick="AcquireImage();" /></li>
                    <li style="display:none;">
                        <input type="button" class="btn abtn" value="Upload" onclick="btnUpload_onclick();" /></li>
                    <li >
                        <input type="button" class="btn abtn" value="Remove Selected Image" onclick="removeImage('selected');" /></li>
                    <li >
                        <input type="button" class="btn abtn" value="Remove All Images" onclick="removeImage('all');" /></li>
                        <li >
                        <input type="button" class="btn abtn" value="Close" onclick="oncloseclick();" /></li>
                </ul>
            </td>
        </tr>
        
    </table>
</asp:Panel>
<asp:HiddenField ID="hidForModel" runat="server" />

<style type="text/css">
.btn-group input { 
    background-color: #4CAF50;
    border: 1px solid green;
    color: white;
    padding: 10px 24px; 
    cursor: pointer;
    width: 200px; 
    display: block; 
}
</style>

<script type="text/javascript" src="Resources/dynamsoft.webtwain.initiate.js"></script>

<script type="text/javascript" src="Resources/dynamsoft.webtwain.config.js"></script>

<script type="text/javascript">
    function onscanclick() {
        var PopUpOpen = $find('ucTrfScanner_ModalPopupExtender2');
        PopUpOpen.show();
    }
    function oncloseclick() {
        $('#ucTrfScanner_imgPopupCloseAliqout').click();
        
     }
    function removeImage(type) {
        if (type == 'selected') {
            //            DWObject.SelectedImagesCount = 2;
            //            for (var i = 0; i < 2; i++) {
            //                DWObject.SetSelectedImageIndex(i, i + 1);
            //            }
            DWObject.RemoveAllSelectedImages();
        }
        if (type == 'all') {

            DWObject.RemoveAllImages();
        }
    }
    function OnHttpUploadSuccess() {
        console.log('successful');
    }
    function OnHttpUploadFailure(errorCode, errorString, sHttpResponse) {
        alert(errorString + sHttpResponse);
    }

    function btnUpload_onclick() {
        var strstrHTTPServer = location.hostname; //The name of the HTTP server. 
        var CurrentPathName = unescape(location.pathname);
        var CurrentPath = CurrentPathName.substring(0,
          CurrentPathName.lastIndexOf("/") + 1);
     //   var strActionPage = CurrentPath + "SaveToFile.aspx";
      //  DWObject.IfSSL = false; // Set whether SSL is used
      //  DWObject.HTTPPort = location.port == "" ? 80 : location.port;


        // Upload the image of a specified index in 
        // Dynamic Web TWAIN viewer to the HTTP server asynchronously
        // if (document.getElementById("JPEG").checked) {
//        DWObject.HTTPUploadThroughPost(
//          'http://localhost:9603',
//          DWObject.CurrentImageIndexInBuffer,
//          'WebApp/SaveScann.aspx',
//          "imageData.jpg",
//          OnHttpUploadSuccess,
//          OnHttpUploadFailure
//        );
        var i = 0;
        DWObject.ClearAllHTTPFormField();
        DWObject.SetHTTPFormField("UploadedImagesCount", DWObject.HowManyImagesInBuffer);
        function asyncFailureFunc(errorCode, errorString) {
            alert("ErrorCode: " + errorCode + "\r" + "ErrorString:" + errorString);
        }
        var convertImage = function(_index) {
            DWObject.ConvertToBlob([_index], EnumDWT_ImageType.IT_JPG,
      function(result) {
     DWObject.SetHTTPFormField('image_' + _index, result, 'JPG_image_' + _index);
     i++;
     if (i < DWObject.HowManyImagesInBuffer) {
         convertImage(i);
     }
     else {
         DWObject.HTTPUpload("http://localhost:9603/WebApp/SaveScann.aspx?pid=" + $('#hdnpatientid').val() + "&vid=" + $('#hdnVisitID').val(), OnHttpUploadSuccess, OnHttpUploadFailure);
     }
 }, asyncFailureFunc);
        }
        convertImage(0);
    }
    function scanToJpg() {
        scanner.scan(displayImagesOnPage,
   {
       "output_settings":
      [
         {
             "type": "return-base64",
             "format": "jpg"
         }
      ]
   }
   );
    }
    function displayImagesOnPage(successful, mesg, response) {
        if (!successful) { // On error
            console.error('Failed: ' + mesg);
            return;
        }

        if (successful && mesg != null && mesg.toLowerCase().indexOf('user cancel') >= 0) { // User canceled.
            console.info('User canceled');
            return;
        }

        var scannedImages = scanner.getScannedImage(response, true, false); // returns an array of ScannedImage
        for (var i = 0; (scannedImages instanceof Array) && i < scannedImages.length; i++) {
            var scannedImage = scannedImages[i];
            processScannedImage(scannedImage);
        }
    }

    /** Images scanned so far. */
    var imagesScanned = [];

    /** Processes a ScannedImage */
    function processScannedImage(scannedImage) {
        imagesScanned.push(scannedImage);
        var elementImg = createDomElementFromModel({
            'name': 'img',
            'attributes': {
                'class': 'scanned',
                'src': scannedImage.src
            }
        });
        document.getElementById('images').appendChild(elementImg);
    }
    var DWObject;
    function AcquireImage() {
        DWObject = Dynamsoft.WebTwainEnv.GetWebTwain('dwtcontrolContainer');
        DWObject.ProductKey = 't0112CQIAAF9AG1pTn6qd3mx+8LX/+lrPt0p0ZSSev6IGZnTFlRPAWv2V9Dsc2xCs9QzErvF11kfy+Vl5aS4UKt+3Il8lrGxdtAwtmJU67Bid9crd2I8p/NmLJ3VSxIN8owvGfEPuPIrR7klURDIuOyFlsA==';
        if (DWObject) {
            DWObject.SetViewMode(2, 2);
            DWObject.SelectSource(function() {
                var OnAcquireImageSuccess = OnAcquireImageFailure = function() {
                    DWObject.CloseSource();
                };
                DWObject.OpenSource();
//                DWObject.IfDisableSourceAfterAcquire = true;
//              //  DWObject.PixelType = EnumDWT_PixelType.TWPT_RGB;
//                DWObject.PixelType = EnumDWT_PixelType.TWPT_GRAY;
//                DWObject.BitDepth = 24;
//                DWObject.PageSize = EnumDWT_CapSupportedSizes.TWSS_A4;
//                DWObject.Resolution = 300;
//               // DWObject.IfFeederEnabled = true;
//                DWObject.IfDuplexEnabled = true;
//                DWObject.IfAppendImage = false;
//               // DWObject.IfDisableSourceAfterAcquire = true;
                DWObject.AcquireImage(OnAcquireImageSuccess, OnAcquireImageFailure);
            }, function() {
                console.log('SelectSource failed!');
            });
        }
    }
</script>

