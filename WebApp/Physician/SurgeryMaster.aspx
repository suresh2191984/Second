<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SurgeryMaster.aspx.cs" Inherits="Physician_SurgeryMaster" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/PharmacyHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>SurgeryMaster</title>
    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />

    <script src="../Scripts/bid.js" type="text/javascript"></script>

    <script src="../Scripts/animatedcollapse.js" type="text/javascript"></script>

    <script src="../Scripts/jquery-1.2.2.pack.js" type="text/javascript"></script>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <link href="../StyleSheets/DHEBAdder.css" rel="stylesheet" type="text/css" />

    <script src="../Scripts/datetimepicker.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">
        function SetValues(obj) {
            var x = obj.value.split('~');
            document.getElementById('hdnTreatmentplan').value = "";
            document.getElementById('hdnTreatmentplanName').value = "";
            document.getElementById('txtCode').value = x[0];
            document.getElementById('txtDisplayText').value = x[1];
            document.getElementById('btnFinish').value = "Update";
            document.getElementById('chkDelete').checked = false;
            document.getElementById('hdnTreatmentplan').value = x[2];
            document.getElementById('hdnTreatmentplanName').value = x[4];

            //            var temp = Number(x[2]) - Number(1);
            //            var str = "rblTreatmentplan_" + temp;
            //            if (x[2] == document.getElementById(str).value) {
            //                document.getElementById(str).checked = true;
            //            }
        }
        function Validate() {
            if (document.getElementById('txtCode').value == "") {
                alert('Code Field Cannot be empty');
                return false;
            }
            if (document.getElementById('txtDisplayText').value == "") {
                alert('DisplayText Cannot be empty');
                return false;
            }
            if (document.getElementById('txtCode').value != "") {
                var flag = 0;
                if (document.getElementById('btnFinish').value == "Save") {
                    var isTrue = true;
                    if (document.getElementById('hdnTreatmentType').value == "1") {
                        alert('Select any OtherType')
                        return false;
                    }
                    var y = document.getElementById('txtCode').value;
                    var x = document.getElementById('hdnCheckIsUsed').value.split('^');
                    for (i = 0; i < x.length; i++) {
                        if (x[i] == y) {
                            flag = 1;
                        }
                    }
                    if (flag == 1) {
                        alert('Code Already Exists');
                        return false;
                    }
                    else {
                        document.getElementById('hdnStatus').value = "Save";
                        return true;
                    }
                }
                if (document.getElementById('btnFinish').value == "Update") {
                    document.getElementById('hdnStatus').value = "Update";
                }
            }
            return true;
        }
        function IsExists() {


        }
        function checkDelete(obj) {
            document.getElementById('btnFinish').value = "Update";
        }
        function ClearField() {
            document.getElementById('txtCode').value = "";
            document.getElementById('txtDisplayText').value = "";
            document.getElementById('chkDelete').checked = false;
            return true;
        }
    </script>

</head>
<body id="Body1" runat="server" oncontextmenu="return false;">
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
                <uc4:MainHeader ID="MainHeader" runat="server" />
                <uc3:Header ID="ReceptionHeader" runat="server" />
                <input type="hidden" id="hdnStatus" runat="server" />
            </div>
            <div style="float: right;" class="Rightheader">
            </div>
        </div>
        <table border="0" cellpadding="0" cellspacing="0" class="tableborder">
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
                    <div class="contentdata1" runat="server">
                        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                            <ContentTemplate>
                                <uc6:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                                <table cellpadding="0" cellspacing="0" width="800px">
                                    <tr>
                                        <td>
                                            <div>
                                                <table width="100%" class="dataheader2 defaultfontcolor" border="0" cellpadding="0"
                                                    cellspacing="0">
                                                    <tr>
                                                        <td colspan="2" align="center">
                                                            <asp:Label ID="lblmsg" runat="server" meta:resourcekey="lblmsgResource2"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="2" align="center">
                                                            <asp:RadioButtonList ID="rblTreatmentplan" runat="server" RepeatDirection="Horizontal"
                                                                Height="25px" AutoPostBack="true" CellSpacing="10" OnSelectedIndexChanged="rblTreatmentplan_SelectedIndexChanged">
                                                            </asp:RadioButtonList>
                                                            <asp:HiddenField ID="hdnTreatmentplan" runat="server" />
                                                            <asp:HiddenField ID="hdnTreatmentplanName" runat="server" />
                                                            <asp:HiddenField ID="hdnTreatmentType" runat="server" />
                                                        </td>
                                                    </tr>
                                                    <tr id="trTextItems" runat="server">
                                                        <td align="right">
                                                            <asp:Label ID="lblCode" runat="server" Text="Code"></asp:Label>
                                                            <asp:TextBox ID="txtCode" CssClass="Txtboxsmall" runat="server" Width="172px"></asp:TextBox>
                                                        </td>
                                                        <td align="center">
                                                            <asp:Label ID="lblDisplayText" runat="server" Text="DisplayText"></asp:Label>
                                                            <asp:TextBox ID="txtDisplayText" CssClass="Txtboxsmall" runat="server" Width="175px"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                </table>
                                                <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                                    <tr>
                                                        <td align="center">
                                                            <asp:Button ID="btnFinish" Text="Save" runat="server" onmouseover="this.className='btn btnhov'"
                                                                CssClass="btn" onmouseout="this.className='btn'" OnClientClick="javascript:return Validate();"
                                                                OnClick="btnFinish_Click" />
                                                            &nbsp;
                                                            <asp:Button ID="btnCancel" runat="server" Text="Clear" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                                onmouseout="this.className='btn'" Width="52px" OnClientClick="javascript:return ClearField();" />
                                                            &nbsp;
                                                            <asp:CheckBox ID="chkDelete" runat="server" Text="DeActive Code" onclick="checkDelete(this.id);"
                                                                TextAlign="Right" />
                                                            <asp:HiddenField ID="hdnCheckIsUsed" runat="server" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <div id="divPrintarea">
                                                <table width="100%">
                                                    <tr>
                                                        <td>
                                                            <asp:GridView ID="gvSurgeryMaster" runat="server" wrap="wrap" AutoGenerateColumns="False"
                                                                CssClass="mytable1" Width="100%" AllowPaging="True" OnPageIndexChanging="gvSurgeryMaster_PageIndexChanging">
                                                                <Columns>
                                                                    <asp:TemplateField HeaderText="Select">
                                                                        <ItemTemplate>
                                                                            <input id="rdSelect" name="radio" value='<%# Eval("PostOperationFindings") %>' onclick="SetValues(this)"
                                                                                type="radio" />
                                                                        </ItemTemplate>
                                                                        <ItemStyle Width="2%" />
                                                                    </asp:TemplateField>
                                                                    <asp:BoundField DataField="PhysicianName" HeaderText="Code">
                                                                        <ItemStyle Width="25%" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="IPTreatmentPlanName" HeaderText="DisplayText">
                                                                        <ItemStyle Width="25%" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="OperationID" HeaderText="TypeID" Visible="false">
                                                                        <ItemStyle Width="15%" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="CreatedBy" HeaderText="ModifiedBy" Visible="false">
                                                                        <ItemStyle Width="15%" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="ParentName" HeaderText="Type">
                                                                        <ItemStyle Width="15%" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="Prosthesis" Visible="false" HeaderText="DisplayText">
                                                                        <ItemStyle Width="15%" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="Status" HeaderText="IsActive">
                                                                        <ItemStyle Width="15%" />
                                                                    </asp:BoundField>
                                                                </Columns>
                                                                <PagerStyle CssClass="dataheader1" HorizontalAlign="Center" />
                                                                <HeaderStyle CssClass="dataheader1" />
                                                            </asp:GridView>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                </td>
            </tr>
        </table>
        <uc5:Footer ID="Footer1" runat="server" />
    </div>
    </form>
</body>
</html>
