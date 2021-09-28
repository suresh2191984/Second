<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MonthAverageConsumption.aspx.cs"
    Inherits="LabConsumptionInventory_MonthAverageConsumption" meta:resourcekey="PageResource1"  %>

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
                <asp:Image ID="imgProgressbar" runat="server" 
                    ImageUrl="../PlatForm/Images/loaderNew.GIF" meta:resourcekey="imgProgressbarResource1"
                     />
            </div>
        </div>
        <table align="center" class="w-100p h-50">
            <tr>
          
                <td>
                    <asp:Label ID="lblproductname" Text="Product Name" runat="server" 
                        meta:resourcekey="lblproductnameResource1" ></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtProductName"  runat="server" MaxLength="255" 
                        onchange="ProductOnchange()" onkeypress ="Productkeypress()" 
                        CssClass="medium AutoCompletesearchBox" meta:resourcekey="txtProductNameResource1"
                        ></asp:TextBox>
                  
                </td>
                <td align="left">
                    <asp:Label ID="Labelfrmdt" runat="server" Text="From Date" 
                        meta:resourcekey="LabelfrmdtResource1" ></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtFrom" runat="server" CssClass="small datePickerPres" Width="130px"
                        onkeypress="return ValidateSpecialAndNumeric(this);" TabIndex="1" 
                        meta:resourcekey="txtFromResource1"  />
                </td>
                <td align="left">
                    <asp:Label ID="LabelTodt" runat="server" Text="To Date " 
                        meta:resourcekey="LabelTodtResource1" ></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtTo" runat="server" CssClass="small datePickerPres" Width="130px"
                        onkeypress="return ValidateSpecialAndNumeric(this);" TabIndex="2" 
                        meta:resourcekey="txtToResource1"  />
                </td>
                <td>
                    <asp:Button ID="btnsearch" runat="server" Text="Search" CssClass="btn" 
                        OnClientClick="javascript:return GetData();" meta:resourcekey="btnsearchResource1" 
                         />
                </td>
            </tr>
        </table>
        <br />
        <br />
        <div id="Divshow" runat="server" class="w-100p">
            <table id="MonthAverageConsumption" class="responstable w-100p" style="display: none;">
                <thead>
                    <tr>
                        <th class>
                        <asp:Label ID="Label1" runat="server" Text="S.No" 
                                meta:resourcekey="Label1Resource1" ></asp:Label>
                            
                        </th>
                        <th>
                          <asp:Label ID="Label2" runat="server" Text="Product" 
                                meta:resourcekey="Label2Resource1" ></asp:Label>
                            
                        </th>
                        <th>
                         <asp:Label ID="Label3" runat="server" Text="Month" 
                                meta:resourcekey="Label3Resource1" ></asp:Label>
                            
                        </th>
                        <th>
                        <asp:Label ID="Label4" runat="server" Text="Total" 
                                meta:resourcekey="Label4Resource1" ></asp:Label>
                            
                        </th>
                        <th>
                        <asp:Label ID="Label5" runat="server" Text="Actual Consumption" 
                                meta:resourcekey="Label5Resource1" ></asp:Label>
                            
                        </th>
                        <th class="a-center">
                        <asp:Label ID="Label6" runat="server" Text="Wastage" 
                                meta:resourcekey="Label6Resource1" ></asp:Label>
                            
                        </th>
                        <th>
                         <asp:Label ID="Label7" runat="server" Text="Consumption" 
                                meta:resourcekey="Label7Resource1" ></asp:Label>
                            
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
       #MonthAverageConsumption_info{display:none;}
       .my_class
       {
          align:center;
           }
       </style>
    
    <script src="../PlatForm/Scripts/DataTable/jquery.dataTables.js" type="text/javascript"></script>
    <script src="../PlatForm/Scripts/DataTable/TableTools.min.js" type="text/javascript"></script>
    <script src="../PlatForm/Scripts/DataTable/ZeroClipboard.js" type="text/javascript"></script>

    <link href="../PlatForm/Scripts/DataTable/css/dataTables.tableTools.css" rel="stylesheet"   type="text/css" />
    <link href="../PlatForm/StyleSheets/DataTable/jquery.dataTables.css" rel="stylesheet"  type="text/css" />
    <link href="../PlatForm/StyleSheets/DataTable/demo_table_jui.css" rel="stylesheet" type="text/css" />
    
    
 


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
                    //alert( $("#hdnProductID").val());               
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

                var ProductName = document.getElementById('txtProductName').value;
                // var Month = document.getElementById('drpMonth').text;
               // var Month = $('#drpMonth option:selected').text()
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
                    url: "../LabConsumptionInventory/MonthAverageConsumption.aspx/MonthlyAverageConsumption",
                    contentType: "application/json;charset=utf-8",

                    data: "{'ProductID':'" + $("#hdnProductID").val() + "','fromdate':'" + pFromDate + "','todate':'" + pToDate + "'}",
                    dataType: "json",
                    // async: true,
                    success: AjaxGetFieldData,
                    error: function(xhr, ajaxOptions, thrownError) {
                        alert("Error");
                        $('#MonthAverageConsumption').hide();
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
            //$("#MonthAverageConsumption_info").att("class","hide");
            
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
										 ProductName = this.ProductName,
										 MonthName = this.MonthName,
										 TotalofProduct = this.TotalofProduct,
										 ActualConsumption = this.TestProcessed + "(" + this.ActualConsumption + ")",
										 Wastage = this.Wastage,
										 PerConsumption = this.PerConsumption,

                                 ]);
                    });

                    $('#MonthAverageConsumption').dataTable({
                       // "bDestroy": true,
                        "bProcessing": true,
                       // "bPaginate": true,
                       // "bFooter": true,
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
                                                  "sFileName": "MonthAverageConsumption.xls",
                                                  "bFooter": true

                                              },

                                                {
                                                    "sExtends": "csv",
                                                    "sFileName": "MonthAverageConsumption.csv",
                                                    "bFooter": true

                                                },
                                                {
                                                    "sExtends": "pdf",
                                                    "sFileName": "MonthAverageConsumption.pdf",
                                                    "bFooter": true

                                                },
                                          ]
                        },
                      
                     "aoColumns": [
                  
                                    { "sClass": "a-right", "aTargets": [ 0 ] },
                                    { "sClass": "a-left", "aTargets": [ 1 ] },
                                    { "sClass": "a-left", "aTargets": [ 2 ] },
                                    { "sClass": "a-right", "aTargets": [ 3 ] },
                                    { "sClass": "a-right", "aTargets": [ 4] },
                                    { "sClass": "a-right", "aTargets": [ 5] },
                                    { "sClass": "a-right", "aTargets": [ 6] },
                       
                                ]
                     });
                    
//                   $('#MonthlyWastage').dataTable({
//                        "bDestroy": true,
//                        "bAutoWidth": false,                      
//                        "bProcessing": true,
//                        "aaData": result.d,
//                        "fnStandingRedraw": function() { pop.show(); },
//                        
//                       
//                        "aoColumns": [
//                                        { "mDataProp": "SerialNumber" },
//                                        { "mDataProp": "ProductName" },
//                                        { "mDataProp": "MonthName" },
//                                        { "mDataProp": "TotalofProduct" },
//                                        { "mDataProp": "ActualConsumption" },
//                                        { "mDataProp": "Wastage" },
//                                        { "mDataProp": "PerConsumption" },

//                                   ],
//                        "sPaginationType": "full_numbers",
//                        "aaSorting": [[10, "asc"]],
//                        "bJQueryUI": true,
//                        "iDisplayLength": 25,
//                        "sDom": '<"H"Tfr>t<"F"ip>',                       
//                        "oTableTools": {
//                        "sSwfPath": "../LabConsumptionInventory/Scripts/DataTable/Media/copy_csv_xls_pdf.swf",
//                        "aButtons": ["copy","csv","pdf", ]
//                                   
//                        }
//                    });


                    $('#MonthAverageConsumption').show();
                    $("#pendingProgress").hide();
                    pop.hide();
                }
            }
            catch (e) {
                alert('Exception while binding Data');
                $("#pendingProgress").hide();
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



    ​​
</body>
</html>
