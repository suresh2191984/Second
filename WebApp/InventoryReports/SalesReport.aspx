<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SalesReport.aspx.cs" Inherits="InventoryReports_SalesReport"
    EnableEventValidation="false" meta:resourcekey="PageResource2" %>

<%@ Register Src="~/InventoryCommon/Controls/InventorySearch.ascx" TagName="InventorySearch"
    TagPrefix="uc2" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Sales Report</title>
  



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
    function checkBillnumber(Id) {
        var Id = Id;
        if (Id == 'rdotypes_0') {
            document.getElementById('txtBillNumber').value = "";
            document.getElementById('divBill').style.display = "none";
        }
        if ((Id == 'rdotypes_1') || (Id == 'rdotypes_2')) {
            document.getElementById('txtBillNumber').value = "";
            document.getElementById('divBill').style.display = "block";
        }
    }
    function AddTHEAD(tableName) {
        var table = document.getElementById(tableName);
        if (table != null) {
            var head = document.createElement("THEAD");
            head.style.display = "table-header-group";
            head.appendChild(table.rows[0]);
            table.insertBefore(head, table.childNodes[0]);
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
</style>

</head>
<body oncontextmenu="return true;" onload="javascript: AddTHEAD('gvSales')">
    <form id="form1" runat="server" defaultbutton="btnSearch">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
	<Attune:Attuneheader ID="Attuneheader" runat="server" />
	<script language="javascript" src="../InventoryCommon/Scripts/InvStockReceive.js" type="text/javascript"></script>
		<div class="contentdata">
			<table width="100%">
				<tr>
					<td align="left">
						<div class="dataheaderWider w-100p">
							<table class="w-100p lh20">
								<tr>
									<td>
										<asp:Label ID="lblOrgs" runat="server" Text="Select an Organization" 
                                            meta:resourcekey="lblOrgsResource1"></asp:Label>
									</td>
									<td>
										<asp:DropDownList ID="ddlTrustedOrg" onchange="javascript:clearContextText();" runat="server"
											CssClass="smaller" meta:resourcekey="ddlTrustedOrgResource1">
										</asp:DropDownList>
									</td>
									<td>
										<asp:Label ID="Labelfrmdt" runat="server" Text="From Date" meta:resourcekey="LabelfrmdtResource1"></asp:Label>
									</td>
									<td>
                                    <asp:TextBox ID="txtFrom" onkeypress="return ValidateSpecialAndNumeric(this);"
                                        CssClass="small datePickerPres" Width="70px" runat="server" meta:resourcekey="txtFromResource2"></asp:TextBox>
									</td>
									<td>
										<asp:Label ID="Labeltodt" runat="server" Text="To Date" meta:resourcekey="LabeltodtResource1"></asp:Label>
									</td>
									<td>
                                    <asp:TextBox ID="txtTo" onkeypress="return ValidateSpecialAndNumeric(this);"
                                        CssClass="small datePickerPres" Width="70px" runat="server" meta:resourcekey="txtToResource2"></asp:TextBox>
									</td>
									<td>
										<asp:Panel ID="pnReportType" runat="server"   CssClass="divscheduler-border w-90p lh20"
                                            GroupingText="Report Type" meta:resourcekey="pnReportTypeResource1">
											<asp:RadioButtonList ID="rdotypes" CssClass="w-100p" runat="server" RepeatDirection="Horizontal" meta:resourcekey="rdotypesResource2">
												<asp:ListItem Text="summary" Selected="True"
													meta:resourcekey="ListItemResource4"></asp:ListItem>
												<asp:ListItem Text="Details" meta:resourcekey="ListItemResource5"></asp:ListItem>
												<asp:ListItem Text="Both" meta:resourcekey="ListItemResource6"></asp:ListItem>
											</asp:RadioButtonList>
										</asp:Panel>
									</td>
									<td>
									    <fieldset class="scheduler-border">
									    <legend class="scheduler-border">Visit Type</legend>
									    <asp:RadioButtonList RepeatDirection="Horizontal" ID="rbtSales" class="w-100p" runat="server" 
                                            meta:resourcekey="rbtSalesResource1">
											<asp:ListItem Text="IP" Selected="True" Value="1" 
                                                meta:resourcekey="ListItemResource1"></asp:ListItem>
											<asp:ListItem Text="OP" Value="0" meta:resourcekey="ListItemResource2"></asp:ListItem>
											<asp:ListItem Text="Both" Value="2" meta:resourcekey="ListItemResource3"></asp:ListItem>
										</asp:RadioButtonList>
										</fieldset>
									</td>
									<td align="left">
										<asp:Button ID="btnSearch" ToolTip="Search" runat="server" Text="Search" CssClass="btn"
											OnClientClick="javascript:return CheckDates('');" OnClick="btnSearch_Click"
											TabIndex="4" meta:resourcekey="btnSearchResource2" />
									</td>
									<td>
										<div id="divBill" runat="server">
											<table style="display: none;">
												<tr>
													<td align="left">
														<asp:Label ID="Labelbillnumber" runat="server" Text="Bill Number" meta:resourcekey="LabelbillnumberResource2"></asp:Label>
													</td>
													<td align="left">
														<asp:TextBox ID="txtBillNumber" runat="server" Width="130px" meta:resourcekey="txtBillNumberResource1"></asp:TextBox>
													</td>
												</tr>
											</table>
										</div>
									</td>
									<td>
										<asp:LinkButton ID="lnkBack" runat="server" CssClass="cancel-btn" OnClick="lnkBack_Click"
											Text="Back" meta:resourcekey="lnkBackResource1"></asp:LinkButton>
									</td>
								</tr>
								<tr>
									<td align="left" style="display: none;">
										<asp:Label ID="LabelLocation" runat="server" Text="Location" meta:resourcekey="LabelLocationResource2"></asp:Label>
									</td>
									<td align="left" style="display: none;">
										<asp:DropDownList ID="ddlLocation" runat="server" Width="130px" TabIndex="3" meta:resourcekey="ddlLocationResource2">
										</asp:DropDownList>
									</td>
								</tr>
							</table>
						</div>
						<div id="contentArea" runat="server" style="display: none;">
							<table border="0" width="100%">
								<tr>
									<td align="right">
										<asp:ImageButton ID="imgBtnXL" OnClick="btn_export_Click" runat="server" ImageUrl="../PlatForm/images/ExcelImage.GIF"
											ToolTip="Save As Excel" meta:resourcekey="imgBtnXLResource2" />
										<asp:LinkButton ID="btn_export" CssClass="hide" runat="server" Font-Bold="True" Text="Export to Excel"
											OnClick="btn_export_Click" Style="border-width: 2px;" Font-Size="12px" ForeColor="Black"
											Font-Underline="True" meta:resourcekey="btn_exportResource2" />
										<asp:ImageButton ID="imgBtnPrint" runat="server" ImageUrl="../PlatForm/images/printer.GIF"
											ToolTip="Click Here To Print Supplier Details" OnClientClick="return CallPrint();"
											meta:resourcekey="imgBtnPrintResource2" />
										<asp:LinkButton ID="lnkPrint" CssClass="hide" runat="server" Font-Bold="True" OnClientClick="return CallPrint();"
											Font-Underline="True" Text="Print" Font-Size="12px" ForeColor="Black" ToolTip="Click Here To Print Stock Details"
											meta:resourcekey="lnkPrintResource1"></asp:LinkButton>
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
										<table width="100%" border="0" cellpadding="0" cellspacing="0">
											<tr>
												<td>
													<asp:Label ID="lblMsg" runat="server" meta:resourcekey="lblMsgResource2"></asp:Label>
												</td>
											</tr>
											<tr>
												<td align="left" valign="top">
													<div class="dataheaderWider" visible="False" style="font-weight: bold;" runat="server"
														id="divPharmacytotRefund">
														<asp:Label runat="server" ID="lblPharmacytotRefund" meta:resourcekey="lblPharmacytotRefundResource1"></asp:Label><br />
														<asp:Label runat="server" ID="lblPharmacyDateRangeRefund" meta:resourcekey="lblPharmacyDateRangeRefundResource1"></asp:Label>
														<asp:Label runat="server" ID="lblPharmacyItemRefund" Visible="False" meta:resourcekey="lblPharmacyItemRefundResource1"></asp:Label>
													</div>
												</td>
												<td align="left">
													<asp:GridView ID="grdSummarydata" runat="server" AutoGenerateColumns="False" Width="100%"
														Visible="true" ForeColor="#333333" CssClass="mytable2" meta:resourcekey="grdSummarydataResource1" ShowFooter="true">
														<Columns>
															<asp:BoundField HeaderText="Tax Rate(%)" DataFormatString="{0:0.00}" DataField="Type"
																meta:resourcekey="BoundFieldResource13" />
															<asp:BoundField HeaderText="Invoice Amt" DataFormatString="{0:0.00}" DataField="NetAmount"
																meta:resourcekey="BoundFieldResource14" />
															<asp:BoundField HeaderText="Sales Value" DataFormatString="{0:0.00}" DataField="NetValue"
																meta:resourcekey="BoundFieldResource15" />
															<asp:BoundField HeaderText="Tax Paid" DataFormatString="{0:0.00}" DataField="GrossBillValue"
																meta:resourcekey="BoundFieldResource16" />
														</Columns>
														<%--<FooterStyle Font-Size="Smaller" BackColor="White" ForeColor="#000066" />--%>
														<FooterStyle CssClass="dataheader1" HorizontalAlign="Right" />
														<PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
														<RowStyle Font-Size="9pt" BackColor="White" Font-Bold="False" />
														<SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
														<HeaderStyle Font-Size="9pt" CssClass="grdcolor" Height="7px" Font-Bold="True" />
													</asp:GridView>
												</td>
											</tr>
											<tr>
												<td>
													<div id="divsummary" style="display: none;" runat="server">
														<table width="100%" border="0" cellpadding="3" cellspacing="2">
															<tr>
																<td class="colorforcontent" align="left">
																	<div id="ACX2minusOPPmt" style="display: block;" runat="server">
																		&nbsp;<img src="../PlatForm/images/HideBids.gif" alt="hide" width="15px" height="15px" align="top"
																			style="cursor: pointer" onclick="showResponses('ACX2OPPmt','ACX2minusOPPmt','ACX2responsesOPPmt',0);" />
																		<span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2OPPmt','ACX2minusOPPmt','ACX2responsesOPPmt',0);">
																			&nbsp;Summary Report </span>
																	</div>
																	<div id="ACX2OPPmt" style="display: none;" runat="server">
																		&nbsp;<img src="../PlatForm/images/ShowBids.gif" alt="Show" width="15" height="15" align="top"
																			style="cursor: pointer" onclick="showResponses('ACX2OPPmt','ACX2minusOPPmt','ACX2responsesOPPmt',1);" />
																		<span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2OPPmt','ACX2minusOPPmt','ACX2responsesOPPmt',1);">
																			&nbsp;Summary Report</span>
																	</div>
																</td>
															</tr>
															<tr class="tablerow" id="ACX2responsesOPPmt" runat="server">
																<td runat="server">
																	<asp:GridView ID="gvIPCreditMainGrandTotal" runat="server" AutoGenerateColumns="False"
																		Width="100%" Visible="False" ForeColor="#333333" CssClass="mytable1" meta:resourcekey="gvIPCreditMainGrandTotalResource1">
																		<Columns>
																			<asp:BoundField DataField="BillAmount" DataFormatString="{0:0.00}" HeaderText="Bill Amt"
																				meta:resourcekey="BoundFieldResource6">
																				<ItemStyle HorizontalAlign="Right" />
																			</asp:BoundField>
																			<asp:BoundField DataField="PreviousDue" DataFormatString="{0:0.00}" HeaderText="Acc Due"
																				Visible="False" meta:resourcekey="BoundFieldResource7">
																				<ItemStyle HorizontalAlign="Right" />
																			</asp:BoundField>
																			<asp:BoundField DataField="CreditDue" DataFormatString="{0:0.00}" HeaderText="Credit Due"
																				Visible="False" meta:resourcekey="BoundFieldResource8">
																				<ItemStyle HorizontalAlign="Right" />
																			</asp:BoundField>
																			<asp:BoundField DataField="Discount" DataFormatString="{0:0.00}" HeaderText="Discount"
																				meta:resourcekey="BoundFieldResource9">
																				<ItemStyle HorizontalAlign="Right" />
																			</asp:BoundField>
																			<asp:BoundField DataField="NetValue" DataFormatString="{0:0.00}" HeaderText="Net Amt"
																				meta:resourcekey="BoundFieldResource10">
																				<ItemStyle HorizontalAlign="Right" />
																			</asp:BoundField>
																			<asp:BoundField DataField="ReceivedAmount" DataFormatString="{0:0.00}" HeaderText="Rcvd Amt"
																				meta:resourcekey="BoundFieldResource11">
																				<ItemStyle HorizontalAlign="Right" />
																			</asp:BoundField>
																			<asp:BoundField DataField="Cash" DataFormatString="{0:0.00}" HeaderText="Cash" meta:resourcekey="BoundFieldResource12">
																				<ItemStyle HorizontalAlign="Right" />
																			</asp:BoundField>
																			<asp:BoundField DataField="Cards" DataFormatString="{0:0.00}" HeaderText="Cards"
																				meta:resourcekey="BoundFieldResource13">
																				<ItemStyle HorizontalAlign="Right" />
																			</asp:BoundField>
																			<asp:BoundField DataField="Cheque" DataFormatString="{0:0.00}" HeaderText="Cheque"
																				meta:resourcekey="BoundFieldResource14">
																				<ItemStyle HorizontalAlign="Right" />
																			</asp:BoundField>
																			<asp:BoundField DataField="DD" DataFormatString="{0:0.00}" HeaderText="Drafts" meta:resourcekey="BoundFieldResource15">
																				<ItemStyle HorizontalAlign="Right" />
																			</asp:BoundField>
																			<asp:BoundField DataField="Due" DataFormatString="{0:0.00}" HeaderText="Bill Due"
																				meta:resourcekey="BoundFieldResource16">
																				<ItemStyle HorizontalAlign="Right" />
																			</asp:BoundField>
																			<asp:BoundField DataField="VisitType" Visible="False" HeaderText="Visit" meta:resourcekey="BoundFieldResource18">
																				<ItemStyle HorizontalAlign="Right" />
																			</asp:BoundField>
																			<asp:BoundField DataField="AmountRefund" DataFormatString="{0:0.00}" HeaderText="Rfd Amt"
																				meta:resourcekey="BoundFieldResource19">
																				<ItemStyle HorizontalAlign="Right" />
																			</asp:BoundField>
																			<asp:BoundField DataField="DepositUsed" DataFormatString="{0:0.00}" HeaderText="Deposit Used"
																				meta:resourcekey="BoundFieldResource21">
																				<ItemStyle HorizontalAlign="Right" />
																			</asp:BoundField>
																			<asp:BoundField DataField="CoPayment" DataFormatString="{0:0.00}" HeaderText="ClosingBalance"
																				meta:resourcekey="BoundFieldResource20">
																				<ItemStyle HorizontalAlign="Right" />
																			</asp:BoundField>
																		</Columns>
																		<FooterStyle BackColor="White" ForeColor="#000066" />
																		<PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
																		<RowStyle BackColor="White" Font-Bold="True" />
																		<SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
																		<HeaderStyle CssClass="grdcolor" Font-Bold="True" />
																	</asp:GridView>
																</td>
															</tr>
														</table>
													</div>
												</td>
											</tr>
										</table>
										<table id="tblGrid" width="100%" border="0">
											<tr>
												<td>
													<input type="hidden" id="hdnRowCount" runat="server"></input>
														<input id="hdnextendedGrid" runat="server" type="hidden"></input>
														<asp:GridView ID="MainGrandTotal" runat="server" AutoGenerateColumns="False" Caption=" Sales Summary Details"
															ForeColor="#333333" HorizontalAlign="Right" meta:resourcekey="MainGrandTotalResource2"
															OnRowDataBound="gvAllSales_RowDataBound" Visible="False" Width="100%">
															<Columns>
																<asp:BoundField DataField="Type" DataFormatString="{0:dd-MMM-yyyy}" HeaderText="Bill Date"
																	meta:resourcekey="BoundFieldResource17">
																	<FooterStyle CssClass="dataheader1" />
																</asp:BoundField>
																<asp:BoundField DataField="NetValue" HeaderText="Gross Value" DataFormatString="{0:0.00}"
																	meta:resourcekey="BoundFieldResource18">
																	<ItemStyle HorizontalAlign="Right" />
																</asp:BoundField>
																<asp:BoundField DataField="AdvanceRecieved" HeaderText="Vat (4%)" DataFormatString="{0:0.00}"
																	meta:resourcekey="BoundFieldResource19">
																	<ItemStyle HorizontalAlign="Right" />
																</asp:BoundField>
																<asp:BoundField DataField="TaxPercent" HeaderText="Vat (5%)" DataFormatString="{0:0.00}"
																	meta:resourcekey="BoundFieldResource20">
																	<ItemStyle HorizontalAlign="Right" />
																</asp:BoundField>
																<asp:BoundField DataField="GrossAmount" HeaderText="Vat (5.5%)" 
                                                                    DataFormatString="{0:0.00}" meta:resourcekey="BoundFieldResource3">
																	<ItemStyle HorizontalAlign="Right" />
																</asp:BoundField>
																<asp:BoundField DataField="AmountReceived" HeaderText="Vat (12.5%)" DataFormatString="{0:0.00}"
																	meta:resourcekey="BoundFieldResource21">
																	<ItemStyle HorizontalAlign="Right" />
																</asp:BoundField>
																<asp:BoundField DataField="ServiceCharge" HeaderText="Vat (13.5%)" DataFormatString="{0:0.00}"
																	meta:resourcekey="BoundFieldResource22">
																	<ItemStyle HorizontalAlign="Right" />
																</asp:BoundField>
																<asp:BoundField DataField="TaxAmount14" HeaderText="Vat (14.00%)" 
                                                                    DataFormatString="{0:0.00}" meta:resourcekey="BoundFieldResource4"
																	>
																	<ItemStyle HorizontalAlign="Right" />
																</asp:BoundField>
																 <asp:BoundField DataField="TaxAmount145" HeaderText="Vat (14.50%)" DataFormatString="{0:0.00}"
																	meta:resourcekey="BoundFieldResource23">
																	<ItemStyle HorizontalAlign="Right" />
																</asp:BoundField>
																<asp:BoundField DataField="AmountRefund" HeaderText="Vat (0%)" DataFormatString="{0:0.00}"
																	meta:resourcekey="BoundFieldResource24">
																	<ItemStyle HorizontalAlign="Right" />
																</asp:BoundField>
																<asp:BoundField DataField="CurrentDue" HeaderText="Other Tax" DataFormatString="{0:0.00}"
																	meta:resourcekey="BoundFieldResource25">
																	<ItemStyle HorizontalAlign="Right" />
																</asp:BoundField>
																<asp:BoundField DataField="GrossBillValue" HeaderText="Net Value" DataFormatString="{0:0.00}"
																	meta:resourcekey="BoundFieldResource26">
																	<ItemStyle HorizontalAlign="Right" />
																</asp:BoundField>
															</Columns>
															<FooterStyle BackColor="White" ForeColor="#000066" />
															<HeaderStyle CssClass="grdcolor" Font-Bold="True" />
															<PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
															<RowStyle Font-Bold="True" />
															<SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
														</asp:GridView>
													
												</td>
											</tr>
											<tr>
												<td>
													<asp:GridView ID="gvSales" OnRowCreated="gridView_RowCreated" EmptyDataText="No matching records found "
														runat="server" AutoGenerateColumns="False" Width="100%" AllowPaging="True" OnPageIndexChanging="gvSales_PageIndexChanging"
														PageSize="20" OnRowDataBound="gvSales_RowDataBound" ShowFooter="True" Caption="Sales Details Report"
														meta:resourcekey="gvSalesResource2">
														<Columns>
															<asp:TemplateField HeaderText="S.No" meta:resourcekey="TemplateFieldResource16">
																<ItemTemplate>
																	<%# Container.DataItemIndex + 1 %>
																</ItemTemplate>
																<FooterStyle CssClass="dataheader1" />
															</asp:TemplateField>
															<asp:BoundField DataField="CreatedAt" DataFormatString="{0:dd-MMM-yyyy}" HeaderText="Bill Date"
																meta:resourcekey="BoundFieldResource27">
																<FooterStyle CssClass="dataheader1" />
																<ItemStyle HorizontalAlign="Right" />
															</asp:BoundField>
															<asp:TemplateField HeaderText="Bill No" meta:resourcekey="TemplateFieldResource17">
																<ItemTemplate>
																	<asp:Label ID="lblBillID" Text='<%# Eval("BillNumber") %>' runat="server" 
                                                                        meta:resourcekey="lblBillIDResource1" ></asp:Label>
																</ItemTemplate>
																<FooterStyle CssClass="dataheader1" Font-Bold="True" HorizontalAlign="Right" />
																<ItemStyle HorizontalAlign="Right" />
															</asp:TemplateField>
															<asp:TemplateField HeaderText="Receipt/Due Bill No" meta:resourcekey="TemplateFieldResource18">
																<ItemTemplate>
																	<asp:Label ID="lblRECBillID" Text='<%# Eval("ReceiptNo") %>' runat="server" 
                                                                        meta:resourcekey="lblRECBillIDResource1" ></asp:Label>
																</ItemTemplate>
																<FooterTemplate>
																	<asp:Label ID="Labelpagetot" runat="server" Text="Page Total" meta:resourcekey="LabelpagetotResource1"></asp:Label>
																</FooterTemplate>
																<FooterStyle CssClass="dataheader1" Font-Bold="True" />
																<ItemStyle HorizontalAlign="Right" />
															</asp:TemplateField>
															<asp:TemplateField HeaderText="Gross Value" meta:resourcekey="TemplateFieldResource19">
																<ItemTemplate>
																	<asp:Label ID="lblNet" Text='<%# Eval("NetValue", "{0:n}") %>' runat="server" 
                                                                        meta:resourcekey="lblNetResource1" ></asp:Label>
																</ItemTemplate>
																<FooterTemplate>
																	<%# lblTotalNet.Text %>
																</FooterTemplate>
																<FooterStyle CssClass="dataheader1" Font-Bold="True" />
																<ItemStyle HorizontalAlign="Right" />
															</asp:TemplateField>
															<asp:TemplateField HeaderText="Vat (4%)" meta:resourcekey="TemplateFieldResource20">
																<ItemTemplate>
																	<asp:Label ID="lblVat4" Text='<%# Eval("AdvanceRecieved", "{0:n}") %>' 
                                                                        runat="server" meta:resourcekey="lblVat4Resource1"
																		></asp:Label>
																</ItemTemplate>
																<FooterTemplate>
																	<%# lblVat4.Text %>
																</FooterTemplate>
																<FooterStyle CssClass="dataheader1" Font-Bold="True" />
																<ItemStyle HorizontalAlign="Right" />
															</asp:TemplateField>
															<asp:TemplateField HeaderText="Vat (5%)" meta:resourcekey="TemplateFieldResource21">
																<ItemTemplate>
																	<asp:Label ID="lblVat5" Text='<%# Eval("TaxPercent", "{0:n}") %>' 
                                                                        runat="server" meta:resourcekey="lblVat5Resource1"
																		></asp:Label>
																</ItemTemplate>
																<FooterTemplate>
																	<%# lblVat5.Text%>
																</FooterTemplate>
																<FooterStyle CssClass="dataheader1" Font-Bold="True" />
																<ItemStyle HorizontalAlign="Right" />
															</asp:TemplateField>
															<asp:TemplateField HeaderText="Vat (5.5%)" meta:resourcekey="TemplateFieldfiveResource">
																<ItemTemplate>
																	<asp:Label ID="lblVat55" Text='<%# Eval("GrossAmount", "{0:n}") %>' 
                                                                        runat="server" meta:resourcekey="lblVat55Resource1" ></asp:Label>
																</ItemTemplate>
																<FooterTemplate>
																	<%# lblVat55.Text%>
																</FooterTemplate>
																<FooterStyle CssClass="dataheader1" Font-Bold="True" />
																<ItemStyle HorizontalAlign="Right" />
															</asp:TemplateField>
															<asp:TemplateField HeaderText="Vat (12.5%)" meta:resourcekey="TemplateFieldResource22">
																<ItemTemplate>
																	<asp:Label ID="lblVat12" Text='<%# Eval("AmountReceived", "{0:n}") %>' 
                                                                        runat="server" meta:resourcekey="lblVat12Resource1"
																		></asp:Label>
																</ItemTemplate>
																<FooterTemplate>
																	<%# lblVat12.Text %>
																</FooterTemplate>
																<FooterStyle CssClass="dataheader1" Font-Bold="True" />
																<ItemStyle HorizontalAlign="Right" />
															</asp:TemplateField>
															<asp:TemplateField HeaderText="Vat (13.5%)" meta:resourcekey="TemplateFieldResource23">
																<ItemTemplate>
																	<asp:Label ID="lblVat13" Text='<%# Eval("ServiceCharge", "{0:n}") %>' 
                                                                        runat="server" meta:resourcekey="lblVat13Resource1"
																		></asp:Label>
																</ItemTemplate>
																<FooterTemplate>
																	<%# lblVat13.Text %>
																</FooterTemplate>
																<FooterStyle CssClass="dataheader1" Font-Bold="True" />
																<ItemStyle HorizontalAlign="Right" />
															</asp:TemplateField>
															<asp:TemplateField HeaderText="Vat (14.0%)" 
                                                                meta:resourcekey="TemplateFieldResource3" >
																<ItemTemplate>
																	<asp:Label ID="lblVat14" Text='<%# Eval("TaxAmount14", "{0:n}") %>' 
                                                                        runat="server" meta:resourcekey="lblVat14Resource1" 
																		></asp:Label>
																</ItemTemplate>
																<FooterTemplate>
																	<%# lblVat14.Text %>
																</FooterTemplate>
																<FooterStyle CssClass="dataheader1" Font-Bold="True" />
																<ItemStyle HorizontalAlign="Right" />
															</asp:TemplateField>
															
															 <asp:TemplateField HeaderText="Vat (14.5%)" meta:resourcekey="TemplateFieldResource24">
																<ItemTemplate>
																	<asp:Label ID="lblVat145" Text='<%# Eval("TaxAmount145", "{0:n}") %>' 
                                                                        runat="server" meta:resourcekey="lblVat14Resource2"
																		></asp:Label>
																</ItemTemplate>
																<FooterTemplate>
																	<%# lblVat145.Text %>
																</FooterTemplate>
																<FooterStyle CssClass="dataheader1" Font-Bold="True" />
																<ItemStyle HorizontalAlign="Right" />
															</asp:TemplateField>
															
															<asp:TemplateField HeaderText="Vat (0%)" meta:resourcekey="TemplateFieldResource25">
																<ItemTemplate>
																	<asp:Label ID="lblVat0" Text='<%# Eval("AmountRefund", "{0:n}") %>' 
                                                                        runat="server" meta:resourcekey="lblVat0Resource1"
																		></asp:Label>
																</ItemTemplate>
																<FooterTemplate>
																	<%# lblVat0.Text %>
																</FooterTemplate>
																<FooterStyle CssClass="dataheader1" Font-Bold="True" />
																<ItemStyle HorizontalAlign="Right" />
															</asp:TemplateField>
															<asp:TemplateField HeaderText="Others" meta:resourcekey="TemplateFieldResource26">
																<ItemTemplate>
																	<asp:Label ID="lblVatothers" Text='<%# Eval("CurrentDue", "{0:n}") %>' 
                                                                        runat="server" meta:resourcekey="lblVatothersResource1"
																		></asp:Label>
																</ItemTemplate>
																<FooterTemplate>
																	<%# lblVatothers.Text %>
																</FooterTemplate>
																<FooterStyle CssClass="dataheader1" Font-Bold="True" />
																<ItemStyle HorizontalAlign="Right" />
															</asp:TemplateField>
															<asp:TemplateField HeaderText="Net Value" meta:resourcekey="TemplateFieldResource27">
																<ItemTemplate>
																	<asp:Label ID="lblGross" Text='<%# Eval("GrossBillValue", "{0:n}") %>' 
                                                                        runat="server" meta:resourcekey="lblGrossResource1"
																		></asp:Label>
																</ItemTemplate>
																<FooterTemplate>
																	<%# lblTotalGross.Text %>
																</FooterTemplate>
																<FooterStyle CssClass="dataheader1" Font-Bold="True" />
																<ItemStyle HorizontalAlign="Right" />
															</asp:TemplateField>
														</Columns>
														<PagerStyle CssClass="dataheader1 pager-style" HorizontalAlign="Center" />
														<FooterStyle HorizontalAlign="Right" />
														<HeaderStyle CssClass="dataheader1" />
													</asp:GridView>
													<asp:Label ID="lblTotalGross" Text="0" runat="server" Visible="False" meta:resourcekey="lblTotalGrossResource2"></asp:Label>
													<asp:Label ID="lblTotalNet" Text="0" runat="server" Visible="False" meta:resourcekey="lblTotalNetResource2"></asp:Label>
													<asp:Label ID="lblTotalVat" Text="0" runat="server" Visible="False" meta:resourcekey="lblTotalVatResource2"></asp:Label>
													<asp:Label ID="lblVat4" Text="0" runat="server" Visible="False" meta:resourcekey="lblVat4Resource4"></asp:Label>
													<asp:Label ID="lblVat5" Text="0" runat="server" Visible="False" meta:resourcekey="lblVat5Resource4"></asp:Label>
													<asp:Label ID="lblVat55" Text="0" runat="server" Visible="False" 
                                                        meta:resourcekey="lblVat55Resource2"></asp:Label>
													<asp:Label ID="lblVat12" Text="0" runat="server" Visible="False" meta:resourcekey="lblVat12Resource4"></asp:Label>
													<asp:Label ID="lblVat13" Text="0" runat="server" Visible="False" meta:resourcekey="lblVat13Resource4"></asp:Label>
													<asp:Label ID="lblVat14" Text="0" runat="server" Visible="False" meta:resourcekey="lblVat14Resource4"></asp:Label>
													<asp:Label ID="lblVat145" Text="0" runat="server" Visible="False" meta:resourcekey="lblVat14Resource4"></asp:Label>
													<asp:Label ID="lblVat0" Text="0" runat="server" Visible="False" meta:resourcekey="lblVat0Resource4"></asp:Label>
													<asp:Label ID="lblVatothers" Text="0" runat="server" Visible="False" meta:resourcekey="lblVatothersResource4"></asp:Label>
												</td>
											</tr>
											<tr>
												<td>
													<asp:Label ID="lblAmountReceived" Text="0.00" runat="server" Visible="False" meta:resourcekey="lblAmountReceivedResource2"></asp:Label>
													<asp:Label ID="lblCurrentDue" Text="0.00" runat="server" Visible="False" meta:resourcekey="lblCurrentDueResource2"></asp:Label>
													<asp:Label ID="lblUserTotalNet" Text="0.00" runat="server" Visible="False" meta:resourcekey="lblUserTotalNetResource2"></asp:Label>
												</td>
											</tr>
											<tr>
												<td>
												</td>
											</tr>
										</table>
									</ContentTemplate>
									<Triggers>
										<asp:PostBackTrigger ControlID="btn_export" />
									</Triggers>
								</asp:UpdatePanel>
							</div>
						</div>
					</td>
				</tr>
			</table>
		</div>

		<Attune:Attunefooter ID="Attunefooter" runat="server" />          
    <asp:HiddenField ID="hdnButtonText" runat="server" meta:resourcekey="hdnButtonText1" />
        <asp:HiddenField ID="hdnMessages" runat="server" />
    
    </form>
    <script language="javascript" type="text/javascript">
        var errorMsg = SListForAppMsg.Get('InventoryReports_Error') == null ? "Alert" : SListForAppMsg.Get('InventoryReports_Error');
        function CheckDates(splitChar) {

            if (document.getElementById('txtFrom').value == '') {

                var userMsg = SListForAppMsg.Get("InventoryReports_PurchaseStatusReport_aspx_01") == null ? "Select From Date!" : SListForAppMsg.Get("InventoryReports_PurchaseStatusReport_aspx_01");
                ValidationWindow(userMsg, errorMsg);
                return false;
            }
            else if (document.getElementById('txtTo').value == '') {
                var userMsg = SListForAppMsg.Get("InventoryReports_PurchaseStatusReport_aspx_02") == null ? "Select To Date!" : SListForAppMsg.Get("InventoryReports_PurchaseStatusReport_aspx_02");
                
                return true;
            }
            else {
                //Assign From And To Date from Controls 
                DateFrom = document.getElementById('txtFrom').value;
                DateTo = document.getElementById('txtTo').value;
                if (CheckFromToDate(DateFrom, DateTo)) {
                    GetPurchaseStatusDetails();
                    return false;
                } else {
                    var userMsg = SListForAppMsg.Get("InventoryReports_PurchaseStatusReport_aspx_03") == null ? "From date should not be  greater then To date" : SListForAppMsg.Get("InventoryReports_PurchaseStatusReport_aspx_03");
                    ValidationWindow(userMsg, errorMsg);
                    return false;
                }

            }

        }
        function clearContextText() {
            $('#contentArea').hide();
            $('#divPrint').hide();
            $('#lblNoResult').hide();
        }
		
		$(window).on('beforeunload', function () {
            $('#preloader').hide();
        });
</script>
</body>
</html>

