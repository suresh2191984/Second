<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Helpvideo.aspx.cs" Inherits="HelpFiles_Helpvideo" meta:resourcekey="PageResource1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">



    <script src="Scripts/jquery.js" type="text/javascript"></script>
   <script src="Scripts/mediaelement.min.js" type="text/javascript"></script>
   <%@ Register Src="~/PlatFormControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="~/PlatFormControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
   
    <script type="text/javascript">


        $(document).ready(function() {

            return $.ajax({
                type: "POST",
                url: '../PlatformWebServices/PlatFormServices.asmx/GetRoleHelpVideo',
                contentType: "application/json",
                dataType: "json",
                success: function(result) {
                    if ((result.d).length > 0) {

                        var list = '<ul class="list-unstyled">';

                        list = list + '<li class="list-group-item header-color bold pointer" > User Manual <ul class="lh30 orange bold"> <a  class="pointer" onclick="ShowReport();"> User Manual</a></ul> </li>'
                        
                        list += ' <li class="list-group-item header-color bold pointer">Help Video <ul>'

                        $.each(result.d, function(key, value) {
                        list += "<li class='lh30 orange bold'> <a  class='pointer' onclick=\showclick('" + value.VideoFilePath + "');\  > " + value.VideoDescription + " </a></li>"
                        });

                        list += '</ul> </li> </ul>'
                        $('#Helpvideotitle').append(list);


                    }
                }


            });






        });




        function ShowReport() {
            var url = $("#hdnUserManual").val();        
            var div = $("#helpVideo");
            div.empty();
            div.append('<iframe  frameborder="1"  style="width:100%;height:500px" src="' + "../VisitInfo/PDFView.aspx?ispopup=Y&Url=" + url + '" />');            
            return false;
        }
        
        


        function showclick(Path) {

          
            $('#helpVideo').empty();
            var video = '<video width="760" height="500" id="player1"     src="' + Path + '" type="video/mp4" controls="controls"></video>';
            $('#helpVideo').append(video);

        }
        
        
    </script>
    <style>
        #helpVideo video{padding-left: 9%;}
        #Helpvideotitle .list-unstyled {
            padding-left: 0;
            list-style: none;
        }
        #Helpvideotitle ul ul, #Helpvideotitle  ol ul {
            list-style-type: circle;
        }
        #Helpvideotitle ol ol,#Helpvideotitle  ol ul,#Helpvideotitle  ul ol, #Helpvideotitle  ul ul {
            margin-bottom: 0;
        }
        #Helpvideotitle li {
            display: list-item;
            text-align: -webkit-match-parent;width:92%;list-style-type: circle;
        }
        .list-group-item:first-child {
            border-top-left-radius: 4px;
            border-top-right-radius: 4px;
        }
        .list-group-item {
            position: relative;
            display: block;
            padding: 10px 15px;
            margin-bottom: -1px;
            background-color: #fff;
            border: 1px solid #ddd;
        }
        #Helpvideotitle ul ul, menu, dir {
        display: block;
        list-style-type: disc;
        -webkit-margin-before: 1em;
        -webkit-margin-after: 1em;
        -webkit-margin-start: 0px;
        -webkit-margin-end: 0px;
        -webkit-padding-start: 40px;
       
    }
     .link
        {
        }
    </style>
    
    <link rel="stylesheet" href="lib/thumbs.css" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
         <Attune:Attuneheader ID="Attuneheader" runat="server" /> 
           <asp:ScriptManager ID="scrpt" runat="server">
    </asp:ScriptManager>

    <div id="helpVideoDiv" class="w-100p ">

        
        <div class="w-30p borderGrey pull-left o-auto" id="Helpvideotitle" style="height:500px;">
       
        </div>
        <div id="helpVideo" class="w-68p pull-left borderGrey bg-rBlue"  style="height:500px;">
              
        </div>
    
    
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    <asp:HiddenField ID="hdnMessages" runat="server" />
      <asp:HiddenField ID="hdnUserManual" runat="server" />
    </form>
    
    <script type="text/javascript">
        $(document).ready(function() {
            $(".list-group-item").click(function(e) {
                $("this").next().toggle();
            });
        });
    </script>
</body>
</html>

