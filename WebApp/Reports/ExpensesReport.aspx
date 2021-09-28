<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ExpensesReport.aspx.cs" Inherits="Reports_ExpensesReport"
    meta:resourcekey="PageResource1" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Assembly="IdeaSparx.CoolControls.Web" Namespace="IdeaSparx.CoolControls.Web"
    TagPrefix="Grd" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link href="../Images/favicon.ico" rel="shortcut icon" />
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
<%--
    <script src="../Scripts/Common.js" type="text/javascript"></script>--%>

    <link type="text/css" href="../StyleSheets/jquery-ui-1.8.19.custom.css" rel="stylesheet" />
    <%-- <script src="../Scripts/jquery-1.2.6.js" type="text/javascript"></script>
    <script src="../Scripts/webtoolkit.jscrollable.js" type="text/javascript"></script>
    <script src="../Scripts/webtoolkit.scrollabletable.js" type="text/javascript"></script>
    <link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />  --%>
    <style type="text/css">
        .Grid
        {
            border: solid 1px #FFFFFF;
        }
        .Grid td
        {
            border: solid 1px #FFFFFF;
            margin: 1px 1px 1px 1px;
            padding: 1px 1px 1px 1px;
        }
        .GridHeader
        {
            font-weight: bold;
            font-size: larger;
            color: White;
            background-color: #3093cf;
        }
        .GridItem
        {
            background-color: #e6e6e6;
        }
        .GridAltItem
        {
            background-color: #3093cf;
        }
        .ui-datepicker
        {
            font-size: 8pt !important;
        }
    </style>
    <%-- <style type="text/css">
        .FixedHeader
        {
            overflow: auto;
            height: 150px;
        }
        table th
        {
            border-width: 2px;
            position: relative;
            top: expression(this.parentNode.parentNode.parentNode.scrollTop-1);
        }
        .Freezing
        {
            position: relative;
            top: expression(this.offsetParent.scrollTop);
            z-index: 10;
        }
    </style>--%>
    <%-- <style type="text/css">
                  table {                       
                        font: normal 11px "Trebuchet MS", Verdana, Arial;                                               
                      background:#fff;                                  
                      border:solid 1px #C2EAD6;
                  }                 
                  
                  td{                   
                  padding: 3px 3px 3px 6px;
                  color: #5D829B;
                  }
                  th {
                        font-weight:bold;
                        font-size:smaller;
                  color: #5D728A;                                             
                  padding: 0px 3px 3px 6px;
                  background: #CAE8EA                       
                  }
            </style>--%>

    <script language="javascript" type="text/javascript">
        function clearContextText() {
            $('#tblContent').hide();

        }
        function validate() {
            if (document.getElementById('hdnXLFlag').value != '1' || document.getElementById('grdDynamic').value == 'undefined') {
                alert('No Records to Export');
                return false;
            }
        }
        function checkAll(obj1) {
            var checkboxCollection = document.getElementById('chklstusers').getElementsByTagName('input');

            for (var i = 0; i < checkboxCollection.length; i++) {
                if (checkboxCollection[i].type.toString().toLowerCase() == "checkbox") {
                    checkboxCollection[i].checked = obj1.checked;
                }
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
        
        function checkAllLoad() {
            var checkboxCollection = document.getElementById('chklstusers').getElementsByTagName('input');
            document.getElementById('Chkboxusers').checked = true;
            for (var i = 0; i < checkboxCollection.length; i++) {
                if (checkboxCollection[i].type.toString().toLowerCase() == "checkbox") {
                    checkboxCollection[i].checked = true;
                }
            }
        }
        
       
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="scriptManager1" AsyncPostBackTimeout="10" runat="server">
    </asp:ScriptManager>
            <Attune:Attuneheader ID="Attuneheader" runat="server" />
                    <div class="contentdata">
           
                        <script type="text/javascript">

                            $(function() {
                                $("#txtFDate").datepicker({
                                    dateFormat: 'dd/mm/yy',
                                    defaultDate: "+1w",
                                    changeMonth: true,
                                    changeYear: true,
                                    maxDate: 0,
                                    yearRange: '1900:2100',
                                    onClose: function(selectedDate) {
                                        $("#txtTDate").datepicker("option", "minDate", selectedDate);

                                        var date = $("#txtFrom").datepicker('getDate');
                                        //var d = new Date(date.getFullYear(), date.getMonth() + 1, 0);
                                        // $("#txtTo").datepicker("option", "maxDate", d);

                                    }
                                });
                                $("#txtTDate").datepicker({
                                    dateFormat: 'dd/mm/yy',
                                    defaultDate: "+1w",
                                    changeMonth: true,
                                    changeYear: true,
                                    maxDate: 0,
                                    yearRange: '1900:2100',
                                    onClose: function(selectedDate) {
                                        $("#txtFDate").datepicker("option", "maxDate", selectedDate);
                                    }
                                })
                            });

                        </script>

                        <table id="tblCollectionOPIP" class="a-center w-100p">
                            <tr class="a-center">
                                <td class="a-left">
                                    <div class="dataheaderWider" style="z-index: 90;">
                                        <table id="casip" class="w-100p">
                                            <tr id="trTrustedOrg" runat="server" style="display: table-row;">
                                                <td>
                                                    <asp:Label ID="lblOrgs" runat="server" Text="Select Org" meta:resourcekey="lblOrgsResource1"></asp:Label>
                                                    &nbsp;
                                                    <asp:DropDownList ID="ddlTrustedOrg" onchange="javascript:clearContextText();" AutoPostBack="true"
                                                        runat="server" CssClass="ddl" OnSelectedIndexChanged="ddlTrustedOrg_SelectedIndexChanged">
                                                    </asp:DropDownList>
                                                </td>
                                                <td>
                                                    <asp:Label ID="Rs_Location" runat="server" Visible="false"  Text="Location" meta:resourcekey="Rs_LocationResource1"></asp:Label>
                                                &nbsp;
                                                    <asp:DropDownList  CssClass="ddlsmall" Visible ="false"  runat="server" ID="ddlLocation"                                                       
                                                        meta:resourcekey="ddLOResource1">
                                                    </asp:DropDownList>
                                                </td>
                                                <td class="a-left">
                                                    <asp:Label ID="Rs_FromDate" Text="From Date :" runat="server" meta:resourcekey="Rs_FromDateResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtFDate" CssClass="Txtboxsmall" Width="70px" runat="server"></asp:TextBox>
                                                    <%--  <ajc:CalendarExtender ID="CalendarExtender1" runat="server" Format="dd/MM/yyyy" PopupButtonID="ImgFDate"
                                                        TargetControlID="txtFrom" Enabled="True" />
                                                    <asp:ImageButton ID="ImgFDate" runat="server" CausesValidation="False" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                        meta:resourcekey="ImgFDateResource1" />
                                                    <ajc:MaskedEditExtender ID="MaskedEditExtender5" runat="server" ErrorTooltipEnabled="True"
                                                        Mask="99/99/9999" MaskType="Date" TargetControlID="txtFrom" CultureAMPMPlaceholder=""
                                                        CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                                                        CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                                                        Enabled="True" />
                                                    <ajc:MaskedEditValidator ID="MaskedEditValidator5" runat="server" ControlExtender="MaskedEditExtender5"
                                                        ControlToValidate="txtFrom" Display="Dynamic" EmptyValueBlurredText="*" EmptyValueMessage="Date is required"
                                                        InvalidValueBlurredMessage="*" InvalidValueMessage="Date is invalid" TooltipMessage="(dd-mm-yyyy)"
                                                        ValidationGroup="MKE" ErrorMessage="MaskedEditValidator5" meta:resourcekey="MaskedEditValidator5Resource1" />--%>
                                                </td>
                                                <td>
                                                    <asp:Label ID="Rs_ToDate" Text="To Date:" runat="server" meta:resourcekey="Rs_ToDateResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtTDate" CssClass="Txtboxsmall" Width="70px" runat="server"></asp:TextBox>
                                                    <%-- <ajc:CalendarExtender ID="CalendarExtender2" runat="server" Format="dd/MM/yyyy" PopupButtonID="ImgTDate"
                                                        TargetControlID="txtTo" Enabled="True" />
                                                    <asp:ImageButton ID="ImgTDate" runat="server" CausesValidation="False" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                        meta:resourcekey="ImgTDateResource1" />
                                                    <ajc:MaskedEditExtender ID="MaskedEditExtender6" runat="server" ErrorTooltipEnabled="True"
                                                        Mask="99/99/9999" MaskType="Date" TargetControlID="txtTo" CultureAMPMPlaceholder=""
                                                        CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                                                        CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                                                        Enabled="True" />
                                                    <ajc:MaskedEditValidator ID="MaskedEditValidator1" runat="server" ControlExtender="MaskedEditExtender6"
                                                        ControlToValidate="txtTo" Display="Dynamic" EmptyValueBlurredText="*" EmptyValueMessage="Date is required"
                                                        InvalidValueBlurredMessage="*" InvalidValueMessage="Date is invalid" TooltipMessage="(dd-mm-yyyy)"
                                                        ValidationGroup="MKE" ErrorMessage="MaskedEditValidator1" meta:resourcekey="MaskedEditValidator1Resource1" />--%>
                                                </td>
                                                <td class="a-right">
                                                    <asp:Button ID="btnSubmit" runat="server" CssClass="btn" onmouseout="this.className='btn'"
                                                        onmouseover="this.className='btn btnhov'" Text="Get Report" OnClick="btnSubmit_Click"
                                                        meta:resourcekey="btnSubmitResource1" />
                                                </td>
                                                <td class="a-right">
                                                    <asp:LinkButton ID="lnkBack" Text="Back" Font-Underline="True" runat="server" CssClass="details_label_age"
                                                        OnClick="lnkBack_Click" meta:resourcekey="lnkBackResource1"></asp:LinkButton>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Panel ID="pHeader" runat="server" CssClass="cpHeader" meta:resourcekey="pHeaderResource1">
                                        <table>
                                            <tr>
                                                <td>
                                                    <asp:Image ID="ImgCollapse" runat="server" meta:resourcekey="ImgCollapseResource1" />
                                                </td>
                                                <td>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblText" runat="server" meta:resourcekey="lblTextResource1" />
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                    <asp:Panel ID="pBody" runat="server" CssClass="cpBody" meta:resourcekey="pBodyResource1">
                                        <table class="w-100p">
                                            <tr>
                                                <td>
                                                    <asp:CheckBoxList ID="chkPurpose" runat="server">
                                                    </asp:CheckBoxList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="a-right">
                                                    <asp:Button ID="btnUpdateFilter" runat="server" CssClass="btn" onmouseout="this.className='btn'"
                                                        onmouseover="this.className='btn btnhov'" Text="Ok" OnClick="btnSubmit_Click"
                                                        meta:resourcekey="btnUpdateFilterResource1" />
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                    <ajc:CollapsiblePanelExtender ID="CollapsiblePanelExtender1" runat="server" TargetControlID="pBody"
                                        CollapseControlID="pHeader" ExpandControlID="pHeader" Collapsed="True" TextLabelID="lblText"
                                        CollapsedText="Show Filter" ExpandedText="Hide Filter" ImageControlID="ImgCollapse"
                                        ExpandedImage="../images/collapse.jpg" CollapsedImage="../images/expand.jpg"
                                        Enabled="True" meta:resourcekey="CollapsiblePanelExtender1Resource1">
                                    </ajc:CollapsiblePanelExtender>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Panel ID="Panel1" runat="server" CssClass="cpHeader">
                                        <table>
                                            <tr>
                                                <td>
                                                    <asp:Image ID="Image1" runat="server" />
                                                </td>
                                                <td>
                                                </td>
                                                <td>
                                                    <asp:Label ID="Label1" runat="server" meta:resourcekey="Label1Resource1"/>
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                    <asp:Panel ID="Panel2" runat="server" CssClass="cpBody w-100p">
                                        <table class="w-100p">
                                            <tr>
                                                <td>
                                                    <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                                                        <ContentTemplate>
                                                            <asp:CheckBox ID="Chkboxusers" Text="ALL" runat="server" CssClass="smallfon" onclick="checkAll(this)"
                                                                Checked="false" />
                                                            <asp:CheckBoxList ID="chklstusers" runat="server" RepeatColumns="6 " RepeatDirection="Horizontal"
                                                                RepeatLayout="Table" CssClass="smallfon">
                                                            </asp:CheckBoxList>
                                                        </ContentTemplate>
                                                        <Triggers>
                                                            <asp:AsyncPostBackTrigger ControlID="ddlTrustedOrg" EventName="SelectedIndexChanged" />
                                                        </Triggers>
                                                    </asp:UpdatePanel>
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                    <ajc:CollapsiblePanelExtender ID="CollapsiblePanelExtender2" runat="server" TargetControlID="Panel2"
                                        CollapseControlID="Panel1" ExpandControlID="Panel1" Collapsed="True" TextLabelID="Label1"
                                        CollapsedText="Show Users List" ExpandedText="Hide Users List" ImageControlID="Image1"
                                        ExpandedImage="../images/collapse.jpg" CollapsedImage="../images/expand.jpg"
                                        Enabled="True" meta:resourcekey="CollapsiblePanelExtender2Resource1">
                                    </ajc:CollapsiblePanelExtender>
                                </td>
                            </tr>
                            <tr id="trError" runat="server">
                                <td class="dataheaderWider" align="center">
                                    <table class="w-100p">
                                        <tr>
                                            <td>
                                                <asp:Label ID="lblResult" ForeColor="#000333" runat="server" meta:resourcekey="lblResultResource1"></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                        <table class="w-100p" id="tblContent">
                            <tr>
                                <td class="a-center">
                                    <asp:ImageButton ID="imgBtnXL" OnClientClick="return validate();" runat="server"
                                        ImageUrl="../Images/ExcelImage.GIF" ToolTip="Save As Excel" OnClick="imgBtnXL_Click"
                                        meta:resourcekey="imgBtnXLResource1" />
                                    <asp:LinkButton ID="lnkExportXL" Text="Export To XL" Font-Underline="True" OnClientClick="return validate();"
                                        runat="server" Font-Bold="True" Font-Size="12px" ForeColor="Black" ToolTip="Save As Excel"
                                        OnClick="lnkExportXL_Click" meta:resourcekey="lnkExportXLResource1"></asp:LinkButton>
                                    <input type="hidden" runat="server" value="0" id="hdnXLFlag" />
                                     <asp:ImageButton ID="btnPrint" runat="server" ImageUrl="~/Images/printer.gif" OnClientClick="return popupprint();"
                                                            ToolTip="Print" meta:resourcekey="btnPrintResource1" />
                                                            <b id="printText" runat="server">
                                                            <asp:LinkButton ID="lnkPrint" Text="Print Report" Font-Underline="True" OnClientClick="return popupprint();"
                                        runat="server" Font-Bold="True" Font-Size="12px" ForeColor="Black" ToolTip="Save As Excel"
                                        meta:resourcekey="lnkExportXLResource2"></asp:LinkButton></b>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <table class="w-90p">
                                        <tr>
                                            <td class="a-center">
                                                <%--<div id="Panel1" class="FixedHeader" style="border-top-width: thick; overflow-y: scroll;
                                                    border-bottom-width: thick; width: 850px; height: 350px">--%>
                                                <table class="w-100p" rules="all" style="border-collapse: collapse" id="tblgrdDynamic"
                                                    runat="server">
                                                    <tr>
                                                        <td class="a-left">
                                                            <%--<asp:Panel ID="pnlWrapper" runat="server" Height="200px" Width="300px" ScrollBars="Vertical">--%>
                                                            <Grd:CoolGridView FixHeaders="True" runat="server" DefaultColumnWidth="80px"
                                                                ShowFooter="True" CssClass="Grid gridView w-100p" ID="grdDynamic" ForeColor="#333333"
                                                                 OnRowDataBound="grdDynamic_RowDataBound" meta:resourcekey="grdDynamicResource1">
                                                                <BoundaryStyle BorderColor="Gray" BorderWidth="1px" BorderStyle="Solid"></BoundaryStyle>
                                                                <HeaderStyle CssClass="dataheader1" />
                                                            </Grd:CoolGridView>
                                                            <%-- </asp:Panel>--%>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="a-left">
                                                            <asp:Label ID="lblTotalExpense" runat="server" meta:resourcekey="lblTotalExpenseResource1"></asp:Label>
                                                        </td>
                                                    </tr>
                                                </table>
                                                <%-- </div>--%>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </div>
            <Attune:Attunefooter ID="Attunefooter" runat="server" />   
    </form>
</body>
</html>
