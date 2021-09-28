<%@ Page Language="C#" AutoEventWireup="true" CodeFile="BloodSearchAndSeperation.aspx.cs"
    Inherits="BloodBank_BloodSearchAndSeperation" meta:resourcekey="PageResource1" %>

<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/PendingVitals.ascx" TagName="PendingVitalsControl"
    TagPrefix="uc2" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/Tasks.ascx" TagName="TaskControl" TagPrefix="uc6" %>
<%@ Register Src="../CommonControls/TaskEscalation.ascx" TagName="TaskEscalation"
    TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/ReminderDisplay.ascx" TagName="ReminderDisplay"
    TagPrefix="uc8" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc9" %>
<%@ Register Src="../CommonControls/Department.ascx" TagName="Department" TagPrefix="uc10" %>
<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Blood Seperation Page</title>
    <link href="../Images/favicon.ico" rel="shortcut icon" />
    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <%--<link href="../StyleSheets/Style.css" rel="stylesheet" type="text/css" />--%>

    <script type="text/javascript" src="../Scripts/Common.js"></script>

    <script type="text/javascript" src="../Scripts/bid.js"></script>

    <script language="javascript" type="text/javascript">
        function ShowDivSeperation(id, rowid) {
            document.getElementById('divSeperation').style.display = 'block';
            document.getElementById('divSave').style.display = 'block';
            document.getElementById('divBagList').style.display = 'none';
            var grd = document.getElementById('grdBagList');
            document.getElementById('lblBagNoValue').innerHTML = grd.rows[rowid + 1].cells[0].innerText;
            document.getElementById('hdnParentbagID').value = grd.rows[rowid + 1].cells[0].innerText;
            document.getElementById('lblBagTypeValue').innerHTML = grd.rows[rowid + 1].cells[1].innerText;
            document.getElementById('hdnBloodBagType').value = grd.rows[rowid + 1].cells[1].innerText;
            document.getElementById('lblBloodGroupValue').innerHTML = grd.rows[rowid + 1].cells[2].innerText;
            document.getElementById('hdnBloodGroup').value = grd.rows[rowid + 1].cells[2].innerText;
            var ddl = document.getElementById('ddlComponent');
            for (var i = 1; i < ddl.length; i++) {
                var comp = ddl.options[i].text;
                //            var Id = ddl.options[i].value();


                var finalcomp = grd.rows[rowid + 1].cells[2].innerHTML + ' ' + comp;
                ddl.options[i].text = finalcomp;

            }
        }
        function BackToSearch() {
            document.getElementById('divSeperation').style.display = 'none';
            document.getElementById('divSave').style.display = 'none';
            document.getElementById('divBagList').style.display = 'block';
            var ddl = document.getElementById('ddlComponent');
            for (var i = 1; i < ddl.length; i++) {
                var comp = ddl.options[i].text;
                var finalcomp = comp.split(' ')[1];
                ddl.options[i].text = finalcomp;
            }
        }
        function onClickAddComponent() {
            var hiddenfield;
            var table;
            var txtComponent;
            var txtBagNo;
            var txtVolume;
            var DDlVolume;
            var txtExpiry;
            hiddenfield = 'hdnComponents';
            table = 'tblComponents';
            txtComponent = 'ddlComponent';
            txtBagNo = 'txtBagNo';
            txtVolume = 'txtVolume';
            txtExpiry = 'txtExpiry';
            var rwNumber = parseInt(110);
            var AddStatus = 0;
            var txtComponentName = document.getElementById(txtComponent).options[document.getElementById(txtComponent).selectedIndex].text;
            var ComponentID = document.getElementById(txtComponent).options[document.getElementById(txtComponent).selectedIndex].value;
            var txtBag = document.getElementById(txtBagNo).value.trim();
            //var txtVolumeValue = document.getElementById(txtVolume).value;
            var txtVolumeValue = document.getElementById('ddlUnits').options[document.getElementById('ddlUnits').selectedIndex].text;
            var txtExpiryValue = document.getElementById(txtExpiry).value;
            document.getElementById(table).style.display = 'block';
            var HidValue = document.getElementById(hiddenfield).value;
            var list = HidValue.split('^');
            if (document.getElementById(hiddenfield).value != "") {
                for (var count = 0; count < list.length; count++) {
                    var HistoryList = list[count].split('~');
                    if (HistoryList[1] != '') {
                        if (HistoryList[0] != '') {
                            rwNumber = parseInt(parseInt(HistoryList[0]) + parseInt(1));
                        }
                        if (txtComponentName != '') {
                            if (HistoryList[1] == txtComponentName) {
                                AddStatus = 1;
                            }
                        }
                    }
                }
            }
            else {

                if (txtComponentName != '') {
                    var row = document.getElementById(table).insertRow(1);
                    row.id = parseInt(rwNumber);
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    var cell4 = row.insertCell(3);
                    var cell5 = row.insertCell(4);
                    cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickComponent(" + parseInt(rwNumber) + ");' src='../Images/Delete.jpg' />";
                    cell1.width = "6%";
                    cell2.innerHTML = txtComponentName;
                    cell3.innerHTML = txtBag;
                    cell4.innerHTML = txtVolumeValue;
                  //  cell4.innerHTML = ddlVolumeValue;
                    
                    cell5.innerHTML = txtExpiryValue;
                    document.getElementById(hiddenfield).value += parseInt(rwNumber) + "~" + txtComponentName + "~" + txtBag + "~" + txtVolumeValue + "~" + txtExpiryValue + "~" + ComponentID + "^";
                    AddStatus = 2;
                }
            }
            if (AddStatus == 0) {
                if (txtComponentName != '') {
                    var row = document.getElementById(table).insertRow(1);
                    row.id = parseInt(rwNumber);
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    var cell4 = row.insertCell(3);
                    var cell5 = row.insertCell(4);
                    cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickComponent(" + parseInt(rwNumber) + ");' src='../Images/Delete.jpg' />";
                    cell1.width = "6%";
                    cell2.innerHTML = txtComponentName;
                    cell3.innerHTML = txtBag;
                    cell4.innerHTML = txtVolumeValue;
                    cell5.innerHTML = txtExpiryValue;
                    document.getElementById(hiddenfield).value += parseInt(rwNumber) + "~" + txtComponentName + "~" + txtBag + "~" + txtVolumeValue + "~" + txtExpiryValue + "~" + ComponentID + "^";
                }
            }
            else if (AddStatus == 1) {
                alert("Component Already Added!");
            }
            document.getElementById(txtComponent).value = '';
            document.getElementById(txtBagNo).value = '';
            //            document.getElementById(txtVolume).value = '';
            document.getElementById('ddlUnits').value =0;
            document.getElementById(txtExpiry).value = '';
            return false;
        }
        function ImgOnclickComponent(ImgID) {
            document.getElementById(ImgID).style.display = "none";
            var HidValue = document.getElementById('hdnComponents').value;
            var list = HidValue.split('^');
            var newHistoryList = '';
            if (document.getElementById('hdnComponents').value != "") {
                for (var count = 0; count < list.length; count++) {
                    var HistoryList = list[count].split('~');
                    if (HistoryList[0] != '') {
                        if (HistoryList[0] != ImgID) {
                            newHistoryList += list[count] + '^';
                        }
                    }
                }
                document.getElementById('hdnComponents').value = newHistoryList;
            }
            if (document.getElementById('hdnComponents').value == '') {
                document.getElementById('tblComponents').style.display = 'none';
            }
        }
        function checkDate1(obj) {
          
            var dt = new Date();
            var CurrentYear = dt.getFullYear();
            var CurrentMonth = dt.getMonth()+1;
            var mm = (CurrentMonth < 10) ? '0' + CurrentMonth : CurrentMonth;
            var myValStr = document.getElementById(obj).value;

            if (myValStr != "__/____" && myValStr != "") {
                var Mon = myValStr.split('/')[0];
                var pyyyy = myValStr.split('/')[1];
                if (pyyyy < CurrentYear) {
                    alert('Provide Vaid Year');
                    return false;
                }
                if (Mon < mm && CurrentYear == pyyyy) {
                    alert('provide Valid Month');
                    return false;
                }
                var isTrue = false;
                
                var myMonth = new Array('01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12');
                for (i = 0; i < myMonth.length; i++) {
                    if (myMonth[i] != "" && Mon != "" && Mon == myMonth[i] && Mon.length == 2) {
                        isTrue = true;
                    }
                }
                if (!isTrue) {
                    document.getElementById(obj).focus();
                    alert("Provide valid date");
                    return isTrue;
                }
                var pdate = Mon + pyyyy;
                var pdatelen = pdate.length;
                for (j = 0; j < pdatelen; j++) {
                    if (pdate.charAt(j) == "_") {
                        document.getElementById(obj).focus();
                        alert("Provide valid date");
                        return false;
                    }
                }
            }
        }
        function DdlOnChange() {
            var ComponentName = document.getElementById('ddlComponent').options[document.getElementById('ddlComponent').selectedIndex].text;
            document.getElementById('hdnComponentName').value = ComponentName;
           // GetUnits(ComponentName);

        }

//        function GetUnits(Name) {
//        

//          
//            var ddl= document.getElementById('ddlComponent');
//            for (var i = 1; i < ddl.length; i++) {
//                var comp = ddl.options[i].text;
//                if (comp == Name) {
//              
//                    document.getElementById('ddlUnits').options[document.getElementById('ddlUnits').selectedIndex].text=unit;
//                }
//                
//             

//            }
//            alert(ddlunits);
//          
//            console.log(ddlunits);
////           if(Name ==ddlunits.setAttribute
//          
//        
//        }

      
    </script>

</head>
<body>
    <form id="frmPatientVitals" runat="server">
    <asp:ScriptManager ID="ctlTaskScriptMgr" runat="server">
    </asp:ScriptManager>
    <div id="wrapper">
        <div id="header">
            <div class="logoleft" style="z-index: 2;">
                <div class="logowrapper">
                    <img alt="" src="<%=LogoPath%>" class="logostyle" />
                </div>
            </div>
            <div class="middleheader">
                <uc4:MainHeader ID="MainHeader" runat="server" />
                <uc3:Header ID="AdminHeader" runat="server" />
            </div>
            <div style="float: right;" class="Rightheader">
            </div>
        </div>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
                <td width="15%" valign="top" id="menu" style="display: block;">
                    <div id="navigation">
                        <uc1:LeftMenu ID="LeftMenu1" runat="server" />
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
                    <div class="contentdata1">
                        <ul>
                            <li>
                                <uc9:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                        <div>
                            <table width="100%">
                                <tr>
                                    <td>
                                        <asp:Label ID="lblSearchBagNo" runat="server" Text="Bag Number" meta:resourcekey="lblSearchBagNoResource1"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtSearchBagNo" runat="server" CssClass="Txtboxsmall" meta:resourcekey="txtSearchBagNoResource1"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblSearchBagType" runat="server" Text="Bag Type" meta:resourcekey="lblSearchBagTypeResource1"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlSearchBagType" CssClass="ddl" runat="server" meta:resourcekey="ddlSearchBagTypeResource1">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblSearchBloodGroup" runat="server" Text="Blood Group" meta:resourcekey="lblSearchBloodGroupResource1"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlSearchBloodGroup" CssClass="ddl" runat="server" meta:resourcekey="ddlSearchBloodGroupResource1">
                                        </asp:DropDownList>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblBloodType" runat="server" Text="Blood Type" meta:resourcekey="lblBloodTypeResource1"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlSearchBloodType" CssClass="ddl" runat="server" meta:resourcekey="ddlSearchBloodTypeResource1">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2" align="right">
                                        <asp:Button ID="btnSearch" Text="Search" CssClass="btn" runat="server" OnClick="btnSearch_Click"
                                            meta:resourcekey="btnSearchResource1" />
                                        <asp:Button ID="btnExit" Text="Cancel" CssClass="btn" runat="server" OnClick="btnCancel_Click"
                                            meta:resourcekey="btnExitResource1" />
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div id="divBagList" runat="server" style="display: block">
                            <asp:GridView ID="grdBagList" runat="server" OnRowDataBound="grdBagList_RowDataBound"
                                AutoGenerateColumns="False" Width="100%" meta:resourcekey="grdBagListResource1">
                                <Columns>
                                    <asp:BoundField HeaderText="BagNo" DataField="BagNumber" meta:resourcekey="BoundFieldResource1" />
                                    <asp:BoundField HeaderText="BagType" DataField="BagType" meta:resourcekey="BoundFieldResource2" />
                                    <asp:BoundField HeaderText="BloodGroup" DataField="BloodGroup" meta:resourcekey="BoundFieldResource3" />
                                    <asp:BoundField HeaderText="BloodType" DataField="BloodComponent" meta:resourcekey="BoundFieldResource4" />
                                    <asp:ButtonField ButtonType="Link" Text="Seperate BloodComponents"  />
                                </Columns>
                            </asp:GridView>
                        </div>
                        <div id="divSeperation" runat="server" style="display: none">
                            <table class="dataheader2" width="100%" style="font-size: small; color: Black" cellpadding="0"
                                cellspacing="0">
                                <tr>
                                    <td>
                                        <asp:Label ID="lblBagNo" Text="Bag Number :: " runat="server" meta:resourcekey="lblBagNoResource1"></asp:Label>
                                        <asp:Label ID="lblBagNoValue" runat="server" meta:resourcekey="lblBagNoValueResource1"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblBagType" Text="BagType :: " runat="server" meta:resourcekey="lblBagTypeResource1"></asp:Label>
                                        <asp:Label ID="lblBagTypeValue" runat="server" meta:resourcekey="lblBagTypeValueResource1"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblBloodGroup" Text="Blood Group :: " runat="server" meta:resourcekey="lblBloodGroupResource1"></asp:Label>
                                        <asp:Label ID="lblBloodGroupValue" runat="server" meta:resourcekey="lblBloodGroupValueResource1"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                            &nbsp;&nbsp;
                            <table cellpadding="0" cellspacing="10" class="datatable" style="color: Black" width="80%">
                                <tr>
                                    <td align="center" colspan="4">
                                        <asp:Label ID="lblBloodSeperation" Font-Size="Large" Text="Enter Blood Seperation Details"
                                            runat="server" meta:resourcekey="lblBloodSeperationResource1"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblComponent" runat="server" Text="Component Name" meta:resourcekey="lblComponentResource1"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblBagNumber" runat="server" Text="BagNumber" meta:resourcekey="lblBagNoResource1"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblVolume" runat="server" Text="Volume"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblExpiry" runat="server" Text="Expiry Date" meta:resourcekey="lblVolumeResource1"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:DropDownList ID="ddlComponent" onchange="javascript:DdlOnChange();" runat="server"
                                            meta:resourcekey="ddlComponentResource1">
                                        </asp:DropDownList>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtBagNo" runat="server" meta:resourcekey="txtBagNoResource1"></asp:TextBox>
                                    </td>
                                     <td>
                                        <asp:DropDownList ID ="ddlUnits"  runat="server" Visible ="True"></asp:DropDownList>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtVolume" runat="server" Visible ="false"></asp:TextBox>
                                    </td>
                                    
                                    <td>
                                        <asp:TextBox ID="txtExpiry" runat="server" onblur="return checkDate1(this.id);" meta:resourcekey="txtBagNoResource1"></asp:TextBox>
                                        <ajc:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="txtExpiry"
                                            Mask="99/9999" ClearMaskOnLostFocus="False" DisplayMoney="Left" AcceptNegative="Left"
                                            ErrorTooltipEnabled="True" CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder=""
                                            CultureDateFormat="" CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                            CultureTimePlaceholder="" Enabled="True" />
                                        <input type="button" id="btnAdd" onclick="onClickAddComponent();" value="Add" class="btn" />
                                    </td>
                                    
                                </tr>
                                <tr>
                                    <td colspan="3">
                                        <input type="hidden" id="hdnComponents" runat="server" />
                                        <table id="tblComponents" class="dataheaderInvCtrl" runat="server" cellpadding="4"
                                            cellspacing="0" border="0" style="display: none" width="97%">
                                            <tr id="Tr1" runat="server">
                                                <th id="Th1" style="font-size: 10px; text-decoration: underline; text-align: left"
                                                    runat="server">
                                                    Delete
                                                </th>
                                                <th id="Th2" style="font-size: 10px; text-decoration: underline; text-align: left"
                                                    runat="server">
                                                    Component
                                                </th>
                                                <th id="Th3" style="font-size: 10px; text-decoration: underline; text-align: left"
                                                    runat="server">
                                                    BagNumber
                                                </th>
                                                <th id="Th4" style="font-size: 10px; text-decoration: underline; text-align: left"
                                                    runat="server">
                                                    Volume
                                                </th>
                                                <th id="Th5" style="font-size: 10px; text-decoration: underline; text-align: left"
                                                    runat="server">
                                                    ExpiryDate
                                                </th>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                            <div id="divSave" runat="server" style="display: none">
                                <table class="datatable" width="80%" style="text-align: center">
                                    <tr valign="bottom">
                                        <td>
                                            <asp:Button ID="btnSave" Text="Save" runat="server" CssClass="btncss" OnClick="btnSave_Click"
                                                meta:resourcekey="btnSaveResource1" />
                                            <asp:Button ID="btnCancel" Text="Back" runat="server" CssClass="btncss" OnClientClick="Javascript:BackToSearch(); return false"
                                                meta:resourcekey="btnCancelResource1" />
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>
                </td>
            </tr>
        </table>
        <uc5:Footer ID="Footer1" runat="server" />
    </div>
    <asp:HiddenField ID="hdnRecords" runat="server" />
    <asp:HiddenField ID="hdnParentbagID" runat="server" />
    <asp:HiddenField ID="hdnBloodGroup" runat="server" />
    <asp:HiddenField ID="hdnBloodBagType" runat="server" />
    <asp:HiddenField ID="hdnComponentName" runat="server" />
    <asp:HiddenField ID ="HdnUnits" runat ="server" />
    </form>
</body>
</html>
