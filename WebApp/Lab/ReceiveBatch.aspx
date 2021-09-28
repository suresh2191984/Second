<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ReceiveBatch.aspx.cs" Inherits="Lab_ReceiveBatch"
    EnableEventValidation="false" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/PatientDetails.ascx" TagName="PatientDetails"
    TagPrefix="ucPatientdet" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter"
    TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="../StyleSheets/TabMenu.css" rel="stylesheet" type="text/css" />

   <script type="text/javascript" src="../Scripts/datetimepicker_css.js"></script>

  <%--  <script src="../Scripts/jquery-1.8.1.min.js" type="text/javascript"></script>--%>

    <script src="../Scripts/ReceiveBatchSheet.js" type="text/javascript"></script>
      <%--<script src="../Scripts/jquery-1.8.1.min.js" type="text/javascript"></script>--%>

    <title>Receive Batch</title>

    <script type="text/javascript">
        function DisplayTab(tabName) {
            //alert("remove");
            $('#TabsMenu li').removeClass('active');
            if (tabName == 'SA') {
                // alert("sa");
                document.getElementById('txtBatchNo').value = "";
                document.getElementById('tdSearchBatch').style.display = 'block';
                $('#li1').addClass('active');
                document.getElementById('tdReceieveBatch').style.display = 'none';
            }
            if (tabName == 'RA') {
                // alert("ra");
                document.getElementById('tdSearchBatch').style.display = 'none';
                $('#li2').addClass('active');
                document.getElementById('tdReceieveBatch').style.display = 'block';
            }
        }
    </script>

    <script type="text/javascript">
        function validateVisit() {
            /* Added By Venkatesh S */
            var vFromdate = SListForAppMsg.Get('Lab_ReceiveBatch_aspx_05') == null ? "Select From Date" : SListForAppMsg.Get('Lab_ReceiveBatch_aspx_05');
            var vTodate = SListForAppMsg.Get('Lab_ReceiveBatch_aspx_01') == null ? "Select To Date" : SListForAppMsg.Get('Lab_ReceiveBatch_aspx_01');
            var vGreaterThenDateValidation = SListForAppMsg.Get('Lab_ReceiveBatch_aspx_02') == null ? "Enter To Date is not Greater than Current Date" : SListForAppMsg.Get('Lab_ReceiveBatch_aspx_02');
            var vFromDateValidation = SListForAppMsg.Get('Lab_ReceiveBatch_aspx_03') == null ? "Enter To Date as Greater than From Date" : SListForAppMsg.Get('Lab_ReceiveBatch_aspx_03');
            var vSelectStatus = SListForAppMsg.Get('Lab_ReceiveBatch_aspx_04') == null ? "Select the Status" : SListForAppMsg.Get('Lab_ReceiveBatch_aspx_04');
           var AlertType = SListForAppMsg.Get('Lab_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('Lab_Header_Alert');
           
            var date = new Date, day = date.getDate(), month = date.getMonth() + 1, year = date.getFullYear(), hour = date.getHours(), minute = date.getMinutes(), seconds = date.getSeconds(), ampm = hour > 12 ? "PM" : "AM";
            hour = hour % 12;
            hour = hour ? hour : 12; // zero = 12

            minute = minute > 9 ? minute : "0" + minute;
            seconds = seconds > 9 ? seconds : "0" + seconds;
            hour = hour > 9 ? hour : "0" + hour;


            var cur_date = day + "-" + month + "-" + year + " " + hour + ":" + minute + ":" + seconds + " " + ampm;



            var fromdate = document.getElementById('txtFrom').value;
            var todate = document.getElementById('txtTo').value;
            if (document.getElementById('txtFrom').value.trim() == '' || document.getElementById('txtFrom').value == null) {
                document.getElementById('txtFrom').focus();
                //alert('Select From Date');
                ValidationWindow(vFromdate, AlertType);
                return false;
            }
            if (document.getElementById('txtTo').value.trim() == '' || document.getElementById('txtTo').value == null) {
                document.getElementById('txtTo').focus();
                //alert('Select To Date');
                ValidationWindow(vTodate, AlertType);
                return false;
            }
            if (cur_date < todate) {
                //alert('Enter To Date is not Greater than Current Date');
                ValidationWindow(vGreaterThenDateValidation, AlertType);
                return false;
            }
            if (Date.parse(document.getElementById('txtFrom').value.trim()) > Date.parse(document.getElementById('txtTo').value.trim())) {
                //alert('Enter To Date as Greater than From Date');
                ValidationWindow(vFromDateValidation, AlertType);
                return false;
            }


            var ddlRegLocation = document.getElementById("ddlRegLocation");
            var ddlBatchStatus = document.getElementById("ddlBatchStatus");
            if (ddlRegLocation.options[ddlRegLocation.selectedIndex].value != '-1' && ddlBatchStatus.options[ddlBatchStatus.selectedIndex].value == '0') {
                //alert('Select the Status');
                ValidationWindow(vSelectStatus, AlertType);
                return false;
            }
        }
        function searchKeyPress(e) {
            //debugger;
            // look for window.event in case event isn't passed in
            if (typeof e == 'undefined' && window.event) { e = window.event; }
            if (e.keyCode == 13) {
                document.getElementById('btnSubmit').click();
            }
        }
    </script>

</head>
<body>
    <form id="form1" runat="server">
    
    <asp:ScriptManager ID="ctlTaskScriptMgr" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
        <asp:UpdatePanel ID="up1" runat="server">
            <ContentTemplate>
                <asp:UpdateProgress ID="Progressbar" AssociatedUpdatePanelID="up1" runat="server">
                    <ProgressTemplate>
                        <div id="progressBackgroundFilter" class="a-center">
                        </div>
                        <div id="processMessage" class="a-center w-20p">
                            <asp:Image ID="img1" Width="40px" Height="40px" runat="server" ImageUrl="../Images/loading.GIF"
                                meta:resourcekey="img1Resource1" />
                        </div>
                    </ProgressTemplate>
                </asp:UpdateProgress>
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <table class="w-100p searchPanel">
                            <tr>
                                <td class="v-top" colspan="2">
                                    <div id='TabsMenu' class="a-left">
                                        <ul>
                                            <li id="li1" class="active" onclick="DisplayTab('SA')"><a href="#"><span><%--Search Batch--%><%=Resources.Lab_ClientDisplay.Lab_ReceiveBatch_aspx_009%></span></a></li>
                                            <li id="li2" onclick="DisplayTab('RA')"><a href='#'><span><%--Receive Batch--%><%=Resources.Lab_ClientDisplay.Lab_ReceiveBatch_aspx_0010%></span></a></li>
                                        </ul>
                                    </div>
                                </td>
                            </tr>
                            <tr class="b-tab">
                                <td class="tabborder">
                                    <br />
                                </td>
                            </tr>
                            <tr>
                                <td id="tdSearchBatch">
                                    <table id="tblSearchBatch" class="a-center w-100p" runat="server">
                                        <tr>
                                            <td>
                                                <asp:Panel ID="pnlSearchBatch" CssClass="w-100p" runat="server" meta:resourcekey="pnlSearchBatchResource1">
                                                    <table cellpadding="2" class="dataheaderInvCtrl" cellspacing="2" class="w-100p">
                                                        <tr>
                                                            <td>
                                                                <table>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="lblRegLocation" runat="server" Text="Register Location" meta:resourcekey="lblRegLocationResource1"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <asp:DropDownList ID="ddlRegLocation" CssClass="ddlsmall" runat="server" meta:resourcekey="ddlRegLocationResource1">
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                            <td>
                                                                <table>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="lblBatchStatus" runat="server" Text="Batch Status" meta:resourcekey="lblBatchStatusResource1"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <asp:DropDownList ID="ddlBatchStatus" CssClass="ddlsmall" runat="server">
                                                                                <%--<asp:ListItem Value="0" meta:resourcekey="ListItemResource1">Select</asp:ListItem>
                                                                                <asp:ListItem Value="1" Selected="True" meta:resourcekey="ListItemResource2">Transferred</asp:ListItem>
                                                                                <asp:ListItem Value="2" meta:resourcekey="ListItemResource3">Received</asp:ListItem>--%>
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <table class="w-100p">
                                                                    <tr class="defaultfontcolor">
                                                                        <td>
                                                                            <asp:Label ID="lblFromDate" runat="server" Text="From Date" meta:resourcekey="lblFromDateResource1"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                        </td>
                                                                        <td id="datecheck" runat="server" class="a-left">
                                                                            <asp:TextBox runat="server" ID="txtFrom" MaxLength="25" size="25" CssClass="cssTextBox"
                                                                                meta:resourcekey="txtFromResource1"></asp:TextBox>
                                                                            <a href="javascript:NewCssCal('<% =txtFrom.ClientID %>','ddmmyyyy','arrow',true,12,'Y','Y')">
                                                                                <img src="../Images/Calendar_scheduleHS.png" width="16" height="16" border="0" alt="Pick a date"></a>
                                                                            &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                            <td>
                                                                <table class="w-100p">
                                                                    <tr class="defaultfontcolor">
                                                                        <td>
                                                                            <asp:Label ID="lblToDate" runat="server" Text="To Date" meta:resourcekey="lblToDateResource1"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                        </td>
                                                                        <td id="Td1" runat="server" class="a-left v-top">
                                                                            <asp:TextBox runat="server" ID="txtTo" MaxLength="25" size="25" CssClass="cssTextBox small"
                                                                                meta:resourcekey="txtToResource1"></asp:TextBox>
                                                                            <a href="javascript:NewCssCal('<% =txtTo.ClientID %>','ddmmyyyy','arrow',true,12,'Y','N')">
                                                                                <img src="../Images/Calendar_scheduleHS.png" width="16" height="16" border="0" alt="Pick a date"></a>
                                                                            &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="2" style="padding-left: -120px">
                                                                <div class="a-center">
                                                                    <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn" OnClick="btnSearch_Click"
                                                                        OnClientClick="javascript:return validateVisit();" meta:resourcekey="btnSearchResource1" />
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </asp:Panel>
                                                <table class="w-100p">
                                                    <tr>
                                                        <td>
                                                            <div id="divBatchDetails" runat="server" style="overflow: auto; height: auto;">
                                                                <asp:GridView ID="gvBatchDetails" runat="server" CssClass="w-100p gridView" AutoGenerateColumns="False"
                                                                    Height="12%" PageSize="20" PagerSettings-Mode="NextPrevious" AllowPaging="True"
                                                                    EmptyDataText="No Matching Records Found" CellPadding="3" CellSpacing="3" OnPageIndexChanging="gvBatchDetails_PageIndexChanging"
                                                                    meta:resourcekey="gvBatchDetailsResource1">
                                                                    <PagerStyle HorizontalAlign="Center" />
                                                                    <HeaderStyle CssClass="dataheader1" />
                                                                    <PagerSettings FirstPageText="" LastPageText="" Mode="NumericFirstLast" NextPageText="&gt;&gt;"
                                                                        PageButtonCount="5" PreviousPageText="&lt;&lt;" />
                                                                    <Columns>
                                                                        <asp:TemplateField HeaderText="SNo" meta:resourcekey="TemplateFieldResource1">
                                                                            <ItemTemplate>
                                                                                <%# ((GridViewRow)Container).RowIndex + 1%>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                        <asp:BoundField DataField="BatchNo" HeaderText="Batch Number" meta:resourcekey="BoundFieldResource1">
                                                                            <HeaderStyle HorizontalAlign="Left" />
                                                                            <ItemStyle Width="10%" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="Location" HeaderText="Location" meta:resourcekey="BoundFieldResource2">
                                                                            <HeaderStyle HorizontalAlign="Left" />
                                                                            <ItemStyle Width="20%" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="SendDateTime" HeaderText="Datetime" meta:resourcekey="BoundFieldResource3">
                                                                            <HeaderStyle HorizontalAlign="Left" />
                                                                            <ItemStyle Width="18%" />
                                                                        </asp:BoundField>
                                                                        <%--<asp:BoundField DataField="Country" HeaderText="Sender" ItemStyle-Width="150" />--%>
                                                                        <asp:BoundField DataField="sender" HeaderText="Sender" meta:resourcekey="BoundFieldResource4">
                                                                            <HeaderStyle HorizontalAlign="Left" />
                                                                            <ItemStyle Width="8%" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="RoundNo" HeaderText="Round No" meta:resourcekey="BoundFieldResource5">
                                                                            <HeaderStyle HorizontalAlign="Left" />
                                                                            <ItemStyle Width="10%" HorizontalAlign="center" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="ZoneLocality" HeaderText="Zone" meta:resourcekey="BoundFieldResource6">
                                                                            <HeaderStyle HorizontalAlign="Left" />
                                                                            <ItemStyle Width="10%" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="VisitId" HeaderText="VisitId" Visible="false" meta:resourcekey="BoundFieldResource7">
                                                                            <HeaderStyle HorizontalAlign="Left" />
                                                                            <ItemStyle Width="" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="Guid" HeaderText="Guid" Visible="false" meta:resourcekey="BoundFieldResource8">
                                                                            <HeaderStyle HorizontalAlign="Left" />
                                                                            <ItemStyle Width="10%" />
                                                                        </asp:BoundField>
                                                                        <asp:TemplateField HeaderText="Action" ItemStyle-HorizontalAlign="Center" ControlStyle-Font-Bold="true"
                                                                            ControlStyle-Width="55%" meta:resourcekey="TemplateFieldResource2">
                                                                            <ItemTemplate>
                                                                                <asp:LinkButton ID="lnkRedirect" Text="Receieve Batch" CommandArgument='<%# Eval("BatchNo") %>'
                                                                                    runat="server" OnClick="RedirectBatchNo" meta:resourcekey="lnkRedirectResource1" />
                                                                                <%-- <asp:LinkButton ID="LinkButton1" Text="Receieve Batch" CommandArgument='<%# Eval("BatchNo") %>'
                                                                                                runat="server" OnClientClick="RedirectBatchNo(this)" />
                                                                                            <asp:Label ID="lblBatchNo" runat="server" Text="<%# Eval("OrgID") %>" Style="display: none;"></asp:Label>--%>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                    </Columns>
                                                                </asp:GridView>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td id="tdReceieveBatch" style="display: none;">
                                    <table id="tblContent" class="a-left w-100p" runat="server">
                                        <tr>
                                            <td>
                                                <asp:Panel ID="pnlSearch" CssClass="w-100p" runat="server" meta:resourcekey="pnlSearchResource1">
                                                    <table cellpadding="2" class="dataheaderInvCtrl w-100p" cellspacing="2">
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="lblBatchNo" runat="server" Text="Batch No" meta:resourcekey="lblBatchNoResource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtBatchNo" runat="server" CssClass="small" onblur="javascript:GetSamplesForBatch();"
                                                                    meta:resourcekey="txtBatchNoResource1"></asp:TextBox>
                                                                &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                            </td>
                                                        </tr>
                                                        <tr id="trSampleBarcode">
                                                            <td>
                                                                <asp:Label ID="lblSampleBarcode" runat="server" Text="Barcode of Sample" meta:resourcekey="lblSampleBarcodeResource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtSampleBarcode" runat="server"  CssClass="small" meta:resourcekey="txtSampleBarcodeResource1" onkeypress="searchKeyPress(event);"></asp:TextBox>
                                                                &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                                <asp:Button ID="btnSubmit" runat="server" Text="submit" CssClass="btn" OnClientClick="javascript:ValidateSamples(); return false;"
                                                                    meta:resourcekey="btnSubmitResource1" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </asp:Panel>
                                                <div id="iframeplaceholder" class="a-center w-100p">
                                                    <iframe runat="server" id='iframeBarcode' name='iframeBarcode' style='position: absolute;
                                                        top: 0px; left: 0px; width: 0px; height: 0px; border: 0px; overfow: none; z-index: -1'>
                                                    </iframe>
                                                </div>
                                                <table id="tblLegends" runat="server" class="a-right w-100p" style="display: none;">
                                                    <tr class="w-100p">
                                                        <td colspan="5" class="w-100p">
                                                            <asp:TextBox ID="txtNew" Enabled="false" CssClass="w-10 h-10" BackColor="#FFEBCD"
                                                                runat="server" meta:resourcekey="txtNewResource1"></asp:TextBox>
                                                            <asp:Label ID="lblNew" Text="New Samples" runat="server" meta:resourcekey="lblNewResource1"></asp:Label>
                                                            <asp:TextBox ID="txtReceived" BackColor="#85BB65" CssClass="w-10 h-10" Enabled="False"
                                                                runat="server" meta:resourcekey="txtReceivedResource1"></asp:TextBox>
                                                            <asp:Label ID="lblReceived" runat="server" Text="Received Samples" meta:resourcekey="lblReceivedResource1"></asp:Label>
                                                            <asp:TextBox ID="txtYettoRecieved" BackColor="#6D6968" CssClass="w-10 h-10" Enabled="False"
                                                                runat="server" meta:resourcekey="txtYettoRecievedResource1"></asp:TextBox>
                                                            <asp:Label ID="lblYettoReceive" runat="server" Text="Yet to Receive" meta:resourcekey="lblYettoReceiveResource1"></asp:Label>
                                                            <asp:TextBox ID="txtAdditionalsamples" CssClass="w-10 h-10" BackColor="#F9B7FF" Enabled="False"
                                                                runat="server" meta:resourcekey="txtAdditionalsamplesResource1"></asp:TextBox>
                                                            <asp:Label ID="lblAdditionalSamples" runat="server" Text="Additional Samples" meta:resourcekey="lblAdditionalSamplesResource1"></asp:Label>
                                                        </td>
                                                    </tr>
                                                </table>
                                                <table>
                                                    <tr>
                                                        <td class="a-left w-100p v-top">
                                                            <table id="grdBatchSamples" class="gridView w-90p" runat="server">
                                                                <tr>
                                                                    <th>
                                                                        Batch No
                                                                    </th>
                                                                    <th>
                                                                        Visit Number
                                                                    </th>
                                                                    <th>
                                                                        Sample Type
                                                                    </th>
                                                                    <th>
                                                                        Patient Name
                                                                    </th>
                                                                    <th>
                                                                        Sent On
                                                                    </th>
                                                                    <th>
                                                                        BatchStatus
                                                                    </th>
                                                                    <th>
                                                                        SampleID
                                                                    </th>
                                                                    <th>
                                                                        PatientVisitID
                                                                    </th>
                                                                    <th>
                                                                        BarcodeNumber
                                                                    </th>
                                                                    <th>
                                                                        <input type="checkbox" name="vehicle" id="CheckBox1" value="Select All">Select All
                                                                    </th>
                                                                    <th>
                                                                        <input type="checkbox" name="vehicle" id="CheckBox2" value="Reprint Barcode">Reprint Barcode
                                                                    </th>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                        <td class="a-left w-100p v-top">
                                                            <asp:GridView ID="grdAdditionalBatchSamples" CssClass="gridView w-80p" runat="server"
                                                                meta:resourcekey="grdAdditionalBatchSamplesResource1">
                                                                <HeaderStyle CssClass="dataheader1" />
                                                            </asp:GridView>
                                                        </td>
                                                    </tr>
                                                </table>
                                                <br />
                                                <table class="a-center">
                                                    <tr>
                                                        <td id="tdBtnReceive" class="a-center" style="display: none;">
                                                            <asp:CheckBox ID="chkBarcodePrint" runat="server" meta:resourcekey="chkBarcodePrintResource1" />
                                                            <asp:Label ID="lblBarcode" runat="server" Text="Click Here To get Barcode Print"
                                                                meta:resourcekey="lblBarcodeResource1"></asp:Label><br />
                                                            <asp:Button ID="btnReceiveBatch" runat="server" Text="Receive Batch" CssClass="btn"
                                                                OnClick="btnReceiveBatch_OnClick" OnClientClick="javascript:return getSampleBatchTrackerDetails();"
                                                                meta:resourcekey="btnReceiveBatchResource1" />
                                                                 </td>
                                                                 
                                                                 <td id="tdbtnReprint" class="a-center" style="display: none;">
                                                                 <asp:CheckBox ID="chkReprintbarcode" runat="server" meta:resourcekey="chkBarcodePrintResource2" />
                                                            <asp:Label ID="lblReprintbarcode" runat="server" Text="Click Here To get Barcode Print"
                                                                meta:resourcekey="lblBarcodeResource1"></asp:Label><br />
                                                                <asp:Button ID="btnReprintbarcode" runat="server" Text="Reprint Barcode"  OnClick="btnReprintBarcode_OnClick" CssClass="btn" 
                                                                    OnClientClick="javascript:return getSampleBatchTrackerDetails();" meta:resourcekey="btnReprintbarcodeResource2" />
                                                            <%--<asp:Button ID="btnBatchCode" runat="server" Text="BatchCode Print" CssClass="btn"
                                                                                    OnClick="btnBatchCode_OnClick" OnClientClick="javascript:return getSampleBatchTrackerDetails();" />--%>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                        <asp:HiddenField ID="hdnBaseOrgId" runat="server" />
                        <asp:HiddenField ID="hdnSampleBatchTrackerDetails" runat="server" />
                        <asp:HiddenField ID="hdnAdditionalSampleBatchTracker" runat="server" />
                        <asp:HiddenField ID="hdnMessages" runat="server" />
                        <asp:HiddenField ID="hdnLstPatientInvSample" runat="server" />
                        <asp:HiddenField ID="hdnBatchId" runat="server" />
                    </ContentTemplate>
                </asp:UpdatePanel>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    </form>
</body>
</html>
