<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DesignationRelationship.aspx.cs"
    Inherits="Admin_DesignationRelationship" meta:resourcekey="PageResource1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ctlTaskScriptMgr" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
        <asp:UpdatePanel ID="uPnlUserMaster" runat="server">
            <ContentTemplate>
                <asp:HiddenField ID="hdnDesignationID" runat="server" />
                <asp:HiddenField ID="hdnRealtionID" runat="server" />
                <asp:HiddenField ID="hdnEmployementTypeID" runat="server" />
                <asp:HiddenField ID="hdnEmpDeptID" runat="server" />
                <asp:HiddenField ID="hdnPatientTypeID" runat="server" />
                <asp:HiddenField ID="hdnGradeID" runat="server" />
                <asp:HiddenField ID="hdnOfficeID" runat="server" />
                <asp:HiddenField ID="hdnOfficeLocationID" runat="server" />
                <table class="searchPanel">
                    <tr>
                        <td colspan="3" class="w-35p">
                            <table class="w-100p">
                                <tr>
                                    <td class="w-15p">
                                        <asp:Label ID="lblSelectType" Text="SELECT TYPE:" runat="server" meta:resourcekey="lblSelectTypeResource1"></asp:Label>
                                    </td>
                                    <td class="w-20p">
                                        <asp:RadioButton ID="rdoDesignation" GroupName="DiscMaster" runat="server" Text="Designation"
                                            onclick="javascript:SelectMaster()" meta:resourcekey="rdoDesignationResource1" />
                                    </td>
                                    <td class="w-20p">
                                        <asp:RadioButton ID="rdoRelationship" GroupName="DiscMaster" runat="server" Text="Relationship"
                                            onclick="javascript:SelectMaster()" meta:resourcekey="rdoRelationshipResource1" />
                                    </td>
                                    <td class="w-20p">
                                        <asp:RadioButton ID="rdoEmployement" GroupName="DiscMaster" runat="server" Text="EmploymentType"
                                            onclick="javascript:SelectMaster()" meta:resourcekey="rdoEmployementResource1" />
                                    </td>
                                    <td class="w-25p">
                                        <asp:RadioButton ID="rdoEmployerDeptMaster" GroupName="DiscMaster" runat="server"
                                            Text="EmployerDeptMaster" onclick="javascript:SelectMaster()" meta:resourcekey="rdoEmployerDeptMasterResource1" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="w-15p">
                                    </td>
                                    <td class="w-20p">
                                        <asp:RadioButton ID="rdoPatientType" GroupName="DiscMaster" runat="server" Text="Patient Type"
                                            onclick="javascript:SelectMaster()" meta:resourcekey="rdoPatientTypeResource1" />
                                    </td>
                                    <td class="w-20p">
                                        <asp:RadioButton ID="rdoGradMaster" GroupName="DiscMaster" runat="server" Text="Grade Name"
                                            onclick="javascript:SelectMaster()" meta:resourcekey="rdoGradMasterResource1" />
                                    </td>
                                    <td class="w-20p">
                                        <asp:RadioButton ID="rdoEmployerName" GroupName="DiscMaster" runat="server" Text="Employer Name"
                                            onclick="javascript:SelectMaster()" meta:resourcekey="rdoEmployerNameResource1" />
                                    </td>
                                    <td class="w-25p">
                                        <asp:RadioButton ID="rdoOfficeLocation" GroupName="DiscMaster" runat="server" Text="Employer Location"
                                            onclick="javascript:SelectMaster()" meta:resourcekey="rdoOfficeLocationResource1" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="w-15p">
                                    </td>
                                    <td class="w-20p">
                                        <asp:RadioButton ID="rdoEmployeeRegisteration" GroupName="DiscMaster" runat="server"
                                            Text="Employee Registration" onclick="javascript:SelectMaster()" meta:resourcekey="rdoEmployeeRegisterationResource1" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
                <div id="divDesign" runat="server" style="display: none;">
                    <table class="dataheader2 defaultfontcolor w-100p searchPanel" id="casip">
                        <tr>
                            <td class="a-right w-35p">
                                <asp:Label ID="lblDesignation" Text="Designation Name" runat="server" meta:resourcekey="lblDesignationResource1"></asp:Label>
                            </td>
                            <td class="w-45p">
                                <asp:TextBox ID="txtDesignation" runat="server" onBlur="return ConverttoUpperCase(this.id);"
                                    CssClass="Txtboxsmall" meta:resourcekey="txtDesignationResource1"></asp:TextBox>
                                &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" class="a-center">
                                <asp:Button ID="btnSaveDesign" runat="server" Text="Save" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                    onmouseout="this.className='btn'" Width="75px" OnClick="btnSaveDesign_Click"
                                    OnClientClick="return CheckDesignationName();" meta:resourcekey="btnSaveDesignResource1" />
                                <asp:Button ID="btnResetDesign" runat="server" Text="Reset" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                    onmouseout="this.className='btn'" Width="75px" OnClientClick="return ResetDesign()"
                                    meta:resourcekey="btnResetDesignResource1" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="20" class="a-center">
                                <asp:GridView ID="grdDesignation" runat="server" CellSpacing="1" CellPadding="1"
                                    AutoGenerateColumns="False" ForeColor="#333333" CssClass="mytable1 gridView w-100p"
                                    meta:resourcekey="grdDesignationResource1">
                                    <Columns>
                                        <asp:TemplateField meta:resourcekey="TemplateFieldResource1">
                                            <ItemTemplate>
                                                <input id="rdSelDesign" name="radio" onclick='extractDesignRow(&#039;<%# Eval("DesignationName") %>&#039;,&#039;<%# Eval("DesignationID") %>&#039;)'
                                                    type="radio" discid='<%# Eval("DesignationID") %>' />
                                            </ItemTemplate>
                                            <ItemStyle Width="40px" />
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="DesignationID" HeaderText="DesignationID" Visible="False"
                                            meta:resourcekey="BoundFieldResource1">
                                            <ItemStyle Width="100px" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="DesignationName" HeaderText="Designation Name" meta:resourcekey="BoundFieldResource2">
                                            <ItemStyle Width="250px" />
                                        </asp:BoundField>
                                    </Columns>
                                    <RowStyle HorizontalAlign="Left" />
                                    <PagerStyle CssClass="dataheader1" HorizontalAlign="Center" />
                                    <HeaderStyle CssClass="dataheader1" />
                                </asp:GridView>
                            </td>
                        </tr>
                    </table>
                </div>
                <div id="divRelation" runat="server" style="display: none;">
                    <table class="dataheader2 defaultfontcolor w-100p searchPanel" id="Table1">
                        <tr>
                            <td class="a-right w-35p">
                                <asp:Label ID="lblRelationshipName" Text="Relationship Name" runat="server" meta:resourcekey="lblRelationshipNameResource1"></asp:Label>
                            </td>
                            <td class="w-45p">
                                <asp:TextBox ID="txtRelationship" runat="server" onBlur="return ConverttoUpperCase(this.id);"
                                    CssClass="Txtboxsmall" meta:resourcekey="txtRelationshipResource1"></asp:TextBox>
                                &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" class="a-center">
                                <asp:Button ID="btnSaveRelation" runat="server" Text="Save" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                    onmouseout="this.className='btn'" Width="75px" OnClick="btnSaveRelation_Click"
                                    OnClientClick="return CheckRelationName();" meta:resourcekey="btnSaveRelationResource1" />
                                <asp:Button ID="btnResetRelation" runat="server" Text="Reset" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                    onmouseout="this.className='btn'" Width="75px" OnClientClick="return ResetRelation();"
                                    meta:resourcekey="btnResetRelationResource1" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="5" class="a-center">
                                <asp:GridView ID="grdRelation" runat="server" CellSpacing="1" CellPadding="1" AutoGenerateColumns="False"
                                    ForeColor="#333333" CssClass="mytable1 gridView w-100p" meta:resourcekey="grdRelationResource1">
                                    <Columns>
                                        <asp:TemplateField HeaderText="Select" meta:resourcekey="TemplateFieldResource2">
                                            <ItemTemplate>
                                                <input id="rdSelRelation" name="radio" onclick='extractRelationRow(&#039;<%# Eval("RelationshipName") %>&#039;,&#039;<%# Eval("RelationshipID") %>&#039;)'
                                                    type="radio" discid='<%# Eval("RelationshipID") %>' />
                                            </ItemTemplate>
                                            <ItemStyle Width="40px" />
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="RelationshipID" HeaderText="Relationship ID" Visible="False"
                                            meta:resourcekey="BoundFieldResource3" />
                                        <asp:BoundField DataField="RelationshipName" HeaderText="Relationship Name" meta:resourcekey="BoundFieldResource4">
                                            <ItemStyle Width="250px" />
                                        </asp:BoundField>
                                    </Columns>
                                    <RowStyle HorizontalAlign="Left" />
                                    <PagerStyle CssClass="dataheader1" HorizontalAlign="Center" />
                                    <HeaderStyle CssClass="dataheader1" />
                                </asp:GridView>
                            </td>
                        </tr>
                    </table>
                </div>
                <div id="divEmploymentType" runat="server" style="display: none;">
                    <table class="dataheader2 defaultfontcolor w-100p searchPanel" id="Table2">
                        <tr>
                            <td class="a-right w-35p">
                                <asp:Label ID="lblEmployementTypeName" Text="EmployementType Name" runat="server"
                                    meta:resourcekey="lblEmployementTypeNameResource1"></asp:Label>
                            </td>
                            <td class="w-45p">
                                <asp:TextBox ID="txtEmployementTypeName" runat="server" onBlur="return ConverttoUpperCase(this.id);"
                                    CssClass="Txtboxsmall" meta:resourcekey="txtEmployementTypeNameResource1"></asp:TextBox>
                                &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" class="a-center">
                                <asp:Button ID="btnSaveEmployementTypeName" runat="server" Text="Save" CssClass="btn"
                                    onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" Width="75px"
                                    OnClick="btnSaveEmployementTypeName_Click" OnClientClick="return CheckEmployementType();"
                                    meta:resourcekey="btnSaveEmployementTypeNameResource1" />
                                <asp:Button ID="btnResetEmployementTypeName" runat="server" Text="Reset" CssClass="btn"
                                    onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" Width="75px"
                                    OnClientClick="return ResetEmployementType();" meta:resourcekey="btnResetEmployementTypeNameResource1" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="5" class="a-center">
                                <asp:GridView ID="grdEmploymentType" runat="server" CellSpacing="1" CellPadding="1"
                                    AutoGenerateColumns="False" ForeColor="#333333" CssClass="mytable1 gridView w-100p"
                                    meta:resourcekey="grdEmploymentTypeResource1">
                                    <Columns>
                                        <asp:TemplateField HeaderText="Select" meta:resourcekey="TemplateFieldResource2">
                                            <ItemTemplate>
                                                <input id="rdSelEmployementTypeName" name="radio" onclick='extractEmployementType(&#039;<%# Eval("EmployementTypeName") %>&#039;,&#039;<%# Eval("EmployementTypeID") %>&#039;)'
                                                    type="radio" discid='<%# Eval("EmployementTypeID") %>' />
                                            </ItemTemplate>
                                            <ItemStyle Width="40px" />
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="EmployementTypeID" HeaderText="EmployementType ID" Visible="False"
                                            meta:resourcekey="BoundFieldResource5" />
                                        <asp:BoundField DataField="EmployementTypeName" HeaderText="EmployementType Name"
                                            meta:resourcekey="BoundFieldResource6">
                                            <ItemStyle Width="250px" />
                                        </asp:BoundField>
                                    </Columns>
                                    <RowStyle HorizontalAlign="Left" />
                                    <PagerStyle CssClass="dataheader1" HorizontalAlign="Center" />
                                    <HeaderStyle CssClass="dataheader1" />
                                </asp:GridView>
                            </td>
                        </tr>
                    </table>
                </div>
                <div id="divEmployerDeptMaster" runat="server" style="display: none;">
                    <table class="dataheader2 defaultfontcolor w-100p searchPanel" id="Table3">
                        <tr>
                            <td class="w-25p">
                                <asp:Label ID="lblEmpDeptName" Text="Employee Department Name" runat="server" meta:resourcekey="lblEmpDeptNameResource1"></asp:Label>
                            </td>
                            <td class="w-25p">
                                <asp:TextBox ID="txtEmpDeptName" runat="server" onBlur="return ConverttoUpperCase(this.id);"
                                    CssClass="Txtboxsmall" meta:resourcekey="txtEmpDeptNameResource1"></asp:TextBox>
                                &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                            </td>
                            <td class="w-25p">
                                <asp:Label ID="lblDeptCode" Text="Enter Department Code" runat="server" meta:resourcekey="lblDeptCodeResource1"></asp:Label>
                            </td>
                            <td class="w-25p">
                                <asp:TextBox ID="txtDeptCode" runat="server" onBlur="return ConverttoUpperCase(this.id);"
                                    CssClass="Txtboxsmall" meta:resourcekey="txtDeptCodeResource1"></asp:TextBox>
                                &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4" class="a-center">
                                <asp:Button ID="btnSaveEmpDeptName" runat="server" Text="Save" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                    onmouseout="this.className='btn'" Width="75px" OnClick="btnSaveEmpDeptName_Click"
                                    OnClientClick="return CheckEmpDeptName();" meta:resourcekey="btnSaveEmpDeptNameResource1" />
                                <asp:Button ID="btnResetEmpDeptName" runat="server" Text="Reset" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                    onmouseout="this.className='btn'" Width="75px" OnClientClick="return ResetEmployerDeptMaster();"
                                    meta:resourcekey="btnResetEmpDeptNameResource1" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="5" class="a-center">
                                <asp:GridView ID="grdEmployerDeptMaster" runat="server" CellSpacing="1" CellPadding="1"
                                    AutoGenerateColumns="False" ForeColor="#333333" CssClass="mytable1 gridView w-100p"
                                    meta:resourcekey="grdEmployerDeptMasterResource1">
                                    <Columns>
                                        <asp:TemplateField HeaderText="Select" meta:resourcekey="TemplateFieldResource2">
                                            <ItemTemplate>
                                                <input id="rdSelEmployerDeptMaster" name="radio" onclick='extractEmployerDeptMasterRow(&#039;<%# Eval("EmpDeptName") %>&#039;,&#039;<%# Eval("EmpDeptID") %>&#039;,&#039;<%# Eval("Code") %>&#039;)'
                                                    type="radio" discid='<%# Eval("EmpDeptID") %>' />
                                            </ItemTemplate>
                                            <ItemStyle Width="40px" />
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="EmpDeptID" HeaderText="Employee Dept ID" Visible="False"
                                            meta:resourcekey="BoundFieldResource7" />
                                        <asp:BoundField DataField="EmpDeptName" HeaderText="EmployeeDept Name" meta:resourcekey="BoundFieldResource8">
                                            <ItemStyle Width="250px" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="Code" HeaderText="Department Code" meta:resourcekey="BoundFieldResource9">
                                            <ItemStyle Width="250px" />
                                        </asp:BoundField>
                                    </Columns>
                                    <RowStyle HorizontalAlign="Left" />
                                    <PagerStyle CssClass="dataheader1" HorizontalAlign="Center" />
                                    <HeaderStyle CssClass="dataheader1" />
                                </asp:GridView>
                            </td>
                        </tr>
                    </table>
                </div>
                <div id="divPatienttypeMaster" runat="server" style="display: none;">
                    <table class="dataheader2 defaultfontcolor w-100p searchPanel" id="Table4">
                        <tr>
                            <td class="a-right w-35p">
                                <asp:Label ID="lblPatientType" Text="Patient Type Name" runat="server" meta:resourcekey="lblPatientTypeResource1"></asp:Label>
                            </td>
                            <td class="w-45p">
                                <asp:TextBox ID="txtPatientType" runat="server" onBlur="return ConverttoUpperCase(this.id);"
                                    CssClass="Txtboxsmall" meta:resourcekey="txtPatientTypeResource1"></asp:TextBox>
                                &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" class="a-center">
                                <asp:Button ID="btnSavePatientType" runat="server" Text="Save" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                    onmouseout="this.className='btn'" Width="75px" OnClick="btnSavePatientType_Click"
                                    OnClientClick="return CheckName();" meta:resourcekey="btnSavePatientTypeResource1" />
                                <asp:Button ID="btnResetPatientType" runat="server" Text="Reset" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                    onmouseout="this.className='btn'" Width="75px" OnClientClick="return Resets();"
                                    meta:resourcekey="btnResetPatientTypeResource1" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="5" class="a-center">
                                <asp:GridView ID="grdPatientTypeMaster" runat="server" CellSpacing="1" CellPadding="1"
                                    AutoGenerateColumns="False" ForeColor="#333333" CssClass="mytable1 gridView w-100p"
                                    meta:resourcekey="grdPatientTypeMasterResource1">
                                    <Columns>
                                        <asp:TemplateField HeaderText="Select" meta:resourcekey="TemplateFieldResource3">
                                            <ItemTemplate>
                                                <input id="rdPatientType" name="radio" onclick='extractPatientTypeRow(&#039;<%# Eval("PatientTypeName") %>&#039;,&#039;<%# Eval("PatientTypeID") %>&#039;)'
                                                    type="radio" discid='<%# Eval("PatientTypeID") %>' />
                                            </ItemTemplate>
                                            <ItemStyle Width="40px" />
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="PatientTypeID" HeaderText="PatientTypeID" Visible="False"
                                            meta:resourcekey="BoundFieldResource10" />
                                        <asp:BoundField DataField="PatientTypeName" HeaderText="Patient Type Name" meta:resourcekey="BoundFieldResource11">
                                            <ItemStyle Width="250px" />
                                        </asp:BoundField>
                                    </Columns>
                                    <RowStyle HorizontalAlign="Left" />
                                    <PagerStyle CssClass="dataheader1" HorizontalAlign="Center" />
                                    <HeaderStyle CssClass="dataheader1" />
                                </asp:GridView>
                            </td>
                        </tr>
                    </table>
                </div>
                <div id="divGradeMaster" runat="server" style="display: none;">
                    <table class="dataheader2 defaultfontcolor w-100p searchPanel" id="Table5">
                        <tr>
                            <td class="a-right w-35p">
                                <asp:Label ID="lblGradeName" Text="Grade Name" runat="server" meta:resourcekey="lblGradeNameResource1"></asp:Label>
                            </td>
                            <td class="w-45p">
                                <asp:TextBox ID="txtGradeName" runat="server" onBlur="return ConverttoUpperCase(this.id);"
                                    CssClass="Txtboxsmall" meta:resourcekey="txtGradeNameResource1"></asp:TextBox>
                                &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" class="a-center">
                                <asp:Button ID="btnSavegrade" runat="server" Text="Save" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                    onmouseout="this.className='btn'" Width="75px" OnClick="btnSavegrade_Click" OnClientClick="return GradeCheckName1();"
                                    meta:resourcekey="btnSavegradeResource1" />
                                <asp:Button ID="btnResetGreade" runat="server" Text="Reset" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                    onmouseout="this.className='btn'" Width="75px" OnClientClick="return GradeResets();"
                                    meta:resourcekey="btnResetGreadeResource1" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="5" class="a-center">
                                <asp:GridView ID="grdGradeMaster" runat="server" CellSpacing="1" CellPadding="1"
                                    AutoGenerateColumns="False" ForeColor="#333333" CssClass="mytable1 gridView w-100p"
                                    meta:resourcekey="grdGradeMasterResource1">
                                    <Columns>
                                        <asp:TemplateField HeaderText="Select" meta:resourcekey="TemplateFieldResource4">
                                            <ItemTemplate>
                                                <input id="rdGradeMaster" name="radio" onclick='extractGradeRow(&#039;<%# Eval("GradeName") %>&#039;,&#039;<%# Eval("GradeID") %>&#039;)'
                                                    type="radio" discid='<%# Eval("GradeID") %>' />
                                            </ItemTemplate>
                                            <ItemStyle Width="40px" />
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="GradeID" HeaderText="GradeID" Visible="False" meta:resourcekey="BoundFieldResource12" />
                                        <asp:BoundField DataField="GradeName" HeaderText="Grade Name" meta:resourcekey="BoundFieldResource13">
                                            <ItemStyle Width="250px" />
                                        </asp:BoundField>
                                    </Columns>
                                    <RowStyle HorizontalAlign="Left" />
                                    <PagerStyle CssClass="dataheader1" HorizontalAlign="Center" />
                                    <HeaderStyle CssClass="dataheader1" />
                                </asp:GridView>
                            </td>
                        </tr>
                    </table>
                </div>
                <div id="divOfficeName" runat="server" style="display: none;">
                    <table class="dataheader2 defaultfontcolor w-100p searchPanel" id="Table6">
                        <tr>
                            <td class="a-right w-35p">
                                <asp:Label ID="lblOfficeName" Text="Office Name" runat="server" meta:resourcekey="lblOfficeNameResource1"></asp:Label>
                            </td>
                            <td class="w-45p">
                                <asp:TextBox ID="txtOfficeName" runat="server" onBlur="return ConverttoUpperCase(this.id);"
                                    CssClass="Txtboxsmall" meta:resourcekey="txtOfficeNameResource1"></asp:TextBox>
                                &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" class="a-center">
                                <asp:Button ID="btnSaveOfficeName" runat="server" Text="Save" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                    onmouseout="this.className='btn'" Width="75px" OnClick="btnSaveOfficeName_Click"
                                    OnClientClick="return OfficeNameCheckName();" meta:resourcekey="btnSaveOfficeNameResource1" />
                                <asp:Button ID="btnOfficeNameReset" runat="server" Text="Reset" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                    onmouseout="this.className='btn'" Width="75px" OnClientClick="return OfficeNameResets();"
                                    meta:resourcekey="btnOfficeNameResetResource1" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="5" class="a-center">
                                <asp:GridView ID="grdOfficeName" runat="server" CellSpacing="1" CellPadding="1" AutoGenerateColumns="False"
                                    ForeColor="#333333" CssClass="mytable1 gridView w-100p" meta:resourcekey="grdOfficeNameResource1">
                                    <Columns>
                                        <asp:TemplateField HeaderText="Select" meta:resourcekey="TemplateFieldResource5">
                                            <ItemTemplate>
                                                <input id="rdOfficeName" name="radio" onclick='extractOfficeNameRow(&#039;<%# Eval("EmployerName") %>&#039;,&#039;<%# Eval("EmployerID") %>&#039;)'
                                                    type="radio" discid='<%# Eval("EmployerID") %>' />
                                            </ItemTemplate>
                                            <ItemStyle Width="40px" />
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="EmployerID" HeaderText="OfficeID" Visible="False" meta:resourcekey="BoundFieldResource14" />
                                        <asp:BoundField DataField="EmployerName" HeaderText="Office Name" meta:resourcekey="BoundFieldResource15">
                                            <ItemStyle Width="250px" />
                                        </asp:BoundField>
                                    </Columns>
                                    <RowStyle HorizontalAlign="Left" />
                                    <PagerStyle CssClass="dataheader1" HorizontalAlign="Center" />
                                    <HeaderStyle CssClass="dataheader1" />
                                </asp:GridView>
                            </td>
                        </tr>
                    </table>
                </div>
                <div id="divOfficeLacation" runat="server" style="display: none;">
                    <table class="dataheader2 defaultfontcolor w-100p searchPanel" id="Table7">
                        <tr>
                            <td class="a-right w-35p">
                                <asp:Label ID="lblOfficeLocation" Text="Office Location Name" runat="server" meta:resourcekey="lblOfficeLocationResource1"></asp:Label>
                            </td>
                            <td class="w-45p">
                                <asp:TextBox ID="txtOfficeLocation" runat="server" onBlur="return ConverttoUpperCase(this.id);"
                                    CssClass="Txtboxsmall" meta:resourcekey="txtOfficeLocationResource1"></asp:TextBox>
                                &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" class="a-center">
                                <asp:Button ID="btnSaveOfficeLocation" runat="server" Text="Save" CssClass="btn"
                                    onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" Width="75px"
                                    OnClick="btnSaveOfficeLocation_Click" OnClientClick="return OfficeLocationCheckName();"
                                    meta:resourcekey="btnSaveOfficeLocationResource1" />
                                <asp:Button ID="btnbtnSaveOfficeLocation" runat="server" Text="Reset" CssClass="btn"
                                    onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" Width="75px"
                                    OnClientClick="return OfficeLocationResets();" meta:resourcekey="btnbtnSaveOfficeLocationResource1" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="5" class="a-center">
                                <asp:GridView ID="grdOfficeLocation" runat="server" CellSpacing="1" CellPadding="1"
                                    AutoGenerateColumns="False" ForeColor="#333333" CssClass="mytable1 gridView w-100p"
                                    meta:resourcekey="grdOfficeLocationResource1">
                                    <Columns>
                                        <asp:TemplateField HeaderText="Select" meta:resourcekey="TemplateFieldResource6">
                                            <ItemTemplate>
                                                <input id="rdOfficeLocation" name="radio" onclick='extractOfficeLocationRow(&#039;<%# Eval("EmployerLocationName") %>&#039;,&#039;<%# Eval("EmployerLocationID") %>&#039;)'
                                                    type="radio" discid='<%# Eval("EmployerLocationID") %>' />
                                            </ItemTemplate>
                                            <ItemStyle Width="40px" />
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="EmployerLocationID" HeaderText="OfficeID" Visible="False"
                                            meta:resourcekey="BoundFieldResource16" />
                                        <asp:BoundField DataField="EmployerLocationName" HeaderText="Office Locatione Name"
                                            meta:resourcekey="BoundFieldResource17">
                                            <ItemStyle Width="250px" />
                                        </asp:BoundField>
                                    </Columns>
                                    <RowStyle HorizontalAlign="Left" />
                                    <PagerStyle CssClass="dataheader1" HorizontalAlign="Center" />
                                    <HeaderStyle CssClass="dataheader1" />
                                </asp:GridView>
                            </td>
                        </tr>
                    </table>
                </div>
                <div id="divEmployeeRegistration" runat="server" style="display: none;">
                    <table class="dataheader2 defaultfontcolor w-100p searchPanel" id="Table8">
                        <tr>
                            <td style="width: 171px;">
                                <asp:Label ID="lblEmployementType" runat="server" Text="Employee Type" meta:resourcekey="lblEmployementTypeResource1"></asp:Label>
                            </td>
                            <td style="width: 300px;">
                                <asp:DropDownList ID="ddlEmployementType" runat="server" CssClass="ddlsmall" >
                                </asp:DropDownList>
                                <asp:Label ID="Label2" runat="server" ForeColor="Red" Text="*" meta:resourcekey="Label2Resource1"></asp:Label>
                                <asp:Label ID="lblEmpNo" runat="server" Visible="False" meta:resourcekey="lblEmpNoResource1"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 155px;">
                                <asp:Label ID="lblEmpNumber" runat="server" Text="Employee Number" meta:resourcekey="lblEmpNumberResource1"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtEmployementTypeNo" runat="server" CssClass="Txtboxsmall" meta:resourcekey="txtEmployementTypeNoResource1"></asp:TextBox>
                                <asp:Label ID="Label5" runat="server" ForeColor="Red" Text="*" meta:resourcekey="Label5Resource1"></asp:Label>
                            </td>
                            <td style="width: 155px;">
                                <asp:Label ID="lblEmpName" runat="server" Text="Employee Name" meta:resourcekey="lblEmpNameResource1"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtEmpName" runat="server" CssClass="Txtboxsmall" meta:resourcekey="txtEmpNameResource1"></asp:TextBox>
                                <asp:Label ID="Label6" runat="server" ForeColor="Red" Text="*" meta:resourcekey="Label6Resource1"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblDateOfJoin" runat="server" Text="Date of Joining" meta:resourcekey="lblDateOfJoinResource1"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtJoinDate" runat="server" CssClass="Txtboxsmall" onchange="checkdate()"
                                    meta:resourcekey="txtJoinDateResource1"></asp:TextBox>
                                <ajc:CalendarExtender ID="CalendarExtender1" Format="dd/MM/yyyy" runat="server" TargetControlID="txtJoinDate"
                                    Enabled="True" />
                            </td>
                            <td>
                                <asp:Label ID="lblQualification" runat="server" Text="Qualification" meta:resourcekey="lblQualificationResource1"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtQualification" runat="server" CssClass="Txtboxsmall" meta:resourcekey="txtQualificationResource1"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblDepartment" runat="server" Text="Department" meta:resourcekey="lblDepartmentResource1"></asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlDepartment" runat="server" CssClass="ddlsmall">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="Label1" runat="server" Text="Designation" meta:resourcekey="Label1Resource1"></asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlDesignation" runat="server" CssClass="ddllarge" >
                                </asp:DropDownList>
                            </td>
                            <td>
                                <asp:Label ID="lblOffice" runat="server" Text="Employer Name" meta:resourcekey="lblOfficeResource1"></asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlEmployerName" runat="server" CssClass="ddlsmall" >
                                </asp:DropDownList>
                                <asp:Label ID="Label12" runat="server" ForeColor="Red" Text="*" meta:resourcekey="Label12Resource1"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblEmpLocation" runat="server" Text="Employee Location" meta:resourcekey="lblEmpLocationResource1"></asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlEmployerLocation" runat="server" CssClass="ddlsmall" >
                                </asp:DropDownList>
                                <asp:Label ID="Label3" runat="server" ForeColor="Red" Text="*" meta:resourcekey="Label3Resource1"></asp:Label>
                            </td>
                            <td>
                                <asp:Label ID="lblEmpZone" runat="server" Text="Zone" meta:resourcekey="lblEmpZoneResource1"></asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlZone" runat="server" CssClass="ddllarge" >
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblEmail" runat="server" Text="E-Mail" meta:resourcekey="lblEmailResource1"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtEmail" runat="server" onblur="javascript:checkMailId();" CssClass="Txtboxsmall"
                                    meta:resourcekey="txtEmailResource1"></asp:TextBox>
                            </td>
                            <td>
                                <asp:Label ID="lblMobile" runat="server" Text="Mobile" meta:resourcekey="lblMobileResource1"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtMobile" runat="server"      onkeypress="return ValidateOnlyNumeric(this);"   
                                    CssClass="Txtboxsmall" meta:resourcekey="txtMobileResource1"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblLandLine" runat="server" Text="Landline" meta:resourcekey="lblLandLineResource1"></asp:Label>
                            </td>
                            <td align="left">
                                <asp:TextBox ID="txtLandLine" runat="server"      onkeypress="return ValidateOnlyNumeric(this);"   
                                    CssClass="Txtboxsmall" meta:resourcekey="txtLandLineResource1"></asp:TextBox>
                            </td>
                            <td>
                                <asp:Label ID="lblDiscountLimit" runat="server" Text="Discount Limit" meta:resourcekey="lblDiscountLimitResource1"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtDiscountLimit" runat="server" MaxLength="20" CssClass="Txtboxsmall"
                                    AutoComplete="off" TabIndex="16" onkeydown=" return isNumeric(event,this.id);"
                                    meta:resourcekey="txtDiscountLimitResource1"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="Rs_FromDate2" runat="server" Text="Discount Valid From" meta:resourcekey="Rs_FromDate2Resource1"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox Width="70px" ID="txtFromPeriod" runat="server" meta:resourcekey="txtFromPeriodResource1"></asp:TextBox>
                                <asp:ImageButton ID="ImgBntCalcFrom" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                    CausesValidation="False" meta:resourcekey="ImgBntCalcFromResource1" />
                                <ajc:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="txtFromPeriod"
                                    Mask="99/99/9999" MaskType="Date" ErrorTooltipEnabled="True" CultureAMPMPlaceholder=""
                                    CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                                    CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                                    Enabled="True" />
                                <ajc:MaskedEditValidator ID="MaskedEditValidator1" runat="server" ControlExtender="MaskedEditExtender1"
                                    ControlToValidate="txtFromPeriod" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                    Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                    ValidationGroup="MKE" ErrorMessage="MaskedEditValidator1" meta:resourcekey="MaskedEditValidator1Resource1" />
                                <ajc:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="txtFromPeriod"
                                    Format="dd/MM/yyyy" PopupButtonID="ImgBntCalcFrom" Enabled="True" />
                            </td>
                            <td>
                                <asp:Label ID="Rs_ToDate2" runat="server" Text="Discount Valid To" meta:resourcekey="Rs_ToDate2Resource1"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox Width="70px" runat="server" ID="txtToPeriod" meta:resourcekey="txtToPeriodResource1"></asp:TextBox>
                                <asp:ImageButton ID="ImgBntCalcTo" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                    CausesValidation="False" meta:resourcekey="ImgBntCalcToResource1" />
                                <ajc:MaskedEditExtender ID="MaskedEditExtender2" runat="server" TargetControlID="txtToPeriod"
                                    Mask="99/99/9999" MaskType="Date" ErrorTooltipEnabled="True" CultureAMPMPlaceholder=""
                                    CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                                    CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                                    Enabled="True" />
                                <ajc:MaskedEditValidator ID="MaskedEditValidator2" runat="server" ControlExtender="MaskedEditExtender2"
                                    ControlToValidate="txtToPeriod" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                    Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                    ValidationGroup="MKE" ErrorMessage="MaskedEditValidator2" meta:resourcekey="MaskedEditValidator2Resource1" />
                                <ajc:CalendarExtender ID="CalendarExtender3" runat="server" TargetControlID="txtToPeriod"
                                    Format="dd/MM/yyyy" PopupButtonID="ImgBntCalcTo" Enabled="True" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                        </tr>
                        <tr class="a-center">
                            <td colspan="4" class="a-center">
                                <table>
                                    <tr>
                                        <td>
                                            <asp:Button ID="btnSaveEmpReg" runat="server" Text="Save" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                onmouseout="this.className='btn'" Width="75px" OnClientClick="return ValidateEmpReg();"
                                                OnClick="btnSaveEmpRegistration_Click" meta:resourcekey="btnSaveEmpRegResource1" />
                                            <asp:Button ID="btnResetEmpReg" runat="server" Text="Reset" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                onmouseout="this.className='btn'" Width="75px" OnClientClick='return ResetEmpReg()'
                                                meta:resourcekey="btnResetEmpRegResource1" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="5" class="a-center">
                                <asp:GridView ID="grdEmpReg" runat="server" CellSpacing="1" CellPadding="1" AutoGenerateColumns="False"
                                    ForeColor="#333333" AllowPaging="True" PageSize="8" OnPageIndexChanging="grdEmpReg_PageIndexChanging"
                                    CssClass="mytable1 gridView w-100p" meta:resourcekey="grdEmpRegResource1">
                                    <Columns>
                                        <asp:TemplateField HeaderText="Select" meta:resourcekey="TemplateFieldResource7">
                                            <ItemTemplate>
                                                <input id="rdEmpRegGrd" name="rdEmpRegGrd" type="radio" onclick='extractEmpRegRow(
                                                                &#039;<%# Eval("EmployementTypeID") %>&#039;
                                                                ,&#039;<%# Eval("EmployeeNumber") %>&#039;
                                                                ,&#039;<%# Eval("Name") %>&#039;
                                                                ,&#039;<%# Eval("DOJ") %>&#039;
                                                                ,&#039;<%# Eval("Qualification") %>&#039;
                                                                ,&#039;<%# Eval("DeptID") %>&#039;
                                                                ,&#039;<%# Eval("DesignationID") %>&#039;
                                                                ,&#039;<%# Eval("EmployerID") %>&#039;
                                                                ,&#039;<%# Eval("EmployerLocationID") %>&#039;
                                                                ,&#039;<%# Eval("ZoneID") %>&#039;
                                                                ,&#039;<%# Eval("MobileNo") %>&#039;
                                                                ,&#039;<%# Eval("LandlineNo") %>&#039;
                                                                ,&#039;<%# Eval("EMail") %>&#039;                                                                
                                                                ,&#039;<%# Eval("DiscountLimit") %>&#039;
                                                                ,&#039;<%# Eval("DiscountValidFrom") %>&#039;
                                                                ,&#039;<%# Eval("DiscountValidTo") %>&#039;
                                                                )' discid='<%# Eval("EmpID") %>' />
                                            </ItemTemplate>
                                            <ItemStyle Width="40px" />
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="EmployeeNumber" HeaderText="Employee No." meta:resourcekey="BoundFieldResource18" />
                                        <asp:BoundField DataField="Name" HeaderText="Name" meta:resourcekey="BoundFieldResource19" />
                                        <asp:BoundField DataField="Type" HeaderText="Employment Type" meta:resourcekey="BoundFieldResource20" />
                                        <asp:BoundField DataField="EmpDeptName" HeaderText="Department" meta:resourcekey="BoundFieldResource21" />
                                        <asp:BoundField DataField="DesignationName" HeaderText="Designation" meta:resourcekey="BoundFieldResource22" />
                                        <asp:BoundField DataField="EmployerName" HeaderText="Employer" meta:resourcekey="BoundFieldResource23" />
                                        <asp:BoundField DataField="EmployerLocationName" HeaderText="Location" meta:resourcekey="BoundFieldResource24" />
                                        <asp:BoundField DataField="ZoneName" HeaderText="Zone" meta:resourcekey="BoundFieldResource25" />
                                        <asp:BoundField DataField="MobileNo" HeaderText="Mobile" meta:resourcekey="BoundFieldResource26" />
                                        <asp:BoundField DataField="LandlineNo" HeaderText="Landline" meta:resourcekey="BoundFieldResource27" />
                                        <asp:BoundField DataField="EMail" HeaderText="E-Mail" meta:resourcekey="BoundFieldResource28" />
                                    </Columns>
                                    <RowStyle HorizontalAlign="Left" />
                                    <PagerStyle CssClass="dataheader1" HorizontalAlign="Center" />
                                    <HeaderStyle CssClass="dataheader1" />
                                </asp:GridView>
                            </td>
                        </tr>
                    </table>
                    <br />
                </div>
                </div> </td> </tr> </table>
            </ContentTemplate>
        </asp:UpdatePanel>
        <asp:HiddenField ID="hdnMessages" runat="server" />
        <asp:HiddenField ID="hdnbtnSaveEmpReg" runat="server" Value="Save" />
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    </form>

    <script type="text/javascript">


        function ValidateEmpReg() {

                var AlrtWinHdr = SListForAppMsg.Get("Admin_TestInvestigation_aspx_02") != null ? SListForAppMsg.Get("Admin_TestInvestigation_aspx_02") : "Information";
                var userMsg = SListForAppMsg.Get("Admin_DesignationRelationship_aspx_01") != null ? SListForAppMsg.Get("Admin_DesignationRelationship_aspx_01") : "Select Employee Type";
                var userMsg1 = SListForAppMsg.Get("Admin_DesignationRelationship_aspx_02") != null ? SListForAppMsg.Get("Admin_DesignationRelationship_aspx_02") : "Enter Employee Number";
                var userMsg2 = SListForAppMsg.Get("Admin_DesignationRelationship_aspx_03") != null ? SListForAppMsg.Get("Admin_DesignationRelationship_aspx_03") : "Select Employer Name";
                var userMsg3 = SListForAppMsg.Get("Admin_DesignationRelationship_aspx_04") != null ? SListForAppMsg.Get("Admin_DesignationRelationship_aspx_04") : "Select Employee Location";
                var userMsg4 = SListForAppMsg.Get("Admin_DesignationRelationship_aspx_15") != null ? SListForAppMsg.Get("Admin_DesignationRelationship_aspx_15") : "Created Sucessfully";
            
            if (document.getElementById('ddlEmployementType').selectedIndex == '0' || document.getElementById('ddlEmployementType').value == '') {
                //var userMsg = SListForApplicationMessages.Get("Admin\\DesignationRelationship.aspx_1");
                if (userMsg != null) {
                    // alert(userMsg);
                    ValidationWindow(userMsg, AlrtWinHdr);
                    //return false;
                }
                else {
                    //alert('Select Employee Type');
                    ValidationWindow(userMsg, AlrtWinHdr);
                    //return false;
                }

                document.getElementById('ddlEmployementType').focus();
                return false;
            }
            if (document.getElementById('txtEmployementTypeNo').value == '') {
                //var userMsg = SListForApplicationMessages.Get("Admin\\DesignationRelationship.aspx_2");
                if (userMsg1 != null) {
                    // alert(userMsg);
                    ValidationWindow(userMsg1, AlrtWinHdr);
                    //return false;
                }
                else {
                    //alert('Enter Employee Number');
                    ValidationWindow(userMsg1, AlrtWinHdr);
                    //return false;
                }
                document.getElementById('txtEmployementTypeNo').focus();
                return false;
            }
            if (document.getElementById('txtEmpName').value == '') {
                //var userMsg = SListForApplicationMessages.Get("Admin\\DesignationRelationship.aspx_3");
                if (userMsg1 != null) {
                    //alert(userMsg);
                    ValidationWindow(userMsg1, AlrtWinHdr);
                    //return false;
                }
                else {
                    //alert('Enter Employee Name');
                    ValidationWindow(userMsg1, AlrtWinHdr);
                    //return false;
                }
                document.getElementById('txtEmpName').focus();
                return false;
            }
            if (document.getElementById('ddlEmployerName').selectedIndex == '0' || document.getElementById('ddlEmployerName').value == '') {
                //var userMsg = SListForApplicationMessages.Get("Admin\\DesignationRelationship.aspx_4");
                if (userMsg2 != null) {
                    // alert(userMsg);
                    ValidationWindow(userMsg2, AlrtWinHdr);
                    // return false;
                }
                else {
                    //alert('Select Employer Name');
                    ValidationWindow(userMsg2, AlrtWinHdr);
                    // return false;
                }
                document.getElementById('ddlEmployerName').focus();
                return false;
            }
            if (document.getElementById('ddlEmployerLocation').selectedIndex == '0' || document.getElementById('ddlEmployerLocation').value == '') {
                //var userMsg = SListForApplicationMessages.Get("Admin\\DesignationRelationship.aspx_5");
                if (userMsg3 != null) {
                    //alert(userMsg);
                    ValidationWindow(userMsg3, AlrtWinHdr);
                    //return false;
                }
                else {
                    // alert('Select Employee Location');
                    ValidationWindow(userMsg3, AlrtWinHdr);
                    //return false;
                }

                document.getElementById('ddlEmployerLocation').focus();
                return false;
            }
            return true;
        }
        function SelectMaster() {
            if (document.getElementById('rdoDesignation').checked == true) {
                document.getElementById('divDesign').style.display = 'block';
                document.getElementById('txtDesignation').value = "";
                document.getElementById('divRelation').style.display = 'none';
                document.getElementById('divEmploymentType').style.display = 'none';
                document.getElementById('divEmployerDeptMaster').style.display = 'none';
                document.getElementById('divPatienttypeMaster').style.display = 'none';
                document.getElementById('divOfficeName').style.display = 'none';
                document.getElementById('divGradeMaster').style.display = 'none';
                document.getElementById('divOfficeLacation').style.display = 'none';
                document.getElementById('divEmployeeRegistration').style.display = 'none';
            }
            if (document.getElementById('rdoRelationship').checked == true) {
                document.getElementById('divDesign').style.display = 'none';
                document.getElementById('divRelation').style.display = 'block';
                document.getElementById('txtRelationship').value = "";
                document.getElementById('divEmploymentType').style.display = 'none';
                document.getElementById('divEmployerDeptMaster').style.display = 'none';
                document.getElementById('divPatienttypeMaster').style.display = 'none';
                document.getElementById('divOfficeName').style.display = 'none';
                document.getElementById('divGradeMaster').style.display = 'none';
                document.getElementById('divOfficeLacation').style.display = 'none';
                document.getElementById('divEmployeeRegistration').style.display = 'none';
            }
            if (document.getElementById('rdoEmployement').checked == true) {
                document.getElementById('divDesign').style.display = 'none';
                document.getElementById('divRelation').style.display = 'none';
                document.getElementById('divEmploymentType').style.display = 'block';
                document.getElementById('txtEmployementTypeName').value = "";
                document.getElementById('divEmployerDeptMaster').style.display = 'none';
                document.getElementById('divPatienttypeMaster').style.display = 'none';
                document.getElementById('divOfficeName').style.display = 'none';
                document.getElementById('divGradeMaster').style.display = 'none';
                document.getElementById('divOfficeLacation').style.display = 'none';
                document.getElementById('divEmployeeRegistration').style.display = 'none';
            }
            if (document.getElementById('rdoEmployerDeptMaster').checked == true) {
                document.getElementById('divDesign').style.display = 'none';
                document.getElementById('divRelation').style.display = 'none';
                document.getElementById('divEmploymentType').style.display = 'none';
                document.getElementById('divEmployerDeptMaster').style.display = 'block';
                document.getElementById('txtEmpDeptName').value = "";
                document.getElementById('divPatienttypeMaster').style.display = 'none';
                document.getElementById('divOfficeName').style.display = 'none';
                document.getElementById('divGradeMaster').style.display = 'none';
                document.getElementById('divOfficeLacation').style.display = 'none';
                document.getElementById('divEmployeeRegistration').style.display = 'none';
            }
            if (document.getElementById('rdoPatientType').checked == true) {
                document.getElementById('divDesign').style.display = 'none';
                document.getElementById('divRelation').style.display = 'none';
                document.getElementById('divEmploymentType').style.display = 'none';
                document.getElementById('divEmployerDeptMaster').style.display = 'none';
                document.getElementById('divPatienttypeMaster').style.display = 'block';
                document.getElementById('divOfficeName').style.display = 'none';
                document.getElementById('divGradeMaster').style.display = 'none';
                document.getElementById('divOfficeLacation').style.display = 'none';
                document.getElementById('txtPatientType').value = "";
                document.getElementById('divEmployeeRegistration').style.display = 'none';
            }
            if (document.getElementById('rdoGradMaster').checked == true) {
                document.getElementById('divDesign').style.display = 'none';
                document.getElementById('divRelation').style.display = 'none';
                document.getElementById('divEmploymentType').style.display = 'none';
                document.getElementById('divEmployerDeptMaster').style.display = 'none';
                document.getElementById('divPatienttypeMaster').style.display = 'none';
                document.getElementById('divGradeMaster').style.display = 'block';
                document.getElementById('divOfficeName').style.display = 'none';
                document.getElementById('divOfficeLacation').style.display = 'none';
                document.getElementById('txtGradeName').value = "";
                document.getElementById('divEmployeeRegistration').style.display = 'none';
            }
            if (document.getElementById('rdoEmployerName').checked == true) {
                document.getElementById('divDesign').style.display = 'none';
                document.getElementById('divRelation').style.display = 'none';
                document.getElementById('divEmploymentType').style.display = 'none';
                document.getElementById('divEmployerDeptMaster').style.display = 'none';
                document.getElementById('divPatienttypeMaster').style.display = 'none';
                document.getElementById('divGradeMaster').style.display = 'none';
                document.getElementById('divOfficeName').style.display = 'block';
                document.getElementById('divOfficeLacation').style.display = 'none';
                document.getElementById('txtOfficeName').value = "";
                document.getElementById('divEmployeeRegistration').style.display = 'none';
            }
            if (document.getElementById('rdoOfficeLocation').checked == true) {
                document.getElementById('divDesign').style.display = 'none';
                document.getElementById('divRelation').style.display = 'none';
                document.getElementById('divEmploymentType').style.display = 'none';
                document.getElementById('divEmployerDeptMaster').style.display = 'none';
                document.getElementById('divPatienttypeMaster').style.display = 'none';
                document.getElementById('divGradeMaster').style.display = 'none';
                document.getElementById('divOfficeName').style.display = 'none';
                document.getElementById('divOfficeLacation').style.display = 'block';
                document.getElementById('txtOfficeLocation').value = "";
                document.getElementById('divEmployeeRegistration').style.display = 'none';
            }
            if (document.getElementById('rdoEmployeeRegisteration').checked == true) {
                document.getElementById('divDesign').style.display = 'none';
                document.getElementById('divRelation').style.display = 'none';
                document.getElementById('divEmploymentType').style.display = 'none';
                document.getElementById('divEmployerDeptMaster').style.display = 'none';
                document.getElementById('divPatienttypeMaster').style.display = 'none';
                document.getElementById('divGradeMaster').style.display = 'none';
                document.getElementById('divOfficeName').style.display = 'none';
                document.getElementById('divOfficeLacation').style.display = 'none';
                document.getElementById('txtOfficeLocation').value = "";
                document.getElementById('divEmployeeRegistration').style.display = 'block';
            }
        }

        function extractEmpRegRow(EmployementTypeID, EmployeeNumber, Name, DOJ, Qualification, DeptID, DesignationID, EmployerID, EmployerLocationID, Zone, MobileNo, LandlineNo, EMail, DiscountLimit, DiscountValidFrom, DiscountValidTo) {
            document.getElementById("ddlEmployementType").value = EmployementTypeID;
            document.getElementById("txtEmployementTypeNo").value = EmployeeNumber;
            document.getElementById("txtEmpName").value = Name;
            document.getElementById("txtJoinDate").value = DOJ;
            document.getElementById("txtQualification").value = Qualification;
            document.getElementById("ddlDepartment").value = DeptID;
            document.getElementById("ddlDesignation").value = DesignationID;
            document.getElementById("ddlEmployerName").value = EmployerID;
            document.getElementById("ddlEmployerLocation").value = EmployerLocationID;
            document.getElementById("ddlZone").value = Zone;
            document.getElementById("txtMobile").value = MobileNo;
            document.getElementById("txtLandLine").value = LandlineNo;
            document.getElementById("txtEmail").value = EMail;

            document.getElementById("txtDiscountLimit").value = DiscountLimit == "0" ? "" : DiscountLimit;
            document.getElementById("txtFromPeriod").value = DiscountValidFrom == "31/12/9999 23:59:59" ? "" : DiscountValidFrom;
            document.getElementById("txtToPeriod").value = DiscountValidTo == "31/12/9999 23:59:59" ? "" : DiscountValidTo;

            document.getElementById("btnSaveEmpReg").value = "Update";
            document.getElementById("hdnbtnSaveEmpReg").value = "";
            document.getElementById("hdnbtnSaveEmpReg").value = "Update";
        }
        function ResetEmpReg() {
            document.getElementById("hdnbtnSaveEmpReg").value = "";
            document.getElementById("hdnbtnSaveEmpReg").value = "Save";
            document.getElementById("ddlEmployementType").selectedIndex = 0;
            document.getElementById("txtEmployementTypeNo").value = '';
            document.getElementById("txtEmpName").value = '';
            document.getElementById("txtJoinDate").value = '';
            document.getElementById("txtQualification").value = '';
            document.getElementById("ddlDepartment").selectedIndex = 0;
            document.getElementById("ddlDesignation").selectedIndex = 0;
            document.getElementById("ddlEmployerName").selectedIndex = 0;
            document.getElementById("ddlEmployerLocation").selectedIndex = 0;
            document.getElementById("ddlZone").selectedIndex = 0;
            document.getElementById("txtMobile").value = '';
            document.getElementById("txtLandLine").value = '';
            document.getElementById("txtEmail").value = '';
            return false;
        }
        function extractDesignRow(src, cID) {
            //var eRow = src.parentElement.parentElement;
            //var RI = eRow.rowIndex;
            document.getElementById("hdnDesignationID").value = "";
            var CasTbl = document.getElementById("grdDesignation");
            document.getElementById("hdnDesignationID").value = cID;
            document.getElementById("txtDesignation").value = src;
            document.getElementById("<%=btnSaveDesign.ClientID %>").value = "Update";
        }

        function ResetDesign() {
            document.getElementById('txtDesignation').value = "";
            document.getElementById('hdnDesignationID').value = "";
            document.getElementById('<%=btnSaveDesign.ClientID %>').value = "Save";
            var radList = document.getElementsByName('rdSelDesign');
            for (var i = 0; i < radList.length; i++) {
                if (radList[i].checked) {
                    radList[i].checked = false;
                }
            }
            return false;
        }

        function extractRelationRow(src, cID) {
            //var eRow = src.parentElement.parentElement;
            //var RI = eRow.rowIndex;
            var CasTbl = document.getElementById("grdRelation");
            document.getElementById('hdnRealtionID').value = cID;
            document.getElementById("txtRelationship").value = src;
            document.getElementById('<%=btnSaveRelation.ClientID %>').value = "Update";
        }

        function ResetRelation() {
            document.getElementById('txtRelationship').value = "";
            document.getElementById('hdnRealtionID').value = "";
            document.getElementById('<%=btnSaveRelation.ClientID %>').value = "Save";
            var radList = document.getElementsByName('rdSelEmployementTypeName');
            for (var i = 0; i < radList.length; i++) {
                if (radList[i].checked) {
                    radList[i].checked = false;
                }
            }
            return false;
        }

        function extractEmployementType(src, cID) {
            //var eRow = src.parentElement.parentElement;
            //var RI = eRow.rowIndex;
            var CasTbl = document.getElementById("grdEmploymentType");
            document.getElementById('hdnEmployementTypeID').value = cID;
            document.getElementById('txtEmployementTypeName').value = src;
            document.getElementById('<%=btnSaveEmployementTypeName.ClientID %>').value = "Update";
        }

        function ResetEmployementType() {
            document.getElementById('txtEmployementTypeName').value = "";
            document.getElementById('hdnEmployementTypeID').value = "";
            document.getElementById('<%=btnSaveEmployementTypeName.ClientID %>').value = "Save";
            var radList = document.getElementsByName('rdSelDesign');
            for (var i = 0; i < radList.length; i++) {
                if (radList[i].checked) {
                    radList[i].checked = false;
                }
            }
            return false;
        }

        function extractEmployerDeptMasterRow(src, cID, code) {
            //var eRow = src.parentElement.parentElement;
            //var RI = eRow.rowIndex;CasTbl.rows[RI].cells[1].innerHTML;
            var CasTbl = document.getElementById("grdEmployerDeptMaster");
            document.getElementById('hdnEmpDeptID').value = cID;
            document.getElementById('txtEmpDeptName').value = src;
            document.getElementById('txtDeptCode').value = code;
            document.getElementById('<%=btnSaveEmpDeptName.ClientID %>').value = "Update";
        }

        function ResetEmployerDeptMaster() {
            document.getElementById('txtEmpDeptName').value = "";
            document.getElementById('hdnEmpDeptID').value = "";
            document.getElementById('txtDeptCode').value = "";
            document.getElementById('<%=btnSaveEmpDeptName.ClientID %>').value = "Save";
            var radList = document.getElementsByName('rdSelEmployerDeptMaster');
            for (var i = 0; i < radList.length; i++) {
                if (radList[i].checked) {
                    radList[i].checked = false;
                }
            }
            return false;
        }

        function CheckDesignationName() {
            var AlrtWinHdr = SListForAppMsg.Get("Admin_TestInvestigation_aspx_02") != null ? SListForAppMsg.Get("Admin_TestInvestigation_aspx_02") : "Information";
            var userMsg = SListForAppMsg.Get("Admin_DesignationRelationship_aspx_05") != null ? SListForAppMsg.Get("Admin_DesignationRelationship_aspx_05") : "Enter designation name";
            var designation = document.getElementById('txtDesignation').value;
            var btnvalue = document.getElementById('btnSaveDesign').value;
            var TblDesig = document.getElementById('grdDesignation');
            var grdlength;
            if (TblDesig == null) {
                grdlength = 0;
            }
            else {
                grdlength = TblDesig.rows.length;
            }
            if (document.getElementById('txtDesignation').value == "") {
                //var userMsg = SListForApplicationMessages.Get("Admin\\DesignationRelationship.aspx_6");
                if (userMsg != null) {
                    //alert(userMsg);
                    ValidationWindow(userMsg, AlrtWinHdr);
                    return false;
                }
                else {
                    //alert("Enter designation name");
                    ValidationWindow(userMsg, AlrtWinHdr);
                    return false;
                }
                //return false;
            }
            if (btnvalue == 'Save') {
                for (i = 1; i <= grdlength - 1; i++) {
                    var desigID = TblDesig.rows[i].cells[0].childNodes[0].getAttribute('DiscID');
                    var designame = TblDesig.rows[i].cells[1].innerHTML;
                    var userMsg2 = SListForAppMsg.Get("Admin_DesignationRelationship_aspx_06") != null ? SListForAppMsg.Get("Admin_DesignationRelationship_aspx_06") : "Name already exists";
                    if (designame.toUpperCase() == designation.toUpperCase()) {
                        // var userMsg = SListForApplicationMessages.Get("Admin\\DesignationRelationship.aspx_7");
                        if (userMsg2 != null) {
                            //alert(userMsg);
                            ValidationWindow(userMsg2, AlrtWinHdr);
                            return false;
                        }
                        else {
                            //alert("Name already exists");
                            ValidationWindow(userMsg2, AlrtWinHdr);
                            return false;
                        }
                        //                        return false;
                    }
                }
            }
        }

        function CheckRelationName() {
            var relation = document.getElementById('txtRelationship').value;
            var btnvalue = document.getElementById('btnSaveRelation').value;
            var Tblrelation = document.getElementById('grdRelation');
            var grdlength;
            var AlrtWinHdr = SListForAppMsg.Get("Admin_TestInvestigation_aspx_02") != null ? SListForAppMsg.Get("Admin_TestInvestigation_aspx_02") : "Information";
            var userMsg = SListForAppMsg.Get("Admin_DesignationRelationship_aspx_07") != null ? SListForAppMsg.Get("Admin_DesignationRelationship_aspx_07") : "Enter Relationship name";
            var userMsg2 = SListForAppMsg.Get("Admin_DesignationRelationship_aspx_06") != null ? SListForAppMsg.Get("Admin_DesignationRelationship_aspx_06") : "Name already exists";
            if (Tblrelation == null) {
                grdlength = 0;
            }
            else {
                grdlength = Tblrelation.rows.length;
            }
            if (document.getElementById('txtRelationship').value == "") {
                //var userMsg = SListForApplicationMessages.Get("Admin\\DesignationRelationship.aspx_8");
                if (userMsg != null) {
                    //alert(userMsg);
                    ValidationWindow(userMsg, AlrtWinHdr);
                    return false;
                }
                else {
                    //alert("Enter relationship name");
                    ValidationWindow(userMsg, AlrtWinHdr);
                    return false;
                }
                //return false;
            }
            if (btnvalue == 'Save') {
                for (i = 1; i <= grdlength - 1; i++) {
                    var relationID = Tblrelation.rows[i].cells[0].childNodes[0].getAttribute('DiscID');
                    var realtionname = Tblrelation.rows[i].cells[1].innerHTML;
                    if (realtionname.toUpperCase() == relation.toUpperCase()) {
                        // var userMsg = SListForApplicationMessages.Get("Admin\\DesignationRelationship.aspx_7");
                        if (userMsg != null) {
                            // alert(userMsg);
                            ValidationWindow(userMsg2, AlrtWinHdr);
                            return false;
                        }
                        else {
                            //alert("Name already exists");
                            ValidationWindow(userMsg2, AlrtWinHdr);
                            return false;
                        }
                        //return false;
                    }
                }
            }
        }

        function CheckEmployementType() {
            var emptype = document.getElementById('txtEmployementTypeName').value;
            var btnvalue = document.getElementById('btnSaveEmployementTypeName').value;
            var TblEmptype = document.getElementById('grdEmploymentType');
            var grdlength;
            var AlrtWinHdr = SListForAppMsg.Get("Admin_TestInvestigation_aspx_02") != null ? SListForAppMsg.Get("Admin_TestInvestigation_aspx_02") : "Information";
            var userMsg = SListForAppMsg.Get("Admin_DesignationRelationship_aspx_08") != null ? SListForAppMsg.Get("Admin_DesignationRelationship_aspx_08") : "Enter employee type name";
            var userMsg2 = SListForAppMsg.Get("Admin_DesignationRelationship_aspx_06") != null ? SListForAppMsg.Get("Admin_DesignationRelationship_aspx_06") : "Name already exists";

            if (TblEmptype == null) {
                grdlength = 0;
            }
            else {
                grdlength = TblEmptype.rows.length;
            }
            if (document.getElementById('txtEmployementTypeName').value == "") {
                //var userMsg = SListForApplicationMessages.Get("Admin\\DesignationRelationship.aspx_9");
                if (userMsg != null) {
                    //alert(userMsg);
                    ValidationWindow(userMsg, AlrtWinHdr);
                    return false;
                }
                else {
                    //alert("Enter employee type name");
                    ValidationWindow(userMsg, AlrtWinHdr);
                    return false;
                }

                //   return false;
            }
            if (btnvalue == 'Save') {
                for (i = 1; i <= grdlength - 1; i++) {
                    var emptypeID = TblEmptype.rows[i].cells[0].childNodes[0].getAttribute('DiscID');
                    var emptypeName = TblEmptype.rows[i].cells[1].innerHTML;
                    if (emptypeName.toUpperCase() == emptype.toUpperCase()) {
                        //var userMsg = SListForApplicationMessages.Get("Admin\\DesignationRelationship.aspx_7");
                        if (userMsg != null) {
                            // alert(userMsg);
                            ValidationWindow(userMsg2, AlrtWinHdr);
                            return false;
                        }
                        else {
                            //alert("Name already exists");
                            ValidationWindow(userMsg2, AlrtWinHdr);
                            return false;
                        }
                        //return false;
                    }
                }
            }
        }

        function CheckEmpDeptName() {
            var empdeptName = document.getElementById('txtEmpDeptName').value;
            var btnvalue = document.getElementById('btnSaveEmpDeptName').value;
            var TblEmpDept = document.getElementById('grdEmployerDeptMaster');
            var grdlength;

            var AlrtWinHdr = SListForAppMsg.Get("Admin_TestInvestigation_aspx_02") != null ? SListForAppMsg.Get("Admin_TestInvestigation_aspx_02") : "Information";
            var userMsg = SListForAppMsg.Get("Admin_DesignationRelationship_aspx_09") != null ? SListForAppMsg.Get("Admin_DesignationRelationship_aspx_09") : "Enter employee department name";
            var userMsg2 = SListForAppMsg.Get("Admin_DesignationRelationship_aspx_06") != null ? SListForAppMsg.Get("Admin_DesignationRelationship_aspx_06") : "Name already exists";
            if (TblEmpDept == null) {
                grdlength = 0;
            }
            else {
                grdlength = TblEmpDept.rows.length;
            }
            if (document.getElementById('txtEmpDeptName').value == "") {
                // var userMsg = SListForApplicationMessages.Get("Admin\\DesignationRelationship.aspx_10");
                if (userMsg != null) {
                    // alert(userMsg);
                    ValidationWindow(userMsg, AlrtWinHdr);
                    return false;
                }
                else {
                    //alert("Enter employee department name");
                    ValidationWindow(userMsg, AlrtWinHdr);
                    return false;
                }

            }
            if (document.getElementById('txtDeptCode').value == "") {
                // var userMsg = SListForApplicationMessages.Get("Admin\\DesignationRelationship.aspx_11");
                var userMsg1 = SListForAppMsg.Get("Admin_DesignationRelationship_aspx_10") != null ? SListForAppMsg.Get("Admin_DesignationRelationship_aspx_10") : "Enterthe code";
                if (userMsg1 != null) {
                    //alert(userMsg);
                    ValidationWindow(userMsg1, AlrtWinHdr);
                    return false;
                }
                else {
                    //alert("Enter the code");
                    ValidationWindow(userMsg1, AlrtWinHdr);
                    return false;
                }

            }
            if (btnvalue == 'Save') {
                for (i = 1; i <= grdlength - 1; i++) {
                    var empDeptID = TblEmpDept.rows[i].cells[0].childNodes[0].getAttribute('DiscID');
                    var empdeptname = TblEmpDept.rows[i].cells[1].innerHTML;
                    if (empdeptname.toUpperCase() == empdeptName.toUpperCase()) {
                        //var userMsg = SListForApplicationMessages.Get("Admin\\DesignationRelationship.aspx_7");
                        if (userMsg2 != null) {
                            //alert(userMsg);
                            ValidationWindow(userMsg2, AlrtWinHdr);
                            return false;
                        }
                        else {
                            //alert("Name already exists");
                            ValidationWindow(userMsg2, AlrtWinHdr);
                            return false;
                        }

                    }
                }
            }
        }
        //-------------------------------------PatientType---------------------

        //--------------------------------Reset-----------------------------------
        function Resets() {
            document.getElementById('txtPatientType').value = "";
            document.getElementById('hdnPatientTypeID').value = "";
            document.getElementById('<%=btnSavePatientType.ClientID %>').value = "Save";
            var radList = document.getElementsByName('rdPatientType');
            for (var i = 0; i < radList.length; i++) {
                if (radList[i].checked) {
                    radList[i].checked = false;
                }
            }
            return false;
        }
        //-------------------------------Update-----------------------------------
        function extractPatientTypeRow(src, cID) {
            //var eRow = src.parentElement.parentElement;
            //var RI = eRow.rowIndex;
            var CasTbl = document.getElementById("grdPatientTypeMaster");
            document.getElementById('hdnPatientTypeID').value = cID;
            document.getElementById('txtPatientType').value = src;
            document.getElementById('<%=btnSavePatientType.ClientID %>').value = "Update";
        }
        function CheckName() {

            var empdeptName = document.getElementById('txtPatientType').value;
            var btnvalue = document.getElementById('btnSavePatientType').value;
            var TblEmpDept = document.getElementById('grdPatientTypeMaster');
            var grdlength;
            var AlrtWinHdr = SListForAppMsg.Get("Admin_TestInvestigation_aspx_02") != null ? SListForAppMsg.Get("Admin_TestInvestigation_aspx_02") : "Information";
            var userMsg = SListForAppMsg.Get("Admin_DesignationRelationship_aspx_11") != null ? SListForAppMsg.Get("Admin_DesignationRelationship_aspx_11") : "Enter the Patient Type Name";
            var userMsg2 = SListForAppMsg.Get("Admin_DesignationRelationship_aspx_06") != null ? SListForAppMsg.Get("Admin_DesignationRelationship_aspx_06") : "Name already exists";
            
            if (TblEmpDept == null) {
                grdlength = 0;
            }
            else {
                grdlength = TblEmpDept.rows.length;
            }
            if (document.getElementById('txtPatientType').value == "") {
                //var userMsg = SListForApplicationMessages.Get("Admin\\DesignationRelationship.aspx_12");
                if (userMsg != null) {
                    //alert(userMsg);
                    ValidationWindow(userMsg, AlrtWinHdr);
                    return false;
                }
                else {
                    // alert("Enter patient type name");
                    ValidationWindow(userMsg, AlrtWinHdr);
                    return false;
                }

            }
            if (btnvalue == 'Save') {
                for (i = 1; i <= grdlength - 1; i++) {
                    var empDeptID = TblEmpDept.rows[i].cells[0].childNodes[0].getAttribute('DiscID');
                    var empdeptname = TblEmpDept.rows[i].cells[1].innerHTML;
                    if (empdeptname.toUpperCase() == empdeptName.toUpperCase()) {
                        //var userMsg = SListForApplicationMessages.Get("Admin\\DesignationRelationship.aspx_7");
                        if (userMsg2 != null) {
                            //alert(userMsg);
                            ValidationWindow(userMsg2, AlrtWinHdr);
                            return false;
                        }
                        else {
                            // alert("Name already exists");
                            ValidationWindow(userMsg2, AlrtWinHdr);
                            return false;
                        }

                    }
                }
            }
        }
        //----------------------------------------Grade--------------------------
        function GradeCheckName1() {

            var empdeptName = document.getElementById('txtGradeName').value;
            var btnvalue = document.getElementById('btnSavegrade').value;
            var TblEmpDept = document.getElementById('grdGradeMaster');
            var grdlength;
            var AlrtWinHdr = SListForAppMsg.Get("Admin_TestInvestigation_aspx_02") != null ? SListForAppMsg.Get("Admin_TestInvestigation_aspx_02") : "Information";
            var userMsg = SListForAppMsg.Get("Admin_DesignationRelationship_aspx_12") != null ? SListForAppMsg.Get("Admin_DesignationRelationship_aspx_12") : "Enter grant Name";
            var userMsg2 = SListForAppMsg.Get("Admin_DesignationRelationship_aspx_06") != null ? SListForAppMsg.Get("Admin_DesignationRelationship_aspx_06") : "Name already exists";
      
            if (TblEmpDept == null) {
                grdlength = 0;
            }
            else {
                grdlength = TblEmpDept.rows.length;
            }
            if (document.getElementById('txtGradeName').value == "") {
                //var userMsg = SListForApplicationMessages.Get("Admin\\DesignationRelationship.aspx_15");
                if (userMsg != null) {
                    //alert(userMsg);
                    ValidationWindow(userMsg, AlrtWinHdr);
                    return false;
                }
                else {
                    // alert("Enter grade name");
                    ValidationWindow(userMsg, AlrtWinHdr);
                    return false;
                }

            }
            if (btnvalue == 'Save') {
                for (i = 1; i <= grdlength - 1; i++) {
                    var empDeptID = TblEmpDept.rows[i].cells[0].childNodes[0].getAttribute('DiscID');
                    var empdeptname = TblEmpDept.rows[i].cells[1].innerHTML;
                    if (empdeptname.toUpperCase() == empdeptName.toUpperCase()) {
                       // var userMsg = SListForApplicationMessages.Get("Admin\\DesignationRelationship.aspx_7");
                        if (userMsg2 != null) {
                            // alert(userMsg);
                            ValidationWindow(userMsg2, AlrtWinHdr);
                            return false;
                        }
                        else {
                            // alert("Name already exists");
                            ValidationWindow(userMsg2, AlrtWinHdr);
                            return false;
                        }
                    }
                }
            }
        }

        function GradeResets() {
            document.getElementById('txtGradeName').value = "";
            document.getElementById('hdnGradeID').value = "";
            document.getElementById('<%=btnSavegrade.ClientID %>').value = "Save";
            var radList = document.getElementsByName('rdGradeMaster');
            for (var i = 0; i < radList.length; i++) {
                if (radList[i].checked) {
                    radList[i].checked = false;
                }
            }
            return false;
        }

        function extractGradeRow(src, cID) {
            //var eRow = src.parentElement.parentElement;
            //var RI = eRow.rowIndex;
            var CasTbl = document.getElementById("grdGradeMaster");
            document.getElementById('hdnGradeID').value = cID;
            document.getElementById('txtGradeName').value = src;
            document.getElementById('<%=btnSavegrade.ClientID %>').value = "Update";
        }

        //----------------------------------------OfficeName--------------------------
        function OfficeNameCheckName() {

            var empdeptName = document.getElementById('txtOfficeName').value;
            var btnvalue = document.getElementById('btnSaveOfficeName').value;
            var TblEmpDept = document.getElementById('grdOfficeName');
            var grdlength;

            var AlrtWinHdr = SListForAppMsg.Get("Admin_TestInvestigation_aspx_02") != null ? SListForAppMsg.Get("Admin_TestInvestigation_aspx_02") : "Information";
            var userMsg = SListForAppMsg.Get("Admin_DesignationRelationship_aspx_13") != null ? SListForAppMsg.Get("Admin_DesignationRelationship_aspx_13") : "Enter Employee Name";
            
            if (TblEmpDept == null) {
                grdlength = 0;
            }
            else {
                grdlength = TblEmpDept.rows.length;
            }
            if (document.getElementById('txtOfficeName').value == "") {
                //var userMsg = SListForApplicationMessages.Get("Admin\\DesignationRelationship.aspx_3");
                if (userMsg != null) {
                    //alert(userMsg);
                    ValidationWindow(userMsg, AlrtWinHdr);
                    return false;
                }
                else {
                    //alert("Enter employer name");
                    ValidationWindow(userMsg, AlrtWinHdr);
                    return false;
                }

            }
            if (btnvalue == 'Save') {
                for (i = 1; i <= grdlength - 1; i++) {
                    var empDeptID = TblEmpDept.rows[i].cells[0].childNodes[0].getAttribute('DiscID');
                    var empdeptname = TblEmpDept.rows[i].cells[1].innerHTML;
                    var userMsg2 = SListForAppMsg.Get("Admin_DesignationRelationship_aspx_06") != null ? SListForAppMsg.Get("Admin_DesignationRelationship_aspx_06") : "Name already exists";
        
                    if (empdeptname.toUpperCase() == empdeptName.toUpperCase()) {

                        //var userMsg = SListForApplicationMessages.Get("Admin\\DesignationRelationship.aspx_7");
                        if (userMsg2 != null) {
                            //alert(userMsg);
                            ValidationWindow(userMsg2, AlrtWinHdr);
                            return false;
                        }
                        else {
                            //alert("Name already exists");
                            ValidationWindow(userMsg2, AlrtWinHdr);
                            return false;
                        }
                    }
                }
            }
        }

        function OfficeNameResets() {
            document.getElementById('txtOfficeName').value = "";
            document.getElementById('hdnOfficeID').value = "";
            document.getElementById('<%=btnSaveOfficeName.ClientID %>').value = "Save";
            var radList = document.getElementsByName('rdOfficeName');
            for (var i = 0; i < radList.length; i++) {
                if (radList[i].checked) {
                    radList[i].checked = false;
                }
            }
            return false;
        }

        function extractOfficeNameRow(src, cID) {
            //var eRow = src.parentElement.parentElement;
            //var RI = eRow.rowIndex;
            var CasTbl = document.getElementById("grdOfficeName");
            document.getElementById('hdnOfficeID').value = cID;
            document.getElementById('txtOfficeName').value = src;
            document.getElementById('<%=btnSaveOfficeName.ClientID %>').value = "Update";
        }


        //----------------------------------------OfficeLocation--------------------------
        function OfficeLocationCheckName() {

            var empdeptName = document.getElementById('txtOfficeLocation').value;
            var btnvalue = document.getElementById('btnSaveOfficeLocation').value;
            var TblEmpDept = document.getElementById('grdOfficeLocation');
            var grdlength;
            var AlrtWinHdr = SListForAppMsg.Get("Admin_TestInvestigation_aspx_02") != null ? SListForAppMsg.Get("Admin_TestInvestigation_aspx_02") : "Information";
            var userMsg = SListForAppMsg.Get("Admin_DesignationRelationship_aspx_14") != null ? SListForAppMsg.Get("Admin_DesignationRelationship_aspx_14") : "Enter Location Name";
            var userMsg2 = SListForAppMsg.Get("Admin_DesignationRelationship_aspx_06") != null ? SListForAppMsg.Get("Admin_DesignationRelationship_aspx_06") : "Name already exists";
       
            if (TblEmpDept == null) {
                grdlength = 0;
            }
            else {
                grdlength = TblEmpDept.rows.length;
            }
            if (document.getElementById('txtOfficeLocation').value == "") {
                //var userMsg = SListForApplicationMessages.Get("Admin\\DesignationRelationship.aspx_13");
                if (userMsg != null) {
                    //alert(userMsg);
                    ValidationWindow(userMsg, AlrtWinHdr);
                    return false;
                }
                else {
                    //alert("Enter location Name");
                    ValidationWindow(userMsg, AlrtWinHdr);
                    return false;
                }

            }
            if (btnvalue == 'Save') {
                for (i = 1; i <= grdlength - 1; i++) {
                    var empDeptID = TblEmpDept.rows[i].cells[0].childNodes[0].getAttribute('DiscID');
                    var empdeptname = TblEmpDept.rows[i].cells[1].innerHTML;
                    if (empdeptname.toUpperCase() == empdeptName.toUpperCase()) {
                        //var userMsg = SListForApplicationMessages.Get("Admin\\DesignationRelationship.aspx_7");
                        if (userMsg2 != null) {
                            //alert(userMsg);
                            ValidationWindow(userMsg2, AlrtWinHdr);
                            return false;
                        }
                        else {
                            //  alert("Name already exists");
                            ValidationWindow(userMsg2, AlrtWinHdr);
                            return false;
                        }
                    }
                }
            }
        }

        function OfficeLocationResets() {
            document.getElementById('txtOfficeLocation').value = "";
            document.getElementById('hdnOfficeLocationID').value = "";
            document.getElementById('<%=btnSaveOfficeLocation.ClientID %>').value = "Save";
            var radList = document.getElementsByName('rdOfficeLocation');
            for (var i = 0; i < radList.length; i++) {
                if (radList[i].checked) {
                    radList[i].checked = false;
                }
            }
            return false;
        }

        function extractOfficeLocationRow(src, cID) {
            //var eRow = src.parentElement.parentElement;
            //var RI = eRow.rowIndex;
            var CasTbl = document.getElementById("grdOfficeLocation");
            document.getElementById('hdnOfficeLocationID').value = cID;
            document.getElementById('txtOfficeLocation').value = src;
            document.getElementById('<%=btnSaveOfficeLocation.ClientID %>').value = "Update";
        }
        //------------------------------------------------------------------------
        function checkdate() {
            var validformat = /^\d{2}\/\d{2}\/\d{4}$/ //Basic check for format validity
            if (!validformat.test(document.getElementById('<%=txtJoinDate.ClientID %>').value)) {
                document.getElementById('<%=txtJoinDate.ClientID %>').value = '';
            }
        }
        function checkMailId() {
            var emailID = document.getElementById('txtEmail')
            if ((emailID.value == null) || (emailID.value.trim() != "")) {
                if (echeck(emailID.value) == false) {
                    emailID.value = ""
                    emailID.focus()
                    return false
                }
            }
            return true
        }
        function echeck(str) {

            var at = "@"
            var dot = "."
            var lat = str.indexOf(at)
            var lstr = str.length
            var ldot = str.indexOf(dot)

            var AlrtWinHdr = SListForAppMsg.Get("Admin_TestInvestigation_aspx_02") != null ? SListForAppMsg.Get("Admin_TestInvestigation_aspx_02") : "Information";
            var userMsg = SListForAppMsg.Get("Admin_UserMaster_aspx_24") != null ? SListForAppMsg.Get("Admin_UserMaster_aspx_24") : "Invalid Email-ID";
            if (str.indexOf(at) == -1) {
                //var userMsg = SListForApplicationMessages.Get("Admin\\DesignationRelationship.aspx_14");
                if (userMsg != null) {
                    //alert(userMsg);
                    ValidationWindow(userMsg, AlrtWinHdr);
                    return false;
                }
                else {
                    // alert('Invalid e-mail ID');
                    ValidationWindow(userMsg, AlrtWinHdr);
                    return false
                }

            }

            if (str.indexOf(at) == -1 || str.indexOf(at) == 0 || str.indexOf(at) == lstr) {
                //var userMsg = SListForApplicationMessages.Get("Admin\\DesignationRelationship.aspx_14");
                if (userMsg != null) {
                    // alert(userMsg);
                    ValidationWindow(userMsg, AlrtWinHdr);
                    return false;
                }
                else {
                    // alert('Invalid e-mail ID');
                    ValidationWindow(userMsg, AlrtWinHdr);
                    return false
                }
            }

            if (str.indexOf(dot) == -1 || str.indexOf(dot) == 0 || str.indexOf(dot) == lstr) {
                //var userMsg = SListForApplicationMessages.Get("Admin\\DesignationRelationship.aspx_14");
                if (userMsg != null) {
                    //alert(userMsg);
                    ValidationWindow(userMsg, AlrtWinHdr);
                    return false;
                }
                else {
                    // alert('Invalid e-mail ID');
                    ValidationWindow(userMsg, AlrtWinHdr);
                    return false
                }
            }

            if (str.indexOf(at, (lat + 1)) != -1) {
               // var userMsg = SListForApplicationMessages.Get("Admin\\DesignationRelationship.aspx_14");
                if (userMsg != null) {
                    //alert(userMsg);
                    ValidationWindow(userMsg, AlrtWinHdr);
                    return false;
                }
                else {
                    // alert('Invalid e-mail ID');
                    ValidationWindow(userMsg, AlrtWinHdr);
                    return false
                }
            }

            if (str.substring(lat - 1, lat) == dot || str.substring(lat + 1, lat + 2) == dot) {
                //var userMsg = SListForApplicationMessages.Get("Admin\\DesignationRelationship.aspx_14");
                if (userMsg != null) {
                    //alert(userMsg);
                    ValidationWindow(userMsg, AlrtWinHdr);
                    return false;
                }
                else {
                    //alert('Invalid e-mail ID');
                    ValidationWindow(userMsg, AlrtWinHdr);
                    return false
                }
            }

            if (str.indexOf(dot, (lat + 2)) == -1) {
               // var userMsg = SListForApplicationMessages.Get("Admin\\DesignationRelationship.aspx_14");
                if (userMsg != null) {
                    //alert(userMsg);
                    ValidationWindow(userMsg, AlrtWinHdr);
                    return false;
                }
                else {
                    // alert('Invalid e-mail ID');
                    ValidationWindow(userMsg, AlrtWinHdr);
                    return false
                }
            }

            if (str.indexOf(" ") != -1) {
                //var userMsg = SListForApplicationMessages.Get("Admin\\DesignationRelationship.aspx_14");
                if (userMsg != null) {
                    //alert(userMsg);
                    ValidationWindow(userMsg, AlrtWinHdr);
                    return false;
                }
                else {
                    // alert('Invalid e-mail ID');
                    ValidationWindow(userMsg, AlrtWinHdr);
                    return false
                }
            }

            return true
        }
        function blockNonNumbers(obj, e, allowDecimal, allowNegative) {
            var key;
            var isCtrl = false;
            var keychar;
            var reg;

            if (window.event) {
                key = e.keyCode;
                isCtrl = window.event.ctrlKey
            }
            else if (e.which) {
                key = e.which;
                isCtrl = e.ctrlKey;
            }

            if (isNaN(key)) return true;

            keychar = String.fromCharCode(key);

            // check for backspace or delete, or if Ctrl was pressed
            if (key == 8 || isCtrl) {
                return true;
            }

            reg = /\d/;
            var isFirstN = allowNegative ? keychar == '-' && obj.value.indexOf('-') == -1 : false;
            var isFirstD = allowDecimal ? keychar == '.' && obj.value.indexOf('.') == -1 : false;

            return isFirstN || isFirstD || reg.test(keychar);
        }
        function isNumeric(e, Id) {
            var key; var isCtrl; var flag = 0;
            var txtVal = document.getElementById(Id).value.trim();
            var len = txtVal.split('.');
            if (len.length > 0) {
                flag = 1;
            }
            if (window.event) {
                key = window.event.keyCode;
                if (window.event.shiftKey) {
                    isCtrl = false;
                }
                else {
                    if ((key >= 48 && key <= 57) || (key >= 96 && key <= 105) || (key == 110 && flag == 0) || (key == 8) || (key == 9) || (key == 12) || (key == 27) || (key == 37) || (key == 39) || (key == 46) || (key == 190 && flag == 0)) {
                        isCtrl = true;
                    }
                    else {
                        isCtrl = false;
                    }
                }
            } return isCtrl;
        }
    </script>

</body>
</html>
