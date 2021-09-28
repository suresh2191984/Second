<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AmountApprovalDetails.aspx.cs"
    Inherits="Billing_AmountApprovalDetails" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="~/CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="~/CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />

    <script src="../Scripts/MessageHandler.js" type="text/javascript"></script>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script type="text/javascript">


        function AssignApprovalDetails(PatientDetailsValue) { 
            while (count = document.getElementById('tblPatientDetails').rows.length) {

                for (var j = 0; j < document.getElementById('tblPatientDetails').rows.length; j++) {
                    document.getElementById('tblPatientDetails').deleteRow(j);
                }
            }
            var Headrow = document.getElementById('tblPatientDetails').insertRow(0);
            Headrow.id = "HeadID";
            Headrow.style.fontWeight = "bold";
            Headrow.className = "dataheader1"
            var cell1 = Headrow.insertCell(0);
            var cell2 = Headrow.insertCell(1);
            var cell3 = Headrow.insertCell(2);
            var cell4 = Headrow.insertCell(3);
            var cell5 = Headrow.insertCell(4);
            var cell6 = Headrow.insertCell(5);
            cell1.innerHTML = "Patient Name";
            cell2.innerHTML = "Age";
            cell3.innerHTML = "Visit Purpose";
            cell4.innerHTML = "Approval Status";
            cell5.innerHTML = "Approval Type";
            cell6.innerHTML = "Created At";
            var row = document.getElementById('tblPatientDetails').insertRow(1);
            row.style.height = "13px";
            var cell1 = row.insertCell(0);
            var cell2 = row.insertCell(1);
            var cell3 = row.insertCell(2);
            var cell4 = row.insertCell(3);
            var cell5 = row.insertCell(4);
            var cell6 = row.insertCell(5);
            cell1.innerHTML = PatientDetailsValue.split('~')[0];
            cell2.innerHTML = PatientDetailsValue.split('~')[1]
            cell3.innerHTML = PatientDetailsValue.split('~')[2];
            cell4.innerHTML = PatientDetailsValue.split('~')[4];
            cell5.innerHTML = PatientDetailsValue.split('~')[3];
            cell6.innerHTML = PatientDetailsValue.split('~')[13];
            document.getElementById('hdnAprovelSatus').value = cell4;
             

            if (PatientDetailsValue.split('~')[3] == 'Cheque') {

                while (count = document.getElementById('tblChequeDetails').rows.length) {

                    for (var j = 0; j < document.getElementById('tblChequeDetails').rows.length; j++) {
                        document.getElementById('tblChequeDetails').deleteRow(j);
                    }
                }
                var Headrow = document.getElementById('tblChequeDetails').insertRow(0);
                Headrow.id = "HeadID";
                Headrow.style.fontWeight = "bold";
                Headrow.className = "dataheader1"
                var cell1 = Headrow.insertCell(0);
                var cell2 = Headrow.insertCell(1);
                var cell3 = Headrow.insertCell(2);
                var cell4 = Headrow.insertCell(3);
                cell1.innerHTML = "Cheque No";
                cell2.innerHTML = "Cheque valid Date";
                cell3.innerHTML = "Bank Name";
                cell4.innerHTML = "Amount";
                var row = document.getElementById('tblChequeDetails').insertRow(1);
                row.style.height = "13px";
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                var cell3 = row.insertCell(2);
                var cell4 = row.insertCell(3);
                cell1.innerHTML = PatientDetailsValue.split('~')[5];
                cell2.innerHTML = PatientDetailsValue.split('~')[6];
                cell3.innerHTML = PatientDetailsValue.split('~')[7];
                cell4.innerHTML = PatientDetailsValue.split('~')[8];


            }

            if (PatientDetailsValue.split('~')[5] == 'Discount') {
            }


            document.getElementById('<%= lblDiscountAmountText.ClientID %>').innerHTML = PatientDetailsValue.split('~')[9];
            document.getElementById('<%= lblTotalAmounttext.ClientID %>').innerHTML = PatientDetailsValue.split('~')[10];
            document.getElementById('<%= lblUSerName.ClientID %>').innerHTML = PatientDetailsValue.split('~')[11];
            document.getElementById('<%= lblRequestedComments.ClientID %>').innerHTML = PatientDetailsValue.split('~')[12];
        }

        
         
     
    </script>

</head>
<body>
    <form id="fnAAD" runat="server">
    <asp:ScriptManager ID="SMAAD" runat="server">
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
                <uc3:Header ID="ReceptionHeader" runat="server" />
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
                <td width="100%" valign="top" class="tdspace">
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
                                <uc6:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                        <div>
                            <table cellpadding="0" style="border: 0px; border-color: Red" runat="server" id="tbVisitClient"
                                border="0" cellspacing="0" width="100%">
                                <tr>
                                    <td align="center">
                                        <table cellpadding="0" style="border: 0px; border-color: Red" runat="server" id="Table1"
                                            border="0" cellspacing="0" width="90%">
                                            <tr align="left">
                                                <td colspan="4">
                                                    <br />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="center" colspan="4">
                                                    <asp:Label ID="lblHeaderText" runat="server" Font-Bold="true" Text="Amount Approval Details"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <br />
                                                </td>
                                            </tr>
                                            <tr align="left">
                                                <td colspan="4">
                                                    <table id="tblPatientDetails" border="1" cellpadding="2" cellspacing="0" class="dataheaderInvCtrl"
                                                        style="text-align: left; font-size: 11px;" width="100%">
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr align="left">
                                                <td colspan="4">
                                                    <table id="tblChequeDetails" border="1" cellpadding="2" cellspacing="0" class="dataheaderInvCtrl"
                                                        style="text-align: left; font-size: 11px;" width="100%">
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr align="left">
                                                <td>
                                                    <table>
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="lblTotalAmount" runat="server" Text="TotalAmount:"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblTotalAmounttext" runat="server" Text=""></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="lblDiscount" runat="server" Text="Discount Amount:"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblDiscountAmountText" runat="server" Text=""></asp:Label>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <td>
                                                    <table>
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="lblUSer" runat="server" Text="Requested By:"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblUSerName" runat="server" Text=""></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="lbluserComm" runat="server" Text="Requested Comments:"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblRequestedComments" runat="server" Text=""></asp:Label>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <br />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2">
                                                    <asp:GridView ID="gvFeeDetails" EmptyDataText="No matching records found " runat="server"
                                                        AutoGenerateColumns="False" CssClass="mytable1" Width="100%" AllowPaging="false">
                                                        <Columns>
                                                            <asp:TemplateField HeaderText="S.No">
                                                                <ItemTemplate>
                                                                    <%# Container.DataItemIndex + 1 %>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:BoundField HeaderText="Item Name" DataField="Descrip" />
                                                            <asp:BoundField HeaderText="Quantity" DataField="Quantity" />
                                                            <asp:BoundField HeaderText="Amount" DataField="Amount" />
                                                        </Columns>
                                                        <HeaderStyle CssClass="dataheader1" />
                                                    </asp:GridView>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="1" align="right">
                                                    <asp:Label ID="lblComments" runat="server" Text="Comments:"></asp:Label>
                                                </td>
                                                <td align="left">
                                                    <asp:TextBox ID="txtComments" runat="Server" TextMode="MultiLine"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <br />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="1" align="right">
                                                    <asp:Button ID="btnAmountApprovalDetailsOk" runat="server" Text="Approve" 
                                                        CssClass="btn" onclick="btnAmountApprovalDetailsOk_Click" />
                                                </td>
                                                <td colspan="1" align="left">
                                                    <asp:Button ID="btnAmountApprovalDetailsCancel" runat="server" Text="Reject" 
                                                        CssClass="btn" onclick="btnAmountApprovalDetailsCancel_Click" />
                                                    <input type="hidden" runat="server" id="hdnAmountApprovalDetailsID" value="0" />
                                                    <input type="hidden" runat="server" id="hdnApprovalType" value="" />
                                                    <input type="hidden" runat="server" id="hdnStatus" value="" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </td>
            </tr>
        </table>
        <asp:HiddenField ID="hdnMessages" runat="server" />
         <asp:HiddenField ID="hdnAprovelSatus" runat="server" />
         <uc5:Footer ID="Footer1" runat="server" />
    </div>
    </form>
</body>
</html>
