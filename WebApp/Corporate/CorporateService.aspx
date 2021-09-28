<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CorporateService.aspx.cs"
    Inherits="Corporate_CorporateService" meta:resourcekey="PageResource1" %>

<%@ Register Src="ServiceSearch.ascx" TagName="BillSearch" TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/PhysicianHeader.ascx" TagName="PhyHeader" TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>
<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Service Search</title>
    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />

    <script src="../Scripts/Common.js" type="text/javascript"></script>

</head>
<body oncontextmenu="return true;">
    <form id="form1" runat="server" defaultbutton="bGo">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>

    <script language="javascript" type="text/javascript">
        function ServiceSelectBillNo(rid, Bid, PatientID, visitID, PName, PNumber, BillNo) {
            var len = document.forms[0].elements.length;
            for (var i = 0; i < len; i++) {
                if (document.forms[0].elements[i].type == "radio") {
                    document.forms[0].elements[i].checked = false;
                }
            }
            document.getElementById(rid).checked = true;
            document.getElementById("<%= hdnVID.ClientID %>").value = visitID;
            document.getElementById("<%= hdnPID.ClientID %>").value = PatientID;
            document.getElementById("<%= hdnPNAME.ClientID %>").value = PName;
            document.getElementById("<%= hdnPNumber.ClientID %>").value = PNumber;
            document.getElementById("<%= hdnBID.ClientID %>").value = Bid;
            document.getElementById("<%= hdnBillNo.ClientID %>").value = BillNo;
            setBillNumber(BillNo);
        }

        function setBillNumber(BillNo) {
            document.getElementById('hdnBillNumber').value = BillNo;
        }

        function CheckVisitID() {

            var ddlaction = document.getElementById('dList')
            if (document.getElementById("hdnBillNumber").value == '') {
                alert('Please select a Patient');
                return false;
            }
            else {

                document.getElementById("<%= hdnVisitDetail.ClientID %>").value = document.getElementById("<%= dList.ClientID %>").options[document.getElementById("<%= dList.ClientID %>").selectedIndex].innerHTML;
                return true;
            }
        }


        function PrintReport() {
            var vid = document.getElementById('hdnVID').value;
            var pid = document.getElementById('hdnPID').value;
            var bid = document.getElementById('hdnBID').value;
            var ddlaction = document.getElementById('dList');
            if (ddlaction.options[document.getElementById('dList').selectedIndex].innerHTML == 'Print Bill') {


                var strFeatures = "toolbar=no,status=no,menubar=no,location=no";
                strFeatures = strFeatures + ",scrollbars=yes,resizable=yes,height=600,width=800";
                // ADDED THE LINE BELOW TO ORIGINAL EXAMPLE
                strFeatures = strFeatures + ",left=0,top=0";
                var strURL = "../Reception/ViewPrintPage.aspx?vid=" + vid + "&pagetype=BP&IsPopup=Y&CCPage=Y&pid=" + pid + "&bid=" + bid;
                var PrintWindow = window.open(strURL, "", strFeatures);
                PrintWindow.focus();
                PrintWindow.print();



            }
        }
        function PrintDynamic() {
            var vid = document.getElementById('hdnVID').value;
            var pid = document.getElementById('hdnPID').value;
            var bid = document.getElementById('hdnBID').value;
            var ddlaction = document.getElementById('dList');
            if (ddlaction.options[document.getElementById('dList').selectedIndex].innerHTML == 'Print Bill') {


                var strFeatures = "toolbar=no,status=no,menubar=no,location=no";
                strFeatures = strFeatures + ",scrollbars=yes,resizable=yes,height=600,width=800";
                // ADDED THE LINE BELOW TO ORIGINAL EXAMPLE
                strFeatures = strFeatures + ",left=0,top=0";
                var strURL = "../Reception/ViewPrintPage.aspx?vid=" + vid + "&pagetype=BP&IsPopup=Y&CCPage=Y&dinc=y&pid=" + pid + "&bid=" + bid;
                var PrintWindow = window.open(strURL, "", strFeatures);



            }
        }
    </script>

    <div id="wrapper">
        <div id="header">
            <div class="logoleft" style="z-index: 2;">
                <div class="logowrapper">
                    <img alt="" src="<%=LogoPath%>" class="logostyle" />
                </div>
            </div>
            <div class="middleheader">
                <uc4:MainHeader ID="MHead" runat="server" />
                <uc3:Header ID="userHeader" runat="server" />
                <uc7:PhyHeader ID="physicianHeader" runat="server" />
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
                    <div class="contentdata1">
                        <ul>
                            <li>
                                <uc6:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                        <asp:UpdatePanel ID="up1" runat="server">
                            <ContentTemplate>
                                <table width="100%" cellpadding="0" cellspacing="0" border="0">
                                    <tr>
                                        <td style="padding-bottom: 10px;">
                                            <div class="defaultfontcolor">
                                                <uc2:BillSearch ID="uctrlBillSearch" runat="server" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="defaultfontcolor">
                                            <asp:Label ID="lblResult" runat="server" meta:resourcekey="lblResultResource1"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="display: none;" width="100%" runat="server" id="pagetdPrint" 
                                            enableviewstate="False">
                                        </td>
                                    </tr>
                                    <tr id="aRow" style="width: 100%" runat="server" visible="False">
                                        <td style="width: 100%" class="defaultfontcolor" runat="server">
                                            <asp:Label ID="LblSelectaBillandPerformoneofthefollowing" Text="Select a service and perform the following"
                                                runat="server" ></asp:Label>
                                            <asp:DropDownList ID="dList" runat="server" meta:resourcekey="dListResource1" CssClass="ddlsmall">
                                            </asp:DropDownList>
                                            <asp:Button ID="bGo" runat="server" Text="Go" OnClick="bGo_Click" CssClass="btn"
                                                OnClientClick="javascript:return CheckVisitID();" onmouseover="this.className='btn btnhov'"
                                                onmouseout="this.className='btn'" meta:resourcekey="bGoResource1" />
                                        </td>
                                    </tr>
                                </table>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                </td>
            </tr>
        </table>
        <input type="hidden" id="hdnBillNo" name="bid" value="0" runat="server" />
        <input type="hidden" id="hdnBID" name="bid" value="0" runat="server" />
        <input type="hidden" id="hdnVID" name="vid" value="0" runat="server" />
        <input type="hidden" id="hdnPID" name="pid" value="0" runat="server" />
        <input type="hidden" id="hdnPNAME" name="PName" runat="server" />
        <input type="hidden" id="hdnPNumber" name="PNumber" runat="server" />
        <input type="hidden" id="hdnVisitDetail" runat="server" />
        <input type="hidden" id="hdnBillStatus" name="bStatus" runat="server" />
        <input type="hidden" id="hdnpatientType" runat="server" />
        <input type="hidden" id="hdnVisitTypeCredit" name="bStatus1" runat="server" />
        <asp:HiddenField runat="server" ID="hdnBillNumber" />
        <uc5:Footer ID="Footer1" runat="server" />
    </div>
    </form>
</body>
</html>
