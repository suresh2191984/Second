<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SaveLabRefOrgDetails.aspx.cs"
    Inherits="Reception_SaveLabRefOrgDetails" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%--<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>--%>
<%@ Register Src="../CommonControls/AddressControl.ascx" TagName="AddressControl"
    TagPrefix="uc8" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<%--<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>--%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Manage Reference Organization Details</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
    <%--    <script src="../Scripts/Common.js" type="text/javascript"></script>--%>

    <script src="../Scripts/MessageHandler.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">
        function validateLabRefOrgDetails() {
            var objAlert = SListForAppMsg.Get("Reception_SaveLabRefOrgDetails_aspx_05") == null ? "Alert" : SListForAppMsg.Get("Reception_SaveLabRefOrgDetails_aspx_05");
            var objApp01 = SListForAppMsg.Get("Reception_SaveLabRefOrgDetails_aspx_01") == null ? "Please Enter The Hospital/Clinic/Lab Name" : SListForAppMsg.Get("Reception_SaveLabRefOrgDetails_aspx_01");
            var objApp02 = SListForAppMsg.Get("Reception_SaveLabRefOrgDetails_aspx_02") == null ? "Please Enter The Code" : SListForAppMsg.Get("Reception_SaveLabRefOrgDetails_aspx_02");
             var objApp03= SListForAppMsg.Get("Reception_SaveLabRefOrgDetails_aspx_03") == null ? "Please select the type" : SListForAppMsg.Get("Reception_SaveLabRefOrgDetails_aspx_03");
            var objApp04= SListForAppMsg.Get("Reception_SaveLabRefOrgDetails_aspx_04") == null ? "Code already exists.Please give any other code" : SListForAppMsg.Get("Reception_SaveLabRefOrgDetails_aspx_04");
            if (document.getElementById('txtName').value == '') {
                var userMsg = SListForApplicationMessages.Get('Reception\\SaveLabRefOrgDetails.aspx_1');
                if (userMsg != null) {
                    ValidationWindow(userMsg, objAlert);

                    //alert(userMsg);
                    return false;
                }
                else {
                    ValidationWindow(objApp01, objAlert);

               // alert('Please Enter The Hospital/Clinic/Lab Name');
                }
                document.getElementById('txtName').focus();
                return false;
            }
            if (document.getElementById('txtHosCode').value == '') {
                var userMsg = SListForApplicationMessages.Get('Reception\\SaveLabRefOrgDetails.aspx_2');
                if (userMsg != null) {
                     ValidationWindow(userMsg, objAlert);
                    //alert(userMsg);
                    return false;
                }
                else { 
                ValidationWindow(objApp02, objAlert);
               // alert('Please Enter The Code'); 
               }
                document.getElementById('txtHosCode').focus();
                return false;
            }
            var dropvalue = document.getElementById('drplstReferringType').options[document.getElementById('drplstReferringType').selectedIndex].value;
            if (dropvalue == '0') {
                var userMsg = SListForApplicationMessages.Get('Reception\\SaveLabRefOrgDetails.aspx_3');
                if (userMsg != null) {
                 ValidationWindow(userMsg, objAlert);
                    //alert(userMsg);
                    return false;
                }
                else { 
                ValidationWindow(objApp03, objAlert);
                //alert('Please select the type');
                 }
                document.getElementById('drplstReferringType').focus();
                return false;
            }
            if (document.getElementById('hdnCheckCode').value == '1') { 
            ValidationWindow(objApp04, objAlert);
                //alert('Code already exists.Please give any other code');
                document.getElementById('txtHosCode').focus();                
                return false;
            }         
        }        

        function SetReferringTypeID() {
            var dropvalue = document.getElementById('drplstReferringType').options[document.getElementById('drplstReferringType').selectedIndex].value;
            document.getElementById('hdnRefOrgType').value = dropvalue;
        }

        function ValidateCode() {
            if (document.getElementById('txtHosCode').disabled == false) {
                var codeType = 'HOS';
                var txtValue = document.getElementById('txtHosCode').value;
                WebService.GetCheckCode(codeType, txtValue, onCheckCount);
            }
        }

        function onCheckCount(Count) {
            document.getElementById('hdnCheckCode').value = Count;
        }
        function onUpdatehide() {
            document.getElementById('btnDelete').style.display = 'none';
            document.getElementById('btnCancel').style.display = 'none';
        }
        function ConfirmCancel() {
            var InformationMsg = SListForAppMsg.Get("InventoryKit_Information") != null ? SListForAppMsg.Get("InventoryKit_Information") : "Information";
            var OkMsg = SListForAppMsg.Get("InventoryKit_Ok") != null ? SListForAppMsg.Get("InventoryKit_Ok") : "Ok";
            var CancelMsg = SListForAppMsg.Get("InventoryKit_Cancel") != null ? SListForAppMsg.Get("InventoryKit_Cancel") : "Cancel";
            var userMsg = SListForAppMsg.Get("Reception_SaveLabRefOrgDetails_aspx_08") == null ? "Are you sure to proceed?" : SListForAppMsg.Get("Reception_SaveLabRefOrgDetails_aspx_08");
            var con = ConfirmWindow(userMsg, InformationMsg, OkMsg, CancelMsg)
            if (con == true) {
                return true;
            }
            else {
                return false;
            }
        }
        function SetContextKey() {
            var deptName = document.getElementById('drplstPerson').options[document.getElementById('drplstPerson').selectedIndex].text;
            var deptCode = document.getElementById('drplstPerson').options[document.getElementById('drplstPerson').selectedIndex].value;
            var depart = document.getElementById('hdnAddDepart').value.split('^');
            var flag = 0;
            for (var i = 0; i < depart.length; i++) {
                if (depart[i] != "") {
                    if (deptCode == depart[i].split('~')[1]) {
                        flag = 1;
                        break;
                    }
                }
            }
            if (flag == 1) {
                document.getElementById('hdnEmpID').value = "-1";
                document.getElementById('tdtxtClnt').style.display = "table-cell";
                document.getElementById('tdtxtPrsn').style.display = "none";
            }
            else {

                $find('AutoCompleteExtender3').set_contextKey(deptCode);
            }
            return;
        }

        function GetEmpID(source, eventArgs) {
            var strVal = eventArgs.get_value();
            document.getElementById('txtPersonName').value = eventArgs.get_text();
            document.getElementById('hdnEmpID').value = strVal.split('~')[0].trim();
            document.getElementById('txtPrsnMobile').value = strVal.split('~')[1].trim();
            document.getElementById('txtPrsnLandNo').value = strVal.split('~')[2].trim();
            document.getElementById('txtPrsnEmail').value = strVal.split('~')[3].trim();
        }
    </script>

</head>
<body oncontextmenu="return false;">
    <form id="prFrm" runat="server" defaultbutton="btnFinish">
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="True">
        <Services>
            <asp:ServiceReference Path="~/WebService.asmx" />
        </Services>
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
            <ContentTemplate>
                <table class="w-100p searchPanel">
                    <tr>
                        <td class="h-32">
                            <table id="mytable1" class="w-100p" style=" margin-left: 30px;">
                                <tr>
                                    <td colspan="5" id="us">
                                        <asp:Literal runat="server" ID="ltHead" Text="Select a Clinic/Hospital to edit the details or click on Add New 
                                               Clinic." meta:resourcekey="ltHeadResource1"></asp:Literal>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td class="a-center">
                            <asp:Panel ID="Panel7" BorderStyle="Inset" CssClass="dataheader2 w-100p" runat="server" meta:resourcekey="Panel7Resource1">
                                <table class="w-100p">
                                    <tr>
                                        <td class="padding3">
                                            <table class="w-100p" style=" margin-left: 20px;">
                                                <tr>
                                                    <td class="a-left" style="width: 125px;">
                                                        <input id="rdoHospitals" type="radio" style="display: none;" name="clientType" checked
                                                            value="1" runat="server" />
                                                        <%=Resources.Reception_ClientDisplay.Reception_SaveLabRefOrgDetails_aspx_06%>
                                                    </td>
                                                    <td class="a-left">
                                                        <div id="CTHospital" runat="server">
                                                            <asp:DropDownList ID="ddlHospital" CssClass="ddlsmall" ToolTip="Select Refering Hospital"
                                                                runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlHospital_SelectedIndexChanged"
                                                                meta:resourcekey="ddlHospitalResource1">
                                                            </asp:DropDownList>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <asp:LinkButton ID="addNewHospital" ToolTip="Click here to Add New Refering Clinic"
                                                            Visible="False" ForeColor="#000333" runat="server" OnClick="addNewHospital_Click"
                                                            meta:resourcekey="addNewHospitalResource1"><u> <%# Resources.Reception_ClientDisplay.Reception_SaveLabRefPhysicianDetails_aspx_05%>   <%--Add New Refering Clinic--%></u></asp:LinkButton>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </td>
                    </tr>
                    <tr>
                        <td style="display: none;">
                            <asp:Label ID="lblStatus" Visible="False" runat="server" ForeColor="#000333" meta:resourcekey="lblStatusResource1"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="a-center">
                            <div id="trAddress" runat="server">
                                <asp:Panel ID="Panel4" CssClass="dataheader2 w-100p" BorderStyle="Inset"  runat="server" meta:resourcekey="Panel4Resource1">
                                    <table   class="w-100p"  style="margin-left: 20px;"  >
                                     <tr>
                                        <td colspan="6" style="height:5px"></td>
                                        </tr>
                                        <tr>
                                            <td class="a-left" style="width: 125px;">
                                                <asp:Label ID="Label1" Text="Hospital/Clinic/Lab" runat="server" meta:resourcekey="Label1Resource1"></asp:Label>
                                            </td>
                                            <td class="a-left" style="width: 220px;">
                                                <asp:TextBox ID="txtName" onblur="ConverttoUpperCase(this.id);" ToolTip="Refering Hospital Name"
                                                    runat="server" MaxLength="60" TabIndex="1" CssClass="small" meta:resourcekey="txtNameResource1"></asp:TextBox>
                                                &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                            </td>
                                            <td class="a-left" style="width: 125px;">
                                                <asp:Label ID="lblHospitalCode" Text="Code" runat="server" meta:resourcekey="lblHospitalCodeResource1"></asp:Label>
                                            </td>
                                            <td class="a-left" style="width: 220px;">
                                                <asp:TextBox ID="txtHosCode" runat="server" CssClass="small" TabIndex="2" onKeyUp="ValidateCode();"
                                                    meta:resourcekey="txtHosCodeResource1"></asp:TextBox>
                                                &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                <asp:HiddenField ID="hdnCheckCode" runat="server" />
                                            </td>
                                            <td>
                                            </td>
                                            <td align="left">
                                                <asp:Label ID="Label12" Text="Type" runat="server" meta:resourcekey="Label12Resource1"></asp:Label>
                                            </td>
                                            <td align="left">
                                                <asp:DropDownList ID="drplstReferringType" onChange="SetReferringTypeID" runat="server"
                                                    TabIndex="3" RepeatDirection="Horizontal" CssClass="ddlsmall" meta:resourcekey="drplstReferringTypeResource1">
                                                </asp:DropDownList>
                                                &nbsp;<img src="../Images/starbutton.png" alt="" class="v-middle" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="display: none;" class="a-left">
                                                <asp:TextBox runat="server" Visible="False" ID="txtAddressID" CssClass="small"
                                                    meta:resourcekey="txtAddressIDResource1"></asp:TextBox>
                                            </td>
                                            <td style="width: 125px;" class="a-left">
                                                <asp:Label ID="Label2" Text="Address 1" runat="server" meta:resourcekey="Label2Resource1"></asp:Label>
                                            </td>
                                            <td style="width: 220px;" class="a-left">
                                                <asp:TextBox ID="txtAddress1" runat="server" onBlur="return ConverttoUpperCase(this.id);"
                                                    MaxLength="60" TabIndex="4" CssClass="small" meta:resourcekey="txtAddress1Resource1"></asp:TextBox>
                                            </td>
                                            <td style="width: 125px;" class="a-left">
                                                <asp:Label ID="Label3" Text="Address 2" runat="server" meta:resourcekey="Label3Resource1"></asp:Label>
                                            </td>
                                            <td style="width: 220px;" colspan="2" align="left">
                                                <asp:TextBox ID="txtAddress2" runat="server" onBlur="return ConverttoUpperCase(this.id);"
                                                    MaxLength="60" TabIndex="5" CssClass="small" meta:resourcekey="txtAddress2Resource1"></asp:TextBox>
                                            </td>
                                            <td class="a-left">
                                                <asp:Label ID="lblRefType" Text="Referring Type" runat="server" meta:resourcekey="lblRefTypeResource1"></asp:Label>
                                            </td>
                                            <td class="a-left">
                                                <asp:DropDownList ID="ddlRefType" runat="server" TabIndex="6" CssClass="ddlsmall" meta:resourcekey="ddlRefTypeResource1">
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 125px;" class="a-left">
                                                <asp:Label ID="Label4" Text="Address 3" runat="server" meta:resourcekey="Label4Resource1"></asp:Label>
                                            </td>
                                            <td style="width: 220px;" class="a-left">
                                                <asp:TextBox ID="txtAddress3" runat="server" CssClass="small" onBlur="return ConverttoUpperCase(this.id);"
                                                    MaxLength="60" TabIndex="7" meta:resourcekey="txtAddress3Resource1"></asp:TextBox>
                                            </td>
                                            <td style="width: 125px;" class="a-left">
                                                <asp:Label ID="Label5" Text="City" runat="server" meta:resourcekey="Label5Resource1"></asp:Label>
                                            </td>
                                            <td style="width: 220px;" colspan="2" class="a-left">
                                                <asp:TextBox ID="txtCity" runat="server" onBlur="return ConverttoUpperCase(this.id);"
                                                    MaxLength="25" TabIndex="8" CssClass="small" meta:resourcekey="txtCityResource1"></asp:TextBox>
                                            </td>
                                             <td class="a-left" style="width: 100px;" >
                                                <asp:Label ID="Label13" Text="Folder Path" runat="server" meta:resourcekey="lblFolderPath"></asp:Label>
                                            </td>
                                            <td class="a-left"  class="a-left">
                                                <asp:TextBox ID="PathName" Width="350px" runat="server" ></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 125px;" class="a-left">
                                                <asp:Label ID="Label7" Text="Country" runat="server" meta:resourcekey="Label7Resource1"></asp:Label>
                                            </td>
                                            <td style="width: 220px;" align="left">
                                                <asp:DropDownList ID="ddCountry" runat="server" TabIndex="9" AutoPostBack="True"
                                                    CssClass="ddlsmall" OnSelectedIndexChanged="ddCountry_SelectedIndexChanged" meta:resourcekey="ddCountryResource1">
                                                </asp:DropDownList>
                                            </td>
                                            <td style="width: 125px;" class="a-left">
                                                <asp:Label ID="Label6" Text="State" runat="server" meta:resourcekey="Label6Resource1"></asp:Label>
                                            </td>
                                            <td style="width: 220px;" colspan="2" class="a-left">
                                                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                                    <ContentTemplate>
                                                        <asp:DropDownList ID="ddState" runat="server" TabIndex="10" CssClass="ddlsmall" meta:resourcekey="ddStateResource1">
                                                        </asp:DropDownList>
                                                    </ContentTemplate>
                                                    <Triggers>
                                                        <asp:AsyncPostBackTrigger ControlID="ddCountry" EventName="SelectedIndexChanged" />
                                                    </Triggers>
                                                </asp:UpdatePanel>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 125px;" class="a-left">
                                                <asp:Label ID="Label8" Text="PostalCode" runat="server" meta:resourcekey="Label8Resource1"></asp:Label>
                                            </td>
                                            <td style="width: 220px;" class="a-left">
                                                <asp:TextBox ID="txtPostalCode" TabIndex="11" runat="server"    onkeypress="return ValidateOnlyNumeric(this);"  
                                                     CssClass="small" MaxLength="6" meta:resourcekey="txtPostalCodeResource1"></asp:TextBox>
                                            </td>
                                            <td style="width: 125px;" class="a-left">
                                                <asp:Label ID="Label9" Text="LandLine" runat="server" meta:resourcekey="Label9Resource1"></asp:Label>
                                            </td>
                                            <td style="width: 220px;" colspan="2" class="a-left">
                                                <asp:TextBox ID="txtLandLine" TabIndex="12" runat="server"    onkeypress="return ValidateOnlyNumeric(this);"  
                                                    CssClass="small" MaxLength="12" meta:resourcekey="txtLandLineResource1"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 125px;" class="a-left">
                                                <asp:Label ID="lblMobile" Text="Mobile" runat="server" meta:resourcekey="lblMobileResource1"></asp:Label>
                                            </td>
                                            <td style="width: 220px;" class="a-left">
                                                <asp:TextBox ID="txtMobile" TabIndex="13" runat="server"    onkeypress="return ValidateOnlyNumeric(this);"  
                                                     CssClass="small" MaxLength="11" meta:resourcekey="txtMobileResource1"></asp:TextBox>
                                            </td>
                                            <td style="width: 125px;" class="a-left">
                                                <asp:Label ID="Label11" Text="Alternate LandLine" runat="server" meta:resourcekey="Label11Resource1"></asp:Label>
                                            </td>
                                            <td style="width: 220px;" colspan="2" class="a-left">
                                                <asp:TextBox ID="txtAltLandLine" TabIndex="14" runat="server"    onkeypress="return ValidateOnlyNumeric(this);"  
                                                     CssClass="small" MaxLength="12" meta:resourcekey="txtAltLandLineResource1"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 125px;" class="a-left">
                                                <asp:Label ID="Label10" Text="Fax" runat="server" meta:resourcekey="Label10Resource1"></asp:Label>
                                            </td>
                                            <td style="width: 220px;" class="a-left">
                                                <asp:TextBox ID="txtFax" TabIndex="15" runat="server" CssClass="small" MaxLength="12"
                                                    meta:resourcekey="txtFaxResource1"></asp:TextBox>
                                            </td>
                                            <td style="width: 125px;" colspan="3" class="a-left">
                                                <asp:CheckBox ID="chkIsClient" TabIndex="16" runat="server" Text="IsClient" meta:resourcekey="chkIsClientResource1" />
                                            </td>
                                        </tr>
                                     <tr class="a-left">
		                             <td>
                                                                                                                        <asp:Label ID="lblContactType" Text="Contact Type" runat="server" meta:resourcekey="lblContactTypeResource1"></asp:Label>
                                                                                                                    </td>
                                                                                                                    <td>
                                                                                                                        <asp:DropDownList runat="server" ID="drplstPerson" Width="170px" CssClass="small" onChange="SetContextKey();"
                                                                                                                            meta:resourcekey="drplstPersonResource1">
                                                                                                                        </asp:DropDownList>
                                                                                                                        &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                                                                                    </td>
                                                                                                                    <td>
                                                                                                                        <asp:Label ID="lblPersonName" Text="Name" runat="server" meta:resourcekey="lblPersonNameResource1"></asp:Label>
                                                                                                                    </td>
                                                                                                                    <td style="display: table-cell;" id="tdtxtPrsn">
                                                                                                                        <asp:TextBox ID="txtPersonName" runat="server" CssClass="Txtboxsmall" Width="170px"
                                                                                                                            meta:resourcekey="txtPersonNameResource1"></asp:TextBox>
                                                                                                                        &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                                                                                        <ajc:AutoCompleteExtender ID="AutoCompleteExtender3" runat="server" TargetControlID="txtPersonName"
                                                                                                                            EnableCaching="False" MinimumPrefixLength="2" CompletionInterval="0" FirstRowSelected="True"
                                                                                                                            CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                                                                                            CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" ServiceMethod="GetSpecifiedDeptEmployee"
                                                                                                                            OnClientItemSelected="GetEmpID" ServicePath="~/WebService.asmx" UseContextKey="True"
                                                                                                                            DelimiterCharacters="" Enabled="True">
                                                                                                                        </ajc:AutoCompleteExtender>
                                                                                                                    </td>
		                            </tr>
                                    </table>
                                </asp:Panel>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td class="a-center" colspan="4">
                            <asp:Button ID="btnFinish" ToolTip="Click here to Save Refering Hospital Details"
                                Style="cursor: pointer;" runat="server" OnClick="btnFinish_Click" Text="Save"
                                OnClientClick="return validateLabRefOrgDetails()" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                onmouseout="this.className='btn'" TabIndex="56" meta:resourcekey="btnFinishResource1" />
                            <asp:Button ID="btnDelete" Visible="False" runat="server" OnClick="btnDelete_Click"
                                Text="Delete" TabIndex="57" OnClientClick="javascript:return ConfirmCancel();" Style="cursor: pointer;" ToolTip="Click here to Remove Refering Hospital Details"
                                CssClass="btn" onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'"
                                meta:resourcekey="btnDeleteResource1" />
                            <asp:Button ID="btnCancel" TabIndex="58" runat="server" Text="Cancel" ToolTip="Click here to Cancel, View the Home Page"
                                Style="cursor: pointer;" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                onmouseout="this.className='btn'" OnClick="btnCancel_Click" meta:resourcekey="btnCancelResource1" />
                        </td>
                    </tr>
                </table>
                <asp:HiddenField ID="hdnRefOrgType" runat="server" />
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    <asp:HiddenField ID="hdnMessages" runat="server" />
       <input type="hidden" id="hdnAddDepart" runat="server" value="" />
    <input type="hidden" id="hdnEmpID" runat="server" value="" />
    </form>
</body>
</html>
