<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Reorderlevel.aspx.cs" Inherits="StockManagement_Reorderlevel"
    meta:resourcekey="PageResource1" EnableEventValidation="false" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Src="~/InventoryCommon/Controls/ProductSearch.ascx" TagName="ProductSearch"
    TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Stock In Hand</title>
   
        <link rel="stylesheet" type="text/css" href="../PlatForm/Scripts/DataTable/css/dataTables.tableTools.css" />
        <link rel="stylesheet" type="text/css" href="../PlatForm/Scripts/DataTable/css/demo_table_jui.css" />
        <link rel="stylesheet" type="text/css" href="../PlatForm/Scripts/DataTable/css/dataTables.tableTools.css" />
    <style type="text/css">
        .bottom, .dataTables_length, .dataTables_filter
        {
            display: none !important;
        }
    </style>

    <script src="../PlatForm/Scripts/JsonScript.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">
        var OrderArray = new Array();
        function checkCodes() {
            var tbl = document.getElementById('tblResult');
            var searchText = document.getElementById('txtProductName').value.toUpperCase().trim();
            var isTrue = 1;

            for (var i = 1; i < tbl.rows.length; i++) {
                var tblRow = tbl.rows[i];
                var tblCell = tblRow.cells[1];
                var tblSpan = tblCell.innerHTML;
                if (searchText != "") {
                    if (tblSpan.toLowerCase().indexOf(searchText.toLowerCase()) == 0) {
                        tblRow.style.display = "table-row"

                    }
                    else {
                        tblRow.style.display = "none"
                    }
                }
                else {
                    tblRow.style.display = "table-row"


                }
            }
        }
        function GetReorderLevelDetails() {
            //LoadStockInHand(string productName, int OrgID, int ILocationID, int InventoryLocationID)

            var OrgID = "<%= OrgID %>";
            var OrgAddressId = "<%=ILocationID %>";
            var LocationID = "<%=InventoryLocationID %>";
            var CategoryId = 0;
            var ProductName = document.getElementById("txtProductName").value;
            var Description = '';
            var parameter = { productName: ProductName, OrgID: OrgID, ILocationID: OrgAddressId, InventoryLocationID: LocationID };
            $.ajax({
                type: "POST",
                url: "../InventoryCommon/WebService/InventoryWebService.asmx/LoadStockInHand",
                data: JSON.stringify(parameter),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: true,
                success: function Success(data) {
                    var Items = data.d;
                    var lstInventoryItemsBasket = Items;
                    if (lstInventoryItemsBasket.length > 0) {
                        if ($("#CheckBox1").prop('checked') == true) {
                            //do something
                            $("#chkSelectAll").attr('checked', false);
                            $("#btnBillShow").hide();
                            lstInventoryItemsBasket = $.grep(lstInventoryItemsBasket, function (n, i) {
                            return n.OrderedQty > 0;
                            });
                        }
                        else if ($("#chkShowAll").attr('checked')) {
                            $("#btnBillShow").show();
                            lstInventoryItemsBasket = $.grep(lstInventoryItemsBasket, function(n, i) {
                                return n.OrderedQty >= 0;
                            });
                        }
                        else {
                            $("#btnBillShow").show();
                            lstInventoryItemsBasket = $.grep(lstInventoryItemsBasket, function (n, i) {
                                return n.Description == "Y" && n.OrderedQty == 0;
                            });
                        }
                        fun_BindValues(lstInventoryItemsBasket);

                    }
                    else {
                        alert('No Records Found');

                    }
                },
                error: function(jqXHR, textStatus, errorThrown) {


                }

            });

        }

        var DTD;
        var v;
        function fun_BindValues(JST) {
            var OrgID = "<%= OrgID %>";
            var OrgAddressId = "<%=ILocationID %>";
            var LocationID = "<%=InventoryLocationID %>";
            var CategoryId = 0;
            var ProductName = document.getElementById("txtProductName").value;
            var Description = '';
            var OrderedQty = 0;
            var chkbox = document.getElementById("CheckBox1").value;

            DTD = [];

            if (JST) {
                $.each(JST, function() {


                    if (chkbox.checked == 'on' && OrderedQty > 0) {
                        var ProductName = this.ProductName;
                        var CategoryName = this.CategoryName;
                        var ReOrderLevel = this.ReOrderLevel;
                        var StockReceived = this.InHandQuantity;
                        var OrderedQty = this.OrderedQty;
                        var Description = this.Description;
                        var Des = Description;
                        var ProductId = this.ProductID;
                        var Unit = this.SellingUnit;
                        DTD.push([
         ProductName = ProductName,
         CategoryName = CategoryName,
         ReOrderLevel = ReOrderLevel,
         StockReceived = StockReceived,
         OrderedQty = OrderedQty,
         Description = Description,
         ProductId = ProductID,
         SellingUnit = Unit

               ]);
                    }
                    else {
                        var ProductName = this.ProductName;
                        var CategoryName = this.CategoryName;
                        var ReOrderLevel = this.ReOrderLevel;
                        var StockReceived = this.InHandQuantity;
                        var OrderedQty = this.OrderedQty;
                        var Description = this.Description;
                        var Des = Description;
                        var ProductID = this.ProductID;
                        var Unit = this.SellingUnit;
                        DTD.push([
         ProductName = ProductName,
         CategoryName = CategoryName,
         ReOrderLevel = ReOrderLevel,
         StockReceived = StockReceived,
         OrderedQty = OrderedQty,
         Description = Description,
         ProductId = ProductID,
         SellingUnit = Unit
          ]);
                    }
                });

                BindgvTransDetails(true);
                $('#divProgress').hide();
            }

        }

        function GoToPurchaseSupplier() {
            $('#tblResult tr').not(":first").each(function(rowIndex, r) {
                if ($(r.cells[5])[0].children[0].checked) {
                    var OrderArrayObj = new Object();
                    OrderArrayObj["ProductName"] = $(r.cells[0])[0].innerHTML;
                    OrderArrayObj["OrderedQty"] = $(r.cells[4])[0].innerHTML;
                    OrderArrayObj["ProductID"] = $(r.cells[6])[0].innerHTML;
                    OrderArrayObj["SellingUnit"] = $(r.cells[7])[0].innerHTML;
                    OrderArray.push(OrderArrayObj);
                }
            });


            return OrderArray;

        }

        function GoBillShow() {

            var str = "";
            var ProductID;
            GoToPurchaseSupplier(OrderArray);

            for (var i in OrderArray) {
                if (i == 0) {
                    str = OrderArray[i].ProductID+"~"+OrderArray[i].ProductName + "~" + OrderArray[i].SellingUnit;
                }

                else {
                    str = str + "^" + OrderArray[i].ProductID + "~" + OrderArray[i].ProductName + "~" + OrderArray[i].SellingUnit;
                }

            }
            if (str !== " ") {
                document.getElementById('hdnvalue').value = str;
            }

        }
    </script>

</head>
<body id="Body1" oncontextmenu="return false;" runat="server">
    <%-- onload="javascript:BindValues();"--%>
    <form id="prFrm" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    
      <Attune:Attuneheader ID="Attuneheader" runat="server" />
   
    <div class="contentdata">
 
        <table class="w-100p searchPanel">
            <tr>
                <td>
                    <div id="divExp" runat="server">
                        <div style="float: left;" id="divLegend">
                            <table id="tblLegend" class="w-100p">
                                <tr>
                                    <td>
                                        <asp:Label ID="lblProductName" Text="ProductName" runat="server" meta:resourcekey="lblProductNameResource1"></asp:Label>
                                        <asp:TextBox onkeyup="checkCodes()" ID="txtProductName" runat="server" Width="200px"
                                            meta:resourcekey="txtProductNameResource1"></asp:TextBox>
                                    </td>
                                    <td class="a-right">
                                        <asp:Button ID="btnSearch" runat="server" Text="Search" Style="cursor: pointer;"
                                            CssClass="btn" onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'"
                                            meta:resourcekey="btnSearchResource1" /><%--OnClick="btnSearch_Click" --%>
                                        
                                       <%-- <asp:LinkButton ID="lnkExportXL" Text="Export To XL" Font-Underline="True" runat="server"
                                            OnClientClick="javascript:return Excel();" Font-Bold="True" Font-Size="12px"
                                            ForeColor="Black" ToolTip="Save As Excel" meta:resourcekey="lnkExportXLResource1"></asp:LinkButton>--%>
                                        <asp:Button ID="btnprnt" runat="server" Text="Print" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                            onmouseout="this.className='btn'" OnClientClick="return popupprint(event);" meta:resourcekey="btnprntResource1" />
                                        <asp:LinkButton ID="lnkBack" runat="server" CssClass="btn" OnClick="lnkBack_Click"
                                            meta:resourcekey="lnkBackResource1" Text="Back&amp;nbsp;&amp;nbsp;&amp;nbsp;"></asp:LinkButton>
                                    </td>
                                    <td class="a-right">
                                        <asp:ImageButton ID="imgBtnXL" runat="server" ImageUrl="~/PlatForm/Images/ExcelImage.GIF"
                                            ToolTip="Save As Excel" OnClientClick="javascript:return Excel();" meta:resourcekey="imgBtnXLResource1" /><%--OnClick="imgBtnXL_Click"--%>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="a-right">
                                        <asp:TextBox ID="txtReachedReorder" ReadOnly="True" runat="server" Height="10px"
                                            Style="background-color: #FFA500" Width="10px" meta:resourcekey="txtReachedReorderResource1"></asp:TextBox>
                                        <asp:Label ID="lblReachedReorder" Text="Reached reorder" runat="server" meta:resourcekey="lblReachedReorderResource1"></asp:Label>
                                        <asp:TextBox ID="txtorderQty" ReadOnly="True" runat="server" Height="10px" Width="10px"
                                            Style="background-color: #cce9ef" meta:resourcekey="txtorderQtyResource1"></asp:TextBox>
                                        <asp:Label ID="lblorderQty" runat="server" meta:resourcekey="lblorderQtyResource1"></asp:Label>
                                    </td>
                                    <td align="right">
                                        <asp:CheckBox ID="chkShowAll" runat="server" Text="Show All" onclick="GetReorderLevelDetails();"
                                            meta:resourcekey="chkShowAllResource1" />
                                    </td>
                                    <td align="right">
                                        <asp:CheckBox ID="chkSelectAll" Checked="true" runat="server" Text="Select All" meta:resourcekey="chkSelectAllResource1" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">
                                    </td>
                                    <td align="right">
                                        <%--<asp:CheckBox ID="CheckBox1" AutoPostBack="True" runat="server" Text="Check to View Products Placed on Purchase Order"
                                            onclick="GetReorderLevelDetails()" meta:resourcekey="CheckBox1Resource1" />--%>
                                        <input type="checkbox" value="Check to View Products Placed on Purchase Order" id="CheckBox1" onclick="GetReorderLevelDetails()"   />
                                       <%=Resources.StockManagement_ClientDisplay.StockManagement_ReorderLevel_aspx_27%>
                                        <%-- OnCheckedChanged=" CheckBox1_CheckedChanged "--%>
                                    </td>
                                    <td></td>
                                </tr>
                            </table>
                        </div>
                        <div id="tblHostional" class="hide">
                            <table class="searchPanel w-100p">
                                <tr>
                                    <td class="a-left w-5p v-bottom">
                                        <img id="imgPath" runat="server" />
                                    </td>
                                    <td>
                                        <asp:Label ID="lblHosital" runat="server" 
                                            meta:resourcekey="lblHositalResource1" />
                                    </td>
                                </tr>
                                <tr class="panelHeader">
                                    <td class="a-center" colspan="2">
                                        <asp:Label ID="lblReport" runat="server" 
                                            meta:resourcekey="lblReportResource1" />
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div id="divPrint" runat="server" style="display: block;">
                            <table id="tblResult" class="gridView w-100p">
                                <thead>
                                    <tr class="gridHeader">
                                        <th class="a-left" scope="col">
                                            <asp:Label ID="lblProductName1" Text="Product" runat="server" meta:resourcekey="BoundFieldResource1" />
                                        </th>
                                        <th class="a-left" scope="col">
                                            <asp:Label ID="lblCategory" Text="Category" runat="server" meta:resourcekey="BoundFieldResource2" />
                                        </th>
                                        <th class="a-left" scope="col">
                                            <asp:Label ID="lblReorderLevel" Text="Reorder Level" runat="server" meta:resourcekey="BoundFieldResource3" />
                                        </th>
                                        <th class="a-left" scope="col">
                                            <asp:Label ID="lblStockInHand" Text="Stock In Hand" runat="server" meta:resourcekey="BoundFieldResource4" />
                                        </th>
                                        <th class="a-left" scope="col">
                                            <asp:Label ID="lblOrderedQty" Text="Ordered Qty" runat="server" meta:resourcekey="BoundFieldResource5" />
                                        </th>
                                        <th class="a-left" scope="col">
                                            <asp:Label ID="lblOrder1" Text="Order" runat="server" meta:resourcekey="BoundFieldResource6" />
                                        </th>
                                        <th class="a-left" scope="col" style="display: none;">
                                            <asp:Label ID="lblProductID" Text="Product ID" runat="server" meta:resourcekey="testLable" />
                                        </th>
                                        <th class="a-left" scope="col" style="display: none;">
                                            <asp:Label ID="lblUnit" Text="Units" runat="server"/>
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>
                        </div>
                </td>
            </tr>
            <tr>
                <td class="a-center">
                    <asp:Button ID="btnBillShow" Style="cursor: pointer;" runat="server" Text="Go" CssClass="btn"
                        OnClientClick="javascript:return GoBillShow();" onmouseover="this.className='btn btnhov'"
                        OnClick="btnBillShow_Click" onmouseout="this.className='btn'" meta:resourcekey="btnBillShowResource1" />
                    <asp:HiddenField ID="hdnvalue" runat="server" />
                </td>
            </tr>
        </table>
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    <asp:HiddenField ID="hdnMessages" runat="server" />
    <asp:HiddenField ID="hdngrid" runat="server" />
    <asp:HiddenField ID="hdntblResult" runat="server" />
    <input type="hidden" id="hdnProductId" value="" runat="server" />
    
    </form>

    <script type="text/javascript">
        $("#chkSelectAll").click(function () {
            $('#tblResult tbody input[type="checkbox"]').prop('checked', this.checked);
        });
        function deSelectAll() {
            var isTrue = false;
            var pSelect = document.getElementById('chkSelectAll').checked;
            for (var i = 0; i < document.forms[0].elements.length; i++) {
                element = document.forms[0].elements[i];
                if (element.type == "checkbox" && document.getElementById(element.id).id != document.getElementById('CheckBox1').id) {
                    document.getElementById(element.id).checked = pSelect;
                    isTrue = true;
                }
            }


            if (pSelect == true) {
                document.getElementById('btnBillShow').style.display = "block";
            }
            if (pSelect == false) {
                document.getElementById('btnBillShow').style.display = "none";
            }
        }

        function isChecked() {
            var isTrue = false;
            for (var i = 0; i < document.forms[0].elements.length; i++) {
                element = document.forms[0].elements[i];
                if (element.type == "checkbox" && document.getElementById(element.id).id != document.getElementById('CheckBox1').id) {
                    if (document.getElementById(element.id).checked) {
                        isTrue = true;

                    }
                }
            }
            if (isTrue == false) {
                document.getElementById('btnBillShow').style.display = "none";
                document.getElementById('chkSelectAll').checked = false;
            }
            if (isTrue == true) {
                document.getElementById('chkSelectAll').checked = true;
                document.getElementById('btnBillShow').style.display = "block";
            }
        }
        isChecked();


        function popupprint(e) {
            BindgvTransDetails(false);
            document.getElementById('tblHostional').style.display = "block";

            document.getElementById('lblReport').innerHTML = 'Reorder Level Report ';
            $('#tblResult_filter').hide();
            $('#ToolTables_tblResult_0').hide();
            $('#ToolTables_tblResult_1').hide();
            $('#ToolTables_tblResult_2').hide();
            $('#ToolTables_tblResult_3').hide();
            $('#tblResult_info').hide();
            $('#tblResult_paginate').hide();
            var PrtLog = document.getElementById('tblHostional');
            var prtContent = document.getElementById('divPrint');

            $('#ToolTables_tblResult_0').css('display', 'none');
            $('#ToolTables_tblResult_1').css('display', 'none');
            $('#tblResult_filter').css('display', 'none');
            $('#tblResult_info').css('display', 'none');
            $('#tblResult').prop('border', '1');
            $('#tblResult').prop('cellspacing', '0');
            $('#tblResult').prop('cellpading', '0');

            var WinPrint = window.open('', '', 'left=0,top=0,toolbar=0,scrollbars=0,status=0');
            //alert(WinPrint);
            WinPrint.document.write('<html><head>');
            WinPrint.document.write('<link rel="stylesheet" type="text/css" href="../PlatForm/StyleSheets/Common.css" />');
            WinPrint.document.write('<link rel="stylesheet" type="text/css" href="../PlatForm/Themes/IB/style.css" />');
            WinPrint.document.write('<style>.datatable td {color: #000 !important;}#tblResult tr > *:nth-child(6) {display: none;}</style>');
            WinPrint.document.write('</head><body>');
            WinPrint.document.write(PrtLog.innerHTML);
            WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.write('</body></html>');
            setTimeout(function() {
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
            }, 1000);
            //WinPrint.close();
            document.getElementById('tblHostional').style.display = "none";
            $('#ToolTables_tblResult_0').css('display', 'block');
            $('#ToolTables_tblResult_1').css('display', 'block');
            $('#tblResult_filter').css('display', 'block');
            $('#tblResult_info').removeAttr("style");
            $('#tblResult_filter').removeAttr("border");
            $('#tblResult').removeAttr("cellspacing");
            $('#tblResult').removeAttr("cellpading");
            $('#ToolTables_tblResult_0').removeAttr("style");
            $('#ToolTables_tblResult_1').removeAttr("style");
            $('#tblResult').removeClass().addClass('displaytb');
            BindgvTransDetails(true);
            return false;

        }
 
    </script>

</body>
</html>
<script src="../PlatForm/Scripts/DataTable/jquery.dataTables.js" type="text/javascript"></script>

<script src="../PlatForm/Scripts/DataTable/ZeroClipboard.js" type="text/javascript"></script>

<%--<script src="../PlatForm/Scripts/DataTable/jquery.js" type="text/javascript"></script>--%>

<%--<script src="../PlatForm/Scripts/DataTable/jquery.dataTables.min.js" type="text/javascript"></script>--%>

<%--<script type="text/javascript" src="../PlatForm/Scripts/jquery-ui-1.10.4.custom.min.js"></script>--%>


<script type="text/javascript" src="../PlatForm/Scripts/DataTable/TableTools.js"></script>
<script type="text/javascript" src="../PlatForm/Scripts/DataTable/TableTools.min.js"></script>

<script language="javascript" type="text/javascript">

    $(document).ready(function() { GetReorderLevelDetails(); });

    function BindgvTransDetails(lblfalg) {
        $("#tblResult > tbody > tr").remove();
        $('#tblResult').dataTable({
            "bDestroy": true,
            "bProcessing": true,
            "bPaginate": lblfalg,
            "bFooter": true,
            "bDeferRender": true,
            "bSortable": false,
            "bJQueryUI": true,
            "aaData": DTD,
            'bSort': false,
            'bFilter': true,
            'sPaginationType': 'full_numbers',
            "bDeferRender": true,
            "fnRowCallback": function(nRow, aData, iDisplayIndex) {
                if ($(nRow).find("input[type=checkbox]")[0].checked && (!$("#chkShowAll").prop('checked') == true)) {
                    $(nRow).attr('style', 'background-color: orange !important');
                }

                else if ((!$(nRow).find("input[type=checkbox]")[0].checked) && ($("#CheckBox1").prop('checked') == true)) {
                    //$(nRow).attr('style', '#tblResult tr > *:nth-child(6) {display: none;}');
                    $(nRow).find("input[type=checkbox]").hide();
                    $(nRow).css("background-color", "#cce9ef");
                }
                else {
                    if ($("#chkShowAll").prop('checked') == true) {

                        if (($(nRow).find('td:eq(4)').text() == "0") && (!$(nRow).find("input[type=checkbox]")[0].checked)) {
                            $(nRow).attr('style', 'background-color: white !important');

                        }
                        else if (($(nRow).find("input[type=checkbox]")[0].checked) && ($(nRow).find('td:eq(4)').text() == "0")) {
                            $(nRow).attr('style', 'background-color: orange !important');
                        }
                        else if (Number($(nRow).find('td:eq(4)').text() > 0)) {
                            $(nRow).css("background-color", "#cce9ef");
                        }
                        else {
                            $(nRow).css("background-color", "green");
                        }
                    }
                }

                return nRow;
            },
            "aoColumnDefs": [{ aTargets: [5],

                fnRender: function(o, v) {

                    if (o.aData[5] == "N") {

                        return '<input type="checkbox" id="chkOrder" name="Order"  style="text-align:right;" unchecked />';

                    }
                    else {

                        return '<input type="checkbox" id="chkOrder" name="Order" checked  />';

                    }
                }
            },
                          { "sClass": "a-left  hide", aTargets: [6] }, { "sClass": "a-left  hide", aTargets: [7] }
             ]


        });

    }
    function Excel() {
        BindgvTransDetails(false);
        $("#tblResult").battatech_excelexport({
            containerid: "tblResult",
            datatype: 'table',
            worksheetname: "ReorderLevelReport"
        });
        BindgvTransDetails(true);
        return false;
    }       
	$(window).on('beforeunload', function () {
		$('#preloader').hide();
	});
</script>

<script src="../PlatForm/Scripts/Battatech_excelexport/jquery.battatech.excelexport.js"
    type="text/javascript"></script>

<script src="../PlatForm/Scripts/Battatech_excelexport/jquery.battatech.excelexport.min.js"
    type="text/javascript"></script>

