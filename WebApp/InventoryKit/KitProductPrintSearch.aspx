<%@ Page Language="C#" AutoEventWireup="true" CodeFile="KitProductPrintSearch.aspx.cs"
    Inherits="InventoryKit_KitProductPrintSearch" culture="auto" meta:resourcekey="PageResource1" uiculture="auto" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Src="~/InventoryCommon/Controls/InventorySearch.ascx" TagName="InventorySearch"
    TagPrefix="uc2" %>
<%@ Register Src="~/PlatFormControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>KitProduct Print Search </title>

    <script type="text/javascript" language="JavaScript">

        function ShowRegDate() {
            document.getElementById('txtFromDate').value = "";
            document.getElementById('txtToDate').value = "";
            document.getElementById('txtFromPeriod').value = "";
            document.getElementById('txtToPeriod').value = "";
            document.getElementById('hdnTempFrom').value = "";
            document.getElementById('hdnTempTo').value = "";

            document.getElementById('hdnTempFromPeriod').value = "0";
            document.getElementById('hdnTempToPeriod').value = "0";
            if (document.getElementById('ddlRegisterDate').value == "0") {

                document.getElementById('txtFromDate').value = document.getElementById('hdnFirstDayWeek').value;
                document.getElementById('txtToDate').value = document.getElementById('hdnLastDayWeek').value;
                document.getElementById('txtFromDate').disabled = true;
                document.getElementById('txtToDate').disabled = true;
                document.getElementById('hdnTempFrom').value = document.getElementById('hdnFirstDayWeek').value;
                document.getElementById('hdnTempTo').value = document.getElementById('hdnLastDayWeek').value;

                //document.getElementById('divRegDate').style.display = 'block';
                //document.getElementById('divRegDate').style.display = 'block';
                $('#divRegDate').removeClass().addClass('show');
                document.getElementById('divRegDate').style.display = 'inline';
                document.getElementById('divRegDate').style.display = 'inline';
                //document.getElementById('divRegCustomDate').style.display = 'none';
                //document.getElementById('divRegCustomDate').style.display = 'none';
                $('#divRegCustomDate').removeClass().addClass('hide');
            }
            if (document.getElementById('ddlRegisterDate').value == "1") {
                document.getElementById('txtFromDate').disabled = true;
                document.getElementById('txtToDate').disabled = true;
                document.getElementById('txtFromDate').value = ToExternalDate(document.getElementById('hdnFirstDayMonth').value);
                document.getElementById('txtToDate').value = ToExternalDate(document.getElementById('hdnLastDayMonth').value);
                document.getElementById('hdnTempFrom').value = document.getElementById('hdnFirstDayMonth').value;
                document.getElementById('hdnTempTo').value = document.getElementById('hdnLastDayMonth').value;

                //document.getElementById('divRegDate').style.display = 'block';
                //document.getElementById('divRegDate').style.display = 'block';
                $('#divRegDate').removeClass().addClass('show');
                document.getElementById('divRegDate').style.display = 'inline';
                document.getElementById('divRegDate').style.display = 'inline';
                //document.getElementById('divRegCustomDate').style.display = 'none';
                //document.getElementById('divRegCustomDate').style.display = 'none';
                $('#divRegCustomDate').removeClass().addClass('hide');
            }
            if (document.getElementById('ddlRegisterDate').value == "2") {
                document.getElementById('txtFromDate').disabled = true;
                document.getElementById('txtToDate').disabled = true;
                document.getElementById('txtFromDate').value = ToExternalDate(document.getElementById('hdnFirstDayYear').value);
                document.getElementById('txtToDate').value = ToExternalDate(document.getElementById('hdnLastDayYear').value);
                document.getElementById('hdnTempFrom').value = document.getElementById('hdnFirstDayYear').value;
                document.getElementById('hdnTempTo').value = document.getElementById('hdnLastDayYear').value

                //document.getElementById('divRegDate').style.display = 'block';
                //document.getElementById('divRegDate').style.display = 'block';
                $('#divRegDate').removeClass().addClass('show');
                document.getElementById('divRegDate').style.display = 'inline';
                document.getElementById('divRegDate').style.display = 'inline';
                //document.getElementById('divRegCustomDate').style.display = 'none';
                //document.getElementById('divRegCustomDate').style.display = 'none';
                $('#divRegCustomDate').removeClass().addClass('hide');

            }
            if (document.getElementById('ddlRegisterDate').value == "3") {
                //document.getElementById('divRegDate').style.display = 'none';
                //document.getElementById('divRegDate').style.display = 'none';
                $('#divRegDate').removeClass().addClass('hide');
                //document.getElementById('divRegCustomDate').style.display = 'block';
                //document.getElementById('divRegCustomDate').style.display = 'block';
                $('#divRegCustomDate').removeClass().addClass('show');
                document.getElementById('divRegCustomDate').style.display = 'inline';
                document.getElementById('divRegCustomDate').style.display = 'inline';
                document.getElementById('hdnTempFromPeriod').value = "1";
                document.getElementById('hdnTempToPeriod').value = "1";

            }
            if (document.getElementById('ddlRegisterDate').value == "-1") {
                document.getElementById('txtFromDate').disabled = true;
                document.getElementById('txtToDate').disabled = true;

                //document.getElementById('divRegDate').style.display = 'none';
                //document.getElementById('divRegDate').style.display = 'none';
                $('#divRegDate').removeClass().addClass('hide');
                //document.getElementById('divRegCustomDate').style.display = 'none';
                //document.getElementById('divRegCustomDate').style.display = 'none';
                $('#divRegCustomDate').removeClass().addClass('hide');


            }
            if (document.getElementById('ddlRegisterDate').value == "4") {
                document.getElementById('txtFromDate').disabled = true;
                document.getElementById('txtToDate').disabled = true;

                //document.getElementById('divRegDate').style.display = 'none';
                //document.getElementById('divRegDate').style.display = 'none';
                $('#divRegDate').removeClass().addClass('hide');
                //document.getElementById('divRegCustomDate').style.display = 'none';
                //document.getElementById('divRegCustomDate').style.display = 'none';
                $('#divRegCustomDate').removeClass().addClass('hide');


            }
            if (document.getElementById('ddlRegisterDate').value == "5") {
                document.getElementById('txtFromDate').disabled = true;
                document.getElementById('txtToDate').disabled = true;
                document.getElementById('txtFromDate').value = ToExternalDate(document.getElementById('hdnLastWeekFirst').value);
                document.getElementById('txtToDate').value = ToExternalDate(document.getElementById('hdnLastWeekLast').value);
                document.getElementById('hdnTempFrom').value = document.getElementById('hdnLastWeekFirst').value;
                document.getElementById('hdnTempTo').value = document.getElementById('hdnLastWeekLast').value;

                //document.getElementById('divRegDate').style.display = 'block';
                //document.getElementById('divRegDate').style.display = 'block';
                $('#divRegDate').removeClass().addClass('show');
                document.getElementById('divRegDate').style.display = 'inline';
                document.getElementById('divRegDate').style.display = 'inline';
                //document.getElementById('divRegCustomDate').style.display = 'none';
                //document.getElementById('divRegCustomDate').style.display = 'none';
                $('#divRegCustomDate').removeClass().addClass('hide');
            }
            if (document.getElementById('ddlRegisterDate').value == "6") {
                document.getElementById('txtFromDate').disabled = true;
                document.getElementById('txtToDate').disabled = true;
                document.getElementById('txtFromDate').value = ToExternalDate(document.getElementById('hdnLastMonthFirst').value);
                document.getElementById('txtToDate').value = ToExternalDate(document.getElementById('hdnLastMonthLast').value);
                document.getElementById('hdnTempFrom').value = document.getElementById('hdnLastMonthFirst').value;
                document.getElementById('hdnTempTo').value = document.getElementById('hdnLastMonthLast').value;

                //document.getElementById('divRegDate').style.display = 'block';
                //document.getElementById('divRegDate').style.display = 'block';
                $('#divRegDate').removeClass().addClass('show');
                document.getElementById('divRegDate').style.display = 'inline';
                document.getElementById('divRegDate').style.display = 'inline';
                //document.getElementById('divRegCustomDate').style.display = 'none';
                //document.getElementById('divRegCustomDate').style.display = 'none';
                $('#divRegCustomDate').removeClass().addClass('hide');
            }
            if (document.getElementById('ddlRegisterDate').value == "7") {
                document.getElementById('txtFromDate').disabled = true;
                document.getElementById('txtToDate').disabled = true;
                document.getElementById('txtFromDate').value = ToExternalDate(document.getElementById('hdnLastYearFirst').value);
                document.getElementById('txtToDate').value = ToExternalDate(document.getElementById('hdnLastYearLast').value);
                document.getElementById('hdnTempFrom').value = document.getElementById('hdnLastYearFirst').value;
                document.getElementById('hdnTempTo').value = document.getElementById('hdnLastYearLast').value;

                //document.getElementById('divRegDate').style.display = 'block';
                //document.getElementById('divRegDate').style.display = 'block';
                $('#divRegDate').removeClass().addClass('show');
                document.getElementById('divRegDate').style.display = 'inline';
                document.getElementById('divRegDate').style.display = 'inline';
                //document.getElementById('divRegCustomDate').style.display = 'none';
                //document.getElementById('divRegCustomDate').style.display = 'none';
                $('#divRegCustomDate').removeClass().addClass('hide');
            }
        }
        
    </script>

<%--    <style type="text/css">
        .style3
        {
            height: 28px;
        }
    </style>--%>
</head>
<body id="Body1" oncontextmenu="return false;" runat="server">
    <form id="prFrm" runat="server" defaultbutton="btnKitSearch">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <attune:attuneheader ID="Attuneheader" runat="server" />
        <script type="text/javascript" language="javascript">
            var errorMsg = SListForAppMsg.Get("InventoryKit_Error") != null ? SListForAppMsg.Get("InventoryKit_Error") : "Alert";
            var InformationMsg = SListForAppMsg.Get("InventoryKit_Information") != null ? SListForAppMsg.Get("InventoryKit_Information") : "Information";
            var okMsg = SListForAppMsg.Get("InventoryKit_Ok") != null ? SListForAppMsg.Get("InventoryKit_Ok") : "Ok";
            var CancelMsg = SListForAppMsg.Get("InventoryKit_Cancel") != null ? SListForAppMsg.Get("InventoryKit_Cancel") : "Cancel";
   </script>
    <div class="contentdata">
        <ul>
            <li>
                
                <input type="hidden" id="hdnReceivedID" runat="server" />
                <input type="hidden" id="hdnProductId" runat="server" />
                <input type="hidden" id="tempTable" runat="server" />
                <input type="hidden" id="hdnProductList" runat="server" />
                <input type="hidden" id="hdnProductName" runat="server" />
                <input type="hidden" id="hdnTotalqty" runat="server" />
                <input type="hidden" id="hdnRowEdit" runat="server" />
            </li>
        </ul>
        <table class="w-100p">
            <tr>
                <td>
                    <div id="DivCustomer" runat="server">
                        <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                            <ContentTemplate>
                                <table class="w-100p searchPanel">
                                    <tr class="panelContent">
                                        <td class="a-left">
                                            <asp:Label ID="lblKitName" runat="server" Text="Select Kit Name" 
                                                meta:resourcekey="lblKitNameResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="ddlKitNames" CssClass="small" TabIndex="1" runat="server" 
                                                meta:resourcekey="ddlKitNamesResource1">
                                            </asp:DropDownList>
                                        </td>
                                        <td class="a-left">
                                            <asp:Label ID="lblBatchNo" runat="server" Text="Kit BatchNo" 
                                                meta:resourcekey="lblBatchNoResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" ID="txtKitBatchNo" CssClass="small" TabIndex="2" runat="server" 
                                                meta:resourcekey="txtKitBatchNoResource1"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr class="panelContent">
                                        <td class="a-left">
                                            <asp:Label ID="lblStatus" runat="server" Text="Status" 
                                                meta:resourcekey="lblStatusResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="ddlStatus" CssClass="small" runat="server" 
                                                meta:resourcekey="ddlStatusResource1">
                                               
                                            </asp:DropDownList>
                                        </td>
                                        <td class="a-left">
                                            <asp:Label ID="lblBillDate" runat="server" Text="Bill Date" 
                                                meta:resourcekey="lblBillDateResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="ddlRegisterDate" onChange="javascript:return ShowRegDate();"
                                                CssClass="small" runat="server" 
                                                meta:resourcekey="ddlRegisterDateResource1">
                                                
                                            </asp:DropDownList>
                                        </td>
                                        <td>
                                            <div id="divRegDate" class="hide" runat="server">
                                            <asp:Label ID="lblFromDate" runat="server" Text="From Date" 
                                                    meta:resourcekey="lblFromDateResource1"></asp:Label>
                                                
                                                <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" class="small" ID="txtFromDate" runat="server" 
                                                    meta:resourcekey="txtFromDateResource1"></asp:TextBox>
                                                <asp:Label ID="lblToDate" runat="server" Text="To Date" 
                                                    meta:resourcekey="lblToDateResource1"></asp:Label>
                                               
                                                <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" class="small" runat="server" ID="txtToDate" 
                                                    meta:resourcekey="txtToDateResource1"></asp:TextBox>
                                            </div>
                                            <div id="divRegCustomDate" runat="server"  class="hide">
                                            <asp:Label ID="Label1" runat="server" Text="From Date" 
                                                    meta:resourcekey="Label1Resource1"></asp:Label>
                                                
                                                <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" class="datePicker small" ID="txtFromPeriod" runat="server" 
                                                    meta:resourcekey="txtFromPeriodResource1"></asp:TextBox>
                                                <asp:Label ID="lblToDate1" runat="server" Text="To Date" 
                                                    meta:resourcekey="lblToDate1Resource1"></asp:Label>
                                                
                                                <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" class="datePicker small" runat="server" ID="txtToPeriod" 
                                                    meta:resourcekey="txtToPeriodResource1"></asp:TextBox>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr class="panelFooter">
                                        <td colspan="5"  class="a-center">
                                            <asp:Button ID="btnKitSearch" runat="server" Text="Search" CssClass="btn" 
                                                OnClick="btnKitSearch_Click" meta:resourcekey="btnKitSearchResource1" />
                                        </td>
                                    </tr>
                                </table>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                        <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                            <ContentTemplate>
                                <table id="tablebilID" runat="server" class="w-100p">
                                    <tr>
                                        <td>
                                            <div>
                                                <asp:Panel ID="pnlSerch" runat="server" CssClass="w-100p">
                                                    <table id="searchTab" runat="server" class="w-100p">
                                                        <tr>
                                                            <td>
                                                                <asp:GridView ID="grdResult" EmptyDataText="No Matching Records Found!"
                                                                    runat="server" AllowPaging="True" AutoGenerateColumns="False"
                                                                    DataKeyNames="ProductID,BatchNo" OnRowDataBound="grdResult_RowDataBound"
                                                                    OnPageIndexChanging="grdResult_PageIndexChanging" OnRowCommand="grdResult_RowCommand"
                                                                    PageSize="20" CssClass="gridView w-100p" 
                                                                    meta:resourcekey="grdResultResource1">
                                                                    <HeaderStyle CssClass="gridHeader" />
                                                                    <PagerStyle CssClass="gridPager" />
                                                                    <Columns>
                                                                        <asp:TemplateField HeaderText="Select" ControlStyle-CssClass="a-left" 
                                                                            meta:resourcekey="TemplateFieldResource1">
                                                                            <ItemTemplate>
                                                                                <asp:RadioButton ID="rdSel" runat="server" ToolTip="Select Row" 
                                                                                    GroupName="OrderSelect" meta:resourcekey="rdSelResource1" />
                                                                            </ItemTemplate>

<ControlStyle CssClass="a-left"></ControlStyle>
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="Kit No" 
                                                                            meta:resourcekey="TemplateFieldResource2">
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="lblBillID" Text='<%# Eval("ProductID") %>' runat="server" 
                                                                                   ></asp:Label>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                        <asp:BoundField DataField="ProductName" HeaderText="Product Name" 
                                                                            meta:resourcekey="BoundFieldResource1" />
                                                                        <asp:BoundField DataField="BatchNo" HeaderText="KitBatchNo" 
                                                                            meta:resourcekey="BoundFieldResource2" />
                                                                        <%--<asp:BoundField DataField="ExpiryDate" HeaderText="Created Date" 
                                                                            DataFormatString="{0:dd/MM/yyyy hh:mm tt}" 
                                                                            meta:resourcekey="BoundFieldResource3" />--%>
                                                                        <asp:TemplateField HeaderText="Created Date">
                                                                            <ItemTemplate>
                                                                                <span>
                                                                                    <%#((DateTime)DataBinder.Eval(Container.DataItem, "ExpiryDate")).ToString(DateTimeFormat)%></span>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                        <asp:BoundField DataField="LocationName" HeaderText="Location Name" 
                                                                            meta:resourcekey="BoundFieldResource4" />
                                                                        <asp:BoundField DataField="Name" HeaderText="Status" 
                                                                            meta:resourcekey="BoundFieldResource5" />
                                                                        <asp:TemplateField HeaderText="Barcode" 
                                                                            meta:resourcekey="TemplateFieldResource3">
                                                                            <ItemStyle CssClass="a-center" />
                                                                            <ItemTemplate>
                                                                                <asp:Button ID="btnBarcode" Text="Barcode" CssClass="btn" runat="server" 
                                                                                    CommandName="Barcode" 
                                                                                    CommandArgument='<%# Eval("ProductID")+","+ Eval("BatchNo") %>' 
                                                                                     />
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                        <asp:BoundField DataField="LocationID" HeaderText="LocationID" Visible="false" 
                                                                            meta:resourcekey="BoundFieldResource6" />
                                                                        <asp:BoundField DataField="ID" HeaderText="KitID" Visible="false" 
                                                                            meta:resourcekey="BoundFieldResource7" />
                                                                    </Columns>
                                                                </asp:GridView>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <input type="hidden" id="hdnpopUp" value="N" runat="server" />
                                                            </td>
                                                        </tr>
                                                        <tr id="tdgo" runat="server"  class="hide">
                                                            <td  class="a-center">
                                                            <asp:Label ID="lblRecord" Text="Select a Record and perform one of the following" 
                                                                    runat="server" meta:resourcekey="lblRecordResource1"></asp:Label>
                                                                
                                                                <asp:DropDownList ID="ddlAction" runat="server" Width="120px" 
                                                                    meta:resourcekey="ddlActionResource1">
                                                                </asp:DropDownList>
                                                                <asp:Button ID="btnGo" runat="server" Text="GO" CssClass="btn"
                                                                   OnClientClick="return CheckValidation();" OnClick="btnGo_Click" 
                                                                    meta:resourcekey="btnGoResource1" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </asp:Panel>
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                </td>
            </tr>
        </table>
    </div>
    <attune:attunefooter ID="Attunefooter" runat="server" />
    <input type="hidden" id="hdnKitID" runat="server" />
    <input type="hidden" id="hdnMasterKitID" runat="server" />
    <input type="hidden" id="hdnBatchNo" runat="server" />
    <input type="hidden" id="hdnStatus" runat="server" />
    <asp:HiddenField ID="hdnLID" runat="server" />
    <asp:HiddenField ID="hdnFirstDayWeek" runat="server" />
    <asp:HiddenField ID="hdnLastDayWeek" runat="server" />
    <asp:HiddenField ID="hdnFirstDayMonth" runat="server" />
    <asp:HiddenField ID="hdnLastDayMonth" runat="server" />
    <asp:HiddenField ID="hdnFirstDayYear" runat="server" />
    <asp:HiddenField ID="hdnLastDayYear" runat="server" />
    <asp:HiddenField ID="hdnDateImage" runat="server" />
    <asp:HiddenField ID="hdnTempFrom" runat="server" />
    <asp:HiddenField ID="hdnTempTo" runat="server" />
    <asp:HiddenField ID="hdnTempFromPeriod" runat="server" />
    <asp:HiddenField ID="hdnTempToPeriod" runat="server" />
    <asp:HiddenField ID="hdnLastMonthFirst" runat="server" />
    <asp:HiddenField ID="hdnLastMonthLast" runat="server" />
    <asp:HiddenField ID="hdnLastWeekFirst" runat="server" />
    <asp:HiddenField ID="hdnLastWeekLast" runat="server" />
    <asp:HiddenField runat="server" ID="hdnLastYearFirst" />
    <asp:HiddenField ID="hdnLastYearLast" runat="server" />
    <input id="hdnBarcode" runat="server" type="hidden" value="N" />
    <asp:HiddenField ID="hdnMessages" runat="server" />
    </form>
</body>
</html>
<script type="text/javascript" language="javascript">
    var userMsg;
    function INVRowCommon(rid, MasterKitID, BatchNo, KID, LID, Status) {
        var len = document.forms[0].elements.length;
        for (var i = 0; i < len; i++) {
            if (document.forms[0].elements[i].type == "radio") {
                document.forms[0].elements[i].checked = false;
            }
        }
        document.getElementById(rid).checked = true;
        document.getElementById("hdnKitID").value = KID;
        document.getElementById("hdnMasterKitID").value = MasterKitID;
        document.getElementById("hdnBatchNo").value = BatchNo;
        document.getElementById("hdnStatus").value = Status;
        //document.getElementById("tdgo").style.display = 'block';
        $('#tdgo').removeClass().addClass('show');
        document.getElementById('hdnLID').value = LID;

    }

    function CheckValidation() {

        if (document.getElementById('hdnMasterKitID').value == '') {
            var userMsg = SListForAppMsg.Get("InventoryKit_KitProductPrintSearch.aspx_aspx_01") == null ? "Select an KitBatch Product" : SListForAppMsg.Get("InventoryKit_KitProductPrintSearch.aspx_aspx_01");
            if (userMsg != null && errorMsg != null) {
                ValidationWindow(userMsg,errorMsg);
                return false;
            }
        }
        return true;
    }
    function barCode(KID, BatchNo, Orgid, categoryCode) {
        document.getElementById('hdnBarcode').value = 'Y';

        var url = '../VisitInfo/PrintBarcode.aspx?visitId=' + KID + '&sampleId=' + BatchNo + '&orgId=' + Orgid + '&categoryCode=' + categoryCode;

        var WinPrint = window.open(url, 'Window', 'width=750,height=650,top=50,left=50,toolbars=no,scrollbars=yes,status=no,resizable=yes');
    }

        
   
    </script>