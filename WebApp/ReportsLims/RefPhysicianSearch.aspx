<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RefPhysicianSearch.aspx.cs"
    Inherits="ReportsLims_RefPhysicianSearch" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>
        <%=Resources.ReportsLims_AppMsg.ReportsLims_RefPhysicianSearch_aspx_hdr %>
    </title>
    <link href="../Images/favicon.ico" rel="shortcut icon" />  

    <script src="../Scripts/CommonBilling.js" type="text/javascript"></script>

    <link type="text/css" href="../StyleSheets/jquery-ui-1.8.19.custom.css" rel="stylesheet" />

    <script language="javascript" type="text/javascript">
        function validateToDate() {

            var AlrtWinHdr = SListForAppMsg.Get("ReportsLims_DiscountReportLims_aspx_winhdr") != null ? SListForAppMsg.Get("ReportsLims_DiscountReportLims_aspx_winhdr") : "Alert";
            var UsrMsgDisp = SListForAppMsg.Get("ReportsLims_RefPhysicianSearch_aspx_01") != null ? SListForAppMsg.Get("ReportsLims_RefPhysicianSearch_aspx_01") : "Provide / select valid Ref Physician Name";
            var UsrMsgDisp1 = SListForAppMsg.Get("ReportsLims_BillWiseDeptCollectionReportLims_aspx_02") != null ? SListForAppMsg.Get("ReportsLims_BillWiseDeptCollectionReportLims_aspx_02") : "Provide / select value for From date";
            var UsrMsgDisp2 = SListForAppMsg.Get("ReportsLims_BillWiseDeptCollectionReportLims_aspx_03") != null ? SListForAppMsg.Get("ReportsLims_BillWiseDeptCollectionReportLims_aspx_03") : "Provide / Select Value for To date";
            
                if (document.getElementById('txtInternalExternalPhysician').value != '')
                if (document.getElementById('hdnReferedPhyID').value == '0') {
                //alert('Provide / select valid Ref Physician Name');
                ValidationWindow(UsrMsgDisp, AlrtWinHdr);
                    document.getElementById('txtInternalExternalPhysician').focus();
                    return false;
                }
            }
            if (document.getElementById('txtFDate').value == '') {
                // alert('Provide / select value for From date');
                ValidationWindow(UsrMsgDisp1, AlrtWinHdr);
                document.getElementById('txtFDate').focus();
                return false;
            }
            if (document.getElementById('txtTDate').value == '') {
                //alert('Provide / select value for To date');
                ValidationWindow(UsrMsgDisp2, AlrtWinHdr);
                document.getElementById('txtTDate').focus();
                return false;
            }
        }
        function checkAll(obj1) {
            var checkboxCollection = document.getElementById('chkCategory').getElementsByTagName('input');

            for (var i = 0; i < checkboxCollection.length; i++) {
                if (checkboxCollection[i].type.toString().toLowerCase() == "checkbox") {
                    checkboxCollection[i].checked = obj1.checked;
                }
            }
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
    <form id="form1" runat="server">
   <asp:ScriptManager ID="scriptManager1" runat="server">
    </asp:ScriptManager>
        <Attune:Attuneheader ID="Attuneheader" runat="server" />
                    <div class="contentdata">

                       <%-- <script type="text/javascript" src="../Scripts/jquery-1.7.2.min.js"></script>

                        <script type="text/javascript" src="../Scripts/jquery-ui-1.8.19.custom.min.js"></script>--%>

                        <script type="text/javascript">
                            $(function() {
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
                            });
                            function clearContextText() {
                                $('#contentArea').hide();

                            }
                        </script>

        <triggers>
                <asp:PostBackTrigger ControlID="lnkExportXL" />
                <asp:PostBackTrigger ControlID="imgBtnXL" />
            </triggers>
        <table id="tblCollectionOPIP" class="dataheader2 defaultfontcolor a-center w-100p">
            <tr>
                <td class="a-left">
                    <div class="dataheaderWider">
                        <table id="tbl" class="w-100p">
                            <tr>
                                <td>
                                    <asp:Label ID="lblOrgs" runat="server" Text="ReferringPhysician" meta:resourcekey="lblOrgsResource1"></asp:Label>
                                </td>
                                                <td id="tdRefDrParttxt" runat="server">
                                                                    <asp:TextBox ID="txtInternalExternalPhysician" runat="server" CssClass="Txtboxlarge" meta:resourcekey="txtSearchPhysicianNameResource1"
                                                                                ToolTip="Refering Physician(Doctor) Name"></asp:TextBox>
                                                                    <ajc:AutoCompleteExtender ID="AutoCompleteExtenderRefPhy" runat="server" CompletionInterval="1"
                                                                        CompletionListCssClass="wordWheel listMain .box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                                        CompletionListItemCssClass="wordWheel itemsMain" CompletionSetCount="10" EnableCaching="false" 
                                                                        FirstRowSelected="true" MinimumPrefixLength="2" OnClientItemSelected="PhysicianSelected"
                                                                        ServiceMethod="GetRateCardForBilling" ServicePath="~/OPIPBilling.asmx" OnClientItemOver="PhysicianTempSelected"
                                                                        TargetControlID="txtInternalExternalPhysician">
                                                                    </ajc:AutoCompleteExtender>
                                                                </td>
                                                                <%--<td>
                                                                 <asp:Label ID="Label1" runat="server" Text="Category"></asp:Label>
                                                                </td>
                                                                <td>
                                                                       <asp:DropDownList ID="ddlcategory" runat="server" Height="20px" Width="273px">                                                                                                                                       
                                                                    </asp:DropDownList>  
                                                                    </td>   --%>                                            
                                                <td>
                                                    <asp:Label ID="Rs_FromDate" Text="From Date:" runat="server" meta:resourcekey="Rs_FromDateResource1"></asp:Label>
                                                    <asp:TextBox ID="txtFDate" CssClass="Txtboxsmall" Width="70px" runat="server" meta:resourcekey="txtFDateResource1"></asp:TextBox>                                                    
                                                </td>
                                                <td>
                                                    <asp:Label ID="Rs_ToDate" Text="To Date:" runat="server" meta:resourcekey="Rs_ToDateResource1"></asp:Label>
                                                    <asp:TextBox ID="txtTDate" CssClass="Txtboxsmall" Width="70px" runat="server" meta:resourcekey="txtTDateResource1"></asp:TextBox>                                                   
                                                <td>
                                                    <asp:Button ID="btnSubmit" runat="server" Text="Get Report" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                       OnClick="btnSubmit_Click"   onmouseout="this.className='btn'" OnClientClick="javascript:return validateToDate();"
                                                      meta:resourcekey="btnSubmitResource1" />
                                                </td>
                                                <td>
                                                    <asp:LinkButton ID="lnkBack" Text="Back" Font-Underline="True" runat="server" CssClass="details_label_age"
                                                     OnClick="lnkBack_Click"  meta:resourcekey="lnkBackResource1"></asp:LinkButton>
                                                </td>
                                            </tr>  
                                                <tr>
                                <td colspan="2">
                                    <asp:ImageButton ID="imgBtnXL" OnClientClick="if(getElementById('hdnXLFlag').value!='1' || getElementById('GridRefPhysician')== undefined ) { alert('No Records to Export');return false;} return true;"
                                        runat="server" ImageUrl="../Images/ExcelImage.GIF" ToolTip="Save As Excel" Style="width: 16px"
                                        meta:resourcekey="imgBtnXLResource1" />
                                    <asp:LinkButton ID="lnkExportXL" Text="Export To XL" Font-Underline="True" OnClientClick="if(getElementById('hdnXLFlag').value!='1' || getElementById('GridRefPhysician')== undefined ) { alert('No Records to Export');return false;} return true;"
                                        runat="server" Font-Bold="True" Font-Size="12px" ForeColor="Black" ToolTip="Save As Excel"
                                        meta:resourcekey="lnkExportXLResource1" OnClick="lnkExportXL_Click"></asp:LinkButton>
                                    <input type="hidden" runat="server" value="0" id="hdnXLFlag" />
                                                </td>
                                            </tr>  
                                                <tr>
                                                 <td>
                                                    <ajc:CollapsiblePanelExtender ID="CollapsiblePanelExtender1" runat="server" TargetControlID="CategoryPanel"
                                                        CollapseControlID="pHeader" ExpandControlID="pHeader" Collapsed="true" TextLabelID="lblText"
                                                        CollapsedText="ShowCategoryLists " ExpandedText="HideCategoryLists" ImageControlID="ImgCollapse"
                                        ExpandedImage="../Images/ShowBids.gif" CollapsedImage="../Images/HideBids.gif"
                                        Enabled="True" meta:resourcekey="CollapsiblePanelExtender1" >
                                                    </ajc:CollapsiblePanelExtender>
                                                </td>
                                            </tr>
                                                                   
                                        </table>
                                    </div>
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
                    <asp:Panel ID="CategoryPanel" runat="server" class="bg-row" meta:resourcekey="CategoryPanelResource1">
                        <asp:CheckBox ID="ChkboxAll" Text="ALL" runat="server" CssClass="smallfon" onclick="checkAll(this)"
                            meta:resourcekey="ChkboxAllResource1" />
                        <asp:CheckBoxList ID="chkCategory" runat="server" RepeatColumns="6" RepeatDirection="Horizontal"
                            CssClass="smallfon" meta:resourcekey="chkCategoryResource1">
                        </asp:CheckBoxList>
                                                                <asp:AsyncPostBackTrigger ControlID="ddlTrustedOrg" EventName="SelectedIndexChanged" />
                                                    </asp:Panel> 
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
                                                <div id="divOPDWCR" runat="server" style="display: none;">
                                                    <div id="prnReport">
                            <table class="w-100p">
                                <tr>
                                    <td>
                                        <div id="div1" runat="server" style="display: block;">
                                            <div id="Div2" style="font-family: Arial; text-decoration: none; font-size: 10px;">
                                                <asp:GridView ID="GridRefPhysician" runat="server" AutoGenerateColumns="False" Width="100%"
                                                    AllowPaging="False" CellPadding="1" CssClass="mytable1" EmptyDataText="Details Not Available"
                                                    Font-Names="verdana" >
                                                                                        <HeaderStyle CssClass="dataheader1" />
                                                    <RowStyle HorizontalAlign="Left" Font-Size="10px" />
                                                    <Columns>
                                                <asp:BoundField DataField="RefPhyName" HeaderText="Referring Physician Name" meta:resourcekey="BoundFieldResource2">
                                                    <ItemStyle HorizontalAlign="Left" Wrap="False" Width="40px"></ItemStyle>
                                                </asp:BoundField>
                                                <asp:BoundField DataField="Remarks" Visible="false" HeaderText="Category" meta:resourcekey="BoundFieldResource3">
                                                    <ItemStyle Width="25px" HorizontalAlign="Center" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="FeeDescription" HeaderText="Investigation Name / Group"
                                                    meta:resourcekey="BoundFieldResource4">
                                                    <ItemStyle Width="25px" HorizontalAlign="Center" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="FeeId" HeaderText="No of Investigations " meta:resourcekey="BoundFieldResource5">
                                                    <ItemStyle Width="25px" HorizontalAlign="Center" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="Amount" HeaderText="Referal Pay out" meta:resourcekey="BoundFieldResource6">
                                                    <ItemStyle Width="25px" HorizontalAlign="Center" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="Rate" HeaderText="Net Amount" meta:resourcekey="BoundFieldResource7">
                                                    <ItemStyle Width="25px" HorizontalAlign="Center" />
                                                </asp:BoundField>
                                            </Columns>
                                            <FooterStyle BackColor="White" ForeColor="#000066" />
                                            <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                            <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                            <HeaderStyle CssClass="grdcolor" Font-Bold="True" />
                                        </asp:GridView>
                                            </div>
                                        </div>
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td class="a-right">
                                                                                    <b>
                                            <asp:Label ID="lblDiscountAmount" runat="server" Font-Bold="True" ForeColor="Red"
                                                meta:resourcekey="lblDiscountAmountResource1"></asp:Label></b>
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                        <br />
                                                        
                                                    </div>
                                                </div>                                                 
                                        <input id="hdnReferedPhyID" type="hidden" value="0" runat="server" />
                                        <input id="hdnReferedPhyName" type="hidden" value="" runat="server" />
                                        <input id="hdnReferedPhysicianCode" type="hidden" value="0" runat="server" />
                                        <input id="hdnReferedPhyType" type="hidden" value="" runat="server" />
                                        <asp:HiddenField ID="hdnFromDate" runat="server" />
                                        <asp:HiddenField ID="hdnToDate" runat="server" />
                                    </div>
        <Attune:Attunefooter ID="Attunefooter" runat="server" />                         
    </form>
</body>
</html>
