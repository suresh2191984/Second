<%@ Page Language="C#" AutoEventWireup="true" CodeFile="StockConsumption.aspx.cs"
    Inherits="LabConsumptionInventory_StockConsumption" meta:resourcekey="PageResource1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="True">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div>
        <div id="pendingProgress" style="display: none;">
            <div id="progressBackgroundFilter" class="a-center">
            </div>
            <div id="processMessage" class="a-center w-20p">
                <asp:Image ID="imgProgressbar" runat="server" ImageUrl="../PlatForm/Images/loaderNew.GIF"
                    meta:resourcekey="imgProgressbarResource1" />
            </div>
        </div>
        <table align="center" class="w-100p h-50">
            <tr>
                <td>
                    <asp:Label ID="lblproductname" Text="Product Name" runat="server" meta:resourcekey="lblproductnameResource1"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtProductName" runat="server" MaxLength="255" onchange="ProductOnchange()"
                        onkeypress="Productkeypress()" CssClass="medium AutoCompletesearchBox" meta:resourcekey="txtProductNameResource1"></asp:TextBox>
                </td>
                <td align="left">
                    <asp:Label ID="Labelfrmdt" runat="server" Text="From Date" meta:resourcekey="LabelfrmdtResource1"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtFrom" runat="server" CssClass="small datePickerPres" Width="130px"
                        onkeypress="return ValidateSpecialAndNumeric(this);" TabIndex="1" meta:resourcekey="txtFromResource1" />
                </td>
                <td align="left">
                    <asp:Label ID="LabelTodt" runat="server" Text="To Date " meta:resourcekey="LabelTodtResource1"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtTo" runat="server" CssClass="small datePickerPres" Width="130px"
                        onkeypress="return ValidateSpecialAndNumeric(this);" TabIndex="2" meta:resourcekey="txtToResource1" />
                </td>
                <td>
                    <asp:Button ID="btnsearch" runat="server" Text="Search" CssClass="btn" OnClientClick="javascript:return GetData();"
                        meta:resourcekey="btnsearchResource1" />
                </td>
            </tr>
        </table>
        <br />
        <br />
        <div id="Divshow" runat="server" class="w-100p">
            <table id="StockConsumption" class="responstable w-100p" style="display: none;">
                <thead>
                    <tr>
                        <th class="a-left">
                            <asp:Label ID="lblSNO" runat="server" Text="S.No" meta:resourcekey="lblSNOResource1" />
                        </th>
                        <th>
                            <asp:Label ID="lblDate" runat="server" Text="Date" meta:resourcekey="lblDateResource1" />
                        </th>
                        <th>
                            <asp:Label ID="lblProduct" runat="server" Text="Product Name" meta:resourcekey="lblProductResource1" />
                        </th>
                        <th>
                            <asp:Label ID="lblOpenStock" runat="server" Text="Open Stock" meta:resourcekey="lblOpenStockResource1" />
                        </th>
                        <th>
                            <asp:Label ID="lblClosingStock" runat="server" Text="Closing Stock" meta:resourcekey="lblClosingStockResource1" />
                        </th>
                    </tr>
                </thead>
            </table>
        </div>
        <asp:HiddenField ID="hdnProductID" runat="server" />
        <asp:HiddenField ID="hdnOrgid" runat="server" />
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    </form>

   <style> 
          #StockConsumption_info{display:none;}
   </style>
    <script src="../PlatForm/Scripts/DataTable/jquery.dataTables.js" type="text/javascript"></script>
    <script src="../PlatForm/Scripts/DataTable/TableTools.min.js" type="text/javascript"></script>
    <script src="../PlatForm/Scripts/DataTable/ZeroClipboard.js" type="text/javascript"></script>
    
    <link href="../PlatForm/Scripts/DataTable/css/dataTables.tableTools.css" rel="stylesheet"   type="text/css" />
    <link href="../PlatForm/StyleSheets/DataTable/jquery.dataTables.css" rel="stylesheet"  type="text/css" />
    <link href="../PlatForm/StyleSheets/DataTable/demo_table_jui.css" rel="stylesheet"   type="text/css" />

    <script language="javascript" type="text/javascript">

        $(document).ready(function() {
          
            $("#txtProductName").autocomplete({
                minLength: 2,
                open: function() { $($('.ui-autocomplete')).css('width', '300px'); },
                source: function(request, response) {
                    var param = { prefixText: $('#txtProductName').val(), strOrgID: $("#hdnOrgid").val() };

                    $.ajax({
                        url: "../LabConsumptionInventory/WebServices/LabConsumptionInventory.asmx/GetProductList",
                        data: JSON.stringify(param),
                        dataType: "json",
                        type: "POST",
                        contentType: "application/json; charset=utf-8",

                        success: function(data) {

                            response($.map(data.d, function(item) {
                                return {
                                    label: item.split('^')[0],
                                    value: item.split('^')[0],
                                    pValue: item.split('^')[1]

                                }
                            }))
                        },
                        error: function(XMLHttpRequest, textStatus, errorThrown) {
                            var err = eval("(" + XMLHttpRequest.responseText + ")");
                            //alert(err.Message)
                            // console.log("Ajax Error!");  
                        }
                    });
                },
                select: function(e, i) {
                    $("#txtProductName").val(i.item.label);
                    $("#hdnProductID").val(i.item.pValue);
                    return false;
                }

            });

        });
     
    </script>

    <script language="javascript" type="text/javascript">
        function GetData() {
            try {

                var pop = $("#mdlPopup");
                $("#pendingProgress").show();
                pop.show();
                if (document.getElementById('txtFrom').value == '') {
                    alert('Select From Date');
                    return false;
                }
                if (document.getElementById('txtTo').value == '') {
                    alert('select To Date');
                    return false;
                }

                var frm = document.getElementById('txtFrom').value;
                var to = document.getElementById('txtTo').value;
                var today = "";
                var today1 = "";
                if (frm.indexOf('-') > 0) {
                    today = document.getElementById('txtFrom').value.split(' ')[0].split('-');
                }
                else {
                    today = document.getElementById('txtFrom').value.split(' ')[0].split('/');
                }


                var dd = today[0];
                var mm = today[1];
                var yyyy = today[2];
                var pFromDate = mm + '/' + dd + '/' + yyyy; //+ ' ' + ftime;
                if (to.indexOf('-') > 0) {
                    today1 = document.getElementById('txtTo').value.split(' ')[0].split('-');
                }
                else {
                    today1 = document.getElementById('txtTo').value.split(' ')[0].split('/');
                }


                var dd1 = today1[0];
                var mm1 = today1[1];
                var yyyy1 = today1[2];
                var pToDate = mm1 + '/' + dd1 + '/' + yyyy1; //+ ' ' + ttime;


                $.ajax({
                    type: "POST",
                    url: "../LabConsumptionInventory/StockConsumption.aspx/GetStockConsumption",
                    contentType: "application/json;charset=utf-8",

                    data: "{'ProductID':'" + $("#hdnProductID").val() + "','fromdate':'" + pFromDate + "','todate':'" + pToDate + "'}",
                    dataType: "json",
                    // async: true,
                    success: AjaxGetFieldData,
                    error: function(xhr, ajaxOptions, thrownError) {
                        alert("Error");
                        $('#StockConsumption').hide();
                        pop.hide();
                        return false;
                    }
                });
                pop.hide();
                $('#StockConsumption').show();

            }
            catch (e) {
                pop.hide();
            }
            return false;
        }

        function AjaxGetFieldData(result) {
            try {

                var pop = $("#mdlPopup");           
                var DTD = [];
                if (result != "[]") {

                    $.each(result.d, function() {
                        var SerialNumber = this.SerialNumber;

                        DTD.push([
										 SerialNumber = this.SerialNumber,
										 DateRange = this.DateRange,
										 ProductName = this.ProductName,
										 OpeningStock = this.OpeningStock,
										 ClosingStock = this.ClosingStock,

                      ]);
                    });

                    $('#StockConsumption').dataTable({
                        "bDestroy": true,
                        "bProcessing": true,
                        "bPaginate": true,
                        "bFooter": true,
                        "bDeferRender": true,
                        "bSortable": false,
                        "bJQueryUI": true,
                        "aaData": DTD,
                        'bSort': false,
                        'bFilter': true,
                        'sPaginationType': 'full_numbers',
                        //"fnStandingRedraw": function() { pop.show(); },
                        "sDom": '<"H"Tfr>t<"F"ip>',
                        "oTableTools": {
                            "sSwfPath": "../PlatForm/Scripts/DataTable/Media/copy_csv_xls_pdf.swf",
                            "aButtons": [

                                              {
                                                  "sExtends": "xls",
                                                  "sFileName": "StockConsumptionReport.xls",
                                                  "bFooter": true

                                              },

                                                {
                                                    "sExtends": "csv",
                                                    "sFileName": "StockConsumptionReport.csv",
                                                    "bFooter": true

                                                },
                                                {
                                                    "sExtends": "pdf",
                                                    "sFileName": "StockConsumptionReport.pdf",
                                                    "bFooter": true

                                                },
                                          ]
                        }
                    });


                    $('#StockConsumption').show();
                    $("#pendingProgress").hide();
                    pop.hide();
                }
            }
            catch (e) {
                alert('Exception while binding Data');
            }
            return false;
        }




        function Productkeypress() {
            $("#hdnProductID").val('0');
            return false;
        }
        function ProductOnchange() {
            if ($("#hdnProductID").val() == '0') {
                $("#txtProductName").val('');
            }
            if ($.trim($("#txtProductName").val()) == "") {
                $("#hdnProductID").val('0')
            }
            return false;
        }
    
    </script>

</body>
</html>
