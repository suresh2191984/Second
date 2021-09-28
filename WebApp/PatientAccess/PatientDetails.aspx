<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PatientDetails.aspx.cs" Inherits="PatientAccess_PatientDetails" culture="auto" meta:resourcekey="PageResource1" uiculture="auto" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/AddressControl.ascx" TagName="AddressControl"
    TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Patient Details</title>

    <script language="javascript" type="text/javascript">
        function checkMailId() {
            var emailID = document.getElementById('txtEmailID')
            if ((emailID.value == null) || (emailID.value.trim() != "")) {
                if (echeck(emailID.value) == false) {
                    emailID.value = ""
                    emailID.focus()
                    return false
                }
            }
            return true
        }
        function toggleCheck() {
            if (document.getElementById('ucCAdd_txtAddress2').value != '' && document.getElementById('ucCAdd_txtCity').value != '') {
                document.getElementById('cAdsame').checked = false;
                document.getElementById('CAD').style.display = "block";
            }
        }
        function echeck(str) {

            var at = "@"
            var dot = "."
            var lat = str.indexOf(at)
            var lstr = str.length
            var ldot = str.indexOf(dot)
            if (str.indexOf(at) == -1) {
           var userMsg = SListForApplicationMessages.Get('Patientacess\\PatientDetails.aspx_1');
               if(userMsg !=null)
               {
               alert(userMsg);
               return false;
               }
               else{
               alert('Provide a valid e-mail ID');
                return false
                }
            }

            if (str.indexOf(at) == -1 || str.indexOf(at) == 0 || str.indexOf(at) == lstr) {
              var userMsg = SListForApplicationMessages.Get('Patientacess\\PatientDetails.aspx_1');
               if(userMsg !=null)
               {
               alert(userMsg);
               return false;
               }
               else{
                alert('Provide a valid e-mail ID');
                return false
                }
            }

            if (str.indexOf(dot) == -1 || str.indexOf(dot) == 0 || str.indexOf(dot) == lstr) {
                alert('Provide a valid e-mail ID');
                return false
            }

            if (str.indexOf(at, (lat + 1)) != -1) {
              var userMsg = SListForApplicationMessages.Get('Patientacess\\PatientDetails.aspx_1');
               if(userMsg !=null)
               {
               alert(userMsg);
               return false;
               }
               else{
                alert('Provide a valid e-mail ID');
                return false
                }
            }

            if (str.substring(lat - 1, lat) == dot || str.substring(lat + 1, lat + 2) == dot) {
              var userMsg = SListForApplicationMessages.Get('Patientacess\\PatientDetails.aspx_1');
               if(userMsg !=null)
               {
               alert(userMsg);
               return false;
               }
               else{
                alert('Provide a valid e-mail ID');
                return false
                }
            }

            if (str.indexOf(dot, (lat + 2)) == -1) {
              var userMsg = SListForApplicationMessages.Get('Patientacess\\PatientDetails.aspx_1');
               if(userMsg !=null)
               {
               alert(userMsg);
               return false;
               }
               else{
                alert('Provide a valid e-mail ID');
                return false
                }
            }

            if (str.indexOf(" ") != -1) {
              var userMsg = SListForApplicationMessages.Get('Patientacess\\PatientDetails.aspx_1');
               if(userMsg !=null)
               {
               alert(userMsg);
               return false;
               }
               else{
                alert('Provide a valid e-mail ID');
                return false
                }
            }

            return true
        }
        function Checkvalidation() {
            if (document.getElementById('ddMarital').value == 'Select') {
              var userMsg = SListForApplicationMessages.Get('Patientacess\\PatientDetails.aspx_2');
               if(userMsg !=null)
               {
               alert(userMsg);
               return false;
               }
               else{
                alert('Provide the marital status');
                return false ;
                }
                document.getElementById('ddMarital').focus();
                return false;
            }
            if (document.getElementById('ddSex').value == 'Select') {
             var userMsg = SListForApplicationMessages.Get('Patientacess\\PatientDetails.aspx_3');
               if(userMsg !=null)
               {
               alert(userMsg);
               return false;
               }
               else{
                alert('Provide the sex');
                return false ;
                }
                document.getElementById('ddSex').focus();
                return false;
            }
            if (document.getElementById('ucPAdd_txtAddress2').value == '') {
             var userMsg = SListForApplicationMessages.Get('Patientacess\\PatientDetails.aspx_4');
               if(userMsg !=null)
               {
               alert(userMsg);
               return false;
               }
               else{
                alert('Provide the street/road name in permanent address');
                return false ;
                }
                document.getElementById('ucPAdd_txtAddress2').focus();
                return false;
            }
            if (document.getElementById('ucPAdd_txtCity').value == '') {
              var userMsg = SListForApplicationMessages.Get('Patientacess\\PatientDetails.aspx_5');
               if(userMsg !=null)
               {
               alert(userMsg);
               return false;
               }
               else{
                alert('Provide the city in permanent address');
                return false ;
                }
                document.getElementById('ucPAdd_txtCity').focus();
                return false;
            }
            if ((document.getElementById('ucPAdd_txtMobile').value == '') && (document.getElementById('ucPAdd_txtLandLine').value == '')) {
              var userMsg = SListForApplicationMessages.Get('Patientacess\\PatientDetails.aspx_6');
               if(userMsg !=null)
               {
               alert(userMsg);
               return false;
               }
               else{
                alert('Provide at least one contact number');
                return false ;
                }
                document.getElementById('ucPAdd_txtMobile').focus();
                return false;
            }
            if (document.getElementById('CAD').style.display == 'block') {
                if (document.getElementById('ucCAdd_txtAddress2').value == '') {
                 var userMsg = SListForApplicationMessages.Get('Patientacess\\PatientDetails.aspx_7');
               if(userMsg !=null)
               {
               alert(userMsg);
               return false;
               }
               else{
                alert('Provide the street/road name in current address');
                return false ;
                }
                    document.getElementById('ucCAdd_txtAddress2').focus();
                    return false;
                }
                if (document.getElementById('ucCAdd_txtCity').value == '') {
                var userMsg = SListForApplicationMessages.Get('Patientacess\\PatientDetails.aspx_8');
               if(userMsg !=null)
               {
               alert(userMsg);
               return false;
               }
               else{
                alert('Provide the city in current address');
                return false ;
                }
                    document.getElementById('ucCAdd_txtCity').focus();
                    return false;
                }
            }
            return true;
        }
        function onEdit(obj) {
            if (obj == 'divpatientView') {
                document.getElementById('divpatientEdit').style.display = 'block';
                document.getElementById('divpatientView').style.display = 'none';
            }
            if (obj == 'divAddressView') {
                document.getElementById('divAddressEdit').style.display = 'block';
                document.getElementById('divAddressView').style.display = 'none';
            }
        }

        function onView(obj) {
            if (obj == 'divpatientEdit') {
                document.getElementById('divpatientEdit').style.display = 'none';
                document.getElementById('divpatientView').style.display = 'block';
            }
            if (obj == 'divAddressEdit') {
                document.getElementById('divAddressEdit').style.display = 'none';
                document.getElementById('divAddressView').style.display = 'block';
            }
            return false;
        }
        
    </script>

</head>
<body onload="toggleCheck();" oncontextmenu="return false;">
    <form id="frmPatientVitals" runat="server">
    <asp:ScriptManager ID="ctlTaskScriptMgr" runat="server">
    </asp:ScriptManager>
      <Attune:Attuneheader ID="Attuneheader" runat="server" />
                    <div class="contentdata">
                        <table class="w-100p searchPanel">
                            <tr>
                                <td class="h-32">
                                    <asp:Panel ID="pnPatientDetails" runat="server" GroupingText="Patient Details" 
                                        meta:resourcekey="pnPatientDetailsResource1">
                                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                            <ContentTemplate>
                                                <div id="divpatientEdit" style="display: none;" runat="server">
                                                    <table class="w-100p">
                                                        <tr>
                                                            <td class="a-right w-15">
                                                          <asp:Label ID="lbmartalstat" runat="server" Text="Marital Status" 
                                                                    meta:resourcekey="lbmartalstatResource1"></asp:Label>
                                                            </td>
                                                            <td class="w-26p">
                                                                <asp:DropDownList ID="ddMarital" runat="server" TabIndex="1" Width="90px" 
                                                                    meta:resourcekey="ddMaritalResource1">
                                                                    <asp:ListItem Value="S" meta:resourcekey="ListItemResource1">Single</asp:ListItem>
                                                                    <asp:ListItem Selected="True" Value="M" meta:resourcekey="ListItemResource2">Married</asp:ListItem>
                                                                    <asp:ListItem Value="D" meta:resourcekey="ListItemResource3">Divorced</asp:ListItem>
                                                                    <asp:ListItem Value="D" meta:resourcekey="ListItemResource4">Widow</asp:ListItem>
                                                                </asp:DropDownList>
                                                                &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                            </td>
                                                            <td class="a-right w-15p">
                                                 <asp:Label ID="lbsex" runat="server" Text="Sex" meta:resourcekey="lbsexResource1"></asp:Label>
                                                            </td>
                                                            <td class="w-25p">
                                                                <asp:DropDownList ID="ddSex" runat="server" TabIndex="2" 
                                                                    meta:resourcekey="ddSexResource1">
                                                                    <asp:ListItem Value="M" meta:resourcekey="ListItemResource5">Male</asp:ListItem>
                                                                    <asp:ListItem Value="F" meta:resourcekey="ListItemResource6">Female</asp:ListItem>
                                                                </asp:DropDownList>
                                                                &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="a-right w-15p">
                                                            <asp:Label ID="lbspousefathernme" runat="server" Text="Spouse/Father Name" 
                                                                    meta:resourcekey="lbspousefathernmeResource1"></asp:Label>
                                                            </td>
                                                            <td class="w-26p">
                                                                <asp:TextBox ID="txtRelation" runat="server" MaxLength="50" TabIndex="3" 
                                                                    meta:resourcekey="txtRelationResource1"></asp:TextBox>
                                                            </td>
                                                            <td class="a-right w-15p">
                                                                <asp:Label ID="lbpob1" runat="server" Text="Place Of Birth" 
                                                                    meta:resourcekey="lbpob1Resource1"></asp:Label>
                                                            </td>
                                                            <td class="w-25p">
                                                                <asp:TextBox ID="txtPlaceOfBirth" runat="server" MaxLength="30" TabIndex="4" 
                                                                    meta:resourcekey="txtPlaceOfBirthResource1"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="a-right">
                                                       <asp:Label ID="lboccup" runat="server" Text="Occupation" 
                                                                    meta:resourcekey="lboccupResource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtOccupation" runat="server" MaxLength="20" TabIndex="5" 
                                                                    meta:resourcekey="txtOccupationResource1"></asp:TextBox>
                                                            </td>
                                                            <td class="a-right">
                                                          <asp:Label ID="lbbldgrp" runat="server" Text="Blood Group" 
                                                                    meta:resourcekey="lbbldgrpResource1"></asp:Label>
                                                            </td>
                                                            <td class="w-25p">
                                                                <asp:DropDownList ID="ddBloodGrp" runat="server" TabIndex="6" Width="90px" 
                                                                    meta:resourcekey="ddBloodGrpResource1">
                                                                    <asp:ListItem Value="-1" meta:resourcekey="ListItemResource7">Select</asp:ListItem>
                                                                    <asp:ListItem meta:resourcekey="ListItemResource8">O+</asp:ListItem>
                                                                    <asp:ListItem meta:resourcekey="ListItemResource9">A+</asp:ListItem>
                                                                    <asp:ListItem meta:resourcekey="ListItemResource10">B+</asp:ListItem>
                                                                    <asp:ListItem meta:resourcekey="ListItemResource11">O-</asp:ListItem>
                                                                    <asp:ListItem meta:resourcekey="ListItemResource12">A-</asp:ListItem>
                                                                    <asp:ListItem meta:resourcekey="ListItemResource13">B-</asp:ListItem>
                                                                    <asp:ListItem meta:resourcekey="ListItemResource14">A1+</asp:ListItem>
                                                                    <asp:ListItem meta:resourcekey="ListItemResource15">A1-</asp:ListItem>
                                                                    <asp:ListItem meta:resourcekey="ListItemResource16">AB+</asp:ListItem>
                                                                    <asp:ListItem meta:resourcekey="ListItemResource17">AB-</asp:ListItem>
                                                                    <asp:ListItem meta:resourcekey="ListItemResource18">A1B+</asp:ListItem>
                                                                    <asp:ListItem meta:resourcekey="ListItemResource19">A1B-</asp:ListItem>
                                                                    <asp:ListItem meta:resourcekey="ListItemResource20">A2+</asp:ListItem>
                                                                    <asp:ListItem meta:resourcekey="ListItemResource21">A2-</asp:ListItem>
                                                                    <asp:ListItem meta:resourcekey="ListItemResource22">A2B+</asp:ListItem>
                                                                    <asp:ListItem meta:resourcekey="ListItemResource23">A2B-</asp:ListItem>
                                                                </asp:DropDownList>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="a-right w-15p">
                                                        <asp:Label ID="lbreg" runat="server" Text="Religion" meta:resourcekey="lbregResource1"></asp:Label>
                                                            </td>
                                                            <td class="w-26p">
                                                                <asp:TextBox ID="txtReligion" runat="server" MaxLength="25" TabIndex="7" 
                                                                    meta:resourcekey="txtReligionResource1"></asp:TextBox>
                                                            </td>
                                                            <td class="a-right w-15p">
                                                                <asp:Label ID="lbemail" runat="server" Text="EMail" 
                                                                    meta:resourcekey="lbemailResource1"></asp:Label>
                                                            </td>
                                                            <td class="w-25p">
                                                                <asp:TextBox ID="txtEmail" onblur="javascript:checkMailId();" runat="server" MaxLength="100"
                                                                    onbeforepaste="BeforePaste_Event()" onPaste="Paste_Event()" TabIndex="8" 
                                                                    meta:resourcekey="txtEmailResource1"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="a-right w-15p">
                                                            <asp:Label ID="lbidenmark1" runat="server" Text="Identification Marks 1" 
                                                                    meta:resourcekey="lbidenmark1Resource1"></asp:Label>
                                                            </td>
                                                            <td class="w-26p">
                                                                <asp:TextBox ID="txtIdentification1" runat="server" TabIndex="9" TextMode="MultiLine"
                                                                    Rows="2" Columns="20" MaxLength="128" 
                                                                    meta:resourcekey="txtIdentification1Resource1"></asp:TextBox>
                                                            </td>
                                                            <td class="a-right w-15p">
                                                                    <asp:Label ID="lbidenmark2" runat="server" Text="Identification Marks 2" 
                                                                        meta:resourcekey="lbidenmark2Resource1"></asp:Label>
                                                            </td>
                                                            <td class="w-25p">
                                                                <asp:TextBox ID="txtIdentification2" runat="server" TabIndex="10" TextMode="MultiLine"
                                                                    Rows="2" Columns="20" MaxLength="127" 
                                                                    meta:resourcekey="txtIdentification2Resource1"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="a-right w-15p">
                                                      <asp:Label ID="lburn" runat="server" Text="URN" meta:resourcekey="lburnResource1"></asp:Label>
                                                            </td>
                                                            <td class="w-26p">
                                                                <asp:TextBox ID="txtURNo" runat="server" MaxLength="50" TabIndex="17" 
                                                                    meta:resourcekey="txtURNoResource1"></asp:TextBox>
                                                            </td>
                                                            <td class="a-right w-15p">
                                                                  <asp:Label ID="lnurnof" runat="server" Text="URN Of" 
                                                                      meta:resourcekey="lnurnofResource1"></asp:Label>
                                                            </td>
                                                            <td class="w-25p">
                                                                <asp:DropDownList ID="ddlUrnoOf" runat="server" TabIndex="18" 
                                                                    meta:resourcekey="ddlUrnoOfResource1">
                                                                </asp:DropDownList>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="a-right w-15p">
                                                         <asp:Label ID="lburntype" runat="server" Text="URN Type" 
                                                                    meta:resourcekey="lburntypeResource1"></asp:Label>
                                                            </td>
                                                            <td class="w-26p">
                                                                <asp:DropDownList ID="ddlUrnType" runat="server" TabIndex="19" 
                                                                    meta:resourcekey="ddlUrnTypeResource1">
                                                                </asp:DropDownList>
                                                            </td>
                                                            <td class="a-right w-15p">
                                                            </td>
                                                            <td class="w-25p">
                                                            </td>
                                                        </tr>
                                                        <tr class="h-15">
                                                            <td colspan="4" class="a-center">
                                                                <asp:Button ID="btnUpdate" runat="server" OnClientClick="return Checkvalidation();"
                                                                    OnClick="btnFinish_Click" Text="Update" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                                    onmouseout="this.className='btn'" Width="54px" 
                                                                    meta:resourcekey="btnUpdateResource1" />
                                                                <asp:Button ID="btnCancel" runat="server" OnClientClick="return onView('divpatientEdit');"
                                                                    Text="Cancel" CssClass="btn" onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'"
                                                                    Width="54px" meta:resourcekey="btnCancelResource1" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                                <div id="divpatientView" style="display: block;" runat="server">
                                                    <table class="w-100p">
                                                        <tr>
                                                            <td class="a-right w-15p">
                                                          <asp:Label ID="lbmarstat1" runat="server" Text="Marital Status :" 
                                                                    meta:resourcekey="lbmarstat1Resource1"></asp:Label>
                                                            </td>
                                                            <td class="w-26p">
                                                                <asp:Label ID="lblMaritalStatus" runat="server" 
                                                                    meta:resourcekey="lblMaritalStatusResource1"></asp:Label>
                                                            </td>
                                                            <td class="a-right w-15p">
                                                  <asp:Label ID="lbsex1" runat="server" Text="Sex :" meta:resourcekey="lbsex1Resource1"></asp:Label>
                                                            </td>
                                                            <td class="w-25p">
                                                                <asp:Label ID="lblSex" runat="server" meta:resourcekey="lblSexResource1"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="a-right w-15p">
                                                          <asp:Label ID="lbspousefat" runat="server" Text="Spouse/Father Name :" 
                                                                    meta:resourcekey="lbspousefatResource1"></asp:Label>
                                                            </td>
                                                            <td class="w-26p">
                                                                <asp:Label ID="lblFather" runat="server" meta:resourcekey="lblFatherResource1"></asp:Label>
                                                            </td>
                                                            <td class="a-right w-15p">
                                                    <asp:Label ID="lbpob" runat="server" Text="Place Of Birth :" 
                                                                    meta:resourcekey="lbpobResource1"></asp:Label>
                                                            </td>
                                                            <td class="w-25p">
                                                                <asp:Label ID="lblPlaceOfBirth" runat="server" 
                                                                    meta:resourcekey="lblPlaceOfBirthResource1"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="a-right">
                                               <asp:Label ID="lboccup1" runat="server" Text="Occupation :" meta:resourcekey="lboccup1Resource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblOccupation" runat="server" 
                                                                    meta:resourcekey="lblOccupationResource1"></asp:Label>
                                                            </td>
                                                            <td class="a-right">
                                                          <asp:Label ID="lbbloodgrp1" runat="server" Text="Blood Group :" 
                                                                    meta:resourcekey="lbbloodgrp1Resource1"></asp:Label>
                                                            </td>
                                                            <td class="w-25p">
                                                                <asp:Label ID="lblBloodGroup" runat="server" 
                                                                    meta:resourcekey="lblBloodGroupResource1"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="a-right w-15p">
                                                                       <asp:Label ID="lbreg1" runat="server" Text="Religion :" 
                                                                           meta:resourcekey="lbreg1Resource1"></asp:Label>
                                                            </td>
                                                            <td class="w-26p">
                                                                <asp:Label ID="lblReligion" runat="server" 
                                                                    meta:resourcekey="lblReligionResource1"></asp:Label>
                                                            </td>
                                                            <td class="a-right w-15p">
                                                               <asp:Label ID="lbemail1" runat="server" Text="EMail :" 
                                                                    meta:resourcekey="lbemail1Resource1"></asp:Label>
                                                            </td>
                                                            <td class="w-26p">
                                                                <asp:Label ID="lblEMail" runat="server" meta:resourcekey="lblEMailResource1"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td sclass="a-right w-15p">
                                               <asp:Label ID="lblidenmark1" runat="server" Text="Identification Marks 1 :" 
                                                                    meta:resourcekey="lblidenmark1Resource1"></asp:Label>
                                                            </td>
                                                            <td class="w-26p">
                                                                <asp:Label ID="lblIdMarks1" runat="server" 
                                                                    meta:resourcekey="lblIdMarks1Resource1"></asp:Label>
                                                            </td>
                                                            <td class="a-right w-15p">
                                                <asp:Label ID="lbidenmark" runat="server" Text="Identification Marks 2 :" 
                                                                    meta:resourcekey="lbidenmarkResource1"></asp:Label>
                                                            </td>
                                                            <td class="w-25p">
                                                                <asp:Label ID="lblIdMarks2" runat="server" 
                                                                    meta:resourcekey="lblIdMarks2Resource1"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="a-right w-15p">
                                                      <asp:Label ID="lburn1" runat="server" Text="URN :" meta:resourcekey="lburn1Resource1"></asp:Label>
                                                            </td>
                                                            <td class="w-26p">
                                                                <asp:Label ID="lblUrNo" runat="server" meta:resourcekey="lblUrNoResource1"></asp:Label>
                                                            </td>
                                                            <td class="a-right w-15p">
                                                       <asp:Label ID="lburnof" runat="server" Text="URN Of" meta:resourcekey="lburnofResource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblURNof" runat="server" meta:resourcekey="lblURNofResource1"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="a-right">
                                                          <asp:Label ID="lburntype1" runat="server" Text="URN Type:" 
                                                                    meta:resourcekey="lburntype1Resource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblURNType" runat="server" 
                                                                    meta:resourcekey="lblURNTypeResource1"></asp:Label>
                                                            </td>
                                                            <td class="a-right">
                                                            </td>
                                                            </td>
                                                        </tr>
                                                        <tr class="h-15">
                                                            <td colspan="4" class="a-right">
                                                                <input name='button' onclick="onEdit('divpatientView')" value='Edit' type='button'
                                                                    style='background-color: Transparent; color: Blue; border-style: none; text-decoration: underline;
                                                                    cursor: pointer' />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </asp:Panel>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Panel ID="pnAddress" runat="server" GroupingText="Address Details" 
                                        meta:resourcekey="pnAddressResource1">
                                        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                            <ContentTemplate>
                                                <div id="divAddressEdit" style="display: none;" runat="server">
                                                    <table>
                                                        <tr>
                                                            <td>
                                                                <uc2:AddressControl ID="ucPAdd" runat="server" StartIndex="18" AddressType="PERMANENT"
                                                                    Title="Permanent Address" />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:CheckBox ID="cAdsame" runat="server" Checked="True" CssClass="defaultfontcolor"
                                                                    Text="Check this if current address is same as above" 
                                                                    meta:resourcekey="cAdsameResource1" />
                                                                <div id="CAD" style="display: none; text-align: left;">
                                                                    <uc2:AddressControl ID="ucCAdd" runat="server" StartIndex="26" AddressType="CURRENT"
                                                                        Title="Current Address" />
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr class="h-15">
                                                            <td colspan="4" class="a-center">
                                                                <asp:Button ID="btnAddress" runat="server" OnClientClick="return Checkvalidation();"
                                                                    OnClick="btnFinish_Click" Text="Update" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                                    onmouseout="this.className='btn'" Width="54px" 
                                                                    meta:resourcekey="btnAddressResource1" />
                                                                <asp:Button ID="btnAddCan" runat="server" OnClientClick="return onView('divAddressEdit');"
                                                                    Text="Cancel" CssClass="btn" onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'"
                                                                    Width="54px" meta:resourcekey="btnAddCanResource1" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                                <div id="divAddressView" style="display: block;" runat="server">
                                                    <table class="w-100p">
                                                        <tr>
                                                            <td>
                                                            <asp:Label ID="lbpermntadd" runat="server" Text="Permanent Address"  Font-Bold ="true" 
                                                                    meta:resourcekey="lbpermntaddResource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lbcurrntadd" runat="server" Text="Current Address"  Font-Bold ="true" 
                                                                    meta:resourcekey="lbcurrntaddResource1"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="v-top paddingL10">
                                                                <asp:Label ID="lblAddress1" runat="server" 
                                                                    meta:resourcekey="lblAddress1Resource1"></asp:Label>
                                                            </td>
                                                            <td class="v-top paddingL10">
                                                                <asp:Label ID="lblAddress2" runat="server" 
                                                                    meta:resourcekey="lblAddress2Resource1"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr class="h-15">
                                                            <td colspan="4" class="a-right">
                                                                <input name='button' onclick="onEdit('divAddressView')" value='Edit' type='button'
                                                                    style='background-color: Transparent; color: Blue; border-style: none; text-decoration: underline;
                                                                    cursor: pointer' />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </asp:Panel>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                </td>
                            </tr>
                            <tr>
                                <td class="h-15">
                                </td>
                            </tr>
                        </table>
                    </div>
       <Attune:Attunefooter ID="Attunefooter" runat="server" />         
    <asp:HiddenField ID="hdnMessages" runat="server" />
    </form>
</body>
</html>
