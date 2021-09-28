<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DiseaseburdenReport.aspx.cs"
    Inherits="Corporate_DiseaseburdenReport" meta:resourcekey="PageResource1" %>

<%@ Register Src="~/CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="~/CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="~/Corporate/ComplaintDes.ascx" TagName="ICDCodeReport" TagPrefix="uc2" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Disease Burden</title>
    <link href="../Images/favicon.ico" rel="shortcut icon" />
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>

<link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">
        function validateToDate() {

            if (document.getElementById('txtFDate').value == '') {
                alert('Provide / select value for From date');
                document.getElementById('txtFDate').focus();
                return false;
            }
            if (document.getElementById('txtTDate').value == '') {
                alert('Provide / select value for To date');
                document.getElementById('txtTDate').focus();
                return false;
            }
        }
        function popupprint() {
            var prtContent = document.getElementById('prnReport');
            var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,status=0');
            //alert(WinPrint);
            WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
            WinPrint.close();
        }

        function popupprintD() {
            var prtContent = document.getElementById('tblPatientDetail');
            var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,status=0');
            //alert(WinPrint);
            WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
            WinPrint.close();
        }
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="scriptManager1" runat="server">
    </asp:ScriptManager>
    <div id="wrapper">
        <div id="header">
            <div class="logoleft" style="z-index: 2;">
                <div class="logowrapper">
                    <img alt="" src="<%=LogoPath%>" class="logostyle" />
                </div>
            </div>
            <div class="middleheader">
                <uc4:MainHeader ID="MHead" runat="server" />
                <uc3:Header ID="RHead" runat="server" />
            </div>
            <div style="float: right;" class="Rightheader">
            </div>
        </div>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
                <td width="15%" valign="top" id="menu" style="display: none;">
                    <div id="navigation">
                        <uc1:LeftMenu ID="LeftMenu1" runat="server" />
                    </div>
                </td>
                <td width="85%" valign="top" class="tdspace">
                    <img alt="" onclick="Showmenu();Showhide();" src="../Images/show.png" id="showmenu"
                        style="cursor: pointer;" />
                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td>
                                <asp:GridView ID="gvPatientDetail" runat="server" Width="100%" CellPadding="4" CssClass="mytable1"
                                    AutoGenerateColumns="False" ForeColor="#333333" HorizontalAlign="Left" 
                                    meta:resourcekey="gvPatientDetailResource1">
                                    <Columns>
                                        <asp:TemplateField HeaderText="Patient Name" 
                                            meta:resourcekey="TemplateFieldResource1">
                                            <ItemTemplate>
                                                <asp:Label ID="lblNamePD" Text='<%# Eval("Name") %>' runat="server" 
                                                    meta:resourcekey="lblNamePDResource1"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Employee No" 
                                            meta:resourcekey="TemplateFieldResource2">
                                            <ItemTemplate>
                                                <asp:Label ID="lblPatientNumberPD" Text='<%# Eval("PatientNumber") %>' 
                                                    runat="server" meta:resourcekey="lblPatientNumberPDResource1"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Age" meta:resourcekey="TemplateFieldResource3">
                                            <ItemTemplate>
                                                <asp:Label ID="lblAgePD" Text='<%# Eval("Age") %>' runat="server" 
                                                    meta:resourcekey="lblAgePDResource1"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Visit Date" 
                                            meta:resourcekey="TemplateFieldResource4">
                                            <ItemTemplate>
                                                <asp:Label ID="lblVisitDatePD" Text='<%# Eval("VisitDate") %>' runat="server" 
                                                    meta:resourcekey="lblVisitDatePDResource1"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Visit Type" 
                                            meta:resourcekey="TemplateFieldResource5">
                                            <ItemTemplate>
                                                <asp:Label ID="lblVisitTypePD" Text='<%# Eval("VisitType") %>' runat="server" 
                                                    meta:resourcekey="lblVisitTypePDResource1"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                    <FooterStyle BackColor="White" ForeColor="#000066" />
                                    <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                    <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                    <HeaderStyle CssClass="grdcolor" Font-Bold="True" />
                                </asp:GridView>
                                <Top:TopHeader ID="TopHeader1" runat="server" />
                            </td>
                        </tr>
                    </table>
                    <div class="contentdata1">
                        <ul>
                            <li>
                                <uc6:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                        <table id="tblICDreport" align="center" width="100%">
                            <tr align="center">
                                <td>
                                    <asp:UpdatePanel ID="updatePanel1" runat="server">
                                        <ContentTemplate>
                                            <div class="dataheaderWider">
                                                <table id="tbl" width="100%">
                                                    <tr>
                                                        <td align="left" style="width: 350px">
                                                            <table width="100%">
                                                                <tr>
                                                                    <td style="height: 17px">
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <uc2:ICDCodeReport ID="ICDCodeReport1" runat="server" />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                        <td  align="left" valign="top" style="display:none">
                                                            <asp:CheckBox ID="ChkIcdcode" runat="server" Checked="true" Text="ICD Code" />
                                                        </td>
                                                        <td align="right">
                                                            <asp:Label ID="Rs_FromDate" Text="From Date :" runat="server" meta:resourcekey="Rs_FromDateResource1"></asp:Label>
                                                        </td>
                                                        <td align="left">
                                                            <asp:TextBox ID="txtFDate" CssClass="Txtboxsmall" runat="server" meta:resourcekey="txtFDateResource1"></asp:TextBox>
                                                            <ajc:CalendarExtender ID="CalendarExtender3" Format="dd/MM/yyyy" runat="server" TargetControlID="txtFDate"
                                                                Enabled="True" />
                                                        </td>
                                                        <td align="right">
                                                            <asp:Label ID="Rs_ToDate" Text="To Date:" runat="server" meta:resourcekey="Rs_ToDateResource1"></asp:Label>
                                                        </td>
                                                        <td align="left">
                                                            <asp:TextBox ID="txtTDate" runat="server" meta:resourcekey="txtTDateResource1" CssClass="Txtboxsmall"></asp:TextBox>
                                                            <ajc:CalendarExtender ID="CalendarExtender1" Format="dd/MM/yyyy" runat="server" TargetControlID="txtTDate"
                                                                Enabled="True" />
                                                        </td>
                                                        <td align="left">
                                                            <asp:RadioButtonList ID="rblReportType" RepeatDirection="Horizontal" runat="server"
                                                                meta:resourcekey="rblReportTypeResource1">
                                                                <asp:ListItem Text="Summary" Selected="True" Value="0" meta:resourcekey="ListItemResource1"></asp:ListItem>
                                                                <asp:ListItem Text="Detail" Value="1" meta:resourcekey="ListItemResource2"></asp:ListItem>
                                                                <%--<asp:ListItem Text="Employee" Value="2"></asp:ListItem>
                                                                <asp:ListItem Text="ALL" Value="3"></asp:ListItem>--%>
                                                            </asp:RadioButtonList>
                                                        </td>
                                                        <td align="left" style="display:none">
                                                            <asp:RadioButtonList ID="rblReportType1" RepeatDirection="Horizontal" runat="server">
                                                                <asp:ListItem Text="Employee" Value="0" Selected="True"></asp:ListItem>
                                                                <asp:ListItem Text="ALL" Value="1"></asp:ListItem>
                                                            </asp:RadioButtonList>
                                                        </td>
                                                        <td align="left">
                                                            <asp:Button ID="btnSearch" runat="server" Text="Get Report" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                                onmouseout="this.className='btn'" OnClientClick="javascript:return validateToDate();"
                                                                OnClick="btnSubmit_Click" meta:resourcekey="btnSearchResource1" />
                                                        </td>
                                                        <td style="display:none">
                                                            <asp:ImageButton ID="imgBtnXL" runat="server" ImageUrl="../Images/ExcelImage.GIF"
                                                                ToolTip="Save As Excel" Style="width: 16px" OnClick="imgBtnXL_Click" meta:resourcekey="imgBtnXLResource1" />
                                                        </td>
                                                        <td align="left">
                                                            <asp:LinkButton ID="lnkBack" Text="Back" Font-Underline="True" runat="server" CssClass="details_label_age"
                                                                OnClick="lnkBack_Click" meta:resourcekey="lnkBackResource1"></asp:LinkButton>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <asp:UpdateProgress ID="Progressbar" runat="server">
                                                <ProgressTemplate>
                                                    <asp:Image ID="imgProgressbar" runat="server" ImageUrl="~/Images/working.gif" meta:resourcekey="imgProgressbarResource1" />
                                                    <asp:Label ID="Rs_Pleasewait" Text="Please wait...." runat="server" meta:resourcekey="Rs_PleasewaitResource1"></asp:Label>
                                                </ProgressTemplate>
                                            </asp:UpdateProgress>
                                            <div id="divPrint" style="display: none;" runat="server">
                                                <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                                    <tr>
                                                        <td align="right" style="padding-right: 10px; color: #000000;">
                                                            <b id="printText" runat="server">
                                                                <asp:Label ID="Rs_PrintReport1" Text="Print Report" runat="server" meta:resourcekey="Rs_PrintReport1Resource1"></asp:Label></b>
                                                            <asp:ImageButton ID="btnPrint" runat="server" ImageUrl="~/Images/printer.gif" OnClientClick="return popupprint();"
                                                                ToolTip="Print" meta:resourcekey="btnPrintResource1" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <div id="prnReport">
                                                <table width="100%">
                                                    <tr>
                                                        <td class="dataheaderInvCtrl">
                                                            <asp:Label ID="lblmsg" runat="server" Text="No Records Found" Visible="False" meta:resourcekey="lblmsgResource1"></asp:Label>
                                                            <asp:GridView ID="grdResult" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                                                                CellPadding="4" ForeColor="#333333" GridLines="None" Width="100%" PageSize="5"
                                                                OnRowDataBound="grdResult_RowDataBound" OnPageIndexChanging="grdResult_PageIndexChanging"
                                                                meta:resourcekey="grdResultResource1">
                                                                <HeaderStyle BorderWidth="0px" />
                                                                <PagerStyle CssClass="dataheader1" HorizontalAlign="Center" />
                                                                <Columns>
                                                                    <asp:TemplateField meta:resourcekey="TemplateFieldResource6">
                                                                        <ItemTemplate>
                                                                            <table cellpadding="0" class="dataheaderInvCtrl" style="border-collapse: collapse;"
                                                                                cellspacing="0" border="1" width="100%">
                                                                                <tr>
                                                                                    <td>
                                                                                        <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                                                                            <tr>
                                                                                                <td>
                                                                                                    <table cellpadding="5" cellspacing="0" border="0" width="100%">
                                                                                                        <tr class="Duecolor">
                                                                                                            <td align="left" style="font-weight: bold;">
                                                                                                                <%--<asp:Label ID="Label1" runat="server" Text="ICD Code :"></asp:Label>
                                                                                                                <asp:Label ID="lblICDCode" Text='<%# DataBinder.Eval(Container.DataItem,"ICDCode") %>'
                                                                                                                    runat="server" meta:resourcekey="lblICDCodeResource1"></asp:Label>
                                                                                                                :--%>
                                                                                                                <asp:Label ID="Label2" runat="server" Text="Complaint Name  :"></asp:Label>
                                                                                                                <asp:Label ID="lblComplaintName" Text='<%# DataBinder.Eval(Container.DataItem,"ComplaintName") %>'
                                                                                                                    runat="server" meta:resourcekey="lblComplaintNameResource1"></asp:Label>
                                                                                                            </td>
                                                                                                            <%--<td align="Right" style="font-weight: bold;">
                                                                                                                <asp:Label ID="lblDepName" runat="server" Text="Department Name  :"></asp:Label>
                                                                                                                <asp:Label ID="lblTypeName" Text='<%# DataBinder.Eval(Container.DataItem,"TypeName") %>'
                                                                                                                    runat="server" meta:resourcekey="lblComplaintNameResource1"></asp:Label>
                                                                                                            </td>--%>
                                                                                                    </table>
                                                                                                </td>
                                                                                            </tr>
                                                                                            <tr>
                                                                                                <td class="dataheaderInvCtrl">
                                                                                                    <asp:GridView ID="grdChildResult" runat="server" AutoGenerateColumns="False" Width="100%">
                                                                                                        <PagerSettings Mode="NextPrevious"></PagerSettings>
                                                                                                        <Columns>
                                                                                                            <asp:TemplateField HeaderText="Patient Name" HeaderStyle-HorizontalAlign="Left">
                                                                                                                <ItemTemplate>
                                                                                                                    <asp:Label ID="lblName" Text='<%# Eval("Name") %>' runat="server"></asp:Label>
                                                                                                                </ItemTemplate>
                                                                                                                <ItemStyle Width="25%" HorizontalAlign="Left"/>
                                                                                                            </asp:TemplateField>
                                                                                                            <asp:TemplateField HeaderText="Employee No" HeaderStyle-HorizontalAlign="Left">
                                                                                                                <ItemTemplate>
                                                                                                                    <asp:Label ID="lblPatientNumber" Text='<%# Eval("PatientNumber") %>' runat="server"
                                                                                                                        meta:resourcekey="lblPatientNumberResource1"></asp:Label>
                                                                                                                </ItemTemplate>
                                                                                                                <ItemStyle Width="10%" HorizontalAlign="Left"/>
                                                                                                            </asp:TemplateField>
                                                                                                            <asp:TemplateField HeaderText="Patient Type" HeaderStyle-HorizontalAlign="Left">
                                                                                                                <ItemTemplate>
                                                                                                                    <asp:Label ID="lblAge" Text='<%# Eval("RelationName") %>' runat="server"></asp:Label>
                                                                                                                </ItemTemplate>
                                                                                                                <ItemStyle Width="10%" HorizontalAlign="Left"/>
                                                                                                            </asp:TemplateField>
                                                                                                            <asp:TemplateField HeaderText="Age" HeaderStyle-HorizontalAlign="Left">
                                                                                                                <ItemTemplate>
                                                                                                                    <asp:Label ID="lblAge" Text='<%# Eval("Age") %>' runat="server"></asp:Label>
                                                                                                                </ItemTemplate>
                                                                                                                <ItemStyle Width="10%" HorizontalAlign="Left"/>
                                                                                                            </asp:TemplateField>
                                                                                                            <asp:TemplateField HeaderText="Visit Date" HeaderStyle-HorizontalAlign="Left">
                                                                                                                <ItemTemplate>
                                                                                                                    <asp:Label ID="lblVisitDate" Text='<%# Eval("VisitDate") %>' runat="server"></asp:Label>
                                                                                                                </ItemTemplate>
                                                                                                                <ItemStyle Width="10%" HorizontalAlign="Left"/>
                                                                                                            </asp:TemplateField>
                                                                                                            <asp:TemplateField HeaderText="Department" HeaderStyle-HorizontalAlign="Left">
                                                                                                                <ItemTemplate>
                                                                                                                    <asp:Label ID="lblAge" Text='<%# Eval("CompressedName") %>' runat="server"></asp:Label>
                                                                                                                </ItemTemplate>
                                                                                                                <ItemStyle Width="20%" HorizontalAlign="Left"/>
                                                                                                            </asp:TemplateField>
                                                                                                            <asp:TemplateField HeaderText="Disease type" HeaderStyle-HorizontalAlign="Left">
                                                                                                                <ItemTemplate>
                                                                                                                    <asp:Label ID="lblVisitType" Text='<%# Eval("AliasName") %>' runat="server"></asp:Label>
                                                                                                                </ItemTemplate>
                                                                                                                <ItemStyle Width="15%" HorizontalAlign="Left"/>
                                                                                                            </asp:TemplateField>
                                                                                                        </Columns>
                                                                                                    </asp:GridView>
                                                                                                </td>
                                                                                            </tr>
                                                                                        </table>
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
                                                <table width="100%" align="center">
                                                    <tr>
                                                        <td class="dataheaderInvCtrl">
                                                            <table cellpadding="0" cellspacing="0" border="0" width="100%" >
                                                                <tr>
                                                                    <td class="dataheaderInvCtrl">
                                                                        <asp:GridView ID="gvSummary" runat="server" Width="100%" CellPadding="4" AutoGenerateColumns="False"
                                                                            HorizontalAlign="Left" CssClass="mytable1" DataKeyNames="ICDCode,ComplaintName"
                                                                            OnRowCommand="gvSummary_RowCommand" meta:resourcekey="gvSummaryResource1">
                                                                            <HeaderStyle CssClass="grdcolor" Font-Bold="True" />
                                                                            <FooterStyle BackColor="White" ForeColor="#000066" />
                                                                            <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                                                            <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                                            <Columns>
                                                                                <%--<asp:TemplateField HeaderText="ICDCode" meta:resourcekey="TemplateFieldResource7">
                                                                                    <ItemTemplate>
                                                                                        <asp:Label ID="lblICDS" Text='<%# Eval("ICDCode") %>' runat="server" meta:resourcekey="lblICDSResource1"></asp:Label>
                                                                                    </ItemTemplate>
                                                                                </asp:TemplateField>--%>
                                                                                <asp:TemplateField HeaderText="Complaint Name">
                                                                                    <ItemTemplate>
                                                                                        <asp:Label ID="lblICDNameS" Text='<%# Eval("ComplaintName") %>' runat="server" ></asp:Label>
                                                                                    </ItemTemplate>
                                                                                   <ItemStyle HorizontalAlign="Left" /> 
                                                                                </asp:TemplateField>
                                                                                <asp:TemplateField HeaderText="Depatment name" >
                                                                                    <ItemTemplate>
                                                                                        <asp:Label ID="lblICDS" Text='<%# Eval("TypeName") %>' runat="server" ></asp:Label>
                                                                                    </ItemTemplate>
                                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                                </asp:TemplateField>
                                                                                <asp:TemplateField HeaderText="Patient Count">
                                                                                    <ItemTemplate>
                                                                                        <asp:LinkButton ID="lbtnPatientCount" runat="server" Text='<%# Eval("PatientCount") %>'
                                                                                            CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>' CommandName="OView"
                                                                                            Font-Underline="True"></asp:LinkButton>
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
                                                <table width="100%" align="center">
                                                    <tr>
                                                        <td class="dataheaderInvCtrl">
                                                            <table cellpadding="0" cellspacing="0" border="0" width="100%" >
                                                                <tr>
                                                                    <td class="dataheaderInvCtrl">
                                                                        <asp:GridView ID="grdDetails" runat="server" Width="100%" CellPadding="4" AutoGenerateColumns="False"
                                                                            HorizontalAlign="Left" CssClass="mytable1"   >
                                                                            <HeaderStyle CssClass="grdcolor" Font-Bold="True" />
                                                                            <FooterStyle BackColor="White" ForeColor="#000066" />
                                                                            <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                                                            <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                                            <Columns>
                                                                                <asp:TemplateField HeaderText="Disease">
                                                                                    <ItemTemplate>
                                                                                        <asp:Label ID="lblICDNameS" Text='<%# Eval("ComplaintName") %>' runat="server" ></asp:Label>
                                                                                    </ItemTemplate>
                                                                                   <ItemStyle HorizontalAlign="Left" /> 
                                                                                </asp:TemplateField>
                                                                                <asp:TemplateField HeaderText="ICD Code">
                                                                                    <ItemTemplate>
                                                                                        <asp:Label ID="lblICDNameS" Text='<%# Eval("VersionNo") %>' runat="server" ></asp:Label>
                                                                                    </ItemTemplate>
                                                                                   <ItemStyle HorizontalAlign="Left" /> 
                                                                                </asp:TemplateField>
                                                                                <asp:TemplateField HeaderText="Disease Onset">
                                                                                    <ItemTemplate>
                                                                                        <asp:Label ID="lblICDNameS" Text='<%# Eval("AliasName") %>' runat="server" ></asp:Label>
                                                                                    </ItemTemplate>
                                                                                   <ItemStyle HorizontalAlign="Left" /> 
                                                                                </asp:TemplateField>
                                                                                <asp:TemplateField HeaderText="Name" >
                                                                                    <ItemTemplate>
                                                                                        <asp:Label ID="lblICDS" Text='<%# Eval("Name") %>' runat="server" ></asp:Label>
                                                                                    </ItemTemplate>
                                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                                </asp:TemplateField>
                                                                                <asp:TemplateField HeaderText="Emp No" >
                                                                                    <ItemTemplate>
                                                                                        <asp:Label ID="lblICDS" Text='<%# Eval("PatientNumber") %>' runat="server" ></asp:Label>
                                                                                    </ItemTemplate>
                                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                                </asp:TemplateField>
                                                                                <asp:TemplateField HeaderText="Patient Type" >
                                                                                    <ItemTemplate>
                                                                                        <asp:Label ID="lblICDS" Text='<%# Eval("RelationName") %>' runat="server" ></asp:Label>
                                                                                    </ItemTemplate>
                                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                                </asp:TemplateField>
                                                                                <asp:TemplateField HeaderText="Age" >
                                                                                    <ItemTemplate>
                                                                                        <asp:Label ID="lblICDS" Text='<%# Eval("Age") %>' runat="server" ></asp:Label>
                                                                                    </ItemTemplate>
                                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                                </asp:TemplateField>
                                                                                <asp:TemplateField HeaderText="Sex" >
                                                                                    <ItemTemplate>
                                                                                        <asp:Label ID="lblICDS" Text='<%# Eval("SEX") %>' runat="server" ></asp:Label>
                                                                                    </ItemTemplate>
                                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                                </asp:TemplateField>
                                                                                <asp:TemplateField HeaderText="Depatment name" >
                                                                                    <ItemTemplate>
                                                                                        <asp:Label ID="lblICDS" Text='<%# Eval("CompressedName") %>' runat="server" ></asp:Label>
                                                                                    </ItemTemplate>
                                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                                </asp:TemplateField>
                                                                                <asp:TemplateField HeaderText="Residing location" >
                                                                                    <ItemTemplate>
                                                                                        <asp:Label ID="lblICDS" Text='<%# Eval("Comments") %>' runat="server" ></asp:Label>
                                                                                    </ItemTemplate>
                                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                                </asp:TemplateField>
                                                                                <asp:TemplateField HeaderText="Consulting Doctor" >
                                                                                    <ItemTemplate>
                                                                                        <asp:Label ID="lblICDS" Text='<%# Eval("PreviousKnownName") %>' runat="server" ></asp:Label>
                                                                                    </ItemTemplate>
                                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                                </asp:TemplateField>
                                                                                <asp:TemplateField HeaderText="Dr Speciality" >
                                                                                    <ItemTemplate>
                                                                                        <asp:Label ID="lblICDS" Text='<%# Eval("Religion") %>' runat="server" ></asp:Label>
                                                                                    </ItemTemplate>
                                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                                </asp:TemplateField>
                                                                                <asp:TemplateField HeaderText="Encounter Date" >
                                                                                    <ItemTemplate>
                                                                                        <asp:Label ID="lblICDS" Text='<%# Eval("VisitDate") %>' runat="server" ></asp:Label>
                                                                                    </ItemTemplate>
                                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                                </asp:TemplateField>
                                                                                <asp:TemplateField HeaderText="Encounter Location" >
                                                                                    <ItemTemplate>
                                                                                        <asp:Label ID="lblICDS" Text='<%# Eval("Status") %>' runat="server" ></asp:Label>
                                                                                    </ItemTemplate>
                                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                                </asp:TemplateField>
                                                                            </Columns>
                                                                        </asp:GridView>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <asp:Panel ID="pnlPatientDetail" runat="server" CssClass="modalPopup dataheaderPopup"
                                                Width="80%" Style="display: none">
                                                <table width="100%">
                                                    <tr>
                                                        <td align="right" style="padding-right: 10px; color: #000000;">
                                                            <b id="B1" runat="server">
                                                                <asp:Label ID="Rs_PrintReport" Text="Print Report" runat="server" meta:resourcekey="Rs_PrintReportResource1"></asp:Label>
                                                            </b>
                                                            <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/Images/printer.gif"
                                                                OnClientClick="return popupprintD();" ToolTip="Print" meta:resourcekey="ImageButton1Resource1" />
                                                        </td>
                                                    </tr>
                                                </table>
                                                <table id="tblPatientDetail" cellpadding="2" cellspacing="0" border="0" width="100%"
                                                    runat="server" class="dataheaderInvCtrl" style="display: block;">
                                                    <tr id="Tr1" class="grdcolor" runat="server">
                                                        <td id="Td1" runat="server" align="left">
                                                            <asp:Label ID="lblDepName" runat="server" Text="Department Name  :"></asp:Label>
                                                            <asp:Label ID="lblIcdCodePD" runat="server"></asp:Label>
                                                        </td>
                                                        <td id="Td4" runat="server" align="right">
                                                            <asp:Label ID="Label3" runat="server" Text="Complaint Name  :"></asp:Label>
                                                            <asp:Label ID="lblIcdNamePD" runat="server"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr id="Tr2" class="defaultfontcolor" runat="server">
                                                        <td id="Td2" runat="server" colspan="2">
                                                            <asp:GridView ID="GridView1" runat="server" Width="100%" CellPadding="4" CssClass="mytable1"
                                                                AutoGenerateColumns="False" ForeColor="#333333" HorizontalAlign="Left">
                                                                <Columns>
                                                                    <asp:TemplateField HeaderText="Patient Name">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblNamePD" Text='<%#Eval("Name") %>' runat="server"></asp:Label>
                                                                        </ItemTemplate>
                                                                        <ItemStyle HorizontalAlign="Left" /> 
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Employee No">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblPatientNumberPD" Text='<%#Eval("PatientNumber") %>' runat="server"></asp:Label>
                                                                        </ItemTemplate>
                                                                        <ItemStyle HorizontalAlign="Left" /> 
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Age">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblAgePD" Text='<%#Eval("Age") %>' runat="server"></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Visit Date">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblVisitDatePD" Text='<%#Eval("VisitDate") %>' runat="server"></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Visit Type">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblVisitTypePD" Text='<%#Eval("VisitType") %>' runat="server"></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                </Columns>
                                                                <FooterStyle BackColor="White" ForeColor="#000066" />
                                                                <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                                                <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                                <HeaderStyle CssClass="grdcolor" Font-Bold="True" />
                                                            </asp:GridView>
                                                        </td>
                                                    </tr>
                                                    <tr id="Tr3" runat="server" align="center">
                                                        <td id="Td3" align="center" runat="server" colspan="2">
                                                            <asp:Button ID="BtnPatientDetail" runat="server" Text="Close" CssClass="btn" />
                                                        </td>
                                                    </tr>
                                                </table>
                                                <ajc:ModalPopupExtender ID="ModelPopPatientDetail" runat="server" TargetControlID="btnR"
                                                    PopupControlID="pnlPatientDetail" BackgroundCssClass="modalBackground" OkControlID="BtnPatientDetail"
                                                    DynamicServicePath="" Enabled="True" />
                                                <input type="button" id="btnR" runat="server" style="display: none;" /></asp:Panel>
                                            </div>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
        </table>
        <uc5:Footer ID="Footer1" runat="server" />
    </div>
    </form>
</body>
</html>
