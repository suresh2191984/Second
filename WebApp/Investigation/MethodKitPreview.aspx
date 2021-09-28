<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MethodKitPreview.aspx.cs" Inherits="Investigation_MethodKitPreview" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/MethodKitMapping.ascx" TagName="MethodKitCapture"
    TagPrefix="uc7" %>
<%@ Register Src="~/CommonControls/Theme.ascx" TagName="Theme" TagPrefix="T1" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter"
    TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Method, Kit &amp; Instrument Capture</title>
    <style type="text/css">
        .style1
        {
            width: 492px;
        }
        .classNav { visibility:hidden!important; height:0px!important; display:none!important;}
              
    </style>
    <script language="javascript" type="text/javascript">       

        function popupClose() {            
            window.close();
            return false;
        }
        function hideHeader() {
            document.getElementById('header').style.display = 'none';
            document.getElementById('Attuneheader_menu').style.display = 'none';
            document.getElementById('imagetd').style.display = 'none';
            $("#navigation").addClass("classNav");
            document.getElementById('Attuneheader_TopHeader1_ImgBtnHome').style.display = 'none';
        }
        function hidebutton()
        { 
            document.getElementById('btnSave').style.display = 'block';
        }
       
    </script>
</head>
<body id="Body1" oncontextmenu="return true;" runat="server">
    <form id="prFrm" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div style="display:none";>
    <T1:Theme ID="Theme1" runat="server" />
    </div>
      <Attune:Attuneheader ID="Attuneheader" runat="server" />
              <div class="contentdata">
                        
                        <uc7:MethodKitCapture ID="ucMethodKitCapture" runat="server" />
                        <table cellpadding="0" cellspacing="0" border="0" width="100%" class="defaultfontcolor">
                            <tr>
                                <td class="a-center">
                                    <%--<asp:Button ID="btnEdit" CssClass="btn" runat="server" Text="Back" onmouseover="this.className='btn btnhov'"
                                        onmouseout="this.className='btn'" OnClick="btnEdit_Click" />--%>
                                    <asp:Button ID="btnSave" runat="server" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                        onmouseout="this.className='btn'" Text="Save & Continue" 
                                        OnClick="btnSave_Click" meta:resourcekey="btnSaveResource1" />
                                   <asp:Button ID="Button1" runat="server" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                        onmouseout="this.className='btn'" Text="Close" 
                                        OnClientClick="popupClose()" meta:resourcekey="Button1Resource1" />
                                </td>
                            </tr>
                        </table>
                        <input id="hdnHeaderName" runat="server" type="hidden" value="0" />
                    </div>
        <Attune:Attunefooter ID="Attunefooter" runat="server" />             
    </form>

    <script language="javascript" type="text/javascript">
        LoadExistingMethodKit();
        var showhide = document.getElementById('ucMethodKitCapture_btnShow').value;
        if(showhide == "N")
        {
        document.getElementById('btnSave').style.display = 'none';
        }
    </script>

</body>
</html>
