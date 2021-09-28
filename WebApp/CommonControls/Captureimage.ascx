<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Captureimage.ascx.cs"
    Inherits="PlatForm_CommonControls_Captureimage" %>  
<link rel="stylesheet" type="text/css" href="../PlatForm/StyleSheets/Captureimage.css" />



<div class="PhotoUploadWrapper">
    <div class="PhotoUpoloadCoseBtn">
    </div>
    <div class="PhotoUploadContent">
        <div class="PhotoUpoloadLeft">
            <div class="PhotoUpoloadRightHeader">
                <p class="font14 custfontfamily3 pull-left lh35 custtxtindent bold cust1backgrnd7 ">
                    <asp:Label ID="lblWebaCamebra" Text="Web Camera" runat="server"></asp:Label>
                </p>
            </div>
            <div class="PhotoUpoloadLeftMainCont">
                <div class="photo_selected_BG">
                    <div class="custpadding3">
                        <div id="webcam">
                        </div>
                    </div>
                </div>
                <div class="a-center marginB46">
                 
                        <input type="image" id="capture" onclick = "javascript:CapturePhoto();void(0);"
                            src="../PlatForm/Images/captureBTN.png" alt="#" />
                </div>
            </div>
        </div>
        <div class="PhotoUpoloadRight">
            <div class="PhotoUpoloadLeftHeader">
                <p class="font14 custfontfamily3 pull-left lh35 custtxtindent bold cust1backgrnd7 ">
                    <asp:Label ID="Label1" Text="Upload Photo" runat="server"></asp:Label>
                </p>
            </div>
            <div class="photo_selected_BG">
                <div class="custpadding4">
                    <canvas id="canvas" width="320" height="240"></canvas>
                </div>
            </div>
            <div class="a-center marginB46">
                <a href="#" id="filter" onclick="javascript:return UploadPic();return false;" class="hide">
                    <input type="image" id="Submit" src="../PlatForm/Images/submitBTN.png" /></a>
            </div>
        </div>
    </div>
</div>
<asp:HiddenField ID="hdnFileName" runat="server" />
<asp:HiddenField ID="hdnConcatFilename" runat="server" />
<asp:HiddenField ID="WebcamhdnOrgID" runat="server" />
<asp:HiddenField ID="hdnLoginID" runat="server" />


<script src="../PlatForm/Scripts/Captureimage/jquery.webcam.js" type="text/javascript"></script>


<script type="text/javascript">
    $(document).ready(function() {
        callWebcam();
    });
    function callWebcam() {
        var pos = 0;
        var ctx = null;
        var cam = null;
        var image = null;
        var ImagData = null;
        var filter_on = false;
        var filter_id = 0;

        function clearText(field) {
            if (field.defaultValue == field.value) field.value = '';
            else if (field.value == '') field.value = field.defaultValue;
        }
        function changeFilter() {
            if (filter_on) {
                filter_id = (filter_id + 1) & 7;
            }
        }

        function toggleFilter(obj) {
            if (filter_on = !filter_on) {
                obj.parentNode.addClass('bordercolor5');
            } else {
                obj.parentNode.addClass('bordercolor6');
            }
        }

        jQuery("#webcam").webcam({
            //width: 272,
            width: 272,
            height: 202,
            mode: "callback",
            swffile: "../PlatForm/Scripts/Captureimage/jscam_canvas_only.swf",

            onTick: function(remain) {

                if (0 == remain) {
                    jQuery("#status").text("Cheese!");
                } else {
                    jQuery("#status").text(remain + " seconds remaining...");
                }
            },

            onSave: function(data) {

                var col = data.split(";");
                ImagData = data;
                var img = image;

                if (false == filter_on) {

                    for (var i = 0; i < 320; i++) {
                        var tmp = parseInt(col[i]);
                        img.data[pos + 0] = (tmp >> 16) & 0xff;
                        img.data[pos + 1] = (tmp >> 8) & 0xff;
                        img.data[pos + 2] = tmp & 0xff;
                        img.data[pos + 3] = 0xff;
                        pos += 4;
                    }

                } else {

                    var id = filter_id;
                    var r, g, b;
                    var r1 = Math.floor(Math.random() * 255);
                    var r2 = Math.floor(Math.random() * 255);
                    var r3 = Math.floor(Math.random() * 255);

                    for (var i = 0; i < 320; i++) {
                        var tmp = parseInt(col[i]);

                        /* Copied some xcolor methods here to be faster than calling all methods inside of xcolor and to not serve complete library with every req */

                        if (id == 0) {
                            r = (tmp >> 16) & 0xff;
                            g = 0xff;
                            b = 0xff;
                        } else if (id == 1) {
                            r = 0xff;
                            g = (tmp >> 8) & 0xff;
                            b = 0xff;
                        } else if (id == 2) {
                            r = 0xff;
                            g = 0xff;
                            b = tmp & 0xff;
                        } else if (id == 3) {
                            r = 0xff ^ ((tmp >> 16) & 0xff);
                            g = 0xff ^ ((tmp >> 8) & 0xff);
                            b = 0xff ^ (tmp & 0xff);
                        } else if (id == 4) {

                            r = (tmp >> 16) & 0xff;
                            g = (tmp >> 8) & 0xff;
                            b = tmp & 0xff;
                            var v = Math.min(Math.floor(.35 + 13 * (r + g + b) / 60), 255);
                            r = v;
                            g = v;
                            b = v;
                        } else if (id == 5) {
                            r = (tmp >> 16) & 0xff;
                            g = (tmp >> 8) & 0xff;
                            b = tmp & 0xff;
                            if ((r += 32) < 0) r = 0;
                            if ((g += 32) < 0) g = 0;
                            if ((b += 32) < 0) b = 0;
                        } else if (id == 6) {
                            r = (tmp >> 16) & 0xff;
                            g = (tmp >> 8) & 0xff;
                            b = tmp & 0xff;
                            if ((r -= 32) < 0) r = 0;
                            if ((g -= 32) < 0) g = 0;
                            if ((b -= 32) < 0) b = 0;
                        } else if (id == 7) {
                            r = (tmp >> 16) & 0xff;
                            g = (tmp >> 8) & 0xff;
                            b = tmp & 0xff;
                            r = Math.floor(r / 255 * r1);
                            g = Math.floor(g / 255 * r2);
                            b = Math.floor(b / 255 * r3);
                        }

                        img.data[pos + 0] = r;
                        img.data[pos + 1] = g;
                        img.data[pos + 2] = b;
                        img.data[pos + 3] = 0xff;
                        pos += 4;
                    }
                }

                if (pos >= 0x4B000) {
                    ctx.putImageData(img, 0, 0);
                    pos = 0;
                    var canvas = document.getElementById("canvas");
                    //  $.post("http://192.168.1.199/HaomaTesting/WebCam/UploadImage.aspx", { image: canvas.toDataURL("image/png") });

                }
            },

            onCapture: function() {
               document.getElementById('XwebcamXobjectX').save();
                jQuery("#flash").css("display", "block");
                $('#filter').css("display", "block");
                jQuery("#flash").fadeOut(100, function() {
                    jQuery("#flash").css("opacity", 1);
                });
            },

            debug: function(type, string) {

                jQuery("#status").html(type + ": " + string);

            },

            onLoad: function() {

                var cams = webcam.getCameraList();
                for (var i in cams) {
                    jQuery("#cams").append("<li>" + cams[i] + "</li>");
                }

                $("#capture").on("click", webcam.capture);
            }

        }

);

        window.addEventListener("load", function() {
            //alert(25);
            jQuery("body").append("<div id=\"flash\"></div>");

            var canvas = document.getElementById("canvas");

            if (canvas.getContext) {
                ctx = document.getElementById("canvas").getContext("2d");
                ctx.clearRect(0, 0, 320, 240);

                var img = new Image();

                img.src = "../PlatForm/Images/captureImage.png";

                img.onload = function() {
                    ctx.drawImage(img, 129, 89);
                }
                image = ctx.getImageData(0, 0, 320, 240);


            }

        }, false);

        window.addEventListener("resize", function() {
        //alert(26);
            var pageSize = getPageSize();

            jQuery("#flash").css({ height: pageSize[1] + "px" });

        }, false);


    }
    function UploadPic() {
        // generate the image data
        debugger;
        var canvas = document.getElementById("canvas");
        var dataURL = canvas.toDataURL("image/png");
        var OrgID = $('#<%=WebcamhdnOrgID.ClientID %>').val();
        var LoginID = $('#<%=hdnLoginID.ClientID %>').val();
        //alert(OrgID);

        $.ajax({
            url: "../PlatForm/Handler/CameraImage.ashx?OrgID=" + OrgID + "&LoginID=" + LoginID,
            type: "POST",
            contentType: false,
            processData: false,
            data: dataURL,
            async: false,
            success: function(result) {
                FileName = result;
                $('#<%=hdnFileName.ClientID %>').val(FileName); 
                if ($('#divCaptureimage').length > 0) {
                    $("#divCaptureimage").dialog('close');
                }
                if (typeof Show_image == 'function') {
                    if (FileName != '') {
                        //Adding Comma separated filename
                        $('#Captureimage_hdnConcatFilename').val($('#Captureimage_hdnConcatFilename').val() + "," + $('#<%=hdnFileName.ClientID %>').val());
                        var ConCatValue = $('#Captureimage_hdnConcatFilename').val();
                    }
                    Show_image(ConCatValue);
                }

                $('#filter').css("display", "none");
                return false;
            },
            error: function(err) {
                alert(err.statusText);
            }
        }); 
//        alert("Picture Uploaded SuccessFully.");
        return false;
    }


    function Get_FileName() {
        return $('#<%=hdnFileName.ClientID %>').val();
    }

    function CapturePhoto() {
        //alert(8);
        document.getElementById('XwebcamXobjectX').capture();
    }
    function editcanvas() {
        jQuery("body").append("<div id=\"flash\"></div>");

        var canvas = document.getElementById("canvas");

        if (canvas.getContext) {
            ctx = document.getElementById("canvas").getContext("2d");
            ctx.clearRect(0, 0, 320, 240);

            var img = new Image();

            img.src = "../PlatForm/Images/captureImage.png";

            img.onload = function() {
                ctx.drawImage(img, 129, 89);
            }
            image = ctx.getImageData(0, 0, 320, 240);


        }

       
    }

    function loadsize() {
        var pageSize = getPageSize();

        jQuery("#flash").css({ height: pageSize[1] + "px" });
    }

        function getPageSize() {

            var xScroll, yScroll;

            if (window.innerHeight && window.scrollMaxY) {
                xScroll = window.innerWidth + window.scrollMaxX;
                yScroll = window.innerHeight + window.scrollMaxY;
            } else if (document.body.scrollHeight > document.body.offsetHeight) { // all but Explorer Mac
                xScroll = document.body.scrollWidth;
                yScroll = document.body.scrollHeight;
            } else { // Explorer Mac...would also work in Explorer 6 Strict, Mozilla and Safari
                xScroll = document.body.offsetWidth;
                yScroll = document.body.offsetHeight;
            }

            var windowWidth, windowHeight;

            if (self.innerHeight) { // all except Explorer
                if (document.documentElement.clientWidth) {
                    windowWidth = document.documentElement.clientWidth;
                } else {
                    windowWidth = self.innerWidth;
                }
                windowHeight = self.innerHeight;
            } else if (document.documentElement && document.documentElement.clientHeight) { // Explorer 6 Strict Mode
                windowWidth = document.documentElement.clientWidth;
                windowHeight = document.documentElement.clientHeight;
            } else if (document.body) { // other Explorers
                windowWidth = document.body.clientWidth;
                windowHeight = document.body.clientHeight;
            }

            // for small pages with total height less then height of the viewport
            if (yScroll < windowHeight) {
                pageHeight = windowHeight;
            } else {
                pageHeight = yScroll;
            }

            // for small pages with total width less then width of the viewport
            if (xScroll < windowWidth) {
                pageWidth = xScroll;
            } else {
                pageWidth = windowWidth;
            }
            return [pageWidth, pageHeight];
        }



    //

</script>