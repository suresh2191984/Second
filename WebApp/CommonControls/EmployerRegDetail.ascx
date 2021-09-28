<%@ Control Language="C#" AutoEventWireup="true" CodeFile="EmployerRegDetail.ascx.cs"
    Inherits="CommonControls_EmployerRegDetail" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<script type ="text/javascript" language ="javascript" >
var slist={Update:'<%=Resources.ClientSideDisplayTexts.CommonControls_EmployerRegDetail_Update %>',Upload:'<%=Resources.ClientSideDisplayTexts.CommonControls_EmployerRegDetail_Upload %>'};
</script>
<script type="text/javascript" language="javascript">
    function ShowAlertMsg(key) {
        var vPEmpNo = SListForAppMsg.Get('CommonControls_EmployerRegDetail_ascx_01') == null ? "Please Check The Employee Number" : SListForAppMsg.Get('CommonControls_EmployerRegDetail_ascx_01');

       var userMsg = SListForApplicationMessages.Get(key);
            if (userMsg != null) {
                alert(userMsg);
                return false ;
            }
            else 
            {
                //alert('Please Check The Employee Number');
                ValidationWindow(vPEmpNo, AlertType);
            return false ;
            }
         
           return true;
        }

    function ShowPatientType() {
        if (document.getElementById('<%=ddlPatientType.ClientID %>').value == "---Select---") {
            document.getElementById('<%=trPatientEmployee.ClientID %>').style.display = "none";
            document.getElementById('<%=trRelation.ClientID %>').style.display = "none";
            document.getElementById('<%=trExtended.ClientID %>').style.display = "none";
            document.getElementById('<%=trRelatedEmployer.ClientID %>').style.display = "none";
            document.getElementById('<%=trExternalEmployer.ClientID %>').style.display = "none";
            if (document.getElementById('hdnInsertorUpdate').value == "1") {
                EmpDetailClar();
            }
        }
        else if (document.getElementById('<%=ddlPatientType.ClientID %>').value == "1") {
            document.getElementById('<%=trPatientEmployee.ClientID %>').style.display = "block";
            document.getElementById('<%=trRelation.ClientID %>').style.display = "none";
            document.getElementById('<%=trRelatedEmployer.ClientID %>').style.display = "none";
            document.getElementById('<%=trExtended.ClientID %>').style.display = "none";
            document.getElementById('<%=trExternalEmployer.ClientID %>').style.display = "none";
            if (document.getElementById('hdnInsertorUpdate').value == "1") {
                //EmpDetailClar();
                document.getElementById('btnFinish').disabled = false;
            }
        }
        else if (document.getElementById('<%=ddlPatientType.ClientID %>').value == "2") {
            document.getElementById('<%=trPatientEmployee.ClientID %>').style.display = "none";
            document.getElementById('<%=trExtended.ClientID %>').style.display = "none";
            document.getElementById('<%=trRelation.ClientID %>').style.display = "block";
            document.getElementById('<%=trRelatedEmployer.ClientID %>').style.display = "block";
            document.getElementById('<%=trExternalEmployer.ClientID %>').style.display = "none";
            if (document.getElementById('hdnInsertorUpdate').value == "1") {
                EmpDetailClar();
                document.getElementById('btnFinish').disabled = false;
            }
            if (document.getElementById('<%=hdnMID.ClientID %>').value == '1') {
                document.getElementById('btnFinish').disabled = false;
            }
            else {
            }

        }
        else if (document.getElementById('<%=ddlPatientType.ClientID %>').value == "3") {
            document.getElementById('<%=trExtended.ClientID %>').style.display = "block";
            document.getElementById('<%=trPatientEmployee.ClientID %>').style.display = "none";
            document.getElementById('<%=trRelation.ClientID %>').style.display = "none";
            document.getElementById('<%=trRelatedEmployer.ClientID %>').style.display = "block";
            document.getElementById('<%=trExternalEmployer.ClientID %>').style.display = "none";
            if (document.getElementById('hdnInsertorUpdate').value == "1") {
                EmpDetailClar();
                document.getElementById('btnFinish').disabled = false;
                document.getElementById('<%=txtEmployerID.ClientID %>').value = document.getElementById('<%=hdnExtendedID.ClientID %>').value;
            }
            if (document.getElementById('<%=hdnMID.ClientID %>').value == '1') {
                document.getElementById('btnFinish').disabled = false;
            }
            else {
            }
        }
        else if (document.getElementById('<%=ddlPatientType.ClientID %>').value == "4") {
            document.getElementById('<%=trPatientEmployee.ClientID %>').style.display = "none";
            document.getElementById('<%=trRelation.ClientID %>').style.display = "none";
            document.getElementById('<%=trExtended.ClientID %>').style.display = "none";
            document.getElementById('<%=trRelatedEmployer.ClientID %>').style.display = "none";
            document.getElementById('<%=trExternalEmployer.ClientID %>').style.display = "block";
            if (document.getElementById('hdnInsertorUpdate').value == "1") {
                EmpDetailClar();
                document.getElementById('btnFinish').disabled = false;
                document.getElementById('<%=txtExternalnumber.ClientID %>').value = document.getElementById('<%=hdnExternalID.ClientID %>').value;
            }
            if (document.getElementById('<%=hdnMID.ClientID %>').value == '1') {
                document.getElementById('btnFinish').disabled = false;
            }
            else {
            }
        }
        else if (document.getElementById('<%=ddlPatientType.ClientID %>').value == "5") {
            document.getElementById('<%=trPatientEmployee.ClientID %>').style.display = "none";
            document.getElementById('<%=trRelation.ClientID %>').style.display = "none";
            document.getElementById('<%=trExtended.ClientID %>').style.display = "none";
            document.getElementById('<%=trRelatedEmployer.ClientID %>').style.display = "none";
            document.getElementById('<%=trExternalEmployer.ClientID %>').style.display = "none";
            if (document.getElementById('hdnInsertorUpdate').value == "1") {
                EmpDetailClar();
                document.getElementById('btnFinish').disabled = false;

            }
            if (document.getElementById('<%=hdnMID.ClientID %>').value == '1') {
                document.getElementById('btnFinish').disabled = false;
            }
            else {
            }
        }

    }
    
     
</script>

<script type="text/javascript">
    function noNumbers(id) {
        var split = document.getElementById(id).value.split('~');
        var EmpName = split[0];
        var EmpNO = split[1];
        if (EmpName != '') {
            document.getElementById('<%=txtEmployerID.ClientID %>').value = EmpNO;
            document.getElementById('<%=TextBoxURN.ClientID %>').value = EmpNO;
        }

    }
    function EMPNumbers(id) {
        var split = document.getElementById(id).value.split('~');
        var cnt = split.length;
        if (cnt > 1) {
            var EmpName = split[0];
            var EmpNO = split[1];
            document.getElementById('<%=txtEmployementTypeNo.ClientID %>').value = EmpNO;
            document.getElementById('<%=TextBoxURN.ClientID %>').value = EmpNO;

        }

    }

    function ValidateEmp() {
        var vPEmpNo = SListForAppMsg.Get('CommonControls_EmployerRegDetail_ascx_02') == null ? "Please Enter the Employee No" : SListForAppMsg.Get('CommonControls_EmployerRegDetail_ascx_02');
    
        if (document.getElementById('<%=TextBoxURN.ClientID %>').value == '') {
            var userMsg = SListForApplicationMessages.Get('CommonControls\\EmployerRegDetail.ascx_1');
            if (userMsg != null) {
                alert(userMsg);
            }
            else {
                // alert("Please Enter the Employee No");
                ValidationWindow(vPEmpNo, AlertType);
            }
            document.getElementById('<%=TextBoxURN.ClientID %>').focus();
            return false;
        }
    }
    function ValidateEX() {
        var vPEmpNo = SListForAppMsg.Get('CommonControls_EmployerRegDetail_ascx_02') == null ? "Please Enter the Employee No" : SListForAppMsg.Get('CommonControls_EmployerRegDetail_ascx_02');
    
        if (document.getElementById('<%=txtEmployerID.ClientID %>').value == '') {
            var userMsg = SListForApplicationMessages.Get('CommonControls\\EmployerRegDetail.ascx_1');
            if (userMsg != null) {
                alert(userMsg);
            } else {
            // alert("Please Enter the Employee No");
            ValidationWindow(vPEmpNo, AlertType)
            }
            document.getElementById('<%=txtEmployerID.ClientID %>').focus();
            return false;
        }
    }
    function EmpDetailClar() {
        if (document.getElementById('<%=ddlPatientType.ClientID %>').value == "1") {
            document.getElementById('<%=ddlEmployementType.ClientID %>').value = '0';
            //document.getElementById('<%=txtEmployementTypeNo.ClientID %>').value = '';
            document.getElementById('<%=txtJoinDate.ClientID %>').value = '';
            document.getElementById('<%=txtQualification.ClientID %>').value = '';
            document.getElementById('<%=ddlDepartment.ClientID %>').selectedIndex = '0';
            document.getElementById('<%=ddlEmployementType.ClientID %>').selectedIndex = '0';
            document.getElementById('<%=ddlDesignation.ClientID %>').selectedIndex = '0';
            document.getElementById('<%=ddlGrade.ClientID %>').selectedIndex = '0';
            document.getElementById('<%=ddlEmployerName.ClientID %>').selectedIndex = '0';
            document.getElementById('<%=ddlEmployerLocation.ClientID %>').selectedIndex = '0';
            document.getElementById("txtName").value = '';
            document.getElementById("tDOB").value = ''
            document.getElementById("ddSex").value = '';
            document.getElementById('txtDOBNos').value = '';
            document.getElementById('ddMarital').value = '0'
            document.getElementById("txtAddress").value = '';
            document.getElementById("txtCity").value = '';
            document.getElementById("ddState").selectedIndex = '0';
            document.getElementById("ddCountry").selectedIndex = '0';
            document.getElementById("txtMobile").value = '';
            document.getElementById("txtLandLine").value = '';
            document.getElementById("txtFileNo").value = '';
            document.getElementById('<%=hdnEmpdetails.ClientID %>').value = '';
            document.getElementById('imgPatient').src = "../Images/ProfileDefault.jpg";
            document.getElementById('divRemovePhoto').style.display = 'none';
            document.getElementById('lblUploadPhoto').innerHTML =slist.Upload;
        }
        if (document.getElementById('<%=ddlPatientType.ClientID %>').value == "2") {
            document.getElementById('<%=ddlEmployementType.ClientID %>').value = '0';
            //document.getElementById('<%=txtEmployementTypeNo.ClientID %>').value = '';
            document.getElementById('<%=txtEmployerID.ClientID %>').value = document.getElementById('<%=txtEmployementTypeNo.ClientID %>').value;
            document.getElementById('<%=txtJoinDate.ClientID %>').value = '';
            document.getElementById('<%=txtQualification.ClientID %>').value = '';
            document.getElementById('<%=ddlDepartment.ClientID %>').selectedIndex = '0';
            document.getElementById('<%=ddlEmployementType.ClientID %>').selectedIndex = '0';
            document.getElementById('<%=ddlDesignation.ClientID %>').selectedIndex = '0';
            document.getElementById('<%=ddlGrade.ClientID %>').selectedIndex = '0';
            document.getElementById('<%=ddlEmployerName.ClientID %>').selectedIndex = '0';
            document.getElementById('<%=ddlEmployerLocation.ClientID %>').selectedIndex = '0';
            document.getElementById("txtName").value = '';
            document.getElementById("tDOB").value = ''
            document.getElementById("ddSex").selectedIndex = '0';
            document.getElementById('txtDOBNos').value = '';
            document.getElementById('ddMarital').selectedIndex = '0';
            document.getElementById('<%=ddlRelation.ClientID %>').selectedIndex = 0
            document.getElementById('<%=hdnEmpdetails.ClientID %>').value = '';
            document.getElementById('imgPatient').src = "../Images/ProfileDefault.jpg";
            document.getElementById('divRemovePhoto').style.display = 'none';
            document.getElementById('lblUploadPhoto').innerHTML =slist.Upload;
        }
        else {
            document.getElementById('<%=ddlEmployementType.ClientID %>').value = '0';
            //document.getElementById('<%=txtEmployementTypeNo.ClientID %>').value = '';
            document.getElementById('<%=txtEmployerID.ClientID %>').value = document.getElementById('<%=txtEmployementTypeNo.ClientID %>').value;
            document.getElementById('<%=txtJoinDate.ClientID %>').value = '';
            document.getElementById('<%=txtQualification.ClientID %>').value = '';
            document.getElementById('<%=ddlDepartment.ClientID %>').selectedIndex = '0';
            document.getElementById('<%=ddlEmployementType.ClientID %>').selectedIndex = '0';
            document.getElementById('<%=ddlDesignation.ClientID %>').selectedIndex = '0';
            document.getElementById('<%=ddlGrade.ClientID %>').selectedIndex = '0';
            document.getElementById('<%=ddlEmployerName.ClientID %>').selectedIndex = '0';
            document.getElementById('<%=ddlEmployerLocation.ClientID %>').selectedIndex = '0';
            document.getElementById("txtName").value = '';
            document.getElementById("tDOB").value = ''
            document.getElementById("ddSex").selectedIndex = '0';
            document.getElementById('txtDOBNos').value = '';
            document.getElementById('ddMarital').selectedIndex = '0';
            document.getElementById('<%=ddlExtended.ClientID %>').selectedIndex = '0';
            document.getElementById('<%=hdnEmpdetails.ClientID %>').value = '';
            document.getElementById('imgPatient').src = "../Images/ProfileDefault.jpg";
            document.getElementById('divRemovePhoto').style.display = 'none';
            document.getElementById('lblUploadPhoto').innerHTML =slist.Upload;
        }
    }
    function EmpDetails(pID) {
        var ptye = document.getElementById('<%=ddlPatientType.ClientID %>').value;
        if (ptye == 1) {
            var split = pID.split('~');
            var cnt = split.length;
            if (cnt > 1) {
                var EmpName = split[0];
                var EmpNO = split[1]
                var Sex = split[2];
                var Marital = split[3];
                var State = split[4];
                var Country = split[5];
                var City = split[6];
                var MoblieNo = split[7];
                var LandlineNo = split[8];
                var DOB = split[9];
                var Qln = split[10];
                var Doj = split[11];
                var Add = split[12];
                var GradeID = split[13];
                var EmployementTypeID = split[14];
                var DeptID = split[15];
                var DesignationID = split[16];
                var EmployerLocationID = split[17];
                var EmployerID = split[18];
                var FileNo = split[19];
                var PictureName = split[20];
                document.getElementById('<%=ddlEmployementType.ClientID %>').value = '1';
                document.getElementById('<%=txtEmployementTypeNo.ClientID %>').value = EmpNO;
                document.getElementById('<%=txtJoinDate.ClientID %>').value = Doj;
                document.getElementById('<%=txtQualification.ClientID %>').value = Qln;
                document.getElementById('<%=ddlDepartment.ClientID %>').value = DeptID;
                document.getElementById('<%=ddlDesignation.ClientID %>').value = DesignationID;
                document.getElementById('<%=ddlGrade.ClientID %>').value = GradeID;
                document.getElementById('<%=ddlEmployerName.ClientID %>').value = EmployerID;
                document.getElementById('<%=ddlEmployerLocation.ClientID %>').value = EmployerLocationID;
                document.getElementById("txtName").value = EmpName;
                document.getElementById("tDOB").value = DOB
                document.getElementById("ddSex").value = Sex;
                document.getElementById('ddMarital').value = Marital
                document.getElementById("txtAddress").value = Add;
                document.getElementById("txtCity").value = City;
                document.getElementById("ddState").options[document.getElementById('ddState').selectedIndex].text = State;
                document.getElementById("ddState").value = '31';
                document.getElementById("ddCountry").options[document.getElementById('ddCountry').selectedIndex].text = Country;
                document.getElementById("txtMobile").value = MoblieNo;
                document.getElementById("txtLandLine").value = LandlineNo;
                document.getElementById("txtFileNo").value = FileNo;
                countAge('tDOB');
                document.getElementById('<%=hdnEmpdetails.ClientID %>').value = '';
                if (PictureName == '') {
                    document.getElementById('imgPatient').src = "../Images/ProfileDefault.jpg";
                    document.getElementById('divRemovePhoto').style.display = 'none';
                    document.getElementById('lblUploadPhoto').innerHTML =slist.Upload;
                }
                else {
                    document.getElementById('imgPatient').src = "PatientImageHandler.ashx?FileName=" + PictureName;
                    document.getElementById('divRemovePhoto').style.display = 'block';
                    document.getElementById('lblUploadPhoto').innerHTML =slist.Update;
                }
            }
        }
        else {
            EmpDetails1(pID)
        }
    }

    function EmpDetails1(pID) {
        var split = pID.split('~');
        var cnt = split.length;
        if (cnt > 1) {
            var EmpName = split[0];
            var EmpNO = split[1]
            var Sex = split[2];
            var Marital = split[3];
            var State = split[4];
            var Country = split[5];
            var City = split[6];
            var MoblieNo = split[7];
            var LandlineNo = split[8];
            var DOB = split[9];
            var Qln = split[10];
            var Doj = split[11];
            var Add = split[12];
            var GradeID = split[13];
            var EmployementTypeID = split[14];
            var DeptID = split[15];
            var DesignationID = split[16];
            var EmployerLocationID = split[17];
            var EmployerID = split[18];
            var FileNo = split[19];
            //            document.getElementById('<%=ddlEmployementType.ClientID %>').value = '1';
            //            document.getElementById('<%=txtEmployementTypeNo.ClientID %>').value = EmpNO;
            //            document.getElementById('<%=txtJoinDate.ClientID %>').value = Doj;
            //            document.getElementById('<%=txtQualification.ClientID %>').value = Qln;
            //            document.getElementById('<%=ddlDepartment.ClientID %>').value = DeptID;
            //            document.getElementById('<%=ddlDesignation.ClientID %>').selectedIndex = DesignationID;
            //            document.getElementById('<%=ddlGrade.ClientID %>').selectedIndex = GradeID;
            //            document.getElementById('<%=ddlEmployerName.ClientID %>').selectedIndex = EmployerID;
            //            document.getElementById('<%=ddlEmployerLocation.ClientID %>').selectedIndex = EmployerLocationID;
            //document.getElementById("txtName").value = EmpName;
            //document.getElementById("tDOB").value = DOB
            document.getElementById("ddSex").selectedIndex = 0;
            document.getElementById('ddMarital').selectedIndex = 0
            document.getElementById('<%=ddlRelation.ClientID %>').selectedIndex = 0;
            document.getElementById('<%=txtEmployerID.ClientID %>').value = EmpNO;
            document.getElementById("txtAddress").value = Add;
            document.getElementById("txtCity").value = City;
            document.getElementById("ddState").options[document.getElementById('ddState').selectedIndex].text = State;
            document.getElementById("ddState").value = '31';
            document.getElementById("ddCountry").options[document.getElementById('ddCountry').selectedIndex].text = Country;
            document.getElementById("txtMobile").value = MoblieNo;
            document.getElementById("txtLandLine").value = LandlineNo;
            document.getElementById("txtFileNo").value = FileNo;
            // countAge('tDOB');
            document.getElementById('<%=hdnEmpdetails.ClientID %>').value = '';
        }
    }
    function EmpsetSexValue(sexId, msId, MarId) {
        //alert(document.getElementById('<%=ddlRelation.ClientID %>').selectedIndex.text);
        var Relation = document.getElementById('<%=ddlRelation.ClientID %>').options[document.getElementById('<%=ddlRelation.ClientID %>').selectedIndex].text;
        //alert(document.getElementById('<%=ddlRelation.ClientID %>').options[document.getElementById('<%=ddlRelation.ClientID %>').selectedIndex].text);
        document.getElementById(MarId).value = 'S';
        if (Relation.toUpperCase().trim() == 'MOTHER' || Relation.toUpperCase().trim() == 'WIFE') {
            document.getElementById(msId).value = '9';
            document.getElementById(MarId).value = 'M';
        }
        else if (Relation.toUpperCase().trim() == 'DAUGHTER') {
            document.getElementById(msId).value = '2';

        }
        else if (Relation.toUpperCase().trim() == 'FATHER' || Relation.toUpperCase().trim() == 'HUSBAND') {
            document.getElementById(MarId).value = 'M';
            document.getElementById(msId).value = '1';
        }
        else {
            document.getElementById(msId).value = '1';
        }
        if (document.getElementById(msId).value == '1') {
            document.getElementById(sexId).value = 'M';
        }
        else if (document.getElementById(msId).value == '2') {
            document.getElementById(sexId).value = 'F';
        }
        else if (document.getElementById(msId).value == '9') {
            document.getElementById(sexId).value = 'F';
        }
        else {

            document.getElementById(sexId).value = '0'

        }
    }
    function checkdate() {
        var validformat = /^\d{2}\/\d{2}\/\d{4}$/ //Basic check for format validity
        if (!validformat.test(document.getElementById('<%=txtJoinDate.ClientID %>').value)) {
            document.getElementById('<%=txtJoinDate.ClientID %>').value = '';
        }
    }
</script>

<table cssclass="dataheader2 defaultfontcolor w-100p">
    <tr>
        <td style="width: 173px;">
            <table>
                <tr>
                    <td>
                        <asp:Label ID="lblURNSearch" runat="server" Text="  URN Search" 
                            meta:resourcekey="lblURNSearchResource1"></asp:Label>
                    </td>
                </tr>
            </table>
        </td>
        <td style="display: table-cell; padding-left: 1px; width: 250px;">
            <table>
                <tr>
                    <td>
                        <asp:TextBox ID="TextBoxURN" CssClass="Txtboxlarge" runat="server" onKeyDown="ClearItemIlst();"
                            onkeypress="ClearItemIlst();" onKeyUp="ClearItemIlst();" 
                            meta:resourcekey="TextBoxURNResource1"></asp:TextBox>
                        <ajc:AutoCompleteExtender ID="AutoCompleteUrnNO" runat="server" CompletionInterval="0"
                            CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" CompletionListCssClass="wordWheel listMain .box"
                            CompletionListItemCssClass="wordWheel itemsMain" OnClientItemOver="IAmSelected"
                            OnClientItemSelected="IAmSelected" BehaviorID="AutoComplete" DelimiterCharacters=""
                            EnableCaching="False" FirstRowSelected="True" Enabled="True" MinimumPrefixLength="1"
                            ServiceMethod="GetEmpDetails" ServicePath="~/InventoryWebService.asmx" TargetControlID="TextBoxURN"
                            UseContextKey="True">
                        </ajc:AutoCompleteExtender>
                    </td>
                </tr>
            </table>
        </td>
        <td style="display: table-cell;" class="w-80 paddingL1">
            <%-- <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                <ContentTemplate>
                    <asp:Button ID="lblFetchEmpDetail0" runat="server" Text="Validate" CssClass="btn"
                        OnClientClick="javascript:return ValidateEmp()" OnClick="lblFetchEmpDetails_Click" Visible="false">
                    </asp:Button>
                    <asp:Button ID="lblClear" runat="server" 
                            Text="Clear" CssClass="btn" OnclindClick="javascript:return EmpDetailClar()"  ></asp:Button>
                </ContentTemplate>
            </asp:UpdatePanel>--%>
        </td>
        <td>
            <div id="showimage" style="display: none; position: absolute; width: 460px; left: 50%;
                top: 3%">
                <div onclick="hidebox();return false" class="divCloseRight">
                </div>
                <table border="0" width="453px" cellspacing="1" class="modalPopup dataheaderPopup"
                    cellpadding="1">
                    <tr>
                        <td id="dragbar" style="cursor: move; cursor: pointer" width="100%" onmousedown="initializedrag(event)">
                            <asp:Label ID="lblEmpadnotherDetails" runat="server" 
                                meta:resourcekey="lblEmpadnotherDetailsResource1"></asp:Label>
                        </td>
                    </tr>
                </table>
            </div>
        </td>
    </tr>
</table>
<table class="dataheader2 defaultfontcolor w-100p">
    <tr>
        <td colspan="4">
            <table class="w-100p">
                <tr id="Tr1" runat="server">
                    <td style="width: 171px;">
                        <asp:Label ID="lblPatientType" runat="server" Text="Patient Type" 
                            meta:resourcekey="lblPatientTypeResource1"></asp:Label>
                    </td>
                    <td style="width: 340px;">
                        <asp:DropDownList ID="ddlPatientType" CssClass="ddlsmall" onChange="javascript:return ShowPatientType();"
                            runat="server" meta:resourcekey="ddlPatientTypeResource1">
                  
                <%--<asp:ListItem Text="Employee" Value="1"></asp:ListItem>  
                <asp:ListItem Text="Dependent" Value="2"></asp:ListItem>
                <asp:ListItem Text="Extended" Value="3"></asp:ListItem>--%>
                        </asp:DropDownList>
                        <asp:Label ID="lblddlP" runat="server" Text="*" ForeColor="Red" 
                            meta:resourcekey="lblddlPResource1"></asp:Label>
                    </td>
                    <td>
                    </td>
                    <td>
                    </td>
                </tr>
                <tr id="trRelation" runat="server" style="display: none;">
                    <td>
                        <asp:Label ID="lblRelation" runat="server" Text="Relationship" 
                            meta:resourcekey="lblRelationResource1"></asp:Label>
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlRelation" CssClass="ddlsmall" runat="server" 
                            onchange="EmpsetSexValue('ddSex','ddSalutation','ddMarital');" 
                            meta:resourcekey="ddlRelationResource1">
                        </asp:DropDownList>
                        <asp:Label ID="Label3" runat="server" Text="*" ForeColor="Red" 
                            meta:resourcekey="Label3Resource1"></asp:Label>
                    </td>
                    <td>
                    </td>
                    <td>
                    </td>
                </tr>
                <tr id="trExtended" runat="server" style="display: none;">
                    <td>
                        <asp:Label ID="lblExtended" runat="server" Text="Extended Type" 
                            meta:resourcekey="lblExtendedResource1"></asp:Label>
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlExtended" CssClass="ddlsmall" runat="server" 
                            meta:resourcekey="ddlExtendedResource1">
                      
                        <%--    <asp:ListItem Text="Driver" Value="1"></asp:ListItem>
                            <asp:ListItem Text="House Maid" Value="2"></asp:ListItem>--%>
                        </asp:DropDownList>
                        <asp:Label ID="Label1" runat="server" Text="*" ForeColor="Red" 
                            meta:resourcekey="Label1Resource1"></asp:Label>
                    </td>
                    <td>
                    </td>
                    <td>
                    </td>
                </tr>
                <tr id="trRelatedEmployer" runat="server" style="display: none;">
                    <td>
                        <asp:Label ID="lblRelatedEmp" runat="server" Text="Employee Number" 
                            meta:resourcekey="lblRelatedEmpResource1"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtEmployerID" CssClass="Txtboxsmall" runat="server" 
                            onChange="checkemployeeNo1()" meta:resourcekey="txtEmployerIDResource1"></asp:TextBox>
                        <asp:Label ID="Label4" runat="server" Text="*" ForeColor="Red" 
                            meta:resourcekey="Label4Resource1"></asp:Label>
                    </td>
                    <td style="display: none;">
                        <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                            <ContentTemplate>
                                <asp:Button ID="btnCheckNo1" runat="server" Text="Validate" CssClass="btn" 
                                    OnClick="btnCheckNo1_Click" meta:resourcekey="btnCheckNo1Resource1">
                                </asp:Button>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </td>
                                        <td>
                    </td>
                </tr>
                <tr id="trExternalEmployer" runat="server" style="display: none;">
                    <td>
                        <asp:Label ID="Label6" runat="server" Text="Patient Number" 
                            meta:resourcekey="Label6Resource1"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtExternalnumber" CssClass="Txtboxsmall" runat="server" 
                            Enabled="False" meta:resourcekey="txtExternalnumberResource1"></asp:TextBox>
                        <asp:Label ID="Label7" runat="server" Text="*" ForeColor="Red" 
                            meta:resourcekey="Label7Resource1"></asp:Label>
                    </td>
                    <td>
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>
                                <input id="btnAdd1" style="display: block; font-size: 10px; width: 120px;" type="button"
                                    class="btn" value="Associate(Dependents)" onclick="showModalPopup(event);" />
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </td>
                    <td>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr id="trPatientEmployee" runat="server" style="display: none;">
        <td colspan="4">
            <table class="w-100p">
                <tr id="trEmployeeType" runat="server">
                    <td style="width: 171px;">
                        <asp:Label ID="lblEmployementType" runat="server" Text="Employee Type" 
                            meta:resourcekey="lblEmployementTypeResource1"></asp:Label>
                    </td>
                    <td style="width: 300px;">
                        <asp:DropDownList ID="ddlEmployementType" CssClass="ddlsmall" runat="server" 
                            onChange="EmployementType()" meta:resourcekey="ddlEmployementTypeResource1">
              
                        </asp:DropDownList>
                        <asp:Label ID="Label2" runat="server" Text="*" ForeColor="Red" 
                            meta:resourcekey="Label2Resource1"></asp:Label>
                        <asp:Label ID="lblEmpNo" runat="server" Visible="False" 
                            meta:resourcekey="lblEmpNoResource1"></asp:Label>
                    </td>
                    <td style="width: 155px;">
                        <asp:Label ID="lblEmpNumber" runat="server" Text="Employee Number" 
                            meta:resourcekey="lblEmpNumberResource1"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtEmployementTypeNo" CssClass="Txtboxsmall" runat="server" 
                            onChange="checkemployeeNo()" meta:resourcekey="txtEmployementTypeNoResource1"></asp:TextBox>
                        <asp:Label ID="Label5" runat="server" Text="*" ForeColor="Red" 
                            meta:resourcekey="Label5Resource1"></asp:Label>
                    </td>
                    <td style="display: none;">
                        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                            <ContentTemplate>
                                <asp:Button ID="btnCheckNo" runat="server" Text="Validate" CssClass="btn" 
                                    OnClick="btnCheckNo_Click" meta:resourcekey="btnCheckNoResource1">
                                </asp:Button>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </td>
                </tr>
                <tr id="trDOJ" runat="server">
                    <td>
                        <asp:Label ID="lblDateOfJoin" runat="server" Text="Date of Joining" 
                            meta:resourcekey="lblDateOfJoinResource1"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtJoinDate" CssClass="Txtboxsmall" runat="server" 
                            onchange="checkdate()" meta:resourcekey="txtJoinDateResource1"></asp:TextBox>
                        <ajc:CalendarExtender ID="CalendarExtender1" Format="dd/MM/yyyy" runat="server" TargetControlID="txtJoinDate"
                            Enabled="True" />
                        <%--<asp:Label ID="Label6" runat="server" Text="*" ForeColor="Red"></asp:Label>--%>
                    </td>
                    <td>
                        <asp:Label ID="lblQualification" runat="server" Text="Qualification" 
                            meta:resourcekey="lblQualificationResource1"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtQualification" CssClass="Txtboxsmall" runat="server" 
                            meta:resourcekey="txtQualificationResource1"></asp:TextBox>
                        <%--<asp:Label ID="Label7" runat="server" Text="*" ForeColor="Red"></asp:Label>--%>
                    </td>
                </tr>
                <tr id="trDepartment" runat="server">
                    <td>
                        <asp:Label ID="lblDepartment" runat="server" Text="Department" 
                            meta:resourcekey="lblDepartmentResource1"></asp:Label>
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlDepartment" CssClass="ddlsmall" runat="server" 
                            meta:resourcekey="ddlDepartmentResource1">
                     
                        </asp:DropDownList>
                        <%--<asp:Label ID="Label8" runat="server" Text="*" ForeColor="Red"></asp:Label>--%>
                    </td>
                    <td style="display: none">
                        <asp:Label ID="lblGrade" runat="server" Text="Grade" 
                            meta:resourcekey="lblGradeResource1"></asp:Label>
                    </td>
                    <td style="display: none">
                        <asp:DropDownList ID="ddlGrade" runat="server" CssClass="ddlsmall" 
                            meta:resourcekey="ddlGradeResource1">
                        
                        </asp:DropDownList>
                        <%--<asp:Label ID="Label11" runat="server" Text="*" ForeColor="Red"></asp:Label>--%>
                    </td>
                    <td>
                        <asp:Label ID="Rs_BloodGroup" Text="Blood Group" runat="server" 
                            meta:resourcekey="Rs_BloodGroupResource1" />
                    </td>
                    <td>
                        <asp:DropDownList ID="ddBloodGrp" runat="server" CssClass="ddlsmall" 
                            meta:resourcekey="ddBloodGrpResource1">
                            <%--<asp:ListItem Value="-1" meta:resourcekey="ListItemResource1" Text="--Select One--"></asp:ListItem>
                            <asp:ListItem meta:resourcekey="ListItemResource2" Text="O+"></asp:ListItem>
                            <asp:ListItem meta:resourcekey="ListItemResource3" Text="A+"></asp:ListItem>
                            <asp:ListItem meta:resourcekey="ListItemResource4" Text="B+"></asp:ListItem>
                            <asp:ListItem meta:resourcekey="ListItemResource5" Text="O-"></asp:ListItem>
                            <asp:ListItem meta:resourcekey="ListItemResource6" Text="A-"></asp:ListItem>
                            <asp:ListItem meta:resourcekey="ListItemResource7" Text="B-"></asp:ListItem>
                            <asp:ListItem meta:resourcekey="ListItemResource8" Text="A1+"></asp:ListItem>
                            <asp:ListItem meta:resourcekey="ListItemResource9" Text="A1-"></asp:ListItem>
                            <asp:ListItem meta:resourcekey="ListItemResource10" Text="AB+"></asp:ListItem>
                            <asp:ListItem meta:resourcekey="ListItemResource11" Text="AB-"></asp:ListItem>
                            <asp:ListItem meta:resourcekey="ListItemResource12" Text="A1B+"></asp:ListItem>
                            <asp:ListItem meta:resourcekey="ListItemResource13" Text="A1B-"></asp:ListItem>
                            <asp:ListItem meta:resourcekey="ListItemResource14" Text="A2+"></asp:ListItem>
                            <asp:ListItem meta:resourcekey="ListItemResource15" Text="A2-"></asp:ListItem>
                            <asp:ListItem meta:resourcekey="ListItemResource16" Text="A2B+"></asp:ListItem>
                            <asp:ListItem meta:resourcekey="ListItemResource17" Text="A2B-"></asp:ListItem>--%>
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr id="trDesignation" runat="server">
                    <td>
                        <asp:Label ID="lblDesignation" runat="server" Text="Designation" 
                            meta:resourcekey="lblDesignationResource1"></asp:Label>
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlDesignation" CssClass="ddllarge" runat="server" 
                            meta:resourcekey="ddlDesignationResource1">
                        
                        </asp:DropDownList>
                        <%--<asp:Label ID="Label9" runat="server" Text="*" ForeColor="Red"></asp:Label>--%>
                    </td>
                    <td>
                        <asp:Label ID="lblOffice" runat="server" Text="Employer Name" 
                            meta:resourcekey="lblOfficeResource1"></asp:Label>
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlEmployerName" runat="server" CssClass="ddlsmall" 
                            onChange="checkemployeeNo()" meta:resourcekey="ddlEmployerNameResource1">
                    
                        </asp:DropDownList>
                        <asp:Label ID="Label12" runat="server" Text="*" ForeColor="Red" 
                            meta:resourcekey="Label12Resource1"></asp:Label>
                    </td>
                </tr>
                <tr id="trOfficeLocation" runat="server">
                    <td>
                        <asp:Label ID="lblOfficeLocation" Text="Employee Location" runat="server" 
                            meta:resourcekey="lblOfficeLocationResource1"></asp:Label>
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlEmployerLocation" CssClass="ddlsmall" runat="server" 
                            meta:resourcekey="ddlEmployerLocationResource1">
                      
                        </asp:DropDownList>
                        <%--<asp:Label ID="Label10" runat="server" Text="*" ForeColor="Red"></asp:Label>--%>
                    </td>
                    <td>
                    </td>
                </tr>
                <asp:HiddenField ID="hdnEmployee" Value="N" runat="server" />
                <asp:HiddenField ID="hdnPatientID" runat="server" />
                <asp:HiddenField ID="hdnEmpdetails" runat="server" />
                <asp:HiddenField ID="hdnEmployeeDetails" runat="server" />
                <asp:HiddenField ID="hdnMID" runat="server" Value="0" />
                <asp:HiddenField ID="hdnEmpID" runat="server" />
                <asp:HiddenField ID="hdnExternalID" runat="server" />
                <asp:HiddenField ID="hdnExtendedID" runat="server" />
                <asp:HiddenField ID="hdnEmployeeNo" runat="server" />
            </table>
        </td>
    </tr>
</table>
<asp:UpdatePanel ID="UpdatePanel3" runat="server">
    <ContentTemplate>
        <div>
            <asp:Panel ID="pnlOthers" runat="server" Style="display: none;" 
                CssClass="modalPopup dataheaderPopup w-60p" meta:resourcekey="pnlOthersResource1">
                <div id="divOthers">
                    <table align="center">
                        <tr>
                            <td>
                                <table style="border-collapse: collapse;" class="a-center w-100p">
                                    <tr>
                                        <td>
                                            <table border="1px" style="border-collapse: collapse;" class="a-center w-100p">
                                                <tr style="background-color: #2c88b1;">
                                                    <td nowrap="nowrap" class="w-30p">
                                                        <asp:Label ID="lblExternal" runat="server" Text="External Patient Number" Font-Bold="True"
                                                            ForeColor="White" meta:resourcekey="lblExternalResource1" />
                                                    </td>
                                                    <td nowrap="nowrap" class="w-30p">
                                                        <asp:Label ID="lblDependents" runat="server" Text="Dependents Number" Font-Bold="True"
                                                            ForeColor="White" meta:resourcekey="lblDependentsResource1"></asp:Label>
                                                    </td>
                                                    <td nowrap="nowrap" class="w-30p">
                                                        <asp:Label ID="Label8" runat="server" Text="Relation Type" Font-Bold="True" 
                                                            ForeColor="White" meta:resourcekey="Label8Resource1"></asp:Label>
                                                    </td>
                                                    <td nowrap="nowrap" class="w-10p a-center">
                                                        <asp:Label ID="lblAction" runat="server" Text="Action" Font-Bold="True" 
                                                            ForeColor="White" meta:resourcekey="lblActionResource1"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td nowrap="nowrap">
                                                        <asp:TextBox ID="txtExternal" runat="server" Width="200px" 
                                                            CssClass="Txtboxmedium" meta:resourcekey="txtExternalResource1"></asp:TextBox>
                                                        <ajc:AutoCompleteExtender ID="AutoCompleteNOD" runat="server" CompletionInterval="0"
                                                            CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" CompletionListCssClass="wordWheel listMain .box"
                                                            CompletionListItemCssClass="wordWheel itemsMain" OnClientItemOver="IAmSelected1"
                                                            OnClientItemSelected="IAmSelected1" BehaviorID="AutoComplete1" DelimiterCharacters=""
                                                            EnableCaching="False" FirstRowSelected="True" Enabled="True" MinimumPrefixLength="1"
                                                            ContextKey="Y" ServiceMethod="GetExternalDetails" ServicePath="~/WebService.asmx"
                                                            TargetControlID="txtExternal" UseContextKey="True">
                                                        </ajc:AutoCompleteExtender>
                                                        <asp:HiddenField ID="hdnExternalName" runat="server" />
                                                        <asp:HiddenField ID="HiddenField1" runat="server" />
                                                        <asp:HiddenField ID="hdnExternalPatientID" runat="server" />
                                                    </td>
                                                    <td nowrap="nowrap">
                                                        <asp:TextBox ID="txtDependents" runat="server" Width="200px" CssClass="Txtboxmedium"
                                                            onChange="checsameNo()" meta:resourcekey="txtDependentsResource1"></asp:TextBox>
                                                        <ajc:AutoCompleteExtender ID="AutoCompleteExtenD" runat="server" CompletionInterval="0"
                                                            CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" CompletionListCssClass="wordWheel listMain .box"
                                                            CompletionListItemCssClass="wordWheel itemsMain" OnClientItemOver="IAmSelected2"
                                                            OnClientItemSelected="IAmSelected2" BehaviorID="AutoComplete2" DelimiterCharacters=""
                                                            EnableCaching="False" FirstRowSelected="True" Enabled="True" MinimumPrefixLength="1"
                                                            ContextKey="Y" ServiceMethod="GetExternalDetails" ServicePath="~/WebService.asmx"
                                                            TargetControlID="txtDependents" UseContextKey="True">
                                                        </ajc:AutoCompleteExtender>
                                                        <asp:HiddenField ID="hdnDependentsName" runat="server" />
                                                        <asp:HiddenField ID="hdnDependentsID" runat="server" />
                                                        <asp:HiddenField ID="hdnDependentsPatientID" runat="server" />
                                                    </td>
                                                    <td width="300px" align="left" nowrap="nowrap">
                                                        <asp:DropDownList ID="ddlRelation1" CssClass="ddlsmall" runat="server" 
                                                            meta:resourcekey="ddlRelation1Resource1">
                                                      
                                                        </asp:DropDownList>
                                                        <asp:Label ID="Label9" runat="server" Text="*" ForeColor="Red" 
                                                            meta:resourcekey="Label9Resource1"></asp:Label>
                                                    </td>
                                                    <td class="a-center">
                                                        <input type="button" id="aNew" value="Add" tooltip="Add Relation" class="btn" onmouseover="this.className='btn btnhov'"
                                                            onmouseout="this.className='btn'" onclick="ControlValidation1();return false;" />
                                                    </td>
                                                </tr>
                                            </table>
                                            <asp:HiddenField ID="hdnpatient" runat="server" />
                                            <asp:HiddenField ID="hdnDeleted" runat="server" />
                                            <asp:HiddenField ID="hdnNameExists" runat="server" />
                                            <asp:HiddenField ID="hdnPatientDetails" runat="server" />
                                            <asp:HiddenField ID="hdnPatient1Details" runat="server" />
                                            <asp:HiddenField ID="hdnpatientcount" runat="server" />
                                            <div id="dvTable" runat="server">
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td class="h-20">
                            </td>
                        </tr>
                        <tr>
                            <td class="a-center">
                                <asp:Button ID="btnOk1" runat="server" Text="OK" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                    onmouseout="this.className='btn'" Width="70px" OnClientClick="javascript:return checkForValues();"
                                    OnClick="btnOk1_Click" meta:resourcekey="btnOk1Resource1" />
                                &nbsp;&nbsp;
                                <asp:Button ID="btnCancel1" runat="server" Text="Cancel" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                    onmouseout="this.className='btn'" Width="70px" 
                                    OnClientClick="return Tableclear();" meta:resourcekey="btnCancel1Resource1" />
                            </td>
                        </tr>
                    </table>
                </div>
            </asp:Panel>
            <ajc:ModalPopupExtender ID="mpeOthers" runat="server" BehaviorID="mpeOthersBehavior"
                PopupControlID="pnlOthers" CancelControlID="btnCancel1" TargetControlID="btnfamilytree"
                DynamicServicePath="" Enabled="True">
            </ajc:ModalPopupExtender>
            <input type="button" id="btnfamilytree" runat="server" style="display: none;" />
        </div>
    </ContentTemplate>
</asp:UpdatePanel>

<script type="text/javascript" language="javascript">
    function IAmSelected1(source, eventArgs) {
        document.getElementById('<%=hdnPatientDetails.ClientID %>').value = eventArgs.get_value();
        var hdnPatientDetails = document.getElementById('<%=hdnPatientDetails.ClientID %>').value.split('~');
        document.getElementById('<%=hdnExternalName.ClientID %>').value = hdnPatientDetails[0];
        document.getElementById('<%=hdnExternalID.ClientID %>').value = hdnPatientDetails[1];
        document.getElementById('<%=hdnExternalPatientID.ClientID %>').value = hdnPatientDetails[2];
        document.getElementById('<%=hdnPatientDetails.ClientID %>').value = '';
    }
    function IAmSelected2(source, eventArgs) {
        document.getElementById('<%=hdnPatient1Details.ClientID %>').value = eventArgs.get_value();
        var hdnPatient1Details = document.getElementById('<%=hdnPatient1Details.ClientID %>').value.split('~');
        document.getElementById('<%=hdnDependentsName.ClientID %>').value = hdnPatient1Details[0];
        document.getElementById('<%=hdnDependentsID.ClientID %>').value = hdnPatient1Details[1];
        document.getElementById('<%=hdnDependentsPatientID.ClientID %>').value = hdnPatient1Details[2];
        document.getElementById('<%=hdnpatientcount.ClientID %>').value = hdnPatient1Details[3];
        document.getElementById('<%=hdnPatient1Details.ClientID %>').value = '';

    }
    function ControlValidation1() {
        var retval = Validation();
        if (retval != false) {
            CmdAdd_onclick1(retval);
        }
    }
    function Validation() {
        var vPEId = SListForAppMsg.Get('CommonControls_EmployerRegDetail_ascx_03') == null ? "Provide the External patient number ID" : SListForAppMsg.Get('CommonControls_EmployerRegDetail_ascx_03');
        var vPDepNo = SListForAppMsg.Get('CommonControls_EmployerRegDetail_ascx_04') == null ? "Provide the Dependents number" : SListForAppMsg.Get('CommonControls_EmployerRegDetail_ascx_04');
        var vPRelationType = SListForAppMsg.Get('CommonControls_EmployerRegDetail_ascx_05') == null ? "Provide the relation Type" : SListForAppMsg.Get('CommonControls_EmployerRegDetail_ascx_05');
        var vExNotAdd = SListForAppMsg.Get('CommonControls_EmployerRegDetail_ascx_06') == null ? "External to external not add" : SListForAppMsg.Get('CommonControls_EmployerRegDetail_ascx_06');
    
        if (document.getElementById('<%=txtExternal.ClientID %>').value == '') {
            var userMsg = SListForApplicationMessages.Get('CommonControls\\EmployerRegDetail.ascx_2');
            if (userMsg != null) {
                alert(userMsg);
            } else {
            // alert('Provide the External patient number ID');
            ValidationWindow(vPEId, AlertType);
            }
            document.getElementById('<%=txtExternal.ClientID %>').focus();
            return false;
        }
        if (document.getElementById('<%=txtDependents.ClientID %>').value == '') {
            var userMsg = SListForApplicationMessages.Get('CommonControls\\EmployerRegDetail.ascx_3');
            if (userMsg != null) {
                alert(userMsg);
            } else {
            //alert('Provide the Dependents number');
            ValidationWindow(vPDepNo, AlertType);
            }
            document.getElementById('<%=txtDependents.ClientID %>').focus();
            return false;
        }
        if (document.getElementById('<%=ddlRelation1.ClientID %>').value == '---Select---' || document.getElementById('<%=ddlRelation1.ClientID %>').value == '') {
            var userMsg = SListForApplicationMessages.Get('CommonControls\\EmployerRegDetail.ascx_4');
            if (userMsg != null) {
                alert(userMsg);
            } else {
            // alert('Provide the relation Type');
            ValidationWindow(vPRelationType, AlertType);
            }
            document.getElementById('<%=ddlRelation1.ClientID %>').focus();
            return false;
        }
        if (Number(document.getElementById('<%=hdnpatientcount.ClientID %>').value) > 1) {
            var userMsg = SListForApplicationMessages.Get('CommonControls\\EmployerRegDetail.ascx_5');
            if (userMsg != null) {
                alert(userMsg);
            } else {
            ValidationWindow(vExNotAdd, AlertType);
            
                //alert('External to external not add');
            }
            document.getElementById('<%=txtDependents.ClientID %>').value = ''
            document.getElementById('<%=txtDependents.ClientID %>').focus();
            return false;
        }


        var ExternalName = document.getElementById('<%=hdnExternalName.ClientID %>').value;
        var ExternalID = document.getElementById('<%=hdnExternalID.ClientID %>').value;
        var ExternalPatientID = document.getElementById('<%=hdnExternalPatientID.ClientID %>').value;
        var DependentsName = document.getElementById('<%=hdnDependentsName.ClientID %>').value;
        var DependentsID = document.getElementById('<%=hdnDependentsID.ClientID %>').value;
        var DependentsPatientID = document.getElementById('<%=hdnDependentsPatientID.ClientID %>').value;
        var ddlDepententsType = document.getElementById('<%=ddlRelation1.ClientID %>');
        var RelationType = ddlDepententsType.options[ddlDepententsType.selectedIndex].value;
        var retval = ExternalName + "~" + ExternalID + "~" + ExternalPatientID + "~" + DependentsName + "~" + DependentsID + "~" + DependentsPatientID + "~" + RelationType;
        return retval;
    }
    function CmdAdd_onclick1(gotValue) {
      //  var vProvideName = SListForAppMsg.Get('CommonControls_EmployerRegDetail_ascx_07') == null ? "External Name already exists! Do you want to continue" : SListForAppMsg.Get('CommonControls_EmployerRegDetail_ascx_07');
    
        var ViewStateValue = document.getElementById('<%=hdnpatient.ClientID %>').value;
        var arrayGotValue = new Array();
        arrayGotValue = gotValue.split('~');
        var ExternalName, ExternalID, ExternalPatientID, DependentsName, DependentsID, DependentsPatientID, RelationType;
        if (arrayGotValue.length > 0) {
            ExternalName = arrayGotValue[0];
            ExternalID = arrayGotValue[1];
            ExternalPatientID = arrayGotValue[2];
            DependentsName = arrayGotValue[3];
            DependentsID = arrayGotValue[4];
            DependentsPatientID = arrayGotValue[5];
            RelationType = arrayGotValue[6];
        }
        var arrayAlreadyPresentDatas = new Array();
        var iAlreadyPresent = 0;
        var iCount = 0;

        var arrayAlreadyPresentDatasRepeat = new Array();
        var iAlreadyPresentRepeat = 0;
        var iCountRepeat = 0;

        var tempDatas1 = document.getElementById('<%=hdnpatient.ClientID %>').value;
        arrayAlreadyPresentDatasRepeat = tempDatas1.split('~');
        for (var j = 0; j < arrayAlreadyPresentDatasRepeat.length; j++) {
            if (arrayAlreadyPresentDatasRepeat[j].split('^')[0] == 'ExternalID') {
                var arraydrugs = arrayAlreadyPresentDatasRepeat[j].split('^')[1];
                if (arraydrugs.length > 0) {
                    if (arraydrugs.toLowerCase() == (DrugName.toLowerCase())) {
                        iAlreadyPresentRepeat++;
                    }
                }
            }
        }
        if (iAlreadyPresentRepeat == 0) {
            tempDatas1 += ExternalID;
            document.getElementById('<%=hdnpatient.ClientID %>').value = tempDatas1;
            ViewStateValue += "EXTERNAME^" + ExternalName + "~EXTERNALID^" + ExternalID + "~EXTERNALPATIENTID^" + ExternalPatientID + "~DEPENDENTSNAME^" + DependentsName + "~DEPENTENTDID^" + DependentsID + "~DEPENTENTSPATIENTID^" + DependentsPatientID + "~RELATIONTYPE^" + RelationType + "|";
            document.getElementById('<%=hdnpatient.ClientID %>').value = ViewStateValue;
            CreateJavaScriptTables1();
            Controlclear();
        }
        else {

            var i;
            i = confirm("External Name already exists! Do you want to continue ");
            if (i == true) {
                document.getElementById('<%=hdnpatient.ClientID %>').value = tempDatas1;
                document.getElementById('<%=hdnpatient.ClientID %>').value = tempDatas1;
                ViewStateValue += "EXTERNAME^" + ExternalName + "~EXTERNALID^" + ExternalID + "~EXTERNALPATIENTID^" + ExternalPatientID + "~DEPENDENTSNAME^" + DependentsName + "~DEPENTENTDID^" + DependentsID + "~DEPENTENTSPATIENTID^" + DependentsPatientID + "~RELATIONTYPE^" + RelationType + "|";
                document.getElementById('<%=hdnpatient.ClientID %>').value = ViewStateValue;
                CreateJavaScriptTables1();
                Controlclear();
                return true;
            }
            else {
                Controlclear();
                return false;
            }
        }
    }
    function CreateJavaScriptTables1() {
        if (document.getElementById('<%=hdnpatient.ClientID %>').value != '') {
            document.getElementById('<%=dvTable.ClientID %>').innerHTML = "";
            var newTable, startTag, endTag;
            var ViewStateValue = document.getElementById('<%=hdnpatient.ClientID %>').value;
            startTag = "<br/><TABLE ID='tabDrg1' align='center' WIDTH='100%' Cellpadding='4' Cellspacing='0' Border='1px' style='BackgroundColor:#ff6600;border-collapse:collapse;' >" +
                "<tr style='height:20px;background-color:#2c88b1'>" +
                "<td style='width:20px;'>"+"<%=Resources.ClientSideDisplayTexts.CommonControls_EmployerRegDetail_Select %>"+"</td>" +
                "<td style='width:200px;'>"+"<%=Resources.ClientSideDisplayTexts.CommonControls_EmployerRegDetail_ExternalName %>"+"</td>" +
                "<td style='width:120px;'>"+"<%=Resources.ClientSideDisplayTexts.CommonControls_EmployerRegDetail_ExternalNumber %>"+"</td>" +
                " <td style='width:200px;'>"+"<%=Resources.ClientSideDisplayTexts.CommonControls_EmployerRegDetail_DependentsName %>"+"</Label></td>" +
                "<td style='width:120px;'>"+"<%=Resources.ClientSideDisplayTexts.CommonControls_EmployerRegDetail_DependentsNumber %>"+"</Label></td>" +
                "<td >"+"<%=Resources.ClientSideDisplayTexts.CommonControls_EmployerRegDetail_RelationType %>"+"</Label></td>" +
                "<td style='width:120px;' >"+"<%=Resources.ClientSideDisplayTexts.CommonControls_EmployerRegDetail_Action %>"+"</Label></td>" +
                "</tr>";
            endTag = "</TABLE>";
            newTable = startTag;

            var arrayMainData = new Array();
            var arraySubData = new Array();
            var arrayChildData = new Array();
            var iarrayMainDataCount = 0;
            var iarraySubDataCount = 0;

            arrayMainData = ViewStateValue.split('|');
            if (arrayMainData.length > 0) {
                for (iarrayMainDataCount = 0; iarrayMainDataCount < arrayMainData.length - 1; iarrayMainDataCount++) {

                    arraySubData = arrayMainData[iarrayMainDataCount].split('~');
                    for (iarraySubDataCount = 0; iarraySubDataCount < arraySubData.length; iarraySubDataCount++) {
                        arrayChildData = arraySubData[iarraySubDataCount].split('^');
                        if (arrayChildData.length > 0) {
                            if (arrayChildData[0] == "EXTERNAME") {
                                ExternalName = arrayChildData[1];
                            }
                            if (arrayChildData[0] == "EXTERNALID") {
                                ExternalID = arrayChildData[1];
                            }
                            if (arrayChildData[0] == "EXTERNALPATIENTID") {
                                ExternalPatientID = arrayChildData[1];
                            }
                            if (arrayChildData[0] == "DEPENDENTSNAME") {
                                DependentsName = arrayChildData[1];
                            }
                            if (arrayChildData[0] == "DEPENTENTDID") {
                                DependentsID = arrayChildData[1];
                            }
                            if (arrayChildData[0] == "DEPENTENTSPATIENTID") {
                                DependentsPatientID = arrayChildData[1];
                            }
                            if (arrayChildData[0] == "RELATIONTYPE") {
                                RelationType = arrayChildData[1];
                            }
                        }
                    }
                    var chkBoxName = "EXTERNAME^" + ExternalName + "~EXTERNALID^" + ExternalID + "~EXTERNALPATIENTID^" + ExternalPatientID + "~DEPENDENTSNAME^" + DependentsName + "~DEPENTENTDID^" + DependentsID + "~DEPENTENTSPATIENTID^" + DependentsPatientID + "~RELATIONTYPE^" + RelationType + "";
                    var ReturnYesOrNo = DeletedValueCheck(chkBoxName);
                    if (ReturnYesOrNo == "Yes") {
                        newTable += "<TR><TD><input name='EXTERNAME^" + ExternalName + "~EXTERNALID^" + ExternalID + "~EXTERNALPATIENTID^" + ExternalPatientID + "~DEPENDENTSNAME^" + DependentsName + "~DEPENTENTDID^" + DependentsID + "~DEPENTENTSPATIENTID^" + DependentsPatientID + "~RELATIONTYPE^" + RelationType + "' onclick='chkUnCheck(name);'  type='checkbox' /> "
                    + "</TD><TD style=\"WIDTH: 120px\" nowrap='nowrap'>" + ExternalName + "</TD>";
                    }
                    else {
                        newTable += "<TR><TD><input name='EXTERNAME^" + ExternalName + "~EXTERNALID^" + ExternalID + "~EXTERNALPATIENTID^" + ExternalPatientID + "~DEPENDENTSNAME^" + DependentsName + "~DEPENTENTDID^" + DependentsID + "~DEPENTENTSPATIENTID^" + DependentsPatientID + "~RELATIONTYPE^" + RelationType + "' onclick='chkUnCheck(name);'  type='checkbox' checked='checked' />"
                    + "</TD><TD style=\"WIDTH: 120px\" nowrap='nowrap'>" + ExternalName + "</TD>";
                    }
                    newTable += "<TD style=\"WIDTH: 120px\" nowrap='nowrap'>" + ExternalID + "</TD>";
                    newTable += "<TD style=\"WIDTH: 120px\" nowrap='nowrap'>" + DependentsName + "</TD>";
                    newTable += "<TD style=\"WIDTH: 120px\" nowrap='nowrap'>" + DependentsID + "</TD>";
                    newTable += "<TD style=\"WIDTH: 120px\" nowrap='nowrap'>" + RelationType + "</TD>";
                    newTable += "<TD><input name='EXTERNAME^" + ExternalName + "~EXTERNALID^" + ExternalID + "~EXTERNALPATIENTID^" + ExternalPatientID + "~DEPENDENTSNAME^" + DependentsName + "~DEPENTENTDID^" + DependentsID + "~DEPENTENTSPATIENTID^" + DependentsPatientID + "~RELATIONTYPE^" + RelationType + "' onclick='btnEdit_OnClick1(name);' value = '<%=Resources.ClientSideDisplayTexts.CommonControls_EmployerRegDetail_Edit %>' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'  /></TD>" + "<TR>";
                }
            }

            newTable += endTag;
            document.getElementById('<%=dvTable.ClientID %>').innerHTML += newTable;

        }

    }
    function Controlclear() {
        //document.getElementById('txtExternal').value = '';
        document.getElementById('<%=txtExternal.ClientID %>').disabled = false
        document.getElementById('<%=txtDependents.ClientID %>').value = '';
        document.getElementById('<%=ddlRelation1.ClientID %>').value = 0;
    }
    function Tableclear() {
        document.getElementById('<%=hdnpatient.ClientID %>').value = '';
        var table = document.getElementById('tabDrg1');
        if (table != null) {
            var rowCount = table.rows.length;
            for (var i = 0; i < rowCount; i++) {
                var row = table.rows[i];
                table.deleteRow(i);
                rowCount--;
                i--;
            }
        }
        CreateJavaScriptTables1()
    }
    function chkUnCheck(DataValue) {
        var arrayAlreadyPresentDatas = new Array();
        var iAlreadyPresent = 0;
        var iCount = 0;
        var tempDatas = document.getElementById('<%=hdnDeleted.ClientID %>').value;
        var boolAlreadyPresent = false;
        arrayAlreadyPresentDatas = tempDatas.split('|');
        if (arrayAlreadyPresentDatas.length > 0) {
            for (iCount = 0; iCount < arrayAlreadyPresentDatas.length; iCount++) {
                if (arrayAlreadyPresentDatas[iCount].toLowerCase() == DataValue.toLowerCase()) {
                    arrayAlreadyPresentDatas[iCount] = "";
                    boolAlreadyPresent = true;
                }
            }
        }
        tempDatas = "";
        for (iCount = 0; iCount < arrayAlreadyPresentDatas.length; iCount++) {
            if (arrayAlreadyPresentDatas[iCount] != "") {
                tempDatas += arrayAlreadyPresentDatas[iCount] + "|";
            }
        }
        if (boolAlreadyPresent == false) {
            tempDatas += DataValue + "|";
        }

        document.getElementById('<%=hdnDeleted.ClientID %>').value = tempDatas;
    }
    function DeletedValueCheck(DataValue) {
        var arrayAlreadyPresentDatas = new Array();
        var iAlreadyPresent = 0;
        var iCount = 0;
        var tempDatas = document.getElementById('<%=hdnDeleted.ClientID %>').value;
        var retValueAlreadyPresent = "No";

        arrayAlreadyPresentDatas = tempDatas.split('|');
        if (arrayAlreadyPresentDatas.length > 0) {
            for (iCount = 0; iCount < arrayAlreadyPresentDatas.length; iCount++) {
                if (arrayAlreadyPresentDatas[iCount].toLowerCase() == DataValue.toLowerCase()) {
                    retValueAlreadyPresent = "Yes";
                }
            }
        }
        return retValueAlreadyPresent;
    }
    function btnEdit_OnClick1(sEditedData) {

        var arrayAlreadyPresentDatas = new Array();
        var iAlreadyPresent = 0;
        var iCount = 0;
        var tempDatas = document.getElementById('<%=hdnpatient.ClientID %>').value;
        arrayAlreadyPresentDatas = tempDatas.split('|');
        if (arrayAlreadyPresentDatas.length > 0) {
            for (iCount = 0; iCount < arrayAlreadyPresentDatas.length; iCount++) {
                if (arrayAlreadyPresentDatas[iCount].toLowerCase() == sEditedData.toLowerCase()) {
                    arrayAlreadyPresentDatas[iCount] = "";
                }

            }
        }

        tempDatas = "";
        for (iCount = 0; iCount < arrayAlreadyPresentDatas.length; iCount++) {
            if (arrayAlreadyPresentDatas[iCount] != "") {
                tempDatas += arrayAlreadyPresentDatas[iCount] + "|";
            }
        }

        var arrayGotValue = new Array();
        var arrayExternalName = new Array();
        var arrayExternalID = new Array();
        var arrayExternalPatientID = new Array();
        var arrayDependentsName = new Array();
        var arrayDependentsID = new Array();
        var arrayDependentsPatientID = new Array();
        var arrayDurationDaysCount = new Array();
        var arrayRelationType = new Array();
        arrayGotValue = sEditedData.split('~');

        var ExternalName, ExternalID, ExternalPatientID, DependentsName, DependentsID, DependentsPatientID, RelationType;


        if (arrayGotValue.length > 0) {
            ExternalName = arrayGotValue[0];
            ExternalID = arrayGotValue[1];
            ExternalPatientID = arrayGotValue[2];
            DependentsName = arrayGotValue[3];
            DependentsID = arrayGotValue[4];
            DependentsPatientID = arrayGotValue[5];
            RelationType = arrayGotValue[6];

            arrayExternalName = ExternalName.split('^');
            arrayExternalID = ExternalID.split('^');
            arrayExternalPatientID = ExternalPatientID.split('^');
            arrayDependentsName = DependentsName.split('^');
            arrayDependentsID = DependentsID.split('^');
            arrayDependentsPatientID = DependentsPatientID.split('^');
            arrayRelationType = RelationType.split('^');



        }

        if (arrayExternalName.length > 0) {
            document.getElementById('<%=txtExternal.ClientID %>').value = arrayExternalName[1];
        }

        if (arrayDependentsName.length > 0) {
            document.getElementById('<%=txtDependents.ClientID %>').value = arrayDependentsName[1];
        }

        if (arrayRelationType.length > 0) {
            document.getElementById('<%=ddlRelation1.ClientID %>').value = arrayRelationType[1];
        }

        document.getElementById('<%=hdnpatient.ClientID %>').value = tempDatas;
        // Delete datas from Drugname Exists Field
        var tempDatas = document.getElementById('<%= hdnNameExists.ClientID %>').value;
        arrayAlreadyPresentDatas = null;
        arrayAlreadyPresentDatas = tempDatas.split('|');
        if (arrayAlreadyPresentDatas.length > 0) {
            for (iCount = 0; iCount < arrayAlreadyPresentDatas.length; iCount++) {

                if (arrayAlreadyPresentDatas[iCount].toLowerCase() == (arrayExternalName[1].toLowerCase())) {
                    arrayAlreadyPresentDatas[iCount] = "";
                }
            }
        }
        tempDatas = "";
        for (iCount = 0; iCount < arrayAlreadyPresentDatas.length; iCount++) {
            if (arrayAlreadyPresentDatas[iCount] != "") {
                tempDatas += arrayAlreadyPresentDatas[iCount] + "|";
            }
        }
        document.getElementById('<%= hdnNameExists.ClientID %>').value = tempDatas;
    }
    function checkForValues() {

        var vAssDepExtP = SListForAppMsg.Get('CommonControls_EmployerRegDetail_ascx_07') == null ? "Please associate dependents for External Patient" : SListForAppMsg.Get('CommonControls_EmployerRegDetail_ascx_07');
    
        if (document.getElementById('<%=dvTable.ClientID %>').innerHTML == '') {
            var userMsg = SListForApplicationMessages.Get('CommonControls\\EmployerRegDetail.ascx_6');
            if (userMsg != null) {
                alert(userMsg);
            } else {
            //alert('Please associate dependents for External Patient');
            ValidationWindow(vAssDepExtP, AlertType);
            }
            document.getElementById('<%=dvTable.ClientID %>').value = '';
            document.getElementById('<%=txtExternal.ClientID %>').focus();
            return false;
        }
    }
    function FnIsvalid1(obj) {
        var vSucee = SListForAppMsg.Get('CommonControls_EmployerRegDetail_ascx_08') == null ? "Update Successfully" : SListForAppMsg.Get('CommonControls_EmployerRegDetail_ascx_08');
        var vFaild = SListForAppMsg.Get('CommonControls_EmployerRegDetail_ascx_09') == null ? "Update Faild." : SListForAppMsg.Get('CommonControls_EmployerRegDetail_ascx_09');
    
        if (obj = 1) {
            var userMsg = SListForApplicationMessages.Get('CommonControls\\EmployerRegDetail.ascx_7');
            if (userMsg != null) {
                alert(userMsg);
            } else {
            //alert("Update Successfully");
            ValidationWindow(vSucee, AlertType);
            }
            Tableclear();

        }
        else {
            var userMsg = SListForApplicationMessages.Get('CommonControls\\EmployerRegDetail.ascx_8');
            if (userMsg != null) {
                alert(userMsg);
            } else {
               // alert("Update Faild.");
            ValidationWindow(vFaild, AlertType);
            }
            return false;
        }

    }
    function checsameNo() {
        var vExtDepPsame = SListForAppMsg.Get('CommonControls_EmployerRegDetail_ascx_10') == null ? "External and dependents patient name is same" : SListForAppMsg.Get('CommonControls_EmployerRegDetail_ascx_10');
    
    
        if (document.getElementById('<%=txtExternal.ClientID %>').value == document.getElementById('<%=txtDependents.ClientID %>').value) {
            var userMsg = SListForApplicationMessages.Get('CommonControls\\EmployerRegDetail.ascx_9');
            if (userMsg != null) {
                alert(userMsg);
            } else {
            //alert("External and dependents patient name is same");
            ValidationWindow(vExtDepPsame, AlertType);
            }
            document.getElementById('<%=txtDependents.ClientID %>').value = '';
            return false;
        }
    }
</script>

<script type="text/javascript" language="javascript">
    function showModalPopup(evt, footDescID, footAmtID) {
        document.getElementById('<%= pnlOthers.ClientID %>').style.display = "none";
        var modalPopupBehavior = $find('mpeOthersBehavior');
        modalPopupBehavior.show();
        document.getElementById('<%=txtExternal.ClientID %>').focus();
    }
    function checkemployeeNo() {
        var txtbox = document.getElementById('<%=txtEmployementTypeNo.ClientID %>').value;
        document.getElementById('<%=txtEmployementTypeNo.ClientID %>').value = txtbox.trim();
        document.getElementById('<%=btnCheckNo.ClientID %>').click();
    }
    function checkemployeeNo1() {
        var txtbox = document.getElementById('<%=txtEmployerID.ClientID %>').value;
        document.getElementById('<%=txtEmployerID.ClientID %>').value = txtbox.trim();
        if (document.getElementById('<%=ddlExtended.ClientID %>').value > 0) {
            document.getElementById('<%=btnCheckNo1.ClientID %>').click();
        }
    }
    function CheckEmployeeNumber(objID) {
        var vEmpAlreadyNo = SListForAppMsg.Get('CommonControls_EmployerRegDetail_ascx_11') == null ? "Employee number already exists. Please re-enter" : SListForAppMsg.Get('CommonControls_EmployerRegDetail_ascx_11');
    
        if (objID > 0) {
            if (document.getElementById('hdnInsertorUpdate').value == "1") {
                var userMsg = SListForApplicationMessages.Get('CommonControls\\EmployerRegDetail.ascx_10');
                if (userMsg != null) {
                    alert(userMsg);
                } else {
                // alert('Employee number already exists. Please re-enter');
                ValidationWindow(vEmpAlreadyNo, AlertType);
                }
                document.getElementById('<%=txtEmployementTypeNo.ClientID %>').value = '';
                document.getElementById('<%=txtEmployementTypeNo.ClientID %>').focus();
                document.getElementById('<%=ddlEmployerName.ClientID %>').selectedIndex = 0;
                return false;
            }
            else {
                var userMsg = SListForApplicationMessages.Get('CommonControls\\EmployerRegDetail.ascx_10');
                if (userMsg != null) {
                    alert(userMsg);
                } else {
                // alert('Employee number already exists. Please re-enter');
                ValidationWindow(vEmpAlreadyNo, AlertType);
                }
                //document.getElementById('<%=txtEmployementTypeNo.ClientID %>').value = '';
                //document.getElementById('<%=txtEmployementTypeNo.ClientID %>').focus();
                return false;
            }
        }

    }
    function CheckExtentedNumber(objID) {
        var vEmpAlreadyNo = SListForAppMsg.Get('CommonControls_EmployerRegDetail_ascx_11') == null ? "Employee number already exists. Please re-enter" : SListForAppMsg.Get('CommonControls_EmployerRegDetail_ascx_11');
    
        if (objID > 0) {
            if (document.getElementById('hdnInsertorUpdate').value == "1") {
                var userMsg = SListForApplicationMessages.Get('CommonControls\\EmployerRegDetail.ascx_12');
                if (userMsg != null) {
                    alert(userMsg);
                } else {
                //alert('Extented number already exists. Please re-enter');
                ValidationWindow(vEmpAlreadyNo, AlertType);
                }
                document.getElementById('<%=txtEmployerID.ClientID %>').value = '';
                document.getElementById('<%=txtEmployerID.ClientID %>').focus();
                document.getElementById('<%=ddlExtended.ClientID %>').selectedIndex = 0;
                return false;
            }
            else {
                var userMsg = SListForApplicationMessages.Get('CommonControls\\EmployerRegDetail.ascx_12');
                if (userMsg != null) {
                    alert(userMsg);
                } else {
                //alert('Extented number already exists. Please re-enter');
                ValidationWindow(vEmpAlreadyNo, AlertType);
                }
                //document.getElementById('<%=txtEmployementTypeNo.ClientID %>').value = '';
                //document.getElementById('<%=txtEmployementTypeNo.ClientID %>').focus();
                return false;
            }
        }

    }
    function EmployementType() {
        if (document.getElementById('<%=ddlEmployementType.ClientID %>').value == '2') {
            document.getElementById('<%=txtEmployementTypeNo.ClientID %>').value = document.getElementById('<%=hdnEmployeeNo.ClientID %>').value;
        }
        else {
            document.getElementById('<%=txtEmployementTypeNo.ClientID %>').value = '';
        }
    }
    function IAmSelected(source, eventArgs) {
        document.getElementById('<%=hdnEmployeeDetails.ClientID %>').value = eventArgs.get_value();
        Tblist();

    }
    function ClearItemIlst() {
        if (document.getElementById('<%=TextBoxURN.ClientID %>').value.length <= 0) {
            document.getElementById("showimage").style.display = "none";
            document.getElementById('<%=lblEmpadnotherDetails.ClientID %>').innerHTML = "";
        }
        if (document.getElementById('<%=TextBoxURN.ClientID %>').value == '') {
            document.getElementById('<%=ddlPatientType.ClientID %>').value = "---Select---";
            ShowPatientType();
            document.getElementById("txtAddress").value = '';
            document.getElementById("txtCity").value = '';

            document.getElementById("txtMobile").value = '';
            document.getElementById("txtLandLine").value = '';
            document.getElementById("txtFileNo").value = ''
            document.getElementById('<%=txtEmployementTypeNo.ClientID %>').value = '';
        }

    }
    function Tblist() {
        var table = '';
        var tr = '';
        var end = '</table>';
        var y = '';
        document.getElementById('<%=lblEmpadnotherDetails.ClientID %>').innerHTML = '';
        table = "<table cellpadding='1' class='dataheaderInvCtrl' cellspacing='0' border='1'"
                           + "style='width:100%'><thead  align='Left' class='dataheader1' style='font-size:11px'>"
                           + "<th style='width:250px;'>"+"<%=Resources.ClientSideDisplayTexts.CommonControls_EmployerRegDetail_Name %>"+"</th>"
                           + "<th style='width:100px;'>"+"<%=Resources.ClientSideDisplayTexts.CommonControls_EmployerRegDetail_Number %>"+"</th>"
                           + "<th style='width:100px;'>"+"<%=Resources.ClientSideDisplayTexts.CommonControls_EmployerRegDetail_Number %>"+"</th>"
                           + "<th style='width:150px;'>"+"<%=Resources.ClientSideDisplayTexts.CommonControls_EmployerRegDetail_Action %>"+"</th> </thead>";
        var x = document.getElementById('<%=hdnEmployeeDetails.ClientID %>').value.split("^");
        var Tname;
        //var temp = x[1].split('^');
        for (i = 0; i < x.length - 1; i++) {
            if (x[i] != "") {
                var y = x[i].split('~');
                if (y[22] > 0) {
                    Tname = "<input name='" + y[2] + "~" + y[3] + "~" + y[9] + "~" + y[19] + "~" + y[25] + "~" + y[22] + "~" + y[28] + "' onclick='CreateEmpVisit(name);' value = '<%=Resources.ClientSideDisplayTexts.CommonControls_EmployerRegDetail_MakeVisit %>' type='button' style='font-size:10px;background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'  />";
                }
                else {
                    Tname = "";
                }
                tr += "<tr style='font-size:10px;height:10px' align='Left'><td style='width:250px;'>"
                        + y[0] + "</td><td style='width:100px;'>"
                        + y[25] + "</td><td style='width:100px;'>"
                        + y[19] + "</td><td style='width:150px;'>"
                        + "<input name='" + y[0] + "~" + y[1] + "~" + y[2] + "~" + y[3] + "~" + y[4] + "~" + y[5] + "~" + y[6] + "~" + y[7] + "~" + y[8] +
                                                 "~" + y[9] + "~" + y[10] + "~" + y[11] + "~" + y[12] + "~" + y[13] + "~" + y[14] + "~" + y[15] + "~" + y[16] +
                                                  "~" + y[17] + "~" + y[18] + "~" + y[19] + "~" + y[20] + "~" + y[21] + "~" + y[22] + "~" + y[23] + "~" + y[24] + "~" + y[25] + "~" + y[26] + "~" + y[27] + "~" + y[28] + "~" + y[29] +
                                                 "' onclick='btnEdit_OnClick(name);' value = '<%=Resources.ClientSideDisplayTexts.CommonControls_EmployerRegDetail_Select_1 %>' type='button' style='font-size:10px;background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'  />"
                        + "" + Tname + "</td></tr>";

            }
        }
        var tab = table + tr + end;
        document.getElementById('<%=lblEmpadnotherDetails.ClientID %>').innerHTML = tab;
        tbshow();
    }


    function btnEdit_OnClick(sEditedData) {
        var vInvRegPaAlredy = SListForAppMsg.Get('CommonControls_EmployerRegDetail_ascx_12') == null ? "Selected individual is already registered as patient. Please proceed to Make Visit" : SListForAppMsg.Get('CommonControls_EmployerRegDetail_ascx_12');
    
        var split = sEditedData.split('~');
        var cnt = split.length;
        if (cnt > 1) {
            var EmpName = split[0];
            var EmpNO = split[1]
            var Sex = split[2];
            var Marital = split[3];
            var State = split[4];
            var Country = split[5];
            var City = split[6];
            var MoblieNo = split[7];
            var LandlineNo = split[8];
            var DOB = split[9];
            var Qln = split[10];
            var Doj = split[11];
            var Add = split[12];
            var GradeID = split[13];
            var EmployementTypeID = split[14];
            var DeptID = split[15];
            var DesignationID = split[16];
            var EmployerLocationID = split[17];
            var EmployerID = split[18];
            var EmployeeType = split[19];
            var FileNo = split[20];
            var PictureName = split[21];
            var PID = split[22];
            var PNO = split[23];
            var TypeID = split[24];
            var EmptypeNO = split[25];
            var TitleCode = split[26];
            var Bloodgroup = split[27];
            var Status = split[28];
            var EmpID = split[29];
            document.getElementById('<%=ddlPatientType.ClientID %>').value = TypeID;
            ShowPatientType();
            document.getElementById('<%=ddlEmployementType.ClientID %>').selectedIndex = EmployementTypeID;
            document.getElementById('<%=txtEmployementTypeNo.ClientID %>').value = EmpNO;
            document.getElementById('<%=txtExternalnumber.ClientID %>').value = EmptypeNO;
            document.getElementById('<%=txtEmployerID.ClientID %>').value = EmptypeNO;
            document.getElementById('<%=txtJoinDate.ClientID %>').value = Doj;
            document.getElementById('<%=txtQualification.ClientID %>').value = Qln;
            document.getElementById('<%=ddlDepartment.ClientID %>').selectedIndex = DeptID;
            document.getElementById('<%=ddlDesignation.ClientID %>').value = DesignationID;
            document.getElementById('<%=ddlGrade.ClientID %>').value = GradeID;
            document.getElementById('<%=ddlEmployerName.ClientID %>').value = EmployerID;
            document.getElementById('<%=ddlEmployerLocation.ClientID %>').value = EmployerLocationID;
            document.getElementById('<%=ddlRelation.ClientID %>').value = EmployementTypeID;
            document.getElementById('<%=ddlExtended.ClientID %>').value = EmployementTypeID;
            document.getElementById("txtName").value = EmpName;
            document.getElementById("tDOB").value = DOB
            document.getElementById("ddSex").value = Sex;
            document.getElementById('ddMarital').value = Marital
            document.getElementById("txtAddress").value = Add;
            document.getElementById("txtCity").value = City;
            document.getElementById("ddState").value = 31;

            if (State > 1) {
                document.getElementById("ddState").value = State;
            }
            document.getElementById("ddCountry").value = 75;
            if (Country > 1) {
                document.getElementById("ddCountry").value = Country;
            }
            document.getElementById("txtMobile").value = MoblieNo;
            document.getElementById("txtLandLine").value = LandlineNo;
            document.getElementById("txtFileNo").value = FileNo;
            countAge('tDOB');
            document.getElementById('<%=hdnEmpdetails.ClientID %>').value = '';
            if (PictureName == '') {
                document.getElementById('imgPatient').src = "../Images/ProfileDefault.jpg";
                document.getElementById('divRemovePhoto').style.display = 'none';
                document.getElementById('lblUploadPhoto').innerHTML =slist.Upload;
            }
            else {
                document.getElementById('imgPatient').src = "PatientImageHandler.ashx?FileName=" + PictureName;
                document.getElementById('divRemovePhoto').style.display = 'block';
                document.getElementById('lblUploadPhoto').innerHTML =slist.Update;
            }
            document.getElementById("ddSalutation").value = TitleCode;
            document.getElementById('<%=ddBloodGrp.ClientID %>').value = Bloodgroup;
            document.getElementById('<%=hdnEmpID.ClientID %>').value = EmpID;
            if (Status == 'A' || Status == '') {
                document.getElementById('rblPatientStatus').checked = true;
            }
            else {
                document.getElementById('rblPatientStatus').checked = false;
            }
            var MID;
            if (PID > 0) {
                MID = '1';
                document.getElementById('<%=hdnMID.ClientID %>').value = MID;
                var userMsg = SListForApplicationMessages.Get('CommonControls\\EmployerRegDetail.ascx_15');
                if (userMsg != null) {
                    alert(userMsg);
                } else {
                //  alert('Selected individual is already registered as patient. Please proceed to Make Visit ');
                ValidationWindow(vInvRegPaAlredy, AlertType);
                
                }
            }
            else {
                MID = '0';
                document.getElementById('<%=hdnMID.ClientID %>').value = MID;
            }
            if (MID == '1') {
                if (document.getElementById('<%=ddlPatientType.ClientID %>').value == "1") {
                    document.getElementById('btnFinish').disabled = true;
                }
                else {
                    document.getElementById('btnFinish').disabled = true;
                }
            }
            else {
                document.getElementById('btnFinish').disabled = false;
            }
        }
    }




    var ns4 = document.layers
    var ie4 = document.all
    var ns6 = document.getElementById && !document.all


    var dragswitch = 0
    var nsx
    var nsy
    var nstemp

    function drag_dropns(name) {
        if (!ns4)
            return
        temp = eval(name)
        temp.captureEvents(Event.MOUSEDOWN | Event.MOUSEUP)
        temp.onmousedown = gons
        temp.onmousemove = dragns
        temp.onmouseup = stopns
    }

    function gons(e) {
        temp.captureEvents(Event.MOUSEMOVE)
        nsx = e.x
        nsy = e.y
    }
    function dragns(e) {
        if (dragswitch == 1) {
            temp.moveBy(e.x - nsx, e.y - nsy)
            return false
        }
    }

    function stopns() {
        temp.releaseEvents(Event.MOUSEMOVE)
    }

    //drag drop function for ie4+ and NS6////
    /////////////////////////////////


    function drag_drop(e) {
        if (ie4 && dragapproved) {
            crossobj.style.left = tempx + event.clientX - offsetx
            crossobj.style.top = tempy + event.clientY - offsety
            return false
        }
        else if (ns6 && dragapproved) {
            crossobj.style.left = tempx + e.clientX - offsetx + "px"
            crossobj.style.top = tempy + e.clientY - offsety + "px"
            return false
        }
    }

    function initializedrag(e) {
        crossobj = ns6 ? document.getElementById("showimage") : document.all.showimage
        var firedobj = ns6 ? e.target : event.srcElement
        var topelement = ns6 ? "html" : document.compatMode != "BackCompat" ? "documentElement" : "body"
        while (firedobj.tagName != topelement.toUpperCase() && firedobj.id != "dragbar") {
            firedobj = ns6 ? firedobj.parentNode : firedobj.parentElement
        }

        if (firedobj.id == "dragbar") {
            offsetx = ie4 ? event.clientX : e.clientX
            offsety = ie4 ? event.clientY : e.clientY

            tempx = parseInt(crossobj.style.left)
            tempy = parseInt(crossobj.style.top)

            dragapproved = true
            document.onmousemove = drag_drop
        }
    }

    ////drag drop functions end here//////

    function hidebox() {
        crossobj = ns6 ? document.getElementById("showimage") : document.all.showimage

        crossobj.style.display = "none"

    }
    function tbshow() {
        document.onmouseup = new Function("dragapproved=false")

        document.getElementById("showimage").style.display = "block";
    }
    function Make_OnClick(sEditedData) {
    }
</script>

