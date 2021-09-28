<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ImageUploadManager.ascx.cs"
    Inherits="ImageUploadManager" EnableViewState="true" %>

<script language="javascript" type="text/javascript">

    var counter = 0;

    function FinishImagePreview(rValue) {
        //alert(rValue);
        document.getElementById(lblMessageId).style.display = "none";
        // The new path will contain the path of the image on the server
        var rArray = new Array();
        rArray = rValue.split("~");
        //alert(rArray[0]);
        if (rArray[0] == "Error") {
            alert(rArray[1]);
            document.getElementById('<%= upload_progress.ClientID%>').style.display = "none";
        } else {
            CreateNestedElements(rArray[1], rArray[2], rArray[3]);
        }
    }

    function CreateNestedElements(newPath, ContentType, Filename) {
        // alert(newPath);
        var divElement = document.createElement("div");
        divElement.id = "div" + counter;
        divElement.className = "ImageBox";

        var deleteButton = document.createElement("img");
        deleteButton.id = counter;
        deleteButton.src = "../Images/close_button.gif";
        deleteButton.onclick = DeleteItem;
        deleteButton.className = "abs";
        deleteButton.style.top = 5 + "px";
        deleteButton.style.left = 5 + "px";

        //created image object and assign values
        var imageObject = document.createElement("label");

        //resize proportionaly
        //        var iRatio = iWidth / iHeight;

        //        if (iRatio > 1) {
        //            iWidth = ImageWidth;
        //            iHeight = ImageWidth / iRatio;
        //        } else {

        //            iHeight = ImageWidth;
        //            iWidth = ImageWidth * iRatio;
        //        }
        //----
        //        var filename = newPath.split('/');
        imageObject.style.width = "180px";
        imageObject.style.height = "20px";

        imageObject.id = "img" + counter;
        // imageObject.src = ".." + newPath;
        imageObject.name = "myidname" + counter;
        //imageObject.innerHTML = document.getElementById('<%=imgUpload.ClientID %>').value;
        imageObject.innerHTML = Filename;
        imageObject.className = "abs";

        //calculate
        //        var boxHeight = ImageWidth + 30;
        //        var boxWidth = boxHeight;
        //        //alert("BH:" + boxHeight + "; HW:" + boxWidth);
        //        var iLeft = (boxWidth - ImageWidth) / 2;
        //        var iTop = (boxHeight / 2) - (iHeight / 2);

        divElement.style.width = "500px";
        divElement.style.height = "30px";

        imageObject.style.top = "8px";
        imageObject.style.left = "22px";



        divElement.appendChild(imageObject);
        divElement.appendChild(deleteButton);

        document.getElementById("fileList").appendChild(divElement);
        counter++;

        document.getElementById('<%= upload_progress.ClientID%>').style.display = "none";

    }

    function DeleteItem(e) {

        document.getElementById('<%= upload_progress.ClientID%>').style.display = "block";
        var evt = e || window.event;
        var evtTarget = evt.target || evt.srcElement;
        CallServer(evtTarget.id, '');


        // IE
        if (evtTarget.parentElement) {
            var childDiv = evtTarget.parentElement;
            childDiv.parentElement.removeChild(childDiv);
        }

        // FIREFOX
        else if (evtTarget.parentNode) {
            var childDiv = evtTarget.parentNode;
            childDiv.parentNode.removeChild(childDiv);
        }
    }
    function ReceiveServerData(rValue) {
        document.getElementById('<%= upload_progress.ClientID%>').style.display = "none";
        var rArray = new Array();
        rArray = rValue.split("~");
        if (rArray[0] == "Error") {
            alert(rArray[1]);
        }
    }

    function ExecuteFileUpload() {
        //if (document.getElementById('txtImgDesc').value != '') {
        submitUpload("hiddenFrame");
        document.getElementById('<%= upload_progress.ClientID%>').style.display = "block";
        //}
        //        else {
        //            alert('Enter Image Title')
        //            document.getElementById('txtImgDesc').Focus;
        //        }
    }
    function ShowSavedImages() {
        var urls = new Array();
        var hdnPaths = document.getElementById(hdnControlId);
        if (hdnPaths.value != "") {
            urls = hdnPaths.value.split("|");
            for (i = 0; i < urls.length; i++) {
                if (urls[i] != "") {
                    FinishImagePreview(urls[i], false);
                }
            }
        }

    }


</script>

<table cellpadding="2" cellspacing="5" style="width: 100%; border-right: lightsteelblue thin ridge;
    border-top: lightsteelblue thin ridge; border-left: lightsteelblue thin ridge;
    border-bottom: lightsteelblue thin ridge; position: relative;">
    <tr>
        <td>
            <asp:HiddenField ID="hidNotesid" runat="server" />
        </td>
    </tr>
    <tr>
        <td style="background-color: lightsteelblue;">
            <table style="width: 100%">
                <tr>
                    <td style="width: 85%; height: 27px;">
                        <strong>
                            <asp:Label ID="Rs_UploadImages" runat="server" Text="Upload Images" meta:resourcekey="Rs_UploadImagesResource1"></asp:Label></strong>
                    </td>
                    <td style="text-align: right; width: 15%; height: 27px;">
                        <asp:Button ID="btnSave" runat="server" Visible="False" Text="Save Images" CssClass="btnForUpload"
                            meta:resourcekey="btnSaveResource1" />
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td>
            <div style="position: relative;">
                <input id="imgUpload" type="file" onchange="ExecuteFileUpload();" runat="server"
                    style="width: 100%" size="59" />
                <img id="upload_progress" src="../Images/working.gif" runat="server" style="display: none;
                    position: absolute; top: 49%; left: 49%; z-index: 110; background-color: whitesmoke;
                    border-right: darkgray 1px solid; padding-right: 8px; border-top: darkgray 1px solid;
                    padding-left: 8px; padding-bottom: 8px; border-left: darkgray 1px solid; padding-top: 8px;
                    border-bottom: darkgray 1px solid;" />
            </div>
        </td>
    </tr>
    <tr>
        <td width="center">
            <div id="fileList" style="text-align: left; position: relative;">
            </div>
        </td>
    </tr>
    <tr>
        <td>
            <asp:Label ID="lblMessage" runat="server" Width="100%" meta:resourcekey="lblMessageResource1"></asp:Label>
        </td>
    </tr>
</table>
<div id="fileUpload" style="display: none;">
    <iframe src="" id="hiddenFrame" name="hiddenFrame" style="width: 0px; height: 0px">
    </iframe>
</div>
<input id="hdnSavedImage" runat="server" type="hidden" />
