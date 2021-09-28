<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PendingPhysioSearch.aspx.cs"
    Inherits="Dialysis_PendingPhysioSearch" meta:resourcekey="PageResource1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/PatientHeader.ascx" TagName="PatientHeader" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc4" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc8" %>
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="UserHeader" TagPrefix="uc9" %>
<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<%@ Register Src="../CommonControls/DateSelection.ascx" TagName ="DateSelect" TagPrefix="DateCtrl" %>
<%@ Register src="../CommonControls/IPClientTpaInsurance.ascx" tagname="IPClientTpaInsurance" tagprefix="uc5" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat='server'>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Pending Procedures</title>
    <%-- <link href="../StyleSheets/Style.css" rel="stylesheet" type="text/css" />--%>
    <link href="../StyleSheets/DHEBAdder.css" rel="stylesheet" type="text/css" />

    <script src="../Scripts/bid.js" type="text/javascript"></script>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />

    <script language="javascript" type="text/javascript">


        function pValidationTreatment() {

            if (document.getElementById("OPid").value == '') {
                alert('Select a patient ');
                return false;
            }
        }

        function GetProcID(Rid, pid, parentVisitID, procID) {
            var len = document.forms[0].elements.length;
            for (var i = 0; i < len; i++) {
                if (document.forms[0].elements[i].type == "radio") {
                    document.forms[0].elements[i].checked = false;
                }
            }
            document.getElementById(Rid).checked = true;
            document.getElementById('OPid').value = pid;
            //document.getElementById('hdnProcId').value = 0;
            document.getElementById('hdnProcId').value = procID;
            document.getElementById('hdnParentVisitID').value = parentVisitID;
        }
        function alertMesage() {
            if (confirm('Do you want to delete this pending procedure?')) {
                //alert('delete');
                return true;
            }
            else {
                //alert('No');
                return false;
            }
        }
    </script>
    
</head>
<body oncontextmenu="return false;">
    <form id="form2" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="True">
    <Services>
        <asp:ServiceReference Path="~/OPIPBilling.asmx"/>
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
                <uc1:MainHeader ID="MainHeader" runat="server" />
                <uc9:UserHeader ID="UserHeader1" runat="server" />
                <%--<uc3:PatientHeader ID="patientHeader" runat="server" />--%>
            </div>
            <div style="float: right;" class="Rightheader">
            </div>
        </div>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
                <td width="15%" valign="top" id="menu" style="display: block;">
                    <div id="navigation">
                        <uc4:LeftMenu ID="LeftMenu1" runat="server" />
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
                    <div class="contentdata">
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>
                                <asp:HiddenField runat="server" ID="hdnvistType" />
                                <asp:HiddenField runat="server" ID="hdnPatientPhysioDtlID" />
                                <input type="hidden" id="hdnDiagnosisItems" runat="server" >
                                    <table id="tblSelectOption" runat="server" border="0" cellpadding="0" 
                                        cellspacing="0" style="display: block" width="100%">
                                        <tr runat="server">
                                            <td runat="server">
                                                <uc8:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                                            </td>
                                        </tr>
                                        <tr runat="server">
                                            <td runat="server">
                                                &nbsp;
                                            </td>
                                        </tr>
                                    </table>
                                    <asp:Panel ID="pnlSearch" runat="server" CssClass="dataheader2">
                                        <table runat="server" align="center" border="0" cellpadding="0" cellspacing="0" width="100%">
                                            <tr>
                                                <td id="tdPatientNo" runat="server" align="left" style="display:none">
                                                    <asp:Label ID="Rs_PatientNo" runat="server" Text="Patient No"></asp:Label>
                                                </td>
                                                <td id="tdPatientNum" align="left" runat="server" style="display:none">
                                                    <asp:TextBox ID="txtPatientNo" runat="server" Width="180px" CssClass="Txtboxmedium"></asp:TextBox>
                                                </td>
                                                <td id="tdEmpNo" style="display: none;" runat="server" align="left">
                                                    <asp:Label ID="Label1" runat="server" Text="Employee No"></asp:Label>
                                                </td>
                                                <td id="tdEmpNum" style="display: none;" runat="server" align="left">
                                                    <asp:TextBox ID="txtEmpNo" runat="server" CssClass="Txtboxsmall"></asp:TextBox>
                                                </td>                                                                                               
                                                <td id="Td2" runat="server" align="left">
                                                    <asp:Label ID="Rs_PatientName" runat="server" Text="Patient Name"></asp:Label>
                                                </td>
                                                <td id="Td5" runat="server" align="left">
                                                    <asp:TextBox Width="180px" ID="txtName" runat="server" CssClass="Txtboxmedium"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>                                                 
                                                <td id="Td3" runat="server" align="left" style="display:none">
                                                    <asp:Label ID="Label2" runat="server" Text="Procedure"></asp:Label>
                                                </td>
                                                <td id="Td4" runat="server" colspan="2" style="display:none">
                                                    <asp:TextBox CssClass="Txtboxmedium" ID="txtProcedure" Width="180px" Height="18px" onfocus="chkPros();"
                                                        runat="server"></asp:TextBox>
                                                    <ajc:AutoCompleteExtender ID="AutoCompleteExtender3" runat="server" TargetControlID="txtProcedure"
                                                        EnableCaching="False" MinimumPrefixLength="2" CompletionInterval="0" FirstRowSelected="false"
                                                        OnClientItemSelected="IAmSelected" CompletionListCssClass="wordWheel listMain .box"
                                                        CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                        ServiceMethod="GetQuickBillItems" ServicePath="~/OPIPBilling.asmx" DelimiterCharacters=""
                                                        Enabled="True">
                                                    </ajc:AutoCompleteExtender>
                                                </td>                                                
                                            </tr>                                                
                                        </table>
                                        <table runat="server" align="center" border="0" cellpadding="0" cellspacing="0" width="100%">
                                            <tr align="left">
                                                <td>
                                                    <DateCtrl:DateSelect ID="dtSearch" runat="server" />
                                                </td>
                                            </tr>
                                            <tr runat="server">
                                                <td runat="server">
                                                    &nbsp;
                                                </td>
                                            </tr>
                                        </table>
                                        <table runat="server" border="0" width=80%" align="center">
                                            <tr>
                                                <td id="Td1" runat="server" align="center">
                                                    <asp:Button ID="btnSearch" runat="server" CssClass="btn" OnClick="btnSearch_Click"
                                                        Text="Search" />
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                    <table id="tblPendingPhysio" runat="server" border="0" cellpadding="0" 
                                        cellspacing="0" style="display: block" width="100%">
                                        <tr runat="server" class="defaultfontcolor">
                                            <td runat="server">
                                                <table border="0" cellpadding="4" cellspacing="0"  
                                                    width="100%">
                                                     
                                                    <tr style="height: 10px;">
                                                        <td align="center" style="font-weight: normal; color: #000;">
                                                            <input id="OPid" name="OPid" type="hidden" />
                                                            <asp:GridView EmptyDataText="No matching records found" ID="gvPendingPhysio" runat="server" AllowPaging="True" 
                                                                AutoGenerateColumns="False" CssClass="mytable1"
                                                                OnPageIndexChanging="gvPendingPhysio_PageIndexChanging" 
                                                                OnRowCommand="gvPendingPhysio_RowCommand"
                                                                OnRowDataBound="gvPendingPhysio_RowDataBound" PageSize="20">
                                                                <HeaderStyle CssClass ="dataheader1" />
                                                                <PagerSettings Mode="NumericFirstLast" />
                                                                <Columns>
                                                                    <asp:TemplateField HeaderText="Select">
                                                                        <ItemTemplate>
                                                                            <%--   <input name="MyRadioButton" type="radio"  value='<%# Eval("OperationID") %>' />--%>
                                                                            <asp:RadioButton ID="rdSel" runat="server" GroupName="PatientSelect" 
                                                                                ToolTip="Select Row" />
                                                                        </ItemTemplate>
                                                                        <ItemStyle Width="5%" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Patient Name">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblName" runat="server" Text='<%#Bind("Name") %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                        <ItemStyle Width="14%" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Patient No">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblPatientNumber" runat="server" 
                                                                                Text='<%#Bind("PatientNumber") %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                        <ItemStyle Width="8%" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Age">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblAge" runat="server" Text='<%#Bind("Age") %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                        <ItemStyle Width="8%" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Phone Number">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblMobileNumber" runat="server" 
                                                                                Text='<%#Bind("MobileNumber") %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                        <ItemStyle Width="10%" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Address">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblParentName" runat="server" Text='<%#Bind("Address") %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                        <ItemStyle Width="14%" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Procedure Name">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblProcedureName" runat="server" Text='<%#Bind("ProcedureDesc") %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                        <ItemStyle Width="14%" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Employee No.">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblEmployeeNumber" runat="server" Text='<%#Bind("EmployeeNumber") %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                        <ItemStyle Width="8%" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Next Review Date">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblNextReview" runat="server" Text='<%#Bind("NextReview") %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                        <ItemStyle Width="14%" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Procedure ID" Visible="false">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblProcedureID" runat="server" Text='<%#Bind("RelationTypeId") %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                        <ItemStyle Width="14%" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Todays Visit" Visible="false">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblTodaysVisit" runat="server" Text='<%#Bind("IsConfidential") %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                        <ItemStyle Width="14%" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Todays Visit" Visible="false">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblTodaysVisitDate" runat="server" Text='<%#Bind("RegistrationDTTM") %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                        <ItemStyle Width="14%" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Close">
                                                                        <ItemTemplate>
                                                                            <asp:ImageButton ID="imgDelete" runat="server" CommandArgument='<%# String.Format("{0} ~ {1}",Eval("RelationTypeId"),Eval("PatientID")) %>' OnClientClick="return alertMesage();" 
                                                                            CommandName="Delete" ImageUrl="~/Images/Delete.jpg"/>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>                                                                    
                                                                </Columns>
                                                            </asp:GridView>
                                                        </td>
                                                    </tr>
                                                    <tr style="display: none;">
                                                        <td>
                                                          
                                                            <uc5:IPClientTpaInsurance ID="IPClientTpaInsurance1" runat="server" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td align="center" align="center">
                                                            <asp:Button ID="btnGo" runat="server" CssClass="btn" OnClick="btnGo_Click1" 
                                                                OnClientClick="return pValidationTreatment()" Text="Go" />
                                                            <asp:Button ID="btnConfirmVisit" runat="server" CssClass="btn" 
                                                                OnClientClick="return pValidationTreatment()" 
                                                                Text="Make Visit to Physiotherapy" onclick="btnConfirmVisit_Click" />                                                            
                                                            <asp:HiddenField ID="hdnPatientID" runat="server" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                    <asp:HiddenField ID="hdnOrgID" runat="server" Value = "0" />
                                    <asp:HiddenField ID="hdnProcedureID" runat="server" Value = "0" />
                                    <asp:HiddenField ID="hdnIsCorpOrg" runat ="server" Value ="0" />
                                    <asp:HiddenField ID="hdnProcId" runat="server" Value="0" />
                                    <asp:HiddenField ID="hdnParentVisitID" runat="server" Value="0" />
                                </input>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                </td>
            </tr>
        </table>
        <script type ="text/javascript">
            function chkPros() {
                var sval = 'PRO';
                var sRateID = -1;
                var pvalue = -1;
                var pVisitID = -1;
                var IsMapped;
                var OrgID = '<%= OrgID%>';
                var IsMapped = 'N';
                sval = sval + '~' + OrgID + '~' + sRateID + '~' + pvalue + '~' + pVisitID + '~' + IsMapped;
                $find('AutoCompleteExtender3').set_contextKey(sval);
            }
            function IAmSelected(source, eventArgs) {
                var list = eventArgs.get_value().split('^');
                if (list.length > 0) {
                    document.getElementById('hdnProcedureID').value = list[0];
                }
            }
    </script>
        <uc2:Footer ID="Footer1" runat="server" />
    </div>
    </form>
</body>
</html>
