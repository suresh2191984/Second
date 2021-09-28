<%@ Page Language="C#"  AutoEventWireup="true" CodeFile="PatientEMRComplaintHistory.aspx.cs" Inherits="Patient_PatientEMRComplaintHistory" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/Advice.ascx" TagName="Adv" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ViewTRFImage.ascx" TagName="ViewTRFImage" TagPrefix="TRF" %>
<%@ Register Src="~/CommonControls/PatientVitals.ascx" TagName="PatientVitals" TagPrefix="ucVitals" %>
<%@ Register Src ="~/EMR/His.ascx" TagName="EmrHis" TagPrefix="ucllll" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<script type="text/javascript" src="../Scripts/bid.js"></script>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Patient EMR Complaint History</title>
    
      <style type="text/css">
        input:focus
        {
            /*background: #8AC0DA;*/
            outline: .25px solid #8f0000;
        }
    </style>
   
    
    <script type="text/javascript">
        function saved() {
            alert('saved successsfully');

        }



        function maxWidth(id) {
            var maxlength = 0;
            var curlength = 0;
            var mySelect = document.getElementById(id);
            for (var i = 0; i < mySelect.options.length; i++) {
                if (mySelect[i].text.length > maxlength) {
                    maxlength = mySelect[i].text.length;
                }
            }
            mySelect.style.width = maxlength * 7;
        }
        function restoreWidth(id) {
            var mySelect = document.getElementById(id);
            mySelect.style.width = "100px";
        } 
    </script>

    <script language="javascript" type="text/javascript">

        function popupprint() {
            var prtContent = document.getElementById('Hisss_divviewHistory');
            var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,status=0');
            WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
            WinPrint.close();
        }


        function showContentHis(id) {
            var chkvalue = id;
            var ddl = id.split('_');
            var divid = 'tcEMR_tpHistory_ucHistory_div' + ddl[3] + '_' + ddl[4];
            if (document.getElementById(id).checked == true) {
                document.getElementById(divid).style.display = 'block';
            }
            else {
                document.getElementById(divid).style.display = 'none';
            }
        }
        function showContent(id, div) {
            if (document.getElementById('tcEMR_tpHistory_ucHistory_chk' + id).checked == true) {
                document.getElementById('tcEMR_tpHistory_ucHistory_div' + div).style.display = 'block';
            }
            else {
                document.getElementById('tcEMR_tpHistory_ucHistory_div' + div).style.display = 'none';
            }
        }
        function HideFunction() {
            if (document.getElementById('Hisss_tblAtt') != null) {
                document.getElementById('Hisss_tblAtt').style.display = "none";
            }
            if (document.getElementById('Hisss_tblBtnAtt') != null) {
                document.getElementById('Hisss_tblBtnAtt').style.display = "none";
            }
        }
        function showQuitDet(id) {
            var chkvalue = id;
            var ddl = id.split('_');
            var divid = 'tcEMR_tpHistory_ucHistory_td' + ddl[3] + '_' + ddl[4];
            if (document.getElementById(id).checked == true) {
                document.getElementById(divid).style.display = 'block';
            }
            else {
                document.getElementById(divid).style.display = 'none';
            }
        }
        function showOthersBoxHis(ddl) {

            var ddlValue = document.getElementById(ddl).options[document.getElementById(ddl).selectedIndex].innerHTML;
            var OID = ddl.split('_');


            var strDiv = 'tcEMR_tpHistory_ucHistory_div' + OID[3] + '_' + OID[4];


            if ((ddlValue == "Others") || (ddlValue == "Occasional Physicial Activity") || (ddlValue == "Athlete") || (ddlValue == "Regular Exercise")) {
                document.getElementById(strDiv).style.display = 'block';
            }
            else {
                document.getElementById(strDiv).style.display = 'none';
            }
        }
        function showOthersChkBox(id) {
            if (document.getElementById(id).checked == true) {


                document.getElementById('tcEMR_tpHistory_ucHistory_divchkOthers_9').style.display = 'block';
            }
            else {
                document.getElementById('tcEMR_tpHistory_ucHistory_divchkOthers_9').style.display = 'none';
            }
        }
        function PreSBPKeyPress() {
            var key = window.event.keyCode;
            if ((key != 16) && (key != 4) && (key != 9)) {
                var sVal = document.getElementById('tcEMR_tpExamination_PatientVitalsControl_txtSBP').value;
                var ctrlDBP = document.getElementById('tcEMR_tpExamination_PatientVitalsControl_txtDBP');
                if (sVal.length == 3) {
                    ctrlDBP.focus();
                }
            }
        }


        function SaveDynamicHistory() {

            document.getElementById('Hisss_trDynamicControlsTable').style.display = 'block';
//            var txtid = arrayHistoryData[iMain].split('~')[0] + "_" + arrayHistoryData[iMain].split('~')[1] + "_txt";
//            var chkid = arrayHistoryData[iMain].split('~')[0] + "_" + arrayHistoryData[iMain].split('~')[1] + "_chk";
//            var RowID = arrayHistoryData[iMain].split('~')[0] + "_" + arrayHistoryData[iMain].split('~')[1];
//            var HdnID1 = arrayHistoryData[iMain].split('~')[0] + "_" + arrayHistoryData[iMain].split('~')[1] + '_h1';
//            var HdnID2 = arrayHistoryData[iMain].split('~')[0] + "_" + arrayHistoryData[iMain].split('~')[1] + '_h2';

            var pHistoryvalue;
            var pHistoryName;
            var pHistoryID;
            
            var Ischeck;
            var lstPatientHistoryAttribute = [];
            var count = 0;
            $('#Hisss_tblDynamicControls tr:not(:first)').each(function(i, n) {
                $row = $(n);
                count = count + 1;
               // if ($row.find($('[id$="' + Ischeck + '"] input[type=checkbox]:checked'))) {
 
                    pHistoryvalue = $row.find($('input[id$="_txt"]')).val();
                    pHistoryName = $row.find($('input[id$="_h1"]')).val();
                    pHistoryID = $row.find($('input[id$="_h2"]')).val();

                     
                    lstPatientHistoryAttribute.push({
                    HistoryID: pHistoryID,
                    AttributeValueName: pHistoryvalue,
                        HistoryName: pHistoryName
                    });
                //}
            });
            if (lstPatientHistoryAttribute.length > 0) {
                $('#Hisss_hdnPatientHistoryAttribute').val(JSON.stringify(lstPatientHistoryAttribute));
            }
            
        }   
    </script>
</head>
<body>
    <form id="form1" runat="server">
    
   <asp:ScriptManager ID="scm1" runat="server">
<%--  <Services>
            <asp:ServiceReference Path="~/WebService.asmx" />
        </Services>--%>
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
                    <div class="contentdata" id="dMain">
                        <%--<ul>
                            <li>
                                <uc6:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>--%>
                        <table class="w-100p">
                           <tr>
                            <td>
                                <div id="ViewTRF" runat="server" style="display: none">
                                    <trf:viewtrfimage id="TRFUC" runat="server" />
                                </div>
                            </td>
                        </tr>
                           
                            <tr>
                                <td class="a-right">
                                   
                                 
                                </td>
                            </tr>
                            
                            <tr>
                                <td>
                                    <asp:UpdatePanel ID="upTabControl" runat="server">
                                        <ContentTemplate>
                                          <div id="divCapHis" style="height:auto;overflow:auto;">
                                            <ucllll:EmrHis id="Hisss" runat="Server" ></ucllll:EmrHis>
                                           </div>
                                         
                                        </ContentTemplate>
                                         <%--<Triggers>
                                        <asp:AsyncPostBackTrigger ControlID="tcEMR" EventName="ActiveTabChanged" />
                                           <asp:AsyncPostBackTrigger ControlID="Hisss"></asp:AsyncPostBackTrigger>
                                        </Triggers>--%>
                                    </asp:UpdatePanel>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td class="a-center">
                                 <input id="hdnhistoryList" runat="server" type="hidden" value="" />
                                   <input id="hdnType" runat="server" type="hidden" value="" />
                                 <asp:Button id="btnSave" runat="server" text="Save" onclick="btnSave_Click"  OnClientClick="javascript:SaveDynamicHistory();" />
                                 <asp:Button id="btnUpdate" runat="server" text="Edit" onclick="btnUpdate_Click" />
                                  <asp:Button id="btnPrint" runat="server" text="Print"  OnClientClick="return popupprint();" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                        </table>
                    </div>
      <Attune:Attunefooter ID="Attunefooter" runat="server" />         
    </form>
</body>
</html>
<%--<script src="../Scripts/jquery-1.8.1.min.js" type="text/javascript"></script>--%>