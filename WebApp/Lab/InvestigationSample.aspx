<%@ Page Language="C#" AutoEventWireup="true" EnableEventValidation="false" CodeFile="InvestigationSample.aspx.cs"
    Inherits="Lab_InvestigationSample_aspx" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%--<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc2" %>
<%@ Register Src="~/CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc4" %>--%>
<%--<%@ Register Src="~/CommonControls/PatientHeader.ascx" TagName="PatientHeader" TagPrefix="uc3" %>--%>
<%--<%@ Register Src="../CommonControls_NewUI/ErrorDisplay.ascx" TagName="ErrorDisplay"
    TagPrefix="uc7" %>--%>
<%@ Register Src="../CommonControls/OrderedSamples.ascx" TagName="OrderedSamples"
    TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/SampleCollectedVisit.ascx" TagName="SampleCollectedVisit"
    TagPrefix="uc8" %>
<%@ Register Src="../CommonControls/PatientDetails.ascx" TagName="PatientDetails"
    TagPrefix="ucPatientdet" %>
<%@ Register Src="../CommonControls/LabBillPrint.ascx" TagName="srsprint" TagPrefix="ucsrs" %>
<%--<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="UserHeader" TagPrefix="uc6" %>--%>
<%@ Register Src="../CommonControls/ViewTRFImage.ascx" TagName="ViewTRFImage"
    TagPrefix="TRF" %>
<%@ Register Src="../CommonControls/CollectSample.ascx" TagName="CollectSample"
    TagPrefix="CollectSample" %>
<%@ Register Src="~/CommonControls/NewDateTimePicker.ascx" TagName="DateTimePicker"
    TagPrefix="DateTimePicker" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter"
    TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Investigation Sample Collection</title>
<%--
    <script src="../Scripts/bid.js" type="text/javascript"></script>

    <script src="../Scripts/Common.js" type="text/javascript"></script>--%>

    <script src="../Scripts/jquery-1.8.1.min.js" language="javascript" type="text/javascript"></script>

<%--    <script src="../Scripts/JsonScript.js" language="javascript" type="text/javascript"></script>--%>

    <script src="../Scripts/CollectSample.js" language="javascript" type="text/javascript"></script>

    <script type="text/javascript" language="javascript">

        $(document).ready(function() {


           

            dialogfunc();

        });
        $(function() {
            //           $("form").bind("keypress", function(e) {
            //            if (e.keyCode == 13)
            //                event.preventDefault();
            //                 return false;
            //            });
            $('#btnFinish').focus();
            $('input[type="text"]').on('keypress', function(event) {
                if (event.keyCode == 13) {
                    event.preventDefault();
                }
            });
            $(window).keydown(function(event) {

                if (event.altKey && (event.which == 71 )) {
                    $('#btnFinish').trigger("click")
                    
                }
            });
            if (document.getElementById('hdnSpecimendetails').value = "Y") {
          
                sessionStorage.setItem('hdnSpecimendetails', '');
            }

            
            // autocomplete for specimen
          
            // end
            
        });
    </script>

    <script language="javascript" type="text/javascript">
        function OpenSrsPrint() {
            //            document.getElementById('divsrs').style.display='block';
            var prtContent = document.getElementById('divsrs1');
            var WinPrint = window.open("", "", "toolbar=0,left=0,top=0,scrollbars=yes,status=0");
            WinPrint.document.write(prtContent.innerHTML);
            //WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
            //WinPrint.close();
            return false;
        }

        function OpenBillPrint(url) {
            window.open(url, "billprint", "letf=0,top=0,toolbar=0,scrollbars=yes,status=0");
        }
        window.onbeforeunload = LeavePage;
        function LeavePage(e) {

            ValidateUserExit("User");

        }
        function TaskOpenJs(arg) {
            //LockReleased
            //alert(arg);
        }
        function ProcessCallBackError(arg) {
            //Error in UnLocking
            //alert('Error In Unlocking');
        }
    </script>

</head>
<body oncontextmenu="return false;">
    <form id="form1" runat="server" >
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
        <table class="w-100p">
            <tr>
                <td>
                    <div id="ViewTRF" runat="server" style="display: none">
                        <TRF:ViewTRFImage ID="TRFUC" runat="server" />
                    </div>
                </td>
            </tr>
        </table>
        <asp:Label ID="lblStatus" Visible="False" runat="server" ForeColor="#000333" Text="No Matching Records Found!"
            meta:resourcekey="lblStatusResource1"></asp:Label>
        <div runat="server" id="dInves" style="display: none;">
            <asp:Table CellPadding="2" CssClass="colorforcontentborder font11 w-100p" runat="server"
                ID="dispTab" meta:resourcekey="dispTabResource1">
                <asp:TableRow ID="tblReferred" runat="server" class="h-15" meta:resourcekey="tblReferredResource1">
                    <asp:TableHeaderCell ForeColor="#000" HorizontalAlign="left" meta:resourcekey="TableHeaderCellResource1">
                        <asp:Literal ID="ColDrName" runat="server" Text="Dr. Name:" meta:resourcekey="ColDrNameResource1"></asp:Literal>&nbsp;
                        <asp:Literal ID="DrName" runat="server" meta:resourcekey="DrNameResource2"></asp:Literal></asp:TableHeaderCell>
                    <asp:TableHeaderCell ForeColor="#000" HorizontalAlign="left" meta:resourcekey="TableHeaderCellResource2">
                        <asp:Literal ID="Literal3" runat="server" Text="Hospital/Branch:" meta:resourcekey="Literal3Resource1"></asp:Literal>&nbsp;
                        <asp:Literal ID="HospitalName" runat="server" meta:resourcekey="HospitalNameResource1"></asp:Literal></asp:TableHeaderCell>
                </asp:TableRow>
                <asp:TableRow ID="TableRow1" runat="server" meta:resourcekey="TableRow1Resource1">
                    <asp:TableHeaderCell ColumnSpan="4" HorizontalAlign="left" meta:resourcekey="TableHeaderCellResource3">
                        <asp:Table runat="server" ID="trCC" class="w-100p" Style="display: none;" meta:resourcekey="trCCResource1">
                            <asp:TableRow class="h-15" meta:resourcekey="TableRowResource1">
                                <asp:TableHeaderCell ForeColor="#000" ColumnSpan="2" HorizontalAlign="left" meta:resourcekey="TableHeaderCellResource4">
                                    <asp:Literal ID="Literal4" runat="server" Text="Collection Centre:" meta:resourcekey="Literal4Resource1"></asp:Literal>&nbsp;
                                    <asp:Literal ID="CollectionCentre" runat="server" meta:resourcekey="CollectionCentreResource1"></asp:Literal></asp:TableHeaderCell></asp:TableRow>
                        </asp:Table>
                    </asp:TableHeaderCell>
                </asp:TableRow>
            </asp:Table>
            <div runat="server" id="divPatientDetails">
                <ucPatientdet:PatientDetails ID="PatientDetail" runat="server" />
            </div>
            <asp:UpdatePanel ID="upSample" runat="server">
                <ContentTemplate>
                    <table class="w-100p">
                        <tr>
                            <td>
                                <uc5:OrderedSamples ID="OrderedSamples1" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <table class="dataheader2">
                                    <tr>
                                        <td colspan="1">
                                            <asp:Label ID="lblSampleDateTime" runat="server" meta:resourceKey="lblSampleDateTimeResource2"
                                                Text="Sample Collected Date Time" Font-Bold="true"></asp:Label>
                                        </td>
                                        <td>
                                            <DateTimePicker:DateTimePicker ID="DateTimePicker1" runat="server" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td style="color: #000;" class="a-left h-23">
                                <div id="ACX2plus2" style="display: none;">
                                    <img src="../Images/showBids.gif" alt="Show" width="15" height="15" align="top" style="cursor: pointer"
                                        onclick="showResponses('ACX2plus2','ACX2minus2','ACX2responses5',1);" />
                                    <span class="dataheader1txt" style="cursor: pointer; color: #000;" onclick="showResponses('ACX2plus2','ACX2minus2','ACX2responses5',1);" meta:resourcekey="dataheader1txtResource1">
                                        &nbsp; <%= Resources.Lab_ClientDisplay.Lab_Investigation_InvestigationSample_aspx_01%></span>
                                </div>
                                <div id="ACX2minus2" style="display: block;">
                                    <img src="../Images/hideBids.gif" alt="hide" width="15px" height="15px" align="top"
                                        style="cursor: pointer" onclick="showResponses('ACX2plus2','ACX2minus2','ACX2responses5',0);" />
                                    <span class="dataheader1txt" style="cursor: pointer; color: #000;" onclick="showResponses('ACX2plus2','ACX2minus2','ACX2responses5',0);" meta:resourcekey="dataheader2txtResource1">
                                    &nbsp;<%=Resources.Lab_ClientDisplay.Lab_Investigation_InvestigationSample_aspx_01%>
                                </div>
                            </td>
                        </tr>
                        <tr class="tablerow" id="ACX2responses5" style="display: table-row;">
                            <td>
                                <div class="w-100p">
                                    <CollectSample:CollectSample ID="ctlCollectSample" runat="server" />
                                </div>
                                <asp:Panel CssClass="dataheader2" runat="server" ID="pnlDept" Style="display: none">
                                    <table id="deptTab" runat="server" class="w-100p" cellpadding="4" style="display: none">
                                        <tr class="Duecolor h-20">
                                            <td colspan="10">
                                                <asp:Label ID="lblDeptheader" runat="server" meta:resourcekey="lblDeptheaderResource1"><%=Resources.Lab_ClientDisplay.Lab_Investigation_InvestigationSample_aspx_02%>
                                         
                                                </asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="a-left w-100p v-top" colspan="5">
                                                <asp:DataList Width="100%" ID="repDepts" runat="server" RepeatColumns="5">
                                                    <ItemTemplate>
                                                        <table class="w-100p">
                                                            <tr>
                                                                <td class="w-85p h-20" style="font-weight: normal; color: #000;">
                                                                    <asp:CheckBox ID="chkDept" runat="server" />
                                                                    <asp:Label ID="lblDeptName" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "DeptName")%>'> </asp:Label>
                                                                </td>
                                                                <td class="h-20 w-15p" style="font-weight: normal; color: #000;">
                                                                    <asp:Label ID="lblDeptID" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "DeptID")%>'
                                                                        Visible="False"> </asp:Label>
                                                                    <asp:Label ID="lblRoleID" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "RoleID")%>'
                                                                        Visible="False"> </asp:Label>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </ItemTemplate>
                                                </asp:DataList>
                                            </td>
                                        </tr>
                                    </table>
                                </asp:Panel>
                                <table class="w-100p">
                                    <tr>
                                        <td>
                                            <uc8:SampleCollectedVisit ID="SampleCollectedVisit1" runat="server" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="a-center">
                                            <asp:Button ID="btnFinish" runat="server" ToolTip="Click here to Generate Work Order"
                                                Style="cursor: pointer;" CssClass="btn" OnClick="btnFinish_Click" onmouseout="this.className='btn'"
                                                onmouseover="this.className='btn btnhov'" Text="Generate Work Order" UseSubmitBehavior="true"  meta:resourcekey="btnFinishResource1"/>
                                            <asp:Button ID="btnCancel" runat="server" ToolTip="Click here to Cancel, View the Home Page"
                                                Style="cursor: pointer;" CssClass="btn" OnClick="btnCancel_Click" onmouseout="this.className='btn'"
                                                onmouseover="this.className='btn btnhov'" Text="Cancel" UseSubmitBehavior="true" meta:resourcekey="btnCancelResource1"/>
                                            <%--<asp:Button ID="btnsrsprint" runat="server" ToolTip="Click here to Generate SRS"
                                                                Style="cursor: pointer;" CssClass="btn" onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'"
                                                                Text="SRS Print" OnClientClick="javascript:return OpenSrsPrint();" />--%>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div id="divsrs" style="display: none;">
                                    <div id="divsrs1">
                                        <ucsrs:srsprint ID="ucsrsprint" runat="server" />
                                    </div>
                                </div>
                            </td>
                        </tr>
                    </table>
                    <input type="hidden" id="hDept" runat="server" />
                    <input type="hidden" id="HdnButtonClicked" runat="server" />
                    <input type="hidden" id="hdnEmpNo" runat="server" />
                    <asp:HiddenField ID="hdnLstPatientInvSample" runat="server" />
                    <asp:HiddenField ID="hdnLstSampleTracker" runat="server" />
                    <asp:HiddenField ID="hdnLstPatientInvSampleMapping" runat="server" />
                    <asp:HiddenField ID="hdnLstInvestigationValues" runat="server" />
                    <asp:HiddenField ID="hdnLstCollectedSampleStatus" runat="server" />
                    <asp:HiddenField ID="hdnLstPatientInvestigation" runat="server" />
                    <asp:HiddenField ID="hdnvisitnumber" runat="server" />
                    <input type="hidden" id="hdnVisitID" runat="server" />
                    <input type="hidden" id="hdnpatientid" runat="server" />
                    <input type="hidden" id="hdnneedbillinv" runat="server" />
                    <input type="hidden" id="hdorgid" runat="server" />
                    <input type="hidden" id="hdnorgaddressid" runat="server" />
                    <input type="hidden" id="hdnquerystring" runat="server" />
                    <input type="hidden" id="hdncltdatetime" runat="server" />
                    <asp:HiddenField ID="hdnMessages" runat="server" />
                    <asp:HiddenField ID="HdnFlagforprint" runat="server" />
                    <asp:HiddenField ID="hdnSpecimendetails" runat="server" />
                  <asp:HiddenField ID="hdnOrgID" runat="server" />
                    
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </div>
     <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
    <asp:Button runat="server" ID="BTNCheck" Text="" OnClick="BTNCheck_Click" hidden />
    </ContentTemplate>
<%--    <Triggers>
    <asp:PostBackTrigger ControlID="BTNCheck" />
    </Triggers>--%>
    </asp:UpdatePanel>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    <div id="dialog1" style="display:none">
    </form>
</body>
</html>
  <script type="text/javascript" src="../Scripts/datetimepicker_css.js"></script>