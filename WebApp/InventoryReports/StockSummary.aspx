<%@ Page Language="C#" AutoEventWireup="true" CodeFile="StockSummary.aspx.cs" Inherits="InventoryReports_StockSummary"
    meta:resourcekey="PageResource1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>StockSummary</title>

  
</head>
<body oncontextmenu="return false;" runat="server">
    <form id="prFrm" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
        <table border="0" cellpadding="2" cellspacing="1">
            <tr>
                <td>
                    <table>
                        <tr>
                            <td>
                                <asp:Label ID="lblLocationName" runat="server" Text="LocationName" meta:resourcekey="lblLocationNameResource1"></asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlLocation" runat="server" CssClass="ddl" meta:resourcekey="ddlLocationResource1">
                                </asp:DropDownList>
                            </td>
                            <td>
                                <asp:Label ID="lblDate" runat="server" Text="Date" meta:resourcekey="lblDateResource1"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtDate" runat="server" Width="130px" CssClass="small datePicker"
                                    onkeypress="return ValidateSpecialAndNumeric(this);" Style="text-align: justify"
                                    meta:resourcekey="txtDateResource1" />
                            </td>
                            <td>
                                <asp:Button ID="btnSearch" ToolTip="Search" runat="server" Text="Search" CssClass="btn"
                                    OnClick="btnSearch_Click" meta:resourcekey="btnSearchResource1" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td class="dataheader2">
                    <div id="divPrintarea">
                        <table id="tblGrid">
                            <tr>
                                <td>
                                    <asp:Label ID="lblOPENINGSTOCKVALUE" runat="server" Text="OPENINGSTOCKVALUE" meta:resourcekey="lblOPENINGSTOCKVALUEResource1"></asp:Label>
                                </td>
                                <td>
                                </td>
                                ?
                                <td>
                                </td>
                                <td>
                                    <asp:Label ID="lblOSV" runat="server" meta:resourcekey="lblOSVResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblADD" runat="server" Text="ADD" meta:resourcekey="lblADDResource1"></asp:Label>
                                </td>
                                <td>
                                </td>
                                <td>
                                </td>
                                <td>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblPURCHASEDURINGTHEDAY" runat="server" Text="PURCHASEDURINGTHEDAY"
                                        meta:resourcekey="lblPURCHASEDURINGTHEDAYResource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="lblpurchaseduring" runat="server" meta:resourcekey="lblpurchaseduringResource1"></asp:Label>
                                </td>
                                <td>
                                </td>
                                <td>
                                </td>
                            </tr>
                            <tr>
                                <td id="tdrecd" runat="server" style="display: none;">
                                    <asp:Label ID="lblRECEIVEDFROM" runat="server" Text="RECEIVEDFROM" meta:resourcekey="lblRECEIVEDFROMResource1"></asp:Label>
                                    <asp:Label ID="lblLocation" runat="server" meta:resourcekey="lblLocationResource1"></asp:Label>
                                </td>
                                <td id="tdrecdvalue" runat="server" style="display: none;">
                                    <asp:Label ID="lblRecdValue" runat="server" meta:resourcekey="lblRecdValueResource1"></asp:Label>
                                </td>
                                <td>
                                </td>
                                <td>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                </td>
                                <td>
                                </td>
                                <td>
                                </td>
                                <td>
                                    <asp:Label ID="lblSubTotal1" runat="server" meta:resourcekey="lblSubTotal1Resource1"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                </td>
                                <td>
                                    <asp:Label ID="lblTOTAL" runat="server" Text="TOTAL" meta:resourcekey="lblTOTALResource1"></asp:Label>
                                </td>
                                <td>
                                </td>
                                <td>
                                    <asp:Label ID="lblgrandTotal" runat="server" meta:resourcekey="lblgrandTotalResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblLESS" runat="server" Text="LESS" meta:resourcekey="lblLESSResource1"></asp:Label>
                                </td>
                                <td>
                                </td>
                                <td>
                                </td>
                                <td>
                                </td>
                            </tr>
                            <tr>
                                <td id="tdiss" runat="server" style="display: none;">
                                    <asp:Label ID="lblISSUEDTO" runat="server" Text="ISSUEDTO" meta:resourcekey="lblISSUEDTOResource1"></asp:Label>
                                    <asp:Label ID="lblToLocation" runat="server" meta:resourcekey="lblToLocationResource1"></asp:Label>
                                </td>
                                <td id="tdtoiss" runat="server" style="display: none;">
                                    <asp:Label ID="lblTolacationAmounr" runat="server" meta:resourcekey="lblTolacationAmounrResource1"></asp:Label>
                                </td>
                                <td>
                                </td>
                                <td>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblDAMAGESOTHERS" runat="server" Text="DAMAGESOTHERS" meta:resourcekey="lblDAMAGESOTHERSResource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="lblothers" runat="server" meta:resourcekey="lblothersResource1"></asp:Label>
                                </td>
                                <td>
                                </td>
                                <td>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblSALESFROTHEDAY" runat="server" Text="SALESFROTHEDAY" meta:resourcekey="lblSALESFROTHEDAYResource1"></asp:Label>
                                </td>
                                <td>
                                    <td>
                                    </td>
                                </td>
                                <td>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:GridView ID="gvUsers" runat="server" meta:resourcekey="gvUsersResource1">
                                        <Columns>
                                            <asp:BoundField HeaderText="Name" DataField="Name" meta:resourcekey="BoundFieldResource1" />
                                            <asp:BoundField HeaderText="Amount" DataField="StockValue" meta:resourcekey="BoundFieldResource2" />
                                        </Columns>
                                    </asp:GridView>
                                </td>
                                <td>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                </td>
                                <td>
                                </td>
                                <td>
                                </td>
                                <td>
                                    <asp:Label ID="lblSubToatl2" runat="server" meta:resourcekey="lblSubToatl2Resource1"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblCLOSINGSTOCKVALUE" runat="server" Text="CLOSINGSTOCKVALUE" meta:resourcekey="lblCLOSINGSTOCKVALUEResource1"></asp:Label>
                                </td>
                                <td>
                                </td>
                                <td>
                                </td>
                                <td>
                                    <asp:Label ID="lblClosingValues" runat="server" meta:resourcekey="lblClosingValuesResource1"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
            <tr align="center">
                <td>
                    <asp:Button ID="btnHome" Text="Home" Width="5%" runat="server" CssClass="btn" onmouseover="this.className='btn btnhov'"
                        onmouseout="this.className='btn'" OnClick="btnHome_Click" meta:resourcekey="btnHomeResource1" />
                </td>
            </tr>
        </table>
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    <asp:HiddenField ID="hdnMessages" runat="server" />
    <asp:HiddenField ID="hdnButtonText" runat="server" meta:resourcekey="hdnButtonText1" />
    </form>
</body>
</html>
