<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ProductConsumtion.aspx.cs"
    Inherits="LabConsumptionInventory_ProductConsumtion" meta:resourcekey="PageResource1"  %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>        
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="True">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
        <div id="pendingProgress" style="display: none;">
            <div id="progressBackgroundFilter" class="a-center">
            </div>
            <div id="processMessage" class="a-center w-20p">
                <asp:Image ID="imgProgressbar" runat="server" 
                    ImageUrl="../PlatForm/Images/loaderNew.GIF" meta:resourcekey="imgProgressbarResource1"
                    />
            </div>
        </div>
        
        
        
    <script language="javascript" type="text/javascript">
        function callWebservices() {

            var Barcode = document.getElementById('txtbarcode').value;
            var ProductName = document.getElementById('txtProductName').value;

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
                                url: "../LabConsumptionInventory/ProductConsumtion.aspx/GetConsumptionFlexService",
                                contentType: "application/json;charset=utf-8",

                                data: "{'ProductID':'" + $("#hdnProductID").val() + "','Barcode':'" + Barcode + "','fromdate':'" + pFromDate + "','todate':'" + pToDate + "'}",
                                dataType: "json",
                                async: true,
                                success: AjaxGetFieldData,
                                error: function(xhr, ajaxOptions, thrownError) {
                                    alert("Error");
                                    $('#ProductConsumption').hide();
                                  
                                    pop.hide();
                                    return false;
                                }
                            });
                            pop.hide();
                            $('#ProductConsumption').show();
            return false;
        }
        
         function AjaxGetFieldData(result) {
        
         
        
           var RowSpan =true; var RowSpancount=1;
            try {
             
                var pop = $("#mdlPopup");
         
                var DTD = [];
                if (result != "[]") {
                    
                    $.each(result.d, function(i, obj) {
                                                
                        var SerialNumber = this.SerialNumber;
                        var PrimaryBarcode = this.PrimaryBarcode;
                        var SecondaryBarocode = this.SecondaryBarocode;
                        var ProductName = this.ProductName;
                        var TestName = this.TestName;
                        var Quantity = this.Quantity;
                        var QtyTestCount = this.QtyTestCount;
                        var TestProcessed = this.TestProcessed;
                        var StdConsumption = this.StdConsumption;
                        var MachineRCRR = this.MachineRCRR;
                        var QC = this.QC;
                        var Calibration = this.Calibration;
                        var ActualConsumption = this.ActualConsumption;
                        var Wastage = this.Wastage;
                        var Consumptionflex = this.Consumptionflex;
                        var KitConsumed = this.KitConsumed;
                        var DeviceCount = this.DeviceCount;
                        var RRCount = this.RRCount;
                        var RCCount = this.RCCount;
                        var QCCount = this.QCCount;
                        var CalibrationCount = this.CalibrationCount;
                        var Quantity =this.Quantity; 
               
                        
                        
                    
                        Tbl_tr = $('<tr/>');
                        var tdSerialNumber = $('<td/>').html(SerialNumber);
                            var tdPrimaryBarcode = $('<td/>').html(PrimaryBarcode );
                            var tdSecondaryBarocode = $('<td/>').html(SecondaryBarocode );
                            var tdProductName = $('<td/>').html(ProductName);
                            var tdTestName = $('<td/>').html(TestName);
                            var tdQtyTestCount,tdWastage,tdConsumptionflex,tdKitConsumed;                            
                            //var tdConsumptionflex = $('<td/>').html(Consumptionflex ); 
                            //var tdKitConsumed = $('<td/>').html(KitConsumed ); 
                           // var tdQtyTestCount = $('<td rowspan="'+Quantity+'" />').html(QtyTestCount);
                            
                            if(Quantity>1 && RowSpan==true)
                            {
                                    tdQtyTestCount = $('<td align="right" rowspan="'+Quantity+'" />').html(QtyTestCount);
                                    tdWastage = $('<td  align="right" rowspan="'+Quantity+'" />').html(Wastage );
                                    tdConsumptionflex = $('<td align="right" rowspan="'+Quantity+'"/>').html(Consumptionflex );
                                    tdKitConsumed = $('<td align="right" rowspan="'+Quantity+'" />').html(KitConsumed ); 
                                    RowSpan=false;
                                    RowSpancount++;
                            }
                            else if(RowSpancount==Quantity && RowSpan==false){
                             RowSpancount=1;
                             RowSpan=true;    
                             tdQtyTestCount=$('<td  style="display:none"/>');  
                             tdWastage=$('<td style="display:none"/>');
                             tdConsumptionflex=$('<td style="display:none"/>');
                             tdKitConsumed=$('<td style="display:none"/>');                        
                            }
                            else {                            
                             tdQtyTestCount = $('<td align="right" />').html(QtyTestCount);
                             tdWastage  = $('<td align="right" />').html(Wastage);                             
                             tdConsumptionflex = $('<td align="right" />').html(Consumptionflex);
                             tdKitConsumed =  $('<td align="right" />').html(KitConsumed);
                            }
                                                        
                            var tdTestProcessed = $('<td align="right" />').html(TestProcessed ); 
                            var tdStdConsumption = $('<td align="right" />').html(DeviceCount +"("+StdConsumption+")" );
                            var tdMachineRCRR = $('<td align="right" />').html( (RRCount+RCCount) +"("+MachineRCRR+")" );  
                            var tdQC = $('<td align="right" />').html(QCCount +"("+QC+")" );  
                            var tdCalibration = $('<td align="right" />').html(CalibrationCount +"("+Calibration+")");  
                            var tdActualConsumption = $('<td align="right" />').html(ActualConsumption ); 
                          

                        Tbl_tr.append(tdSerialNumber).append(tdPrimaryBarcode).append(tdSecondaryBarocode).append(tdProductName).append(tdTestName).append(tdQtyTestCount).append(tdTestProcessed).append(tdStdConsumption).append(tdMachineRCRR).append(tdQC).append(tdCalibration).append(tdActualConsumption).append(tdWastage).append(tdConsumptionflex).append(tdKitConsumed);
                        $('[id$="ProductConsumption"] tbody').append(Tbl_tr);
                        
                        

                  });

                    $('#ProductConsumption').dataTable({
                        "bDestroy": true,
                        "bProcessing": true,
                        "bPaginate": true,
                        "bFooter": true,
                        "bDeferRender": false,
                        "bSortable": false,                      
                        "bJQueryUI": true,
                       // "aaData": DTD,
                        'bSort': false,
                        'bFilter': false,         
                        'sPaginationType': 'full_numbers',
                        //"fnStandingRedraw": function() { pop.show(); },
                        "sDom": '<"H"Tfr>t<"F"ip>',
                        "oTableTools": {
                            "sSwfPath": "../PlatForm/Scripts/DataTable/Media/copy_csv_xls_pdf.swf",
                            "aButtons": [

                                              {
                                                  "sExtends": "xls",
                                                  "sFileName": "ProductConsumptionReport.xls",
                                                  "bFooter": true

                                              },

                                                {
                                                    "sExtends": "csv",
                                                    "sFileName": "ProductConsumptionReport.csv",
                                                    "bFooter": true

                                                },
                                                    {
                                                        "sExtends": "pdf",
                                                        "sFileName": "ProductConsumptionReport.pdf",
                                                        "bFooter": true

                                                    },
                                      


                                          ]
                             },

                    });                                       
                              

                    $('#ProductConsumption').show();
                    $("#pendingProgress").hide();
                    pop.hide();
                }
            }
            catch (e) {
                alert('Exception while binding Data');
            }
            return false;
        }
    </script>
    
        <table align="center" class="w-100p h-50">
        <tr>
                <td>
                    <asp:Label ID="lblscanbarcode" Text="Scan Barcode" runat="server" meta:resourcekey="lblscanbarcodeResource1" 
                        ></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtbarcode" runat="server" meta:resourcekey="txtbarcodeResource1" 
                        ></asp:TextBox>
                </td>
                <td>
                    <asp:Label ID="lblproductname" Text="Product Name" runat="server" 
                        meta:resourcekey="lblproductnameResource1" ></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtProductName" runat="server" MaxLength="255" 
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
                        OnClientClick="javascript:return GetData();" 
                        meta:resourcekey="btnsearchResource1" onclick="btnsearch_Click" 
                         />
                </td>
            </tr>
        </table>
        <br />
        <br />
        <div id="Divshow" runat="server" class="o-auto w-100p-datatable">
                
        
       <table id="ProductConsumption" class="responstable w-100p" style="display:none" >
              <thead align="left" class="nowrap-wordTh">
                    <tr>
                        <th>
                         <asp:Label ID="lblSNO" runat="server" Text="S.No" 
                                meta:resourcekey="lblSNOResource1" />
                           
                        </th>
                        <th>
                            <asp:Label ID="lblPrimaryBarcode" runat="server" Text="PrimaryBarcode" 
                                meta:resourcekey="lblPrimaryBarcodeResource1" />
                            
                        </th>
                        <th>
                         <asp:Label ID="lblSecondaryBarocde" runat="server" Text="Secondary Barocde" 
                                meta:resourcekey="lblSecondaryBarocdeResource1" />
                            
                        </th>
                        <th>
                         <asp:Label ID="lblProduct" runat="server" Text="Product Name" 
                                meta:resourcekey="lblProductResource1" />
                           
                        </th>
                        <th>
                           <asp:Label ID="lblTestName" runat="server" Text="TestName" 
                                meta:resourcekey="lblTestNameResource1" />
                            
                        </th>
        
                        <th>
                         <asp:Label ID="lblQtyTestCount" runat="server" Text="Qty Test Count" 
                                meta:resourcekey="lblQtyTestCountResource1" />
                            
                        </th>
                        <th>
                         <asp:Label ID="lblTestProcessed" runat="server" Text="Test Processed" 
                                meta:resourcekey="lblTestProcessedResource1" />
                            
                        </th>
                        <th>
                          <asp:Label ID="Label1" runat="server" Text=" Std Consumption" 
                                meta:resourcekey="Label1Resource1" />
                           
                        </th>
                        <th>
                           <asp:Label ID="Label2" runat="server" Text="Machine RC/RR" 
                                meta:resourcekey="Label2Resource1" />
                          
                        </th>
                 
                        <th>
                        <asp:Label ID="Label3" runat="server" Text="QC" 
                                meta:resourcekey="Label3Resource1" />
                            
                        </th>
                        <th>
                          <asp:Label ID="Label4" runat="server" Text="Calibration" 
                                meta:resourcekey="Label4Resource1" />
                            
                        </th>
                        <th>
                          <asp:Label ID="Label5" runat="server" Text="Actual Consumption" 
                                meta:resourcekey="Label5Resource1" />
                           
                        </th>                     
                        <th>
                           <asp:Label ID="Label6" runat="server" Text="Wastage" 
                                meta:resourcekey="Label6Resource1" />
                            
                        </th>
                        <th>
                         <asp:Label ID="Label7" runat="server" Text="Consumption % flex" 
                                meta:resourcekey="Label7Resource1" />
                           
                        </th>
                        <th>
                         <asp:Label ID="Label8" runat="server" Text="Kit Consumed" 
                                meta:resourcekey="Label8Resource1" />
                           
                        </th>
                    </tr>
                </thead>
                <tbody id="tbodyProductConsumption">
                  </tbody>
            </table>
            
            <asp:HiddenField ID="hdnProductID" runat="server"  Value="0"/>
            <asp:HiddenField ID="hdnOrgid" runat="server" />
        </div>
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    </form>
    
    <style>
        .w-100p-datatable
        {
            width: 1360px;
            overflow: auto;
        }
        #ProductConsumption_info{display:none;}
        .nowrap-wordTh tr>th
        {
            word-break: break-word !important;    
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

            $("#txtbarcode").autocomplete({
                minLength: 2,
                open: function() { $($('.ui-autocomplete')).css('width', '300px'); },
                source: function(request, response) {
                    var param = { prefixText: $('#txtbarcode').val(), strOrgID: $("#hdnOrgid").val() ,ActionType :"PCReports" };

                    $.ajax({
                        url: "../LabConsumptionInventory/WebServices/LabConsumptionInventory.asmx/GetBarCode",
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

                    $("#txtbarcode").val($.trim(i.item.label.split('^')[0].split('~')[0]));
                    $("#hdnProductID").val(i.item.pValue);
                    SelectGvSTLProduct(i.item.pValue, $.trim(i.item.label.split('^')[0].split('~')[0]));
                    return false;
                }
            });
        
        });

        function SelectGvSTLProduct(ProductID, BarcodeValue) {

            try {
                $('[id$="gvStockToLoaded"] tbody tr').each(function(i, n) {
                    var currentRow = $(n);
                    if (i > 0) {

                        if (Number(currentRow.find("input[id$='hdnSTLProductID']").val()) == Number(ProductID)) {
                            currentRow.find("input[id$='txtSTLBarCode']").val(BarcodeValue);
                            currentRow.find("input[id$='cbSTLLoad']").prop('checked', true);
                            //currentRow[0].cells[0].childNodes[1].checked=true;
                            currentRow.find("input[id$='txtSTLBarCode']").attr('readonly', true);
                            return false;
                        }
                    }
                });
                return false;
            }
            catch (ex) {
                console.error("SelectGvSTLProduct", ex.message);
            }

        }
     
    </script>

    <script language="javascript" type="text/javascript">
        function GetData() {
            try {             
                
    
        $("#tbodyProductConsumption").empty();
        
        
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
                


               
            }
            catch (e) {
                pop.hide();
            }
           
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
