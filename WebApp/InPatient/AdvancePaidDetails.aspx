<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AdvancePaidDetails.aspx.cs"
    Inherits="Reception_AdvancePaidDetails" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc121" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/PatientHeader.ascx" TagName="PatientHeader" TagPrefix="uc8" %>
<%@ Register Src="../CommonControls/InPatientProceduresBill.ascx" TagName="ipTreatmentBillDetails"
    TagPrefix="uc9" %>
<%@ Register Src="../CommonControls/ConsultationDetails.ascx" TagName="ipConsultationDetails"
    TagPrefix="uc10" %>
<%@ Register Src="../CommonControls/InPatientInvestigation.ascx" TagName="ipInvestigation"
    TagPrefix="uc11" %>
<%@ Register Src="../CommonControls/InvestigationControl.ascx" TagName="InvestigationControl"
    TagPrefix="ucinv1" %>
<%@ Register Src="../CommonControls/MedicalIndents.ascx" TagName="medIndents" TagPrefix="uc13" %>
<%@ Register Src="../CommonControls/DynamicDHEBAdder.ascx" TagName="OtherPayments"
    TagPrefix="uc14" %>
<%@ Register Src="../CommonControls/PaymentTypeDetails.ascx" TagName="PaymentType"
    TagPrefix="uc15" %>
<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Add Payments</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
    <%--<link href="../StyleSheets/StyleSheet.css" rel="Stylesheet" type="text/css" />--%>
          <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <script src="../Scripts/bid.js" type="text/javascript"></script>

    <script src="../Scripts/animatedcollapse.js" type="text/javascript"></script>

    <script src="../Scripts/jquery-1.2.2.pack.js" type="text/javascript"></script>

    <link href="../StyleSheets/DHEBAdder.css" rel="Stylesheet" type="text/css" />

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">
    function PopUpPage() {
    
        dDate = document.getElementById('<%= hdnDate.ClientID %>').value;
        dAmount = document.getElementById('<%= hdnAmount.ClientID %>').value;
        if((dAmount != "")&&(Number(dAmount) > 0))
        {
            var strFeatures = "toolbar=no,status=no,menubar=no,location=no";
            strFeatures = strFeatures + ",scrollbars=yes,resizable=yes,height=600,width=800";
            strFeatures = strFeatures + ",left=0,top=0";
            var strURL = "PrintReceiptPage.aspx?Amount=" + dAmount + "&dDate=" + dDate + "&PNAME=<%=Request.QueryString["PNAME"] %>";
            window.open(strURL, "", strFeatures, true);
            
        }
        else
        {
                alert('Select a payment');
        }
    }
    
    function ClearScriptDatas()
    {
    document.getElementById('<%= hdnAmount.ClientID %>').value="";
             document.getElementById('<%= hdnDate.ClientID %>').value="";
             document.getElementById('<%= hdnNowPaid.ClientID %>').value="";
    }
    
    </script>

</head>
<body oncontextmenu="return false;">
    <form id="form2" runat="server" defaultbutton="btnSave">

    <script type="text/javascript">
        function changefuncion() {
            var typ = document.getElementById("<%= ddlPaymentFor.ClientID %>").value;
            var Inves = document.getElementById('divInvestigation');
            var Treat = document.getElementById('divTreatmentBill');
            var Advance = document.getElementById('divAdvance');
            var others = document.getElementById('divOthers');

            if (typ == "PRO") {
                Inves.style.display = "none";
                Treat.style.display = "block";
                others.style.display = "none";
                Advance.style.display = "none";
            }
            else if (typ == "INV") {
                Inves.style.display = "block";
                Treat.style.display = "none";
                others.style.display = "none";
                Advance.style.display = "none";
            }
            else if (typ == "OTH") {
                Inves.style.display = "none";
                Treat.style.display = "none";
                others.style.display = "block";
                Advance.style.display = "none";
            }
            else if (typ == "ADV") {
                Inves.style.display = "none";
                Treat.style.display = "none";
                others.style.display = "none";
                Advance.style.display = "block";
            }
            else {
                Inves.style.display = "none";
                Treat.style.display = "none";
                others.style.display = "none";
                Advance.style.display = "none";
            }
        }

        function CallPrintReceipt(dDate, dAmount, idValue) {
            var previousAmount = document.getElementById('<%= hdnAmount.ClientID %>').value;
            var newAmount = 0;
            document.getElementById('hdnCount').value;
            var objChkBok = document.getElementById(idValue);

            document.getElementById('<%= hdnDate.ClientID %>').value = "";
            if (objChkBok.checked == true) {

                newAmount = Number(previousAmount) + Number(dAmount);
            }
            if (objChkBok.checked == false) {
                newAmount = Number(previousAmount) - Number(dAmount);
            }

            document.getElementById('<%= hdnAmount.ClientID %>').value = newAmount;
        }


        function ModifyAmountValue(PaymentAmount, TotalAmount, ServiceCharge) {
            if (addedAmount > 0) {
                var oldAmount = document.getElementById('<%= txtPayment.ClientID %>').value;
                oldAmount = Number(oldAmount) + Number(TotalAmount);
                ServiceCharge = (Number(ServiceCharge) * Number(PaymentAmount) / 100);
                document.getElementById('<%= txtServiceCharge.ClientID %>').value = format_number(Number(ServiceCharge) + Number(tempService), 2);
                document.getElementById('<%= hdnServiceCharge.ClientID %>').value = format_number(Number(ServiceCharge) + Number(tempService), 2);
                document.getElementById('<%= txtPayment.ClientID %>').value = format_number(oldAmount, 2);
                document.getElementById('<%= hdnNowPaid.ClientID %>').value = format_number(oldAmount, 2);
                return true;
            }
            else {
                alert('Amount cannot be zero');
                return false;
            }
        }


        function DeleteAmountValue(PaymentAmount, TotalAmount, ServiceCharge) {
            var oldAmount = document.getElementById('<%= txtPayment.ClientID %>').value;
            oldAmount = Number(oldAmount) - Number(TotalAmount);
            document.getElementById('<%= txtPayment.ClientID %>').value = format_number(oldAmount, 2);
            document.getElementById('<%= hdnNowPaid.ClientID %>').value = format_number(oldAmount, 2);

            ServiceCharge = (Number(ServiceCharge) * Number(PaymentAmount) / 100);

            document.getElementById('<%= txtServiceCharge.ClientID %>').value = format_number(Number(tempService) - Number(ServiceCharge), 2);
            document.getElementById('<%= hdnServiceCharge.ClientID %>').value = format_number(Number(tempService) - Number(ServiceCharge), 2);

        }

        function chkCreditPament() {
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
                        <table border="0" width="100%" cellpadding="4" cellspacing="1" class="defaultfontcolor">
                            <tr>
                                <td>
                                    <table>
                                        <tr>
                                            <td>
                                               <asp:Label ID="Rs_PatientNumber" Text="Patient Number :" runat="server" 
                                                    meta:resourcekey="Rs_PatientNumberResource1"></asp:Label>
                                            </td>
                                            <td class="style3">
                                                <asp:Label ID="lblPatientID" runat="server" 
                                                    meta:resourcekey="lblPatientIDResource1"></asp:Label>
                                            </td>
                                            <td>
                                                &nbsp;&nbsp;&nbsp;
                                            </td>
                                            <td>
                                                <asp:Label ID="Rs_PatientName" Text="Patient Name :" runat="server" 
                                                    meta:resourcekey="Rs_PatientNameResource1"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label ID="lblPatientName" runat="server" 
                                                    meta:resourcekey="lblPatientNameResource1"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                &nbsp;
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="Rs_PaymentFor" Text="Payment For :" runat="server" 
                                                    meta:resourcekey="Rs_PaymentForResource1"></asp:Label>
                                            </td>
                                            <td class="style3">
                                                <asp:DropDownList ID="ddlPaymentFor" CssClass ="ddlsmall" runat="server" 
                                                    onChange="changefuncion()" meta:resourcekey="ddlPaymentForResource1">
                                                    <asp:ListItem Text="--Select--" Value="SEL" 
                                                        meta:resourcekey="ListItemResource1"></asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                            <td>
                                                &nbsp;&nbsp;&nbsp;
                                            </td>
                                            <td>
                                                &nbsp;
                                            </td>
                                            <td>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Panel ID="pnltempItems" runat="server" CssClass="defaultfontcolor" 
                                        meta:resourcekey="pnltempItemsResource1">
                                        <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                            <tr>
                                                <td class="colorforcontent" style="width: 25%;" height="23" align="left">
                                                    <div id="ACX2plusTemp" style="display: Block; width: 393px;">
                                                        &nbsp;<img src="../Images/ShowBids.gif" alt="Show" width="15" height="15" align="top"
                                                            style="cursor: pointer" onclick="showResponses('ACX2plusTemp','ACX2minusTemp','ACX2responsesTemp',1);" />
                                                        <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plusTemp','ACX2minusTemp','ACX2responsesTemp',1);">
                                                            &nbsp;<asp:Label ID="Rs_UnBilledItems" Text="UnBilled Items" runat="server" 
                                                            meta:resourcekey="Rs_UnBilledItemsResource1"></asp:Label></span>
                                                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Total Amount :&nbsp;
                                                        <asp:Label ID="lblTotalAmount" runat="server" Text="Label" 
                                                            meta:resourcekey="lblTotalAmountResource1"></asp:Label>
                                                    </div>
                                                    <div id="ACX2minusTemp" style="display: none;">
                                                        &nbsp;<img src="../Images/HideBids.gif" alt="hide" width="15px" height="15px" align="top"
                                                            style="cursor: pointer" onclick="showResponses('ACX2plusTemp','ACX2minusTemp','ACX2responsesTemp',0);" />
                                                        <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plusTemp','ACX2minusTemp','ACX2responsesTemp',0);">
                                                        &nbsp;<asp:Label ID="Rs_UnBilledItems1" Text="UnBilled Items" runat="server" 
                                                            meta:resourcekey="Rs_UnBilledItems1Resource1"></asp:Label>
                                                    </div>
                                                </td>
                                                <td style="width: 75%" height="23" align="left">
                                                    &nbsp;
                                                </td>
                                            </tr>
                                            <tr class="tablerow" id="ACX2responsesTemp" style="display: none;">
                                                <td colspan="2">
                                                    <div class="filterdatahe">
                                                        <asp:GridView ID="grdDuechart" runat="server" AutoGenerateColumns="False" BackColor="White"
                                                            BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3" 
                                                            Font-Bold="False" meta:resourcekey="grdDuechartResource1">
                                                            <Columns>
                                                                <asp:BoundField DataField="Description" HeaderText="Description" 
                                                                    meta:resourcekey="BoundFieldResource1" />
                                                                <asp:BoundField DataField="Comments" HeaderText="Comments" 
                                                                    meta:resourcekey="BoundFieldResource2" />
                                                                <asp:BoundField DataField="FromDate" DataFormatString="{0:dd/MM/yyyy hh:mm tt}" 
                                                                    HeaderText="From" meta:resourcekey="BoundFieldResource3" />
                                                                <asp:BoundField DataField="ToDate" DataFormatString="{0:dd/MM/yyyy hh:mm tt}" 
                                                                    HeaderText="To" meta:resourcekey="BoundFieldResource4" />
                                                                <asp:BoundField DataField="AMOUNT" HeaderText="UnitPrice" 
                                                                    meta:resourcekey="BoundFieldResource5" />
                                                                <asp:BoundField DataField="unit" HeaderText="Quantity" 
                                                                    meta:resourcekey="BoundFieldResource6" />
                                                                <asp:TemplateField HeaderText="Amount" 
                                                                    meta:resourcekey="TemplateFieldResource1">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblAmount" runat="server" meta:resourcekey="lblAmountResource1" 
                                                                            Text='<%# NumberConvert(Eval("unit"),Eval("AMOUNT")) %>'></asp:Label>
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
                                                        <div align="right" style="width: 500px; font-weight: bold;">
                                                            <asp:Label ID="Rs_TotalAmount"  Text="Total Amount :" runat="server" 
                                                                meta:resourcekey="Rs_TotalAmountResource1"></asp:Label>
                                                            <asp:Label ID="lblTotalAmount2" runat="server" 
                                                                meta:resourcekey="lblTotalAmount2Resource1"></asp:Label>
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
                                <td style="text-decoration: none">
                                    <div id="divInvestigation" style="display: none;">
                                        <ucinv1:InvestigationControl ID="InvestigationControl1" runat="server" />
                                    </div>
                                    <div id="divTreatmentBill" style="display: none;">
                                        <uc9:ipTreatmentBillDetails ID="ipTreatmentBill" runat="server" />
                                    </div>
                                    <div id="divAdvance" style="display: none;">
                                        <asp:Panel ID="pnltempAdvancePayments" runat="server" 
                                            CssClass="defaultfontcolor" meta:resourcekey="pnltempAdvancePaymentsResource1">
                                            <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td class="colorforcontent" style="width: 25%;" height="23" align="left">
                                                        <div id="ACX2plusAdvPmt" style="display: block; width: 393px">
                                                            &nbsp;<img src="../Images/ShowBids.gif" alt="Show" width="15" height="15" align="top"
                                                                style="cursor: pointer" onclick="showResponses('ACX2plusAdvPmt','ACX2minusAdvPmt','ACX2responsesAdvPmt',1);" />
                                                            <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plusAdvPmt','ACX2minusAdvPmt','ACX2responsesAdvPmt',1);">
                                                                &nbsp;<asp:Label ID="Rs_PreviousAdvancePayments" 
                                                                Text="Previous Advance Payments" runat="server" 
                                                                meta:resourcekey="Rs_PreviousAdvancePaymentsResource1"></asp:Label></span> 
                                                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Total :&nbsp;<asp:Label ID="lblAdvancePaid" runat="server" 
                                                                meta:resourcekey="lblAdvancePaidResource1"></asp:Label>
                                                        </div>
                                                        <div id="ACX2minusAdvPmt" style="display: none;">
                                                            &nbsp;<img src="../Images/HideBids.gif" alt="hide" width="15px" height="15px" align="top"
                                                                style="cursor: pointer" onclick="showResponses('ACX2plusAdvPmt','ACX2minusAdvPmt','ACX2responsesAdvPmt',0);" />
                                                            <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plusAdvPmt','ACX2minusAdvPmt','ACX2responsesAdvPmt',0);">
                                                            &nbsp;<asp:Label ID="Rs_PreviousAdvancePayments1" Text="Previous Advance Payments" 
                                                                runat="server" meta:resourcekey="Rs_PreviousAdvancePayments1Resource1"></asp:Label>
                                                        </div>
                                                    </td>
                                                    <td style="width: 75%" height="23" align="left">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                                <tr class="tablerow" id="ACX2responsesAdvPmt" style="display: none;">
                                                    <td colspan="2">
                                                        <div class="filterdatahe">
                                                            <asp:GridView ID="gvAdvancePaidDetails" runat="server" AutoGenerateColumns="False"
                                                                BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px"
                                                                CellPadding="3" Font-Bold="False" Width="50%" 
                                                                meta:resourcekey="gvAdvancePaidDetailsResource1">
                                                                <Columns>
                                                                    <asp:TemplateField HeaderText="Sel" meta:resourcekey="TemplateFieldResource2">
                                                                        <ItemTemplate>
                                                                            <input ID="rdoID" runat="server" 
                                                                                onclick="CallPrintReceipt(pDate,pAmount,this.id);" type="checkbox"></input>
                                                                            </input>
                                                                        </ItemTemplate>
                                                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                                                    </asp:TemplateField>
                                                                    <asp:BoundField DataField="AdvanceAmount" HeaderText="Amount" 
                                                                        meta:resourcekey="BoundFieldResource7">
                                                                        <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="PaidDate" DataFormatString="{0:dd/MM/yyyy hh:mm tt}" 
                                                                        HeaderText="Paid Date" meta:resourcekey="BoundFieldResource8">
                                                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                                                    </asp:BoundField>
                                                                </Columns>
                                                                <FooterStyle BackColor="White" ForeColor="#000066" />
                                                                <HeaderStyle CssClass="grdcolor" Font-Bold="True" />
                                                                <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                                                <RowStyle ForeColor="#000066" />
                                                                <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                            </asp:GridView>
                                                            <div align="right" style="width: 330px; font-weight: bold;">
                                                                <asp:Label ID="Rs_Total" Text="Total :" runat="server" 
                                                                    meta:resourcekey="Rs_TotalResource1"></asp:Label>&nbsp;<asp:Label ID="lblAdvancePaid1" runat="server" 
                                                                    meta:resourcekey="lblAdvancePaid1Resource1"></asp:Label>
                                                            </div>
                                                            <asp:Button ID="btnPrint" runat="server" Text="Print Receipt" CssClass="btn1" onmouseover="this.className='btn1 btnhov1'"
                                                                onmouseout="this.className='btn1'" 
                                                                OnClientClick='PopUpPage();return false;' 
                                                                meta:resourcekey="btnPrintResource1" />
                                                        </div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </asp:Panel>
                                        <br clear="all" />
                                        <asp:Label ID="Rs_ServiceCharge" Text="Service Charge :" runat="server" 
                                            meta:resourcekey="Rs_ServiceChargeResource1"></asp:Label>
                                        <asp:TextBox ID="txtServiceCharge" Enabled="False" runat="server" Text="0.00" TabIndex="9"
                                            CssClass="textBoxRightAlign" 
                                            meta:resourcekey="txtServiceChargeResource1" />
                                        <asp:HiddenField ID="hdnServiceCharge" runat="server" Value="0" />
                                        <br clear="all" />
                                        <asp:Label ID="Rs1_TotalAmount" Text="Total Amount :" runat="server" 
                                            meta:resourcekey="Rs1_TotalAmountResource1"></asp:Label>
                                        <asp:TextBox ID="txtPayment" Width="100px" Style="text-align: right;" runat="server"
                                            ReadOnly="True" CssClass="isocolor" meta:resourcekey="txtPaymentResource1" 
                                            Text="0"></asp:TextBox>
                                        <br />
                                        <uc15:PaymentType ID="PaymentTypes" runat="server" />
                                    </div>
                                    <div id="divOthers" style="display: none;">
                                        <uc14:OtherPayments ID="OtherPayments" runat="server" ServiceMethod="m10" ServicePath="~/p"
                                            DescriptionDisplayText="FeeType" CommentDisplayText="Amount" />
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td align="center">
                                    &nbsp;<asp:Button ID="btnSave" runat="server" Text="Save & Add More" CssClass="btn" Width="100px"
                                        onmouseover="this.className='btn btnhov1'" onmouseout="this.className='btn'"
                                        OnClick="btnSave_Click" meta:resourcekey="btnSaveResource1" />
                                    &nbsp;<asp:Button ID="btnFinish" runat="server" Text="Finish" CssClass="btn" onmouseover="this.className='btn btnhov1'"
                                        onmouseout="this.className='btn'" OnClick="btnFinish_Click" 
                                        meta:resourcekey="btnFinishResource1" />
                                    &nbsp;<asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn" onmouseover="this.className='btn btnhov1'"
                                        onmouseout="this.className='btn'" OnClick="btnCancel_Click" 
                                        meta:resourcekey="btnCancelResource1" />
                                </td>
                            </tr>
                        </table>
                        <input type="hidden" runat="server" id="hdnDate" />
                        <input type="hidden" id="hdnCount" />
                        <input type="hidden" runat="server" id="hdnAmount" />
                        <input type="hidden" runat="server" id="hdnNowPaid" />
                        <br />
                    </div>
                </td>
            </tr>
        </table>
        <uc5:Footer ID="Footer1" runat="server" />
    </div>
    </form>
</body>
</html>
