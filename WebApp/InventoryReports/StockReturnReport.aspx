<%@ Page Language="C#" AutoEventWireup="true" CodeFile="StockReturnReport.aspx.cs" Inherits="InventoryReports_StockReturnReport" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Stock Return Report</title>
  
<script language="javascript" type="text/javascript">
        function printwin() {
          //  var prtContent = document.getElementById('dPrint');
            var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,status=0');
            WinPrint.document.write('<html><style>html *{font-size: 7px;}</style><body>');
        //    document.getElementById('gvPurchase').setAttribute["AllowPaging"]= "False";
         //        document.getElementById('gvPurchase_Alternate').setAttribute["AllowPaging"]= "False";
              WinPrint.document.write($('#printdiv').html());
         //   WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.write('</body></html>');
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
            //WinPrint.close();
            return false;
        }
        
    </script>


<script language="javascript" type="text/javascript">
    function CallPrint() {
        var prtContent = document.getElementById('printdiv');
        var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,status=0');
        WinPrint.document.write(prtContent.innerHTML);
        WinPrint.document.close();
        WinPrint.focus();
        WinPrint.print();
        WinPrint.close();
        return false;
    }
</script>

<script type="text/javascript" language="javascript">
    function onCalendarShown2() {

        var cal = $find("calendar2");
        cal._switchMode("months", true);

        if (cal._monthsBody) {
            for (var i = 0; i < cal._monthsBody.rows.length; i++) {
                var row = cal._monthsBody.rows[i];
                for (var j = 0; j < row.cells.length; j++) {
                    Sys.UI.DomEvent.addHandler(row.cells[j].firstChild, "click", call2);
                }
            }
        }
    }

    function onCalendarHidden2() {
        var cal = $find("calendar2");
        if (cal._monthsBody) {
            for (var i = 0; i < cal._monthsBody.rows.length; i++) {
                var row = cal._monthsBody.rows[i];
                for (var j = 0; j < row.cells.length; j++) {
                    Sys.UI.DomEvent.removeHandler(row.cells[j].firstChild, "click", call2);
                }
            }
        }

    }

    function call2(eventElement) {
        var target = eventElement.target;
        switch (target.mode) {
            case "month":
                var cal = $find("calendar2");
                cal._visibleDate = target.date;
                cal.set_selectedDate(target.date);
                cal._switchMonth(target.date);
                cal._blur.post(true);
                cal.raiseDateSelectionChanged();
                break;
        }
    }
</script>

<script type="text/javascript" language="javascript">

    
    
    function onCalendarShown() {

        var cal = $find("calendar1");
        //Setting the default mode to month
        cal._switchMode("months", true);

        //Iterate every month Item and attach click event to it
        if (cal._monthsBody) {
            for (var i = 0; i < cal._monthsBody.rows.length; i++) {
                var row = cal._monthsBody.rows[i];
                for (var j = 0; j < row.cells.length; j++) {
                    Sys.UI.DomEvent.addHandler(row.cells[j].firstChild, "click", call);
                }
            }
        }
    }

    function onCalendarHidden() {
        var cal = $find("calendar1");
        //Iterate every month Item and remove click event from it
        if (cal._monthsBody) {
            for (var i = 0; i < cal._monthsBody.rows.length; i++) {
                var row = cal._monthsBody.rows[i];
                for (var j = 0; j < row.cells.length; j++) {
                    Sys.UI.DomEvent.removeHandler(row.cells[j].firstChild, "click", call);
                }
            }
        }

    }

    function call(eventElement) {
        var target = eventElement.target;
        switch (target.mode) {
            case "month":
                var cal = $find("calendar1");
                cal._visibleDate = target.date;
                cal.set_selectedDate(target.date);
                cal._switchMonth(target.date);
                cal._blur.post(true);
                cal.raiseDateSelectionChanged();
                break;
        }
    }
  
</script>

<script src="Scripts/GridviewSelRow.js" type="text/javascript"></script>

<style type="text/css">
    @media print
    {
        th
        {
            color: black;
            background-color: white;
        }
        tHead
        {
            display: table-header-group;
        }
    }
        .hide{display: none;}
</style>

</head>
<body>
    <form id="form1" runat="server" defaultbutton="btnSearch">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
	<Attune:Attuneheader ID="Attuneheader" runat="server" />
		<div class="contentdata">
			<table width="100%">
				<tr>
					<td align="left">
						<div class="dataheaderWider w-100p">
							<table class="w-100p lh20">
								<tr>
								    <td align="left">
                                        <asp:Label ID="lblLocation" runat="server" Text="Location" meta:resourcekey="LabelLocationResource1"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlLocation" runat="server" CssClass="small" TabIndex="4" meta:resourcekey="ddlLocationResource1">
                                        </asp:DropDownList>
                                    </td>
									<td>
										<asp:Label ID="Labelfrmdt" runat="server" Text="From Date" meta:resourcekey="LabelfrmdtResource1"></asp:Label>
									</td>
									<td>
                                    <asp:TextBox ID="txtFrom" onkeypress="return ValidateSpecialAndNumeric(this);"
                                        CssClass="small datePickerPres" Width="75px" runat="server" meta:resourcekey="txtFromResource2"></asp:TextBox>
									</td>
									<td>
										<asp:Label ID="Labeltodt" runat="server" Text="To Date" meta:resourcekey="LabeltodtResource1"></asp:Label>
									</td>
									<td>
                                    <asp:TextBox ID="txtTo" onkeypress="return ValidateSpecialAndNumeric(this);"
                                        CssClass="small datePickerPres" Width="75px" runat="server" meta:resourcekey="txtToResource2"></asp:TextBox>
									</td>
									<td>
										<asp:Panel ID="pnReportType" runat="server" CssClass="divscheduler-border w-90p lh20"
                                            GroupingText="Grouping Filter">

											<asp:RadioButtonList ID="rdotypes" CssClass="w-100p" runat="server" RepeatDirection="Horizontal" meta:resourcekey="rdotypesResource2">
												<asp:ListItem Text="Item Wise" Value="ItemWise"></asp:ListItem>
												<asp:ListItem Text="Vendor Wise" Value="VendorWise" ></asp:ListItem>
											</asp:RadioButtonList>
										</asp:Panel>
									</td>
                                    <td id="tdVendorName" class="hide">
                                        <span>Vendor Name </span>&nbsp; &nbsp;
                                        <asp:TextBox ID="txtSupplier" runat="server" CssClass="small bg-searchimage" OnkeyPress="return ValidateMultiLangChar(this)"
                                            TabIndex="3" meta:resourcekey="txtSupplierResource1"></asp:TextBox>
                                        <ajc:AutoCompleteExtender ID="AutoCompleteExtender2" runat="server" TargetControlID="txtSupplier"
                                            ServiceMethod="GetSupplierList" ServicePath="~/InventoryCommon/WebService/InventoryWebService.asmx"
                                            EnableCaching="False" MinimumPrefixLength="1" CompletionInterval="10" CompletionListCssClass="wordWheel listMain box"
                                            CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" CompletionListItemCssClass="listitemtwo"
                                            DelimiterCharacters=";,:" Enabled="True">
                                        </ajc:AutoCompleteExtender>
                                    </td>
									<td id="tdProdName" class="hide">
									    <span>Product Name </span> &nbsp; &nbsp;
									    <asp:TextBox ID="txtProduct" runat="server" CssClass="small bg-searchimage"
                                        OnkeyPress="return ValidateMultiLangChar(this)" TabIndex="4" meta:resourcekey="txtProductResource1"></asp:TextBox>
                                        <ajc:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" TargetControlID="txtProduct"
                                            OnClientItemSelected="ProductItemSelectedvalues" ServiceMethod="GetSearchProductList"
                                            ServicePath="~/InventoryCommon/WebService/InventoryWebService.asmx" EnableCaching="False"
                                            MinimumPrefixLength="1" CompletionInterval="10" CompletionListCssClass="wordWheel listMain box"
                                            CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" CompletionListItemCssClass="listitemtwo"
                                            DelimiterCharacters=";,:" Enabled="True">
                                        </ajc:AutoCompleteExtender>
									</td>
									<td align="left">
										<asp:Button ID="btnSearch" ToolTip="Search" runat="server" Text="Search" CssClass="btn"
											OnClientClick="javascript:return Check('');" OnClick="btnSearch_Click"
											TabIndex="4" meta:resourcekey="btnSearchResource1" />
									</td>
									<td align="left">
										<asp:LinkButton ID="lnkBack" runat="server" CssClass="cancel-btn" OnClick="lnkBack_Click"
											Text="Back" meta:resourcekey="lnkBackResource1"></asp:LinkButton>
									</td>
								</tr>
							</table>
						</div>
						<div id="contentArea" runat="server" style="display: none;">
							<table border="0" width="100%">
								<tr>
									<td align="right">
										<asp:ImageButton ID="imgBtnXL" OnClick="btnExcel_Click" runat="server" ImageUrl="../PlatForm/images/ExcelImage.GIF"
											ToolTip="Save As Excel" meta:resourcekey="imgBtnXLResource2" />
									</td>
								</tr>
							</table>
							<div id="printdiv">
								<asp:UpdatePanel ID="up1" runat="server">
									<ContentTemplate>
										<asp:UpdateProgress ID="Progressbar" AssociatedUpdatePanelID="up1" runat="server">
											<ProgressTemplate>
												<div id="progressBackgroundFilter">
												</div>
												<div align="center" id="processMessage">
													<asp:Label ID="Loading" Text="Loading..." runat="server" meta:resourcekey="LoadingResource2" />
													<br />
													<br />
													<asp:Image ID="imgProgressbar" runat="server" ImageUrl="~/PlatForm/Images/working.gif" meta:resourcekey="imgProgressbarResource2" />
												</div>
											</ProgressTemplate>
										</asp:UpdateProgress>
										<input type="hidden" id="hdnRowCount" runat="server"/>
                                        <asp:GridView ID="gvStockReturn" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                                            CssClass="gridView w-100p" EmptyDataText="No matching records found" OnPageIndexChanging="gvStockReturn_PageIndexChanging"
                                            OnRowCreated="gridView_RowCreated">
                                            <Columns>
                                                <asp:TemplateField HeaderText="S.No">
                                                    <ItemTemplate>
                                                        <%# Container.DataItemIndex + 1 %>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Store Location">
                                                    <ItemTemplate>
                                                        <asp:Label ID="StoreLocation" runat="server" 
                                                            Text='<%# Eval("LocationName") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Supplier Name">
                                                    <ItemTemplate>
                                                        <asp:Label ID="SupplierName" runat="server" 
                                                            Text='<%# Eval("SupplierName") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Stock Return No">
                                                    <ItemTemplate>
                                                        <asp:Label ID="StockReturnNo" runat="server" 
                                                            Text='<%# Eval("InvoiceNo") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="StockReturn Date">
                                                    <ItemTemplate>
                                                        <asp:Label ID="StockReturnDate" runat="server" 
                                                            Text='<%# Eval("InvoiceDate", "{0: dd-MMM-yyyy}")%>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Product Name">
                                                    <ItemTemplate>
                                                        <asp:Label ID="ProductName" runat="server" 
                                                            Text='<%# Eval("ProductName") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Product Code">
                                                    <ItemTemplate>
                                                        <asp:Label ID="ProductCode" runat="server" 
                                                            Text='<%# Eval("ProductCode") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="GRN No">
                                                    <ItemTemplate>
                                                        <asp:Label ID="StockReceivedNo" runat="server" 
                                                            Text='<%# Eval("StockReceivedNo") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Batch No">
                                                    <ItemTemplate>
                                                        <asp:Label ID="BatchNo" runat="server" 
                                                            Text='<%# Eval("BatchNo") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="HSN Code">
                                                    <ItemTemplate>
                                                        <asp:Label ID="HSNCode" runat="server" 
                                                            Text='<%# Eval("HSNCode") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Quantity">
                                                    <ItemTemplate>
                                                        <asp:Label ID="Quantity" runat="server" 
                                                            Text='<%# Eval("Quantity") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Compliment Qty">  
                                                    <ItemTemplate>
                                                        <asp:Label ID="ComplimentQty" runat="server" 
                                                            Text='<%# Eval("ComplimentQTY") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="SGST">
                                                    <ItemTemplate>
                                                        <asp:Label ID="SGSTRate" runat="server" 
                                                            Text='<%# Eval("SGSTRate") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="CGST">
                                                    <ItemTemplate>
                                                        <asp:Label ID="CGSTRate" runat="server" 
                                                            Text='<%# Eval("CGSTRate") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="IGST">
                                                    <ItemTemplate>
                                                        <asp:Label ID="IGSTRate" runat="server" 
                                                            Text='<%# Eval("IGSTRate") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Return Amount">  
                                                    <ItemTemplate>
                                                        <asp:Label ID="ReturnAmount" runat="server" 
                                                            Text='<%# Eval("TotalCost") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Raised By">  
                                                    <ItemTemplate>
                                                        <asp:Label ID="RaisedBy" runat="server" 
                                                            Text='<%# Eval("Barcode") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Approved By">  
                                                    <ItemTemplate>
                                                        <asp:Label ID="ApprovedBy" runat="server" 
                                                            Text='<%# Eval("BarcodeNo") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>
                                            <HeaderStyle CssClass="dataheader1" />
                                           <PagerStyle CssClass="dataheader1" HorizontalAlign="Center" Wrap="False" />
                                        </asp:GridView>
									</ContentTemplate>
								</asp:UpdatePanel>
							</div>
						</div>
					</td>
				</tr>
			</table>
            <table id="tblNoResult" runat="server" border="0" width="100%" style="display: none;" >
                <tr>
                    <td align="center">
                        <asp:Label ID="lblNodata" runat="server"></asp:Label>
                    </td>
                </tr>
            </table>
		</div>
		<Attune:Attunefooter ID="Attunefooter" runat="server" />          
        <asp:HiddenField ID="hdnMessages" runat="server" />
        <asp:HiddenField ID="hdnProdID" runat="server" Value="0"/>
    
    </form>
    <script language="javascript" type="text/javascript">

        function Types() {
            var rbtypes = document.getElementById("<%=rdotypes.ClientID%>");
            var rdtype = rbtypes.getElementsByTagName("input");

            for (var i = 0; i < rdtype.length; i++) {
                if (rdtype[i].checked) {
                    if (rdtype[i].value == "VendorWise") {
                        $("#tdVendorName").removeAttr("class");
                        $("#tdProdName").attr("class", "hide");
                        document.getElementById('<%=txtProduct.ClientID %>').value = '';
                        document.getElementById('hdnProdID').value = '0';
                    }
                    else {
                        $("#tdVendorName").attr("class", "hide");
                        $("#tdProdName").removeAttr("class");
                        document.getElementById('<%=txtSupplier.ClientID %>').value = '';
                    }
                }
            }
        }

        $(document).ready(function() {
            Types();
            
            $("[id*=rdotypes] input").on("click", function() {
                var selectedValue = $(this).val();
                if (selectedValue == "VendorWise") {
                    $("#tdVendorName").removeAttr("class");
                    $("#tdProdName").attr("class", "hide");
                    document.getElementById('<%=txtProduct.ClientID %>').value = '';
                    document.getElementById('hdnProdID').value = '0';
                }
                else {
                    $("#tdVendorName").attr("class", "hide");
                    $("#tdProdName").removeAttr("class");
                    document.getElementById('<%=txtSupplier.ClientID %>').value = '';
                }
            });
        });


        function ProductItemSelectedvalues(sender, eventArgs) {
            var item = eventArgs.get_value();
            document.getElementById('hdnProdID').value = item.split("~")[0];
        }

        var errorMsg = "Alert";
        function Check(splitChar) {
            if (document.getElementById('txtSupplier').value == '') {
                document.getElementById('txtSupplier').value = '';
            }

            if (document.getElementById('txtProduct').value == '') {
                document.getElementById('hdnProdID').value = '0';
            }
            
            if (document.getElementById('txtFrom').value == '') {

                var userMsg = "Select From Date!";
                ValidationWindow(userMsg, errorMsg);
                return false;
            }
            else if (document.getElementById('txtTo').value == '') {
                var userMsg = "Select To Date!" ;
                
                return true;
            }
            else {
                //Assign From And To Date from Controls 
                DateFrom = document.getElementById('txtFrom').value;
                DateTo = document.getElementById('txtTo').value;
                if (!CheckFromToDate(DateFrom, DateTo)) {
                    var userMsg = "From date should not be greater then To date";
                    ValidationWindow(userMsg, errorMsg);
                    return false;
                }
            }
        }
        
        function clearContextText() {
            $('#contentArea').hide();
        }
        
		$(window).on('beforeunload', function () {
            $('#preloader').hide();
        });
    </script>
</body>
</html>


