<%@ Page Language="C#" AutoEventWireup="true" CodeFile="EditTPAPayment.aspx.cs" Inherits="InPatient_EditTPAPayment" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">
        function checkTotal(ID1, ID2, TPAamount) {
                //            alert('Total');
            //            alert(ID1);
            //            alert(ID2);
            // alert(document.getElementById(ID2).value);
            var tot = (Number(document.getElementById(ID2).value) + Number(TPAamount));

            if (document.getElementById(ID2).value != '') {
                if (Number(document.getElementById(ID1).innerHTML) < Number(tot)) {
                alert('Amount is greater than bill amount');
                }
            }
            else {
                alert('Provide received amount');
            }
        }

    </script>

</head>
<body id="">
    <form id="prFrm" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div id="">
      
        <div id="">
        <%--<asp:UpdatePanel  ID="pnl" runat="server"><ContentTemplate>--%>
            <asp:Panel ID="pnlAttrib" BorderWidth="1px" CssClass="dataheader2" runat="server">
                <table width="50%" border="1">
                    <tr>
                        <td colspan="2">
                            <asp:GridView ID="grdTPACollection" Width="100%" runat="server" AutoGenerateColumns="False"
                                DataKeyNames="PatientID,PatientVisitID,FinalBillID" PagerSettings-Mode="NextPrevious"
                                PageSize="1">
                                <PagerStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                <HeaderStyle CssClass="dataheader1" />
                                <PagerSettings FirstPageText="" LastPageText="" Mode="NumericFirstLast" NextPageText=""
                                    PageButtonCount="5" PreviousPageText="" />
                                <Columns>
                                    <asp:BoundField DataField="CreatedAt" HeaderText="Date" />
                                    <asp:BoundField DataField="BillAmount" HeaderText="Amount Paid" />
                                    <asp:TemplateField HeaderText="Amount to be Updated" ItemStyle-Width="15%">
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtTPAAmount"   onkeypress="return ValidateOnlyNumeric(this);"  
                                                Width="80%" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                        <ItemStyle Width="15%"></ItemStyle>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="Rs_WriteOff" Text="Write Off:" runat="server"></asp:Label></td>
                        <td>
                            <asp:TextBox ID="txtWriteOff" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="Rs_TDS" Text="TDS :" runat="server"></asp:Label></td>
                        <td>
                            <asp:TextBox ID="txtTDS" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="Rs_Status" Text="Status :" runat="server"></asp:Label>
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlStatus" runat="server">
                                <asp:ListItem Text="Pending" Value="Pending"></asp:ListItem>
                                <asp:ListItem Text="Completed" Value="Completed"></asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr><td colspan="2" align="center">
                    <table><tr>
                    <td>
                       <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn" onmouseover="this.className='btn btnhov'"
                         onmouseout="this.className='btn'" onclick="btnSave_Click" />
                    </td>
                    <td align="center">
                       <asp:Button ID="Button1" runat="server" Text="Cancel" OnClientClick="javascript:window.close ();" CssClass="btn" onmouseover="this.className='btn btnhov'"
                         onmouseout="this.className='btn'" />
                    </td>
                    </tr></table>
                    </td>
                    
                    </tr>
                </table>
            </asp:Panel>
          <%--  </ContentTemplate>
            </asp:UpdatePanel>--%>
        </div>
    </div>
    </form>
</body>
</html>
