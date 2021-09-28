<%@ Page Language="C#" AutoEventWireup="true" CodeFile="InvestigationPayment.aspx.cs"
    Inherits="Billing_InvestigationPayment" meta:resourcekey="PageResource1" %>

<%@ Register Src="../CommonControls/ReferralsINV.ascx" TagName="ReferralsINV" TagPrefix="uc2" %>
<%--<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/AddressControl.ascx" TagName="AddressControl"
    TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/DueDetails.ascx" TagName="DueDetail" TagPrefix="uc6" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/FeesEntry.ascx" TagName="FeesEntry" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="UserHeader" TagPrefix="uc8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />

    <script language="javascript" type="text/javascript">
             function Amount() {

                 var gvET = document.getElementById("FeesEntry1_gvFeesEntry");
                 var rCount = gvET.rows.length;
                 var rowIdx = 1;
                 var tcount = 0;
                 var a = "";
                 for (rowIdx; rowIdx <= rCount - 1; rowIdx++) {
                     var rowElement = gvET.rows[rowIdx];
                     a += rowElement.cells[2].firstChild.value + "~";
                     //alert(a);
                 }
                 //alert("First : " + a);
                 document.getElementById('FeesEntry1_hdnAmount').value = a;

             
                 var chkforzero = false;
                 var amt = document.getElementById('FeesEntry1_hdnAmount').value;
                // alert("Hidden : " + amt);
                 var listamt = new Array();
                 listamt = amt.split('~');
                 if (document.getElementById('FeesEntry1_hdnAmount').value != null) {
                     for (var count = 0; count < listamt.length; count++) {
                         if (listamt[count] == '0.00' && listamt[count] != "") {
                             //alert(listamt[count]);
                             chkforzero = true;
                         }
                     }
                 }
                 if (chkforzero == true) {
                alert('Fees cannot be zero');
                     return false;
                 }
                 else {
                     document.getElementById('btnSave');
                     return true;
                 }
             }
    </script>

</head>
<body id="oneColLayout">
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div id="wrapper">
        <div id="header">
            <div class="logoleft" style="z-index: 2;">
                <div class="logowrapper">
                    <img alt="" src="<%=LogoPath%>" class="logostyle" />
                </div>
            </div>
            <div class="middleheader">
                <uc4:MainHeader ID="MainHeader" runat="server" />
                <uc8:UserHeader ID="UserHeader1" runat="server" />
            </div>
            <div style="float: right;" class="Rightheader">
            </div>
        </div>
        <div id="primaryContent">
            <div id="maincontent">
                <uc1:LeftMenu ID="LeftMenu1" runat="server" CSSStyle="hid" CSSMidStyle="top" />
                <div class="data">
                    <h1>
                        <ul>
                            <li class="dataheader">Investigation Payment</li>
                        </ul>
                        <ul>
                            <li>
                                <uc7:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                    </h1>
                    <div class="rum">
                        <table width="100%" border="0" cellpadding="0" cell="0">
                            <tr>
                                <td align="center">
                                    <uc3:FeesEntry ID="FeesEntry1" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td align="center">
                                    <asp:Button ID="btnSave" Enabled="false" Text="Save" runat="server" CssClass="btn"
                                        onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" OnClick="btnSave_Click" />
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <div>
            <uc5:Footer ID="Footer1" runat="server" />
        </div>
    </div>
    </form>
</body>
</html>
--%>
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Investigations</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>

    <script src="../Scripts/bid.js" type="text/javascript"></script>

    <script src="../Scripts/animatedcollapse.js" type="text/javascript"></script>

    <script src="../Scripts/jquery-1.2.2.pack.js" type="text/javascript"></script>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

<link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="RecHome" runat="server">
    <asp:ScriptManager ID="ctlTaskScriptMgr" runat="server">
    </asp:ScriptManager>
    <div id="wrapper">
        <div id="header">
            <div class="logoleft" style="z-index: 2;">
                <div class="logowrapper">
                    <img alt="" src="<%=LogoPath%>" class="logostyle" />
                </div>
            </div>
            <div class="middleheader">
                <uc4:MainHeader ID="MHead" runat="server" />
                <uc3:Header ID="RHead" runat="server" />
            </div>
            <div style="float: right;" class="Rightheader">
            </div>
        </div>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
                <td width="15%" valign="top" id="menu" style="display: block;">
                    <div id="navigation">
                        <uc1:LeftMenu ID="LeftMenu1" runat="server" />
                    </div>
                </td>
                <td width="85%" valign="top" class="tdspace">
                    <img alt="" onclick="Showmenu();Showhide();" src="../Images/hide.png" id="showmenu"
                        style="cursor: pointer;" />
                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td>
                                <Top:TopHeader ID="TopHeader1" runat="server" />
                            </td>
                        </tr>
                    </table>
                    <div class="contentdata">
                        <ul>
                            <li>
                                <uc7:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                        <table cellpadding="0" cellspacing="0" width="97%" border="0">
                            <tr>
                                <td>
                                    <asp:Label ID="lblReferrals" runat="server" meta:resourcekey="lblReferralsResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <uc2:ReferralsINV ID="ReferralsINV1" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td align="center">
                                    <table>
                                        <tr>
                                            <td align="center">
                                                <asp:Label Text="Task has been modified.Please pick another task" Visible="False"
                                                    runat="server" ID="txtStatus" meta:resourcekey="txtStatusResource1"></asp:Label>
                                                <asp:Label ID="txttaskPending" runat="server" Text="Task is Pending.Please pick another task"
                                                    Visible="false"></asp:Label>
                                                <asp:Button ID="btnSave" Text="Save" runat="server" CssClass="btn" 
                                                    onmouseout="this.className='btn'" OnClick="btnSave_Click" meta:resourcekey="btnSaveResource1"
                                                    Width="45px" />
                                            </td>
                                            <td align="center" runat="server" visible="false">
                                                <asp:Button ID="btnBack" Text="Back" runat="server" CssClass="btn" 
                                                    onmouseout="this.className='btn'" OnClick="btnBack_Click" meta:resourcekey="btnBackResource1" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td style="height: 40px;">
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div id="divPaid" runat="server" visible="false">
                                        <asp:Image ImageUrl="../Images/starbutton.png" ID="imgPaid" runat="server" meta:resourcekey="imgPaidResource1" />
                                        <asp:Label ID="Rs_AmountPaidInReferredOrg" Text="Amount Paid In Referred Org" runat="server"
                                            meta:resourcekey="Rs_AmountPaidInReferredOrgResource1"></asp:Label>
                                        <asp:Label ID="lblOrg" runat="server" meta:resourcekey="lblOrgResource1"></asp:Label>
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
        </table>
        <asp:HiddenField ID="hdnAmount" runat="server" />
        <asp:HiddenField ID="hdnOrg" runat="server" />
        <asp:HiddenField ID="hdnLocation" runat="server" />
        <asp:HiddenField ID="hdnTaskId" Value="0" runat="server" />
        <uc5:Footer ID="Footer1" runat="server" />
    </div>
    </form>
</body>
</html>

<script language="javascript" type="text/javascript">
    //    function fnValues(PerformingOrg, Amount) {
    //        var orgId = document.getElementById('<%= hdnOrg.ClientID %>').value
    //        if (orgId != PerformingOrg.value.split('~')[1]) {
    //            Amount.disabled = true;
    //        }
    //        else {
    //            Amount.disabled = false;
    //        }

    //    }

</script>

