<%@ Page Language="C#" AutoEventWireup="true" CodeFile="InventorySearch.aspx.cs"
    Inherits="InventoryCommon_InventorySearch" EnableEventValidation="false" meta:resourcekey="PageResource1" %>

<%@ Register Src="~/InventoryCommon/Controls/InventorySearch.ascx" TagName="InventorySearch"
    TagPrefix="uc2" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Inventory Search</title>
 
</head>
<body oncontextmenu="return true;">
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="True">
        <Services>
            <asp:ServiceReference Path="~/InventoryCommon/WebService/InventoryWebService.asmx" />
        </Services>
    </asp:ScriptManager>
   <Attune:Attuneheader ID="Attuneheader" runat="server" />
                    <div class="contentdata">                     
                        <table class="searchPanel">
                            <tr>
                                <td>
                                    <input type="hidden" id="hdnSearchParameter" runat="server" />
                                    <uc2:InventorySearch ID="uctlInventorySearch" runat="server" />
                                </td>
                            </tr>
                        </table>
                    </div>
                   
                <Attune:Attunefooter ID="Attunefooter" runat="server" />
           <asp:HiddenField ID ="hdnMessages" runat ="server" />
           <asp:HiddenField ID="hdnButtonText" runat="server" meta:resourcekey="hdnButtonText1" />
    </form>
</body>
</html>
<script language="javascript" type="text/javascript">
        //-------------Mani--------
    $(document).ready(function() {
        if ($("#Attuneheader_TopHeader1_lblvalue").text() == 'InventorySearch') {
            $("#Attuneheader_TopHeader1_lblvalue").text("Inventory Search");
        }
    });
        //----------End------------
        </script>
