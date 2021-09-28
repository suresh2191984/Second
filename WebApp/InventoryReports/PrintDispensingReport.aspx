7<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PrintDispensingReport.aspx.cs"
    Inherits="InventoryReports_PrintDispensingReport" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Dispensing Records</title>
</head>
<body id="oneColLayout">
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ctlTaskScriptMgr" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div id="div1" class="contentdata">
        <td class="style2" style="display: none">
            <asp:RadioButtonList ID="rblVisitType" RepeatDirection="Horizontal" runat="server"
                meta:resourcekey="rblVisitTypeResource1">
            </asp:RadioButtonList>
        </td>
        <asp:Table ID="DispensingRecords" runat="server" Width="100%" meta:resourcekey="DispensingRecordsResource1">
            <asp:TableRow meta:resourcekey="TableRowResource3">
                <asp:TableCell ID="cHeaderOrgAddress" Font-Bold="true" runat="server" meta:resourcekey="cHeaderOrgAddressResource1">
                    <asp:Table ID="tHeaderOrgAddress" runat="server" Width="50%" meta:resourcekey="tHeaderOrgAddressResource1">
                        <asp:TableRow meta:resourcekey="TableRowResource1">
                            <asp:TableCell ID="orgName" Font-Bold="true" Font-Size="14px" runat="server" meta:resourcekey="orgNameResource1">
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow meta:resourcekey="TableRowResource2">
                            <asp:TableCell ID="orgAddress" Font-Bold="true" runat="server" meta:resourcekey="orgAddressResource1">
                            </asp:TableCell>
                        </asp:TableRow>
                    </asp:Table>
                </asp:TableCell>
                <asp:TableCell ID="cHeaderDispensingRecords" Font-Bold="true" Font-Size="16px" HorizontalAlign="Right"
                    runat="server" meta:resourcekey="cHeaderDispensingRecordsResource1">
  
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow meta:resourcekey="TableRowResource4">
                <asp:TableCell ColumnSpan="2" meta:resourcekey="TableCellResource1">
            <hr  />
           
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow meta:resourcekey="TableRowResource5">
                <asp:TableCell ID="fromToDispensingRecords" Font-Bold="true" runat="server" ColumnSpan="2"
                    meta:resourcekey="fromToDispensingRecordsResource1">
                    
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow meta:resourcekey="TableRowResource6">
                <asp:TableCell ColumnSpan="2" meta:resourcekey="TableCellResource2">
            <hr  />
           
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow meta:resourcekey="TableRowResource7">
                <asp:TableCell ID="cColumns" runat="server" Width="100%" ColumnSpan="2" meta:resourcekey="cColumnsResource1">
                    <asp:Table ID="DataHeaders" runat="server" Width="100%" meta:resourcekey="DataHeadersResource1">
                    </asp:Table>
                </asp:TableCell>
            </asp:TableRow>
        </asp:Table>
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    <asp:HiddenField ID="hdnMessages" runat="server" />
    </form>
</body>
</html>

<script language="javascript" type="text/javascript">
    window.print();
</script>

