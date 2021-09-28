<%@ Page Language="C#" AutoEventWireup="true" CodeFile="BulkRateCardApply.aspx.cs"
    Inherits="Billing_BulkRateCardApply" EnableEventValidation="false" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%--<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/PatientHeader.ascx" TagName="PatientHeader" TagPrefix="uc8" %>--%>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/DynamicDHEBAdder.ascx" TagName="OtherPayments"
    TagPrefix="uc14" %>
<%@ Register Src="../CommonControls/PaymentTypeDetails.ascx" TagName="PaymentType"
    TagPrefix="uc15" %>
<%@ Register Src="../CommonControls/OtherCurrencyReceived.ascx" TagName="OtherCurrencyDisplay"
    TagPrefix="uc21" %>
<%--<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>--%>
<%@ Register Src="../CommonControls/DateSelection.ascx" TagName="DateSelection" TagPrefix="DateCtrl" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Collections</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
    <%--<link href="../StyleSheets/StyleSheet.css" rel="Stylesheet" type="text/css" />--%>
    <%--   <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <link type="text/css" href="../StyleSheets/jquery-ui-1.8.19.custom.css" rel="stylesheet" />

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script src="../Scripts/bid.js" type="text/javascript"></script>--%>

    <script src="../Scripts/animatedcollapse.js" type="text/javascript"></script>

    <%--   <script src="../Scripts/jquery-1.2.2.pack.js" type="text/javascript"></script>--%>
    <link href="../StyleSheets/DHEBAdder.css" rel="Stylesheet" type="text/css" />

    <script src="../Scripts/QuickBill.js" type="text/javascript"></script>

    <script src="../Scripts/MessageHandler.js" type="text/javascript"></script>

    <script src="../Scripts/JsonScript.js" language="javascript" type="text/javascript"></script>

    <script src="../Scripts/jquery.MultiFile.js" type="text/javascript"></script>

    <%--    <script src="../Scripts/jquery-1.3.2.js" type="text/javascript"></script>--%>
    <style type="text/css">
        #ddlcredit
        {
            width: 60%;
        }
    </style>

    <script type="text/javascript" language="javascript">

        function expandDropDownList1(elementRef) {
            elementRef.style.width = '550px';
        }

        function collapseDropDownList(elementRef) {
            elementRef.style.width = elementRef.normalWidth;
        }
    </script>

</head>
<body oncontextmenu="return false;">
    <form id="form1" runat="server">
    <asp:ScriptManager ID="scrpt" runat="server">
        <Services>
            <asp:ServiceReference Path="~/WebService.asmx" />
        </Services>
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
        <asp:UpdatePanel ID="UdtPanel" UpdateMode="Conditional" runat="server">
            <ContentTemplate>
                <table class="w-100p searchPanel">
                    <tr>
                        <td>
                            <table class="dataheaderInvCtrl w-100p">
                                <tr>
                                    <td>
                                        <asp:Label ID="Rs_From" Text="From Date" runat="server"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox runat="server" ID="txtFrom" CssClass="small" MaxLength="25" size="20"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:Label ID="Rs_To" Text="To Date" runat="server"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox runat="server" ID="txtTo" MaxLength="25" CssClass="small" size="20"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblClient" runat="server" Text="Client Name"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtClientNameSrch" runat="server" MaxLength="40" CssClass="small"
                                            AutoComplete="off"></asp:TextBox>
                                        <ajc:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" TargetControlID="txtClientNameSrch"
                                            CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                            CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" EnableCaching="False"
                                            MinimumPrefixLength="1" CompletionInterval="1" FirstRowSelected="True" ServiceMethod="GetHospAndRefPhy"
                                            OnClientItemSelected="OnselectedClientName" ServicePath="~/WebService.asmx" DelimiterCharacters=""
                                            Enabled="True" UseContextKey="True">
                                        </ajc:AutoCompleteExtender>
                                    </td>
                                    <td>
                                        <asp:Button ID="btnsearch" runat="server" CssClass="btn w-50" Text="Go" OnClick="btnsearch_Click" />
                                    </td>
                                    <td>
                                        &nbsp;
                                    </td>
                                </tr>
                            </table>
                            <table class="w-100p">
                                <tr>
                                    <td>
                                        <asp:Panel ID="panelDispatchType" runat="server" CssClass="dataheaderInvCtrl w-100p"
                                            Font-Bold="true" Style="display: none">
                                            <table>
                                                <tr>
                                                    <td class="v-top" nowrap="nowrap">
                                                        <asp:Label ID="lblInvoiceDetails" runat="server" Text="Invoiced Numbers"></asp:Label>
                                                    </td>
                                                    <td class="v-top" nowrap="nowrap" colspan="2">
                                                        <asp:RadioButtonList ID="chkInvoice" runat="server" AutoPostBack="true" OnSelectedIndexChanged="chkInvoice_SelectedIndexChanged">
                                                        </asp:RadioButtonList>
                                                        <%-- <asp:CheckBoxList ID="chkInvoice" runat="server">
                                                                </asp:CheckBoxList>--%>
                                                    </td>
                                                </tr>
                                                <tr id="trrateCard" style="display: table-row" runat="server">
                                                    <td nowrap="nowrap">
                                                        <asp:Label ID="lblrateCrdname" runat="server" Text="RateCard Mapped With Clients"></asp:Label>
                                                    </td>
                                                    <td class="v-top" nowrap="nowrap">
                                                        <asp:CheckBoxList ID="ChkRateNameForClient" runat="server">
                                                        </asp:CheckBoxList>
                                                    </td>
                                                    <td>
                                                        <asp:Button ID="btnOk" Style="display: none" runat="server" CssClass="btn w-50" Text="Go"
                                                            OnClick="btnOk_Click" OnClientClick="return Validate()" />
                                                    </td>
                                                    <td nowrap="nowrap">
                                                        <asp:Label ID="lblratename" runat="server" Text="New RateCard Name"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <span class="richcombobox" style="width: 130px;">
                                                            <asp:DropDownList ID="ddlratecardname" runat="server" CssClass="ddlsmall">
                                                            </asp:DropDownList>
                                                        </span>
                                                    </td>
                                                    <td>
                                                        <asp:Button ID="btnApply" runat="server" CssClass="btn w-50" Text="Search" OnClick="btnApply_Click"
                                                            OnClientClick="return Validate()" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </asp:Panel>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                    </td>
                                </tr>
                                <tr id="trGrdBulkRate" runat="server" style="display: none">
                                    <td>
                                        <asp:GridView ID="GrdBulkRate" CssClass="gridView w-100p h-12p" runat="server" AutoGenerateColumns="False"
                                            PagerStyle-ForeColor="Black">
                                            <Columns>
                                                <asp:TemplateField HeaderText="Bill Number" ItemStyle-Width="5%" ItemStyle-HorizontalAlign="left">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblptvisID" runat="server" Text='<%#bind("BillNo")%>'></asp:Label>
                                                        <asp:HiddenField ID="hdnbulkrateID" runat="server" Value='<%# bind("BulckRateUpdateID") %>' />
                                                        <asp:HiddenField ID="hdnVisitNumber" runat="server" Value='<%# bind("VisitNo") %>' />
                                                        <asp:HiddenField ID="hdnOldAmount" runat="server" Value='<%# bind("OldAmount") %>' />
                                                        <asp:HiddenField ID="hdnNewAmount" runat="server" Value='<%# bind("NewAmount") %>' />
                                                        <asp:HiddenField ID="hdnnbillno" runat="server" Value='<%# bind("BillNo") %>' />
                                                        <asp:HiddenField ID="hdnFinalBillID" runat="server" Value='<%# bind("FinalbillID") %>' />
                                                        <asp:HiddenField ID="hdnInvoiceID" runat="server" Value='<%# bind("InvoiceID") %>' />
                                                        <asp:HiddenField ID="hdntotbillamount" runat="server" Value='<%# bind("TotBillAmt") %>' />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Visit Number" ItemStyle-Width="6%" ItemStyle-HorizontalAlign="left">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblpatno" runat="server" Text='<%#bind("VisitNo")%>'></asp:Label></ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Billed Amount" ItemStyle-Width="6%" ItemStyle-HorizontalAlign="left">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblbillamt" runat="server" DataFormatString="{0:0.00}" Text=' <%# DataBinder.Eval(Container.DataItem, "TotBillAmt","{0:0.00}") %>'></asp:Label></ItemTemplate>
                                                </asp:TemplateField>
                                                <%--<asp:TemplateField HeaderText="Old Rate Name" ItemStyle-Width="6%" ItemStyle-HorizontalAlign="left">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lbloldratname" runat="server" Text='<%#bind("OldRateName")%>'></asp:Label></ItemTemplate>
                                                        </asp:TemplateField>--%>
                                                <asp:TemplateField HeaderText="Old Amount" ItemStyle-Width="6%" ItemStyle-HorizontalAlign="left">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lbloldamt" runat="server" DataFormatString="{0:0.00}" Text=' <%# DataBinder.Eval(Container.DataItem, "OldAmount","{0:0.00}") %>'>'></asp:Label></ItemTemplate>
                                                </asp:TemplateField>
                                                <%--<asp:TemplateField HeaderText="New Rate Name" ItemStyle-Width="10%" ItemStyle-HorizontalAlign="left">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblnewratname" runat="server" Text='<%#bind("OldRateName")%>'></asp:Label></ItemTemplate>
                                                        </asp:TemplateField>--%>
                                                <asp:TemplateField HeaderText="New Amount" ItemStyle-Width="10%" ItemStyle-HorizontalAlign="left">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblPatientName" runat="server" DataFormatString="{0:0.00}" Text=' <%# DataBinder.Eval(Container.DataItem, "NewAmount","{0:0.00}") %>'></asp:Label></ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Amount Difference" ItemStyle-Width="10%" ItemStyle-HorizontalAlign="left">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lbldiffamt" runat="server" DataFormatString="{0:0.00}" Text='<%#bind("Diffamount")%>'></asp:Label></ItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>
                                            <PagerStyle CssClass="dataheader1 w-14" HorizontalAlign="Center" VerticalAlign="Middle" />
                                            <HeaderStyle CssClass="dataheader1 w-14" />
                                            <PagerSettings FirstPageText="" LastPageText="" Mode="NumericFirstLast" NextPageText=""
                                                PageButtonCount="5" PreviousPageText="" />
                                        </asp:GridView>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="a-center" id="tdbtnRateCard" style="display: none" runat="server">
                                        <asp:Button ID="btnRateCard" Text="Create Task" CssClass="btn" runat="server" OnClientClick="return ValidateApprove()"
                                            OnClick="btnRateCard_Click" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="chkInvoice" EventName="SelectedIndexChanged" />
            </Triggers>
        </asp:UpdatePanel>
    </div>
   
            <asp:HiddenField ID="hdnclientName" runat="server" />
            <asp:HiddenField ID="hdnClientID" runat="server" />
            <asp:HiddenField ID="hdnOrgID" runat="server" />
            <asp:HiddenField ID="hdnRateID" runat="server" />
            <asp:HiddenField ID="hdnqClientID" Value="-1" runat="server" />
            <asp:HiddenField ID="hdnqNewRateID" Value="-1" runat="server" />
            <asp:HiddenField ID="hdnqFromDate" Value="" runat="server" />
            <asp:HiddenField ID="hdnqToDate" Value="" runat="server" />
            <asp:HiddenField ID="hdnqBulkID" Value="-1" runat="server" />
      
     <Attune:Attunefooter ID="Attunefooter" runat="server" />
    </form>
   

    <script type="text/javascript">
        function OnselectedClientName(source, eventArgs) {
            document.getElementById('txtClientNameSrch').value = eventArgs.get_text();
            document.getElementById('<%=hdnclientName.ClientID %>').value = eventArgs.get_text();
            document.getElementById('<%=hdnClientID.ClientID %>').value = eventArgs.get_value();
        }
    </script>

    <%--
    <script type="text/javascript" src="../Scripts/jquery-1.7.2.min.js"></script>

    <script type="text/javascript" src="../Scripts/jquery-ui-1.8.19.custom.min.js"></script>
--%>

    <script type="text/javascript">
        function DatePickUP() {
            $(function() {
                $("#txtFrom").datepicker({
                    dateFormat: 'dd/mm/yy',
                    defaultDate: "+1w",
                    changeMonth: true,
                    changeYear: true,
                    maxDate: 0,
                    yearRange: '1900:2100',
                    onClose: function(selectedDate) {
                        $("#txtTo").datepicker("option", "minDate", selectedDate);

                        var date = $("#txtFrom").datepicker('getDate');
                        //var d = new Date(date.getFullYear(), date.getMonth() + 1, 0);
                        // $("#txtTo").datepicker("option", "maxDate", d);

                    }
                });
                $("#txtTo").datepicker({
                    dateFormat: 'dd/mm/yy',
                    defaultDate: "+1w",
                    changeMonth: true,
                    changeYear: true,
                    maxDate: 0,
                    yearRange: '1900:2100',
                    onClose: function(selectedDate) {
                        $("#txtFrom").datepicker("option", "maxDate", selectedDate);
                    }
                })
            });
        }



        var atLeast = 1
        function Validate() {
            var ddl = document.getElementById('ddlratecardname').value;
            if (ddl == "-1") {
                alert('Select the New RateCard Name');
                return false;
            }
            var radio = document.getElementById("<%=chkInvoice.ClientID%>");
            var inputs = radio.getElementsByTagName("input");
            var counter1 = 0;
            var Flag = 0;
            for (var i = 0; i < inputs.length; i++) {
                if (inputs[i].checked) {
                    counter1++;
                }
            }
            if (atLeast > counter1) {
                alert("Please select atleast " + atLeast + " InvoiceNumber");
                return false;
            }
            else {
                Flag = 1;
            }

            var CHK = document.getElementById("<%=ChkRateNameForClient.ClientID%>");
            var checkbox = CHK.getElementsByTagName("input");
            var counter = 0;
            for (var i = 0; i < checkbox.length; i++) {
                if (checkbox[i].checked) {
                    counter++;
                }
            }
            if (atLeast > counter) {
                alert("Please select atleast " + atLeast + " RateCardName");
                return false;
            }
            else {
                Flag = 2;
            }
            if (Flag == 0) {
                return false;
            }
            return true;

        }

     
        var atLeast1 = 1
        function ValidateApprove() {
            var radio = document.getElementById("<%=chkInvoice.ClientID%>");
            var inputs = radio.getElementsByTagName("input");
            var counter1 = 0;
            var Flag = 0;
            for (var i = 0; i < inputs.length; i++) {
                if (inputs[i].checked) {
                    counter1++;
                }
            }
            if (atLeast1 > counter1) {
                alert("Please select atleast " + atLeast + " InvoiceNumber");
                return false;
            }
            else {
                Flag = 1;
            }

            var CHK = document.getElementById("<%=ChkRateNameForClient.ClientID%>");
            var checkbox = CHK.getElementsByTagName("input");
            var counter = 0;
            for (var i = 0; i < checkbox.length; i++) {
                if (checkbox[i].checked) {
                    counter++;
                }
            }
            if (atLeast > counter) {
                alert("Please select atleast " + atLeast + " RateCardName");
                return false;
            }
            else {
                Flag = 2;
            }
            if (Flag == 0) {
                return false;
            }
            return true;

        }
           
    </script>

    <script type="text/javascript">
        if (typeof DatePickUP == 'function')
            Sys.WebForms.PageRequestManager.getInstance().add_pageLoaded(DatePickUP);
    </script>

</body>
</html>
