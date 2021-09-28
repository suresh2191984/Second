<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DevicesStockUsage.aspx.cs"
    Inherits="LabConsumptionInventory_DevicesStockUsage" meta:resourcekey="PageResource1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>DevicesStockUsage</title>
</head>
<body oncontextmenu="return true;">
    <form id="form1" runat="server">

    <script type="text/javascript" src="Scripts/DevicesStockUsage.js"></script>

    <script type="text/javascript">

        function gvStockLoadedCheckAndUncheck(chk) {
            $('#<%=gvStockLoaded.ClientID %>').find("input:checkbox").each(function() {
                if (this != chk) {
                    this.checked = chk.checked;
                }
            });
        }

        function gvStockToLoadedCheckAndUncheck(chk) {
            $('#<%=gvStockToLoaded.ClientID %>').find("input:checkbox").each(function() {
                if (this != chk) {
                    this.checked = chk.checked;
                    if (chk.checked == false) {
                        $('#' + this.id.replace("_cbSTLLoad", "_txtSTLBarCode")).val('');
                    }
                }
            });
        }

        function DisplayTab(tabName) {
            if (tabName == 'SL') {
                $('#tblStockToLoaded').removeClass().addClass('hide');
                $('#tblStockLoaded').removeClass().addClass('displaytb w-100p');
                $('#tabStocktoload').removeClass();
                $('#tabstockloaded').addClass('active');
                $('#btnClear').addClass('hide');
                
            }
            if (tabName == 'STL') {
                $('#tblStockLoaded').removeClass().addClass('hide');
                $('#tblStockToLoaded').removeClass().addClass('displaytb w-100p');

                $('#tabstockloaded').removeClass();
                $('#tabStocktoload').addClass('active');
				$('#btnClear').removeClass('hide');
            }
        }

        function ClearStatement() {
            $('#ddlAnalyzerName').val('0');
            document.getElementById('txtBarcode').value = "";
            $('#gvStockToLoaded').find('th').each(function() {
            $(this).find('input').prop('checked', false);

            });

            $('#gvStockToLoaded').find('td').each(function() {
            $(this).find('input').prop('checked', false);
          

        });
   
        }
        
        
        



    function ClosemodelPopup(obj) {
        $("#divReject").dialog('close');
        return false;
    }

    function OpenmodelPopup(obj) {
     
         
     $("#divReject").dialog(
          {
              modal: true,
              //height: 250,
              autoOpen: false,
              //width: 250,    
              title: 'Nearing Expiry Products',
              dialogClass: 'closeTitleBar',
              open: function(event, ui) {
                  //$(this).parent().addClass("w-auto");
                  //$(this).parent().css("left", "40%");
              }
          });
          $("#divReject").dialog('open');
            return false;
      }
       
        

        

    </script>

    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="True">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
     <%--   <asp:Button ID="btnReject" Text=" Reject Indent " runat="server" OnClientClick="return OpenmodelPopup(this)"
            CssClass="btn" CommandArgument="RejectIntend" />--%>
        <table class="w-100p">
            <tr>
                <td class="w-100p">
                    <table class="w-40p h-50p">
                        <tr>
                            <td>
                                <asp:Label ID="lblDevicesName" runat="server" Text="Select Device Name" meta:resourcekey="lblDevicesNameResource1"></asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlAnalyzerName" runat="server" CssClass="medium" meta:resourcekey="ddlAnalyzerNameResource1">
                                </asp:DropDownList>
                                <img src="../PlatForm/Images/starbutton.png" alt="" class="a-center" />
                            </td>
                            <td>
                                <asp:Button ID="btnLoad" Text="Show" CssClass="btn" runat="server" OnClick="btnLoad_Click"
                                    meta:resourcekey="btnLoadResource1" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <table class="w-100p">
            <tr>
                <td class="v-top">
                    <div id='TabsMenus' class="a-left">
                        <ul>
                            <li id="tabStocktoload" class="active" onclick="DisplayTab('STL')"><a href='#'><span>
                                <asp:Label ID="lblStocktoload" runat="server" Text="Stock to load" meta:resourcekey="lblStocktoloadResource1"></asp:Label></span></a></li>
                            <li id="tabstockloaded" onclick="DisplayTab('SL')"><a href='#'><span>
                                <asp:Label ID="lblstockloaded" runat="server" Text=" Stock Loaded" meta:resourcekey="lblstockloadedResource1"></asp:Label></span></a></li>
                        </ul>
                    </div>
                </td>
            </tr>
        </table>
        <table id="tblStockToLoaded" class="w-100p">
            <tr>
                <td class="w-100p">
                    <table class="w-100p h-50 hide" id="tblSTLBarcode" runat="server">
                        <tr>
                            <td>
                                <asp:Label ID="lblBarcode" runat="server" Text="BarCodeNo" meta:resourcekey="lblBarcodeResource1"></asp:Label>
                            </td>
                            <td colspan="2">
                                <asp:TextBox ID="txtBarcode" runat="server" CssClass="medium" meta:resourcekey="txtBarcodeResource1"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                    <div class="w-100p">
                        <asp:GridView ID="gvStockToLoaded" runat="server" AutoGenerateColumns="False" CssClass="gridView w-100p"
                            OnRowCommand="gvStockToLoaded_RowCommand" meta:resourcekey="gvStockToLoadedResource1">
                            <Columns>
                                <asp:TemplateField meta:resourcekey="TemplateFieldResource1">
                                    <HeaderTemplate>
                                        <asp:CheckBox ID="cbhdrSTLLoad" runat="server" class="fndChk" onclick="return gvStockToLoadedCheckAndUncheck(this)"
                                            meta:resourcekey="cbhdrSTLLoadResource1" />
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:CheckBox ID="cbSTLLoad" runat="server" onclick="return gvCheckboxClick(this);"
                                            meta:resourcekey="cbSTLLoadResource1" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Product Name" meta:resourcekey="TemplateFieldResource2">
                                    <ItemTemplate>
                                        <asp:Label ID="lblProductName" runat="server" Text='<%# Bind("ProductName") %>' meta:resourcekey="lblProductNameResource1"></asp:Label>
                                        <asp:HiddenField ID="hdnSTLProductID" runat="server" Value='<%# Bind("ProductID") %>' />
                                        <asp:HiddenField ID="hdnSTLDeviceID" runat="server" Value='<%# Bind("DeviceID") %>' />
                                        <asp:HiddenField ID="hdnStockReceivedBarcodeDetailsID" runat="server" Value='0' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="BarCode" meta:resourcekey="TemplateFieldResource3">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtSTLBarCode" runat="server" Text='<%# Bind("ItemBarcodeNo") %>'
                                            ReadOnly="True" meta:resourcekey="txtSTLBarCodeResource1"></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Action" meta:resourcekey="TemplateFieldResource4">
                                    <ItemTemplate>
                                        <asp:Button ID="btnSTLLoad" runat="server" CssClass="btn" Text="Load" CommandName="load"
                                            CommandArgument='<%# Container.DataItemIndex %>' OnClientClick="return GvStockToLoad(this);"
                                            meta:resourcekey="btnSTLLoadResource1" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </td>
            </tr>
            <tr>
                <td class="hide" id="tdSTL" runat="server">
                    <asp:Button ID="btnBulkLoad" runat="server" Text="Load" CssClass="btn" OnClientClick="return GvBulkStockToLoad();"
                        OnClick="btnBulkLoad_Click" meta:resourcekey="btnBulkLoadResource1" />
                    <asp:Button ID="btnSTLClear" runat="server" Text="Clear" CssClass="btn" OnClientClick="return ClearStatement();"
                        meta:resourcekey="btnSTLClearResource1" />
                </td>
            </tr>
        </table>
        <table id="tblStockLoaded" class="w-100p hide">
            <tr>
                <td class="h-50p">
                </td>
            </tr>
            <tr>
                <td>
                    <asp:GridView ID="gvStockLoaded" runat="server" AutoGenerateColumns="False" CssClass="gridView w-100p"
                        OnRowCommand="gvStockLoaded_RowCommand" meta:resourcekey="gvStockLoadedResource1">
                        <Columns>
                            <asp:TemplateField meta:resourcekey="TemplateFieldResource5">
                                <HeaderTemplate>
                                    <asp:CheckBox ID="cbhdrLoad" runat="server" onclick="return gvStockLoadedCheckAndUncheck(this)"
                                        meta:resourcekey="cbhdrLoadResource1" />
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:CheckBox ID="cbLoad" runat="server" CssClass="SLchecked" meta:resourcekey="cbLoadResource1" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Product Name" meta:resourcekey="TemplateFieldResource6">
                                <ItemTemplate>
                                    <asp:Label ID="lblProductName" runat="server" Text='<%# Bind("ProductName") %>' meta:resourcekey="lblProductNameResource2"></asp:Label>
                                    <asp:HiddenField ID="hdnSLDeviceID" runat="server" Value='<%# Bind("DeviceID") %>' />
                                    <asp:HiddenField ID="hdnSLDeviceStockUsageID" runat="server" Value='<%# Bind("DeviceStockUsageID") %>' />
                                    <asp:HiddenField ID="hdnSLProuductID" runat="server" Value='<%# Bind("ProductID") %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="BarCode" meta:resourcekey="TemplateFieldResource7">
                                <ItemTemplate>
                                    <asp:TextBox ID="txtBarCode" runat="server" Enabled="False" Text='<%# Bind("ItemBarcodeNo") %>'
                                        meta:resourcekey="txtBarCodeResource2"></asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Date & Time" meta:resourcekey="TemplateFieldResource8">
                                <ItemTemplate>
                                    <asp:Label ID="lblDatetime" runat="server" Text='<%# Bind("StartTime") %>' meta:resourcekey="lblDatetimeResource1"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Action" meta:resourcekey="TemplateFieldResource9">
                                <ItemTemplate>
                                    <asp:Button ID="btnUnload" runat="server" CssClass="btn" Text="Unload" CommandName="SLUnload"
                                        CommandArgument='<%# Container.DataItemIndex %>' OnClientClick="return GvSLUnload(this);"
                                        meta:resourcekey="btnUnloadResource1" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Consumption % " meta:resourcekey="TemplateFieldResource10">
                                <ItemTemplate>
                                    <asp:Label ID="lblConsumption" runat="server" Text='<%# Bind("Consumption") %>' meta:resourcekey="lblConsumptionResource1"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </td>
            </tr>
            <tr>
                <td class="hide" id="tdSLbtn" runat="server">
                    <asp:Button ID="btnSLBulkUnload" runat="server" Text="Unload" CssClass="btn" OnClick="btnSLBulkUnload_Click"
                        OnClientClick="return GvBulkSLUnload();" meta:resourcekey="btnSLBulkUnloadResource1" />
                    <asp:Button ID="btnClear" runat="server" Text="Clear" CssClass="btn" meta:resourcekey="btnClearResource1" />
                </td>
            </tr>
        </table>
        
        <div class="modal fade w-70p hide" id="divReject" role="dialog" data-role="popup">
            <div class="w-auto">
           
              
                    <div class="modal-body">
                       
                       
                       <table id="tblNearestExpiryProduct" class="w-100p gridView">
                            <thead>
                                    <tr>
                                        <th class="w-50p"> Product Name   </th>
                                        <th class="w-10p"> Batch No </th>
                                        <th class="w-15p"> In-hand Quantity </th>
                                        <th class="w-10p"> Expiry Date </th>
                                    </tr>
                            </thead>
                            <tbody></tbody>
                       </table>
                                    
                                    <div class="a-right">
                                       <br />
                                        <input id="btnCancel" onclick="return ClosemodelPopup(this);" value="Close" type="button"
                                        class="btn" />
                                    </div>
                             
                    
                    </div>
               
            </div>
        </div>
        <asp:HiddenField ID="hdnProductID" runat="server" />
        <asp:HiddenField ID="hdnOrgid" runat="server" />
        <asp:HiddenField ID="hdnDevicesUnloadData" runat="server" />
        <asp:HiddenField ID="hdnSTLloadData" runat="server" />
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    </form>

    <script type="text/jscript">

        $(document).ready(function() {

            $("#txtBarcode").autocomplete({
                minLength: 2,
                autoFocus: true,
                open: function() { $($('.ui-autocomplete')).css('width', '300px'); },
                source: function(request, response) {
                    var param = { prefixText: $('#txtBarcode').val(), strOrgID: $("#hdnOrgid").val(),ActionType :"StockToLoad" };

                    $.ajax({
                        url: "../LabConsumptionInventory/WebServices/LabConsumptionInventory.asmx/GetBarCodeJSON", //GetBarCode
                        data: JSON.stringify(param),
                        dataType: "json",
                        type: "POST",
                        contentType: "application/json; charset=utf-8",

                        success: function(data) {
                        
                           var lstProductCollection  = [];
                           
                           lstProductCollection = JSON.parse(data.d);
                           
// String [] => GetBarCode                           
//                            response($.map(data.d, function(item) {
//                              return {
//                                    label: item.split('^')[0],
//                                    value: item.split('^')[0],
//                                    pValue: item.split('^')[1]

//                                }
//                             }))
                          response($.map(lstProductCollection, function(item) {
                              return {
                                    label: item.BarcodeNo,
                                    value: item.BarcodeNo,
                                    pValue: item

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
                                    
                    $("#txtBarcode").val($.trim(i.item.label)); 
                    $("#hdnProductID").val(i.item.pValue.ProductID);
                    
                      var ar = [];
                            ar.push(funGetNearestExpiryProduct(i.item.pValue.ProductID,i.item.pValue.ReceivedUniqueNumber));
                                $.when.apply(this, ar).done(function() {
                                    BindNearestExpiryProduct();
                                }); 
                    
                    SelectGvSTLProduct(i.item.pValue.ProductID, $.trim(i.item.label),i.item.pValue.StockReceivedBarcodeDetailsID);
                    return false;
                }
            });
        });


        function SelectGvSTLProduct(ProductID, BarcodeValue,StockReceivedBarcodeDetailsID) {

            try {
                $('[id$="gvStockToLoaded"] tbody tr').each(function(i, n) {
                    var currentRow = $(n);
                    if (i > 0) {

                        if (Number(currentRow.find("input[id$='hdnSTLProductID']").val()) == Number(ProductID)) {
                            currentRow.find("input[id$='txtSTLBarCode']").val(BarcodeValue);                            
                            currentRow.find("input[id$='hdnStockReceivedBarcodeDetailsID']").val(StockReceivedBarcodeDetailsID);
                                                        
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

</body>
</html>
