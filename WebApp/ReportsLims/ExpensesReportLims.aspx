<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ExpensesReportLims.aspx.cs" Inherits="ReportsLims_ExpanseReport"
    meta:resourcekey="PageResource1" %>

<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
    <%@ Register Src="../CommonControls/NewDateTimePicker.ascx" TagName="DateTimePicker"
   TagPrefix="DateTimePicker" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link href="../Images/favicon.ico" rel="shortcut icon" />
    <link type="text/css" href="../StyleSheets/jquery-ui-1.8.19.custom.css" rel="stylesheet" />
    <style type="text/css" >
        .grid-scroll
        {
            min-height: 100px;
            max-height: 300px;
            overflow-y: auto;
            overflow-x: hidden;
        }
        .ui-datepicker
        {
            font-size: 8pt !important;
        }
    </style>

    <script src="../Scripts/datetimepicker.js" type="text/javascript"></script>
    <script language="javascript" type="text/javascript">
        function Search_Gridview(strKey, strGV) {
            var strData = strKey.value.toLowerCase().split(" ");
            var tblData = document.getElementById(strGV);
            var rowData;
            for (var i = 1; i < tblData.rows.length; i++) {
                rowData = tblData.rows[i].innerHTML;

                // x = "grdPendingDetails_ctl" + i + "_chkreport";
                //document.getElementById(x).checked = false;
                var styleDisplay = 'none';
                for (var j = 0; j < strData.length; j++) {
                    if (rowData.toLowerCase().indexOf(strData[j]) >= 0)
                        styleDisplay = '';
                    else {
                        styleDisplay = 'none';
                        break;
                    }
                }
                tblData.rows[i].style.display = styleDisplay;

            }
        }
        function popupprint() {
            var prtContent = document.getElementById('tblgrdDynamic');
            var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,status=0');
            //alert(WinPrint);
            WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
            WinPrint.close();
        }
        
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="scriptManager1" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
      <script type="text/javascript">
          /*  $(function() {
          $("#txtFDate").datepicker({
          changeMonth: true,
          changeYear: true,
          maxDate: 0,
          yearRange: '2008:2030'
          });
          $("#txtTDate").datepicker({
          changeMonth: true,
          changeYear: true,
          maxDate: 0,
          yearRange: '2008:2030'
          })
          });*/
          $(function() {
          $("#txtValidFrom").datepicker({
                  dateFormat: 'dd/mm/yy',
                  defaultDate: "+1w",
                  changeMonth: true,
                  changeYear: true,
                  maxDate: 0,
                  yearRange: '1900:2100',
                  onClose: function(selectedDate) {
                  $("#txtValidTo").datepicker("option", "minDate", selectedDate);

                      var date = $("#txtValidFrom").datepicker('getDate');
                      //var d = new Date(date.getFullYear(), date.getMonth() + 1, 0);
                      // $("#txtTo").datepicker("option", "maxDate", d);

                  }
              });
              $("#txtValidTo").datepicker({
                  dateFormat: 'dd/mm/yy',
                  defaultDate: "+1w",
                  changeMonth: true,
                  changeYear: true,
                  maxDate: 0,
                  yearRange: '1900:2100',
                  onClose: function(selectedDate) {
                  $("#txtValidFrom").datepicker("option", "maxDate", selectedDate);
                  }
              })
          });
          function clearContextText() {
              $('#contentArea').hide();

          }
                        </script>
    <table id="tblCollectionOPIP" class="w-100p">
        <tr>
            <asp:UpdatePanel ID="updatePanel1" runat="server">
                <ContentTemplate>
                    <td>
                        <div class="dataheaderWider">
                            <table id="tbl" class="w-100p a-center">
                                <tr>
                                    <td>
                                        <asp:Label ID="lblRepType" runat="server" Text="Report Type "></asp:Label>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="drpRepType" Width="180px" runat="server" CssClass="ddl">
                                        </asp:DropDownList>
                                    </td>
                                    <td>
                                        <asp:Label ID="Label1" runat="server" Text="From Date & Time :"></asp:Label>
                                    </td>
                                    <td>
                                        <%--<asp:TextBox runat="server" ID="txtValidFrom" MaxLength="10" size="25" CssClass="Txtboxsmall"
                                            meta:resourcekey="txtFromDateResource1"></asp:TextBox>
                                        <ajc:CalendarExtender ID="CalendarExtender1" Format="dd/MMM/yyyy" runat="server"
                                            TargetControlID="txtValidFrom" PopupButtonID="ImgBntCalc" Enabled="True" />
                                        &nbsp;<asp:Image runat="server" ID="ImgBntCalc1" ImageUrl="~/Images/Calendar_scheduleHS.png"
                                            Width="16px" Height="16px" border="0" alt="Pick from date" meta:resourcekey="ImgBntCalcResource1" />--%>
                                            <asp:TextBox ID="txtValidFrom" CssClass="Txtboxsmall" Width="160px" runat="server" meta:resourcekey="txtFDateResource1"></asp:TextBox>
                                             &nbsp;<asp:Image runat="server" ID="ImgBntCalc1" ImageUrl="~/Images/Calendar_scheduleHS.png"
                                            Width="16px" Height="16px" border="0" alt="Pick from date" meta:resourcekey="ImgBntCalcResource1" />
                                            <img src="../Images/starbutton.png" alt="" align="middle" />
                                    </td>
                                    <td>
                                        <asp:Label ID="lbto" runat="server" Text="To Date & Time :" meta:resourcekey="lbtoResource1"></asp:Label>
                                    </td>
                                    <td>
                                        <%--<asp:TextBox runat="server" ID="txtValidTo" MaxLength="10" CssClass="Txtboxsmall"
                                            meta:resourcekey="txtToDateResource1"></asp:TextBox>
                                        <ajc:CalendarExtender ID="CalendarExtender2" runat="server" Format="dd/MMM/yyyy"
                                            PopupButtonID="ImgToDate" TargetControlID="txtValidTo" Enabled="True" />
                                        &nbsp;<asp:Image runat="server" ID="ImgToDate2" ImageUrl="~/Images/Calendar_scheduleHS.png"
                                            Width="16px" Height="16px" AlternateText="Pick to date" meta:resourcekey="ImgToDateResource1" />--%>
                                             <asp:TextBox ID="txtValidTo" CssClass="Txtboxsmall" Width="160px" runat="server" meta:resourcekey="txtFDateResource1"></asp:TextBox>
                                              &nbsp;<asp:Image runat="server" ID="Image1" ImageUrl="~/Images/Calendar_scheduleHS.png"
                                            Width="16px" Height="16px" border="0" alt="Pick from date" meta:resourcekey="ImgBntCalcResource1" />
                                            <img src="../Images/starbutton.png" alt="" align="middle" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblOrg" runat="server" Text="Select Org "></asp:Label>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="drpOrg" Width="180px" runat="server" CssClass="ddl">
                                        </asp:DropDownList>
                                        <img src="../Images/starbutton.png" alt="" align="middle" />
                                    </td>
                                    <td>
                                        <asp:Label ID="lblUserName" runat="server" Text="User Name "></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox runat="server" ID="txtUserName"></asp:TextBox>
                                        <ajc:AutoCompleteExtender ID="AutoGname1" runat="server" TargetControlID="txtUserName"
                                            ServiceMethod="getUserNames" ServicePath="~/WebService.asmx" EnableCaching="False"
                                            MinimumPrefixLength="2" BehaviorID="AutoCompleteExLstGrp11" CompletionInterval="30"
                                            DelimiterCharacters=";,:" CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                            CompletionListHighlightedItemCssClass="wordWheel itemsSelected" Enabled="True">
                                        </ajc:AutoCompleteExtender>
                                    </td>
                                    <td>
                                        <asp:ImageButton ID="imgBtnXL" runat="server" ImageUrl="../Images/ExcelImage.GIF"
                                            ToolTip="Save As Excel" meta:resourcekey="imgBtnXLResource1" />
                                        <asp:LinkButton ID="lnkExportXL" Text="Export To XL" Font-Underline="True" runat="server"
                                            OnClick="lnkExportXL_Click" Font-Bold="True" Font-Size="12px" ForeColor="Black"
                                            ToolTip="Save As Excel" meta:resourcekey="lnkExportXLResource1"></asp:LinkButton>
                                        <input type="hidden" runat="server" value="0" id="hdnXLFlag" />
                                    </td>
                                    <td>
                                        <asp:ImageButton ID="btnPrint" runat="server" ImageUrl="~/Images/printer.gif" ToolTip="Print"
                                            OnClientClick="return popupprint();" meta:resourcekey="btnPrintResource1" />
                                        <b id="printText" runat="server">
                                            <asp:LinkButton ID="lnkPrint" Text="Print Report" Font-Underline="True" runat="server"
                                                OnClientClick="return popupprint();" Font-Bold="True" Font-Size="12px" ForeColor="Black"
                                                ToolTip="Save As Excel" meta:resourcekey="lnkExportXLResource2"></asp:LinkButton></b>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                    </td>
                                    <td>
                                    </td>
                                    <td>
                                    </td>
                                    <td>
                                        <div align="left">
                                            <asp:Button ID="btnSubmit"  runat="server" CssClass="btn" onmouseout="this.className='btn'"
                                                onmouseover="this.className='btn btnhov'" Text="Get Report" OnClick="btnSubmit_Click"
                                                meta:resourcekey="btnSubmitResource1" /></div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:TextBox ID="txtSearchSummary" placeholder="Search" Visible="false" runat="server" onkeyup="Search_Gridview(this, 'grdSummary')"></asp:TextBox>
                                        <asp:TextBox ID="txtSearchDeatils" placeholder="Search" Visible="false" runat="server" onkeyup="Search_Gridview(this, 'grdPendingDetails')"></asp:TextBox>
                                    </td>
                                </tr>
                                
                                <tr>
                                    <td colspan="6">
                                    <div class="grid-scroll">
                                        <table class="w-100p gridView" rules="all" style="border-collapse: collapse" id="tblgrdDynamic"
                                            runat="server">
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblTotalExpense" runat="server" Font-Bold="true"></asp:Label>
                                                </td>                                             
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:GridView ID="grdPendingDetails" runat="server" AutoGenerateColumns="false" CssClass="gridView w-100p"
                                                        meta:resourceKey="grdPendingDetailsResource1">
                                                        <Columns>
                                                            <%--<asp:TemplateField HeaderText="S.No" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                        <HeaderStyle CssClass="text-center" VerticalAlign="middle" />
                                        <ItemStyle HorizontalAlign="center" VerticalAlign="middle" />
                                        <ItemTemplate>
                                            <%# Container.DataItemIndex+1%>
                                        </ItemTemplate>
                                    </asp:TemplateField>--%>
                                                            <asp:TemplateField HeaderText="S.No.">
                                                                <ItemTemplate>
                                                                    <%# Container.DataItemIndex + 1 %>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:BoundField DataField="OrgName" HeaderText="OrgName" meta:resourceKey="BoundFieldResource3">
                                                                <HeaderStyle CssClass="text-center" VerticalAlign="middle" />
                                                                <ItemStyle HorizontalAlign="center" VerticalAlign="middle" />
                                                            </asp:BoundField>
                                                            <%--<asp:TemplateField HeaderText="YEAR" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="left">
                                        <ItemTemplate>
                                            <asp:Label ID="lblYEAR" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "YEAR")%>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>--%>
                                                            <asp:BoundField DataField="UserName" HeaderText="UserName" meta:resourceKey="BoundFieldResource3">
                                                                <HeaderStyle CssClass="text-center" VerticalAlign="middle" />
                                                                <ItemStyle HorizontalAlign="center" VerticalAlign="middle" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="Amount" HeaderText="Amount" meta:resourceKey="BoundFieldResource3">
                                                                <HeaderStyle CssClass="text-center" VerticalAlign="middle" />
                                                                <ItemStyle HorizontalAlign="center" VerticalAlign="middle" />
                                                            </asp:BoundField>
                                                        </Columns>
                                                    </asp:GridView>
                                                    <asp:GridView ID="grdSummary" runat="server" AutoGenerateColumns="false" CssClass="gridView w-100p">
                                                        <Columns>
                                                            <%--<asp:TemplateField HeaderText="S.No" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                        <HeaderStyle CssClass="text-center" VerticalAlign="middle" />
                                        <ItemStyle HorizontalAlign="center" VerticalAlign="middle" />
                                        <ItemTemplate>
                                            <%# Container.DataItemIndex+1%>
                                        </ItemTemplate>
                                    </asp:TemplateField>--%>
                                                            <asp:TemplateField HeaderText="S.No.">
                                                                <ItemTemplate>
                                                                    <%# Container.DataItemIndex + 1 %>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:BoundField DataField="UserName" HeaderText="UserName" meta:resourceKey="BoundFieldResource3">
                                                                <HeaderStyle CssClass="text-center" VerticalAlign="middle" />
                                                                <ItemStyle HorizontalAlign="center" VerticalAlign="middle" />
                                                            </asp:BoundField>
                                                            <%--<asp:TemplateField HeaderText="YEAR" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="left">
                                        <ItemTemplate>
                                            <asp:Label ID="lblYEAR" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "YEAR")%>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>--%>
                                                            <asp:BoundField DataField="VoucherNumber" HeaderText="VoucherNumber" meta:resourceKey="BoundFieldResource3">
                                                                <HeaderStyle CssClass="text-center" VerticalAlign="middle" />
                                                                <ItemStyle HorizontalAlign="center" VerticalAlign="middle" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="Amount" HeaderText="Amount" meta:resourceKey="BoundFieldResource3">
                                                                <HeaderStyle CssClass="text-center" VerticalAlign="middle" />
                                                                <ItemStyle HorizontalAlign="center" VerticalAlign="middle" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="ModeOfPayment" HeaderText="ModeOfPayment" meta:resourceKey="BoundFieldResource3">
                                                                <HeaderStyle CssClass="text-center" VerticalAlign="middle" />
                                                                <ItemStyle HorizontalAlign="center" VerticalAlign="middle" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="PaidTo" HeaderText="PaidTo" meta:resourceKey="BoundFieldResource3">
                                                                <HeaderStyle CssClass="text-center" VerticalAlign="middle" />
                                                                <ItemStyle HorizontalAlign="center" VerticalAlign="middle" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="CreatedOn" HeaderText="CreatedOn" DataFormatString="{0:dd/MM/yyyy}" meta:resourceKey="BoundFieldResource3">
                                                                <HeaderStyle CssClass="text-center" VerticalAlign="middle" />
                                                                <ItemStyle HorizontalAlign="center" VerticalAlign="middle" />
                                                            </asp:BoundField>
                                                        </Columns>
                                                    </asp:GridView>
                                                </td>
                                            </tr>
                                        </table>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                   <td><asp:Label ID="lblfound" runat="server"></asp:Label></td> </tr>
                        </div>
                        </table>
                    </td>
                </ContentTemplate>
            </asp:UpdatePanel>
        </tr>
    </table>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    </form>
</body>
</html>
