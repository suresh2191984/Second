<%@ Page Language="C#" AutoEventWireup="true" CodeFile="HistopathalogyReport.aspx.cs"
    Inherits="ReportsLims_HistopathalogyReport" meta:resourcekey="PageResource1" %>

<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Histopathalogy Report </title>
    <link href="../Images/favicon.ico" rel="shortcut icon" />
    <script type="text/javascript">

        function validateFrom(obj1, obj2) {
            var obj = document.getElementById(obj1);
            var obj3 = document.getElementById(obj2);
            if (obj.value != '' && obj.value != '__/__/____' || obj3.value != '') {
                dobDt1 = obj.value.split('/');
                var dobDt2 = obj3.value.split('/');
                var dobDtTime = new Date(dobDt1[2] + '/' + dobDt1[1] + '/' + dobDt1[0]);
                var dobDtTime2 = new Date(dobDt2[2] + '/' + dobDt2[1] + '/' + dobDt2[0]);
                var month = (dobDtTime.getMonth() + 1).toString();
                var monthTo = (dobDtTime2.getMonth() + 1).toString();
                var day = dobDt1[0];
                var year = dobDt1[2];
                var dayTo = dobDt2[0];
                var yearTo = dobDt2[2];
                if ((obj3.value != '') && (day > dayTo && month > monthTo && year > yearTo)) {

                    alert("ValidTO Must be Greater than or Equalto From Date");
                    obj3.value = '__/__/____';

                }
            }
           
            if (year > yearTo) {
                alert("FromDate year not be greater than todate year");
                obj.value = '__/__/____';
                obj.focus();
                return false;
            }
            else if (year == yearTo && month > monthTo) {
            alert("FromDate month not be greater than todate month");
            obj.value = '__/__/____';
                obj.focus();
                return false;
            }
            else if (year == yearTo && month == monthTo && day > dayTo) {
            alert("FromDate day not be greater than todate day");
            obj.value = '__/__/____';
                obj.focus();
                return false;
            }
        }

        function ValidDate(obj1, obj2, StartDt, wedFlag, BAflage) {
            var obj = document.getElementById(obj1);
            var obj1 = document.getElementById(obj2);
            if (obj.value == '') {
                alert("Please Select Valid From Date");
                obj1.value = '';
                obj.focus();
            }
            var currentTime;
            if (obj.value != '' && obj.value != '__/__/____') {
                dobDt = obj.value.split('/');
                var dobDtTime = new Date(dobDt[2] + '/' + dobDt[1] + '/' + dobDt[0]);
                var mMonth = (dobDtTime.getMonth() + 1).toString();
                var mDay = dobDt[0];
                var mYear = dobDt[2];
            }
            if (obj1.value != '' && obj1.value != '__/__/____') {
                dobDt1 = obj1.value.split('/');
                var dobDtTime = new Date(dobDt1[2] + '/' + dobDt1[1] + '/' + dobDt1[0]);
                var month = (dobDtTime.getMonth() + 1).toString();
                var day = dobDt1[0];
                var year = dobDt1[2];
            }
            if (mYear > year) {
                alert("ValidTo Must be Greater than or Equalto ValidFrom Date");
                document.getElementById('txtTDate').value = '';
                return false;
                obj1.value = '__/__/____';
                obj1.focus();
                return false;
              
            }
            else if ((mYear == year) && (mMonth > month)) {
            
            alert('ValidTo Must be Greater than or Equalto ValidFrom Date');

            document.getElementById('txtTDate').value = '';
            obj1.value = '__/__/____';
            obj1.focus();
            return false;
               
            }
            else if (mYear == year && mMonth == month && mDay > day) {
            alert('ValidTo Must be Greater than or Equalto ValidFrom Date');
            document.getElementById('txtTDate').value = '';
                obj1.value = '__/__/____';
                obj1.focus();
                return false;
            }
        }

    
    </script>
    
    
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="scriptManager1" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
        <table id="tblCollectionOPIP" class="a-center w-100p">
            <tr class="a-center">
                <td class="a-left">
                    <asp:UpdatePanel ID="updatePanel1" runat="server">
                        <ContentTemplate>
                         <asp:UpdateProgress ID="Progressbar" AssociatedUpdatePanelID="UpdatePanel1" runat="server">
                    <ProgressTemplate>
                        <div id="progressBackgroundFilter">
                        </div>
                        <div align="center" id="processMessage" width="60%">
                            <asp:Label ID="Rs_Pleasewait" Text="Please wait... " runat="server" />
                            <br />
                            <br />
                            <asp:Image ID="imgProgressbar" runat="server" ImageUrl="~/Images/working.gif" />
                        </div>
                    </ProgressTemplate>
                </asp:UpdateProgress>
                            <div class="dataheaderWider">
                                <table id="tbl">
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblOrgs" runat="server" Text="Select an Organization" meta:resourcekey="lblOrgsResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="ddlTrustedOrg" onchange="javascript:clearContextText();" runat="server"
                                                CssClass="ddl">
                                            </asp:DropDownList>
                                        </td>
                                        <td>
                                            <asp:Label ID="Rs_FromDate" Text="From Date :" runat="server" meta:resourcekey="Rs_FromDateResource1"></asp:Label>
                                            <asp:TextBox ID="txtFDate" CssClass="Txtboxsmall" Width="70px" runat="server" meta:resourcekey="txtFDateResource1"></asp:TextBox>
                                             <ajc:CalendarExtender ID="CalendarExtender2" Format="dd/MM/yyyy" runat="server"
                                                                        TargetControlID="txtFDate" PopupButtonID="ImgBntCalc" Enabled="True" />
                                &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                        </td>
                                        <td>
                                            <asp:Label ID="Rs_ToDate" Text="To Date :" runat="server" meta:resourcekey="Rs_ToDateResource1"></asp:Label>
                                            <asp:TextBox ID="txtTDate" CssClass="Txtboxsmall" Width="70px" runat="server" meta:resourcekey="txtTDateResource1"></asp:TextBox>                                             
                                              <ajc:CalendarExtender ID="CalendarExtender1" Format="dd/MM/yyyy" runat="server"
                                                                        TargetControlID="txtTDate" PopupButtonID="ImgBntCalc" Enabled="True" />
                                &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                        </td>
                                        <td class="a-left w-10p">
                                            <asp:Label runat="server" ID="lblDepartment" Text="Select Department" CssClass="label_title"
                                                meta:resourcekey="lblDepartmentResource1"></asp:Label>
                                        </td>
                                        <td class="a-left w-15p" colspan="4">
                                            <asp:DropDownList ID="ddlDepartment" runat="server" CssClass="ddl" Width="200px"
                                                TabIndex="7" meta:resourcekey="ddlDepartmentResource1">
                                            </asp:DropDownList>
                                        </td>
                                        <td class="a-left w-10p">
                                            <asp:Label runat="server" ID="lblTestName" Text="Select Test Name" CssClass="label_title"></asp:Label>
                                        </td>
                                        <td class="a-left w-15p" colspan="4">
                                            <asp:DropDownList ID="drpTestName" runat="server" CssClass="ddl" Width="200px" TabIndex="7">
                                            </asp:DropDownList>
                                        </td>
                                        <td>
                                            <asp:Button ID="btnSubmit" runat="server" Text="Get Report" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                onmouseout="this.className='btn'" OnClientClick="javascript:return validateToDate();"
                                                OnClick="btnSubmit_Click" meta:resourcekey="btnSubmitResource1" />
                                        </td>
                                        <td>
                                            <asp:LinkButton ID="lnkBack" runat="server" Text="Back &nbsp; " CssClass="details_label_age"
                                                OnClick="lnkBack_Click" meta:resourcekey="lnkBackResource1"></asp:LinkButton>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            
                            <div id="divSummPrint" visible="False" runat="server">
                                <table class="w-100p">
                                    <tr>
                                        <td class="a-right paddingR10">
                                            <b id="B1" runat="server">
                                                <asp:Label ID="Rs_PrintReport1" Text="Print Report" runat="server" meta:resourcekey="Rs_PrintReport1Resource1"></asp:Label></b>&nbsp;&nbsp;
                                            <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/Images/printer.gif"
                                                OnClientClick="return popupprint('divSummary');" ToolTip="Print" meta:resourcekey="ImageButton1Resource1" />
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div id="divOPDWCR" runat="server" visible="False">
                                <div id="prnReport">
                                    <table id="tblItem" class="w-100p">
                                        <tr>
                                            <td>
                                                <asp:Label runat="server" Font-Bold="True" ID="lblHeader" meta:resourcekey="lblHeaderResource1"></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                            <div id="Excel" runat="server" style="display:none">
                            <table class="w-100p">
                            <tr>
                            <td id="tdexcel" style="padding-right: 10px; color: #000000;" runat="server">
                                <asp:Label ID="lbExcel" Text="Excel Report" Font-Bold="True" ForeColor="#000333"
                                    runat="server" meta:resourcekey="lbExcelResource1"></asp:Label>
                                <asp:ImageButton ID="btnConverttoXL" OnClick="btnConverttoXL_Click" runat="server"
                                    ImageUrl="~/Images/ExcelImage.GIF" />
                                                          
                               
                            </td>
                            </tr>
                            </table>
                            </div>
                            <div id="divSummary" runat="server">
                             <asp:Panel ID="pnl" runat="server" ScrollBars="Vertical" Style="width:auto; height: 500px; display:none;">
                                <table class="w-100p">
                                    <tr>
                                     
                                        <td class="a-center">
                                            <asp:GridView ID="grdHistoReport" AlternatingRowStyle-CssClass="trEven"  runat="server" AutoGenerateColumns="False" ForeColor="#333333"
                                                CssClass="gridView" meta:resourcekey="gvIPSummaryResource1">
                                                <HeaderStyle CssClass="dataheader1" />
                        <FooterStyle CssClass="dataheader1" />
                                                <Columns>
                                                    <asp:BoundField DataField="AccessionNumber" HeaderText="Accession Number">
                                                        <ItemStyle HorizontalAlign="Left" Width="70%" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="PatientName" HeaderText="Patient Name">
                                                        <ItemStyle HorizontalAlign="Left" Width="70%" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="DOB" HeaderText="Date of Birth">
                                                        <ItemStyle HorizontalAlign="Left" Width="70%" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="AgeGender" HeaderText="Age/Gender">
                                                        <ItemStyle HorizontalAlign="Left" Width="70%" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="Nationality" HeaderText="Nationality">
                                                        <ItemStyle HorizontalAlign="Left" Width="70%" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="ClientName" HeaderText="Client Name">
                                                        <ItemStyle HorizontalAlign="Left" Width="70%" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="ExternalNumber" HeaderText="External Number">
                                                        <ItemStyle HorizontalAlign="Left" Width="70%" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="Physician" HeaderText="Physician">
                                                        <ItemStyle HorizontalAlign="Left" Width="70%" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="Specimen" HeaderText="Specimen">
                                                        <ItemStyle HorizontalAlign="Left" Width="70%" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="Classification" HeaderText="Classification">
                                                        <ItemStyle HorizontalAlign="Left" Width="70%" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="ExaminationCategory" HeaderText="Examination Category">
                                                        <ItemStyle HorizontalAlign="Left" Width="70%" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="SpecialProcedure" HeaderText="Special Procedure">
                                                        <ItemStyle HorizontalAlign="Left" Width="70%" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="Block" HeaderText="Block">
                                                        <ItemStyle HorizontalAlign="Left" Width="70%" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="Slide" HeaderText="Slide">
                                                        <ItemStyle HorizontalAlign="Left" Width="50%" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="IsMalignent" HeaderText="Is Malignent">
                                                        <ItemStyle HorizontalAlign="Left" Width="70%" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="Diagnosis" HeaderText="Diagnosis">
                                                        <ItemStyle HorizontalAlign="Left" Width="70%" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="DateCollected" HeaderText="Sample Collected Time">
                                                        <ItemStyle HorizontalAlign="Left" Width="70%" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="DateReceived" HeaderText="Sample Received Time">
                                                        <ItemStyle HorizontalAlign="Left" Width="70%" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="DateGrossed" HeaderText="Gross Completion Time">
                                                        <ItemStyle HorizontalAlign="Left" Width="70%" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="DateTissued" HeaderText="Tissue Completion Time">
                                                        <ItemStyle HorizontalAlign="Left" Width="70%" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="DateSlidePrepared" HeaderText="Slide Completion Time">
                                                        <ItemStyle HorizontalAlign="Left" Width="70%" />
                                                    </asp:BoundField>                                                    
                                                    <asp:BoundField DataField="DateStatinComplete" HeaderText="Stain Completion Time">
                                                        <ItemStyle HorizontalAlign="Left" Width="70%" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="DateMicroComplete" HeaderText="Microscopy Completion Time">
                                                        <ItemStyle HorizontalAlign="Left" Width="70%" />
                                                    </asp:BoundField>
                                                    
                                                    <asp:BoundField DataField="DateofReport" HeaderText="Date of Report">
                                                        <ItemStyle HorizontalAlign="Left" Width="70%" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="TAT" HeaderText="TAT">
                                                        <ItemStyle HorizontalAlign="Left" Width="70%" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="GrossDoneBy" HeaderText="Gross Done By">
                                                        <ItemStyle HorizontalAlign="Left" Width="50%" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="MicroscopyDoneBy" HeaderText="Microscopy Done By">
                                                        <ItemStyle HorizontalAlign="Left" Width="50%" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="PathaologistName" HeaderText="Pathaologist Name">
                                                        <ItemStyle HorizontalAlign="Left" Width="50%" />
                                                    </asp:BoundField>
                                                     <asp:BoundField DataField="Status" HeaderText="Status">
                                                        <ItemStyle HorizontalAlign="Left" Width="50%" />
                                                    </asp:BoundField>
                                                </Columns>
                                                <FooterStyle BackColor="White" ForeColor="#000066" />
                                                <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                                <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                <HeaderStyle CssClass="grdcolor" Font-Bold="True" />
                                            </asp:GridView>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label Font-Bold="True" Font-Size="13px" runat="server" ID="totTest" meta:resourcekey="totTestResource1"></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                                </asp:Panel>
                            </div>
                        </ContentTemplate>
                        <Triggers>
                <asp:PostBackTrigger ControlID="btnConverttoXL" />
            </Triggers>
                    </asp:UpdatePanel>
                </td>
            </tr>
        </table>
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    <asp:HiddenField ID="hdnMessages" runat="server" />
    </form>

    <script language="javascript" type="text/javascript">
        function ShowAlertMsg(key) {
            var AlrtWinHdr = SListForAppMsg.Get("ReportsLims_DiscountReportLims_aspx_winhdr") != null ? SListForAppMsg.Get("ReportsLims_DiscountReportLims_aspx_winhdr") : "Alert";
            var UsrMsgDisp = SListForAppMsg.Get("ReportsLims_LabStatisticsReportLims_aspx_01") != null ? SListForAppMsg.Get("ReportsLims_LabStatisticsReportLims_aspx_01") : "No Matching Records found for the selected dates";
            var userMsg = SListForApplicationMessages.Get(key);
            if (userMsg != null) {
                // alert(userMsg);
                ValidationWindow(userMsg, AlrtWinHdr);

            }
            else if (key == "CommonMessages_20") {
                //alert(' No Matching Records found for the selected dates');
                ValidationWindow(UsrMsgDisp, AlrtWinHdr);

            }

            return false;
        }
        function validateToDate() {
            var AlrtWinHdr = SListForAppMsg.Get("ReportsLims_DiscountReportLims_aspx_winhdr") != null ? SListForAppMsg.Get("ReportsLims_DiscountReportLims_aspx_winhdr") : "Alert";
            var UsrMsgDisp = SListForAppMsg.Get("ReportsLims_LabStatisticsReportLims_aspx_02") != null ? SListForAppMsg.Get("ReportsLims_LabStatisticsReportLims_aspx_02") : "Provide / select value for From date";
            var UsrMsgDisp1 = SListForAppMsg.Get("ReportsLims_LabStatisticsReportLims_aspx_03") != null ? SListForAppMsg.Get("ReportsLims_LabStatisticsReportLims_aspx_03") : "Provide / select value for To date";
            if (document.getElementById('txtFDate').value == '') {
                //alert('Provide / select value for From date');
                ValidationWindow(UsrMsgDisp, AlrtWinHdr);
                document.getElementById('txtFDate').focus();
                return false;
            }
            if (document.getElementById('txtTDate').value == '') {
                //alert('Provide / select value for To date');
                ValidationWindow(UsrMsgDisp1, AlrtWinHdr);
                document.getElementById('txtTDate').focus();
                return false;
            }
        }
        function popupprint(prnReport) {
            var prtContent = document.getElementById(prnReport);
            var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,status=0');
            //alert(WinPrint);
            WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
            WinPrint.close();
        }
        function clearContextText() {
            $('#contentArea').hide();

        }
    </script>

    <%--<script type="text/javascript" src="../Scripts/jquery-1.7.2.min.js"></script>

                        <script type="text/javascript" src="../Scripts/jquery-ui-1.8.19.custom.min.js"></script>--%>

  

</body>
</html>
