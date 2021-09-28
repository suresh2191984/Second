<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Test.aspx.cs" Inherits="Lab_Test" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/PhysicianHeader.ascx" TagName="PhyHeader" TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Test Search</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>

   <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />

    <script src="../Scripts/bid.js" type="text/javascript"></script>

    <script src="../Scripts/animatedcollapse.js" type="text/javascript"></script>

    <script src="../Scripts/jquery-1.2.2.pack.js" type="text/javascript"></script>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script src="../Scripts/datetimepicker.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">
        function CallPrint() {
            hideColumn();
            var prtContent = document.getElementById('divPrintarea');
            var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,sta­tus=0');
            WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
            WinPrint.close();
            ShowColumn();

            return false;
        }
        function GetPatientDetails(PID) {

            var pID = PID.split('~');
            //            alert("Se"+PID.search('~'));
            //            alert(pID.length);
            //Venkat (27 Year(s))-(Urn NO :~12

            if (pID.length > 1) {
                document.getElementById('hdnSearchPatientID').value = '';
                document.getElementById('hdnSearchPatientID').value = pID[1];
            }
            else {
                pID = document.getElementById('hdnSearchPatientID').value = '';
            }
        }
        function ValidateFields() {
            if (document.getElementById('hdnSearchPatientID').value == '') {
                alert('Please Select a Patient From AutoComplete');
                return false;
            }
        }
    </script>

    <style type="text/css">
        .style1
        {
            height: 32px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
        <Services>
            <asp:ServiceReference Path="~/InventoryWebService.asmx" />
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
                <uc4:MainHeader ID="MHead" runat="server" />
                <uc3:Header ID="UsrHeader1" runat="server" />
                <uc7:PhyHeader ID="PhyHeader1" runat="server" />
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
                    <div class="contentdata">
                        <ul>
                            <li>
                                <uc6:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                        <table width="100%" cellpadding="0" cellspacing="0" border="0" class="defaultfontcolor">
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td width="50%" align="left">
                                    <asp:Panel ID="pnlFilter" runat="server" CssClass="defaultfontcolor">
                                        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="defaultfontcolor">
                                            <tr>
                                                <td class="colorforcontent" style="width: 30%;" height="23" align="left">
                                                    <div id="ACX2plus1" style="display: none;">
                                                        &nbsp;<img src="../Images/showBids.gif" alt="Show" width="15" height="15" align="top"
                                                            style="cursor: pointer" onclick="showResponses('ACX2plus1','ACX2minus1','ACX2responses1',1);" />
                                                        <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plus1','ACX2minus1','ACX2responses1',1);">
                                                            &nbsp;Filter Result</span>
                                                    </div>
                                                    <div id="ACX2minus1" style="display: block;">
                                                        &nbsp;<img src="../Images/hideBids.gif" alt="hide" width="15px" height="15px" align="top"
                                                            style="cursor: pointer" onclick="showResponses('ACX2plus1','ACX2minus1','ACX2responses1',0);" />
                                                        <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plus1','ACX2minus1','ACX2responses1',0);">
                                                        &nbsp;Filter Result
                                                    </div>
                                                </td>
                                                <td height="23" align="right">
                                                </td>
                                            </tr>
                                            <tr class="tablerow" id="ACX2responses1" style="display: block;">
                                                <td colspan="2">
                                                    <div class="filterdataheader2">
                                                        <table class="defaultfontcolor" width="100%" border="0" style="margin: 6px">
                                                            <tr>
                                                                <td>
                                                                    <asp:RadioButton ID="rdoRetest" Text="Retest" runat="server" GroupName="TestType" />
                                                                </td>
                                                                <td style="display: none">
                                                                    <asp:RadioButton ID="rdoRefelectTest" Text="Reflex Test" runat="server" GroupName="TestType" />
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="lblPatientName" Text="Patient Name :" runat="server"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtPatientName" runat="server" onblur="ConverttoUpperCase(this.id); GetPatientDetails(this.value);" CssClass="Txtboxsmall"></asp:TextBox>
                                                                    <ajc:AutoCompleteExtender ID="AutoCompleteProduct" runat="server" TargetControlID="txtPatientName"
                                                                        EnableCaching="false" FirstRowSelected="true" CompletionInterval="100" CompletionSetCount="10"
                                                                        MinimumPrefixLength="2" CompletionListCssClass="listtwo" CompletionListItemCssClass="listitemtwo"
                                                                        CompletionListHighlightedItemCssClass="hoverlistitemtwo" ServiceMethod="GetPatientListWithDetails"
                                                                        ServicePath="~/InventoryWebService.asmx">
                                                                    </ajc:AutoCompleteExtender>
                                                                    &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblBillNumber" Text="Bill Number :" runat="server"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtBillNumber" runat="server" CssClass="Txtboxsmall"></asp:TextBox>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblSampleName" Text="Sample Name :" runat="server"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:DropDownList ID="ddlSampleName" Width="180px" runat="server" ToolTip="Select Sample">
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                            <tr align="center">
                                                                <td colspan="6">
                                                                    <asp:Button ID="btnSearch" CssClass="btn" runat="server" Text="Go" OnClientClick="return ValidateFields();"
                                                                        OnClick="btnSearch_Click" TabIndex="8" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </td>
                            </tr>
                            <td>
                                <table border="0" align="center" width="100%">
                                    <tr>
                                        <td>
                                            <asp:GridView ID="grdResult" EmptyDataText="No Results Found." EmptyDataRowStyle-CssClass="dataheader1"
                                                runat="server" OnRowDataBound="grdResult_RowDataBound" CssClass="mytable1" AutoGenerateColumns="False"
                                                Width="100%" meta:resourcekey="grdResultResource1">
                                                <PagerStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                                <HeaderStyle CssClass="dataheader1" />
                                                <PagerSettings FirstPageText="" LastPageText="" Mode="NumericFirstLast" NextPageText=""
                                                    PageButtonCount="5" PreviousPageText="" />
                                                <Columns>
                                                    <asp:BoundField Visible="false" DataField="TestID" HeaderText="Test ID" />
                                                    <asp:BoundField Visible="false" DataField="PatientID" HeaderText="Patient ID" />
                                                    <asp:BoundField Visible="false" DataField="VisitID" HeaderText="VisitID" />
                                                    <asp:BoundField Visible="false" DataField="UID" HeaderText="UID" />
                                                    <asp:BoundField Visible="false" DataField="ClientID" HeaderText="ClientID" />
                                                    <asp:BoundField Visible="false" DataField="AccessionNumber" HeaderText="AccessionNumber" />
                                                    <asp:TemplateField HeaderText="Investigation ID" Visible="false">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblInvestigationID" Text='<%# Eval("InvestigationID") %>' runat="server"></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Type" Visible="false">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblType" Text='<%# Eval("Type") %>' Visible="false" runat="server"></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="OrderedUID" Visible="false">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblOrderedUID" Text='<%# Eval("OrderedUID") %>' runat="server"></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Select" ItemStyle-HorizontalAlign="Left" HeaderStyle-Width="20px"
                                                        meta:resourcekey="TemplateFieldResource1">
                                                        <ItemTemplate>
                                                            <asp:CheckBox ID="ChkSel" runat="server" ToolTip="Select Patient" GroupName="PatientSelect"
                                                                meta:resourcekey="rdSelResource1" />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="PatientNumber" HeaderText="Patient No" ItemStyle-HorizontalAlign="Left"
                                                        HeaderStyle-HorizontalAlign="Left" />
                                                    <asp:BoundField DataField="PatientName" HeaderText="Patient Name" ItemStyle-HorizontalAlign="Left"
                                                        HeaderStyle-HorizontalAlign="Left" meta:resourcekey="BoundFieldResource4" />
                                                    <asp:TemplateField HeaderText="Investigation Name" ItemStyle-HorizontalAlign="Left"
                                                        HeaderStyle-HorizontalAlign="Left">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblInvestigationName" Text='<%# Eval("InvestigationName") %>' runat="server"></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="SampleDesc" HeaderText="Sample Name" ItemStyle-HorizontalAlign="Left"
                                                        HeaderStyle-HorizontalAlign="Left" />
                                                    <asp:BoundField DataField="ReferingPhysicianName" HeaderText="Referring Physician"
                                                        ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" />
                                                    <asp:BoundField DataField="PhoneNo" HeaderText="Patient PhoneNo" ItemStyle-HorizontalAlign="Left"
                                                        HeaderStyle-HorizontalAlign="Left" />
                                                    <asp:BoundField DataField="Location" HeaderText="Collection Center" ItemStyle-HorizontalAlign="Left"
                                                        HeaderStyle-HorizontalAlign="Left" />
                                                    <asp:BoundField DataField="VisitDate" DataFormatString="{0:dd/MMM/yy hh:mm tt}" HeaderText="Visit Date"
                                                        ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" />
                                                    <asp:BoundField DataField="Status" HeaderText="Status" ItemStyle-HorizontalAlign="Left"
                                                        HeaderStyle-HorizontalAlign="Left" />
                                                    <asp:TemplateField HeaderText="AccessionNumber" Visible="false">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblAccessionNumber" Text='<%# Eval("AccessionNumber") %>' runat="server"></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                </Columns>
                                            </asp:GridView>
                                        </td>
                                    </tr>
                                    <tr id="aRow" style="display: none;" runat="server">
                                        <td id="Td1" class="defaultfontcolor" runat="server" align="center">
                                            <asp:Label ID="Rs_Selectapatient" runat="server" Text="Select a patient and one of the following" />
                                            <asp:DropDownList ID="dList" Visible="false" runat="server" CssClass="ddlTheme">
                                                <%--<asp:ListItem Text="Make Bill Entry" Value="1"></asp:ListItem> --%>
                                               <%-- <asp:ListItem Text="Collect sample" Value="2"></asp:ListItem>
                                                <asp:ListItem Text="Investigation Capture" Value="3"></asp:ListItem>--%>
                                            </asp:DropDownList>
                                            <asp:DropDownList ID="dList1" Visible="false" runat="server" CssClass="ddlsmall">
                                                <asp:ListItem Text="Order Investigation" Value="1"></asp:ListItem>
                                                <asp:ListItem Text="Collect sample" Value="2"></asp:ListItem>
                                            </asp:DropDownList>
                                            <asp:Button ID="bGo" runat="server" Text="Go" CssClass="btn" OnClientClick="return ValidatePatientName()"
                                                onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" OnClick="bGo_Click" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
            </tr>
        </table>
        </td> </tr> </table>
    </div>
    <asp:HiddenField ID="hdnTestID" runat="server" />
    <asp:HiddenField ID="hdnPatientID" runat="server" />
    <asp:HiddenField ID="hdnSelectedPatientID" runat="server" />
    <asp:HiddenField ID="hdnstatus" runat="server" />
    <asp:HiddenField ID="hdnrdosave" runat="server" />
    <asp:HiddenField ID="hdnrdosearch" runat="server" />
    <asp:HiddenField ID="hdnRoleUser" runat="server" />
    <asp:HiddenField ID="hdnUserID" runat="server" />
    <asp:HiddenField ID="hdnvid" runat="server" />
    <asp:HiddenField ID="hdnUID" runat="server" />
    <asp:HiddenField ID="hdnClientID" runat="server" />
    <asp:HiddenField ID="hdnAccessionNumber" runat="server" />
    <asp:HiddenField ID="hdnSearchPatientID" runat="server" />
    </td> </tr> </table>
    <uc5:Footer ID="Footer1" runat="server" />
    <asp:Button ID="btnNoLog" runat="server" Style="display: none" meta:resourcekey="btnNoLogResource1" />
    </div>

    <script language="javascript" type="text/javascript">

        function SelectRow(rid, TestID, PID, status, vid, UID, ClientID, AccessionNumber) {
            chosen = "";

            //            alert(rid);

            //            var len = document.forms[0].elements.length;
            //            for (var i = 0; i < len; i++) {
            //                if (document.forms[0].elements[i].type == "radio") {
            //                    document.forms[0].elements[i].checked = false;
            //                }
            //            }
            //            document.getElementById(rid).checked = true;
            document.getElementById('<%= hdnTestID.ClientID %>').value = TestID;
            document.getElementById('<%= hdnPatientID.ClientID %>').value = PID;
            document.getElementById('<%= hdnstatus.ClientID %>').value = status;
            document.getElementById('<%= hdnvid.ClientID %>').value = vid;
            document.getElementById('<%= hdnUID.ClientID %>').value = UID;
            document.getElementById('<%= hdnClientID.ClientID %>').value = ClientID;
            document.getElementById('<%= hdnAccessionNumber.ClientID %>').value = AccessionNumber;

        }
        function ValidatePatientName() {

            if (document.getElementById('hdnPatientID').value == '') {

                alert('Select patient name');
                return false;
            }
            //            return CheckVisitID();
        }
        
        
    </script>

    </form>
</body>
</html>
