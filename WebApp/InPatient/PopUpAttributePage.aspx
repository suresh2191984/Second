<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PopUpAttributePage.aspx.cs"
    Inherits="InPatient_PopUpAttributePage" meta:resourcekey="PageResource1" %>

<%@ Register Src="../CommonControls/Theme.ascx" TagName="Theme" TagPrefix="uc34" %>
<%@ Register Src="AttribWithDate.ascx" TagName="AttribWithDate" TagPrefix="uc7" %>
<%@ Register Src="TPAArttibControl.ascx" TagName="TPAArttibControl" TagPrefix="uc2" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Src="../CommonControls/IPClientTpaInsurance.ascx" TagName="ClientTpa"
    TagPrefix="uc19" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />

<script src="../Scripts/bid.js" type="text/javascript"></script>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script src="../Scripts/QuickBill.js" type="text/javascript"></script>

    <script src="../Scripts/animatedcollapse.js" type="text/javascript"></script>

    <script src="../Scripts/datetimepicker.js" type="text/javascript"></script>


</head>
<body>
    <form id="form1" runat="server">
    <div style="display: none;">
        <uc34:Theme ID="Theme1" runat="server" />
    </div>
    <%--<div class="dataone">--%>
    <div class="contentdatapopup">
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <table width="100%" cellpadding="0" cellspacing="0" border="0">
            <tr>
                <td align="left" style="font-size: 13px;">
                    <asp:Panel ID="pnlAttrib" runat="server" CssClass="dataheader2" Width="99%" 
                        meta:resourcekey="pnlAttribResource1">
                    </asp:Panel>
                </td>
            </tr>
            <tr>
                <td align="center">
                    <asp:Button ID="btnAttrip" runat="server" Text="OK" CssClass="btn" onmouseover="this.className='btn btnhov1'"
                        onmouseout="this.className='btn'" OnClick="btnAttrip_Click" Width="55px" 
                        meta:resourcekey="btnAttripResource1" />
                    &nbsp;&nbsp; <a style="cursor: pointer; text-decoration: none; font-weight: bold;
                        color: Blue;" href="javascript:winClose();"><asp:Label ID="Rs_CloseWindow" 
                        Text="Close Window" runat="server" meta:resourcekey="Rs_CloseWindowResource1"></asp:Label> </a>
                    <asp:HiddenField runat="server" ID="hdnXMLStr" />
                    <input type="hidden" id="hdnConval" runat="server" />
                    <input type="hidden" id="IsColsePOP" value="N" runat="server" />
                </td>
            </tr>
        </table>
    </div>
    </form>

    <script type="text/javascript" language="javascript">
        SetAttripValue();
        function winClose() {
            window.close();
        }
        function SetAttripValue() {
            if (document.getElementById('IsColsePOP').value == "Y") {
                var con = document.getElementById('hdnConval').value;
                window.opener.document.getElementById(con).value = document.getElementById('hdnXMLStr').value;
                window.close();
            }
        }
        
    </script>

</body>
</html>
