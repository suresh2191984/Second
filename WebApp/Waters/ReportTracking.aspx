<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ReportTracking.aspx.cs" Inherits="Waters_ReportTracking"
    EnableEventValidation="false" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms" Namespace="Microsoft.Reporting.WebForms"
    TagPrefix="rsweb" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms" Namespace="Microsoft.Reporting.WebForms"
    TagPrefix="rsweb" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>

    <script src="../Scripts/bid.js" type="text/javascript"></script>

    <style type="text/css">
        .searchQuotation td, .testSectionArea, .billingDetails
        {
            padding: 2px 10px;
        }
        .testSectionArea .trEven td, .testSectionArea .trOdd td
        {
            padding: 2px;
        }
        .searchQuotation .chkBillingAddress tr td
        {
            padding: 0;
        }
        .chkBillingAddress input[type="checkbox" i]
        {
            margin: 3px 3px 3px 0px;
        }
        table.gridView.tblGridTest .dataHeader
        {
            background: #446d87 !important;
        }
        table.gridView.tblGridTest .dataHeader td
        {
            color: #fff !important;
            font-weight: bold;
        }
        .lblBillingDeatils
        {
            background: #446d87;
            color: #fff;
            font-weight: bold;
            padding: 3px 5px;
        }
        .testSectionArea span
        {
            font-size: 12px;
        }
        table.gridView.tblGridTest tr
        {
            height: 23px;
        }
        .divGridTest
        {
            display: block;
            overflow: auto;
            min-height: 50px;
            max-height: 75px;
        }
        .holder
        {
            height: 16%;
            display: block;
        }
    </style>
</head>
<body>

    <script src="Waters.js" type="text/javascript">

    </script>

    <script type="text/javascript">


        function SelectVisit(id, VisitID, QuotationNumber, ClientName, ClientID, VisitNumber, BioChemistry, Microbiology) {

            debugger;


            document.getElementById('hdnVisitID').value = VisitID;
            document.getElementById('hdnVID').value = VisitID;
            checkIDSelect(id);

        }



        function checkIDSelect(rdbtnid) {
            var rdBtn = document.getElementById(rdbtnid);
            var rdBtnList = document.getElementsByTagName("input");
            for (i = 0; i < rdBtnList.length; i++) {
                if (rdBtnList[i].type == "radio" && rdBtnList[i].id != rdBtn.id) {
                    rdBtnList[i].checked = false;
                }
            }
        }


        function ChkIfSelected(obj, Dummy) {
            // alert(obj);

            debugger;
            if (document.getElementById(obj).checked) {
                document.getElementById('ChkID').value = Dummy + '^';
            }
            else {
                //alert('else');
                var chkSelectAllDynamicID = obj.substring(0, 19);
                document.getElementById(chkSelectAllDynamicID + '_chkSelectAll').checked = false;
                var x = document.getElementById('ChkID').value.split('^');
                document.getElementById('ChkID').value = '';
                for (i = 0; i < x.length; i++) {
                    if (x[i] != '') {
                        if (x[i] != Dummy) {
                            document.getElementById('ChkID').value = x[i] + '^';
                        }
                    }

                }
            }
        }

        function SelectAll(IsChecked) {
            var chkArrayMain = new Array();
            var UniqTemplateChkId = IsChecked.substring(0, 19);
            chkArrayMain = document.getElementById('HdnCheckBoxId').value.split('~');
            if (document.getElementById(IsChecked).checked) {

                for (var i = 0; i < chkArrayMain.length; i++) {
                    if (UniqTemplateChkId == chkArrayMain[i].substring(0, 19)) {
                        if (document.getElementById(chkArrayMain[i]).disabled == false) {
                            document.getElementById(chkArrayMain[i]).checked = true;
                        }
                    }
                }
            } else {
                for (var i = 0; i < chkArrayMain.length; i++) {
                    if (UniqTemplateChkId == chkArrayMain[i].substring(0, 19)) {
                        document.getElementById(chkArrayMain[i]).checked = false;
                    }
                }
            }

        }

        function EnableAll(IsChecked) {
            var chkArrayMain = new Array();
            var chkArraydisable = new Array();
            var UniqTemplateChkId = IsChecked.substring(0, 19);
            chkArrayMain = document.getElementById('HdnCheckBoxId').value.split('~');
            chkArraydisable = document.getElementById('Hdndisablebox').value.split('~');
            if (document.getElementById(IsChecked).checked) {
                for (var i = 0; i < chkArrayMain.length; i++) {
                    if (UniqTemplateChkId == chkArrayMain[i].substring(0, 19)) {
                        document.getElementById(chkArrayMain[i]).disabled = false;
                        document.getElementById(chkArrayMain[i]).checked = true;
                    }
                }
            } else {
                for (var i = 0; i < chkArrayMain.length; i++) {
                    //if (UniqTemplateChkId == chkArrayMain[i].substring(0, 19)) {
                    document.getElementById(chkArrayMain[i]).disabled = false;
                    document.getElementById(chkArrayMain[i]).checked = false;
                    if (chkArraydisable[i] > 0) {
                        document.getElementById(chkArrayMain[i]).disabled = true;
                    }
                    //  }
                }
            }

        }
       
    </script>

    <form id="form1" runat="server">
    <asp:ScriptManager ID="ctlquotationdetails" runat="server">
        <Services>
            <asp:ServiceReference Path="~/OPIPBilling.asmx" />
            <asp:ServiceReference Path="~/WebService.asmx" />
        </Services>
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
        <table class="w-100p searchQuotation searchPanel">
            <tr>
                <td class="v-top">
                    <asp:Label ID="lblQuotationNo" runat="server" Text="Quotation Number :"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtQuotationNo" runat="server" CssClass="Txtboxsmall"></asp:TextBox>
                    <%--     <ajc:AutoCompleteExtender ID="AutoCompleteExtenderQuotationNo" runat="server" TargetControlID="txtQuotationNo"
                            CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                            CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" EnableCaching="False"
                            MinimumPrefixLength="3" CompletionInterval="0" ServiceMethod="GetQuotationNumber"
                            OnClientItemSelected="SelectedQuotationNumber" ServicePath="~/OPIPBilling.asmx"
                            DelimiterCharacters="" Enabled="True" UseContextKey="True">
                        </ajc:AutoCompleteExtender>--%>
                </td>
                <td>
                    <asp:Label ID="lblSampleID" runat="server" Text="Sample ID"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtSampleID" runat="server"></asp:TextBox>
                </td>
                <td>
                    <asp:Label ID="WatersVisitNo" runat="server" Text="Visit Number :"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtWatersVisitNo" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="WaterslblFrom" runat="server" Text="From :"></asp:Label>
                    <span style="color:red">*</span>
                   
                </td>
                <td>
                    <asp:TextBox ID="WaterstxtFrom" runat="server"></asp:TextBox>
                </td>
                <td>
                    <asp:Label ID="WaterslblTo" runat="server" Text="To :"></asp:Label>
                       <span style="color:red">*</span>
                </td>
                <td>
                    <asp:TextBox ID="WaterstxtTo" runat="server"></asp:TextBox>
                </td>
                <td>
                    <asp:Label ID="WaterslblClientName" runat="server" Text="Client Name :"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="WaterstxtClientName" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td colspan="3" class="a-right">
                    <asp:Button ID="btnClear" runat="server" Text="Clear" CssClass="btn" OnClick="btnClear_Click" />
                </td>
                <td colspan="3">
                    <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn" OnClientClick="return ValidateClick();" OnClick="btnSearch_Click" />
                </td>
            </tr>
        </table>
        <%-- <table class="w-100p">
            <tr>
                <td colspan="3">
                    <asp:Label ID="lblSelectavisit" runat="server" Text=" Select a visit" Visible="false"></asp:Label>
                    <asp:DropDownList ID="ddlVisitActionName" runat="server" Visible="false">
                    </asp:DropDownList>
                </td>
            </tr>
        </table>--%>
        <table runat="server" id="tblPDFReportViewer">
            <tr class="w-100p">
                <td>
                    <asp:Panel ID="pnlReportPreview" BorderWidth="1px" CssClass="modalPopup dataheaderPopup"
                        runat="server" Style="display: none">
                        <table class="w-100p dialogHeader">
                            <tr class="w-100p">
                                <td class="a-left">
                                    <asp:Label ID="lblReport" runat="server" Text="Report" CssClass="a-left"></asp:Label>
                                </td>
                                <td class="a-right">
                                    <%--<asp:Button ID="btnclose" runat="server" CssClass="a-left"></asp:Button>--%>
                                    <img id="btnclose" src="../Images/dialog_close_button.png" runat="server" onclick="return HidePopup();"
                                        alt="Close" style="cursor: pointer;" />
                                </td>
                            </tr>
                        </table>
                        <div id="iframeplaceholder" class="w-100p" style="height: auto;">
                        </div>
                    </asp:Panel>
                </td>
            </tr>
        </table>
        <div>
            <table class="w-100p">
                <tr>
                    <td>
                        <asp:GridView ID="grdResult" runat="server" CssClass="w-100p gridView" AutoGenerateColumns="false"
                            EmptyDataText="No Matching Records Found" OnRowDataBound="grdResult_RowDataBound"
                            DataKeyNames="QuotationID">
                            <Columns>
                                <asp:TemplateField HeaderText="select">
                                    <ItemTemplate>
                                        <asp:RadioButton ID="RdoSelect" runat="server" GroupName="select" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField Visible="false">
                                    <ItemTemplate>
                                        <asp:Label ID="lblVisitID" runat="server" Text='<%# Bind("QuotationID") %>' Visible="false"></asp:Label>
                                        <asp:RadioButton ID="select" runat="server" GroupName="select" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                               <%-- <asp:TemplateField HeaderText="Print">
                                    <ItemTemplate>
                                        <table class="w-100p">
                                            <tr>
                                                <td class="w-50p">
                                                    <asp:ImageButton ID="Image1" ImageUrl="../Images/WithStationary.ico" runat="server"
                                                        Style="cursor: pointer; margin-left: 10px; background-color: Transparent;" />
                                                </td>
                                                <td class="w-50p">
                                                    <img id="imgPrintReport" title="Print" runat="server" alt="Print" visible="true"
                                                        src="~/Images/printer.gif" style="cursor: pointer; background-color: Transparent;" />
                                                </td>
                                            </tr>
                                        </table>
                                    </ItemTemplate>
                                </asp:TemplateField>--%>
                                <asp:BoundField DataField="QuotationNo" HeaderText="Quotation Number" />
                                <asp:BoundField DataField="Others" HeaderText="Visit Number" />
                                <asp:BoundField DataField="Remarks" HeaderText="Visit Date" />
                                <asp:BoundField DataField="ClientName" HeaderText="Client Name" />
                                <asp:BoundField DataField="ClientID" HeaderText="ClientID" Visible="false" />
                                <asp:BoundField DataField="Status" HeaderText="Status" />
                                <asp:BoundField DataField="Branch" HeaderText="BioChemistry" />
                                <asp:BoundField DataField="SalesPerson" HeaderText="MicroBiology" />
                                <asp:BoundField DataField="" HeaderText="OutSource" />
                            </Columns>
                        </asp:GridView>
                    </td>
                </tr>
            </table>
        </div>
        <asp:HiddenField ID="hdnTargetCtlReportPreview" runat="server" />
        <ajc:ModalPopupExtender ID="mpReportPreview" runat="server" PopupControlID="pnlReportPreview"
            TargetControlID="hdnTargetCtlReportPreview" BackgroundCssClass="modalBackground"
            Enabled="True">
        </ajc:ModalPopupExtender>
        <%-- <table width='100%' cellspacing='0' cellpadding='2' border="1" id="TblReportTracking"
            class="beta w-100p" runat="server">
        </table>--%>
        <%--<div class="w-100p" id="ShowReport" runat="server">--%>
        <table class="w-100p" id="ddShowReport" runat="server" visible="false">
            <tr class="a-center">
                <td class="defaultfontcolor">
                    <asp:Label ID="lblSelectavisit" runat="server" Text=" Select a visit:" CssClass="a-Center"></asp:Label>
                    <asp:DropDownList ID="ddlVisitActionName" runat="server" CssClass="a-Center">
                    </asp:DropDownList>
                    <asp:Button ID="btnGo" runat="server" Text="Go" CssClass="btn" OnClick="btnGo_Click" />
                </td>
            </tr>
        </table>
        <%-- </div>--%><%--Investigation Report part added--%>
        <%--<table class="w-100p">
            <tr class="w-100p">
                <td class="w-100p">--%>
        <asp:Panel ID="dReport1" runat="server" Height="95%" ScrollBars="Vertical" CssClass="modalPopup dataheaderPopup w-65p"
            Enabled="True">
            <table class="w-100p">
                <tr>
                    <td id="pHeader" Cssclass="a-right">
                        <asp:Image ID="ImgCollapse" runat="server" />
                        <asp:Label ID="lbltext" runat="server"></asp:Label>
                    </td>
                    <td class="a-right">
                        <img id="imgCloseReport" src="../Images/dialog_close_button.png" runat="server" alt="Close"
                            class="pointer" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:UpdatePanel ID="updatePanel1" runat="server">
                            <ContentTemplate>
                                <asp:Panel ID="dReport" runat="server" CssClass="w-65p" Enabled="True">
                                    <table class="w-100p">
                                        <tr>
                                            <td>
                                                <div runat="server">
                                                    <asp:Panel ID="report" runat="server">
                                                        <asp:DataList ID="grdResultTemp" runat="server" CellPadding="4" ForeColor="#333333"
                                                            RepeatDirection="Horizontal" RepeatColumns="2" OnItemDataBound="grdResultTemp_ItemDataBound"
                                                            OnItemCommand="grdResultTemp_ItemCommand">
                                                            <ItemStyle VerticalAlign="Top"></ItemStyle>
                                                            <ItemTemplate>
                                                                <table class="dataheaderInvCtrl searchPanel">
                                                                    <tr>
                                                                        <td class="v-top">
                                                                            <table cellpadding="5" class="colorforcontentborder w-100p">
                                                                                <tr>
                                                                                    <td class="Duecolor h-20">
                                                                                        <table class="w-100p">
                                                                                            <tr class="colorforcontent">
                                                                                                <td class="a-left">
                                                                                                    <asp:Label ID="lblReport" runat="server" Text=" Report"></asp:Label>
                                                                                                </td>
                                                                                                <td>
                                                                                                    <asp:CheckBox ID="chkEnableAll" runat="server" />
                                                                                                    <asp:Label ID="lblEnableALL" runat="server" Text="Reprint"></asp:Label>
                                                                                                </td>
                                                                                                <td class="a-right">
                                                                                                    &nbsp<asp:CheckBox ID="chkSelectAll" runat="server" />
                                                                                                    <asp:Label ID="lblSelectALL" runat="server" Text="Selectall"></asp:Label>
                                                                                                    <asp:Label runat="server" ID="lblReportID" Visible="False" Text='<%# Eval("TemplateID") %>'></asp:Label>
                                                                                                    <asp:Label runat="server" ID="lblReportname" Visible="False" Text='<%# Eval("ReportTemplateName") %>'></asp:Label>
                                                                                                    <asp:HiddenField ID="HdnTemplatename" runat="server" Value='<%# Eval("TemplateName") %>' />
                                                                                                </td>
                                                                                            </tr>
                                                                                        </table>
                                                                                    </td>
                                                                                </tr>
                                                                            </table>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <table cellpadding="5" class="colorforcontentborder w-100p">
                                                                                <tr>
                                                                                    <td>
                                                                                        <asp:DataList ID="grdResultDate" runat="server" CellPadding="4" ForeColor="#333333"
                                                                                            OnItemDataBound="grdResultDate_ItemDataBound" OnItemCommand="grdResultDate_ItemCommand"
                                                                                            RepeatColumns="2" RepeatDirection="Horizontal">
                                                                                            <ItemStyle VerticalAlign="Top" />
                                                                                            <ItemTemplate>
                                                                                                <table>
                                                                                                    <tr>
                                                                                                        <td>
                                                                                                            <asp:Label runat="server" Font-Bold="True" ID="lblCreatedAt" Text='<%# Eval("CreatedAt") %>'></asp:Label>
                                                                                                            <asp:Label runat="server" ID="lblDtReportID" Visible="False" Text='<%# Eval("TemplateID") %>'></asp:Label>
                                                                                                            <asp:Label runat="server" ID="lbldtReportname" Visible="False" Text='<%# Eval("ReportTemplateName") %>'></asp:Label>
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                    <tr>
                                                                                                        <td>
                                                                                                            <asp:DataList ID="dlChildInvName" RepeatColumns="1" runat="server" OnItemCommand="dlChildInvName_ItemCommand"
                                                                                                                OnItemDataBound="dlChildInvName_ItemDataBound" CssClass="w-100p">
                                                                                                                <ItemStyle VerticalAlign="Top" />
                                                                                                                <ItemTemplate>
                                                                                                                    <table>
                                                                                                                        <tr>
                                                                                                                            <td>
                                                                                                                                <asp:CheckBox ID="ChkBox" runat="server" />
                                                                                                                            </td>
                                                                                                                            <td>
                                                                                                                                <asp:Label runat="server" ID="lblInvname" Text='<%# Eval("InvestigationName") %> '></asp:Label>
                                                                                                                                <asp:Label CssClass="notification-bubble" runat="server" ID="lblPrintCount" Text='<%# Eval("PrintCount").ToString()=="0" ? "0" : Eval("PrintCount").ToString() %> '></asp:Label>
                                                                                                                                <asp:Label runat="server" Visible="False" ID="lblInvID" Text='<%# Eval("InvestigationID") %>'></asp:Label>
                                                                                                                                <asp:Label runat="server" ID="lblReportID" Visible="False" Text='<%# Eval("TemplateID") %>'></asp:Label>
                                                                                                                                <asp:Label runat="server" ID="lblReportname" Visible="False" Text='<%# Eval("ReportTemplateName") %>'></asp:Label>
                                                                                                                                <asp:Label runat="server" ID="lblAccessionNo" Visible="False" Text='<%# Eval("AccessionNumber") %>'></asp:Label>
                                                                                                                                <asp:Label runat="server" ID="lblPatientID" Visible="False" Text='<%# Eval("PatientID") %>'></asp:Label>
                                                                                                                                <asp:Label runat="server" ID="lbldeptid" Visible="False" Text='<%# Eval("DeptID") %>'></asp:Label>
                                                                                                                                <asp:Label runat="server" ID="lblStatus" Visible="False" Text='<%# Eval("Status") %>'></asp:Label>
                                                                                                                                <asp:Label ID="lblPackageName" runat="server" Text=""></asp:Label>
                                                                                                                            </td>
                                                                                                                            <td>
                                                                                                                                <asp:LinkButton ID="lnkShow" ForeColor="Black" Font-Bold="True" Font-Underline="True"
                                                                                                                                    runat="server" Visible="False" Text="Show" CommandName="ShowReport" OnClientClick="return ShowHideReport();"></asp:LinkButton>
                                                                                                                            </td>
                                                                                                                        </tr>
                                                                                                                    </table>
                                                                                                                </ItemTemplate>
                                                                                                            </asp:DataList>
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                </table>
                                                                                            </ItemTemplate>
                                                                                        </asp:DataList>
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td style="color: #000000;" class="a-center h-20">
                                                                                        <asp:LinkButton ID="lnkShowReport" runat="server" Text="ShowReport" CommandName="ShowReport"
                                                                                            OnClientClick="javascript:ValidateCheckBox();" CssClass="btn"></asp:LinkButton>
                                                                                    </td>
                                                                                </tr>
                                                                            </table>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </ItemTemplate>
                                                        </asp:DataList>
                                                    </asp:Panel>
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                    <cc1:CollapsiblePanelExtender ID="CollapsiblePanelExtender1" runat="server" TargetControlID="report"
                                        TextLabelID="lbltext" CollapseControlID="pHeader" ExpandControlID="pHeader" Collapsed="False"
                                        CollapsedText="Show Report Details" ExpandedText="Hide Report Details" ImageControlID="ImgCollapse"
                                        ExpandedImage="../Images/showBids.gif" CollapsedImage="../Images/hideBids.gif"
                                        Enabled="True">
                                    </cc1:CollapsiblePanelExtender>
                                </asp:Panel>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Panel runat="server">
                            <table style="display: table;" class="w-100p">
                                <tr>
                                    <td class="v-top">
                                        <rsweb:ReportViewer ID="rReportViewer" runat="server" ProcessingMode="Remote" Font-Names="Verdana"
                                            Font-Size="8pt" WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt">
                                            <ServerReport ReportServerUrl="" />
                                        </rsweb:ReportViewer>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                    </td>
                </tr>
            </table>
        </asp:Panel>
        <cc1:ModalPopupExtender ID="ModalPopupExtender1" runat="server" PopupControlID="dReport1"
            TargetControlID="btnDummy" BackgroundCssClass="modalBackground" CancelControlID="imgCloseReport"
            DynamicServicePath="" Enabled="True">
        </cc1:ModalPopupExtender>
        <input type="button" id="btnDummy" runat="server" style="display: none;" />
        <ajc:ModalPopupExtender ID="modalPopUp" runat="server" DropShadow="false" PopupControlID="pnlOthers"
            BackgroundCssClass="modalBackground" Enabled="True" TargetControlID="btnDummy">
        </ajc:ModalPopupExtender>
        <asp:Panel ID="pnlOthers" runat="server" Style="display: none; height: 600px; width: 1050px;
            vertical-align: bottom; top: 80px;" meta:resourcekey="pnlOthersResource1">
            <table class="w-100p a-center">
                <tr>
                    <td class="a-right">
                        <img class="w-29 h-30 pointer" src="../Images/Close_Red_Online_small.png" alt="Close"
                            id="img2" onclick="ClosePopUp()" style="position: absolute; top: -8px; right: 10px;" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <iframe id="ifPDF" runat="server" width="1000" height="550"></iframe>
                    </td>
                </tr>
                <tr>
                    <td>
                        <input type="button" id="Button2" runat="server" style="display: none;" />
                    </td>
                </tr>
            </table>
        </asp:Panel>
        <%--</td>
            </tr>
        </table>--%>
        <%--End Investigation Report part--%>
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    <input id="hdnReportTrackingList" type="hidden" runat="server" value="" />
    <input id="hdnVisitID" type="hidden" runat="server" value="" />
    <input id="hdnRoleID" type="hidden" runat="server" value="" />
    <input id="hdnOrgID" type="hidden" runat="server" value="" />
    <input id="hdnCurrent" type="hidden" runat="server" value="" />
    <input type="hidden" id="patOrgID" runat="server" name="patOrgID" />
    <asp:HiddenField ID="hdnTemplateId" runat="server" />
    <input type="hidden" id="hdnVID" name="vid" runat="server" />
    <asp:HiddenField ID="hdnlstInvSelected" runat="server" />
    <asp:HiddenField ID="hdnHideReportTemplate" Value="1" runat="server" />
    <asp:HiddenField ID="HdnReportParameter" runat="server" />
    <asp:HiddenField ID="Hdndisablebox" runat="server" />
    <asp:HiddenField ID="HdnCheckBoxId" runat="server" />
    <input type="hidden" id="hdndeptid" runat="server" />
    <asp:HiddenField runat="server" ID="hdnPortNumber" />
    <asp:HiddenField runat="server" ID="hdnIpaddress" />
    <asp:HiddenField runat="server" ID="hdnPath" />
    <input type="hidden" id="ChkID" runat="server" />
    <asp:HiddenField ID="hdnMessages" runat="server" />
    </form>

    <script type="text/javascript">




        $(function() {
            $("#WaterstxtFrom").datepicker({
                dateFormat: 'dd/mm/yy',
                defaultDate: "+1w",
                changeMonth: true,
                changeYear: true,
                showOn: "both",
                buttonImage: "../images/Calendar_scheduleHS.png",
                buttonImageOnly: true,
                maxDate: 0,
                yearRange: '1900:2100',
                onClose: function(selectedDate) {
                    var date = $("#WaterstxtFrom").datepicker('getDate');
                }
            });
        });


        $(function() {
            $("#WaterstxtTo").datepicker({
                dateFormat: 'dd/mm/yy',
                defaultDate: "+1w",
                changeMonth: true,
                changeYear: true,
                showOn: "both",
                buttonImage: "../images/Calendar_scheduleHS.png",
                buttonImageOnly: true,
                maxDate: 0,
                yearRange: '1900:2100',
                onClose: function(selectedDate) {
                    var date = $("#WaterstxtTo").datepicker('getDate');
                }
            });
        });

        function HidePopup() {


            $find("mpReportPreview").hide();

            return false;



        }


        //        function ShowReportPreview() {


        //            $find("ModalPopupExtender1").show();

        //            return false;

        //        }

        function ValidateCheckBox() {
            /* Added By Venkatesh S */
            debugger;
            var AlertType = SListForAppMsg.Get('Investigation_InvestigationReport_aspx_Alert') == null ? "Alert" : SListForAppMsg.Get('Investigation_InvestigationReport_aspx_Alert');
            var vInvestigation = SListForAppMsg.Get('Investigation_InvestigationReport_aspx_22') == null ? "Select an investigation" : SListForAppMsg.Get('Investigation_InvestigationReport_aspx_22');

            var chkArrayMain = new Array();
            var count = 0;
            chkArrayMain = document.getElementById('HdnCheckBoxId').value.split('~');
            for (var i = 0; i < chkArrayMain.length; i++) {
                if (document.getElementById(chkArrayMain[i]).checked == true) {
                    count++;
                }
            }
            if (count > 0)
            { return true; } else {
                var userMsg = SListForApplicationMessages.Get('Investigation\\InvestigationReport.ascx_16');
                if (userMsg != null) {
                    alert(userMsg);
                    return false;
                } else {
                    //alert('Select an investigation');\
                    ValidationWindow(vInvestigation, AlertType);
                    return false;
                }

            }

        }

        function ShowHideReport() {

            debugger;
            var hdnHideReportTemplate = document.getElementById('hdnHideReportTemplate');

            //return true;
            //            if (hdnHideReportTemplate != null && typeof hdnHideReportTemplate != 'undefined') {
            //                if (document.getElementById('hdnHideReportTemplate').value == "1") {
            //                    showResponses('ACX3plus1', 'ACX3minus1', 'ACX3responses1', 0);
            //                    showResponses('ACX3plus2', 'ACX3minus2', 'ACX3responses2', 1);
            //                }
            //                else {
            //                    showResponses('ACX3plus1', 'ACX3minus1', 'ACX3responses1', 1);
            //                    showResponses('ACX3plus2', 'ACX3minus2', 'ACX3responses2', 0);
            //                }
            //            }
        }

        function ValidateClick() {

            if (document.getElementById('WaterstxtFrom').value != '' && document.getElementById('WaterstxtFrom').value != '') {


                return true;

            }
            else {

                ValidationWindow('Please enter From and To Date', 'Alert');
                return false;
            
            
            }
        
        
        
        }

    </script>

</body>
</html>
