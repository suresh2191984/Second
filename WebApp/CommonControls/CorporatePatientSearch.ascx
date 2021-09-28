<%@ Control Language="C#" AutoEventWireup="true" CodeFile="CorporatePatientSearch.ascx.cs"
    Inherits="CommonControls_CorporatePatientSearch" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%--<link rel="stylesheet" type="text/css" href="../StyleSheets/style.css" />--%>
<style type="text/css">
    .divPopup
    {
        display: none;
        z-index: 1000;
        position: absolute;
        background-color: White;
        padding: 2px;
        border: solid 1px black;
    }
</style>
<%--<asp:Panel ID="pnlPSearch" runat="server" DefaultButton="btnSearch">--%>

<script language="javascript" type="text/javascript">
    function SelectRowCommon(rid, patid, Pname, Dob, MStatus, Type, EmpNo,Status) {
        chosen = "";

        var len = document.forms[0].elements.length;
        for (var i = 0; i < len; i++) {
            if (document.forms[0].elements[i].type == "radio") {
                document.forms[0].elements[i].checked = false;
            }
        }
        document.getElementById(rid).checked = true;
        document.getElementById('<%= hdnPatientID.ClientID %>').value = patid;
        document.getElementById('pid').value = patid;
        document.getElementById('<%= hdnTempPatientid.ClientID %>').value = patid;
        document.getElementById('<%= hdnPatientName.ClientID %>').value = Pname;
        document.getElementById('pid').value = patid;
        document.getElementById('<%= hdnTempPatientName.ClientID %>').value = Pname;
        //document.getElementById('<%= patOrgID.ClientID %>').value = POrgID;
        document.getElementById('<%= hdnpDOB.ClientID %>').value = Dob;
        document.getElementById('DOB').value = Dob;
        document.getElementById('<%= hdnpMstatus.ClientID %>').value = MStatus;
        document.getElementById('Mstatus').value = MStatus;
        document.getElementById('<%= hdnpType.ClientID %>').value = Type;
        document.getElementById('Type').value = Type;
        document.getElementById('<%= hdnEmpNo.ClientID %>').value = EmpNo;
        document.getElementById('EmpTypeNo').value = EmpNo;
        document.getElementById('<%= hdnStatus.ClientID %>').value = Status;
        document.getElementById('Status').value = Status;
    }
    function SelectVisit(id, vid, pid, PName, VtP) {

        chosen = "";
        var len = document.forms[0].elements.length;
        for (var i = 0; i < len; i++) {
            if (document.forms[0].elements[i].type == "radio") {
                document.forms[0].elements[i].checked = false;
            }
        }
        document.getElementById(id).checked = true;
        document.getElementById('uctlPatientSearch_' + 'hdnVID').value = vid;
        document.getElementById('uctlPatientSearch_' + 'HdnPID').value = pid;
        document.getElementById('uctlPatientSearch_' + 'hdnPNAME').value = PName;
        document.getElementById('uctlPatientSearch_' + 'hdnVisitPrurporse').value = VtP;
        //        alert(document.getElementById('PID').value);
    }
    function CheckVisitID(DDlID) {

        if (document.getElementById('<%=hdnVID.ClientID %>').value == '') {
            document.getElementById(DDlID).focus();
            var userMsg = SListForApplicationMessages.Get('CommonControls\\CorporatePatientSearch.ascx_1');
            if (userMsg != null) {
                alert(userMsg);
            }
            else { alert('Please Select Visit Detail'); }
            return false;
        }
        else if (document.getElementById(DDlID) != undefined) {
        document.getElementById('<%=hdnVisitDetail.ClientID %>').value = document.getElementById(DDlID)[document.getElementById(DDlID).selectedIndex].value;
            document.getElementById('<%= hdnPathpage.ClientID %>').value = document.getElementById('<%=hdnVisitDetail.ClientID %>').value;
            document.getElementById('<%=hdnRowInx.ClientID %>').value = document.getElementById(DDlID).selectedIndex;
            return true;
        }
    }
    function PathNameName(DDl) {
        var PatheName = document.getElementById('DDl').value;
        document.getElementById('<%= hdnPathpage.ClientID %>').value = PatheName;
    }

    function ShowPicture(id, PictureName) {
        var position = $("#" + id).position();
        $("[id$='imgPopupPatient']").attr('src', '<%=ResolveUrl("~/Reception/PatientImageHandler.ashx?FileName=' + PictureName + '")%>');
        $('#divFullImage').show().css({ left: position.left - 150, top: position.top + 20 });
    }

    function HidePicture() {
        $('#divFullImage').hide();
    }
</script>

<table id="tblHeader" runat="server" width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr>
        <td colspan="4">
            <table border="0" cellpadding="0" cellspacing="2" width="100%" class="dataheader3">
                <tr>
                    <td style="width: 15%">
                        <asp:Label ID="lblEmpNo" runat="server" Text="Employee Number"></asp:Label>
                    </td>
                    <td style="width: 39%">
                        <asp:TextBox ID="txtEmpNo" runat="server" MaxLength="16" onkeypress="return onEnterKeyPress(event);"></asp:TextBox>
                    </td>
                    <td style="width: 20%">
                        <asp:Label ID="EmpName" runat="server" Text="Employee Name"></asp:Label>
                    </td>
                    <td style="width: 28%">
                        <asp:TextBox ID="txtEmployeeName" MaxLength="255" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblEmpAge" runat="server" Text="Employee Age"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtEmpAge" runat="server" MaxLength="3" Width="50px"></asp:TextBox>
                    </td>
                    <td>
                        <asp:Label ID="lblDependent" runat="server" Text="Dependent Type"></asp:Label>
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlPatientType" runat="server">
                            <asp:ListItem Text="---Select---" Value="0"></asp:ListItem>
                            <asp:ListItem Text="Employee" Value="1"></asp:ListItem>
                            <asp:ListItem Text="Dependent" Value="2"></asp:ListItem>
                            <asp:ListItem Text="Extended" Value="3"></asp:ListItem>
                            <asp:ListItem Text="External" Value="4"></asp:ListItem>
                            <%--<asp:ListItem Text="Casuals" Value="5"></asp:ListItem>--%>
                        </asp:DropDownList>
                        <%--<asp:TextBox ID="txtDependent" runat="server" MaxLength="50"></asp:TextBox>--%>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblEmployername" Text="Employer Name" runat=server></asp:Label>
                    </td>
                     <td>
                     <asp:DropDownList ID="ddlEmployerName" runat="server"></asp:DropDownList>
                    </td>
                     <td>
                    </td>
                     <td>
                    </td>
                </tr>
                <tr>
                    <td colspan="4" align="center" nowrap="nowrap">
                        <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn1" onmouseover="this.className='btn1 btnhov1'"
                            onmouseout="this.className='btn1'" OnClick="btnSearch_Click" />
                        &nbsp;
                        <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn1" onmouseover="this.className='btn1 btnhov1'"
                            onmouseout="this.className='btn1'" OnClick="btnCancel_Click" />
                    </td>
                </tr>
            </table>
            <table border="0" id="GrdHeader" runat="server" style="display: block" width="100%">
                <tr class="dataheader1">
                    <td align="left" style="width: 3%">
                        <asp:Label ID="Rs_Select" runat="server" Text="Select"></asp:Label>
                    </td>
                    <td align="left" style="display: none; width: 10%">
                        <asp:Label ID="Rs_PatientNo1" runat="server" Text="Patient No."></asp:Label>
                        <asp:HiddenField ID="HdnID" runat="server" />
                        <asp:HiddenField ID="HdnPID" runat="server" />
                        <asp:HiddenField ID="hdnVisitDetail" runat="server" />
                        <asp:HiddenField ID="hdnVID" runat="server" />
                        <asp:HiddenField ID="HiddenField1" runat="server" />
                        <asp:HiddenField ID="hdnPNAME" runat="server" />
                        <asp:HiddenField ID="hdnPathpage" runat="server" />
                        <asp:HiddenField ID="hdnVisitPrurporse" runat="server" />
                    </td>
                    <td style="width: 25%">
                        <asp:Label ID="Rs_name" runat="server" Text="Name"></asp:Label>
                    </td>
                    <td style="width: 8%">
                        <asp:Label ID="Rs_Empno" runat="server" Text="Employee No."></asp:Label>
                    </td>
                    <td style="width: 11%">
                        <asp:Label ID="Label1" runat="server" Text="Employer Name"></asp:Label>
                    </td>
                    <td style="width: 10%">
                        <asp:Label ID="lbl_RelationName" runat="server" Text="Relation Name"></asp:Label>
                    </td>
                    <td style="width: 8%">
                        <asp:Label ID="Rs_Age" runat="server" Text="Age"></asp:Label>
                    </td>
                    <td align="center" style="width: 15%">
                        <asp:Label ID="Rs_MobileNumber" runat="server" Text="Mobile Number"></asp:Label>
                    </td>
                    <td style="width: 18%">
                        <asp:Label ID="Rs_Address" runat="server" Text="Address"></asp:Label>
                    </td>
                    <td style="width: 18%; display: none">
                        <asp:Label ID="lblDOB" runat="server" Text="DOB"></asp:Label>
                    </td>
                    <td style="width: 18%; display: none">
                        <asp:Label ID="lblType" runat="server" Text="Type"></asp:Label>
                    </td>
                    <td style="width: 18%; display: none">
                        <asp:Label ID="lblMartial" runat="server" Text="Martial Status"></asp:Label>
                    </td>
                    <td style="width: 2%;">
                    </td>
                </tr>
            </table>
            <table width="100%">
                <tr>
                    <td>
                        <asp:GridView ID="grdResult" Width="100%" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                            DataKeyNames="PatientID,Name,Age,MobileNumber,Address,PictureName" OnRowDataBound="grdResult_RowDataBound"
                            OnPageIndexChanging="grdResult_PageIndexChanging" OnRowCommand="grdResult_RowCommand"
                            PageSize="15">
                            <Columns>
                                <asp:BoundField Visible="false" DataField="PatientID" HeaderText="Patient ID" meta:resourcekey="BoundFieldResource1" />
                                <asp:TemplateField meta:resourcekey="TemplateFieldResource1" >
                                    <ItemTemplate>
                                        <table id="TabChild" runat="server" border="0" width="100%" align="left">
                                            <tr id="Tr1" runat="server">
                                                <td id="Td1" style="width: 3%;" nowrap="nowrap" runat="server">
                                                    <asp:RadioButton ID="rdSel" runat="server" ToolTip="Select Row" GroupName="PatientSelect" />
                                                </td>
                                                <td id="PatientNumber" align="left" style="display: none; width: 12%" nowrap="nowrap"
                                                    runat="server">
                                                    <%# DataBinder.Eval(Container.DataItem, "PatientNumber")%>
                                                </td>
                                                <td id="PatientID" align="left" style="display: none" runat="server">
                                                    <asp:TextBox ID="txtPatientId" Text='<%# Bind("PatientID") %>' runat="server"></asp:TextBox>
                                                </td>
                                                <td id="Name" align="left" width="25%" runat="server">
                                                    <asp:ImageButton ID="imgClick" ToolTip="Click here To view visit details" runat="server"
                                                        ImageUrl="~/Images/collapse.jpg" CommandName="ShowChild" CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>' />
                                                    <asp:LinkButton ID="lblNaME" ToolTip="Click here To View Visit details" ForeColor="Black"
                                                        runat="server" CommandName="ShowVisit" Text='<%# Bind("Name") %>' CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>'></asp:LinkButton>
                                                </td>
                                                <td id="Empno" align="left" width="8%" runat="server">
                                                    <%# DataBinder.Eval(Container.DataItem, "PatientNumber")%>
                                                </td>
                                                 <td id="Td2" align="left" width="11%" runat="server">
                                                    <%# DataBinder.Eval(Container.DataItem, "Comments")%>
                                                </td>
                                                <td id="RelationName" align="left" width="10%" runat="server">
                                                    <%# DataBinder.Eval(Container.DataItem, "RelationName")%>
                                                </td>
                                                <td id="Age" align="left" width="8%" runat="server">
                                                    <asp:Label ID="lblAge" runat="server" Text='<%# Bind("Age") %>'></asp:Label>
                                                </td>
                                                <td id="MobileNumber" align="left" width="15%" runat="server">
                                                    <%# DataBinder.Eval(Container.DataItem, "MobileNumber")%>
                                                </td>
                                                <td id="Address" align="left" width="18%" runat="server">
                                                    <%# DataBinder.Eval(Container.DataItem, "Address")%>
                                                </td>
                                                <td id="DOB" align="left" width="18%" runat="server" style="width: 18%; display: none">
                                                    <%# DataBinder.Eval(Container.DataItem, "DOB")%>
                                                </td>
                                                <td id="Type" align="left" width="18%" runat="server" style="width: 18%; display: none">
                                                    <%# DataBinder.Eval(Container.DataItem, "AliasName")%>
                                                </td>
                                                <td id="MartialSt" align="left" width="18%" runat="server" style="width: 18%; display: none">
                                                    <%# DataBinder.Eval(Container.DataItem, "MartialStatus")%>
                                                </td>
                                                <td id="PicPatient" align="right" width="2%" runat="server">
                                                    <asp:ImageButton ID="imgPatient" runat="server" ImageUrl="~/Images/PhotoViewer.png"
                                                        Width="13" Height="13" />
                                                </td>
                                            </tr>
                                            <tr runat="server">
                                                <td colspan="10" runat="server">
                                                    <asp:TemplateField HeaderText="Questions" HeaderStyle-HorizontalAlign="Center" >
                                                        <itemtemplate>
                                                                                   
                                                                                    <div style="width: 100%;">
                                                                                            <div runat="server"  id="DivChild" style="display:none;" class="evenforsurg"  >
                                                                                             
                                                                                                  
                                                                                                    <asp:GridView ID="ChildGrid" EmptyDataText="No Record Found" runat="server" 
                                                                                                        AllowPaging="True" CellPadding="1" AutoGenerateColumns="False"
                                                                                                        DataKeyNames="PatientVisitID,Name" Width="98%" OnRowDataBound="ChildGrid_RowDataBound"
                                                                                                        ForeColor="White"  PageSize="25" OnPageIndexChanging="ChildGrd_PageIndexChanging"
                                                                                                        CssClass="mytable1">
                                                                                                        <HeaderStyle CssClass="dataheader1" />
                                                                                                        <Columns>
                                                                                                            <asp:BoundField Visible="False" DataField="PatientVisitID" 
                                                                                                                HeaderText="Patient Visit ID" />
                                                                                                            <asp:TemplateField HeaderText="Select">
                                                                                                                <ItemTemplate>
                                                                                                                    <asp:RadioButton ID="rdSel" runat="server" ToolTip="Select Row" GroupName="VisitSelect" />
                                                                                                                </ItemTemplate>
                                                                                                            </asp:TemplateField>
                                                                                                        <asp:BoundField DataField="PatientName"   Visible ="false" />
                                                                                                            <asp:BoundField DataField="VisitDate" DataFormatString="{0:dd MMM yyyy}" HeaderText="Visit Date" />
                                                                                                            
                                                                                                            <asp:BoundField DataField="ReferingPhysicianName" HeaderText="Ref Physician" />
                                                                                                        
                                                                                                      <asp:BoundField DataField="Investigation" HeaderText="Investigation List" />
                                                                                                      <asp:BoundField DataField="PerformingPhysicain" HeaderText="Reporting Radiologist" />
                                                                                                      <asp:BoundField DataField="VisitPurposeName" HeaderText="Visit Purpose" />
                                                                                                      <asp:BoundField DataField="OrganizationName" HeaderText="Organization Name" />
                                                                                                      <asp:BoundField DataField="WardNo" HeaderText="WardNo" />  
                                                                                                                                                
                                                                                                                        
                                                                                                            <asp:BoundField Visible="False" DataField="Status" HeaderText="Report Status" />
                                                                                                   <asp:BoundField Visible="False" DataField="Status" HeaderText="Report Status" />
                                                                                                            
                                                                                                           
                                                                                                        </Columns>
                                                                                                    </asp:GridView>&nbsp;
                                                                                                   
                                                                                                        <asp:DropDownList ID="ddlVisitActionName" CssClass="ddlTheme" runat="server">
                                                                                                        </asp:DropDownList>
                                                                                                        <asp:Button ID="btnGo" runat="server" Text="Go" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                                                                             onmouseout="this.className='btn'"   OnClick="btnGo_Click1"  />
                                                                                                    
                                                                                               
                                                                                            </div>
                                                                                       
                                                                                    </div>
                                                                                </itemtemplate>
                                                    </asp:TemplateField>
                                                </td>
                                            </tr>
                                        </table>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<table>
    <tr>
        <td>
            <asp:Label ID="lblErrmsg" Text="" runat="server"></asp:Label>
        </td>
    </tr>
</table>
<div id="divFullImage" class="divPopup">
    <img alt="Patient Picture" id="imgPopupPatient" runat="server" src="~/Images/ProfileDefault.jpg" />
</div>
<input type="hidden" id="hdnRowInx" runat="server" name="hdnRowInx" />
<asp:HiddenField ID="hdnPatientID" runat="server" />
<input type="hidden" id="pid" name="pid" />
<asp:HiddenField ID="hdnpDOB" runat="server" />
<input type="hidden" id="DOB" name="DOB" />
<asp:HiddenField ID="hdnpMstatus" runat="server" />
<input type="hidden" id="Mstatus" name="Mstatus" />
<asp:HiddenField ID="hdnpType" runat="server" />
<input type="hidden" id="Type" name="Type" />
<asp:HiddenField ID="hdnTempPatientid" runat="server" />
<asp:HiddenField ID="hdnPatientName" runat="server" />
<input type="hidden" id="pname" name="pname" />
<asp:HiddenField ID="hdnTempPatientName" runat="server" />
<asp:HiddenField ID="patOrgID" runat="server" />
<asp:HiddenField ID="hdnEmpNo" runat="server" />
<input type="hidden" id="EmpTypeNo" name="EmpTypeNo" />
<asp:HiddenField ID="hdnStatus" runat="server" />
<input type="hidden" id="Status" name="Status" />
