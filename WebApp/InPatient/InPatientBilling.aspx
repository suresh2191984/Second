<%@ Page Language="C#" AutoEventWireup="true" CodeFile="InPatientBilling.aspx.cs"
    Inherits="Billing_InPatientBilling" EnableEventValidation="false" meta:resourcekey="PageResource1" culture="auto" uiculture="auto" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc121" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/DueDetails.ascx" TagName="DueDetail" TagPrefix="uc6" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/PatientHeader.ascx" TagName="PatientHeader" TagPrefix="uc8" %>
<%@ Register Src="../CommonControls/InPatientProceduresBill.ascx" TagName="ipTreatmentBillDetails"
    TagPrefix="uc9" %>
<%@ Register Src="../CommonControls/ConsultationDetails.ascx" TagName="ipConsultationDetails"
    TagPrefix="uc10" %>
<%@ Register Src="../CommonControls/ConsultantDynamic.ascx" TagName="uctrlConsultantDynamic"
    TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/InPatientInvestigation.ascx" TagName="ipInvestigation"
    TagPrefix="uc11" %>
<%@ Register Src="../CommonControls/InvestigationControl.ascx" TagName="InvestigationControl"
    TagPrefix="ucinv1" %>
<%@ Register Src="../CommonControls/MedicalIndents.ascx" TagName="medIndents" TagPrefix="uc13" %>
<%@ Register Src="../CommonControls/SurgicalItems.ascx" TagName="SurItems" TagPrefix="uc14" %>
<%@ Register Src="../CommonControls/DynamicDHEBAdder.ascx" TagName="OtherPayments"
    TagPrefix="uc15" %>
<%@ Register Src="../CommonControls/GeneralBillItems.ascx" TagName="gbi" TagPrefix="ucGBI" %>
<%@ Register Src="../CommonControls/DisplayAllData.ascx" TagName="DisplayAllData"
    TagPrefix="uc17" %>
<%@ Register Src="../CommonControls/OrderSurgeryPkgItems.ascx" TagName="OrderSurgeryPkgItems"
    TagPrefix="uc12" %>
<%@ Register Src="../CommonControls/SurgeryPackageItems.ascx" TagName="SurgeryPackageItems"
    TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>In-Patient Billing</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
    <link href="../StyleSheets/StyleSheet.css" rel="Stylesheet" type="text/css" />
    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript" src="../Scripts/animatedcollapse.js"></script>

    <script src="../Scripts/jquery-1.2.2.pack.js" type="text/javascript"></script>

    <link href="../StyleSheets/DHEBAdder.css" rel="Stylesheet" type="text/css" />

    <script src="../Scripts/MessageHandler.js" type="text/javascript"></script>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <style type="text/css">
        .ddlTheme
        {
            height: 22px;
        }
    </style>
</head>
<body onload="CreateIndentTables();" oncontextmenu="return true;" onkeydown="SuppressBrowserRefresh();">
    <form id="form1" runat="server">

    <script type="text/javascript">

        animatedcollapse.addDiv('divDuechart', 'fade=1,height=1%');
        animatedcollapse.init();

        function makeItTrue() {
            $get('btnSave').disabled = false;
        }
        function validate(bid) {

            //            var temphidvalue = document.getElementById('IpConsultationDetails1_iconHidDelete').value + document.getElementById('dspData_hdfBillType').value + document.getElementById('InvestigationControl1_iconHid').value + document.getElementById('medIndents_hdfIndent').value + document.getElementById('OtherPayments_hdfValues').value;

            //            if (temphidvalue == '') {
            //                alert("Add any one payment type");
            //                return false;
            //            }
            //            else {
            $get(bid).disabled = true;
            javascript: __doPostBack(bid, '');
            //            }
        }
        function ViewBill() {
            var listArray = new Array();
            listArray = document.getElementById('hdnPDetail').value.split('~')
            var pID = listArray[1];
            var vID = listArray[0];
            var PName = listArray[2];
            window.open("IPViewBillTemp.aspx?PID=" + pID + "&VID=" + vID + "&PNAME=" + PName + "&vType=IP&BP=N&IsPopup=Y" + "", "Patient", "height=640,width=800,scrollbars=yes");
        }
        function changefuncion() {
            //alert('changefuncion');             ;
            var typ = document.getElementById("<%= ddlTypes.ClientID %>").value;
            var Cons = document.getElementById('divConsultation');
            var Inves = document.getElementById('divInvestigation');
            var Treat = document.getElementById('divTreatmentBill');
            var Indents = document.getElementById('divIndents');
            var others = document.getElementById('divOthers');
            var Surgical = document.getElementById('divSurgical');
            var genBill = document.getElementById('divGeneralBills');
            var dSPI = document.getElementById('divSPI');

            if (typ == "CON") {
                Cons.style.display = "block";
                Inves.style.display = "none";
                Treat.style.display = "none";
                Indents.style.display = "none";
                others.style.display = "none";
                Surgical.style.display = "none";
                genBill.style.display = "none";
                dSPI.style.display = "none";
            }
            else if (typ == "PRO") {
                Cons.style.display = "none";
                Inves.style.display = "none";
                Treat.style.display = "block";
                Indents.style.display = "none";
                others.style.display = "none";
                Surgical.style.display = "none";
                genBill.style.display = "none";
                dSPI.style.display = "none";
            }
            else if (typ == "INV") {
                Cons.style.display = "none";
                Inves.style.display = "block";
                Treat.style.display = "none";
                Indents.style.display = "none";
                others.style.display = "none";
                Surgical.style.display = "none";
                genBill.style.display = "none";
                dSPI.style.display = "none";
            }
            else if (typ == "OTH") {
                Cons.style.display = "none";
                Inves.style.display = "none";
                Treat.style.display = "none";
                Indents.style.display = "none";
                others.style.display = "block";
                Surgical.style.display = "none";
                genBill.style.display = "none";
                dSPI.style.display = "none";
            }
            else if (typ == "SUR") {
                Cons.style.display = "none";
                Inves.style.display = "none";
                Treat.style.display = "none";
                Indents.style.display = "none";
                others.style.display = "none";
                Surgical.style.display = "block";
                genBill.style.display = "none";
                dSPI.style.display = "none";
            }
            else if (typ == "IND") {
                Cons.style.display = "none";
                Inves.style.display = "none";
                Treat.style.display = "none";
                Indents.style.display = "block";
                others.style.display = "none";
                Surgical.style.display = "none";
                genBill.style.display = "none";
                dSPI.style.display = "none";
            }
            else if (typ == "GEN") {
                Cons.style.display = "none";
                Inves.style.display = "none";
                Treat.style.display = "none";
                Indents.style.display = "none";
                others.style.display = "none";
                Surgical.style.display = "none";
                genBill.style.display = "block";
                dSPI.style.display = "none";
            }
            else if (typ == "SPKG") {
                Cons.style.display = "none";
                Inves.style.display = "none";
                Treat.style.display = "none";
                Indents.style.display = "none";
                others.style.display = "none";
                Surgical.style.display = "none";
                genBill.style.display = "none";
                dSPI.style.display = "block";
            }
            else {
                Cons.style.display = "none";
                Inves.style.display = "none";
                Treat.style.display = "none";
                Indents.style.display = "none";
                others.style.display = "none";
                Surgical.style.display = "none";
                genBill.style.display = "none";
                dSPI.style.display = "none";
            }
        }
    </script>

    <asp:ScriptManager ID="scrpt" runat="server">
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
                <uc8:PatientHeader ID="PatientHeader" runat="server" />
            </div>
            <div style="float: right;" class="Rightheader">
            </div>
        </div>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
                <td width="15%" valign="top" id="menu" style="display: block;">
                    <div id="navigation">
                        <uc121:LeftMenu ID="LeftMenu1" runat="server" />
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
                        <%--<asp:UpdatePanel ID="pnlOrder" runat="server">
                            <ContentTemplate>--%>
                        <table width="100%" border="0">
                            <tr>
                                <td>
                                    <table width="50%" border="0" align="center">
                                        <tr id="trPreAuthLimitMsg" runat="server" style="display: none;">
                                            <td align="center" colspan="2">
                                                <asp:Label ID="lbl" runat="server" Font-Bold="True" Text="Bill amount is exceeds the pre authorization amount "
                                                    ForeColor="Red" meta:resourcekey="lblResource1"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr id="Preauth" runat="server" style="display: none">
                                            <td align="right">
                                                <asp:Label ID="Label1" runat="server" Text="Pre Authorization Amount :" Font-Bold="True"
                                                    meta:resourcekey="Label1Resource1"></asp:Label>
                                            </td>
                                            <td align="left">
                                                <asp:Label ID="lblPreAuthAmount" runat="server" Font-Bold="True" meta:resourcekey="lblPreAuthAmountResource1"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr id="trGross" runat="server" style="display: none">
                                            <td align="right">
                                                <asp:Label ID="Label2" runat="server" Text="Gross Amount :" Font-Bold="True" meta:resourcekey="Label2Resource1"></asp:Label>
                                            </td>
                                            <td align="left">
                                                <asp:Label ID="lblGross" runat="server" Font-Bold="True" meta:resourcekey="lblGrossResource1"></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 100%;">
                                    <asp:Panel ID="pnltempItems" runat="server" CssClass="defaultfontcolor" meta:resourcekey="pnltempItemsResource1">
                                        <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                            <tr>
                                                <td class="colorforcontent" style="width: 25%;" height="23" align="left">
                                                    <div id="ACX2plusTemp" style="display: Block; width: 394px; margin-bottom: 0px;">
                                                        &nbsp;<img src="../Images/ShowBids.gif" alt="Show" width="15" height="15" align="top"
                                                            style="cursor: pointer" onclick="showResponses('ACX2plusTemp','ACX2minusTemp','ACX2responsesTemp',1);" />
                                                        <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plusTemp','ACX2minusTemp','ACX2responsesTemp',1);">
                                                            &nbsp;<asp:Label ID="Rs_PreviousDues" Text="Previous Dues" runat="server" meta:resourcekey="Rs_PreviousDuesResource1"></asp:Label>
                                                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;
                                                            &nbsp;&nbsp;&nbsp;
                                                            <asp:Label ID="lbtotamt" runat="server" Text="Total Amount" 
                                                            meta:resourcekey="lbtotamtResource1"></asp:Label>:&nbsp;
                                                            <asp:Label ID="lblTotalAmount1" runat="server" meta:resourcekey="lblTotalAmount1Resource1"></asp:Label></span>
                                                    </div>
                                                    <div id="ACX2minusTemp" style="display: None;">
                                                        &nbsp;<img src="../Images/HideBids.gif" alt="hide" width="15px" height="15px" align="top"
                                                            style="cursor: pointer" onclick="showResponses('ACX2plusTemp','ACX2minusTemp','ACX2responsesTemp',0);" />
                                                        <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plusTemp','ACX2minusTemp','ACX2responsesTemp',0);">
                                                            &nbsp;<asp:Label ID="Rs_PreviousDues1" Text="Previous Dues" runat="server" meta:resourcekey="Rs_PreviousDues1Resource1"></asp:Label>
                                                    </div>
                                                </td>
                                                <td style="width: 75%" height="23" align="left">
                                                    <asp:Button ID="lbtnViewBill" runat="server" Text="View Bill" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                        onmouseout="this.className='btn'" OnClientClick="ViewBill(); return false;" Height="26px"
                                                        meta:resourcekey="lbtnViewBillResource1" Width="73px" />
                                                    <asp:HiddenField ID="hdnPDetail" runat="server" />
                                                </td>
                                            </tr>
                                            <tr class="tablerow" id="ACX2responsesTemp" style="display: None;">
                                                <td colspan="2">
                                                    <div class="filterdatahe">
                                                        <asp:GridView ID="grdDuechart" runat="server" AutoGenerateColumns="False" BackColor="White"
                                                            BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3" Font-Bold="False"
                                                            meta:resourcekey="grdDuechartResource1">
                                                            <Columns>
                                                                <asp:BoundField DataField="Description" HeaderText="Description" meta:resourcekey="BoundFieldResource1" />
                                                                <asp:BoundField DataField="Comments" HeaderText="Comments" meta:resourcekey="BoundFieldResource2" />
                                                                <asp:BoundField DataField="FromDate" DataFormatString="{0:dd/MM/yyyy hh:mm tt}" HeaderText="From"
                                                                    meta:resourcekey="BoundFieldResource3" />
                                                                <asp:BoundField DataField="ToDate" DataFormatString="{0:dd/MM/yyyy hh:mm tt}" HeaderText="To"
                                                                    meta:resourcekey="BoundFieldResource4" />
                                                                <asp:BoundField DataField="AMOUNT" HeaderText="UnitPrice" meta:resourcekey="BoundFieldResource5" />
                                                                <asp:BoundField DataField="unit" HeaderText="Quantity" meta:resourcekey="BoundFieldResource6" />
                                                                <asp:TemplateField HeaderText="Amount" meta:resourcekey="TemplateFieldResource1">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblAmount" runat="server" meta:resourcekey="lblAmountResource1" Text='<%# NumberConvert(Eval("unit"),Eval("AMOUNT")) %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                            </Columns>
                                                            <FooterStyle BackColor="White" ForeColor="#000066" />
                                                            <HeaderStyle CssClass="grdcolor" Font-Bold="True" />
                                                            <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                                            <RowStyle ForeColor="#000066" />
                                                            <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                        </asp:GridView>
                                                        <br />
                                                        <div align="right" style="width: 550px; font-weight: bold;">
                                                            <asp:Label ID="Rs_TotalAmount" Text="Total Amount :" runat="server" meta:resourcekey="Rs_TotalAmountResource1"></asp:Label>
                                                            <asp:Label ID="lblTotalAmount" runat="server" Text="Label" meta:resourcekey="lblTotalAmountResource1"></asp:Label>
                                                        </div>
                                                        <br />
                                                    </div>
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <uc12:OrderSurgeryPkgItems ID="OSPI" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="Rs_SelectPaymentType" Text="Select Payment Type" runat="server" meta:resourcekey="Rs_SelectPaymentTypeResource1"></asp:Label>
                                    <asp:DropDownList ID="ddlTypes" CssClass="ddlsmall" runat="server" onChange="changefuncion()"
                                        meta:resourcekey="ddlTypesResource1">
                                        <asp:ListItem Text="--Select--" Value="SEL" meta:resourcekey="ListItemResource1"></asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <table cellpadding="0" cellspacing="0" width="100%">
                                        <tr>
                                            <td>
                                                <div id="divConsultation" style="display: none;" runat="server">
                                                    <%--<uc10:ipConsultationDetails ID="ipConsultation" runat="server" />--%>
                                                    <uc1:uctrlConsultantDynamic ID="IpConsultationDetails1" runat="server" />
                                                </div>
                                                <div id="divInvestigation" style="display: none;">
                                                    <asp:Label ID="Rs_Date" Text="Date :" runat="server" meta:resourcekey="Rs_DateResource1"></asp:Label>
                                                    <asp:TextBox ID="txtInvDate" runat="server" Width="130px" TabIndex="4" Style="text-align: justify"
                                                        ValidationGroup="MKE" meta:resourcekey="txtInvDateResource1" />
                                                    <a href="javascript:NewCal('<%=txtInvDate.ClientID %>','ddmmyyyy',true,12)">
                                                        <img src="../Images/Calendar_scheduleHS.png" width="16" height="16" border="0" alt="Pick a date" /></a>
                                                    <br />
                                                    <ucinv1:InvestigationControl ID="InvestigationControl1" runat="server" />
                                                </div>
                                                <div id="divTreatmentBill" style="display: none;" align="center">
                                                    <asp:Label ID="Rs_Date1" Text="Date :" runat="server" meta:resourcekey="Rs_Date1Resource1"></asp:Label>
                                                    <asp:TextBox ID="txtProcedureDT" runat="server" Width="130px" TabIndex="4" Style="text-align: justify"
                                                        ValidationGroup="MKE" meta:resourcekey="txtProcedureDTResource1" />
                                                    <a href="javascript:NewCal('<%=txtProcedureDT.ClientID %>','ddmmyyyy',true,12)">
                                                        <img src="../Images/Calendar_scheduleHS.png" width="16" height="16" border="0" alt="Pick a date" /></a>
                                                    <br />
                                                    <uc9:ipTreatmentBillDetails ID="ipTreatmentBill" runat="server" />
                                                </div>
                                                <div id="divIndents" style="display: none;">
                                                    <uc13:medIndents ID="medIndents" runat="server" />
                                                </div>
                                                <div id="divOthers" style="display: none;">
                                                    <uc15:OtherPayments ID="OtherPayments" runat="server" ServiceMethod="m10" ServicePath="~/p"
                                                        DescriptionDisplayText="FeeType" CommentDisplayText="Amount" />
                                                </div>
                                                <div id="divSurgical" style="display: none;">
                                                    <uc14:SurItems ID="SurgicalItems" runat="server" />
                                                </div>
                                                <br />
                                                <div id="divGeneralBills" style="display: none;">
                                                    <uc17:DisplayAllData ID="dspData" runat="server" />
                                                    <asp:Label ID="Rs_Date2" Text="Date :" runat="server" meta:resourcekey="Rs_Date2Resource1"></asp:Label>
                                                    <asp:TextBox ID="txtgenDate" runat="server" Width="130px" TabIndex="4" Style="text-align: justify"
                                                        ValidationGroup="MKE" meta:resourcekey="txtgenDateResource1" />
                                                    <a href="javascript:NewCal('<%=txtgenDate.ClientID %>','ddmmyyyy',true,12)">
                                                        <img src="../Images/Calendar_scheduleHS.png" width="16" height="16" border="0" alt="Pick a date" /></a>
                                                    <br />
                                                    <ucGBI:gbi ID="ucGBI" runat="server" />
                                                </div>
                                                <div id="divSPI" style="display: none;">
                                                    <uc3:SurgeryPackageItems ID="SPI" runat="server" />
                                                </div>
                                                <br />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="6">
                                                <asp:Button ID="btnSave" runat="server" Text="Add to Due Chart" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                    onmouseout="this.className='btn'" OnClientClick="return validate(this.id);" OnClick="btnSave_Click"
                                                    meta:resourcekey="btnSaveResource1" />
                                                <asp:Button ID="btnEditDueChart" runat="server" Text="Edit Dues" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                    onmouseout="this.className='btn'" OnClick="btnEditDueChart_Click" meta:resourcekey="btnEditDueChartResource1" />
                                                <asp:Button ID="btnFinish" runat="server" Text="Make Payment" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                    onmouseout="this.className='btn'" OnClientClick="return validate(this.id);" OnClick="btnFinish_Click"
                                                    meta:resourcekey="btnFinishResource1" />
                                                <asp:Button ID="btnClose" runat="server" Text="Close" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                    onmouseout="this.className='btn'" OnClick="btnClose_Click" meta:resourcekey="btnCloseResource1" />
                                                <asp:HiddenField ID="hdnInterimBillNo" runat="server" />
                                                <br />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                        <%--</ContentTemplate>
                        </asp:UpdatePanel>--%>
                    </div>
                </td>
            </tr>
        </table>
        <uc5:Footer ID="Footer1" runat="server" />
    </div>
    <asp:HiddenField ID="hdnMessages" runat="server" />
    </form>
</body>
</html>
