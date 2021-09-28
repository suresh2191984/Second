<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DaywiseCollection.aspx.cs"
    EnableEventValidation="false" Inherits="Billing_BillSettlement" meta:resourcekey="PageResource2" %>
<%@ Register Src="../CommonControls/PendingVitals.ascx" TagName="PendingVitalsControl"
    TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Admin Daywise Collection</title>
    <link href="../Images/favicon.ico" rel="shortcut icon" />
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
    <link href="../StyleSheets/DHEBAdder.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript" src="../Scripts/AutoComplete.js" language="javascript"></script>

    <script type="text/javascript" src="../Scripts/DHEBAdder.js"></script>
<%--
    <script src="../Scripts/jquery-1.2.2.pack.js" type="text/javascript"></script>--%>

    <link type="text/css" href="../StyleSheets/jquery-ui-1.8.19.custom.css" rel="stylesheet" />
    <style type="text/css">
        .stylenone
        {
            display: none;
        }
        #tblSelectedUser td, .tblSelectedUser td {
            padding: 5px;
        }
        #gvBillDetails {
        width  : 1340px!important;
        display: block;
        overflow: auto;        
        }
      
    </style>

    <script runat="server">
        decimal TotalUnitPrice;
        decimal GetAmount(decimal Price)
        {
            if (Price != 0)
            {
                TotalUnitPrice += Price;
            }
            else
            {
                Price = 0;
            }
            return Price;
        }
        decimal GetTotal()
        {
            return TotalUnitPrice;
        }
    </script>

    <style type="text/css">
        .ui-datepicker
        {
            font-size: 8pt !important;
        }
    </style>
</head>
<body>
    <form id="frmPatientVitals" runat="server">

    <script language="javascript" type="text/javascript">
        function clearContextText() {
            $('#contentArea').hide();

        }
        function openViewBill(obj, ftype, BillStatus, BillType, isFinal) {
            var skey = "";
            if (ftype == "PRM") {
                if (BillType == "Bill") {
                    skey = "../Inventory/PrintBill.aspx"
                           + obj
                           + "&IsPopup=" + "Y"
                           + "&CCPage=Y"
                               + "";
                }
                if (BillType == "Rec") {
                    skey = "../Inventory/TempViewInvReceipt.aspx"
                           + obj
                           + "&IsPopup=" + "Y"
                           + "&CCPage=Y"
                               + "";
                }

                window.open(skey, 'ViewBill', 'letf=0,top=0,height=640,width=800,toolbar=0,scrollbars=1,status=0');
            }
            else {
                if (BillType == "Bill") {
                    if (BillStatus == 'OTHERS') {
                        var skey = "../Reception/ViewPrintPage.aspx"
                           + obj
                           + "&IsPopup=" + "Y"
                           + "&CCPage=Y"
                           + "";

                        window.open(skey, 'ViewBill', 'letf=0,top=0,height=640,width=800,toolbar=0,scrollbars=1,status=0');
                    }
                }
                if (BillType == "Rec") {

                    if (BillStatus == 'ADVANCE') {//Advance
                        var skey = "../Inpatient/PrintReceiptPage.aspx"
                           + obj
                           + "&IsPopup=" + "Y"
                           + "&CCPage=Y&usr=Y"
                           + "&pDet=ADVANCE";

                        window.open(skey, 'ViewBill', 'letf=0,top=0,height=640,width=800,toolbar=0,scrollbars=1,status=0');
                    }
                    if (BillStatus == 'DEPOSIT') {//deposit
                        var skey = "../Reception/PrintDepositReceipt.aspx"
                           + obj
                           + "&IsPopup=" + "Y"
                           + "&CCPage=Y&usr=Y"
                           + "&pDet=DEPOSIT";

                        window.open(skey, 'ViewBill', 'letf=0,top=0,height=640,width=800,toolbar=0,scrollbars=1,status=0');
                    }
                    if (BillStatus == 'OTHERS') {//deposit
                        if (isFinal = 'Y') {
                            var skey = "../Inpatient/PrintReceiptPage.aspx"
                           + obj
                           + "&IsPopup=" + "Y"
                           + "&CCPage=Y&usr=Y"
                           + "&pDet=GENERATEBILL&FinalReceipt=Y";

                            window.open(skey, 'ViewBill', 'letf=0,top=0,height=640,width=800,toolbar=0,scrollbars=1,status=0');
                        }
                        else {

                            var skey = "../Inpatient/PrintReceiptPage.aspx"
                           + obj
                           + "&IsPopup=" + "Y"
                           + "&CCPage=Y&usr=Y"
                           + "&pDet=IPPAYMENTS";

                            window.open(skey, 'ViewBill', 'letf=0,top=0,height=640,width=800,toolbar=0,scrollbars=1,status=0');
                        }
                    }


                }

            }
        }

        
        function popupprint() {
            document.getElementById('<%= btnViewDetails.ClientID %>').style.display = 'None';
            document.getElementById('<%= trHospitalAddress.ClientID %>').style.display = 'block';
            document.getElementById('<%= trdate.ClientID %>').style.display = 'block';
            document.getElementById('<%= trdate1.ClientID %>').style.display = 'block';
            var prtContent = document.getElementById('printCashClosure');
            var WinPrint = window.open('', '', 'letf=100,top=100,height=600,width=1050,toolbar=0,scrollbars=1,status=0,resizable=1');
           //var WinPrint = window.open('', '', 'height=600,width=800');
           // alert(WinPrint);
            WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
            //WinPrint.close();

            document.getElementById('<%= btnViewDetails.ClientID %>').style.display = 'block';
            document.getElementById('<%= trHospitalAddress.ClientID %>').style.display = 'none';
            document.getElementById('<%= trdate.ClientID %>').style.display = 'none';
            document.getElementById('<%= trdate1.ClientID %>').style.display = 'none';
            return false;
        }


        function validateToDate() {
            var AlertType = SListForAppMsg.Get('Admin_LabAdminSummaryReports_aspx_01') == null ? "Alert" : SListForAppMsg.Get('Admin_LabAdminSummaryReports_aspx_01');
            var objdate = SListForAppMsg.Get('Admin_DaywiseCollection_aspx_01') == null ? "Provide / select value for To date" : SListForAppMsg.Get('Admin_DaywiseCollection_aspx_01');

            if (document.getElementById('txtToDate').value == '') {
                //alert('Provide / select value for To date');
                ValidationWindow(objdate, AlertType);
                document.getElementById('ImgToDate').focus();
                return false;
            }
        }



        var ddlText, ddlValue, ddl, lblMesg;
        //        function CacheItems() {
        //            ddlText = new Array();
        //            ddlValue = new Array();
        //            ddl = document.getElementById('ddlUser');
        //            for (var i = 0; i < ddl.options.length; i++) {

        //                ddlText[ddlText.length] = ddl.options[i].text;
        //                ddlValue[ddlValue.length] = ddl.options[i].value;

        //            }
        //        }

        //        window.onload = CacheItems;

        function FilterItems(value) {
            ddl.options.length = 0;
            for (var i = 0; i < ddlText.length; i++) {
                if (ddlText[i].toLowerCase().indexOf(value) != -1) {
                    AddItem(ddlText[i], ddlValue[i]);
                }
            }

            if (ddl.options.length == 0) {
                AddItem("No Physician Found", "");
            }
        }

        function AddItem(text, value) {
            var opt = document.createElement("option");
            opt.text = text;
            opt.value = value;
            ddl.options.add(opt);
        }






        function AddPhysician() {

            var ddlPhy = document.getElementById('ddlUser');
            var ddlPhyLength = ddlPhy.options.length;

            for (var i = 0; i < ddlPhyLength; i++) {
                if (ddlPhy.options[i].selected) {


                    if (ddlPhy.options[i].text != '--All--') {

                        document.getElementById('txtNew').value = ddlPhy.options[i].text;

                    }

                }

            }


        }
         

    </script>

    <asp:ScriptManager ID="ctlTaskScriptMgr" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
                    <div class="contentdata">
                        <script type="text/javascript">
                           /* $(function() {
                                $("#txtFromDate").datepicker({
                                    changeMonth: true,
                                    changeYear: true,
                                    maxDate: 0,
                                    yearRange: '2008:2030'
                                });
                                $("#txtToDate").datepicker({
                                    changeMonth: true,
                                    changeYear: true,
                                    maxDate: 0,
                                    yearRange: '2008:2030'
                                })
                            });*/
                            $(function() {
                            $("#txtFromDate").datepicker({
                                    dateFormat: 'dd/mm/yy',
                                    defaultDate: "+1w",
                                    changeMonth: true,
                                    changeYear: true,
                                    maxDate: 0,
                                    yearRange: '1900:2100',
                                    onClose: function(selectedDate) {
                                    $("#txtToDate").datepicker("option", "minDate", selectedDate);

                                    var date = $("#txtFromDate").datepicker('getDate');
                                        //var d = new Date(date.getFullYear(), date.getMonth() + 1, 0);
                                        // $("#txtTo").datepicker("option", "maxDate", d);

                                    }
                                });
                                $("#txtToDate").datepicker({
                                    dateFormat: 'dd/mm/yy',
                                    defaultDate: "+1w",
                                    changeMonth: true,
                                    changeYear: true,
                                    maxDate: 0,
                                    yearRange: '1900:2100',
                                    onClose: function(selectedDate) {
                                    $("#txtFromDate").datepicker("option", "maxDate", selectedDate);
                                    }
                                })
                            });

                        </script>

                        <div class="a-center">
                            <table class="dataheader2 defaultfontcolor a-left w-100p searchPanel">
                                <tr id="trTrustedOrg" runat="server" style="display: table-row;">
                                    <td>
                                        <asp:Label ID="lblOrgs" runat="server" Text="Select an Organization" 
                                            meta:resourcekey="lblOrgsResource1"></asp:Label>
                                        &nbsp;
                                        <asp:DropDownList ID="ddlTrustedOrg" AutoPostBack="true"  CssClass ="ddlsmall" runat="server" 
                                             onchange="javascript:clearContextText();" OnSelectedIndexChanged="ddlTrustedOrg_SelectedIndexChanged">
                                        </asp:DropDownList>
                                    </td>
                                      <td>
                                                    <asp:Label ID="Rs_Location" runat="server" Text="Location" meta:resourcekey="Rs_LocationResource1"></asp:Label>
                                                &nbsp;
                                                    <asp:DropDownList  CssClass="ddlsmall" runat="server" ID="ddlLocation"                                                       
                                                        meta:resourcekey="ddLOResource1">
                                                    </asp:DropDownList>
                                                </td>
                                    <td>
                                    <%=Resources.Admin_ClientDisplay.Admin_DaywiseCollection_aspx_10%> 
                                        <%--From :--%>
                                    </td>
                                    <td>
                                        <asp:TextBox runat="server" ID="txtFromDate" CssClass="Txtboxsmall" 
                                            Width="70px" meta:resourcekey="txtFromDateResource2"></asp:TextBox>
                                    </td>
                                    <td>
                                    <%=Resources.Admin_ClientDisplay.Admin_DaywiseCollection_aspx_11%> 
                                        <%--To :--%>
                                    </td>
                                    <td>
                                        <asp:TextBox runat="server" ID="txtToDate" CssClass="Txtboxsmall" Width="70px" 
                                            meta:resourcekey="txtToDateResource2"></asp:TextBox>
                                    </td>
                                    <td>
                                    <%=Resources.Admin_ClientDisplay.Admin_DaywiseCollection_aspx_12%> 
                                        <%--Select Currency :--%>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlCurrency" ToolTip="Select Currency" runat="server" Width="250px">
                                        </asp:DropDownList>
                                    </td>
                                    <td class="a-left">
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="7" class="v-top">
                                        <table>
                                            <tr>
                                                <td class="v-top">
                                                  <%=Resources.Admin_ClientDisplay.Admin_DaywiseCollection_aspx_01%>  
                                                  
                                                  <asp:Label ID="lblUName" runat="server" meta:resourcekey="lblUNameResource2"></asp:Label>
                                                </td>
                                                <td class="v-top">
                                                    <asp:Panel ID="pHeader" runat="server" meta:resourcekey="pHeaderResource2">
                                                        <table>
                                                            <tr>
                                                                <td class="cpHeader" runat="server" id="tdimg">
                                                                    <asp:Image ID="ImgCollapse" runat="server" 
                                                                        meta:resourcekey="ImgCollapseResource2" />
                                                                    <asp:Label ID="lblText" runat="server" meta:resourcekey="lblTextResource2" />
                                                                </td>
                                                                <td>
                                                                    <asp:Button ID="btnViewDetails" runat="server" CssClass="btn" TabIndex="2" onmouseover="this.className='btn btnhov'"
                                                                        onmouseout="this.className='btn'" OnClientClick="javascript:return validateToDate();"
                                                                        Text="View Details" OnClick="btnViewDetails_Click" 
                                                                        meta:resourcekey="btnViewDetailsResource2" />
                                                                </td>
                                                                <td class="a-left">
                                                                    <asp:LinkButton ID="lnkBack" runat="server" CssClass="details_label_age" 
                                                                        OnClick="lnkBack_Click" meta:resourcekey="lnkBackResource2"><%=Resources.Admin_ClientDisplay.Admin_DaywiseCollection_aspx_13%> <%--Back--%>&nbsp;&nbsp;&nbsp;</asp:LinkButton>
                                                                </td>
                                                                <td class="a-left">
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </asp:Panel>
                                                    <asp:Panel ID="pBody" runat="server" meta:resourcekey="pBodyResource2">
                                                        <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                                                            <ContentTemplate>
                                                                <asp:CheckBox ID="Chkboxusers" Text="ALL" runat="server" 
                                                            CssClass="smallfon" onclick="checkAll(this)" 
                                                            meta:resourcekey="ChkboxusersResource2" />
                                                                <asp:CheckBoxList ID="chklstusers" runat="server" RepeatColumns="6" 
                                                            RepeatDirection="Horizontal" CssClass="smallfon" 
                                                            meta:resourcekey="chklstusersResource2">
                                                                </asp:CheckBoxList>
                                                            </ContentTemplate>
                                                            <Triggers>
                                                                <asp:AsyncPostBackTrigger ControlID="ddlTrustedOrg" EventName="SelectedIndexChanged" />
                                                            </Triggers>
                                                        </asp:UpdatePanel>
                                                    </asp:Panel>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                            <table>
                                <tr>
                                    <td>
                                        <ajx:CollapsiblePanelExtender ID="CollapsiblePanelExtender1" runat="server" TargetControlID="pBody"
                                            CollapseControlID="pHeader" ExpandControlID="pHeader" Collapsed="True" TextLabelID="lblText"
                                            CollapsedText="ShowUserLists " ExpandedText="HideUserLists" ImageControlID="ImgCollapse"
                            ExpandedImage="../Images/ShowBids.gif" CollapsedImage="../Images/HideBids.gif"
                            Enabled="True" meta:resourcekey="CollapsiblePanelExtender1Resource1">
                                        </ajx:CollapsiblePanelExtender>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div id="contentArea">
                            <div id="divPrint" style="display: none;" runat="server">
                                <table class="w-100p">
                                    <tr>
                                        <td class="a-right paddingR10" style="color: #000000;">
                                            <asp:ImageButton ID="imgBtnXL" OnClick="imgBtnXL_Click" runat="server" ImageUrl="../Images/ExcelImage.GIF"
                                                ToolTip="Save As Excel" meta:resourcekey="imgBtnXLResource2" />
                                            <asp:LinkButton ID="lnkExportXL" OnClick="imgBtnXL_Click" runat="server" 
                                                Font-Bold="True" Font-Size="12px" ForeColor="Black" ToolTip="Save As Excel" 
                                                meta:resourcekey="lnkExportXLResource2"><u><%=Resources.Admin_ClientDisplay.Admin_DaywiseCollection_aspx_26%><%--Export To XL--%></u></asp:LinkButton>
                                                <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/Images/printer.gif" OnClientClick="return popupprint();"
                                                            ToolTip="Print" meta:resourcekey="btnPrintResource1" />
                                                            <b id="printText" runat="server">
                                                            <asp:LinkButton ID="lnkPrint" Text="Print Report" Font-Underline="True" OnClientClick="return popupprint();"
                                        runat="server" Font-Bold="True" Font-Size="12px" ForeColor="Black" ToolTip="Save As Excel"
                                        meta:resourcekey="lnkExportXLResource2"></asp:LinkButton></b>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div class="a-center" id="printCashClosure" style="page-break-after:auto" runat="server">
                                <div style="float: left; display: none;" id="divname" runat="server" class="dataheader2 defaultfontcolor">
                                    <table>
                                        <tr>
                                            <td style="float: left">
                                                <%=Resources.Admin_ClientDisplay.Admin_DaywiseCollection_aspx_02%>
                                                <asp:Label ID="lblName" runat="server" meta:resourcekey="lblNameResource2"></asp:Label>
                                                &nbsp;
                                            </td>
                                            <td style="float: left">
                                                &nbsp;&nbsp;
                                                <%=Resources.Admin_ClientDisplay.Admin_DaywiseCollection_aspx_03%> 
                                                <asp:Label ID="lblReportDate" runat="server" 
                                                    meta:resourcekey="lblReportDateResource2"></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <table class="defaultfontcolor a-left w-100p">
                                    <tr id="tralldetails" runat="server">
                                        <td class="v-top">
                                            <div id="divAllUsers" runat="server">
                                                <table class="defaultfontcolor a-left w-100p">
                                                    <tr id="trHospitalAddress" runat="server" style="display: none;">
                                                        <td colspan="7" class="a-center">
                                                            <label style="font-family: Verdana;" class="font14" id="lblHospitalName" runat="server">
                                                            </label>
                                                        </td>
                                                    </tr>
                                                    <tr id="trdate" runat="server" style="display: none;">
                                                        <td>
                                                            <asp:Label ID="lblcurrentdate" runat="server" class="a-left font14" 
                                                                Style="font-family: Verdana;" meta:resourcekey="lblcurrentdateResource2"></asp:Label>
                                                        </td>
                                                        </tr>
                                                   <tr id="trdate1" runat="server" style="display: none;">
                                                        <td>
                                                            <asp:Label ID="lblfromtodate" runat="server" lass="font14" 
                                                                Style="font-family: Verdana;" meta:resourcekey="lblfromtodateResource2"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="dataheader2 v-top">
                                                            <asp:Panel ID="pnlReceived" runat="server" GroupingText="Received Details" 
											meta:resourcekey="gvBillDetails1Resource2">
                                                                <asp:GridView ID="gvAllUsers" EmptyDataText="No Results Found." AllowPaging="false"
                                                                    runat="server" GridLines="Both" OnRowCommand="gvAllUsers_RowCommand" CssClass="mytable1 w-100p gridView"
                                                    AutoGenerateColumns="false" meta:resourcekey="gvAllUsersResource2">
                                                                    <HeaderStyle CssClass="dataheader1" />
                                                                    <RowStyle HorizontalAlign="Left" Font-Size="12px" />
                                                                    <Columns>
                                                                        <asp:TemplateField HeaderText="S.No" meta:resourcekey="TemplateFieldResource9">
                                                                            <ItemTemplate>
                                                                                <%# Container.DataItemIndex + 1 %>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="Received By" 
                                                                            meta:resourcekey="TemplateFieldResource10">
                                                                            <ItemTemplate>
                                                                                <asp:LinkButton ID="lnkReceivedNumber" runat="server" 
                                                                                    CommandArgument='<%# Eval("ReceivedBy") %>' CommandName="UserLink" 
                                                                                    ForeColor="Brown" meta:resourcekey="lnkReceivedNumberResource3" Style="color: Black; text-decoration: underline;
                                                                                    font-family: Verdana; cursor: pointer;" Text='<%# Eval("finalBillID") %>'></asp:LinkButton>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                        <asp:BoundField DataField="AmtReceived" HeaderText="Amount" 
                                                                            meta:resourcekey="BoundFieldResource5">
                                                                        <ItemStyle HorizontalAlign="Right" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="Cash" HeaderText="Cash" 
                                                                           >
                                                                        <ItemStyle HorizontalAlign="Right" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="Card" HeaderText="Card" 
                                                                            >
                                                                        <ItemStyle HorizontalAlign="Right" />
                                                                        </asp:BoundField>
                                                                    </Columns>
                                                                    <HeaderStyle CssClass="dataheader1" />
                                                                    <RowStyle HorizontalAlign="Left" Font-Size="12px" />
                                                                </asp:GridView>
                                                            </asp:Panel>
                                                        </td>
                                                        <td class="dataheader2 v-top">
                                                            <asp:Panel ID="pnlRefund" runat="server" GroupingText="Refund / Cancel Details" 
                                                                meta:resourcekey="pnlRefundResource2">
                                                                <asp:GridView ID="gvAllUsersRefund" EmptyDataText="No Results Found." AllowPaging="false"
                                                                    runat="server" GridLines="Both" OnRowCommand="gvAllUsers_RowCommand" CssClass="mytable1 gridView w-100p"
                                                    AutoGenerateColumns="false" meta:resourcekey="gvAllUsersRefundResource2">
                                                                    <HeaderStyle CssClass="dataheader1" />
                                                                    <RowStyle HorizontalAlign="Left" Font-Size="12px" />
                                                                    <Columns>
                                                                        <asp:TemplateField HeaderText="S.No" meta:resourcekey="TemplateFieldResource11">
                                                                            <ItemTemplate>
                                                                                <%# Container.DataItemIndex + 1 %>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="Refund By" 
                                                                            meta:resourcekey="TemplateFieldResource12">
                                                                            <ItemTemplate>
                                                                                <asp:LinkButton ID="lnkReceivedNumber" runat="server" 
                                                                                    CommandArgument='<%# Eval("ReceivedBy") %>' CommandName="UserLink" 
                                                                                    meta:resourcekey="lnkReceivedNumberResource4" Style="color: Black; text-decoration: underline;
                                                                                    font-family: Verdana; cursor: pointer;" Text='<%# Eval("FinalBillID") %>'></asp:LinkButton>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                        <asp:BoundField DataField="AmtReceived" HeaderText="Amount" 
                                                                            meta:resourcekey="BoundFieldResource6">
                                                                        <ItemStyle HorizontalAlign="Right" />
                                                                        </asp:BoundField>
                                                                    </Columns>
                                                                    <HeaderStyle CssClass="dataheader1" />
                                                                    <RowStyle HorizontalAlign="Left" Font-Size="12px" />
                                                                </asp:GridView>
                                                            </asp:Panel>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="dataheader2 v-top">
                                                            <asp:Panel ID="pnlPayments" runat="server" GroupingText="Payment Details" 
                                                                meta:resourcekey="pnlPaymentsResource2">
                                                                <asp:GridView ID="gvAllUsersPayments" EmptyDataText="No Results Found." AllowPaging="false"
                                                                    runat="server" OnRowCommand="gvAllUsers_RowCommand" GridLines="Both" CssClass="mytable1 gridView w-100p"
                                                                    AutoGenerateColumns="false" meta:resourcekey="gvAllUsersPaymentsResource2">
                                                                    <HeaderStyle CssClass="dataheader1" />
                                                                    <RowStyle HorizontalAlign="Left" Font-Size="12px" />
                                                                    <Columns>
                                                                        <asp:TemplateField HeaderText="S.No" meta:resourcekey="TemplateFieldResource13">
                                                                            <ItemTemplate>
                                                                                <%# Container.DataItemIndex + 1 %>
                                                                            </ItemTemplate>
                                                                            <ItemStyle Width="8%" />
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="Paid By" 
                                                                            meta:resourcekey="TemplateFieldResource14">
                                                                            <ItemTemplate>
                                                                                <asp:LinkButton ID="lnkReceivedNumber0" runat="server" 
                                                                                    CommandArgument='<%# Eval("ReceivedBy") %>' CommandName="UserLink" 
                                                                                    meta:resourcekey="lnkReceivedNumber0Resource2" Style="color: Black; text-decoration: underline;
                                                                                    font-family: Verdana;" Text='<%# Eval("FinalBillID") %>'></asp:LinkButton>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                        <asp:BoundField DataField="AmtReceived" HeaderText="Amount" 
                                                                            meta:resourcekey="BoundFieldResource7">
                                                                        <ItemStyle HorizontalAlign="Right" />
                                                                        </asp:BoundField>
                                                                    </Columns>
                                                                    <HeaderStyle CssClass="dataheader1" />
                                                                    <RowStyle HorizontalAlign="Left" Font-Size="12px" />
                                                                </asp:GridView>
                                                            </asp:Panel>
                                                        </td>
                                                        <td class="dataheader2 v-top">
                                                            <asp:Panel ID="Panel3" runat="server" GroupingText="Collection Summary" 
                                                                meta:resourcekey="Panel3Resource2">
                                                                <asp:GridView ID="gvPayDetails" EmptyDataText="No Results Found." AllowPaging="false"
                                                                    runat="server" OnRowCommand="gvPayDetails_RowCommand" GridLines="Both" CssClass="mytable1 gridView w-100p"
                                                    AutoGenerateColumns="false" meta:resourcekey="gvPayDetailsResource2">
                                                                    <HeaderStyle CssClass="dataheader1" />
                                                                    <RowStyle HorizontalAlign="Left" Font-Size="12px" />
                                                                    <Columns>
                                                                        <asp:TemplateField HeaderText="S.No" meta:resourcekey="TemplateFieldResource15">
                                                                            <ItemTemplate>
                                                                                <%# Container.DataItemIndex + 1 %>
                                                                            </ItemTemplate>
                                                                            <ItemStyle Width="8%" />
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="Description" 
                                                                            meta:resourcekey="TemplateFieldResource16">
                                                                            <ItemTemplate>
                                                                                <asp:LinkButton ID="lnkDescription0" runat="server" 
                                                                                    CommandArgument='<%# Eval("Descriptions") %>' CommandName="UserLink" 
                                                                                    meta:resourcekey="lnkDescription0Resource2" Style="color: Black; text-decoration: underline;
                                                                                    font-family: Verdana;" Text='<%# Eval("Descriptions") %>'></asp:LinkButton>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                        <asp:BoundField DataField="Amount" HeaderText="Amount" 
                                                                            meta:resourcekey="BoundFieldResource8">
                                                                        <ItemStyle HorizontalAlign="Right" />
                                                                        </asp:BoundField>
                                                                    </Columns>
                                                                    <HeaderStyle CssClass="dataheader1" />
                                                                    <RowStyle HorizontalAlign="Left" Font-Size="12px" />
                                                                </asp:GridView>
                                                            </asp:Panel>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <div id="divSingleUser" runat="server">
                                                <table class="defaultfontcolor a-left w-100p bg-row">
                                                    <tr>
                                                        <td class="dataheader2 v-top">
                                            <asp:Panel ID="Panel1" runat="server" GroupingText="Received Details" meta:resourcekey="gvBillDetails1Resource2">
                                                <asp:GridView ID="gvBillDetails" EmptyDataText="No Results Found."  runat="server"
                                                    DataKeyNames="FinalBillID" OnRowDataBound="gvBillDetails_RowDataBound" CssClass="mytable1 gridView w-100p"
                                                    AutoGenerateColumns="False" meta:resourcekey="gvBillDetailsResource2">
                                                                    <HeaderStyle CssClass="dataheader1" />
                                                                    <RowStyle HorizontalAlign="Left" Font-Size="12px" />
                                                                    <Columns>
                                                        <asp:TemplateField HeaderText="S.No" meta:resourcekey="TemplateField1Resource4">
                                                                            <ItemTemplate>
                                                                                <%# Container.DataItemIndex + 1 %>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Bill Number" meta:resourcekey="TemplateField1Resource5">
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="lnkBillNumber" Style="color: Black; font-family: Verdana; cursor: pointer;"
                                                                    Text='<%# Eval("BillNumber") %>' runat="server" meta:resourcekey="lnkBillNumberResource3"></asp:Label>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                        <asp:BoundField DataField="CreatedAt" HeaderText="Billed Date" DataFormatString="{0:d}"
                                                            meta:resourcekey="BoundField1Resource17" />
                                                                        <%--<asp:BoundField DataField="ReceiptNO" HeaderText="Receipt No" />--%>
                                                        <asp:BoundField DataField="Descriptions" HeaderText="Patient No" meta:resourcekey="BoundField1Resource18" />
                                                        <asp:BoundField DataField="VisitNumber" HeaderText="Visit No" meta:resourcekey="BoundField1Resource19" />
                                                        <asp:BoundField DataField="Name" HeaderText="Patient Name" meta:resourcekey="BoundField1Resource20" />
                                                        <asp:BoundField DataField="Amount" HeaderText="Net Amount" ItemStyle-HorizontalAlign="Right"
                                                            meta:resourcekey="BoundField1Resource21">
                                                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="AmtReceived" HeaderText="Received Amount" ItemStyle-HorizontalAlign="Right"
                                                            meta:resourcekey="BoundField1Resource22">
                                                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="Cash" HeaderText="Cash" ItemStyle-HorizontalAlign="Right"
                                                            meta:resourcekey="BoundField1Resource23">
                                                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="Card" HeaderText="Cards" ItemStyle-HorizontalAlign="Right"
                                                            meta:resourcekey="BoundField1Resource24">
                                                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="DD" HeaderText="DD" ItemStyle-HorizontalAlign="Right"
                                                            meta:resourcekey="BoundField1Resource25">
                                                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="Cheque" HeaderText="Cheque" ItemStyle-HorizontalAlign="Right"
                                                            meta:resourcekey="BoundField1Resource26">
                                                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="PaidCurrency" HeaderText="Paid Currency" Visible="true"
                                                            ItemStyle-HorizontalAlign="Center" meta:resourcekey="BoundField1Resource27">
                                                            <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                                        <%-- <asp:TemplateField HeaderText="PaidCurrencyAmount" ItemStyle-HorizontalAlign="Right" Visible="true">
                                                                        <ItemTemplate>
                                                                            <%--   <asp:Label runat="server" ID="tot" Text='<%#Bind("TotalAmount") %>'></asp:Label>
                                                                            <%# GetAmount(decimal.Parse(Eval("PaidCurrencyAmount").ToString()))%>
                                                                        </ItemTemplate>
                                                                        <FooterTemplate>
                                                                            <%# (string) " "+ GetTotal() %>
                                                                        </FooterTemplate>
                                                                    </asp:TemplateField>--%>
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="AmtReceived" HeaderText="Paid Currency Amt" ItemStyle-HorizontalAlign="Right"
                                                            meta:resourcekey="BoundField1Resource28">
                                                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="BookedDate" HeaderText="Booked Date" meta:resourcekey="BoundField1Resource29" />
                                                        <asp:BoundField DataField="BookedBy" HeaderText="Booked By" meta:resourcekey="BoundField1Resource30" />
                                                        <asp:BoundField DataField="BookingID" HeaderText="BookingID" meta:resourcekey="BoundField1Resource31" />
                                                        <asp:BoundField DataField="CollectedDateTime" HeaderText="Collected DateTime" meta:resourcekey="BoundField1Resource32" />
                                                        <asp:BoundField DataField="City" HeaderText="City Name" meta:resourcekey="BoundField1Resource33" />
                                                        <asp:BoundField DataField="GrossBillValue" HeaderText="Gross BillValue" ItemStyle-HorizontalAlign="Right"
                                                            meta:resourcekey="BoundField1Resource34">
                                                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="DiscountAmt" HeaderText="Discount Amount" ItemStyle-HorizontalAlign="Right"
                                                            meta:resourcekey="BoundField1Resource35">
                                                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="DueAmount" HeaderText="Due Amount" ItemStyle-HorizontalAlign="Right"
                                                            meta:resourcekey="BoundField1Resource36">
                                                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                        </asp:BoundField>
                                                    </Columns>
                                                    <RowStyle HorizontalAlign="Left" />
                                                </asp:GridView>
                                            </asp:Panel>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="dataheader2 v-top">
                                            <asp:Panel ID="PanelgvRefundDetails" runat="server" GroupingText="Refund / Cancel Details"
                                                meta:resourcekey="gvRefundDetails1Resource2">
                                                <asp:GridView ID="gvRefundDetails" EmptyDataText="No Results Found." CssClass="mytable1 gridView w-100p"
                                                    AutoGenerateColumns="False" OnRowDataBound="gvRefundDetails_RowDataBound" runat="server"
                                                    meta:resourcekey="gvRefundDetailsResource2">
                                                    <HeaderStyle CssClass="dataheader1" />
                                                    <RowStyle HorizontalAlign="Left" Font-Size="12px" />
                                                    <Columns>
                                                        <asp:TemplateField HeaderText="S.No" meta:resourcekey="TemplateField1Resource2">
                                                            <ItemTemplate>
                                                                <%#Container .DataItemIndex +1 %>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Bill Number" meta:resourcekey="TemplateField1Resource3">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lnkBillNumber" Style="color: Black; font-family: Verdana;" Text='<%# Eval("BillNumber") %>'
                                                                    runat="server" meta:resourcekey="lnkBillNumberResource2"></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:BoundField DataField="ReceiptNO" HeaderText="Refund NO" meta:resourcekey="BoundField1Resource9" />
                                                        <asp:BoundField DataField="Descriptions" HeaderText="Patient No" meta:resourcekey="BoundField1Resource10" />
                                                        <asp:BoundField DataField="Name" HeaderText="Patient Name" meta:resourcekey="BoundField1Resource11" />
                                                        <asp:BoundField DataField="AmtReceived" HeaderText="Amount" ItemStyle-HorizontalAlign="Right"
                                                            meta:resourcekey="BoundField1Resource12">
                                                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="Cash" HeaderText="Cash" ItemStyle-HorizontalAlign="Right"
                                                            meta:resourcekey="BoundField1Resource13">
                                                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="Card" HeaderText="Cards" ItemStyle-HorizontalAlign="Right"
                                                            meta:resourcekey="BoundField1Resource14">
                                                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="DD" HeaderText="DD" ItemStyle-HorizontalAlign="Right"
                                                            meta:resourcekey="BoundField1Resource15">
                                                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="Cheque" HeaderText="Cheque" meta:resourcekey="BoundField1Resource16" />
                                                        <asp:BoundField DataField="City" HeaderText="Remarks" />
                                                    </Columns>
                                                    <RowStyle HorizontalAlign="Left" />
                                                </asp:GridView>
                                            </asp:Panel>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="dataheader2 v-top">
                                            <asp:Panel ID="Panel2" runat="server" GroupingText="Payment Details" meta:resourcekey="pnlPaymentsResource2">
                                                <asp:GridView ID="gvPaymentDetails" EmptyDataText="No Results Found." runat="server"
                                                    CssClass="mytable1 gridView w-100p" AutoGenerateColumns="False" meta:resourcekey="gvPaymentDetailsResource2">
                                                    <HeaderStyle CssClass="dataheader1" />
                                                    <RowStyle HorizontalAlign="Left" Font-Size="12px" />
                                                    <Columns>
                                                        <asp:TemplateField ItemStyle-Width="8%" HeaderText="S.No" meta:resourcekey="TemplateField1Resource6">
                                                            <ItemTemplate>
                                                                <%# Container.DataItemIndex + 1 %>
                                                            </ItemTemplate>
                                                            <ItemStyle Width="8%"></ItemStyle>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField ItemStyle-CssClass="stylenone" HeaderStyle-CssClass="stylenone"
                                                            HeaderText="Doctor Number" meta:resourcekey="TemplateField1Resource7">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lnkBillNumber0" runat="server" Style="color: Black; font-family: Verdana;
                                                                    cursor: pointer;" Text='<%# Eval("AmtReceivedID") %>' meta:resourcekey="lnkBillNumber0Resource1"></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle CssClass="stylenone"></HeaderStyle>
                                                            <ItemStyle CssClass="stylenone"></ItemStyle>
                                                        </asp:TemplateField>
                                                        <asp:BoundField DataField="Name" HeaderText="Description" meta:resourcekey="BoundField1Resource37" />
                                                        <asp:BoundField DataField="AmtReceived" HeaderText="Amount" ItemStyle-HorizontalAlign="Right"
                                                            meta:resourcekey="BoundField1Resource38">
                                                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                        </asp:BoundField>
                                                    </Columns>
                                                    <RowStyle HorizontalAlign="Left" />
                                                </asp:GridView>
                                            </asp:Panel>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="dataheader2 v-top">
                                            <asp:Panel ID="PnlRefundnew" runat="server">
                                                <asp:GridView ID="gvRefundDetailssplitup" EmptyDataText="No Results Found." runat="server"
                                                    OnRowDataBound="gvRefundDetailssplitup_RowDataBound" CssClass="mytable1 gridView w-100p"
                                                    AutoGenerateColumns="False" meta:resourcekey="ggvRefundDetailssplitupResource2">
                                                    <HeaderStyle CssClass="dataheader1" />
                                                    <RowStyle HorizontalAlign="Left" Font-Size="12px" />
                                                    <Columns>
                                                        <asp:BoundField DataField="Descriptions" HeaderText="Payment Type" meta:resourcekey="BoundField1Resource39">
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="AmtReceived" HeaderText="Collection Amt" ItemStyle-HorizontalAlign="Right"
                                                            meta:resourcekey="BoundField1Resource40">
                                                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="RefundAmount" HeaderText="Refund Amt" ItemStyle-HorizontalAlign="Right"
                                                            meta:resourcekey="BoundField1Resource41">
                                                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="PaidCurrencyAmount" HeaderText="Other Paid Amt" ItemStyle-HorizontalAlign="Right"
                                                            meta:resourcekey="BoundField1Resource42">
                                                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="BilledAmount" HeaderText="Total" ItemStyle-HorizontalAlign="Right"
                                                            meta:resourcekey="BoundField1Resource43">
                                                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                        </asp:BoundField>
                                                    </Columns>
                                                    <RowStyle HorizontalAlign="Left" />
                                                </asp:GridView>
                                                <%--<asp:BoundField DataField="PaidCurrencyAmount" HeaderText="Payment Amt" />--%>
                                                <%-- <asp:BoundField DataField="BilledAmount" HeaderText="Total" />
                                                            </Columns>
                                                            <rowstyle horizontalalign="Left" />
                                                            </asp:GridView>--%>
                                                            </asp:Panel>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                              <div>
                                                <table class="defaultfontcolor a-left w-100p bg-row">
                                                    <tr>
                                                        <td class="dataheader2">
                                            <asp:Panel ID="pnlCashIncomeDetails" runat="server" GroupingText="Cash income details"
                                                meta:resourcekey="pnlCashIncomeDetailsResource1">
                                                                <asp:Label ID="lblgvCashIncomeDetails" Visible="false" runat="server"></asp:Label>
                                                                <asp:GridView ID="gvCashIncomeDetails" runat="server" AutoGenerateColumns="False"
                                                    Visible="false" BackColor="White" CssClass="w-100p gridView" BorderColor="#CCCCCC"
                                                    BorderStyle="None" BorderWidth="1px" CellPadding="3" Font-Names="Verdana" Font-Size="9pt"
                                                    OnRowCommand="gvAllUsers_RowCommand" OnRowDataBound="gvCashIncomeDetails_RowDataBound">
                                                                    <RowStyle ForeColor="#000066" />
                                                                    <Columns>
                                                                        <asp:TemplateField HeaderText="Received By" Visible="true" meta:resourcekey="BoundFieldResource9">
                                                                            <ItemTemplate>
                                                                                <asp:LinkButton ID="lnkReceivedNumber" Style="color: Black; text-decoration: underline;
                                                                                    font-family: Verdana; cursor: pointer;" userID='<%# Eval("ReceivedBy") %>' Text='<%# Eval("ReceiptNO") %>'
                                                                                    runat="server" CommandName="UserLink" CommandArgument='<%# Eval("ReceivedBy") %>'></asp:LinkButton>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                        <asp:BoundField DataField="Remarks" HeaderText="Description" Visible="true" meta:resourcekey="BoundFieldResource10"  />
                                                                        <asp:BoundField DataField="AmtReceived" HeaderText="Amount" ItemStyle-HorizontalAlign="Right" meta:resourcekey="BoundFieldResource11">
                                                                            <ItemStyle HorizontalAlign="Right" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="FinalBillID" HeaderText="UniqueID" Visible="false" />
                                                                    </Columns>
                                                                    <FooterStyle BackColor="White" ForeColor="#000066" />
                                                                    <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                                                    <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                                    <HeaderStyle CssClass="grdcolor" Font-Bold="True" />
                                                                </asp:GridView>
                                                            </asp:Panel>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr id="trbeakupdetails" runat="server">
                                        <td class="dataheader2 v-top a-right">
                                            <table class="defaultfontcolor a-right w-100p bg-row">
                                                <tr>
                                                    <td class="a-left">
                                                        <table id="tblSelectedUser" runat="server">
                                                            <tr>
                                                                <td colspan="2" class="a-center">
                                                    <asp:Label ID="lblSelectUsers" Font-Bold="true" runat="server" Text="Selected User's Details"
                                                        meta:resourcekey="lblSelectUsersResource1"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td> <%=Resources.Admin_ClientDisplay.Admin_DaywiseCollection_aspx_14%>
                                                                   <%-- Collected Amount--%>&nbsp;&nbsp;
                                                                </td>
                                                                <td class="a-right">
                                                                    <asp:Label ID="lblSelectedUserCollAmt" runat="server" Text="0.00"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td> <%=Resources.Admin_ClientDisplay.Admin_DaywiseCollection_aspx_15%>
                                                                   <%-- Refunded Amount--%>&nbsp;&nbsp;
                                                                </td>
                                                                <td class="a-right">
                                                                    <asp:Label ID="lblSelectedUserRefAmt" runat="server" Text="0.00"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr style="display: none;">
                                                                <td> <%=Resources.Admin_ClientDisplay.Admin_DaywiseCollection_aspx_16%>
                                                                   <%-- Cancelled Bill Amount--%>&nbsp;&nbsp;
                                                                </td>
                                                                <td class="a-right">
                                                                    <asp:Label ID="lblSelectedUserCanAmt" runat="server" Text="0.00"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td> <%=Resources.Admin_ClientDisplay.Admin_DaywiseCollection_aspx_17%>
                                                                   <%-- Miscellaneous Amount--%>&nbsp;&nbsp;
                                                                </td>
                                                                <td class="a-right">
                                                                    <asp:Label ID="lblSelectedUserMisAmt" runat="server" Text="0.00"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td> <%=Resources.Admin_ClientDisplay.Admin_DaywiseCollection_aspx_18%>
                                                                    <%--Closing Balance--%>&nbsp;&nbsp;
                                                                </td>
                                                                <td class="a-right">
                                                                    <asp:Label ID="lblSelectedUserCloseAmt" runat="server" Text="0.00"></asp:Label>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td class="a-right">
                                                        <table class="tblSelectedUser">
                                                            <tr>
                                                                <td colspan="2">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td> <%=Resources.Admin_ClientDisplay.Admin_DaywiseCollection_aspx_19%>
                                                                    <%--Total Collected Amount--%>&nbsp;&nbsp;
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblTotal" runat="server" Text="0.00"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td> <%=Resources.Admin_ClientDisplay.Admin_DaywiseCollection_aspx_20%>
                                                                    <%--Total Income Amount--%>&nbsp;&nbsp;
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblTotalIncAmount" runat="server" Text="0.00"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td> <%=Resources.Admin_ClientDisplay.Admin_DaywiseCollection_aspx_21%>
                                                                    <%--Total Refunded Amount--%>&nbsp;&nbsp;
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblRefund" runat="server" Text="0.00"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr id="trTotalPendingAmount" runat="server" style="display: none">
                                                                <td> <%=Resources.Admin_ClientDisplay.Admin_DaywiseCollection_aspx_22%>
                                                                   <%-- Total Pending Amount--%>&nbsp;&nbsp;
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblPendingAmt" runat="server" Text="0.00"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr >
                                                                <td> <%=Resources.Admin_ClientDisplay.Admin_DaywiseCollection_aspx_23%>
                                                                    <%--Total Cancelled Bill Amount--%>&nbsp;&nbsp;
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblCancelledAmount" runat="server" Text="0.00"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td> <%=Resources.Admin_ClientDisplay.Admin_DaywiseCollection_aspx_24%>
                                                                    <%--Total Paid Miscellaneous Amount--%>&nbsp;&nbsp;
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblOthersAmount" runat="server" Text="0.00"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td class="a-right"> <%=Resources.Admin_ClientDisplay.Admin_DaywiseCollection_aspx_25%>
                                                                    <%--Closing Balance--%>&nbsp;&nbsp;
                                                                </td>
                                                                <td class="a-right">
                                                                    <asp:Label ID="lblClosingBalance" runat="server" Text="0.00"></asp:Label>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <table class="w-100p">
                                <tr>
                                    <td class="a-center v-middle">
                                        <div class="a-center">
                                            <br />
                                            &nbsp;&nbsp;&nbsp;&nbsp;<asp:Button ID="btnPrint" runat="server" Text="Print" CssClass="btn"
                                onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" OnClientClick="return popupprint();"
                                meta:resourcekey="btnPrintRecource1" />
                                            <br />
                                            <br />
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
       <Attune:Attunefooter ID="Attunefooter" runat="server" />        
    <asp:HiddenField ID="hdnAmtReceivedID" runat="server" />
    <asp:HiddenField ID="hdnUserID" runat="server" />
    <asp:HiddenField ID="hdnLID" runat="server" Value="0" />
    </form>

    <script type="text/javascript" language="javascript">

        function checkAll(obj1) {
            var checkboxCollection = document.getElementById('chklstusers').getElementsByTagName('input');

            for (var i = 0; i < checkboxCollection.length; i++) {
                if (checkboxCollection[i].type.toString().toLowerCase() == "checkbox") {
                    checkboxCollection[i].checked = obj1.checked;
                }
            }
        }

       

    </script>

</body>
</html>
