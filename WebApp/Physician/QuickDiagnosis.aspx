<%@ Page Language="C#" AutoEventWireup="true" CodeFile="QuickDiagnosis.aspx.cs" Inherits="Physician_QuickDiagnosis"
    EnableEventValidation="false" meta:resourcekey="PageResource1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="Header" TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Advice.ascx" TagName="Advice" TagPrefix="uc5" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="AutoCom" %>
<%@ Register Src="../CommonControls/PatientHeader.ascx" TagName="PatientHeader" TagPrefix="uc6" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/DynamicDHEBAdder.ascx" TagName="DHEBAdd" TagPrefix="uc8" %>
<%@ Register Src="../CommonControls/GeneralAdvice.ascx" TagName="GeneralAdv" TagPrefix="uc9" %>
<%@ Register Src="../CommonControls/InvestigationControl.ascx" TagName="InvestigationControl"
    TagPrefix="uc10" %>
<%@ Register Src="../CommonControls/PatientVitals.ascx" TagName="PatientVitals" TagPrefix="uc11" %>
<%@ Register Src="../CommonControls/InventoryAdvice.ascx" TagName="InvenAdv" TagPrefix="uc12" %>
<%@ Register Src="../CommonControls/ComplaintICDCode.ascx" TagName="ComplaintICDCode"
    TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
    <link href="../StyleSheets/StyleSheet.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
  <%--  <link href="../StyleSheets/DHEBAdder.css" rel="stylesheet" type="text/css" />--%>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script type="text/javascript" src="../Scripts/AutoComplete.js" language="javascript"></script>

    <script type="text/javascript" src="../Scripts/bid.js"></script>
<%--
    <script type="text/javascript" src="../Scripts/DHEBAdder.js"></script>--%>

    <script src="../Scripts/jquery-1.2.2.pack.js" type="text/javascript"></script>
<script src="../Scripts/JsonScript.js" type="text/ecmascript"></script>

    <script language="javascript" type="text/javascript">
        function PreSBPKeyPress() {
            var key = window.event.keyCode;
            if ((key != 16) && (key != 4) && (key != 9)) {
                var sVal = document.getElementById('uctPatientVitalsControl_txtSBP').value;
                var ctrlDBP = document.getElementById('uctPatientVitalsControl_txtDBP');
                if (sVal.length == 3) {
                    ctrlDBP.focus();
                }
            }
        }
        function fnChk(chkid) {
            var objAdditional = document.getElementById('chkAdditionalPayments');
            var objReferal = document.getElementById('chkRefer');
            if (objAdditional != null) {
                if (objAdditional.checked == true && objReferal.checked == true) {
                    if (chkid == 'chkAdditionalPayments')
                        objReferal.checked = false;
                    else
                        objAdditional.checked = false;

                }
            }
        }
        function chkContext() {
            
            var orgID = '<%= OrgID %>';
            var lcID = '<%= ILocationID %>';
            var pVisitID = document.getElementById('hdnVisitID').value;
            var pvalue = '';
            var sval = 'PRO';
            var sClientID = '';
            //            sval = sval + '~' + sClientID + '~' + IsMapped + '~' + sRateID + '~' + pvalue + '~' + pVisitID + '~' + orgID + '~' + lcID;
            sval = sval + '~' + 1 + '~' + 'N' + '~' + 1 + '~' + pvalue + '~' + pVisitID + '~' + orgID + '~' + lcID;
            $find('AutoCompleteExtender3').set_contextKey(sval);


        }
        function LstSelected(source, eventArgs) {
            var Result = eventArgs.get_value().split('^');
            document.getElementById('Hdnlist').value = Result;

        }

        function CreateTable() {
            
            var DataTable = [];
           
            var list = document.getElementById('Hdnlist').value.split(',');
            var ProcedureName;
            var ProcedureID;
            var PreName = $('#txtProName').val();

            if (PreName == "") {
                alert('Select Procedure  Name');
                return false;
            }
           // var Qty = $('#txtQuantity').val();

            var ProcName = list[1];
            var ProCID = list[0];
            DataTable.push({
                ProcedureName: ProcName,
                ProcedureID: ProCID,
               // OdreredQty: Qty
                OdreredQty: 1

            });

            BindTable(DataTable);

        }
        function onDeleteItem(ele) {

            $(ele).closest('tr').remove();
        }

        function BindTable(DataTable) {
            var rowCount = $('#tblProcedures tr').length;
            
            $.each(DataTable, function(i, obj) {
                var RowNO = Number(rowCount + i);
                dtTR = $('<tr/>');
                var ID = $('<td align="left"/>').html("<span id='RowID'>" + RowNO + " </span>");
                var ProcedureID = $('<td align="left" style="display:none;"/>').html("<span id='ProcID'>" + obj.ProcedureID + " </span>");
                var ProName = $('<td align="left"/>').html("<span id='ProName'>" + obj.ProcedureName + " </span>");
                //var ProcQuantity = $('<td align="left"/>').html("<span id='Quantity'>" + obj.OdreredQty + " </span>");
                //var btnDelete = '<input id="btnDelete" value="' + "Delete" + '" type="button" style="background-color: Transparent; color: Red; border-style: none; text-decoration: underline; cursor: pointer; font-size: 12px;" onclick="onDeleteItem(this);"/>';
                var btnDelete = '<input id="btnDelete" value="' + "Delete" + '" type="button" style="background-color: Transparent; color: Red; border-style: none; text-decoration: underline; cursor: pointer; font-size: 12px;" onclick="onDeleteItem(this);"/>';
                var tdAction = $('<td/>').html(btnDelete);
               // dtTR.append(ID).append(ProcedureID).append(ProName).append(ProcQuantity).append(tdAction);
                dtTR.append(ID).append(ProcedureID).append(ProName).append(tdAction);
                $('#tbProc').append(dtTR);

            });
            if ($('#tblProcedures tr').length > 0) {
                document.getElementById('tblProcedures').style.display = "block";
            }
            $('#txtProName').val('');
            $('#txtQuantity').val('');
            
        }
        function SaveAddedProc() {
            
            if ($("#tblProcedures")[0].rows.length > 1) {
                var lstProcItems = [];
                $('[id$="tblProcedures"] tbody tr').each(function(i, n) {
                    var currentRow = $(n);
                    var ProcedureID = currentRow.find("span[id$='ProcID']").html();
                    var ProcedureName = currentRow.find("span[id$='ProName']").html();
                    //var OdreredQty = currentRow.find("span[id$='Quantity']").html();

                    lstProcItems.push({
                        ProcedureID: ProcedureID,
                        ProcedureName: ProcedureName,
                       // OdreredQty: OdreredQty
                        OdreredQty: 1
                    });
                    $('[id$="hdnAddItems"]').val(JSON.stringify(lstProcItems));
                });
            }

        }
        function SetorderedProcedure() {
            var rowCount = $('#tblProcedures tr').length;
            var list = JSON.parse($('[id$="hdnSetOrderedProc"]').val());
            $.each(list, function(i, obj) {
                var RowNO = Number(rowCount + i);
                dtTR = $('<tr/>');
                var ID = $('<td align="left"/>').html("<span id='RowID'>" + RowNO + " </span>");
                var ProcedureID = $('<td align="left"/>').html("<span id='ProcID'>" + obj.ProcedureID + " </span>");
                var ProName = $('<td align="left"/>').html("<span id='ProName'>" + obj.ProcedureName + " </span>");
               // var ProcQuantity = $('<td align="left"/>').html("<span id='Quantity'>" + obj.OdreredQty + " </span>");
                var btnDelete = '<input id="btnDelete" value="' + "Delete" + '" type="button" style="background-color: Transparent; color: Red; border-style: none; text-decoration: underline; cursor: pointer; font-size: 12px;" onclick="onDeleteItem(this);"/>';
                var tdAction = $('<td/>').html(btnDelete);
                //dtTR.append(ID).append(ProcedureID).append(ProName).append(ProcQuantity).append(tdAction);
                dtTR.append(ID).append(ProcedureID).append(ProName).append(tdAction);
                $('#tbProc').append(dtTR);

            });
        }
    </script>

</head>
<body>
    <form id="form1" runat="server" defaultbutton="btnHideValues">
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="True">
        <Services>
            <asp:ServiceReference Path="~/WebService.asmx" />
        </Services>
    </asp:ScriptManager>
    <div id="wrapper">
        <div id="header">
            <div class="logoleft" style="z-index: 2;">
                <div class="logowrapper">
                    <img alt="" src="<%=LogoPath%>" class="logostyle" />
                </div>
            </div>
            <div class="middleheader">
                <uc2:Header ID="Header2" runat="server" />
                <uc6:PatientHeader ID="PatientHeader1" runat="server" ShowVitals="true" />
            </div>
            <div style="float: right;" class="Rightheader">
            </div>
        </div>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
                <td width="15%" valign="top" id="menu" style="display: block;">
                    <div id="navigation">
                        <uc3:LeftMenu ID="LeftMenu1" runat="server" />
                    </div>
                </td>
                <td width="85%" valign="top" class="tdspace">
                    <img alt="" onclick="Showmenu();Showhide();" src="../Images/hide.png" id="showmenu"
                        style="cursor: pointer;" />
                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td>
                                <Top:TopHeader ID="TopHeader1" runat="server" />
                            </td>
                        </tr>
                    </table>
                    <div class="contentdata1" id="dMain">
                        <ul>
                            <li>
                                <uc7:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                        <table id="tbAssPhy" runat="server" style="display: none">
                                <tr id="Tr1" runat="server">
                                    <td id="Td1" runat="server">
                                        <asp:Label ID="lblPrescription" runat="server" Text="OnBehalf   :" meta:resourcekey="lblPrescriptionResource1"></asp:Label>
                                    </td>
                                    <td id="Td2" runat="server">
                                        <asp:DropDownList ID="drpPhysician" runat="server">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                            </table>
                        <asp:Panel ID="pnlVitals" runat="server" CssClass="defaultfontcolor" meta:resourcekey="pnlVitalsResource1">
                            <table border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td class="colorforcontent" width="35%" height="23" align="left">
                                        <div style="display: block;" id="ACX2plusMVitals">
                                            &nbsp;<img src="../Images/showBids.gif" alt="Show" width="15" height="15" align="top"
                                                style="cursor: pointer" onclick="showResponses('ACX2plusMVitals','ACX2minusMVitals','ACX2responsesMVitals',1);" />
                                            <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plusMVitals','ACX2minusMVitals','ACX2responsesMVitals',1);">
                                                <asp:Label ID="Rs_CollectVitals" Text="Collect Vitals" runat="server" meta:resourcekey="Rs_CollectVitalsResource1"></asp:Label></span>
                                        </div>
                                        <div style="display: none; height: 18px;" id="ACX2minusMVitals">
                                            &nbsp;<img src="../Images/hideBids.gif" alt="hide" width="15" height="15" align="top"
                                                style="cursor: pointer" onclick="showResponses('ACX2plusMVitals','ACX2minusMVitals','ACX2responsesMVitals',0);" />
                                            <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plusMVitals','ACX2minusMVitals','ACX2responsesMVitals',0);">
                                                <asp:Label ID="Rs_CollectVitals1" Text="Collect Vitals" runat="server" meta:resourcekey="Rs_CollectVitals1Resource1"></asp:Label></span>
                                        </div>
                                    </td>
                                    <td width="75%" height="23" align="left">
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr class="tablerow" id="ACX2responsesMVitals" style="display: none">
                                    <td colspan="2">
                                        <div class="dataheader2">
                                            <uc11:PatientVitals ID="uctPatientVitalsControl" runat="server" />
                                            <br clear="all" />
                                            <br clear="all" />
                                        </div>
                                    </td>
                                </tr>
                                 <tr>
                                    <td>
                                        <table>
                                            <tr>
                                                <td class="colorforcontent" width="35%" height="23" align="left">
                                                    <div style="display: block" id="ACX2plusM12">
                                                        &nbsp;<img src="../Images/showBids.gif" alt="Show" width="15" height="15" align="top"
                                                            style="cursor: pointer" onclick="showResponses('ACX2plusM12','ACX2minusM12','ACX2responsesM12',1);" />
                                                        <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plusM','ACX2minusM12','ACX2responsesM12',1);">
                                                            <asp:Label ID="lblProcedure" Text="Procedure" runat="server"></asp:Label></span>
                                                    </div>
                                                    <div style="display: none; height: 18px;" id="ACX2minusM12">
                                                        &nbsp;<img src="../Images/hideBids.gif" alt="hide" width="15" height="15" align="top"
                                                            style="cursor: pointer" onclick="showResponses('ACX2plusM12','ACX2minusM12','ACX2responsesM12',0);" />
                                                        <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plusM','ACX2minusM12','ACX2responsesM12',0);">
                                                            <asp:Label ID="lblProcedure1" Text="Procedure" runat="server"></asp:Label></span>
                                                    </div>
                                                </td>
                                                <td width="75%" height="23" align="left">
                                                    &nbsp;
                                                </td>
                                            </tr>
                                            <tr class="tablerow" id="ACX2responsesM12" style="display: none">
                                                <td>
                                                    <div class="unfounddataheader2">
                                                        <table width="100%" border="0" class="defaultfontcolor">
                                                            <tr>
                                                                <td align="left" valign="top">
                                                                    <label class="defaultfontcolor" style="cursor: pointer" onclick="ShowProfile('DivProfile')">
                                                                        <asp:Label ID="lblProcedures" Text="Procedure Name" runat="server"></asp:Label></label>
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox CssClass="Txtboxsmall" ID="txtProName" runat="server" onfocus="chkContext();"></asp:TextBox>
                                                                    <AutoCom:AutoCompleteExtender ID="AutoCompleteExtender3" runat="server" TargetControlID="txtProName"
                                                                        EnableCaching="False" MinimumPrefixLength="1" CompletionInterval="0" FirstRowSelected="True"
                                                                        OnClientItemSelected="LstSelected" CompletionListCssClass="wordWheel listMain .box"
                                                                        CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                                        ServiceMethod="GetBillingItems" ServicePath="~/OPIPBilling.asmx" UseContextKey="True"
                                                                        DelimiterCharacters="" Enabled="True">
                                                                    </AutoCom:AutoCompleteExtender>
                                                                </td>
                                                                <td>
                                                                    <input type="button" id="btnAddPro" value="ADD" CssClass="btn" onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" onclick="CreateTable()" />
                                                                </td>
                                                                <td style="display: none;">
                                                                    <asp:Label ID="LblQuantity" runat="server" Text="Quantity" Width="30px"></asp:Label>
                                                                </td>
                                                                <td style="display: none;">
                                                                    <asp:TextBox ID="txtQuantity" CssClass="Txtboxsmall" runat="server" Width="30px"></asp:TextBox>
                                                                </td>
                                                                
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <table id="tblProcedures" border="1" cellpadding="2" cellspacing="0" class="dataheaderInvCtrl"
                                                                        style="text-align: left; font-size: 11px; display: none" width="100%">
                                                                        <thead class="dataheader1">
                                                                            <tr>
                                                                                <th style="width: 20%" scope="col">
                                                                                    <asp:Label ID="thRow" runat="server" Text="No"></asp:Label>
                                                                                </th>
                                                                                <th style="width: 20%;display:none" scope="col">
                                                                                    <asp:Label ID="thProcID" runat="server" Text="ID"></asp:Label>
                                                                                </th>
                                                                                <th style="width: 20%" scope="col">
                                                                                    <asp:Label ID="thProName" runat="server" Text="Name"></asp:Label>
                                                                                </th>
                                                                                <th style="width: 20%" scope="col">
                                                                                    <asp:Label ID="lblQty" runat="server" Text="Quantity"></asp:Label>
                                                                                </th>
                                                                                <th style="width: 20%" scope="col">
                                                                                    <asp:Label ID="thAction" runat="server" Text="Action"></asp:Label>
                                                                                </th>
                                                                            </tr>
                                                                        </thead>
                                                                        <tbody id="tbProc">
                                                                        </tbody>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                        <br />
                        <br />
                        <asp:Panel ID="pnlRec" runat="server" CssClass="defaultfontcolor" Width="850px" meta:resourcekey="pnlRecResource1">
                            <div class="dataheader2">
                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td style="width: 100%">
                                            <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                                <tr>
                                                    <td class="colorforcontent" width="100%" height="23" align="left">
                                                        <div style="display: none" id="ACX2plus1">
                                                            &nbsp;<img src="../Images/showBids.gif" alt="Show" width="15" height="15" align="top"
                                                                style="cursor: pointer" onclick="showResponses('ACX2plus1','ACX2minus1','ACX2responses1',1);" />
                                                            <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plus1','ACX2minus1','ACX2responses1',1);">
                                                                &nbsp;<asp:Label ID="Rs_Diagnosis" Text="Diagnosis" runat="server" meta:resourcekey="Rs_DiagnosisResource1"></asp:Label></span>
                                                        </div>
                                                        <div style="display: block" id="ACX2minus1">
                                                            &nbsp;<img src="../Images/hideBids.gif" alt="hide" width="15" height="15" align="top"
                                                                style="cursor: pointer" onclick="showResponses('ACX2plus1','ACX2minus1','ACX2responses1',0);" />
                                                            <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plus1','ACX2minus1','ACX2responses1',0);">
                                                                &nbsp;<asp:Label ID="Rs_Diagnosis1" Text="Diagnosis" runat="server" meta:resourcekey="Rs_Diagnosis1Resource1"></asp:Label></span>
                                                        </div>
                                                    </td>
                                                </tr>
                                                <tr id="ACX2responses1" style="display: block;">
                                                    <td colspan="2" width="100%">
                                                        <asp:Button ID="btnhidden" runat="server" Text="btnhidden" Visible="False" meta:resourcekey="btnhiddenResource1" />
                                                        <uc5:ComplaintICDCode ID="ComplaintICDCode1" runat="server" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </asp:Panel>
                        <br />
                        <br />
                        <asp:Panel ID="pnlInvest" runat="server" CssClass="defaultfontcolor" Width="720px"
                            meta:resourcekey="pnlInvestResource1">
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td class="colorforcontent" width="25%" height="23" align="left">
                                        <div style="display: block" id="ACX2plus10">
                                            &nbsp;<img src="../Images/showBids.gif" alt="Show" width="15" height="15" align="top"
                                                style="cursor: pointer" onclick="showResponses('ACX2plus10','ACX2minus10','ACX2responses10',1);" />
                                            <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plus10','ACX2minus10','ACX2responses10',1);">
                                                &nbsp;<asp:Label ID="Rs_Investigation" Text="Investigation" runat="server" meta:resourcekey="Rs_InvestigationResource1"></asp:Label></span>
                                        </div>
                                        <div style="display: none" id="ACX2minus10">
                                            &nbsp;<img src="../Images/hideBids.gif" alt="hide" width="15" height="15" align="top"
                                                style="cursor: pointer" onclick="showResponses('ACX2plus10','ACX2minus10','ACX2responses10',0);" />
                                            <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plus10','ACX2minus10','ACX2responses10',0);">
                                                &nbsp;<asp:Label ID="Rs_Investigation1" Text="Investigation" runat="server" meta:resourcekey="Rs_Investigation1Resource1"></asp:Label></span>
                                        </div>
                                    </td>
                                    <td width="75%" height="23" align="left">
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr class="tablerow" id="ACX2responses10" style="display: none">
                                    <td colspan="2">
                                        <div class="unfounddataheader2">
                                            <table width="100%" border="0" class="defaultfontcolor">
                                                <tr>
                                                    <td align="left" valign="top">
                                                        <label class="defaultfontcolor" style="cursor: pointer" onclick="ShowProfile('DivProfile')">
                                                            <asp:Label ID="Rs_MoreInvestigations" Text="More Investigations..." runat="server"
                                                                meta:resourcekey="Rs_MoreInvestigationsResource1"></asp:Label></label>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                        <br />
                        <br />
                        <uc5:Advice ID="uAd" runat="server" />
                        <uc12:InvenAdv ID="uIAdv" runat="server" />
                        <br />
                        <br />
                        <uc9:GeneralAdv ID="uGAdv" runat="server" />
                        <br />
                        <br />
                        <asp:Panel ID="pnlMiscellaneous" runat="server" CssClass="defaultfontcolor" meta:resourcekey="pnlMiscellaneousResource1">
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td class="colorforcontent" width="35%" height="23" align="left">
                                        <div style="display: block" id="ACX2plusM">
                                            &nbsp;<img src="../Images/showBids.gif" alt="Show" width="15" height="15" align="top"
                                                style="cursor: pointer" onclick="showResponses('ACX2plusM','ACX2minusM','ACX2responsesM',1);" />
                                            <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plusM','ACX2minusM','ACX2responsesM',1);">
                                                <asp:Label ID="Rs_Miscellaneous" Text="Miscellaneous" runat="server" meta:resourcekey="Rs_MiscellaneousResource1"></asp:Label></span>
                                        </div>
                                        <div style="display: none; height: 18px;" id="ACX2minusM">
                                            &nbsp;<img src="../Images/hideBids.gif" alt="hide" width="15" height="15" align="top"
                                                style="cursor: pointer" onclick="showResponses('ACX2plusM','ACX2minusM','ACX2responsesM',0);" />
                                            <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plusM','ACX2minusM','ACX2responsesM',0);">
                                                <asp:Label ID="Rs_Miscellaneous1" Text="Miscellaneous" runat="server" meta:resourcekey="Rs_Miscellaneous1Resource1"></asp:Label></span>
                                        </div>
                                    </td>
                                    <td width="75%" height="23" align="left">
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr class="tablerow" id="ACX2responsesM" style="display: none">
                                    <td colspan="2">
                                        <div class="dataheader2">
                                            <br />
                                            <asp:CheckBox ID="chkAdmit" CssClass="defaultfontcolor" runat="server" Text="Admit"
                                                meta:resourcekey="chkAdmitResource1" />
                                            <br />
                                            <asp:CheckBox ID="chkAdditionalPayments" runat="server" onclick="return fnChk(this.id);" Visible="False" Text="Check here to capture additional charges"
                                                meta:resourcekey="chkAdditionalPaymentsResource1" />
                                            <br />
                                            <asp:CheckBox ID="chkRefer" CssClass="defaultfontcolor" onclick="return fnChk(this.id);" runat="server" Text="Referral / Medical Letter"
                                                meta:resourcekey="chkReferResource1" />
                                            <br />
                                            <br />
                                            &nbsp;<asp:Label ID="lblTxt" runat="server" Text="Next Review After" CssClass="defaultfontcolor"
                                                meta:resourcekey="lblTxtResource1"></asp:Label>
                                            <asp:DropDownList ID="ddlNos" runat="server" CssClass="ddl" meta:resourcekey="ddlNosResource1">
                                                <asp:ListItem Value="1" meta:resourcekey="ListItemResource1" Selected ="True" >1</asp:ListItem>
                                                <asp:ListItem Value="2" meta:resourcekey="ListItemResource2">2</asp:ListItem>
                                                <asp:ListItem Value="3" meta:resourcekey="ListItemResource3">3</asp:ListItem>
                                                <asp:ListItem Value="4" meta:resourcekey="ListItemResource4">4</asp:ListItem>
                                                <asp:ListItem Value="5" meta:resourcekey="ListItemResource5">5</asp:ListItem>
                                                <asp:ListItem Value="6" meta:resourcekey="ListItemResource6">6</asp:ListItem>
                                                <asp:ListItem Value="7" meta:resourcekey="ListItemResource7">7</asp:ListItem>
                                                <asp:ListItem Value="8" meta:resourcekey="ListItemResource8">8</asp:ListItem>
                                                <asp:ListItem Value="9" meta:resourcekey="ListItemResource9">9</asp:ListItem>
                                                <asp:ListItem Value="10" meta:resourcekey="ListItemResource10">10</asp:ListItem>
                                                <asp:ListItem Value="11" meta:resourcekey="ListItemResource11">11</asp:ListItem>
                                                <asp:ListItem Value="0" meta:resourcekey="ListItemResource12">0</asp:ListItem>
                                            </asp:DropDownList>
                                            <asp:DropDownList ID="ddlDMY" runat="server" CssClass="ddl" meta:resourcekey="ddlDMYResource1">
                                                <asp:ListItem Value="Day(s)" meta:resourcekey="ListItemResource13">Day(s)</asp:ListItem>
                                                <asp:ListItem Value="Week(s)" meta:resourcekey="ListItemResource14">Week(s)</asp:ListItem>
                                                <asp:ListItem Value="Month(s)" meta:resourcekey="ListItemResource15">Month(s)</asp:ListItem>
                                                <asp:ListItem Value="Year(s)" meta:resourcekey="ListItemResource16">Year(s)</asp:ListItem>
                                                <asp:ListItem Value="0">0</asp:ListItem>
                                            </asp:DropDownList>
                                            <br clear="all" />
                                            <br clear="all" />
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                        <br />
                        <br />
                        <asp:Panel ID="pnlSave" runat="server" CssClass="defaultfontcolor" Width="720px"
                            meta:resourcekey="pnlSaveResource1">
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr class="tablerow" style="background-color: Transparent">
                                    <td>
                                        <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                                            <ContentTemplate>
                                                <table width="100%">
                                                    <tr>
                                                        <td style="width: 25%">
                                                            <asp:Label ID="lblError" runat="server" CssClass="errorbox" Visible="False" meta:resourcekey="lblErrorResource1"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 25%">
                                                            <asp:Button ID="btnSave" runat="server" CssClass="btn" OnClick="btnSave_Click" onmouseout="this.className='btn'"
                                                                onmouseover="this.className='btn btnhov'" Text="Finish" OnClientClick="SaveAddedProc()" meta:resourcekey="btnSaveResource1" />
                                                            <asp:Button ID="btnCancel" runat="server" CssClass="btn" OnClick="btnCancel_Click"
                                                                onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'" Text="Cancel"
                                                                meta:resourcekey="btnCancelResource1" />
                                                            <asp:Button ID="Back" runat="server" CssClass="btn" OnClick="Back_Click" onmouseout="this.className='btn'"
                                                                onmouseover="this.className='btn btnhov'" Text="Back" meta:resourcekey="BackResource1" />
                                                            <asp:Label runat="server" ID="lblRedirectURL" Visible="False" meta:resourcekey="lblRedirectURLResource1"></asp:Label>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                    </div>
                    <div id="DivProfile" style="display: none;" class="contentdata1">
                        <uc10:InvestigationControl ID="InvestigationControl1" runat="server" />
                        <input type="button" value="OK" id="Button1" runat="server" class="btn" onmouseover="this.className='btn btnhov'"
                            onmouseout="this.className='btn'" onclick="ShowProfile('DivProfile')" />
                            <asp:HiddenField runat="server" ID="hdnVisitID" />
                            <asp:HiddenField runat="server" ID="Hdnlist" />
                            <asp:HiddenField runat="server" ID="hdnAddItems" />
                            <asp:HiddenField runat="server" ID="hdnSetOrderedProc" />
                             <asp:HiddenField ID="hdnMessages" runat="server" />
                    </div>
                </td>
            </tr>
        </table>
        <uc4:Footer ID="Footer1" runat="server" />
    </div>
    <asp:Button ID="btnHideValues" runat="server" OnClientClick="javascript:return false;"
        Style="height: 0px; width: 0px;" meta:resourcekey="btnHideValuesResource1" />
    </form>
</body>
</html>
