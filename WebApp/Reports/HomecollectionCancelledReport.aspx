<%@ Page Language="C#" AutoEventWireup="true" CodeFile="HomecollectionCancelledReport.aspx.cs"
    Inherits="Reports_HomecollectionCancelledReport" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script type="text/javascript">


        function CheckToSaveData() {

          //  var customerType = document.getElementById('CSchedule_drpCustomerType').value;
            var fromDate = document.getElementById('txtFDate').value;
            var toDate = document.getElementById('txtbxtodate').value;

            //        if (customerType == '0') {
            //            alert('Please Select Business Type');
            //            document.getElementById('CSchedule_drpCustomerType').focus();
            //            //return false;
            //        }
            //else
            if (fromDate == '') {
                alert('Please Select FromDate');
                document.getElementById('txtFDate').focus();
                return false;
            }
            else if (toDate == '') {
                alert('Please Select ToDate');
                document.getElementById('txtbxtodate').focus();
                return false;
            }

        }
    </script>
    <style type="text/css">
        .HeaderContent
        {
            height: auto;
            width: auto;
            background-color: White;
        }
        .style2
        {
            width: 66px;
        }
    </style>
    <link href="../StyleSheets/TableTools_JUI.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/jquery-ui.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/jquery-ui.theme.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="scriptManager1" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata" runat="server">
        <%--
        <script type="text/javascript" src="../Scripts/jquery-1.7.2.min.js"></script>

        <script type="text/javascript" src="../Scripts/jquery-ui-1.8.19.custom.min.js"></script>--%>

        <script type="text/javascript">
            //            $(function() {
            //                $("#txtFDate").datepicker({
            //                    changeMonth: true,
            //                    changeYear: true,
            //                    maxDate: 0,
            //                    yearRange: '2008:2030'
            //                });
            //                $("#txtToDate").datepicker({
            //                    changeMonth: true,
            //                    changeYear: true,
            //                    maxDate: 0,
            //                    yearRange: '2008:2030'
            //                })
            //            });



            function AutoLocation() {
                monkeyPatchAutocompleteTableApp1();
                $("#txtUser").autocomplete({
                    source: function(request, response) {
                        $.ajax({
                            url: '../WebService.asmx/getUserNamesWithLoginID_HomeCollection',
                            data: "{ 'prefixText': '" + $("#txtUser").val() + "',contextKey:'Y'}",
                            dataType: "json",
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            success: function(data) {
                                index = 0;
                                var autoCompleteArray = new Array();
                                autoCompleteArray = $.map(data.d, function(item) {
                                    return {
                                        label: item.UserName.split('~')[0],
                                        val: item.LoginID

                                    };
                                });
                                response(autoCompleteArray);
                            }
                        });
                    },
                    select: function(e, i) {

                        $("#hdnLoginID").val(i.item.val)

                    },
                    minLength: 1
                });

            }

            function monkeyPatchAutocompleteTableApp1() {

                var oldFn = $.ui.autocomplete.prototype._renderItem;
                $.ui.autocomplete.prototype._renderItem = function(ul, item) {

                    var re = new RegExp("(?![^&;]+;)(?!<[^<>]*)(" + this.term + ")(?![^<>]*>)(?![^&;]+;)", "gi");
                    var t = item.label.replace(re, "<span style='font-weight:bold;'>$1</span>");
                    //        if (index == 0) {
                    //            ul.prepend("<table class='gridView'><tr><td class='gridHeader activeheader'>Location</td><td class='hide'> Value </td></li></td></tr></table>")
                    //            index = 1;
                    //        }
                    return $("<li></li>")
                           .data("item.autocomplete", item)
                                .append("<table class='tableNew'><tr><td>" + item.label + "</td><td class='hide'>" + item.val + "</td></td></a></td></tr></table>")

                           .appendTo(ul);
                    //}
                };
            }




            
            
        </script>

        <table id="tblCollectionOPIP" class="a-center w-100p">
            <tr class="a-center">
                <td class="a-left">
                    <div class="dataheaderWider">
                        <table id="tbl" class="a-center w-100p searchPanel" style="display: table;">
                            <tr id="trTrustedOrg" runat="server" style="display: table-row;">
                                <td>
								 
								<asp:Label ID="lblUserName"  runat="server"  Text ="User Name"></asp:Label>
								</td>
								<td>
                                    <asp:TextBox ID="txtUser" runat="server" TabIndex="7" MaxLength="250" CssClass="AutoCompletesearchBox"
                                        onkeyup="return AutoLocation();">  </asp:TextBox>
                                    <%--<ajc:AutoCompleteExtender ID="AutocompleteGetUserName" runat="server" TargetControlID="txtUser"
                                        EnableCaching="False" FirstRowSelected="False" OnClientItemSelected="SelectTab"
                                        MinimumPrefixLength="2" CompletionListCssClass="listtwo" CompletionInterval="2"
                                        CompletionListItemCssClass="listitemtwo" CompletionListHighlightedItemCssClass="hoverlistitemtwo"
                                        ServiceMethod="getHCUserNamesWithLoginID" ServicePath="~/WebService.asmx" Enabled="True">
                                    </ajc:AutoCompleteExtender>--%>
                                </td>
                                <td>
                                    <asp:Label ID="lblOrgs" runat="server" Text="Status"></asp:Label>
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlstatusall" AutoPostBack="true" runat="server" CssClass="ddlsmall">
                                        <asp:ListItem Selected="True" Text="Cancelled" Value="C"></asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                                <td class="style2">
                                    <asp:Label ID="Rs_FromDate" Text="From Date " runat="server"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox CssClass="small" ID="txtFDate" runat="server"></asp:TextBox>
                                    <a style="color: Red;">*</a>
                                    <%--<a href="javascript:NewCssCal('txtTo','ddmmyyyy','arrow',true,12)">
                                        <img src="../images/Calendar_scheduleHS.png" id="img3" style="vertical-align: middle;"
                                            alt="Pick a date"></a>--%>
                                    <ajc:CalendarExtender ID="AjaxExtTodate" runat="server" Format="dd/MM/yyyy" PopupButtonID="ImgFDate"
                                        TargetControlID="txtFDate" Enabled="True">
                                    </ajc:CalendarExtender>
                                    <asp:ImageButton ID="ImgFDate" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                        meta:resourcekey="ImgFDateResource1" />
                                </td>
                                <td>
                                    <asp:Label ID="Rs_ToDate" Text="To Date " runat="server"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtbxtodate" runat="server"></asp:TextBox>
                                    <a style="color: Red;">*</a>
                                    <asp:ImageButton ID="imgcal_Todate" runat="server" ImageUrl="~/Images/Calendar_scheduleHS.png" />
                                    <ajc:CalendarExtender ID="AjaxExfromdate" runat="server" TargetControlID="txtbxtodate"
                                        Format="dd/MM/yyyy" PopupButtonID="imgcal_Todate">
                                    </ajc:CalendarExtender>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="3">
                                </td>
                                <td class="a-center" colspan="3">
                                    <table class="w-100p">
                                        <tr>
                                            <td class="a-left w-20p">
                                                <asp:Button ID="btnSubmit" runat="server" CssClass="btn" OnClick="btnSubmit_onclick"
                                                   OnClientClick="return CheckToSaveData()"    onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'" Text="Get Report" />
                                            </td>
                                            <td class="a-left w-20p">
                                                <asp:ImageButton ID="btnExcel" runat="server" CssClass="h-25 w-25" ImageUrl="~/Images/ExcelImage.GIF"
                                                    OnClick="btnExcel_Click" meta:resourcekey="btnExcelResource1" ToolTip="Export To Excel"
                                                    Visible="false" />
                                            </td>
                                            <td class="a-left w-25p">
                                                <asp:LinkButton ID="lnkBack" runat="server" BackColor="Red" Text="GO Back" ForeColor="Black"
                                                    Font-Underline="True" OnClick="lnkBack_Click"></asp:LinkButton>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="loading a-center">
                        <%--  Loading...<br />
                        <br />
                        <img src="../Images/loader.gif" alt="" />--%>
                        <asp:UpdateProgress ID="Progressbar" runat="server">
                            <ProgressTemplate>
                                <div id="progressBackgroundFilter" class="a-center">
                                </div>
                                <div id="processMessage" class="a-center w-20p">
                                    <asp:Image ID="img1" Width="40px" Height="40px" runat="server" ImageUrl="../Images/loading.GIF"
                                        meta:resourcekey="img1Resource1" />
                                </div>
                            </ProgressTemplate>
                        </asp:UpdateProgress>
                    </div>
                    <div id="divOPDWCR" runat="server" style="display: block;">
                        <div id="prnReport" runat="server" class="w-100p" style="overflow: scroll; height: 420px;">
                            <table runat="server" class="a-center w-100p">
                                <tr runat="server">
                                    <td class="a-center" runat="server">
                                        <asp:GridView ID="GVhomecollectcancel" runat="server" AutoGenerateColumns="False"
                                            GridLines="Both" ForeColor="#333333" ShowFooter="true" OnRowDataBound="GVhomecollectcancel_OnRowDataBound"
                                            CssClass="mytable1 gridView w-96p m-auto" meta:resourcekey="gvIPCreditMainResource1">
                                            <HeaderStyle Font-Bold="True" CssClass="dataheader1" />
                                            <RowStyle HorizontalAlign="Left" />
                                            <Columns>
                                                <asp:TemplateField HeaderText="S.No">
                                                    <ItemStyle Width="50px" />
                                                    <ItemTemplate>
                                                        <%# Container.DataItemIndex + 1 %>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
												 <asp:BoundField DataField="BookingDate" HeaderText=" Booking Date & Time" meta:resourcekey="BoundFieldResource2">
                                                    <ItemStyle HorizontalAlign="Left" Wrap="true" Width="130px"></ItemStyle>
                                                </asp:BoundField>
												 <asp:BoundField DataField="BookedBy" HeaderText="Booked By" meta:resourcekey="BoundFieldResource2">
                                                    <ItemStyle HorizontalAlign="left" Wrap="true" CssClass="w-100"></ItemStyle>
                                                </asp:BoundField>
												  <asp:BoundField DataField="BookingID" HeaderText="Booking ID" meta:resourcekey="BoundFieldResource2">
                                                    <ItemStyle HorizontalAlign="Left" Wrap="true" CssClass="w-100"></ItemStyle>
                                                </asp:BoundField>
                                                <asp:BoundField DataField="PatientName" HeaderText=" Patient Name" meta:resourcekey="BoundFieldResource2">
                                                    <ItemStyle HorizontalAlign="Left" Wrap="true" Width="300px" CssClass="w-100"></ItemStyle>
                                                </asp:BoundField>
												  <asp:BoundField DataField="City" HeaderText="City">
                                                    <ItemStyle HorizontalAlign="left" Wrap="true" CssClass="w-100"></ItemStyle>
                                                </asp:BoundField>
                                                <asp:BoundField DataField="Name" HeaderText="Test Name" meta:resourcekey="BoundFieldResource2">
                                                    <ItemStyle HorizontalAlign="left" Wrap="true" Width="400px" CssClass="w-100"></ItemStyle>
                                                </asp:BoundField>
                                              
                                               
                                               
                                              
                                                <%--<asp:BoundField DataField="BillNumber" HeaderText="BillNumber">
                                                                            <ItemStyle HorizontalAlign="left" Wrap="False" Width="100px"></ItemStyle>
                                                                        </asp:BoundField>--%>
                                                <asp:BoundField DataField="CancelledBy" HeaderText="Cancelled By" meta:resourcekey="BoundFieldResource2">
                                                    <ItemStyle HorizontalAlign="left" Wrap="true" CssClass="w-100"></ItemStyle>
                                                </asp:BoundField>
                                                <asp:TemplateField HeaderText="Cancelled Date & Time">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblamount" runat="server" Text='<%# Eval("CancelledDate") %>' />
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Left" Wrap="true" Width="130"></ItemStyle>
                                                    <FooterTemplate>
                                                        <asp:Label ID="lbabeltot" Text="Total Amount:" runat="server" />
                                                    </FooterTemplate>
                                                    <FooterStyle HorizontalAlign="Left" Font-Bold="true" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Amount">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblamount" runat="server" Text='<%# Eval("Amount") %>' />
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Left" Wrap="true" Width="70px"></ItemStyle>
                                                    <FooterTemplate>
                                                        <asp:Label ID="lblTotal" runat="server" />
                                                    </FooterTemplate>
                                                    <FooterStyle HorizontalAlign="Left" Font-Bold="true" />
                                                </asp:TemplateField>
                                                <asp:BoundField DataField="ID" Visible="false" HeaderText="Investigationid" meta:resourcekey="BoundFieldResource2">
                                                    <ItemStyle HorizontalAlign="Right" Wrap="true" CssClass="w-100"></ItemStyle>
                                                </asp:BoundField>
                                            </Columns>
                                            <EmptyDataRowStyle CssClass="dataheader1"></EmptyDataRowStyle>
                                            <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                        </asp:GridView>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </td>
            </tr>
        </table>
    </div>
    <input id="hdnLoginID" runat="server" type="hidden" />
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    </form>
</body>

<script src="../Scripts/jquery.autocomplete.js" type="text/javascript"></script>

<script src="../Scripts/jquery-1.11.3.js" type="text/javascript"></script>

<script src="../Scripts/jquery-ui.js" type="text/javascript"></script>

</html>
