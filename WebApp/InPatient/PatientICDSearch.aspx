<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PatientICDSearch.aspx.cs"
    Inherits="InPatient_PatientICDSearch" %>

<%@ Register Src="../CommonControls/PatientSearch.ascx" TagName="PatientSearch" TagPrefix="uc2" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>ICD Status Search</title>
    <script type="text/javascript">

        function SelectVisit(id, vid, pid, PName) {

            chosen = "";
            var len = document.forms[0].elements.length;
            for (var i = 0; i < len; i++) {
                if (document.forms[0].elements[i].type == "radio") {
                    document.forms[0].elements[i].checked = false;
                }
            }
            document.getElementById(id).checked = true;
            document.getElementById("hdnVID").value = vid;
            document.getElementById("hdnPID").value = pid;
            document.getElementById("hdnPNAME").value = PName;
        }

        function CheckVisitID() {

            if (document.getElementById('hdnVID').value == '') {
             var userMsg = SListForApplicationMessages.Get('InPatient\\PatientICDSearch.aspx_1');
                if (userMsg != null) {
                    alert(userMsg);
                                   return false;
                    
                }

                else {

                alert('Select visit detail');
                return false;
                }
            }
            else {

                document.getElementById('hdnVisitDetail').value = document.getElementById('ddlVisitActionName').options[document.getElementById('ddlVisitActionName').selectedIndex].innerHTML;

                return true;
            }

        }

        function ChechVisitDate() {
            //            if (document.getElementById('txtPatientNumber').value.trim() == '') {
            //                if (document.getElementById('txtPname').value.trim() == '') {
            //                    alert('Please Enter Patient Name');
            //                    document.form1.txtPname.focus();
            //                    return false;
            //                }
            //            }
            if (document.getElementById('txtFrom').value == '' || document.getElementById('txtTo').value == '') {

                if (document.getElementById('txtFrom').value != '' && document.getElementById('txtTo').value =='') {
                 var userMsg = SListForApplicationMessages.Get('InPatient\\PatientICDSearch.aspx_3');
                if (userMsg != null) {
                    alert(userMsg);
                                   return false;
                    
                }

                else {
                alert('Provide / select value for To date');
                      return false;
                }
                    document.form1.txtFrom.focus();
                    return false;
                }
                if (document.getElementById('txtFrom').value == '' && document.getElementById('txtTo').value != '') {
                 var userMsg = SListForApplicationMessages.Get('InPatient\\PatientICDSearch.aspx_4');
                if (userMsg != null) {
                    alert(userMsg);
                                   return false;
                    
                }

                else {
                alert('Provide / select value for From date');
                      return false;
                }
                    document.form1.txtFrom.focus();
                    return false;
                }
            }
            return true;

        }
    
    </script>

    <style type="text/css">
        .style1
        {
            height: 33px;
        }
    </style>

</head>
<body onload="pageLoadFocus('txtFrom');" oncontextmenu="return false;">
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ctlTaskScriptMgr" runat="server">
    </asp:ScriptManager>
      <Attune:Attuneheader ID="Attuneheader" runat="server" />
                    <div class="contentdata">
                        <table class="w-100p searchPanel">
                            <tr>
                                <td>
                                    <table class="w-100p">
                                        <tr>
                                            <td class="defaultfontcolor a-left">
                                                <asp:Label ID="Rs_ICDStatus" Text="ICD Status" runat="server"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="drpICDStatus" runat="server" ToolTip="Select ICD Status" CssClass ="ddl"
                                                    Height="16px">
                                                    <asp:ListItem Selected="True">Pending</asp:ListItem>
                                                    <asp:ListItem>Completed</asp:ListItem>
                                                    <asp:ListItem>Ignored</asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                            <td class="defaultfontcolor">
                                                <asp:Label ID="Rs_PatientName" Text="Patient Name" runat="server"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtPname" CssClass ="Txtboxsmall" runat="server"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="style1">
                                                <asp:Label ID="lblFrom" Text="From" runat="server"></asp:Label>
                                            </td>
                                            <td class="style1">
                                                <asp:TextBox ID="txtFrom"  CssClass ="Txtboxsmall" runat="server"></asp:TextBox>
                                                <asp:ImageButton ID="ImgBntCalcFrom" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                    CausesValidation="False" />
                                                <cc1:MaskedEditExtender ID="MaskedEditExtender5" runat="server" TargetControlID="txtFrom"
                                                    Mask="99/99/9999" MessageValidatorTip="true" OnFocusCssClass="MaskedEditFocus"
                                                    OnInvalidCssClass="MaskedEditError" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left"
                                                    ErrorTooltipEnabled="True" />
                                                <cc1:MaskedEditValidator ID="MaskedEditValidator5" runat="server" ControlExtender="MaskedEditExtender5"
                                                    ControlToValidate="txtFrom" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                    Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                    ValidationGroup="MKE" />
                                                <cc1:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="txtFrom"
                                                    Format="dd/MM/yyyy" PopupButtonID="ImgBntCalcFrom" />
                                            </td>
                                            <td class="style1">
                                                <asp:Label ID="lblTo" Text="To" runat="server"></asp:Label>
                                            </td>
                                            <td class="style1">
                                                <asp:TextBox ID="txtTo" runat="server" CssClass ="Txtboxsmall" ></asp:TextBox>
                                                <asp:ImageButton ID="ImgBntCalcTo" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                    CausesValidation="False" />
                                                <cc1:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="txtTo"
                                                    Mask="99/99/9999" MessageValidatorTip="true" OnFocusCssClass="MaskedEditFocus"
                                                    OnInvalidCssClass="MaskedEditError" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left"
                                                    ErrorTooltipEnabled="True" />
                                                <cc1:MaskedEditValidator ID="MaskedEditValidator1" runat="server" ControlExtender="MaskedEditExtender5"
                                                    ControlToValidate="txtTo" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                    Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                    ValidationGroup="MKE" />
                                                <cc1:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="txtTo"
                                                    Format="dd/MM/yyyy" PopupButtonID="ImgBntCalcTo" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="defaultfontcolor">
                                              <asp:Label ID="Rs_VisitType" Text="Visit Type" runat="server"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlType" CssClass ="ddl" runat="server">
                                                    <asp:ListItem Selected="True">Both</asp:ListItem>
                                                    <asp:ListItem>OP</asp:ListItem>
                                                    <asp:ListItem>IP</asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td class="a-center">
                                    <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn" OnClientClick="return ChechVisitDate()"
                                        onmouseover="this.className='btn btnhov'" 
                                        onmouseout="this.className='btn'" OnClick="btnSearch_Click" Width="90px" />
                                    <asp:Button ID="btnCancel" runat="server" Text="Cancel" OnClick="btnCancel_Click"
                                        CssClass="btn" onmouseover="this.className='btn btnhov'" 
                                        onmouseout="this.className='btn'" Width="98px" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;
                                    <asp:GridView ID="grdResult" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                                        DataKeyNames="PatientVisitID,VisitType" OnPageIndexChanging="grdResult_PageIndexChanging"
                                        CssClass="mytable1 gridView" PagerSettings-Mode="NextPrevious" PageSize="15" OnRowCommand="grdResult_RowCommand"
                                        OnRowDataBound="grdResult_RowDataBound">
                                        <PagerStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                        <%--<PagerTemplate>
                                            <tr>
                                                <td colspan="9" align="center">
                                                    <asp:ImageButton ID="lnkPrev" CommandName="Page" runat="server" CausesValidation="false"
                                                        CommandArgument="Prev" ImageUrl="~/Images/previousimage.png" Width="18px" Height="18px" />
                                                    <asp:ImageButton ID="lnkNext" CommandName="Page" runat="server" CausesValidation="false"
                                                        CommandArgument="Next" ImageUrl="~/Images/nextimage.png" Width="18px" Height="18px" />
                                                </td>
                                            </tr>
                                        </PagerTemplate>
                                        --%><HeaderStyle CssClass="dataheader1" />
                                        <PagerSettings FirstPageText="" LastPageText="" Mode="NumericFirstLast" NextPageText=""
                                            PageButtonCount="5" PreviousPageText="" />
                                        <Columns>
                                            <asp:BoundField Visible="false" DataField="PatientVisitID" HeaderText="PatientVisitId" />
                                            <asp:BoundField DataField="PatientName" HeaderText="Name" ItemStyle-Width="25%" ItemStyle-HorizontalAlign="Left">
                                                <ItemStyle HorizontalAlign="Left" Width="25%"></ItemStyle>
                                            </asp:BoundField>
                                            <asp:BoundField DataField="PatientID" ItemStyle-Width="6%" HeaderText="No." Visible="true">
                                                <ItemStyle Width="6%"></ItemStyle>
                                            </asp:BoundField>
                                            <asp:BoundField DataField="PatientAge" ItemStyle-Width="9%" HeaderText="Age" Visible="true">
                                                <ItemStyle Width="9%"></ItemStyle>
                                            </asp:BoundField>
                                            <asp:TemplateField HeaderText="Visit Type">
                                                <ItemTemplate>
                                                    <asp:Label ID="LblGrdVisitType" runat="server" Text='<%# Bind("VisitType") %>'></asp:Label>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("VisitType") %>'></asp:TextBox>
                                                </EditItemTemplate>
                                                <ItemStyle HorizontalAlign="Center" Width="6%" />
                                            </asp:TemplateField>
                                            <asp:BoundField DataFormatString="{0:dd MMM yyyy}" DataField="VisitDate" HeaderText="Visit Date"
                                                ItemStyle-Width="10%">
                                                <ItemStyle Width="10%"></ItemStyle>
                                            </asp:BoundField>
                                            <%--<asp:BoundField DataField="PhysicianName" HeaderText="Consulting Doctor" ItemStyle-Width="0%">
                                                <ItemStyle Width="0%"></ItemStyle>
                                            </asp:BoundField>
                                            --%>
                                            <asp:TemplateField HeaderText="Consulting Doctor">
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="txtGrdConsultant" runat="server" Text='<%# Bind("PhysicianName") %>'></asp:TextBox>
                                                </EditItemTemplate>
                                                <ItemTemplate>
                                                    <asp:Label ID="lblGrdConsultant" runat="server" Text='<%# Bind("PhysicianName") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="AOD" ItemStyle-Width="10%">
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="txtGrdAdmissionDT" runat="server" Text='<%# Bind("AdmissionDate") %>'></asp:TextBox>
                                                </EditItemTemplate>
                                                <ItemTemplate>
                                                    <asp:Label ID="lblGrdAdmissionDT" runat="server" Text='<%# Bind("AdmissionDate","{0:dd MMM yyyy}") %>'></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle Width="10%"></ItemStyle>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="DOD" ItemStyle-Width="10%">
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="txtGrdDischargedDT" runat="server" Text='<%# Bind("DischargedDT") %>'></asp:TextBox>
                                                </EditItemTemplate>
                                                <ItemTemplate>
                                                    <asp:Label ID="lblGrdDischargedDT" runat="server" Text='<%# Bind("DischargedDT","{0:dd MMM yyyy}") %>'></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle Width="10%"></ItemStyle>
                                            </asp:TemplateField>
                                            <asp:BoundField Visible="false" DataField="VisitType" HeaderText="Visit Type" />
                                            <asp:BoundField DataField="OrgID" Visible="false" HeaderText="Address">
                                                <ItemStyle></ItemStyle>
                                            </asp:BoundField>
                                            <asp:TemplateField HeaderText="Status">
                                                <EditItemTemplate>
                                                    <asp:DropDownList ID="ddlICDStatus" runat="server" DataTextField="ICDCodeStatus"
                                                        DataValueField="ICDCodeStatus" SelectedValue='<%# Bind("ICDCodeStatus") %>'>
                                                    </asp:DropDownList>
                                                </EditItemTemplate>
                                                <ItemTemplate>
                                                    <asp:DropDownList ID="ddlICDStatus" runat="server" Text='<%# Bind("ICDCodeStatus") %>'>
                                                        <asp:ListItem Text="Pending"></asp:ListItem>
                                                        <asp:ListItem Text="Completed"></asp:ListItem>
                                                        <asp:ListItem Text="Ignored"></asp:ListItem>
                                                    </asp:DropDownList>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Edit">
                                                <ItemTemplate>
                                                    <asp:Label Visible="false" ID="lblPV" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"PatientVisitId")  %>'></asp:Label>
                                                    <asp:LinkButton ID="btngrdedit" Text="Edit" ForeColor="Red" runat="server" CommandName="OEdit"
                                                        CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>'></asp:LinkButton>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Update">
                                                <ItemTemplate>
                                                    <asp:Button ID="btngrdupdate" runat="server" Text="Update" ForeColor="Red" CommandName="OUpdate"
                                                        CssClass="btn" CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblMessage" runat="server"></asp:Label>
                                    <asp:Label ID="lblResult" runat="server" CssClass="casesheettext"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </div>
               
        <input type="hidden" id="hdnPNAME" name="PName" runat="server" />
        <input type="hidden" id="hdnPID" name="pid" runat="server" />
        <input type="hidden" id="hdnVID" name="vid" runat="server" />
        <input type="hidden" id="hdnVisitDetail" runat="server" />
       <Attune:Attunefooter ID="Attunefooter" runat="server" />     
         <asp:HiddenField ID ="hdnMessages" runat ="server" />
    </form>
</body>
</html>
