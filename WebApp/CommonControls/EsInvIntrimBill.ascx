<%@ Control Language="C#" AutoEventWireup="true" CodeFile="EsInvIntrimBill.ascx.cs" Inherits="CommonControls_EsInvIntrimBill" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc12" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <style type="text/css" media="print">
        #header, #footer
        {
            display: none;
        }
    </style>

    <script language="javascript" type="text/javascript">
        window.name = "BillWindow";
    </script>

</head>
<body>
    <form >
    <%--<asp:ScriptManager ID="ctlTaskScriptMgr" runat="server">
    </asp:ScriptManager>--%>
    <div id="divLaser" runat="server" style="padding-left: 0px; font-size: 12px;">
        <asp:Table ID="billLaser" runat="server" Width="65%">
            
            
            <asp:TableRow>
                <asp:TableCell ID="orgHeadLaser" Font-Bold="true" Font-Size="18px" ColumnSpan="2"
                    HorizontalAlign="Center" runat="server">
  
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow>
                <asp:TableCell ID="orgAddressLaser" ColumnSpan="2" Font-Size="14px" Font-Bold="false"
                    HorizontalAlign="Center" runat="server">
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow style="display:none;">
                <asp:TableCell ID="tblHeader" Font-Bold="true" Font-Size="12px" ColumnSpan="2"
                    HorizontalAlign="Center" runat="server" Text="Patient Interim Dues">
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow>
                <asp:TableCell ID="CreditOrCash" ColumnSpan="2" Font-Bold="true" HorizontalAlign="Center"
                    runat="server">
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow>
                <asp:TableCell ID="Duplicate" ColumnSpan="2" Font-Bold="false" Visible="false" HorizontalAlign="Center"
                    runat="server">
                </asp:TableCell>
            </asp:TableRow>
            
            <asp:TableRow>
                <asp:TableCell ID="billHeaderTDLaser" Style="padding-top: 0px; padding-left: 0px;"
                    runat="server" Width="40%" VerticalAlign="Top">
                    <asp:Table ID="billHeaderLaser" runat="server" Width="100%">
                        <asp:TableRow ID="trorgDLNoLaser" Style="display: block;" runat="server">
                            <asp:TableCell ID="orgDLNoLaser" Font-Bold="false" HorizontalAlign="left" runat="server">
  
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow ID="trorgTinNoLaser" Style="display: block;" runat="server">
                            <asp:TableCell ID="orgTinNoLaser" Font-Bold="false" HorizontalAlign="left" runat="server">
  
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell ID="billNoLaser" Style="padding-top: 10px;" HorizontalAlign="left"
                                runat="server">
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell ID="billDateLaser" Style="padding-top: 15px;" HorizontalAlign="left"
                                runat="server">
                            </asp:TableCell>
                        </asp:TableRow>
                    </asp:Table>
                </asp:TableCell>
                <asp:TableCell Width="40%" VerticalAlign="Top" Style="padding-top: 0px;">
                    <asp:Table ID="Table1" runat="server" Width="100%">
                        <asp:TableRow>
                            <asp:TableCell ID="patientNameLaser" Font-Bold="false" HorizontalAlign="right" runat="server">
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell ID="PatientNoLaser" Font-Bold="false" HorizontalAlign="right" runat="server">
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell ID="PatientAgeLaser" Font-Bold="false" HorizontalAlign="right" runat="server">
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell ID="drNameLaser" Font-Bold="false" runat="server" HorizontalAlign="right">
                            </asp:TableCell>
                        </asp:TableRow>
                    </asp:Table>
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow>
                <asp:TableCell ID="billDetailTDLaser" runat="server" VerticalAlign="Top" ColumnSpan="2"
                    Style="padding-left: 0px;">
                    <asp:Table ID="billDetailLaser" runat="server" BorderWidth="1" CellPadding="3" CellSpacing="0"
                        Width="100%">
                    </asp:Table>
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow>
                <asp:TableCell ID="TableCell1" runat="server" VerticalAlign="Top" ColumnSpan="2"
                    Style="padding-left: 0px;">
                    <asp:Table ID="Table2" runat="server" BorderWidth="1" CellPadding="3" CellSpacing="0"
                        Width="100%">
                    </asp:Table>
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow Style="display: none;">
                <asp:TableCell ID="amountInWordsLaser" Height="115px" VerticalAlign="Top"
                    Style="padding-right: 0px;" HorizontalAlign="right" runat="server" ColumnSpan="2">
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow>
                <asp:TableCell ID="tdSoldByLaser" Font-Bold="true" Style="padding-right: 0px; padding-left: 0px;"
                    HorizontalAlign="left" runat="server" ColumnSpan="2">
  
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow>
                <asp:TableCell ID="tdBillPolicy" Font-Bold="true" Style="padding-right: 0px; padding-left: 0px;"
                    HorizontalAlign="left" runat="server" ColumnSpan="2">
 
                </asp:TableCell>
            </asp:TableRow>
                
                
            <asp:TableRow>
                <asp:TableCell ID="tblFottor" Font-Bold="true" Style="padding-right: 0px; padding-left: 0px;"
                    HorizontalAlign="Center" runat="server" ColumnSpan="2">
                </asp:TableCell>
            </asp:TableRow>
        </asp:Table>
    </div>
    <div>
    </div>
    </form>
</body>
</html>
