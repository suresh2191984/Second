<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ViewPurchaseOrderMedal.aspx.cs"
    EnableEventValidation="false" Inherits="StockManagement_ViewPurchaseOrderMedal" meta:resourcekey="PageResource1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Src="~/StockManagement/Controls/ViewMultiplePurchaseOrder.ascx" TagName="ViewMultiplePurchase"
    TagPrefix="VMP" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Purchase Order</title>

</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
    <div id="TabsMenu" class="TabsMenu">
        <div id="ViewOrderMenu">
            <ul id="UIOrderMenu">
                
            </ul>
        </div>
    </div>
         <div id="ViewOrder" runat="server">
             
            
        </div>
        <asp:HiddenField runat="server" ID="hdnPOIDS" Value=" 1" />
    <asp:HiddenField ID="hdnButtonText" runat="server" meta:resourcekey="hdnButtonText1" />
        <Attune:Attunefooter ID="Attunefooter" runat="server" />
    </div>
    </form>


<script language="javascript" type="text/javascript">
    loadMenu();
    hideAll();   
    $('[id*=DivPurchaseOrder]').eq(0).show();
    function hideAll() {
        $('[id*=DivPurchaseOrder]').hide();
       
    }
    function loadMenu() {
        arrayPOIDS = $("#hdnPOIDS").val().split('~');
        var arrayCount = arrayPOIDS.length;
        var liItems = "";
        for (i = 1; i < arrayCount; i++) {

            //liItems = liItems + "<li onclick='showOrder(this);'><a href='#'><span id='Label7'>" + arrayPOIDS[i] + "</span></a></li>";
            liItems = liItems + "<li onclick='showOrder(this);'><a href='#'><span id='Label7'>" + arrayPOIDS[i] + "</span></a></li>";

        }
        $("#UIOrderMenu").append(liItems)


    }
    function showOrder(obj) {


        hideAll();
        var PurchaseOrderNo= $(obj).text();
        $('[id*=DivPurchaseOrder'+PurchaseOrderNo+']').show();
        
    }
    function popupprint() {
        var prtContent = $("#ViewOrder").html();
        var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,status=0');
        WinPrint.document.write(prtContent);
        WinPrint.document.close();
        WinPrint.focus();
        WinPrint.print();
        WinPrint.close();
        return false;
    }

</script>

</body>
</html>