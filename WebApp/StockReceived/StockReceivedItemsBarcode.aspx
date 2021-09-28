<%@ Page Language="C#" AutoEventWireup="true" CodeFile="StockReceivedItemsBarcode.aspx.cs"
    Inherits="LabConsumptionInventory_StockReceivedItemsView" meta:resourcekey="PageResource1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
      
</head>
<body oncontextmenu="return true;">
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="True">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
     <script>
         function disabledBarcodeTextBox() {

             if ($("#cheAutoBarCode").is(":checked") == true) {
                 $("[id$=txtPBarcode]").prop("disabled", true);
                 $("[id$=txtChildPBarcode]").prop("disabled", true);
                 $("#btnSave").hide();
                 $("#btnPrint").show();
             }
             else {
                 $("[id$=txtPBarcode]").prop("disabled", false);
                 $("[id$=txtChildPBarcode]").prop("disabled", false);
                 $("#btnSave").show();
                 $("#btnPrint").hide();
             }           
             return false;
         }
         function DisPlayMessage() {
             $("#divlblAlertMsg").removeClass("hide");
             $("#btnPrint").addClass("hide");             
             return false;
         }
    </script>
    
    <div class="contentdata">
        <table class="w-100p">
            <tr>
                <td class="w-100p">
                    <table class="w-50p">
                        <tr>
                            <td>
                                <asp:Label ID="lblSupplierName" Text="Supplier Name" runat="server" 
                                    meta:resourcekey="lblSupplierNameResource1"></asp:Label>
                            </td>
                            <td>
                                :
                            </td>
                            <td>
                                <asp:Label ID="lblSupplierValue" runat="server" 
                                    meta:resourcekey="lblSupplierValueResource1"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblDate" Text="Date" runat="server" 
                                    meta:resourcekey="lblDateResource1"></asp:Label>
                            </td>
                            <td>
                                :
                            </td>
                            <td>
                                <asp:Label ID="lblDateValue" runat="server" 
                                    meta:resourcekey="lblDateValueResource1"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblPoNo" Text="P.O No" runat="server" 
                                    meta:resourcekey="lblPoNoResource1"></asp:Label>
                            </td>
                            <td>
                                :
                            </td>
                            <td>
                                <asp:Label ID="lblPoNoValue" runat="server" 
                                    meta:resourcekey="lblPoNoValueResource1"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblReceivedNo" Text="Received No" runat="server" 
                                    meta:resourcekey="lblReceivedNoResource1"></asp:Label>
                            </td>
                            <td>
                                :
                            </td>
                            <td>
                                <asp:Label ID="lblSRDNoValue" runat="server" 
                                    meta:resourcekey="lblSRDNoValueResource1"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblInvoiceNo" Text="Invoice No" runat="server" 
                                    meta:resourcekey="lblInvoiceNoResource1"></asp:Label>
                            </td>
                            <td>
                                :
                            </td>
                            <td>
                                <asp:Label ID="lblInvoiceNoValue" runat="server" 
                                    meta:resourcekey="lblInvoiceNoValueResource1"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblDCNo" Text="DC No" runat="server" 
                                    meta:resourcekey="lblDCNoResource1"></asp:Label>
                            </td>
                            <td>
                                :
                            </td>
                            <td>
                                <asp:Label ID="lblDCNoValue" runat="server" 
                                    meta:resourcekey="lblDCNoValueResource1"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblStatus" Text="Status" runat="server" 
                                    meta:resourcekey="lblStatusResource1"></asp:Label>
                            </td>
                            <td>
                                :
                            </td>
                            <td>
                                <asp:Label ID="lblStatusValue" runat="server" 
                                    meta:resourcekey="lblStatusValueResource1"></asp:Label>
                            </td>
                            <td>
                                <asp:CheckBox ID="cheAutoBarCode" Text="Auto BarCode" runat="server" 
                                    meta:resourcekey="cheAutoBarCodeResource1" />
                            </td>
                            <td id="tdcheIsUniqueBarcode" runat="server" >
                                <asp:CheckBox ID="cheIsUniqueBarcode" Text="Non Unique Barcode" runat="server" 
                                    meta:resourcekey="cheIsUniqueBarcodeResource1" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:GridView ID="gvSRDBarcode" runat="server" AutoGenerateColumns="False" CssClass="gridView w-100p"
                        OnRowCommand="gvSRDBarcode_RowCommand"  
                        OnRowDataBound="gvSRDBarcode_RowDataBound" meta:resourcekey="gvSRDBarcodeResource1"
                        >
                        <Columns>
                            <asp:TemplateField HeaderText="Sno" meta:resourcekey="TemplateFieldResource1">
                                <ItemTemplate>
                                    <%# Container.DataItemIndex + 1 %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Product Name" 
                                meta:resourcekey="TemplateFieldResource2">
                                <ItemTemplate>
                                    <asp:Label ID="lblProductName" runat="server" Text='<%# Bind("ProductName") %>' 
                                        meta:resourcekey="lblProductNameResource1"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField HeaderText="BatchNo" DataField="BatchNo" 
                                meta:resourcekey="BoundFieldResource1" />
                            <asp:TemplateField HeaderText="Product Qty" 
                                meta:resourcekey="TemplateFieldResource3">
                                <ItemTemplate>
                                    <asp:Label ID="lblRECQuantity" runat="server" Text='<%# Bind("RECQuantity") %>' 
                                        meta:resourcekey="lblRECQuantityResource1"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Rec.Unit" 
                                meta:resourcekey="TemplateFieldResource4">
                                <ItemTemplate>
                                    <asp:Label ID="lblRecUnit" runat="server" Text='<%# Bind("RECUnit") %>' 
                                        meta:resourcekey="lblRecUnitResource1"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Invoice Qty" 
                                meta:resourcekey="TemplateFieldResource5">
                                <ItemTemplate>
                                    <asp:Label ID="lblInvoiceQty" runat="server" Text='<%# Bind("InvoiceQty") %>' 
                                        meta:resourcekey="lblInvoiceQtyResource1"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Received Qty" 
                                meta:resourcekey="TemplateFieldResource6">
                                <ItemTemplate>
                                    <asp:Label ID="lblReceivedQty" runat="server" Text='<%# Bind("RcvdLSUQty") %>' 
                                        meta:resourcekey="lblReceivedQtyResource1"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Compliment QTY" 
                                meta:resourcekey="TemplateFieldResource7">
                                <ItemTemplate>
                                    <asp:Label ID="lblComplimentQTY" runat="server" 
                                        Text='<%# Bind("ComplimentQTY") %>' 
                                        meta:resourcekey="lblComplimentQTYResource1"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Rec.Qty.Unit" 
                                meta:resourcekey="TemplateFieldResource8">
                                <ItemTemplate>
                                    <asp:Label ID="lblSellingUnit" runat="server" Text='<%# Bind("SellingUnit") %>' 
                                        meta:resourcekey="lblSellingUnitResource1"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Action" 
                                meta:resourcekey="TemplateFieldResource9">
                                <ItemTemplate>
                                    <asp:HiddenField ID="hdnProductId" runat="server" Value='<%# Bind("ProductId") %>' />
                                    <asp:HiddenField ID="hdnStockReceivedId" runat="server" Value='<%# Bind("StockReceivedId") %>' />
                                    <asp:HiddenField ID="hdnLocationID" runat="server" Value='<%# Bind("LocationID") %>' />
                                    <asp:HiddenField ID="hdnProductReceivedUniqueNumber" runat="server" Value='<%# Bind("ReceivedUniqueNumber") %>' />
                                    <asp:HiddenField ID="hdnIsUniqueBarcode" runat="server" Value='<%# Bind("AttributeDetail") %>' /> 
                                    <asp:HiddenField ID="hdnBarcodeStatus" runat="server" Value='<%# Bind("Status") %>' /> 
                                    
                                    <asp:LinkButton ID="lnkbtn" runat="server" Text="Genarate Barcode" CommandArgument='<%# Container.DataItemIndex %>'
                                        CommandName="BarcodeGenerate" OnClientClick="return BGconfirm();" 
                                        meta:resourcekey="lnkbtnResource1"></asp:LinkButton>
                                        
                                    <asp:LinkButton ID="lknPrintBarcode" runat="server" Text="Print Barcode" CommandArgument='<%# Container.DataItemIndex %>'
                                        CommandName="PrintBarcode" meta:resourcekey="lknPrintBarcodeResource1" ></asp:LinkButton>    
                                        
                                </ItemTemplate>
                            </asp:TemplateField>
                            
                        </Columns>
                    </asp:GridView>
                </td>
            </tr>
            <tr>
                <td class="a-center">
                    <asp:Button ID="btnBack" runat="server" CssClass="cancel-btn" Text="Back" OnClick="btnBack_Click" meta:resourcekey="btnBackResource1" />
                </td>
            </tr>
        </table>
        <asp:Button ID="btnShowPopup" runat="server" Style="display: none" meta:resourcekey="btnShowPopupResource1" />
        <ajc:ModalPopupExtender ID="MPEBarCode" runat="server" TargetControlID="btnShowPopup"
            PopupControlID="pnlpopup" CancelControlID="ImgBtnClose" BackgroundCssClass="modalBackground"
            DynamicServicePath="" Enabled="True">
        </ajc:ModalPopupExtender>
        <asp:Panel ID="pnlpopup" runat="server" CssClass="PanalHdr" Style="display: none"
            meta:resourcekey="pnlpopupResource1">
            <table class="tblHdrStyle w-100p" cellpadding="0" cellspacing="0">
                <tr>
                    <td class="tdhdrcontent">
                        <table class="w-100p">
                            <tr>
                                <td>
                                    <asp:Label ID="lblHdr" runat="server" Text="Stock BarCode Mapping" meta:resourcekey="lblHdrResource1"></asp:Label>
                                </td>
                                <td class="a-right">
                                    <asp:ImageButton ID="ImgBtnClose" runat="server" ImageUrl="~/PlatForm/Images/dialog_close_button.png"
                                        ToolTip="Close" Height="25px" meta:resourcekey="ImgBtnCloseResource1" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td class="h-30">
                        <table class="w-100p h-30">
                            <tr>
                                <td>
                                     <div id="divlblAlertMsg" class="w-80p h-50 v-middle lh50 alert-danger hide">
                                        <span class="invalid-msg"></span>
                                        <asp:Label ID="lblAlertMsg" CssClass="marginL20  w-80p" runat="server" meta:resourcekey="lblAlertMsgResource1"></asp:Label>
                                    </div>
                                </td>
                                <td class="a-right">
                                    <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn" OnClientClick="return ReadParentAndChildBarcode();" OnClick="btnSave_Click" meta:resourcekey="btnSaveResource1" />
                               
                                    <asp:Button ID="btnPrint" runat="server" Text="View Print" CssClass="btn"  OnClick="btnPrint_Click"
                                        meta:resourcekey="btnPrintResource1" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
              
                <tr>
                    <td class="v-top">
                       
                        <div class="w-100p h-450 o-auto" id="ex2">
                            <asp:GridView ID="gvBarcodeDetails" runat="server" AutoGenerateColumns="False" CssClass="gridView w-100p"
                                OnRowDataBound="gvBarcodeDetails_RowDataBound" meta:resourcekey="gvBarcodeDetailsResource1">
                                <Columns>
                                    <asp:TemplateField meta:resourcekey="TemplateFieldResource3">
                                        <ItemTemplate>
                                            <a href="JavaScript:divexpandcollapse('div<%# Eval("StockReceivedBarcodeID") %>');">
                                                <img id="imgdiv<%# Eval("StockReceivedBarcodeID") %>" width="9px" border="1" src="../PlatForm/Images/plus.png"
                                                    alt="" /></a>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Sno" meta:resourcekey="TemplateFieldResource1">
                                        <ItemTemplate>
                                            <asp:Label ID="gvBD_Sno" runat="server" Text='<%# Container.DataItemIndex + 1 %>'
                                                meta:resourcekey="gvBD_SnoResource1"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="ProductName" HeaderText="Product Name" meta:resourcekey="TemplateFieldResource2" />
                                    <asp:TemplateField HeaderText="Rec.Unit" meta:resourcekey="TemplateFieldResource4">
                                        <ItemTemplate>
                                            <asp:Label ID="gvBD_lblRUnit" runat="server" Text='<%# Bind("RecUnit") %>' meta:resourcekey="gvBD_lblRUnitResource1"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    
                                    <asp:TemplateField HeaderText="Barcode" meta:resourcekey="TemplateFieldResource11">
                                        <ItemTemplate>
                                            <asp:TextBox ID="gvBD_txtPBarcode" runat="server" Text='<%# Bind("ParentBarCode") %>'
                                                meta:resourcekey="gvBD_txtPBarcodeResource1"></asp:TextBox>
                                            <asp:HiddenField ID="gvBD_hdnProductID" runat="server" Value='<%# Bind("ProductID") %>' />
                                            <asp:HiddenField ID="gvBD_StockReceivedBarcodeID" runat="server" Value='<%# Bind("StockReceivedBarcodeID") %>' />
                                            <asp:HiddenField ID="gvBD_ReceivedUniqueNumber" runat="server" Value='<%# Bind("ReceivedUniqueNumber") %>' />
                                            <asp:HiddenField ID="gvBD_hdnStatus" runat="server" Value='<%# Bind("Status") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    
                                    
                                    <asp:TemplateField  meta:resourcekey="TemplateFieldResource10">
                                        <ItemTemplate>
                                            <tr id="innerGv">
                                                <td colspan="100%">
                                                    <div id="div<%# Eval("StockReceivedBarcodeID") %>" style="overflow: auto; display: none;
                                                        position: relative; left: 15px; overflow: auto">
                                                        <asp:GridView ID="gvBD_gvChildBarcode" runat="server" AutoGenerateColumns="False"
                                                            CssClass="gridView w-90p" meta:resourcekey="gvBD_gvChildBarcodeResource1">
                                                            <Columns>
                                                                <asp:TemplateField HeaderText="Sno" meta:resourcekey="TemplateFieldResource1">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="gvCB_Sno" runat="server" Text='<%# Container.DataItemIndex + 1 %>'
                                                                            meta:resourcekey="gvCB_SnoResource1"></asp:Label>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:BoundField DataField="ProductName" HeaderText="Product Name" meta:resourcekey="TemplateFieldResource2" />
                                                                <asp:TemplateField HeaderText="Rec.Unit" meta:resourcekey="TemplateFieldResource4">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="gvCB_lblChildRUnit" runat="server" Text='<%# Bind("SellingUnit") %>'
                                                                            meta:resourcekey="gvCB_lblChildRUnitResource1"></asp:Label>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Barcode" meta:resourcekey="TemplateFieldResource11">
                                                                    <ItemTemplate>
                                                                        <asp:TextBox ID="gvCB_txtChildPBarcode" runat="server" Text='<%# Bind("BarcodeNo") %>'
                                                                            meta:resourcekey="gvCB_txtChildPBarcodeResource1"></asp:TextBox>
                                                                        <asp:HiddenField ID="gvCB_hdnStockReceivedBarcodeDetailsID" runat="server" Value='<%# Bind("StockReceivedBarcodeDetailsID") %>' />
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                            </Columns>
                                                        </asp:GridView>
                                                    </div>
                                                </td>
                                            </tr>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </div>
                    </td>
                </tr>
            </table>
        </asp:Panel>
        <asp:HiddenField ID="hdnPrintUrl" runat="server" />
        <asp:HiddenField ID="hdnBarcodeList" runat="server" />
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
  
    </form>
    
    <style type="text/css">
        .tdhdrcontent
        {
            height: 4%;
            font-weight: bold;
            font-size: medium;
            background-color: #E5E4E2;
        }
        .tblHdrStyle
        {
            width: 100%;
            border: Solid 3px E5E4E2;
            height: 100%;
        }
        .PanalHdr
        {
            background-color: white;
            top: 50px !important;
            height: 450px;
            width: 90%;
        }
        .modalBackground
        {
            background-color: Gray;
            filter: alpha(opacity=80);
            opacity: 0.8;
            z-index: 10000;
        }
        .scrollbar
        {
            width: 97%;
            height: 510px;
            background-color: white;
            margin-top: 40px;
            margin-left: 40px;
            overflow-y: scroll;
            float: left;
        }
        .content
        {
            height: 600px;
        }
        /*example2 scrollbar#ex2::-webkit-scrollbar
        {
            width: 16px;
            background-color: #cccccc;
        }
        #ex2::-webkit-scrollbar-thumb
        {
            background-color: #333333;
            border-radius: 10px;
        }
        #ex2::-webkit-scrollbar-thumb:hover
        {
            background-color: #666666;
            border: 1px solid #333333;
        }
        #ex2::-webkit-scrollbar-track
        {
            border: 1px gray solid;
            border-radius: 10px;
            -webkit-box-shadow: 0 0 6px gray inset;
        }*/
    </style>
    
 
    <script type="text/javascript">


        function BGconfirm() {
            var x;
            if (confirm("Please confirm  , Genarate the barcode!") == true) {
                return true;
            } else {
                return false;
            }

        }
        function divexpandcollapse(divname) {
            var div = document.getElementById(divname);
            var img = document.getElementById('img' + divname);
            if (div.style.display == "none") {
                div.style.display = "inline";
                img.src = "../PlatForm/Images/minus.png";

            } else {
                div.style.display = "none";
                img.src = "../PlatForm/Images/plus.png";
            }
        }

        function ReadParentAndChildBarcode() {

            var lstInvBarcode = []; var checkBoolean = "Y";
            var P_lblRUnit, P_txtPBarcode, P_txtPBarcodeId, P_ProductID, P_StockReceivedBarcodeID, P_Status, gvChildGridID, P_sno;
            var A_ProductID, A_StockReceivedBarcodeID, A_Sno, A_Status, A_ReceivedUniqueNumber, A_lblRUnit;
            var cheIsUniqueBarcode = $("#cheIsUniqueBarcode").is(":checked") == true ? "Y" : "N";


            $("#lblAlertMsg").text('');

            $('[id$="gvBarcodeDetails"] tbody tr').each(function(i, n) {
                var currentRow = $(n);

                if (i > 0 && checkBoolean == "Y") {

                    //if (i % 2 != 0) {

                    P_lblRUnit = $.trim(currentRow.find("span[id$='gvBD_lblRUnit']").text());
                    P_txtPBarcode = $.trim(currentRow.find("input[id$='gvBD_txtPBarcode']").val());
                    P_txtPBarcodeId = $.trim(currentRow.find("input[id$='gvBD_txtPBarcode']").attr('id'));
                    P_ProductID = $.trim(currentRow.find("input[id$='gvBD_hdnProductID']").val());
                    P_StockReceivedBarcodeID = $.trim(currentRow.find("input[id$='gvBD_StockReceivedBarcodeID']").val());
                    // P_StockReceivedBarcodeDetailsID = $.trim(currentRow.find("input[id$='gvBD_StockReceivedBarcodeDetailsID']").val());
                    P_ReceivedUniqueNumber = $.trim(currentRow.find("input[id$='gvBD_ReceivedUniqueNumber']").val());

                    P_Status = $.trim(currentRow.find("input[id$='gvBD_hdnStatus']").val());
                    P_sno = $.trim(currentRow.find("span[id$='gvBD_Sno']").text());


                    if (P_ProductID != "") {

                        A_Sno = P_sno; A_StockReceivedBarcodeID = P_StockReceivedBarcodeID; A_ProductID = P_ProductID; A_Status = P_Status;
                        A_ReceivedUniqueNumber = P_ReceivedUniqueNumber; A_lblRUnit = P_lblRUnit;
                        if (P_txtPBarcode == "") {

                            lstInvBarcode = [];
                            $("#lblAlertMsg").text("Please check ( Row No  : " + A_Sno + " ), Parent barcode is empty !..");
                            checkBoolean = "N";
                            $("#" + P_txtPBarcodeId).focus();
                            return false;

                        } else {


                            for (var r = 0; r < lstInvBarcode.length; r++) {

                                if (lstInvBarcode[r].ParentBarCode == P_txtPBarcode || lstInvBarcode[r].ChildBarCode == P_txtPBarcode) {
                                    lstInvBarcode = [];
                                    $("#lblAlertMsg").text("Please check ( Row No  : " + A_Sno + " ), Parent barcode already exists !..");
                                    checkBoolean = "N";
                                    $("#" + P_txtPBarcodeId).focus();
                                    return false;
                                }

                            }


                            lstInvBarcode.push({
                                StockReceivedBarcodeDetailsID: 0,
                                StockReceivedBarcodeID: A_StockReceivedBarcodeID,
                                ReceivedUniqueNumber: P_ReceivedUniqueNumber,
                                ProductID: P_ProductID,
                                ParentBarCode: P_txtPBarcode,
                                BarcodeNo: "",
                                Status: P_Status,
                                RecUnit: A_lblRUnit,
                                SellingUnit: "",
                                IsUniqueBarcode: cheIsUniqueBarcode,
                                ActionType: "PB"
                            });
                        }


                    }

                    if ($("#cheIsUniqueBarcode").is(":checked") == true) {
                        //Read child Grid
                        gvChildGridID = currentRow.closest('tr').find("[id$='gvBD_gvChildBarcode']").attr('id');
                        if (gvChildGridID != undefined) {

                            $('[id$="' + gvChildGridID + '"] tbody tr').each(function(j, k) {

                                var gvChildcurrentRow = $(k);

                                if (j > 0) {

                                    var C_txtChildPBarcode = $.trim(gvChildcurrentRow.find("input[id$='gvCB_txtChildPBarcode']").val());
                                    var C_txtChildPBarcodeID = $.trim(gvChildcurrentRow.find("input[id$='gvCB_txtChildPBarcode']").attr('id'));
                                    var C_lblChildRUnit = $.trim(gvChildcurrentRow.find("span[id$='gvCB_lblChildRUnit']").text());
                                    var C_StockReceivedBarcodeDetailsID = $.trim(gvChildcurrentRow.find("input[id$='gvCB_hdnStockReceivedBarcodeDetailsID']").val());
                                    var C_sno = $.trim(gvChildcurrentRow.find("span[id$='gvCB_Sno']").text());

                                    if (C_txtChildPBarcode == "") {

                                        lstInvBarcode = [];
                                        $("#lblAlertMsg").text("Please check ( Parent Row No  : " + A_Sno + "  ,  chile Row No  : " + C_sno + " ), child barcode is empty !..");
                                        checkBoolean = "N";
                                        $("#" + C_txtChildPBarcodeID).focus();
                                        return false;

                                    } else {

                                        for (var f = 0; f < lstInvBarcode.length; f++) {

                                            if (lstInvBarcode[f].ParentBarCode == C_txtChildPBarcode || lstInvBarcode[f].BarcodeNo == C_txtChildPBarcode) {
                                                lstInvBarcode = [];
                                                $("#lblAlertMsg").text("Please check ( Parent Row No  : " + A_Sno + "  ,  chile Row No  : " + C_sno + " ), child barcode is already exists !..");
                                                checkBoolean = "N";
                                                $("#" + C_txtChildPBarcodeID).focus();
                                                return false;
                                            }

                                        }


                                        lstInvBarcode.push({
                                            StockReceivedBarcodeDetailsID: C_StockReceivedBarcodeDetailsID,
                                            StockReceivedBarcodeID: A_StockReceivedBarcodeID,
                                            ReceivedUniqueNumber: A_ReceivedUniqueNumber,
                                            ProductID: A_ProductID,
                                            ParentBarCode: P_txtPBarcode,
                                            BarcodeNo: C_txtChildPBarcode,
                                            Status: A_Status,
                                            RecUnit: P_lblRUnit,
                                            SellingUnit: C_lblChildRUnit,
                                            IsUniqueBarcode: cheIsUniqueBarcode,
                                            ActionType: "CB"
                                        });


                                    }

                                }

                            });

                        }
                    }

                    //Read child Grid END



                }
            });

            if (checkBoolean == "N") {
                $("#divlblAlertMsg").removeClass("hide");
                return false;
            }

            if (lstInvBarcode.length > 0) {
                $("#hdnBarcodeList").val(JSON.stringify(lstInvBarcode));
            }


            //            alert(JSON.stringify(lstInvBarcode));
            //            return false;
        }
//        $(document).ready(function() {
//            
//        });
    </script>

    <%-- <script type="text/javascript">
    
    //        function HideChildGrid() {
//        
//            $("[id$=innerGv]").hide(); 
//            return false;
//        }

        function PrintBarCode() {
            window.open($("#hdnPrintUrl").val());
            // WinPrint.print();
            //WinPrint.close();
            return false;
        }



    </script>--%>
</body>
</html>
