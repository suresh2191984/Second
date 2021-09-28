<%@ Page Language="C#" AutoEventWireup="true" CodeFile="BannerMaster.aspx.cs" Inherits="Admin_BannerMaster" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/PhysicianHeader.ascx" TagName="DocHeader" TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc9" %>
<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <script src="../Scripts/datetimepicker.js" type="text/javascript"></script>
     <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
            
        function CheckAllRole(obj1) {
            var checkboxCollection = document.getElementById('chkbxlstRole').getElementsByTagName('input');
            for (var i = 0; i < checkboxCollection.length; i++) {
                if (checkboxCollection[i].type.toString().toLowerCase() == "checkbox") {
                    checkboxCollection[i].checked = obj1.checked;
                }
            }
        }
        function CheckStartDt() {
            NewCal('<%=txtStartDt.ClientID %>', 'ddmmyyyy', true, 12)
            document.getElementById('txtStartDt').focus();
            return true;
        }
        function CheckEndDt() {
            NewCal('<%=txtEndDt.ClientID %>', 'ddmmyyyy', true, 12)
            document.getElementById('txtEndDt').focus();
            return true;
        }
        function ChkStartDate() {
            var hdnCurrentDate = document.getElementById('hdnCurrentDate').value;
            var chooseDate = document.getElementById('txtStartDt').value;
            var D1 = new Date(hdnCurrentDate);
            var D2 = new Date(chooseDate);
            difference_in_milliseconds = D2 - D1;
            if (difference_in_milliseconds < 0) {
                alert("Please Select Future Date..!");
                document.getElementById('txtStartDt').value = '';
                document.getElementById('txtEndDt').value = '';
                document.getElementById('txtStartDt').focus();
                return false;
            }
            else {
                return true;
            }
        }

        function ChkEndDate() {
            var hdnStartDate = document.getElementById('txtStartDt').value;
            var chooseDate = document.getElementById('txtEndDt').value;
            var hdnCurrentDate = document.getElementById('hdnCurrentDate').value;
            var D1 = new Date(hdnStartDate);
            var D2 = new Date(chooseDate);
            var D3 = new Date(hdnCurrentDate);
            difference_in_milliseconds = D2 - D1;
            difference_in_milliseconds2 = D2 - D3;
            if (difference_in_milliseconds < 0 || difference_in_milliseconds2 < 0) {
                alert("Please Select Future Date..!");
                document.getElementById('txtEndDt').value = '';
                document.getElementById('txtEndDt').focus();
                return false;
            }
            else {
                return true;
            }
        }

        function count(txt) {
            var lbl = document.getElementById("lblCount");
            lbl.innerHTML = 1000 - txt.value.length;
        }

        function ChkField() {
            if (document.getElementById('txtbannertext').value == '') {
                alert('Please Enter The Banner Text');                
                document.getElementById('txtbannertext').value = '';
                document.getElementById('txtbannertext').focus();
                return false;
            }
            var flag = 0;
            var checkboxCollection = document.getElementById('chkbxlstRole').getElementsByTagName('input');
            for (var i = 0; i < checkboxCollection.length; i++) {
                if (checkboxCollection[i].type.toString().toLowerCase() == "checkbox") {
                    if (checkboxCollection[i].checked == true) {
                        flag = 1;
                    }
                }
            }

            if (flag == 0) {
                alert('Select a Role type');
                document.getElementById('chkbxlstRole').focus();
                return false;
            }
            if (document.getElementById('txtStartDt').value == '') {
                alert('Please Enter The Start Date');
                document.getElementById('txtStartDt').value = '';
                document.getElementById('txtStartDt').focus();
                return false;
            }
            if (document.getElementById('txtEndDt').value == '') {
                alert('Please Enter The End Date');
                document.getElementById('txtEndDt').value = '';
                document.getElementById('txtEndDt').focus();
                return false;
            }
        }

        function Reset() {
            document.getElementById('txtbannertext').value = '';
            document.getElementById('txtStartDt').value = '';
            document.getElementById('txtEndDt').value = '';
            var checkboxCollection = document.getElementById('chkbxlstRole').getElementsByTagName('input');
            for (var i = 0; i < checkboxCollection.length; i++) {
                if (checkboxCollection[i].type.toString().toLowerCase() == "checkbox") {
                    checkboxCollection[i].checked = false;
                }
            }
            document.getElementById("<%= ChkbxRole.ClientID %>").checked = false;
            document.getElementById("<%= btnSave.ClientID %>").value = "Save";
            document.getElementById("<%= hdnValues.ClientID %>").value = "1";
                    
            return false;
        }


        function funcEdit(BannerID, BannerText) {
            //debugger;
            alert("success");
            var pBannerID = document.getElementById(BannerID).value;
            var pBannerText = (document.getElementById(BannerText).value);
            var pReturnQuantity = document.getElementById(ReturnQuantity).value;
            var pRefundAmount = (document.getElementById(RefundAmount).value);
            document.getElementById('hdnBannerID').value = pBannerID;
            document.getElementById('txtbannertext').value = pBannerText;           
        }

        
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ctlTaskScriptMgr" runat="server">
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
                <uc7:DocHeader ID="docHeader" runat="server" />
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
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>
                                <ul>
                                    <li>
                                        <uc9:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                                    </li>
                                </ul>
                                <asp:Panel ID="pnl1" runat="server" GroupingText="Banner" CssClass="dataheader2 defaultfontcolor">
                                    <table border="0" width="100%">
                                        <tr>
                                            <td>
                                                <table>
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="lblbannertext" runat="server" Text="Enter Banner Text Max ("></asp:Label>
                                                            <asp:Label ID="lblCount" runat="server" Text="1000"></asp:Label>&nbsp;Chars.
                                                            )
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtbannertext" runat="server" TextMode="MultiLine" MaxLength="1000"
                                                                 onkeyup="count(this)" Width="252px" Rows="5" Columns="50"></asp:TextBox>
                                                                 <img align="middle" alt="" src="../Images/starbutton.png" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="3">
                                                <table>
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="lblrole" runat="server" Text="Select Role :"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:UpdatePanel ID="pnlPurpose" runat="server">
                                                                <ContentTemplate>
                                                                    <br />
                                                                    <asp:CheckBox ID="ChkbxRole" Text="ALL" runat="server" CssClass="smallfon" onclick="CheckAllRole(this)"
                                                                        Checked="false" />
                                                                    <asp:CheckBoxList ID="chkbxlstRole" runat="server" RepeatDirection="Horizontal" RepeatColumns="5">
                                                                    </asp:CheckBoxList>
                                                                </ContentTemplate>
                                                            </asp:UpdatePanel>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="3" width="">
                                                <table width="100%">
                                                    <tr>
                                                        <td align="right">
                                                            <asp:Label ID="lblstrdate" runat="server" Text="Start Date : "></asp:Label>
                                                        </td>
                                                        <td width="25%">
                                                            <asp:TextBox ToolTip="dd/mm/yyyy mm:hh:ss AM or PM" ID="txtStartDt" runat="server" CssClass ="Txtboxsmall"
                                                                Enabled="true" onBlur="return ChkStartDate();"></asp:TextBox>
                                                            <%--<ajc:MaskedEditExtender ID="MaskedEditExtender2" runat="server" TargetControlID="txtStartDt"
                                                            Mask="99/99/9999 99:99:99" MaskType="DateTime" AcceptAMPM="true" />--%>
                                                            <img onclick="return CheckStartDt()" style="cursor: hand;" id="imgdischarge" src="../Images/Calendar_scheduleHS.png"
                                                                width="16" height="16" border="0" alt="Pick a date" />
                                                                <img align="middle" alt="" src="../Images/starbutton.png" />
                                                        </td>
                                                        <td width="10%" align="right">
                                                            <asp:Label ID="lblenddate" runat="server" Text="End Date : "></asp:Label>
                                                        </td>
                                                        <td width="45%">
                                                            <asp:TextBox ID="txtEndDt" ToolTip="dd/mm/yyyy mm:hh:ss AM or PM" runat="server" CssClass ="Txtboxsmall"
                                                                Enabled="true" onBlur="return ChkEndDate();"></asp:TextBox>
                                                            <%--<ajc:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="txtEndDt"
                                                            Mask="99/99/9999 99:99:99 MM" MaskType="DateTime" AcceptAMPM="true" />--%>
                                                            <img onclick="return CheckEndDt()" style="cursor: hand;" id="img1" src="../Images/Calendar_scheduleHS.png"
                                                                width="16" height="16" border="0" alt="Pick a date" />
                                                                <img align="middle" alt="" src="../Images/starbutton.png" />
                                                            <asp:HiddenField ID="hdnCurrentDate" runat="server" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right" width="45%">
                                                <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn" onmouseout="this.className='btn'"
                                                     OnClick="btnSave_Click" OnClientClick="return ChkField();"
                                                    Width="62px" />
                                            </td>
                                            <td align="left">
                                                <asp:Button ID="btnReset" runat="server" Text="Reset" CssClass="btn" onmouseout="this.className='btn'"
                                                    OnClientClick="return Reset();" 
                                                    Width="64px"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="4" align="center">
                                                <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                                    <ContentTemplate>
                                                        <asp:GridView ID="grdBanner" runat="server" AutoGenerateColumns="False" AllowPaging="True"
                                                            CellPadding="4" CssClass="mytable" DataKeyNames="BannerID,BannerText" OnRowCommand="grdBanner_RowCommand"
                                                            OnRowDataBound="grdBanner_RowDataBound" PageSize="200" Width="50%">
                                                            <HeaderStyle CssClass="dataheader1" />
                                                            <RowStyle Font-Bold="False" />
                                                            <PagerSettings Mode="NextPrevious" />
                                                            <Columns>
                                                                <asp:BoundField DataField="BannerID" HeaderText="Banner ID" Visible="False">
                                                                    <HeaderStyle HorizontalAlign="Left" />
                                                                    <ItemStyle HorizontalAlign="Left" Width="250px" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="BannerText" HeaderText="Banner Text">
                                                                    <HeaderStyle HorizontalAlign="Center" />
                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                </asp:BoundField>
                                                                <asp:TemplateField Visible="false">
                                                                    <ItemTemplate>
                                                                        <asp:HiddenField ID="hdnBanID" Value='<%#Eval("BannerID") %>' runat="server" />
                                                                        <asp:HiddenField ID="hdnBanText" Value='<%#Eval("BannerText") %>' runat="server" />
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                            </Columns>
                                                            <SelectedRowStyle ForeColor="#000066" />
                                                        </asp:GridView>
                                                    </ContentTemplate>
                                                </asp:UpdatePanel>
                                            </td>
                                        </tr>
                                    </table>
                                </asp:Panel>
                                <asp:HiddenField ID="hdnBannerID" runat="server" Value="0" />
                                <asp:HiddenField ID="hdnRoleID" runat="server" />
                                <asp:HiddenField ID="hdnValues" runat="server" Value="1" />
                                
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
