<%@ Page Language="C#" AutoEventWireup="true" CodeFile="OrgWiseCollectionReport.aspx.cs"
    Inherits="Reports_OrgWiseCollectionReport" %>

<%@ Register Src="~/CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="~/CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<%@ Register Src="~/CommonControls/IncomeFromOtherSource.ascx" TagName="IncomeFromOtherSource"
    TagPrefix="uc2" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Organization wise Collection</title>
    <link href="../Images/favicon.ico" rel="shortcut icon" />
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <link type="text/css" href="../StyleSheets/jquery-ui-1.8.19.custom.css" rel="stylesheet" />

    <script language="javascript" type="text/javascript">

        function clearContextText() {
            $('#divOPDWCR').hide();

        }
        function alpha(e) {
            var k;
            document.all ? k = e.keyCode : k = e.which;
            return ((k > 64 && k < 91) || (k > 96 && k < 123) || k == 8 || k == 32 || k == 46 || (k >= 48 && k <= 57));
        }
        function validateToDate() {

            if (document.getElementById('<%= txtFDate.ClientID %>').value == '') {
                alert('Provide / select value for From date');
                document.getElementById('<%= txtFDate.ClientID %>').focus();
                return false;
            }
            if (document.getElementById('<%= txtTDate.ClientID %>').value == '') {
                alert('Provide / select value for To date');
                document.getElementById('<%= txtTDate.ClientID %>').focus();
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
    </script>

    <style type="text/css">
        .ui-datepicker
        {
            font-size: 8pt !important;
        }
    </style>
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
                                <uc6:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>

                        <script type="text/javascript" src="../Scripts/jquery-1.7.2.min.js"></script>

                        <script type="text/javascript" src="../Scripts/jquery-ui-1.8.19.custom.min.js"></script>

                        <script type="text/javascript">
                            $(function() {
                                $("#txtFDate").datepicker({
                                    changeMonth: true,
                                    changeYear: true,
                                    maxDate: 0,
                                    yearRange: '2008:2030'
                                });
                                $("#txtTDate").datepicker({
                                    changeMonth: true,
                                    changeYear: true,
                                    maxDate: 0,
                                    yearRange: '2008:2030'
                                })
                            });

                        </script>

                        <table id="tblCollectionOPIP" align="center" width="100%">
                            <tr align="center">
                                <td align="left">
                                    <asp:UpdatePanel ID="updatePanel1" runat="server">
                                        <ContentTemplate>
                                            <div class="dataheaderWider">
                                                <table id="tbl" width="100%">
                                                    <tr>
                                                        <td style="width: 8%">
                                                            <asp:Label ID="Rs_FromDate" Text="From Date :" runat="server"></asp:Label>
                                                        </td>
                                                        <td style="width: 8%">
                                                            <asp:TextBox CssClass="Txtboxsmall" Width="70px" ID="txtFDate" runat="server"></asp:TextBox>
                                                        </td>
                                                        <td style="width: 8%">
                                                            <asp:Label ID="Rs_ToDate" Text="To Date:" runat="server"></asp:Label>
                                                        </td>
                                                        <td style="width: 8%">
                                                            <asp:TextBox CssClass="Txtboxsmall" Width="70px" ID="txtTDate" runat="server"></asp:TextBox>
                                                        </td>
                                                        <td align="left" style="width: 20%">
                                                            <asp:Panel ID="pnPatientType" Width="100%" GroupingText="Patient Type" runat="server">
                                                                <asp:RadioButtonList ID="rblVisitType" RepeatDirection="Horizontal" RepeatColumns="3"
                                                                    runat="server">
                                                                    <asp:ListItem Text="OP" Selected="True" Value="0"></asp:ListItem>
                                                                    <asp:ListItem Text="IP" Value="1"></asp:ListItem>
                                                                    <asp:ListItem Text="OP&IP" Value="-1"></asp:ListItem>
                                                                </asp:RadioButtonList>
                                                            </asp:Panel>
                                                        </td>
                                                        <td style="width: 22%">
                                                            <asp:Panel ID="pnReportType" runat="server" Width="100%" GroupingText="Report Type">
                                                                <asp:RadioButtonList ID="rblReportType" RepeatDirection="Horizontal" runat="server">
                                                                    <asp:ListItem Text="Summary" Selected="True" Value="0"></asp:ListItem>
                                                                    <asp:ListItem Text="Detailed" Value="1"></asp:ListItem>
                                                                </asp:RadioButtonList>
                                                            </asp:Panel>
                                                        </td>
                                                        <td align="left" style="width: 10%">
                                                            <asp:Button ID="btnSubmit" runat="server" Text="Get Report" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                                onmouseout="this.className='btn'" OnClientClick="javascript:return validateToDate();"
                                                                OnClick="btnSubmit_Click" />
                                                        </td>
                                                        <td style="width: 8%">
                                                            <asp:ImageButton ID="imgBtnXL" runat="server" ImageUrl="../Images/ExcelImage.GIF"
                                                                ToolTip="Save As Excel" OnClick="imgBtnXL_Click" />
                                                        </td>
                                                        <td align="right">
                                                            <asp:LinkButton ID="lnkBack" Font-Underline="True" runat="server" CssClass="details_label_age"
                                                                OnClick="lnkBack_Click">Back&nbsp;&nbsp;</asp:LinkButton>
                                                        </td>
                                                    </tr>
                                                </table>
                                                <table id="Table1" width="100%">
                                                    <tr>
                                                        <td>
                                                            <table>
                                                                <tr>
                                                                    <td valign="top">
                                                                        <asp:Label ID="lblOrgs" runat="server" Text="Select organization"></asp:Label>
                                                                    </td>
                                                                    <td valign="top">
                                                                        <asp:Panel ID="pHeader" runat="server" CssClass="">
                                                                            <table border="0">
                                                                                <tr>
                                                                                    <td class="cpHeader" runat="server" id="tdimg">
                                                                                        <asp:Image ID="ImgCollapse" runat="server" />
                                                                                        <asp:Label ID="lblText" runat="server" />
                                                                                    </td>
                                                                                </tr>
                                                                            </table>
                                                                        </asp:Panel>
                                                                        <asp:Panel ID="pBody" runat="server">
                                                                            <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                                                                                <ContentTemplate>
                                                                                    <%--<asp:DropDownList ID="ddlTrustedOrg" AutoPostBack="true" onchange="javascript:clearContextText();"
                                                                                     runat="server" CssClass="ddl" OnSelectedIndexChanged="ddlTrustedOrg_SelectedIndexChanged">
                                                                                    </asp:DropDownList>--%>
                                                                                    <asp:CheckBox ID="Chkboxusers" Text="ALL" runat="server" CssClass="smallfon" onclick="checkAll(this)"
                                                                                        Checked="false" />
                                                                                    <asp:CheckBoxList ID="chekTrustedOrg" runat="server" RepeatColumns="6" RepeatDirection="Horizontal"
                                                                                        RepeatLayout="Table" CssClass="smallfon">
                                                                                    </asp:CheckBoxList>
                                                                                </ContentTemplate>
                                                                            </asp:UpdatePanel>
                                                                        </asp:Panel>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                </table>
                                                <table>
                                                    <tr>
                                                        <td>
                                                            <ajc:CollapsiblePanelExtender ID="CollapsiblePanelExtender1" runat="server" TargetControlID="pBody"
                                                                CollapseControlID="pHeader" ExpandControlID="pHeader" Collapsed="true" TextLabelID="lblText"
                                                                CollapsedText="Show Oranization Lists " ExpandedText="Hide Oranization Lists"
                                                                ImageControlID="ImgCollapse" ExpandedImage="../Images/ShowBids.gif" CollapsedImage="../Images/HideBids.gif">
                                                            </ajc:CollapsiblePanelExtender>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <asp:UpdateProgress ID="Progressbar" runat="server">
                                                <ProgressTemplate>
                                                    <asp:Image ID="imgProgressbar" runat="server" ImageUrl="~/Images/working.gif" />
                                                    <asp:Label ID="Rs_Pleasewait" Text="Please wait...." runat="server"></asp:Label>
                                                </ProgressTemplate>
                                            </asp:UpdateProgress>
                                            <div id="divPrint" style="display: none;" runat="server">
                                                <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                                    <tr>
                                                        <td align="right" style="padding-right: 10px; color: #000000;">
                                                            <b id="printText" runat="server">
                                                                <asp:Label ID="Rs_PrintReport" Text="Print Report" runat="server"></asp:Label></b>
                                                            <asp:ImageButton ID="btnPrint" runat="server" ImageUrl="~/Images/printer.gif" OnClientClick="return popupprint();"
                                                                ToolTip="Print" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <div id="prnReport">
                                                <div id="divOPDWCR" runat="server" style="display: block;">
                                                    <asp:GridView ID="gvIPCreditMainGrandTotal" runat="server" AutoGenerateColumns="False"
                                                         Width="100%" ForeColor="#333333">
                                                        <Columns>
                                                            <asp:BoundField DataField="PatientName" HeaderText="" ItemStyle-HorizontalAlign="Left">
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="BillAmount" HeaderText="Bill Amount"></asp:BoundField>
                                                            <asp:BoundField DataField="TaxAmount" HeaderText="Tax"></asp:BoundField>
                                                            <asp:BoundField DataField="Discount" HeaderText="Discount"></asp:BoundField>
                                                            <asp:BoundField DataField="ServiceCharge" HeaderText="Service charge"></asp:BoundField>
                                                            <asp:BoundField DataField="NetValue" HeaderText="Net Amount"></asp:BoundField>
                                                            <asp:BoundField DataField="ReceivedAmount" HeaderText="Received Amount"></asp:BoundField>
                                                            <asp:BoundField DataField="RefundAmt" HeaderText="Refund Amount"></asp:BoundField>
                                                            <asp:BoundField DataField="Cash" HeaderText="Cash"></asp:BoundField>
                                                            <asp:BoundField DataField="Cards" HeaderText="Cards"></asp:BoundField>
                                                            <asp:BoundField DataField="Cheque" HeaderText="Cheque"></asp:BoundField>
                                                            <asp:BoundField DataField="DD" HeaderText="DD"></asp:BoundField>
                                                            <asp:BoundField DataField="Coupon" HeaderText="Coupon"></asp:BoundField>
                                                            <asp:BoundField DataField="Due" HeaderText="Due"></asp:BoundField>
                                                            <asp:BoundField DataField="WriteOffAmount" HeaderText="Write-Off amount"></asp:BoundField>
                                                        </Columns>
                                                        <FooterStyle BackColor="White" ForeColor="#000066" />
                                                        <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Right" />
                                                        <RowStyle BackColor="White" Font-Bold="True" HorizontalAlign="Right" />
                                                        <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                        <HeaderStyle Font-Bold="True" HorizontalAlign="Left" />
                                                    </asp:GridView>
                                                    <br />
                                                    <br />
                                                    <asp:GridView ID="gvOrgwisePatientSummary" runat="server" AutoGenerateColumns="False"
                                                        OnRowDataBound="gvOrgwisePatientSummary_RowDataBound" Visible="true" Width="100%"
                                                        HorizontalAlign="Right">
                                                        <Columns>
                                                            <asp:TemplateField HeaderText="Location wise Collection Report" ItemStyle-HorizontalAlign="Left">
                                                                <ItemTemplate>
                                                                    <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                                                        <tr>
                                                                            <td align="left" style="height: 25px;">
                                                                                <b>
                                                                                    <asp:Label ID="lblOrg" Text="Organization Name: " runat="server"></asp:Label>
                                                                                </b>
                                                                                <asp:Label runat="server" ID="lblOrgName" Text='<%# DataBinder.Eval(Container.DataItem, "OrganisationName") %>'></asp:Label>
                                                                                <asp:Label runat="server" Visible="false" ID="lblOrgID" Text='<%# DataBinder.Eval(Container.DataItem, "OrgID") %>'></asp:Label>
                                                                                <b>
                                                                                    <%--<asp:Label ID="lblRowID" runat="server" Text='<% Container.DataItemIndex %>'></asp:Label>--%>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:GridView ID="gvDatewisePatientDetail" runat="server" AutoGenerateColumns="False"
                                                                                    OnRowDataBound="gvDatewisePatientDetail_RowDataBound" Width="100%" ForeColor="#333333">
                                                                                    <Columns>
                                                                                        <asp:TemplateField>
                                                                                            <ItemTemplate>
                                                                                                <table width="100%">
                                                                                                    <tr align="left">
                                                                                                        <td align="left">
                                                                                                            <b>
                                                                                                                <asp:Label runat="server" Visible="false" ID="lblOrgID" Text='<%# DataBinder.Eval(Container.DataItem, "OrgID") %>'></asp:Label>
                                                                                                                <asp:Label runat="server" ID="lblDate" Text="Date: "></asp:Label>
                                                                                                            </b>
                                                                                                            <asp:Label runat="server" ID="lblBillDate" Text='<%# DataBinder.Eval(Container.DataItem, "BillDate") %>'></asp:Label></b>
                                                                                                            <asp:Label runat="server" ID="lblPatientCount" Text="0"></asp:Label>
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                    <tr>
                                                                                                        <td>
                                                                                                            <asp:GridView ID="gvOrgwisePatientDetail" runat="server" AutoGenerateColumns="False"
                                                                                                                OnRowDataBound="gvOrgwisePatientDetail_RowDataBound" Width="100%" ForeColor="#333333"
                                                                                                                CssClass="mytable1">
                                                                                                                <Columns>
                                                                                                                    <asp:BoundField DataField="PatientNumber" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="50px"
                                                                                                                        HeaderText="Patient number"></asp:BoundField>
                                                                                                                    <asp:TemplateField HeaderText="Name" HeaderStyle-HorizontalAlign="Left" Visible="true">
                                                                                                                        <ItemTemplate>
                                                                                                                            <asp:Label runat="server" ID="lblPatientName" Text='<%# DataBinder.Eval(Container.DataItem, "PatientName") %>'></asp:Label>
                                                                                                                        </ItemTemplate>
                                                                                                                        <ItemStyle HorizontalAlign="Left" />
                                                                                                                    </asp:TemplateField>
                                                                                                                    <asp:BoundField DataField="Age" HeaderText="Age"></asp:BoundField>
                                                                                                                    <asp:BoundField DataField="BillNumber" HeaderText="Bill number"></asp:BoundField>
                                                                                                                    <asp:BoundField DataField="BillAmount" HeaderText="Bill amount"></asp:BoundField>
                                                                                                                    <asp:BoundField DataField="TaxAmount" HeaderText="Tax"></asp:BoundField>
                                                                                                                    <asp:BoundField DataField="ServiceCharge" HeaderText="Service charge"></asp:BoundField>
                                                                                                                    <asp:BoundField DataField="Discount" HeaderText="Discount"></asp:BoundField>
                                                                                                                    <asp:BoundField DataField="RefundAmt" HeaderText="Refund amount"></asp:BoundField>
                                                                                                                    <asp:BoundField DataField="NetValue" HeaderText="Net amount"></asp:BoundField>
                                                                                                                    <asp:BoundField DataField="ReceivedAmount" HeaderText="Received amount"></asp:BoundField>
                                                                                                                    <asp:BoundField DataField="Cash" HeaderText="Cash"></asp:BoundField>
                                                                                                                    <asp:BoundField DataField="Cards" HeaderText="Cards"></asp:BoundField>
                                                                                                                    <asp:BoundField DataField="Cheque" HeaderText="Cheque"></asp:BoundField>
                                                                                                                    <asp:BoundField DataField="DD" HeaderText="DD"></asp:BoundField>
                                                                                                                    <asp:BoundField DataField="Coupon" HeaderText="Coupon"></asp:BoundField>
                                                                                                                    <asp:BoundField DataField="Due" HeaderText="Due"></asp:BoundField>
                                                                                                                    <asp:BoundField DataField="WriteOffAmount" HeaderText="Write-Off amount"></asp:BoundField>
                                                                                                                    <asp:BoundField DataField="RefphysicianName" HeaderText="Physician"></asp:BoundField>
                                                                                                                    <asp:BoundField DataField="ClientTypeName" HeaderText="Hospital"></asp:BoundField>
                                                                                                                    <asp:BoundField DataField="ClientName" HeaderText="Client"></asp:BoundField>
                                                                                                                    <asp:BoundField DataField="Location" HeaderText="Location"></asp:BoundField>
                                                                                                                </Columns>
                                                                                                                <RowStyle HorizontalAlign="Right" />
                                                                                                                <HeaderStyle CssClass="grdcolor" Font-Bold="True" HorizontalAlign="Right" />
                                                                                                            </asp:GridView>
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
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                        </Columns>
                                                    </asp:GridView>
                                                </div>
                                                <br />
                                            </div>
                                            </div>
                                        </ContentTemplate>
                                        <Triggers>
                                            <asp:PostBackTrigger ControlID="imgBtnXL" />
                                        </Triggers>
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

<script type="text/javascript" language="javascript">

    function checkAll(obj1) {
        var checkboxCollection = document.getElementById('chekTrustedOrg').getElementsByTagName('input');

        for (var i = 0; i < checkboxCollection.length; i++) {
            if (checkboxCollection[i].type.toString().toLowerCase() == "checkbox") {
                checkboxCollection[i].checked = obj1.checked;
            }
        }
    }

       

</script>

