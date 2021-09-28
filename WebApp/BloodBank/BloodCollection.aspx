<%@ Page Language="C#" AutoEventWireup="true" CodeFile="BloodCollection.aspx.cs"
    Inherits="BloodBank_BloodCollection" meta:resourcekey="PageResource1" %>

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
    <title>Blood Collection Page</title>
    <link href="../Images/favicon.ico" rel="shortcut icon" />
    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    
    <%--<link href="../StyleSheets/Style.css" rel="stylesheet" type="text/css" />--%>

    <script type="text/javascript" src="../Scripts/Common.js"></script>
    
    <script type="text/javascript" src="../Scripts/bid.js"></script>

    <style type="text/css">
        .style2
        {
            height: 36px;
        }
    </style>
<script type ="text/javascript" >


  
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
                        <table class="dataheader2" width="100%" style="font-size: small" cellpadding="0"
                            cellspacing="0">
                            <tr>
                                <td>
                                    <asp:Label ID="lblName" Text="Name :: " runat="server" 
                                        meta:resourcekey="lblNameResource1"></asp:Label>
                                    <asp:Label ID="lblNameValue" runat="server" 
                                        meta:resourcekey="lblNameValueResource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="lblAgeOrSex" Text="Age/Sex :: " runat="server" 
                                        meta:resourcekey="lblAgeOrSexResource1"></asp:Label>
                                    <asp:Label ID="lblAgeOrSexValue" runat="server" 
                                        meta:resourcekey="lblAgeOrSexValueResource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="lblBloodGroup" Text="Blood Group :: " runat="server" 
                                        meta:resourcekey="lblBloodGroupResource1"></asp:Label>
                                    <asp:Label ID="lblBloodGroupValue" runat="server" 
                                        meta:resourcekey="lblBloodGroupValueResource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="lblVisitType" Text="Visit Type :: " runat="server" 
                                        meta:resourcekey="lblVisitTypeResource1"></asp:Label>
                                    <asp:Label ID="lblVisitTypeValue" runat="server" 
                                        meta:resourcekey="lblVisitTypeValueResource1"></asp:Label>
                                </td>
                            </tr>
                        </table>
                        &nbsp;&nbsp;
                        <table cellpadding="0" cellspacing="10" class="datatable" width="80%">
                            <tr>
                                <td>
                                    <asp:Label ID="lblBagNo" Text="Bag Number" runat="server" ForeColor="Black" 
                                        meta:resourcekey="lblBagNoResource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtBagNo"  CssClass="Txtboxsmall" runat="server" meta:resourcekey="txtBagNoResource1"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:Label ID="lblTubingID" Text="Tubing ID" runat="server" ForeColor="Black" 
                                        meta:resourcekey="lblTubingIDResource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="TxtTubeID" CssClass="Txtboxsmall" runat="server" 
                                        meta:resourcekey="TxtTubeIDResource1"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="style2">
                                    <asp:Label ID="lblBagType" Text="Bag Type" runat="server" ForeColor="Black" 
                                        meta:resourcekey="lblBagTypeResource1"></asp:Label>
                                </td>
                                <td class="style2">
                                    <asp:DropDownList ID="ddlBagMake" CssClass="ddl" runat="server" Width="50%" 
                                        meta:resourcekey="ddlBagMakeResource1" 
                                        >
                                    </asp:DropDownList>
                                </td>
                                <td class="style2">
                                    <asp:Label ID="lblBagCapacity" Text="Bag Capacity" runat="server" 
                                        ForeColor="Black" meta:resourcekey="lblBagCapacityResource1"></asp:Label>
                                </td>
                                <td style="color:Black" class="style2">
                                    <asp:DropDownList ID="ddlBagCapacity" CssClass="ddl" runat="server"  
                                        meta:resourcekey="ddlBagCapacityResource1">
                                        <asp:ListItem Value="250" meta:resourcekey="ListItemResource1">250</asp:ListItem>
                                        <asp:ListItem Value="300" meta:resourcekey="ListItemResource2">300</asp:ListItem>
                                        <asp:ListItem Value="350" meta:resourcekey="ListItemResource3">350</asp:ListItem>
                                        <asp:ListItem Value="450" meta:resourcekey="ListItemResource4">450</asp:ListItem>
                                        <asp:ListItem Value="500" meta:resourcekey="ListItemResource5">500</asp:ListItem>
                                    </asp:DropDownList>
                                    ml
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblAntiCoagulants" Text="Anti Coagulants" runat="server" 
                                        ForeColor="Black" meta:resourcekey="lblAntiCoagulantsResource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:RadioButtonList ID="rdoAntiCoagulants" runat="server" ForeColor="Black" 
                                        meta:resourcekey="rdoAntiCoagulantsResource1">
                                        <asp:ListItem Value="CPDA" meta:resourcekey="ListItemResource6">CPDA</asp:ListItem>
                                        <asp:ListItem Value="CPDA-II" meta:resourcekey="ListItemResource7">CPDA-II</asp:ListItem>
                                        <asp:ListItem Value="SAGM" meta:resourcekey="ListItemResource8">SAGM</asp:ListItem>
                                    </asp:RadioButtonList>
                                </td>
                                <td>
                                    <asp:Label ID="lblStorageSlot" Text="Storage Slot" runat="server" 
                                        ForeColor="Black" meta:resourcekey="lblStorageSlotResource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtStorageSlot" CssClass="Txtboxsmall" runat="server" 
                                        meta:resourcekey="txtStorageSlotResource1"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblUnitDrawn" Text="Unit Drawn (ml)" runat="server" ForeColor="Black" 
                                        meta:resourcekey="lblUnitDrawnResource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtUnitDrawn" CssClass="Txtboxsmall" runat="server" onblur="checkvalidity()"
                                        meta:resourcekey="txtUnitDrawnResource1"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:Label ID="lblBatchNo" Text="Batch No." runat="server" ForeColor="Black" 
                                        meta:resourcekey="lblBatchNoResource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtBatchNo" CssClass="Txtboxsmall" runat="server" 
                                        meta:resourcekey="txtBatchNoResource1"></asp:TextBox>
                                </td>
                              
                               
                            </tr>
                            <tr>
                               
                                <td>
                                    <asp:Label ID="lblExpiryDAte" Text="ExpiryDate" runat="server" ForeColor="Black" 
                                       ></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtExpiry" runat="server" onblur="return checkDate1(this.id);" ></asp:TextBox>
                                        <ajc:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="txtExpiry"
                                            Mask="99/9999" ClearMaskOnLostFocus="False" DisplayMoney="Left" AcceptNegative="Left"
                                            ErrorTooltipEnabled="True" CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder=""
                                            CultureDateFormat="" CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                            CultureTimePlaceholder="" Enabled="True" />
                                </td>
                                </td>
                            </tr>
                            &nbsp;&nbsp;&nbsp;
                            <tr>
                                <td>
                                    <asp:LinkButton ID="lnkCapture" Text="Capture" runat="server" Font-Bold="True" 
                                        Font-Size="Small" Font-Underline="True"
                                        ForeColor="Red" meta:resourcekey="lnkCaptureResource1"></asp:LinkButton>
                                </td>
                                <td colspan="5">
                                    <table ID="tblCapturedData" runat="server" cellpadding="0" class="dataheaderCtrl"
                                                cellspacing="20" style="text-align: left; display: none; padding-left: 60; color: Black" border="0"
                                                width="100%">
                                       <tr id="Tr1" runat="server">
                                          <th id="Th1" style="font-size: 12px; text-decoration: underline; text-align: left" runat="server">
                                              Captured Date/Time
                                          </th>
                                          <th id="Th2" style="font-size: 12px; text-decoration: underline; text-align: left" runat="server">
                                              HR
                                          </th>
                                          <th id="Th3" style="font-size: 12px; text-decoration: underline; text-align: left" runat="server">
                                              BP
                                          </th>
                                          <th id="Th4" style="font-size: 12px; text-decoration: underline; text-align: left" runat="server">
                                              Saturation
                                          </th>
                                          <th id="Th5" style="font-size: 12px; text-decoration: underline; text-align: left" runat="server">
                                              Volume(ml)
                                          </th>
                                          <th id="Th6" style="font-size: 12px; text-decoration: underline; text-align: left" runat="server">
                                              Condition
                                          </th>
                                       </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                        <ajc:ModalPopupExtender ID="mpe" runat="server" TargetControlID="lnkCapture" PopupControlID="ModalPanel"
                            DropShadow="True" BackgroundCssClass="modalBackground" OkControlID="CloseButton"
                            DynamicServicePath="" Enabled="True" />
                        <%--<asp:Button ID="btnMClose" runat="server" Style="visibility: hidden" />
                        <asp:Button ID="btnMFinish" runat="server" Style="visibility: hidden" />--%>
                        <asp:Panel ID="ModalPanel" runat="server" Style="display: none" CssClass="modalPopup"
                            Width="900px" Height="70px" meta:resourcekey="ModalPanelResource1">
                            <asp:UpdatePanel ID="up1" runat="server" UpdateMode="Conditional">
                                <ContentTemplate>
                                    <table>
                                        <tr align="left">
                                            <td align="left">
                                                HR:
                                                <asp:TextBox ID="txtHR" Width="20%" runat="server" 
                                                    meta:resourcekey="txtHRResource1"></asp:TextBox>bpm
                                            </td>
                                            <td align="left">
                                                BP:
                                                <asp:TextBox ID="txtBP1" Width="10%" runat="server" 
                                                    meta:resourcekey="txtBP1Resource1"></asp:TextBox> / 
                                                <asp:TextBox ID="txtBP2" Width="10%" runat="server" 
                                                    meta:resourcekey="txtBP2Resource1"></asp:TextBox>mmHg
                                            </td>
                                            <td align="left">
                                                Saturation:
                                                <asp:TextBox ID="txtSaturation" Width="20%" runat="server" 
                                                    meta:resourcekey="txtSaturationResource1"></asp:TextBox>%
                                            </td>
                                            <td align="left">
                                                Volume (ml):
                                                <asp:TextBox ID="txtVolume" Width="20%" runat="server" onblur="CheckVolume()"
                                                    meta:resourcekey="txtVolumeResource1"></asp:TextBox>
                                            </td>
                                            <td align="left">
                                                Condition:
                                            </td>
                                            <td align="left">
                                                <asp:RadioButton ID="rdoStable" Text="Stable" Width="100%" runat="server" 
                                                    GroupName="Condition" onclick="javascript:StableOrUnstable()" 
                                                    meta:resourcekey="rdoStableResource1"/>
                                            </td>
                                            <td align="left">
                                                <asp:RadioButton ID="rdoUnstable" Text="Unstable" Width="100%" runat="server" 
                                                    GroupName="Condition" onclick="javascript:StableOrUnstable()" 
                                                    meta:resourcekey="rdoUnstableResource1"/>
                                            </td>
                                            <td align="left">
                                               <div id="divAdverse" runat="server" style="display:none;width:80%">
                                                  <asp:TextBox ID="txtAdverse" runat="server" 
                                                       meta:resourcekey="txtAdverseResource1"></asp:TextBox>
                                               </div>
                                            </td>
                                            <td align="center">
                                                <asp:Button ID="OKButton" runat="server" Text="Add" 
                                                    OnClientClick="javascript:AddDataToDataTable()" OnClick="OKButton_Click" 
                                                    meta:resourcekey="OKButtonResource1"/>
                                            </td>
                                            <td align="center">
                                                <asp:Button ID="CloseButton" runat="server" Text="Close" 
                                                    OnClick="OKButton_Click" meta:resourcekey="CloseButtonResource1"/>
                                            </td>
                                        </tr>
                                    </table>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </asp:Panel>
                        <table class="datatable" width="80%" style="text-align: center">
                            <tr valign="bottom">
                                <td>
                                    <asp:Button ID="btnSave" Text="Save" runat="server" CssClass="btn" 
                                        OnClick="btnSave_Click" meta:resourcekey="btnSaveResource1"/>
                                    <asp:Button ID="btnCancel" Text="Cancel" runat="server" CssClass="btn" 
                                        OnClick="btnCancel_Click" meta:resourcekey="btnCancelResource1" />
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
        </table>
        <uc5:Footer ID="Footer1" runat="server" />
    </div>
    <asp:HiddenField ID="hdnRecords" runat="server" />
    <asp:HiddenField ID ="hdnBagtype" runat ="server" />
    </form>
</body>
</html>

<script language="javascript" type="text/javascript">
   function StableOrUnstable()
   {
     if(document.getElementById('rdoStable').checked== true && document.getElementById('divAdverse').style.display=="block")
     {
       document.getElementById('divAdverse').style.display="none";
     }
     else if(document.getElementById('rdoUnstable').checked== true && document.getElementById('divAdverse').style.display=="none")
     {
       document.getElementById('divAdverse').style.display="block";
     }
     
   }
   function AddDataToDataTable()
   {
     var rows='';
     var rowcount=document.getElementById('tblCapturedData').rows.length;
     var row = document.getElementById('tblCapturedData').insertRow(rowcount);
//     row.id = e.options[e.options.selectedIndex].value;           
     var cell1 = row.insertCell(0);
     var cell2 = row.insertCell(1);
     var cell3 = row.insertCell(2);
     var cell4 = row.insertCell(3);
     var cell5 = row.insertCell(4);
     var cell6 = row.insertCell(5);
     var d = new Date();
     cell1.innerHTML=d.getDate()+"-"+d.getMonth()+"/"+d.getHours()+":"+d.getMinutes()+":"+d.getSeconds();
     cell1.width=100;
     cell2.innerHTML = document.getElementById("txtHR").value;
     cell2.width=50;
     cell2.align='center';
     cell3.innerHTML = document.getElementById("txtBP1").value+"/"+document.getElementById("txtBP2").value;
     cell3.width=60;
     cell3.align='center';
     cell4.innerHTML=document.getElementById("txtSaturation").value;
     cell4.width=100;
     cell4.align='center';
     cell5.innerHTML=document.getElementById("txtVolume").value;
     cell5.width=100;
     cell5.align='center';
     document.getElementById("txtHR").value="";
     document.getElementById("txtBP1").value="";
     document.getElementById("txtBP2").value="";
     document.getElementById("txtSaturation").value="";
     document.getElementById("txtVolume").value="";
     if(document.getElementById('rdoStable').checked==true){
       cell6.innerHTML="Stable";
       document.getElementById('rdoStable').checked=false;
     }
     else if(document.getElementById('rdoUnstable').checked==true)
     {
       cell6.innerHTML="Unstable - "+document.getElementById('txtAdverse').value;
       document.getElementById('rdoUnstable').checked=false;
       document.getElementById('txtAdverse').value="";
     }
     document.getElementById("hdnRecords").value=document.getElementById("hdnRecords").value+"^"+cell1.innerHTML+"~"+cell2.innerHTML+"~"+cell3.innerHTML+"~"+cell4.innerHTML+"~"+cell5.innerHTML+"~"+cell6.innerHTML;
     document.getElementById('tblCapturedData').style.display="block";
   }

   function checkvalidity()
   {
     var actualVolume;
     var enteredVolume;
     actualVolume=document.getElementById('ddlBagCapacity').options[document.getElementById('ddlBagCapacity').selectedIndex].value;
     enteredVolume=document.getElementById('txtUnitDrawn').value;
     if(actualVolume<enteredVolume)
     {
        alert('Unit drawn cannot exceed bag capacity');
        document.getElementById('txtUnitDrawn').focus();
     }
   }
   function CheckVolume()
   {
     var actual=document.getElementById('ddlBagCapacity').options[document.getElementById('ddlBagCapacity').selectedIndex].value;
     var entered=document.getElementById('txtVolume').value;
     if(actual<entered)
     {
        alert('Volume cannot exceed bag capacity');
        document.getElementById('txtVolume').focus();
     }
 }

 function checkDate1(obj) {

     var dt = new Date();
     var CurrentYear = dt.getFullYear();
     var CurrentMonth = dt.getMonth() + 1;
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
</script>

