<%@ Page Language="C#" AutoEventWireup="true" CodeFile="QuotationRegistration.aspx.cs"
    Inherits="Waters_QuotationRegistration" %>

<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/BillingPart.ascx" TagName="BPart" TagPrefix="BillingPart" %>
<%@ Register Src="../CommonControls/PaymentTypeDetails.ascx" TagName="paymentType"
    TagPrefix="Payment" %>
<%@ Register Src="../CommonControls/OtherCurrencyReceived.ascx" TagName="OtherCurrencyDisplay"
    TagPrefix="OtherCurrency" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .hidden
        {
            display: none;
        }
    </style>
</head>
<body>

    <script src="Waters.js" type="text/javascript"></script>

    <script src="Scripts/CommonQuotation.js" type="text/javascript"></script>

    <script src="../Scripts/CommonBilling.js" type="text/javascript"></script>

    <script src="Waters.js" type="text/javascript"></script>

    <script type="text/javascript" src="../Scripts/datetimepicker_css.js"></script>

    <%--<script type="text/javascript">--%>

    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
        <Services>
            <asp:ServiceReference Path="~/OPIPBilling.asmx" />
            <asp:ServiceReference Path="~/WebService.asmx" />
        </Services>
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata quotMaster">
        <div id="QuotationDetails" runat="server">
            <asp:Panel ID="pnlRegistration"  GroupingText="Registration Page"  runat="server">
                <table class="w-100p searchQuotation searchPanel">
                    <tr runat="server" visible="false">
                        <td class="w-13p">
                            <asp:Label ID="lblSearchBy" runat="server" Text="Search By"></asp:Label>
                            <asp:RadioButton ID="rdoSearchBy" runat="server"></asp:RadioButton>
                            <asp:Label ID="lblQuotation" runat="server" Text="Quotation"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblQuotationNo" Text="Quotation No" runat="server" />
                        </td>
                        <td>
                            <asp:TextBox ID="txtQuotationNo" runat="server" CssClass="small"></asp:TextBox>
                            &nbsp;<img src="../Images/starbutton.png" alt="" class="v-middle" />
                            <ajc:AutoCompleteExtender ID="AutoCompleteExtenderQuotationNo" runat="server" TargetControlID="txtQuotationNo"
                                CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" EnableCaching="False"
                                MinimumPrefixLength="4" CompletionInterval="0" ServiceMethod="GetQuotationNumber"
                                OnClientItemSelected="SelectedQuotationNumber" ServicePath="~/OPIPBilling.asmx"
                                DelimiterCharacters="" Enabled="True" UseContextKey="True">
                            </ajc:AutoCompleteExtender>
                        </td>
                        <td>
                            <asp:Label ID="lblRegClientName" Text="Client Name" runat="server" />
                        </td>
                        <td>
                            <input type="hidden" id="txtClient" runat="server" />
                            <asp:DropDownList ID="ddlClientName" class="ddlsmall" runat="server">
                            </asp:DropDownList>
                        </td>
                        <td>
                            <asp:Label ID="lblRegAddress" Text="Address" runat="server" />
                        </td>
                        <td>
                            <asp:TextBox ID="txtRegAddress" runat="server" CssClass="small"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblRegCity" Text="City" runat="server" />
                        </td>
                        <td>
                            <asp:TextBox ID="txtRegCity" runat="server" CssClass="small"></asp:TextBox>
                        </td>
                        <td>
                            <asp:Label ID="lblRegState" Text="State" runat="server" />
                        </td>
                        <td>
                            <select id="ddState" runat="server" class="ddlsmall" onchange="javascript:onchangeState();">
                            </select>
                            &nbsp;<img src="../Images/starbutton.png" alt="" class="v-middle" />
                        </td>
                        <td>
                            <asp:Label ID="lblRegCountry" Text="Country" runat="server" />
                        </td>
                        <td>
                            <asp:DropDownList ID="ddCountry" runat="server" onchange="javascript:loadState();"
                                CssClass="ddlsmall">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblRegCollectedTime" Text="Collected Time" runat="server" />
                        </td>
                        <td>
                            <asp:TextBox ID="txtRegCollectedTime" runat="server" CssClass="small"></asp:TextBox>
                            <img src="../images/Calendar_scheduleHS.png" id="img2" alt="Pick a date"></a>
                        </td>
                        <td>
                            <asp:Label ID="lblRegSalesPerson" Text="Sales Person" runat="server" />
                        </td>
                        <td>
                            <asp:TextBox ID="txtRegSalesPerson" runat="server" CssClass="small"></asp:TextBox>
                        </td>
                        <td>
                            <asp:Label ID="lblRegBranch" Text="Branch" runat="server" />
                        </td>
                        <td>
                            <asp:TextBox ID="txtRegBranch" runat="server" CssClass="small"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblRegDispatchMode" Text="Dispatch Mode" runat="server" />
                        </td>
                        <td>
                            <asp:CheckBox ID="chkRegEmail" runat="server" Text="Email" />
                            <asp:CheckBox ID="chkRegSMS" runat="server" Text="SMS" />
                        </td>
                        <td>
                            <asp:Label ID="lblRegFileUpload" runat="server" Text="File Upload" />
                        </td>
                        <td>
                            <asp:FileUpload ID="FileUpload1" runat="server" accept="gif|GIF|jpg|JPG|png|PNG|bmp|BMP|jpeg|JPEG|pdf|PDF"
                                class="multi" />
                        </td>
                    </tr>
                </table>
            </asp:Panel>
        </div>
        <div runat="server">
            <asp:Panel runat="server" GroupingText="Test Names">
                <div id="divTestName" runat="server">
                </div>
            </asp:Panel>
        </div>
        <div class="paddingT10">
            <div class="paddingT10" id="divGrid" runat="server">
            </div>
            <asp:Panel ID="PanelTestGroup" runat="server" Style="height: 500px; width: 90%; margin: 0 auto;"
                CssClass="modalPopup dataheaderPopup" CancelControlID="Butclose" Enabled="True">
                <table class="w-100p gridView">
                    <tr>
                        <td>
                            <asp:Label ID="PopUptxtTestName" runat="server" Text="Dummy" />
                        </td>
                        <td>
                            <asp:Label ID="PopUplblSample" runat="server" Text="Sample:" />
                            <asp:Label ID="PopUptxtSample" runat="server" />
                        </td>
                        <td>
                            <asp:Label ID="PopUplblSampleCollectedTime" runat="server" Text="SampleCollectedTime:" />
                            <asp:Label ID="PopUptxtSampleCollectedTime" runat="server" />
                        </td>
                    </tr>
                </table>
                <br />
                <br />
                <table class="w-100p">
                    <tr>
                        <td>
                            <div id="PopUpPkg" class="bg-row w-100p" style="overflow: auto; border: 2px; border-color: #fff;
                                max-height: 300px;">
                            </div>
                        </td>
                    </tr>
                </table>
                <div class="a-center">
                
                <button id="btnUpdate" runat="server" class="btn" onclick="return UpdatePKGList();">
                        Save</button>
                    <button id="btnPopupCancel" runat="server" class="btn" onclick="return CancelRegistrationPopup();">
                        Close</button>
                    
                </div>
            </asp:Panel>
            <ajc:ModalPopupExtender ID="ModalPopupShow1" runat="server" BackgroundCssClass="modalBackground"
                PopupControlID="PanelTestGroup" Enabled="True" TargetControlID="btnDummy" DynamicServicePath="">
            </ajc:ModalPopupExtender>
            <input type="button" id="btnDummy" runat="server" style="display: none;" />
        </div>
        <div id="divBillingPart" runat="server">
            <BillingPart:BPart ID="billPart" runat="server" />
        </div>
        <div>
            <asp:UpdatePanel ID="updatePanel1" runat="server">
                <ContentTemplate>
                    <asp:Label ID="lblSampleReceivetime" runat="server" Text="Sample Receive Time" Visible="false" />
                    <asp:TextBox ID="txtSampleReceivetime" runat="server" Visible="false" onclick="NewCssCal(this.id,'ddmmyyyy','arrow',true,12,'','past');"></asp:TextBox>
                    <%--<input id="chkSampleReceivetime" type="checkbox" runat="server" title="Apply All"
                visible="false"  OncheckedChange="chkApplyAll_CheckedChanged" />--%>
                    <asp:CheckBox ID="chkSampleReceivetime" runat="server" AutoPostBack="true" Visible="false"
                        OnCheckedChanged="chkApplyAll_CheckedChanged" />
                    <asp:Label ID="lblApplyAll" runat="server" Text="Apply All" Visible="false"></asp:Label>
                    <%--<asp:CheckBox ID="chkSampleReceivetime" runat="server" Text="Apply All" Visible="false"  />--%>
                    <div id="divCollectSample" runat="server" style="overflow: auto; border: 1px; border-color: #fff;
                        max-height: 400px;">
                    </div>
                    <div>
                        <table class="w-100p">
                            <tr>
                                <td>
                                    <asp:GridView ID="grdCollectSample" runat="server" CssClass="w-100p gridView" AutoGenerateColumns="false"                                       OnRowDataBound="grdCollectSample_RowDataBound"
                                        EmptyDataText="No Matching Records Found">
                                        <Columns>
                                            <asp:TemplateField HeaderText="Test Name">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblName" runat="server" Text='<%# Eval("Name") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <%--<asp:BoundField DataField="Name" HeaderText="Test Name" />--%>
                                            <asp:TemplateField HeaderText="SampleType">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblSample" runat="server" Text='<%# Eval("SampleTypeID") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <%-- <asp:BoundField DataField="SampleTypeID" HeaderText="Sample" />--%>
                                            <%--<asp:BoundField DataField="" HeaderText="Container" />--%>
                                            <asp:TemplateField HeaderText="Container">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblContainer" runat="server" Text="Box"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="SampleID">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblSampleID" runat="server" Text='<%# Eval("Status") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <%--<asp:BoundField DataField="Status" HeaderText="Sample ID" />--%>
                                            <asp:TemplateField HeaderText="barcode">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblbarcode" runat="server" Text='<%# Eval("DiscountTypeID") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <%--<asp:BoundField DataField="DiscountTypeID"  HeaderText="barcode" />--%>
                                            <asp:TemplateField HeaderText="Status">
                                                <ItemTemplate>
                                                    <asp:DropDownList ID="drpStatus" DataSource='<%# LoadQuotationDropDownValues() %>'
                                                        DataTextField="DisplayText" DataValueField="Code" Style="width: 120px" runat="server">
                                                    </asp:DropDownList>
                                                    <%--<asp:Label ID="lblSampColPersonID" Visible="false" runat="server" Text='<%# Eval("CollectedBy") %>'></asp:Label>--%>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <asp:DropDownList ID="drpStatus" Style="width: 120px" DataSource='<%# LoadQuotationDropDownValues() %>'
                                                        DataTextField="DisplayText" DataValueField="Code" runat="server">
                                                    </asp:DropDownList>
                                                </EditItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Location">
                                                <ItemTemplate>
                                                    <asp:DropDownList ID="drplocation" DataSource='<%# LoadLocation() %>' DataTextField="Location"
                                                        DataValueField="AddressID" Style="width: 120px" runat="server" meta:resourcekey="drpSamColPersonResource1">
                                                    </asp:DropDownList>
                                                    <%--<asp:Label ID="lblSampColPersonID" Visible="false" runat="server" Text='<%# Eval("CollectedBy") %>'></asp:Label>--%>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <asp:DropDownList ID="drplocation" Style="width: 120px" DataSource='<%# LoadLocation() %>'
                                                        DataTextField="Location" DataValueField="AddressID" runat="server" meta:resourcekey="drpSamColPersonResource2">
                                                    </asp:DropDownList>
                                                    <%--  <asp:Label ID="lblSampColPersonID" Visible="false" runat="server" Text='<%# Eval("CollectedBy") %>'></asp:Label>--%>
                                                </EditItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Receive Time">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtReceiveTime" Style="width: 100px" onclick="javascript:NewCssCal(this.id,'ddmmyyyy','arrow',true,12,'','past')"
                                                        runat="server"></asp:TextBox>
                                                    <a id="GrdDatePic" onclick="javascript:NewCssCal(this.previousElementSibling.id,'ddmmyyyy','arrow',true,12,'','past')">
                                                        <img src="../images/Calendar_scheduleHS.png" visible="false" id="img2" alt="Pick a date"></a>
                                                    <%--  <asp:Label Text='<%# Eval("ScheduledTime") %>' runat="server" ID="lblOrnlSTime" Visible="false"></asp:Label>--%>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="txtReceiveTime" Style="width: 100px" onclick="javascript:NewCssCal(this.id,'ddmmyyyy','arrow',true,12,'','past')"
                                                        runat="server"></asp:TextBox>
                                                    <a id="GrdDatePic" onclick="javascript:NewCssCal(this.previousElementSibling.id,'ddmmyyyy','arrow',true,12,'','past')">
                                                        <img src="../images/Calendar_scheduleHS.png" id="img2" alt="Pick a date"></a>
                                                    <%--<asp:Label Text='<%# Eval("ScheduledTime") %>' runat="server" ID="lblOrnlSTime" Visible="false"></asp:Label>--%>
                                                </EditItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="InvestigationID" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblID" runat="server" Text='<%# Eval("ID") %>'></asp:Label>
                                                    <asp:HiddenField ID="hdnID" runat="server" Value='<%# Eval("ID") %>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <%--<asp:BoundField DataField="ID" HeaderText="InvestigationID"  ItemStyle-CssClass="hidden" />--%>
                                            <asp:TemplateField HeaderText="InvestigationsType" HeaderStyle-CssClass="hidden"
                                                ItemStyle-CssClass="hidden">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblInvestigationsType" runat="server" Text='<%# Eval("InvestigationsType") %>'></asp:Label>
                                                    <asp:HiddenField ID="hdnInvestigationType" runat="server" Value='<%# Eval("InvestigationsType") %>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <%-- <asp:BoundField DataField="InvestigationsType" HeaderText="Investigation Type" ItemStyle-CssClass="hidden" />--%>
                                            <asp:TemplateField HeaderText="DeptID" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblDeptID" runat="server" Text='<%# Eval("SampleCount") %>'></asp:Label>
                                                    <asp:HiddenField ID="hdnDeptID" runat="server" Value='<%# Eval("SampleCount") %>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <%--<asp:BoundField DataField="SampleCount" HeaderText="DeptID" ItemStyle-CssClass="hidden" />--%>
                                            <asp:TemplateField HeaderText="SampleContainerID" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblSampleContainerID" runat="server" Text='<%# Eval("OrgID") %>'></asp:Label>
                                                    <asp:HiddenField ID="hdnSampleContainerID" runat="server" Value='<%# Eval("OrgID") %>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <%--<asp:BoundField DataField="DiscountValue" HeaderText="SampleContainerID" ItemStyle-CssClass="hidden" />--%>
                                            <asp:TemplateField HeaderText="Sample Code" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblSampleCode" runat="server" Text='<%# Eval("DiscountValue") %>'></asp:Label>
                                                    <asp:HiddenField ID="hdnSampleCode" runat="server" Value='<%# Eval("DiscountValue") %>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <%-- <asp:BoundField DataField="DiscountTypeID" HeaderText="Sample Code" ItemStyle-CssClass="hidden" />--%>
                                        </Columns>
                                    </asp:GridView>
                                    <asp:UpdateProgress DynamicLayout="False" ID="UpdateProgress1" runat="server">
                                        <ProgressTemplate>
                                            <div id="progressBackgroundFilter" class="a-center">
                                            </div>
                                            <div id="processMessage" class="a-center w-20p">
                                                <asp:Image ID="img1" Width="40px" Height="40px" runat="server" ImageUrl="../Images/loading.GIF"
                                                    meta:resourcekey="img1Resource1" />
                                            </div>
                                        </ProgressTemplate>
                                    </asp:UpdateProgress>
                                </td>
                            </tr>
                        </table>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </div>
    <table class="w-100p">
        <tr>
            <td class="a-center">
                <asp:Button ID="btnGenerateBill" runat="server" Text="Generate Bill" OnClick="btnGenerateBill_onclick" />
                <asp:Button ID="btnClear" runat="server" Text="Clear" OnClick="btnClear_onClick" />
                <asp:Button ID="btnGenerateWorkOrder" runat="server" Text="Generate WorkOrder" OnClick="btnGenerateWorkOrder_onclick"
                    OnClientClick=" return SaveData();" Visible="false" />
                <asp:Button ID="btnCollectClear" runat="server" Text="Clear" OnClick="btnClear_onClick"
                    Visible="false" />
            </td>
        </tr>
    </table>
    </div>
    <asp:HiddenField ID="hdnMessages" runat="server" />
    <asp:HiddenField ID="hdnTestQuotationList" runat="server" Value="" />
    <asp:HiddenField ID="hdnRegPageType" runat="server" Value="" />
    <asp:HiddenField ID="hdnOrdereditems" runat="server" Value="" />
    <input id="hdnSelectedQuotationNo" type="hidden" value="0" runat="server" />
    <input id="hdnSelectedQuotationID" type="hidden" value="0" runat="server" />
    <asp:HiddenField ID="hdnGrossValue" runat="server" Value="0" />
    <input type="hidden" runat="server" value="Y" id="hdnIsCashClient" />
    <asp:HiddenField ID="hdnPopUpPkgID" runat="server" Value="" />
    <input id="hdnOrgID" type="hidden" value="0" runat="server" />
    <input id="hdnID" type="hidden" runat="server" />
    <input id="hdnFeeType" type="hidden" runat="server" />
    <input id="hdnPKGList" type="hidden" runat="server" />
    <input id="hdnPatientStateID" type="hidden" runat="server" />
    <input id="hdnPatientStateID1" type="hidden" runat="server" />
    <input id="hdnPatientID" type="hidden" runat="server" />
    <input id="hdnAppendTest" type="hidden" runat="server" />
    <input id="hdnCollectSampleList" type="hidden" runat="server" value="" />
    <input id="hdnLoadSampleStatus" type="hidden" runat="server" value="" />
    <input id="hdnRoleID" type="hidden" runat="server" value="" />
    <input id="hdnLocation" type="hidden" runat="server" value="" />
    <input id="hdnVisitID" type="hidden" runat="server" value="" />
    <input id="hdnDate" type="hidden" runat="server" value="" />
    <input id="hdnFinalTestList" type="hidden" runat="server" value="" />
    <input id="hdnDefaultRoundoff" type="hidden" runat="server" value="" />
    <input id="hdnTpaRoundoff" type="hidden" runat="server" value="" />
    <input id="hdnRoundOffType" type="hidden" runat="server" value="" />
    <input id="hdnTpaRoundOffType" type="hidden" runat="server" value="" />
    <input id="hdnClientID" type="hidden" runat="server" value="" />
    <input id="hdnDefaultLocationID" type="hidden" runat="server" value="" />
    <input id="hdnIsApplyAll" type="hidden" runat="server" value="" /><%--
    <input id="hdnSelectedCountry" type="hidden" runat="server" value="" />
    <input id="hdnSelectedState" type="hidden" runat="server" value="" />--%>
    <input id="hdnSelectedClientDetails" type="hidden" runat="server" value="" />
    <input id="HdnCoPay" type="hidden" runat="server" value="" />
    <input id="hdnCurrentDate" type="hidden" runat="server" value="" />
    
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    </form>
    <script type="text/javascript">
//        $(function() {
//            $("#txtRegCollectedTime").datepicker({
//                dateFormat: 'dd/mm/yy',
//                defaultDate: "+1w",
//                changeMonth: true,
//                changeYear: true,
//                showOn: "both",
//                buttonImage: "../images/Calendar_scheduleHS.png",
//                buttonImageOnly: true,
//                minDate: 0,
//                yearRange: '1900:2100',
//                onClose: function(selectedDate) {
//                    // $("#txtTo").datepicker("option", "minDate", selectedDate);

//                    var date = $("#txtRegCollectedTime").datepicker('getDate');
//                    //var d = new Date(date.getFullYear(), date.getMonth() + 1, 0);
//                    // $("#txtTo").datepicker("option", "maxDate", d);

//                }
//            });
//        });







   
    
    
    </script>
</body>
</html>
