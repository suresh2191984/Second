<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Investigation.aspx.cs" Inherits="Investigation_Investigation" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="Ajax" %>
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Src="Header.ascx" TagName="Header" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="Header" TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Investigation</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>

    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script src="../Scripts/animatedcollapse.js" type="text/javascript"></script>

    <script src="../Scripts/jquery-1.2.2.pack.js" type="text/javascript"></script>

    <script type="text/javascript" language="javascript">
        animatedcollapse.addDiv('d3002', 'fade=1,height=30%');
        animatedcollapse.addDiv('d3010', 'fade=1,height=20%');
        animatedcollapse.addDiv('d3017', 'fade=1,height=30%');
        animatedcollapse.addDiv('d3023', 'fade=1,height=100%');
        animatedcollapse.addDiv('SpotK', 'fade=1,height=100%');
        animatedcollapse.addDiv('SpotGreat', 'fade=1,height=100%');
        animatedcollapse.addDiv('d3030', 'fade=1,height=20%');
        animatedcollapse.addDiv('d3031', 'fade=1,height=100%');
        animatedcollapse.addDiv('d3035', 'fade=1,height=100%');
        animatedcollapse.addDiv('d3045', 'fade=1,height=20%');
        animatedcollapse.addDiv('d3052', 'fade=1,height=20%');
        animatedcollapse.addDiv('LipidProfile', 'fade=1,height=20%');
        animatedcollapse.addDiv('d3059', 'fade=1,height=40%');
        animatedcollapse.addDiv('d3071', 'fade=1,height=15%');
        animatedcollapse.addDiv('d3077', 'fade=1,height=50%');
        animatedcollapse.addDiv('d3078', 'fade=1,height=50%');
        animatedcollapse.addDiv('d3088', 'fade=1,height=50%');
        animatedcollapse.addDiv('d3094', 'fade=1,height=50%');
        animatedcollapse.addDiv('d3111', 'fade=1,height=50%');
        animatedcollapse.addDiv('d3125', 'fade=1,height=50%');
        animatedcollapse.addDiv('d3127', 'fade=1,height=50%');
        animatedcollapse.addDiv('d2004', 'fade=1,height=10%');
        animatedcollapse.addDiv('d2016', 'fade=1,height=30%');
        animatedcollapse.addDiv('d2017', 'fade=1,height=70%');
        animatedcollapse.addDiv('d2023', 'fade=1,height=10%');
        animatedcollapse.addDiv('d2027', 'fade=1,height=80px');
        animatedcollapse.addDiv('d2036', 'fade=1,height=60%');
        animatedcollapse.addDiv('d2042', 'fade=1,height=70%');
        animatedcollapse.addDiv('d4002', 'fade=1,height=50%');
        animatedcollapse.addDiv('d4013', 'fade=1,height=30%');
        animatedcollapse.addDiv('d4006', 'fade=1,height=30%');
        animatedcollapse.addDiv('d4034', 'fade=1,height=30%');
        animatedcollapse.addDiv('d4045', 'fade=1,height=30%');
        animatedcollapse.addDiv('d4053', 'fade=1,height=15%');
        animatedcollapse.addDiv('d4050', 'fade=1,height=30%');
        animatedcollapse.addDiv('d4059', 'fade=1,height=15%');
        animatedcollapse.addDiv('d4066', 'fade=1,height=15%');
        animatedcollapse.addDiv('d4073', 'fade=1,height=15%');
        animatedcollapse.addDiv('d4083', 'fade=1,height=10%');
        animatedcollapse.addDiv('d4082', 'fade=1,height=30%');
        animatedcollapse.addDiv('d4093', 'fade=1,height=30%');
        animatedcollapse.addDiv('d4099', 'fade=1,height=30%');
        animatedcollapse.addDiv('d4096', 'fade=1,height=30%');
        animatedcollapse.addDiv('d4025', 'fade=1,height=30%');
        animatedcollapse.addDiv('d4032', 'fade=1,height=30%');
        animatedcollapse.addDiv('d4117', 'fade=1,height=30%');
        animatedcollapse.addDiv('d4111', 'fade=1,height=30%');
        animatedcollapse.addDiv('d4102', 'fade=1,height=30%');
        animatedcollapse.addDiv('d4109', 'fade=1,height=30%');
        animatedcollapse.addDiv('d4103', 'fade=1,height=30%');
        animatedcollapse.addDiv('d4012', 'fade=1,height=30%');
        animatedcollapse.addDiv('d1002', 'fade=1,height=30%');
        animatedcollapse.init();
    </script>

</head>
<body oncontextmenu="return false;">
    <form id="frmDialysisRecord" runat="server" defaultbutton="btnSaveClinic">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
        <Services>
            <asp:ServiceReference Path="~/Service.svc" />
        </Services>
    </asp:ScriptManager>
    <div id="wrapper">
        <div id="header">
            <uc2:Header ID="Header2" runat="server" />
            <div class="details">
                <uc1:Header ID="Header1" runat="server" />
            </div>
        </div>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
                <td width="15%" valign="top" id="menu" style="display: block;">
                    <div id="navigation">
                        <uc3:LeftMenu ID="LeftMenu1" runat="server" />
                    </div>
                </td>
                <td width="85%" valign="top" class="tdspace">
                     <img alt="" onclick="Showmenu();Showhide();" src="../Images/hide.png" id="showmenu" style="Cursor:pointer;" />
                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td>
                                <top:topheader id="TopHeader1" runat="server" />
                            </td>
                        </tr>
                    </table>
                    <div class="contentdata">
                        <ul>
                            <li>
                                <uc5:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                        <Ajax:TabContainer runat="server" ID="tabContain" ForeColor="Black" Enabled="true"
                            ActiveTabIndex="1">
                            <Ajax:TabPanel runat="server" HeaderText="Bio-Chemistry" ID="tp3001" ForeColor="Black"
                                Enabled="false">
                                <HeaderTemplate>
                                    Bio-Chemistry
                                </HeaderTemplate>
                                <ContentTemplate>
                                    <table cellspacing="1" style="height: auto" width="100%" border="0">
                                        <tr>
                                            <td>
                                                <a id="a3002" runat="server" href="javascript:animatedcollapse.toggle('d3002')" visible="False">
                                                    <span class="label_collapse">Electrolytes</span></a>
                                                <div id="d3002" style="display: none; padding-left: 30px">
                                                    <table width="61%">
                                                        <tr>
                                                            <td>
                                                                <asp:Panel ID="pn3003" runat="server" Enabled="False">
                                                                    <table width="100%">
                                                                        <tr>
                                                                            <td align="left" valign="top" width="25%">
                                                                                <asp:Label ID="lbl_Na" runat="server" Text="Na&lt;SUP&gt;+&lt;/SUP&gt;"></asp:Label>
                                                                            </td>
                                                                            <td align="left" valign="top">
                                                                                <asp:TextBox ID="t3003" runat="server" MaxLength="5" onbeforepaste="BeforePaste_Event()"
                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()" Width="40px"></asp:TextBox>
                                                                                <asp:Label ID="lbl_NaUnit" runat="server" Text="mg%"></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </asp:Panel>
                                                            </td>
                                                            <td width="54%">
                                                                <asp:Panel ID="pn3004" runat="server" Enabled="False">
                                                                    <table width="100%">
                                                                        <tr>
                                                                            <td align="left" valign="top" width="25%">
                                                                                <asp:Label ID="lbl_K" runat="server" Text="K&lt;SUP&gt;+&lt;/SUP&gt;"></asp:Label>
                                                                            </td>
                                                                            <td align="left" valign="top">
                                                                                <asp:TextBox ID="t3004" runat="server" MaxLength="5" onbeforepaste="BeforePaste_Event()"
                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()" Width="40px"></asp:TextBox>
                                                                                <asp:Label ID="lbl_KUnit" runat="server" Text="mg%"></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </asp:Panel>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:Panel ID="pn3005" runat="server" Enabled="False">
                                                                    <table width="100%">
                                                                        <tr>
                                                                            <td align="left" valign="top" width="25%">
                                                                                <asp:Label ID="lbl_Cl" runat="server" Text="Cl&lt;SUP&gt;-&lt;/SUP&gt;"></asp:Label>
                                                                            </td>
                                                                            <td align="left" valign="top">
                                                                                <asp:TextBox ID="t3005" runat="server" MaxLength="5" onbeforepaste="BeforePaste_Event()"
                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()" Width="40px"></asp:TextBox>
                                                                                <asp:Label ID="lbl_ClUnit" runat="server" Text="mg%"></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </asp:Panel>
                                                            </td>
                                                            <td>
                                                                <asp:Panel ID="pn3006" runat="server" Enabled="False">
                                                                    <table width="100%">
                                                                        <tr>
                                                                            <td align="left" valign="top" width="25%">
                                                                                <asp:Label ID="lbl_Hco" runat="server" Text="Hco&lt;SUB&gt;3&lt;/SUB&gt;&lt;SUP&gt;-&lt;/SUP&gt;"></asp:Label>
                                                                            </td>
                                                                            <td align="left" valign="top">
                                                                                <asp:TextBox ID="t3006" runat="server" MaxLength="5" onbeforepaste="BeforePaste_Event()"
                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()" Width="40px"></asp:TextBox>
                                                                                <asp:Label ID="lbl_HcoUnit" runat="server" Text="mg%"></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </asp:Panel>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:Panel ID="pn3007" runat="server" Enabled="False">
                                                                    <table width="100%">
                                                                        <tr>
                                                                            <td align="left" valign="top" width="25%">
                                                                                <asp:Label ID="lbl_Ca" runat="server" Text="Ca&lt;SUP&gt;++&lt;/SUP&gt;"></asp:Label>
                                                                            </td>
                                                                            <td align="left" valign="top">
                                                                                <asp:TextBox ID="t3007" runat="server" MaxLength="5" onbeforepaste="BeforePaste_Event()"
                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()" Width="40px"></asp:TextBox>
                                                                                <asp:Label ID="lbl_CaUnit" runat="server" Text="mg%"></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </asp:Panel>
                                                            </td>
                                                            <td>
                                                                <asp:Panel ID="pn3008" runat="server" Enabled="False">
                                                                    <table width="100%">
                                                                        <tr>
                                                                            <td align="left" valign="top" width="25%">
                                                                                <asp:Label ID="lbl_Po" runat="server" Text="Po&lt;SUB&gt;4&lt;/SUB&gt;&lt;SUP&gt;--&lt;/SUP&gt;"></asp:Label>
                                                                            </td>
                                                                            <td align="left" valign="top">
                                                                                <asp:TextBox ID="t3008" runat="server" MaxLength="5" onbeforepaste="BeforePaste_Event()"
                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()" Width="40px"></asp:TextBox>
                                                                                <asp:Label ID="lbl_PoUnit" runat="server" Text="mg%"></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </asp:Panel>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Panel ID="pn3009" runat="server" Enabled="False">
                                                    <table width="100%">
                                                        <tr>
                                                            <td align="left" valign="top" width="25%">
                                                                <asp:Label ID="lbl_Mg" runat="server" Text="Mg&lt;SUP&gt;++&lt;/SUP&gt;"></asp:Label>
                                                            </td>
                                                            <td align="left" valign="top">
                                                                <asp:TextBox ID="t3009" runat="server" MaxLength="5" onbeforepaste="BeforePaste_Event()"
                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()" Width="40px"></asp:TextBox>
                                                                <asp:Label ID="lbl_MgUnit" runat="server" Text="mg%"></asp:Label>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </asp:Panel>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <a id="a3010" runat="server" href="javascript:animatedcollapse.toggle('d3010')" visible="False">
                                                    <span class="label_collapse">Blood Sugars</span></a>
                                                <div id="d3010" style="display: none; padding-left: 30px">
                                                    <table width="61%">
                                                        <tr>
                                                            <td>
                                                                <asp:Panel ID="pn3011" runat="server" Enabled="False">
                                                                    <table width="100%">
                                                                        <tr>
                                                                            <td align="left" valign="top" width="25%">
                                                                                <asp:Label ID="lbl_RBS" runat="server" Text="RBS"></asp:Label>
                                                                            </td>
                                                                            <td align="left" valign="top">
                                                                                <asp:TextBox ID="t3011" runat="server" MaxLength="5" onbeforepaste="BeforePaste_Event()"
                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()" Width="40px"></asp:TextBox>
                                                                                <asp:Label ID="lbl_RBSUnit" runat="server" Text="mg"></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </asp:Panel>
                                                            </td>
                                                            <tr>
                                                                <td>
                                                                    <asp:Panel ID="pn3012" runat="server" Enabled="False">
                                                                        <table width="100%">
                                                                            <tr>
                                                                                <td align="left" valign="top" width="25%">
                                                                                    <asp:Label ID="lbl_FBS" runat="server" Text="FBS"></asp:Label>
                                                                                </td>
                                                                                <td align="left" valign="top">
                                                                                    <asp:TextBox ID="t3012" runat="server" MaxLength="5" onbeforepaste="BeforePaste_Event()"
                                                                                             onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()" Width="40px"></asp:TextBox>
                                                                                    <asp:Label ID="lbl_FBSUnit" runat="server" Text="mg"></asp:Label>
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </asp:Panel>
                                                                </td>
                                                            </tr>
                                                    </table>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Panel ID="pn3013" runat="server" Enabled="False">
                                                    <table width="100%">
                                                        <tr>
                                                            <td align="left" valign="top" width="25%">
                                                                <asp:Label ID="lbl_PPBS" runat="server" Text="PPBS"></asp:Label>
                                                            </td>
                                                            <td align="left" valign="top">
                                                                <asp:TextBox ID="t3013" runat="server" MaxLength="5" onbeforepaste="BeforePaste_Event()"
                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()" Width="40px"></asp:TextBox>
                                                                <asp:Label ID="lbl_PPBSUnit" runat="server" Text="mg"></asp:Label>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </asp:Panel>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Panel ID="pn3014" runat="server" Enabled="False">
                                                    <table width="100%">
                                                        <tr>
                                                            <td align="left" valign="top" width="25%">
                                                                <asp:Label ID="lbl_HBA1C" runat="server" Text="HBA&lt;SUB&gt;1&lt;/SUB&gt;C"></asp:Label>
                                                            </td>
                                                            <td align="left" valign="top">
                                                                <asp:TextBox ID="t3014" runat="server" MaxLength="5" onbeforepaste="BeforePaste_Event()"
                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()" Width="40px"></asp:TextBox>
                                                                <asp:Label ID="lbl_HBA1CUnit" runat="server" Text="%"></asp:Label>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </asp:Panel>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">
                                                <div id="d3015" style="display: none">
                                                    <asp:Panel ID="pn3015" runat="server" Enabled="False">
                                                        <table border="0" cellpadding="0" cellspacing="0" width="50%">
                                                            <tr>
                                                                <td align="left" height="27" width="40%">
                                                                    <label>
                                                                        No. Of tests</label>
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="t13015" runat="server" CssClass="textbox_hemat"></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td align="left" height="26" width="40%">
                                                                    <label>
                                                                        Start Time</label>
                                                                </td>
                                                                <td>
                                                                    <asp:DropDownList ID="ddlStartTime" runat="server">
                                                                        <asp:ListItem>1</asp:ListItem>
                                                                        <asp:ListItem>2</asp:ListItem>
                                                                        <asp:ListItem>3</asp:ListItem>
                                                                        <asp:ListItem>4</asp:ListItem>
                                                                        <asp:ListItem>5</asp:ListItem>
                                                                        <asp:ListItem>6</asp:ListItem>
                                                                        <asp:ListItem>7</asp:ListItem>
                                                                        <asp:ListItem>8</asp:ListItem>
                                                                        <asp:ListItem>9</asp:ListItem>
                                                                        <asp:ListItem>10</asp:ListItem>
                                                                        <asp:ListItem>11</asp:ListItem>
                                                                        <asp:ListItem>12</asp:ListItem>
                                                                    </asp:DropDownList>
                                                                    <asp:DropDownList ID="ddlampm" runat="server">
                                                                        <asp:ListItem>am</asp:ListItem>
                                                                        <asp:ListItem>pm</asp:ListItem>
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td align="left" height="27" width="40%">
                                                                    <label>
                                                                        Time Interval(min)</label>
                                                                </td>
                                                                <td>
                                                                    <asp:DropDownList ID="ddlTimeInterval" runat="server">
                                                                        <asp:ListItem>10</asp:ListItem>
                                                                        <asp:ListItem>20</asp:ListItem>
                                                                        <asp:ListItem>30</asp:ListItem>
                                                                        <asp:ListItem>40</asp:ListItem>
                                                                        <asp:ListItem>50</asp:ListItem>
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td align="left" height="26" width="40%">
                                                                    <label>
                                                                        grams of Sugar</label>
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="t43015" runat="server" CssClass="textbox_hemat"></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td align="center" colspan="2">
                                                                    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                                                        <ContentTemplate>
                                                                            <asp:Button ID="btnGenerate" runat="server" OnClick="btnGenerate_Click" CssClass="oi"
                                                                                Text="Generate" />
                                                                        </ContentTemplate>
                                                                    </asp:UpdatePanel>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </asp:Panel>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" style="padding-left: 20px">
                                                <asp:UpdatePanel ID="UpdatePanel5" runat="server">
                                                    <ContentTemplate>
                                                        <asp:Panel ID="pn3016" runat="server" Enabled="true">
                                                        </asp:Panel>
                                                    </ContentTemplate>
                                                </asp:UpdatePanel>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">
                                                <asp:Panel ID="pn301" runat="server" Enabled="False">
                                                </asp:Panel>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <a id="a3017" runat="server" href="javascript:animatedcollapse.toggle('d3017')" visible="False">
                                                    <span class="label_collapse">Renal Function Tests</span></a>
                                                <div id="d3017" style="display: none; padding-left: 30px">
                                                    <table width="80%">
                                                        <tr>
                                                            <td>
                                                                <asp:Panel ID="pn3018" runat="server" Enabled="False">
                                                                    <table width="100%">
                                                                        <tr>
                                                                            <td align="left" valign="top" width="30%">
                                                                                <asp:Label ID="lbl_BUrea" runat="server" Text="B.Urea"></asp:Label>
                                                                            </td>
                                                                            <td align="left" valign="top">
                                                                                <asp:TextBox ID="t3018" runat="server" MaxLength="5" onbeforepaste="BeforePaste_Event()"
                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()" Width="40px"></asp:TextBox>
                                                                                <asp:Label ID="lbl_BUreaUnit" runat="server" Text="mg"></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </asp:Panel>
                                                            </td>
                                                            <tr>
                                                                <td width="51%">
                                                                    <asp:Panel ID="pn3019" runat="server" Enabled="False">
                                                                        <table width="100%">
                                                                            <tr>
                                                                                <td align="left" valign="top" width="30%">
                                                                                    <asp:Label ID="lbl_SCreatinine" runat="server" Text="S.Creatinine"></asp:Label>
                                                                                </td>
                                                                                <td align="left" valign="top">
                                                                                    <asp:TextBox ID="t3019" runat="server" MaxLength="5" onbeforepaste="BeforePaste_Event()"
                                                                                             onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()" Width="40px"></asp:TextBox>
                                                                                    <asp:Label ID="lbl_SCreatinineUnit" runat="server" Text="mg"></asp:Label>
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </asp:Panel>
                                                                </td>
                                                            </tr>
                                                        <tr>
                                                            <td height="42">
                                                                <asp:Panel ID="pn3020" runat="server" Enabled="False">
                                                                    <table width="100%">
                                                                        <tr>
                                                                            <td align="left" valign="top" width="30%">
                                                                                <asp:Label ID="lbl_BUN" runat="server" Text="BUN"></asp:Label>
                                                                            </td>
                                                                            <td align="left" valign="top">
                                                                                <asp:TextBox ID="t3020" runat="server" MaxLength="5" onbeforepaste="BeforePaste_Event()"
                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()" Width="40px"></asp:TextBox>
                                                                                <asp:Label ID="lbl_BUNUnit" runat="server" Text="mg"></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </asp:Panel>
                                                            </td>
                                                            <td>
                                                                <asp:Panel ID="pn3021" runat="server" Enabled="False">
                                                                    <table width="100%">
                                                                        <tr>
                                                                            <td align="left" valign="top" width="30%">
                                                                                <asp:Label ID="lbl_Creatinine" runat="server" Text="Creatinine &lt;br /&gt; Clearance"></asp:Label>
                                                                            </td>
                                                                            <td align="left" valign="top">
                                                                                <asp:TextBox ID="t3021" runat="server" MaxLength="5" onbeforepaste="BeforePaste_Event()"
                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()" Width="40px"></asp:TextBox>
                                                                                <asp:Label ID="lbl_CreatinineUnit" runat="server" Text="ml/min"></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </asp:Panel>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:Panel ID="pn3022" runat="server" Enabled="False">
                                                                    <table width="100%">
                                                                        <tr>
                                                                            <td align="left" valign="top" width="30%">
                                                                                <asp:Label ID="lbl_Plasma" runat="server" Text="Plasma &lt;br /&gt; Osmolality"></asp:Label>
                                                                            </td>
                                                                            <td align="left" valign="top">
                                                                                <asp:TextBox ID="t3022" runat="server" MaxLength="5" onbeforepaste="BeforePaste_Event()"
                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()" Width="40px"></asp:TextBox>
                                                                                <asp:Label ID="lbl_PlasmaUnit" runat="server" Text="mg"></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </asp:Panel>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="2">
                                                                <a id="a3023" runat="server" href="javascript:animatedcollapse.toggle('d3023')" visible="False">
                                                                    <span class="label_collapse">Spot NA+, K+, Great</span></a>
                                                                <div id="d3023" style="display: none; padding-left: 20px">
                                                                    <table width="100%">
                                                                        <tr>
                                                                            <td>
                                                                                <asp:Panel ID="pn3024" runat="server" Enabled="False">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td align="left" valign="top" width="30%">
                                                                                                <asp:Label ID="Label1" runat="server" Text="NA&lt;sup&gt;+&lt;/sup&gt; Urine"></asp:Label>
                                                                                            </td>
                                                                                            <td align="left" valign="top">
                                                                                                <asp:TextBox ID="t3024" runat="server" MaxLength="5" onbeforepaste="BeforePaste_Event()"
                                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()" Width="40px"></asp:TextBox>
                                                                                                <asp:Label ID="Label2" runat="server" Text="mg%"></asp:Label>
                                                                                            </td>
                                                                                            <td align="left" valign="top" width="30%">
                                                                                                <asp:Label ID="Label3" runat="server" Text="NA&lt;sup&gt;+&lt;/sup&gt; Plasma"></asp:Label>
                                                                                            </td>
                                                                                            <td align="left" valign="top">
                                                                                                <asp:TextBox ID="t13024" runat="server" MaxLength="5" onbeforepaste="BeforePaste_Event()"
                                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()" Width="40px"></asp:TextBox>
                                                                                                <asp:Label ID="Label4" runat="server" Text="mg%"></asp:Label>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:Panel ID="pn3025" runat="server" Enabled="False">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td align="left" valign="top" width="30%">
                                                                                                <asp:Label ID="Label9" runat="server" Text="K+ Urine"></asp:Label>
                                                                                            </td>
                                                                                            <td align="left" valign="top">
                                                                                                <asp:TextBox ID="t3025" runat="server" MaxLength="5" onbeforepaste="BeforePaste_Event()"
                                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()" Width="40px"></asp:TextBox>
                                                                                                <asp:Label ID="Label10" runat="server" Text="mg%"></asp:Label>
                                                                                            </td>
                                                                                            <td align="left" valign="top" width="30%">
                                                                                                <asp:Label ID="Label11" runat="server" Text="K+ Plasma"></asp:Label>
                                                                                            </td>
                                                                                            <td align="left" valign="top">
                                                                                                <asp:TextBox ID="t13025" runat="server" MaxLength="5" onbeforepaste="BeforePaste_Event()"
                                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()" Width="40px"></asp:TextBox>
                                                                                                <asp:Label ID="Label12" runat="server" Text="mg%"></asp:Label>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:Panel ID="pn3026" runat="server" Enabled="False">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td align="left" valign="top" width="30%">
                                                                                                <asp:Label ID="Label5" runat="server" Text="Creat Urine"></asp:Label>
                                                                                            </td>
                                                                                            <td align="left" valign="top">
                                                                                                <asp:TextBox ID="t3026" runat="server" MaxLength="5" onbeforepaste="BeforePaste_Event()"
                                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()" Width="40px"></asp:TextBox>
                                                                                                <asp:Label ID="Label6" runat="server" Text="mg%"></asp:Label>
                                                                                            </td>
                                                                                            <td align="left" valign="top" width="30%">
                                                                                                <asp:Label ID="Label7" runat="server" Text="Creat Plasma"></asp:Label>
                                                                                            </td>
                                                                                            <td align="left" valign="top">
                                                                                                <asp:TextBox ID="t13026" runat="server" MaxLength="5" onbeforepaste="BeforePaste_Event()"
                                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()" Width="40px"></asp:TextBox>
                                                                                                <asp:Label ID="Label8" runat="server" Text="mg%"></asp:Label>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:Panel ID="pn3027" runat="server" Enabled="False">
                                                                    <table width="100%">
                                                                        <tr>
                                                                            <td align="left" valign="top" width="30%">
                                                                                <asp:Label ID="Label13" runat="server" Text="Urine Osmolality"></asp:Label>
                                                                            </td>
                                                                            <td align="left" valign="top">
                                                                                <asp:TextBox ID="t3027" runat="server" MaxLength="5" onbeforepaste="BeforePaste_Event()"
                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()" Width="40px"></asp:TextBox>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </asp:Panel>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:Panel ID="pn3028" runat="server" Enabled="False">
                                                                    <table width="100%">
                                                                        <tr>
                                                                            <td align="left" valign="top" width="30%">
                                                                                <asp:Label ID="Label15" runat="server" Text="Urine Specific &lt;br /&gt; Gravity"></asp:Label>
                                                                            </td>
                                                                            <td align="left" valign="top">
                                                                                <asp:TextBox ID="t3028" runat="server" MaxLength="5" onbeforepaste="BeforePaste_Event()"
                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()" Width="40px"></asp:TextBox>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </asp:Panel>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:Panel ID="pn3029" runat="server" Enabled="False">
                                                                    <table width="100%">
                                                                        <tr>
                                                                            <td align="left" valign="top" width="30%">
                                                                                <asp:Label ID="Label17" runat="server" Text="FeNa"></asp:Label>
                                                                            </td>
                                                                            <td align="left" valign="top">
                                                                                <asp:TextBox ID="t3029" runat="server" MaxLength="5" onbeforepaste="BeforePaste_Event()"
                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()" Width="40px"></asp:TextBox>
                                                                                <asp:Label ID="Label18" runat="server" Text="%"></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </asp:Panel>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <a id="a3030" runat="server" href="javascript:animatedcollapse.toggle('d3030')" visible="False">
                                                    <span class="label_collapse">Liver Function Tests</span></a>
                                                <div id="d3030" style="display: none; padding-left: 30px">
                                                    <table width="65%">
                                                        <tr>
                                                            <td>
                                                                <a id="a3031" runat="server" href="javascript:animatedcollapse.toggle('d3031')" visible="False">
                                                                    <span class="label_collapse">Bilirubin</span></a>
                                                                <div id="d3031" style="display: none; padding-left: 20px">
                                                                    <table width="100%">
                                                                        <tr>
                                                                            <td>
                                                                                <asp:Panel ID="pn3032" runat="server" Enabled="False">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td align="left" valign="top" width="30%">
                                                                                                <asp:Label ID="Label19" runat="server" Text="Total"></asp:Label>
                                                                                            </td>
                                                                                            <td align="left" valign="top">
                                                                                                <asp:TextBox ID="t3032" runat="server" MaxLength="5" onbeforepaste="BeforePaste_Event()"
                                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onkeyup="totBilirubin ();" onPaste="Paste_Event()"
                                                                                                    Width="40px"></asp:TextBox>
                                                                                                <asp:Label ID="Label20" runat="server" Text="mg%"></asp:Label>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                            <td width="57%">
                                                                                <asp:Panel ID="pn3033" runat="server" Enabled="False">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td align="left" valign="top" width="30%">
                                                                                                <asp:Label ID="Label21" runat="server" Text="Direct"></asp:Label>
                                                                                            </td>
                                                                                            <td align="left" valign="top">
                                                                                                <asp:TextBox ID="t3033" runat="server" MaxLength="5" onbeforepaste="BeforePaste_Event()"
                                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onkeyup="totBilirubin();" onPaste="Paste_Event()"
                                                                                                    Width="40px"></asp:TextBox>
                                                                                                <asp:Label ID="Label22" runat="server" Text="mg%"></asp:Label>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:Panel ID="pn3034" runat="server" Enabled="False">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td align="left" valign="top" width="30%">
                                                                                                <asp:Label ID="Label23" runat="server" Text="InDirect"></asp:Label>
                                                                                            </td>
                                                                                            <td align="left" valign="top">
                                                                                                <asp:TextBox ID="t3034" runat="server" MaxLength="5" onbeforepaste="BeforePaste_Event()"
                                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onkeyup="totBilirubin();" onPaste="Paste_Event()"
                                                                                                    Width="40px"></asp:TextBox>
                                                                                                <asp:Label ID="Label24" runat="server" Text="mg%"></asp:Label>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <a id="a3035" runat="server" href="javascript:animatedcollapse.toggle('d3035')" visible="False">
                                                                    <span class="label_collapse">Proteins</span></a>
                                                                <div id="d3035" style="display: none; padding-left: 20px">
                                                                    <table width="100%">
                                                                        <tr>
                                                                            <td>
                                                                                <asp:Panel ID="d3036" runat="server" Enabled="False">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td align="left" valign="top" width="30%">
                                                                                                <asp:Label ID="Label25" runat="server" Text="Total"></asp:Label>
                                                                                            </td>
                                                                                            <td align="left" valign="top">
                                                                                                <asp:TextBox ID="t3036" runat="server" MaxLength="5" onbeforepaste="BeforePaste_Event()"
                                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onkeyup="totProteins()" onPaste="Paste_Event()"
                                                                                                    Width="40px"></asp:TextBox>
                                                                                                <asp:Label ID="Label26" runat="server" Text="gms"></asp:Label>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                            <td width="57%">
                                                                                <asp:Panel ID="pn3037" runat="server" Enabled="False">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td align="left" valign="top" width="30%">
                                                                                                <asp:Label ID="Label27" runat="server" Text="Albumin"></asp:Label>
                                                                                            </td>
                                                                                            <td align="left" valign="top">
                                                                                                <asp:TextBox ID="t3037" runat="server" MaxLength="5" onbeforepaste="BeforePaste_Event()"
                                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onkeyup="totProteins()" onPaste="Paste_Event()"
                                                                                                    Width="40px"></asp:TextBox>
                                                                                                <asp:Label ID="Label28" runat="server" Text="gms"></asp:Label>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:Panel ID="pn3038" runat="server" Enabled="False">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td align="left" valign="top" width="30%">
                                                                                                <asp:Label ID="Label29" runat="server" Text="Globulin"></asp:Label>
                                                                                            </td>
                                                                                            <td align="left" valign="top">
                                                                                                <asp:TextBox ID="t3038" runat="server" MaxLength="5" onbeforepaste="BeforePaste_Event()"
                                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onkeyup="totProteins()" onPaste="Paste_Event()"
                                                                                                    Width="40px"></asp:TextBox>
                                                                                                <asp:Label ID="Label30" runat="server" Text="gms"></asp:Label>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                            <tr>
                                                                                <td>
                                                                                    <asp:Panel ID="pn3039" runat="server" Enabled="False">
                                                                                        <table width="100%">
                                                                                            <tr>
                                                                                                <td align="left" valign="top" width="30%">
                                                                                                    <asp:Label ID="Label31" runat="server" Text="A/G Ratio"></asp:Label>
                                                                                                </td>
                                                                                                <td align="left" valign="top">
                                                                                                    <asp:TextBox ID="t3039" runat="server" MaxLength="5" onbeforepaste="BeforePaste_Event()"
                                                                                                             onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()" Width="40px"></asp:TextBox>
                                                                                                    <asp:Label ID="Label32" runat="server"></asp:Label>
                                                                                                </td>
                                                                                            </tr>
                                                                                        </table>
                                                                                    </asp:Panel>
                                                                                </td>
                                                                            </tr>
                                                                        </tr>
                                                                    </table>
                                                                </div>
                                                            </td>
                                                            <tr>
                                                                <td>
                                                                    <table width="100%">
                                                                        <tr>
                                                                            <td>
                                                                                <asp:Panel ID="pn3040" runat="server" Enabled="False">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td align="left" valign="top" width="30%">
                                                                                                <asp:Label ID="Label33" runat="server" Text="SGOT"></asp:Label>
                                                                                            </td>
                                                                                            <td align="left" valign="top" width="70%">
                                                                                                <asp:TextBox ID="t3040" runat="server" MaxLength="5" onbeforepaste="BeforePaste_Event()"
                                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()" Width="40px"></asp:TextBox>
                                                                                                <asp:Label ID="Label34" runat="server" Text="Units/l"></asp:Label>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                            <td width="55%">
                                                                                <asp:Panel ID="pn3041" runat="server" Enabled="False">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td align="left" valign="top" width="30%">
                                                                                                <asp:Label ID="Label35" runat="server" Text="SGPT"></asp:Label>
                                                                                            </td>
                                                                                            <td align="left" valign="top">
                                                                                                <asp:TextBox ID="t3041" runat="server" MaxLength="5" onbeforepaste="BeforePaste_Event()"
                                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()" Width="40px"></asp:TextBox>
                                                                                                <asp:Label ID="Label36" runat="server" Text="units/l"></asp:Label>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:Panel ID="pn3042" runat="server" Enabled="False">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td align="left" valign="top" width="30%">
                                                                                                <asp:Label ID="Label37" runat="server" Text="Alk.Phos"></asp:Label>
                                                                                            </td>
                                                                                            <td align="left" valign="top">
                                                                                                <asp:TextBox ID="t3042" runat="server" MaxLength="5" onbeforepaste="BeforePaste_Event()"
                                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()" Width="40px"></asp:TextBox>
                                                                                                <asp:Label ID="Label38" runat="server" Text="Units/l"></asp:Label>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                            <td>
                                                                                <asp:Panel ID="pn3043" runat="server" Enabled="False">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td align="left" valign="top" width="30%">
                                                                                                <asp:Label ID="Label39" runat="server" Text="Gamma GT"></asp:Label>
                                                                                            </td>
                                                                                            <td align="left" valign="top">
                                                                                                <asp:TextBox ID="t3043" runat="server" MaxLength="5" onbeforepaste="BeforePaste_Event()"
                                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()" Width="40px"></asp:TextBox>
                                                                                                <asp:Label ID="Label40" runat="server" Text="units/l"></asp:Label>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td colspan="2">
                                                                                <asp:Panel ID="pn3044" runat="server" Enabled="False">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td align="left" valign="top" width="21%">
                                                                                                <asp:Label ID="l3044" runat="server" Text="Acid Phosphatase"></asp:Label>
                                                                                            </td>
                                                                                            <td width="24%">
                                                                                                <asp:DropDownList ID="dd3044" runat="server">
                                                                                                    <asp:ListItem>Semen</asp:ListItem>
                                                                                                    <asp:ListItem>Vaginal Fluid</asp:ListItem>
                                                                                                </asp:DropDownList>
                                                                                            </td>
                                                                                            <td width="55%">
                                                                                                <asp:TextBox ID="t3044" runat="server" MaxLength="6"></asp:TextBox>
                                                                                                <label>
                                                                                                    IU/L</label>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                    </table>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <a id="a3045" runat="server" href="javascript:animatedcollapse.toggle('d3045')" visible="False">
                                                    <span class="label_collapse">Cardiac Enzymes</span></a>
                                                <div id="d3045" style="display: none; padding-left: 30px">
                                                    <table width="70%">
                                                        <tr>
                                                            <td>
                                                                <asp:Panel ID="pn3046" runat="server" Enabled="False">
                                                                    <table width="100%">
                                                                        <tr>
                                                                            <td align="left" valign="top" width="30%">
                                                                                <asp:Label ID="Label41" runat="server" Text="Troponin I"></asp:Label>
                                                                            </td>
                                                                            <td align="left" valign="top">
                                                                                <asp:TextBox ID="t3046" runat="server" MaxLength="5" onbeforepaste="BeforePaste_Event()"
                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()" Width="40px"></asp:TextBox>
                                                                                <asp:Label ID="Label42" runat="server" Text="mg/ml"></asp:Label>
                                                                                <asp:DropDownList ID="dd3046" runat="server" Width="70px">
                                                                                    <asp:ListItem>Positive</asp:ListItem>
                                                                                    <asp:ListItem>Negative</asp:ListItem>
                                                                                </asp:DropDownList>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </asp:Panel>
                                                            </td>
                                                            <tr>
                                                                <td>
                                                                    <asp:Panel ID="pn3047" runat="server" Enabled="False">
                                                                        <table width="100%">
                                                                            <tr>
                                                                                <td align="left" valign="top" width="30%">
                                                                                    <asp:Label ID="Label43" runat="server" Text="Troponin T"></asp:Label>
                                                                                </td>
                                                                                <td align="left" valign="top">
                                                                                    <asp:TextBox ID="t3047" runat="server" MaxLength="5" onbeforepaste="BeforePaste_Event()"
                                                                                             onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()" Width="40px"></asp:TextBox>
                                                                                    <asp:Label ID="Label44" runat="server" Text="mg/ml"></asp:Label>
                                                                                    <asp:DropDownList ID="dd3047" runat="server" Width="70px">
                                                                                        <asp:ListItem>Positive</asp:ListItem>
                                                                                        <asp:ListItem>Negative</asp:ListItem>
                                                                                    </asp:DropDownList>
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </asp:Panel>
                                                                </td>
                                                            </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:Panel ID="pn3048" runat="server" Enabled="False">
                                                                    <table width="100%">
                                                                        <tr>
                                                                            <td align="left" valign="top" width="30%">
                                                                                <asp:Label ID="Label45" runat="server" Text="CK-Total"></asp:Label>
                                                                            </td>
                                                                            <td align="left" valign="top">
                                                                                <asp:TextBox ID="t3048" runat="server" MaxLength="5" onbeforepaste="BeforePaste_Event()"
                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()" Width="40px"></asp:TextBox>
                                                                                <asp:Label ID="Label46" runat="server" Text="u/l"></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </asp:Panel>
                                                            </td>
                                                            <tr>
                                                                <td>
                                                                    <asp:Panel ID="pn3049" runat="server" Enabled="False">
                                                                        <table width="100%">
                                                                            <tr>
                                                                                <td align="left" valign="top" width="30%">
                                                                                    <asp:Label ID="Label47" runat="server" Text="CK-MB"></asp:Label>
                                                                                </td>
                                                                                <td align="left" valign="top">
                                                                                    <asp:TextBox ID="t3049" runat="server" MaxLength="5" onbeforepaste="BeforePaste_Event()"
                                                                                             onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()" Width="40px"></asp:TextBox>
                                                                                    <asp:Label ID="Label48" runat="server" Text="mg/ml"></asp:Label>
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </asp:Panel>
                                                                </td>
                                                            </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:Panel ID="pn3050" runat="server" Enabled="False">
                                                                    <table width="100%">
                                                                        <tr>
                                                                            <td align="left" valign="top" width="30%">
                                                                                <asp:Label ID="Label49" runat="server" Text="SGOT"></asp:Label>
                                                                            </td>
                                                                            <td align="left" valign="top">
                                                                                <asp:TextBox ID="t3050" runat="server" MaxLength="5" onbeforepaste="BeforePaste_Event()"
                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()" Width="40px"></asp:TextBox>
                                                                                <asp:Label ID="Label50" runat="server" Text="u/l"></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </asp:Panel>
                                                            </td>
                                                            <td>
                                                                <asp:Panel ID="pn3051" runat="server" Enabled="False">
                                                                    <table width="100%">
                                                                        <tr>
                                                                            <td align="left" valign="top" width="30%">
                                                                                <asp:Label ID="Label51" runat="server" Text="LDH"></asp:Label>
                                                                            </td>
                                                                            <td align="left" valign="top">
                                                                                <asp:TextBox ID="t3051" runat="server" MaxLength="5" onbeforepaste="BeforePaste_Event()"
                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()" Width="40px"></asp:TextBox>
                                                                                <asp:Label ID="Label52" runat="server" Text="u/l"></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </asp:Panel>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <a id="a3052" runat="server" href="javascript:animatedcollapse.toggle('d3052')" visible="False">
                                                    <span class="label_collapse">Lipid Profile</span></a>
                                                <div id="d3052" style="display: none; padding-left: 30px">
                                                    <table width="70%">
                                                        <tr>
                                                            <td>
                                                                <asp:Panel ID="pn3053" runat="server" Enabled="False">
                                                                    <table width="100%">
                                                                        <tr>
                                                                            <td align="left" valign="top" width="30%">
                                                                                <asp:Label ID="Label53" runat="server" Text="Total Cholesterol"></asp:Label>
                                                                            </td>
                                                                            <td align="left" valign="top">
                                                                                <asp:TextBox ID="t3053" runat="server" MaxLength="5" onbeforepaste="BeforePaste_Event()"
                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()" Width="40px"></asp:TextBox>
                                                                                <asp:Label ID="Label54" runat="server" Text="mg%"></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </asp:Panel>
                                                            </td>
                                                            <tr>
                                                                <td>
                                                                    <asp:Panel ID="pn3054" runat="server" Enabled="False">
                                                                        <table width="100%">
                                                                            <tr>
                                                                                <td align="left" valign="top" width="30%">
                                                                                    <asp:Label ID="Label55" runat="server" Text="LDL Cholesterol"></asp:Label>
                                                                                </td>
                                                                                <td align="left" valign="top">
                                                                                    <asp:TextBox ID="t3054" runat="server" MaxLength="5" onbeforepaste="BeforePaste_Event()"
                                                                                             onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()" Width="40px"></asp:TextBox>
                                                                                    <asp:Label ID="Label56" runat="server" Text="mg%"></asp:Label>
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </asp:Panel>
                                                                </td>
                                                            </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:Panel ID="pn3055" runat="server" Enabled="False">
                                                                    <table width="100%">
                                                                        <tr>
                                                                            <td align="left" valign="top" width="30%">
                                                                                <asp:Label ID="Label57" runat="server" Text="HDL Cholesterol"></asp:Label>
                                                                            </td>
                                                                            <td align="left" valign="top">
                                                                                <asp:TextBox ID="TextBox29" runat="server" MaxLength="5" onbeforepaste="BeforePaste_Event()"
                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()" Width="40px"></asp:TextBox>
                                                                                <asp:Label ID="Label58" runat="server" Text="mg%"></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </asp:Panel>
                                                            </td>
                                                            <td>
                                                                <asp:Panel ID="pn3056" runat="server" Enabled="False">
                                                                    <table width="100%">
                                                                        <tr>
                                                                            <td align="left" valign="top" width="30%">
                                                                                <asp:Label ID="Label59" runat="server" Text="VLDL Cholesterol"></asp:Label>
                                                                            </td>
                                                                            <td align="left" valign="top">
                                                                                <asp:TextBox ID="t3056" runat="server" MaxLength="5" onbeforepaste="BeforePaste_Event()"
                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()" Width="40px"></asp:TextBox>
                                                                                <asp:Label ID="Label60" runat="server" Text="mg%"></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </asp:Panel>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:Panel ID="pn3057" runat="server" Enabled="False">
                                                                    <table width="100%">
                                                                        <tr>
                                                                            <td align="left" valign="top" width="30%">
                                                                                <asp:Label ID="Label61" runat="server" Text="Triglycerides"></asp:Label>
                                                                            </td>
                                                                            <td align="left" valign="top">
                                                                                <asp:TextBox ID="t3057" runat="server" MaxLength="5" onbeforepaste="BeforePaste_Event()"
                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()" Width="40px"></asp:TextBox>
                                                                                <asp:Label ID="Label62" runat="server" Text="mg%"></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </asp:Panel>
                                                            </td>
                                                            <tr>
                                                                <td>
                                                                    <asp:Panel ID="pn3058" runat="server" Enabled="False">
                                                                        <table width="100%">
                                                                            <tr>
                                                                                <td align="left" valign="top" width="30%">
                                                                                    <asp:Label ID="Label63" runat="server" Text="LDL/HDL Ratio"></asp:Label>
                                                                                </td>
                                                                                <td align="left" valign="top">
                                                                                    <asp:TextBox ID="t3058" runat="server" MaxLength="5" onbeforepaste="BeforePaste_Event()"
                                                                                             onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()" Width="40px"></asp:TextBox>
                                                                                    <asp:Label ID="Label64" runat="server"></asp:Label>
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </asp:Panel>
                                                                </td>
                                                            </tr>
                                                    </table>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <a id="a3059" runat="server" href="javascript:animatedcollapse.toggle('d3059')" visible="False">
                                                    <span class="label_collapse">General</span></a>
                                                <div id="d3059" style="display: none; padding-left: 30px">
                                                    <table width="70%">
                                                        <tr>
                                                            <td>
                                                                <asp:Panel ID="pn3060" runat="server" Enabled="False">
                                                                    <table width="100%">
                                                                        <tr>
                                                                            <td align="left" valign="top" width="30%">
                                                                                <asp:Label ID="Label65" runat="server" Text="Amylase"></asp:Label>
                                                                            </td>
                                                                            <td align="left" valign="top">
                                                                                <asp:TextBox ID="t3060" runat="server" MaxLength="5" onbeforepaste="BeforePaste_Event()"
                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()" Width="40px"></asp:TextBox>
                                                                                <asp:Label ID="Label66" runat="server" Text="u/l"></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </asp:Panel>
                                                            </td>
                                                            <tr>
                                                                <td>
                                                                    <asp:Panel ID="pn3061" runat="server" Enabled="False">
                                                                        <table width="100%">
                                                                            <tr>
                                                                                <td align="left" valign="top" width="30%">
                                                                                    <asp:Label ID="Label67" runat="server" Text="G&lt;sub&gt;6&lt;sub&gt;PD"></asp:Label>
                                                                                </td>
                                                                                <td align="left" valign="top">
                                                                                    <asp:DropDownList ID="dd3061" runat="server" Width="70px">
                                                                                        <asp:ListItem>Positive</asp:ListItem>
                                                                                        <asp:ListItem>Negative</asp:ListItem>
                                                                                    </asp:DropDownList>
                                                                                    <asp:Label ID="Label68" runat="server"></asp:Label>
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </asp:Panel>
                                                                </td>
                                                            </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:Panel ID="pn3062" runat="server" Enabled="False">
                                                                    <table width="100%">
                                                                        <tr>
                                                                            <td align="left" valign="top" width="30%">
                                                                                <asp:Label ID="Label69" runat="server" Text="Folate"></asp:Label>
                                                                            </td>
                                                                            <td align="left" valign="top">
                                                                                <asp:TextBox ID="t3062" runat="server" MaxLength="5" onbeforepaste="BeforePaste_Event()"
                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()" Width="40px"></asp:TextBox>
                                                                                <asp:Label ID="Label70" runat="server" Text="mg/ml"></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </asp:Panel>
                                                            </td>
                                                            <tr>
                                                                <td>
                                                                    <asp:Panel ID="pn3063" runat="server" Enabled="False">
                                                                        <table width="100%">
                                                                            <tr>
                                                                                <td align="left" valign="top" width="30%">
                                                                                    <asp:Label ID="Label71" runat="server" Text="Lactate"></asp:Label>
                                                                                </td>
                                                                                <td align="left" valign="top">
                                                                                    <asp:TextBox ID="t3063" runat="server" MaxLength="5" onbeforepaste="BeforePaste_Event()"
                                                                                             onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()" Width="40px"></asp:TextBox>
                                                                                    <asp:Label ID="Label72" runat="server" Text="mg/dl"></asp:Label>
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </asp:Panel>
                                                                </td>
                                                            </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:Panel ID="pn3064" runat="server" Enabled="False">
                                                                    <table width="100%">
                                                                        <tr>
                                                                            <td align="left" valign="top" width="30%">
                                                                                <asp:Label ID="Label73" runat="server" Text="Uric Acid"></asp:Label>
                                                                            </td>
                                                                            <td align="left" valign="top">
                                                                                <asp:TextBox ID="t3064" runat="server" MaxLength="5" onbeforepaste="BeforePaste_Event()"
                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()" Width="40px"></asp:TextBox>
                                                                                <asp:Label ID="Label74" runat="server" Text="mg/dl"></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </asp:Panel>
                                                            </td>
                                                            <tr>
                                                                <td>
                                                                    <asp:Panel ID="pn3065" runat="server" Enabled="False">
                                                                        <table width="100%">
                                                                            <tr>
                                                                                <td align="left" valign="top" width="30%">
                                                                                    <asp:Label ID="Label75" runat="server" Text="TIBO"></asp:Label>
                                                                                </td>
                                                                                <td align="left" valign="top">
                                                                                    <asp:TextBox ID="t3065" runat="server" MaxLength="5" onbeforepaste="BeforePaste_Event()"
                                                                                             onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()" Width="40px"></asp:TextBox>
                                                                                    <asp:Label ID="Label76" runat="server" Text="µg/dl"></asp:Label>
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </asp:Panel>
                                                                </td>
                                                            </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:Panel ID="pn3066" runat="server" Enabled="False">
                                                                    <table width="100%">
                                                                        <tr>
                                                                            <td align="left" valign="top" width="30%">
                                                                                <asp:Label ID="Label77" runat="server" Text="Fenetin"></asp:Label>
                                                                            </td>
                                                                            <td align="left" valign="top">
                                                                                <asp:TextBox ID="t3066" runat="server" MaxLength="5" onbeforepaste="BeforePaste_Event()"
                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()" Width="40px"></asp:TextBox>
                                                                                <asp:Label ID="Label78" runat="server" Text="mg/ml"></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </asp:Panel>
                                                            </td>
                                                            <tr>
                                                                <td>
                                                                    <asp:Panel ID="pn3067" runat="server" Enabled="False">
                                                                        <table width="100%">
                                                                            <tr>
                                                                                <td align="left" valign="top" width="30%">
                                                                                    <asp:Label ID="Label79" runat="server" Text="Transfein"></asp:Label>
                                                                                </td>
                                                                                <td align="left" valign="top">
                                                                                    <asp:TextBox ID="t3067" runat="server" MaxLength="5" onbeforepaste="BeforePaste_Event()"
                                                                                             onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()" Width="40px"></asp:TextBox>
                                                                                    <asp:Label ID="Label80" runat="server" Text="mg/dl"></asp:Label>
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </asp:Panel>
                                                                </td>
                                                            </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:Panel ID="pn3068" runat="server" Enabled="False">
                                                                    <table width="100%">
                                                                        <tr>
                                                                            <td align="left" valign="top" width="30%">
                                                                                <asp:Label ID="Label81" runat="server" Text="LBC Sat"></asp:Label>
                                                                            </td>
                                                                            <td align="left" valign="top">
                                                                                <asp:TextBox ID="t3068" runat="server" MaxLength="5" onbeforepaste="BeforePaste_Event()"
                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()" Width="40px"></asp:TextBox>
                                                                                <asp:Label ID="Label82" runat="server" Text="%"></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </asp:Panel>
                                                            </td>
                                                            <tr>
                                                                <td>
                                                                    <asp:Panel ID="pn3069" runat="server" Enabled="False">
                                                                        <table width="100%">
                                                                            <tr>
                                                                                <td align="left" valign="top" width="30%">
                                                                                    <asp:Label ID="Label83" runat="server" Text="Sr. Iron"></asp:Label>
                                                                                </td>
                                                                                <td align="left" valign="top">
                                                                                    <asp:TextBox ID="t3069" runat="server" MaxLength="5" onbeforepaste="BeforePaste_Event()"
                                                                                             onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()" Width="40px"></asp:TextBox>
                                                                                    <asp:Label ID="Label84" runat="server" Text="µg/dl"></asp:Label>
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </asp:Panel>
                                                                </td>
                                                            </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:Panel ID="pn3070" runat="server" Enabled="False">
                                                                    <table width="100%">
                                                                        <tr>
                                                                            <td width="30%">
                                                                                <label>
                                                                                    Lipase</label>
                                                                            </td>
                                                                            <td>
                                                                                <asp:TextBox ID="t3070" runat="server" MaxLength="5" onbeforepaste="BeforePaste_Event()"
                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()" Width="40px"></asp:TextBox>
                                                                                <label>
                                                                                    IU/L</label>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </asp:Panel>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <a id="a3071" runat="server" href="javascript:animatedcollapse.toggle('d3071')" visible="False">
                                                    <span class="label_collapse">Tumor Markers</span></a>
                                                <div id="d3071" style="display: none; padding-left: 30px;">
                                                    <table width="70%">
                                                        <tr>
                                                            <td>
                                                                <asp:Panel ID="pn3072" runat="server" Enabled="False">
                                                                    <table width="100%">
                                                                        <tr>
                                                                            <td align="left" valign="top" width="30%">
                                                                                <asp:Label ID="Label85" runat="server" CssClass="defaultfontcolor" Text="PSA"></asp:Label>
                                                                            </td>
                                                                            <td align="left" valign="top">
                                                                                <asp:TextBox ID="t3072" runat="server" MaxLength="5" onbeforepaste="BeforePaste_Event()"
                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()" Width="40px"></asp:TextBox>
                                                                                <asp:Label ID="Label86" runat="server" CssClass="defaultfontcolor" Text="mg/ml"></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </asp:Panel>
                                                            </td>
                                                            <td>
                                                                <asp:Panel ID="pn3073" runat="server" Enabled="False">
                                                                    <table width="100%">
                                                                        <tr>
                                                                            <td align="left" valign="top" width="30%">
                                                                                <asp:Label ID="Label87" runat="server" CssClass="defaultfontcolor" Text="GA&lt;sub&gt;125&lt;/sub&gt;"></asp:Label>
                                                                            </td>
                                                                            <td align="left" valign="top">
                                                                                <asp:TextBox ID="t3073" runat="server" MaxLength="5" onbeforepaste="BeforePaste_Event()"
                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()" Width="40px"></asp:TextBox>
                                                                                <asp:Label ID="Label88" runat="server" CssClass="defaultfontcolor"></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </asp:Panel>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:Panel ID="pn3074" runat="server" Enabled="False">
                                                                    <table width="100%">
                                                                        <tr>
                                                                            <td align="left" valign="top" width="30%">
                                                                                <asp:Label ID="Label89" runat="server" Text="CEA"></asp:Label>
                                                                            </td>
                                                                            <td align="left" valign="top">
                                                                                <asp:TextBox ID="t3074" runat="server" MaxLength="5" onbeforepaste="BeforePaste_Event()"
                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()" Width="40px"></asp:TextBox>
                                                                                <asp:Label ID="Label90" runat="server" CssClass="defaultfontcolor" Text="mg/ml"></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </asp:Panel>
                                                            </td>
                                                            <td>
                                                                <asp:Panel ID="pn3075" runat="server" Enabled="False">
                                                                    <table width="100%">
                                                                        <tr>
                                                                            <td align="left" valign="top" width="30%">
                                                                                <asp:Label ID="Label91" runat="server" Text="AFP"></asp:Label>
                                                                            </td>
                                                                            <td align="left" valign="top">
                                                                                <asp:TextBox ID="t3075" runat="server" MaxLength="5" onbeforepaste="BeforePaste_Event()"
                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()" Width="40px"></asp:TextBox>
                                                                                <asp:Label ID="Label92" runat="server" CssClass="defaultfontcolor" Text="mg/ml"></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </asp:Panel>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="2">
                                                                <asp:Panel ID="pn3076" runat="server" Enabled="False">
                                                                    <table width="119%">
                                                                        <tr>
                                                                            <td align="left" valign="top" width="30%">
                                                                                <asp:Label ID="Label93" runat="server" Text="Others"></asp:Label>
                                                                            </td>
                                                                            <td align="left" valign="top">
                                                                                <asp:TextBox ID="t3076" runat="server" MaxLength="5" Width="40px"></asp:TextBox>
                                                                                <asp:Label ID="Label94" runat="server"></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </asp:Panel>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <a id="a3077" runat="server" href="javascript:animatedcollapse.toggle('d3077')" visible="False">
                                                    <span class="label_collapse">Hormone Assays</span></a>
                                                <div id="d3077" style="display: none; padding-left: 30px">
                                                    <table width="100%">
                                                        <tr>
                                                            <td>
                                                                <a id="a3078" runat="server" href="javascript:animatedcollapse.toggle('d3078')" visible="False">
                                                                    <span class="label_collapse">Thyroid Profile</span></a>
                                                                <div id="d3078" style="display: none; padding-left: 20px">
                                                                    <table border="0" cellpadding="0" cellspacing="0" width="90%">
                                                                        <tr>
                                                                            <td>
                                                                                <asp:Panel ID="pn3079" runat="server" Enabled="False">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td align="right" width="30%">
                                                                                                <label>
                                                                                                    T<sub>3</sub>-Free T<sub>3</sub></label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:TextBox ID="t3079" runat="server" MaxLength="6" onbeforepaste="BeforePaste_Event()"
                                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()" Width="45px"></asp:TextBox>
                                                                                                <label>
                                                                                                    mg/dl</label>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                            <tr>
                                                                                <td>
                                                                                    <asp:Panel ID="pn3080" runat="server" Enabled="False">
                                                                                        <table width="100%">
                                                                                            <tr>
                                                                                                <td align="right" width="30%">
                                                                                                    <label>
                                                                                                        T<sub>3</sub>- T<sub>3</sub></label>
                                                                                                </td>
                                                                                                <td>
                                                                                                    <asp:TextBox ID="t3080" runat="server" MaxLength="6" onbeforepaste="BeforePaste_Event()"
                                                                                                             onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()" Width="45px"></asp:TextBox>
                                                                                                    <label>
                                                                                                        pg/dl</label>
                                                                                                </td>
                                                                                            </tr>
                                                                                        </table>
                                                                                    </asp:Panel>
                                                                                </td>
                                                                            </tr>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:Panel ID="pn3081" runat="server" Enabled="False">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td align="right" height="26" width="30%">
                                                                                                <label>
                                                                                                    T<sub>3</sub>- Reverse T<sub>3</sub></label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:TextBox ID="t3081" runat="server" MaxLength="6" onbeforepaste="BeforePaste_Event()"
                                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()" Width="45px"></asp:TextBox>
                                                                                                <label>
                                                                                                    mg/dl</label>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                            <td>
                                                                                <asp:Panel ID="pn3082" runat="server" Enabled="False">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td align="right" width="30%">
                                                                                                <label>
                                                                                                    T<sub>4</sub>- T<sub>4</sub></label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:TextBox ID="t3082" runat="server" MaxLength="6" onbeforepaste="BeforePaste_Event()"
                                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()" Width="45px"></asp:TextBox>
                                                                                                <label>
                                                                                                    µg/dL</label>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:Panel ID="pn3083" runat="server" Enabled="False">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td align="right" width="30%">
                                                                                                <label>
                                                                                                    T<sub>4</sub>-Free T<sub>4</sub></label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:TextBox ID="t3083" runat="server" MaxLength="6" onbeforepaste="BeforePaste_Event()"
                                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()" Width="45px"></asp:TextBox>
                                                                                                <label>
                                                                                                    mg/dl</label>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                            <tr>
                                                                                <td>
                                                                                    <asp:Panel ID="pn3084" runat="server" Enabled="False">
                                                                                        <table width="100%">
                                                                                            <tr>
                                                                                                <td align="right" width="30%">
                                                                                                    <label>
                                                                                                        TSH</label>
                                                                                                </td>
                                                                                                <td>
                                                                                                    <asp:TextBox ID="t3084" runat="server" MaxLength="6" onbeforepaste="BeforePaste_Event()"
                                                                                                             onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()" Width="45px"></asp:TextBox>
                                                                                                    <label>
                                                                                                        µunits/ml</label>
                                                                                                </td>
                                                                                            </tr>
                                                                                        </table>
                                                                                    </asp:Panel>
                                                                                </td>
                                                                            </tr>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:Panel ID="pn3085" runat="server" Enabled="False">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td align="right" width="30%">
                                                                                                <label>
                                                                                                    IPTH</label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:TextBox ID="t3085" runat="server" MaxLength="6" onbeforepaste="BeforePaste_Event()"
                                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()" Width="45px"></asp:TextBox>
                                                                                                <label>
                                                                                                </label>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                            <tr>
                                                                                <td>
                                                                                    <asp:Panel ID="pn3086" runat="server" Enabled="False">
                                                                                        <table width="100%">
                                                                                            <tr>
                                                                                                <td align="right" width="30%">
                                                                                                    <label>
                                                                                                        Thyroglobulin</label>
                                                                                                </td>
                                                                                                <td>
                                                                                                    <asp:TextBox ID="t3086" runat="server" MaxLength="6" onbeforepaste="BeforePaste_Event()"
                                                                                                             onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()" Width="45px"></asp:TextBox>
                                                                                                    <label>
                                                                                                        pg/dl</label>
                                                                                                </td>
                                                                                            </tr>
                                                                                        </table>
                                                                                    </asp:Panel>
                                                                                </td>
                                                                            </tr>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:Panel ID="pn3087" runat="server" Enabled="False">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td align="right" width="30%">
                                                                                                <label>
                                                                                                    Free Thyroxine index</label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:TextBox ID="t3087" runat="server" MaxLength="6" onbeforepaste="BeforePaste_Event()"
                                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()" Width="45px"></asp:TextBox>
                                                                                                <label>
                                                                                                </label>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                            <td>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <a id="a3088" runat="server" href="javascript:animatedcollapse.toggle('d3088')" visible="False">
                                                                    <span class="label_collapse">General</span></a>
                                                                <div id="d3088" style="display: none; padding-left: 20px">
                                                                    <table border="0" cellpadding="0" cellspacing="0" width="90%">
                                                                        <tr>
                                                                            <td>
                                                                                <asp:Panel ID="pn3089" runat="server" Enabled="False">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td width="30%">
                                                                                                <label>
                                                                                                    Fasting Insulin</label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:TextBox ID="t3089" runat="server" MaxLength="6" onbeforepaste="BeforePaste_Event()"
                                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onpaste="Paste_Event()" Width="45px"></asp:TextBox>
                                                                                                <label>
                                                                                                    µU/ml</label>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                            <td>
                                                                                <asp:Panel ID="pn3090" runat="server" Enabled="False">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td width="30%">
                                                                                                <label>
                                                                                                    Growth Hormone</label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:TextBox ID="t3090" runat="server" MaxLength="6" onbeforepaste="BeforePaste_Event()"
                                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onpaste="Paste_Event()" Width="45px"></asp:TextBox>
                                                                                                <label>
                                                                                                    mg/ml</label>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:Panel ID="pn3091" runat="server" Enabled="False">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td width="30%">
                                                                                                <label>
                                                                                                    Glucagon</label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:TextBox ID="t3091" runat="server" MaxLength="6" onbeforepaste="BeforePaste_Event()"
                                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onpaste="Paste_Event()" Width="45px"></asp:TextBox>
                                                                                                <label>
                                                                                                    pg/ml</label>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                            <td>
                                                                                <asp:Panel ID="pn3092" runat="server" Enabled="False">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td width="30%">
                                                                                                <label>
                                                                                                    Serotorin</label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:TextBox ID="t3092" runat="server" MaxLength="6" onbeforepaste="BeforePaste_Event()"
                                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onpaste="Paste_Event()" Width="45px"></asp:TextBox>
                                                                                                <label>
                                                                                                    mg/ml</label>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:Panel ID="pn3093" runat="server" Enabled="False">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td width="30%">
                                                                                                <label>
                                                                                                    C-Peptide</label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:TextBox ID="t3093" runat="server" MaxLength="6" onbeforepaste="BeforePaste_Event()"
                                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onpaste="Paste_Event()" Width="45px"></asp:TextBox>
                                                                                                <label>
                                                                                                    mg/ml</label>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                            <td>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <a id="a3094" runat="server" href="javascript:animatedcollapse.toggle('d3094')" visible="False">
                                                                    <span class="label_collapse">Adrenal Hormones</span></a>
                                                                <div id="d3094" style="display: none; padding-left: 20px">
                                                                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                                                        <tr>
                                                                            <td>
                                                                                <asp:Panel ID="pn3095" runat="server" Enabled="False">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td width="40%">
                                                                                                <label>
                                                                                                    Cortisol Free</label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:TextBox ID="t3095" runat="server" Width="45px"></asp:TextBox>
                                                                                                <label>
                                                                                                    µg/24hours</label>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                            <td>
                                                                                <asp:Panel ID="pn3096" runat="server" Enabled="False">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td width="40%">
                                                                                                <label>
                                                                                                    Fasting 8Am-12Noon</label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:TextBox ID="t3096" runat="server" Width="45px"></asp:TextBox>
                                                                                                <label>
                                                                                                    µg/24hours</label>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:Panel ID="pn3097" runat="server" Enabled="False">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td width="40%">
                                                                                                <label>
                                                                                                    Fasting 12 Noon-8Pm</label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:TextBox ID="t3097" runat="server" Width="45px"></asp:TextBox>
                                                                                                <label>
                                                                                                    µg/24hours</label>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                            <td>
                                                                                <asp:Panel ID="pn3098" runat="server" Enabled="False">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td width="40%">
                                                                                                <label>
                                                                                                    Fasting 8Pm-8Am</label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:TextBox ID="t3098" runat="server" Width="45px"></asp:TextBox>
                                                                                                <label>
                                                                                                    µg/24hours</label>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:Panel ID="pn3099" runat="server" Enabled="False">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td width="40%">
                                                                                                <label>
                                                                                                    Deoxycorticosterone</label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:TextBox ID="t3099" runat="server" MaxLength="6" onbeforepaste="BeforePaste_Event()"
                                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()" Width="45px"></asp:TextBox>
                                                                                                <label>
                                                                                                    µ /dl</label>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                            <td>
                                                                                <asp:Panel ID="pn3100" runat="server" Enabled="False">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td width="40%">
                                                                                                <label>
                                                                                                    Aldosterone supine</label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:TextBox ID="t3100" runat="server" MaxLength="6" onbeforepaste="BeforePaste_Event()"
                                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()" Width="45px"></asp:TextBox>
                                                                                                <label>
                                                                                                    µ /dl</label>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:Panel ID="pn3101" runat="server" Enabled="False">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td width="40%">
                                                                                                <label>
                                                                                                    Aldosterone Upright</label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:TextBox ID="t3101" runat="server" MaxLength="6" onbeforepaste="BeforePaste_Event()"
                                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()" Width="45px"></asp:TextBox>
                                                                                                <label>
                                                                                                    µ /dl</label>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                            <td>
                                                                                <asp:Panel ID="pn3102" runat="server" Enabled="False">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td width="40%">
                                                                                                <label>
                                                                                                    Epinephrine Supine</label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:TextBox ID="t3102" runat="server" MaxLength="6" onbeforepaste="BeforePaste_Event()"
                                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()" Width="45px"></asp:TextBox>
                                                                                                <label>
                                                                                                    pg/ml</label>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:Panel ID="pn3103" runat="server" Enabled="False">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td width="40%">
                                                                                                <label>
                                                                                                    Epinephrine Siting</label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:TextBox ID="t3103" runat="server" MaxLength="6" onbeforepaste="BeforePaste_Event()"
                                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()" Width="45px"></asp:TextBox>
                                                                                                <label>
                                                                                                    pg/ml</label>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                            <td>
                                                                                <asp:Panel ID="pn3104" runat="server" Enabled="False">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td width="40%">
                                                                                                <label>
                                                                                                    NorEpinephrine Supine</label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:TextBox ID="t3104" runat="server" MaxLength="6" onbeforepaste="BeforePaste_Event()"
                                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()" Width="45px"></asp:TextBox>
                                                                                                <label>
                                                                                                    pg/ml</label>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:Panel ID="pn3105" runat="server" Enabled="False">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td width="40%">
                                                                                                <label>
                                                                                                    NorEpinephrine Siting</label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:TextBox ID="t3105" runat="server" MaxLength="6" onbeforepaste="BeforePaste_Event()"
                                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()" Width="45px"></asp:TextBox>
                                                                                                <label>
                                                                                                    pg/ml</label>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                            <td>
                                                                                <asp:Panel ID="pn3106" runat="server" Enabled="False">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td width="40%">
                                                                                                <label>
                                                                                                    Metanephrine</label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:TextBox ID="t3106" runat="server" MaxLength="6" onbeforepaste="BeforePaste_Event()"
                                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()" Width="45px"></asp:TextBox>
                                                                                                <label>
                                                                                                </label>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:Panel ID="pn3107" runat="server" Enabled="False">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td width="40%">
                                                                                                <label>
                                                                                                    Renin Supine</label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:TextBox ID="t3107" runat="server" MaxLength="6" onbeforepaste="BeforePaste_Event()"
                                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()" Width="45px"></asp:TextBox>
                                                                                                <label>
                                                                                                    mg/ml</label>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                            <td>
                                                                                <asp:Panel ID="pn3108" runat="server" Enabled="False">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td width="40%">
                                                                                                <label>
                                                                                                    Renin Upright</label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:TextBox ID="t3108" runat="server" MaxLength="6" onbeforepaste="BeforePaste_Event()"
                                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()" Width="45px"></asp:TextBox>
                                                                                                <label>
                                                                                                    mg/ml</label>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:Panel ID="pn3109" runat="server" Enabled="False">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td width="40%">
                                                                                                <label>
                                                                                                    ACTH</label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:TextBox ID="t3109" runat="server" MaxLength="6" onbeforepaste="BeforePaste_Event()"
                                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()" Width="45px"></asp:TextBox>
                                                                                                <label>
                                                                                                    pg/ml</label>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <a id="a3111" runat="server" href="javascript:animatedcollapse.toggle('d3111')" visible="False">
                                                                    <span class="label_collapse">Sex Steroids</span></a>
                                                                <div id="d3111" style="display: none; padding-left: 20px">
                                                                    <table border="0" cellpadding="0" cellspacing="0" width="90%">
                                                                        <tr>
                                                                            <td>
                                                                                <asp:Panel ID="pn3112" runat="server" Enabled="False">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td align="left" width="40%">
                                                                                                <label>
                                                                                                    Testosterone Total</label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:TextBox ID="t3112" runat="server" MaxLength="6" onbeforepaste="BeforePaste_Event()"
                                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()" Width="45px"></asp:TextBox>
                                                                                                <label>
                                                                                                    µ /dl</label>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                            <td>
                                                                                <asp:Panel ID="pn3113" runat="server" Enabled="False">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td width="40%">
                                                                                                <label>
                                                                                                    Free</label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:TextBox ID="t3113" runat="server" MaxLength="6" onbeforepaste="BeforePaste_Event()"
                                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()" Width="45px"></asp:TextBox>
                                                                                                <label>
                                                                                                    µ /dl</label>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:Panel ID="pn3114" runat="server" Enabled="False">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td width="40%">
                                                                                                <label>
                                                                                                    DHEA</label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:TextBox ID="t3114" runat="server" MaxLength="6" onbeforepaste="BeforePaste_Event()"
                                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()" Width="45px"></asp:TextBox>
                                                                                                <label>
                                                                                                    µ /dl</label>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                            <td>
                                                                                <asp:Panel ID="pn3115" runat="server" Enabled="False">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td style="width: 10%">
                                                                                                <label style="width: 10%">
                                                                                                    Dihydroepiandosterone</label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:TextBox ID="t3115" runat="server" MaxLength="6" onbeforepaste="BeforePaste_Event()"
                                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()" Width="45px"></asp:TextBox>
                                                                                                <label>
                                                                                                    µ /dl</label>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:Panel ID="pn3116" runat="server" Enabled="False">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td width="40%">
                                                                                                <label>
                                                                                                    Androstenedione</label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:TextBox ID="t3116" runat="server" MaxLength="6" onbeforepaste="BeforePaste_Event()"
                                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()" Width="45px"></asp:TextBox>
                                                                                                <label>
                                                                                                    µ /dl</label>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                            <td>
                                                                                <asp:Panel ID="pn3117" runat="server" Enabled="False">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td width="20%">
                                                                                                <label>
                                                                                                    <em>Progesterone</em></label>
                                                                                            </td>
                                                                                            <td width="30%">
                                                                                                <div id="d3117" style="display: none">
                                                                                                    <asp:DropDownList ID="dd3117" runat="server">
                                                                                                        <asp:ListItem>Follicular</asp:ListItem>
                                                                                                        <asp:ListItem>Ovulatory</asp:ListItem>
                                                                                                        <asp:ListItem>Midluteal</asp:ListItem>
                                                                                                    </asp:DropDownList>
                                                                                                </div>
                                                                                                <div>
                                                                                                    <asp:TextBox ID="t3117" runat="server" MaxLength="6" onbeforepaste="BeforePaste_Event()"
                                                                                                             onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()" Width="45px"></asp:TextBox>
                                                                                                    <label>
                                                                                                        µ /dl</label>
                                                                                                </div>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:Panel ID="pn3118" runat="server" Enabled="False">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td style="width: 5%">
                                                                                                <label style="width: 5%; white-space: pre;">
                                                                                                    17-Hydroxyprogesterone</label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <div id="d3118" style="display: none">
                                                                                                    <asp:DropDownList ID="dd3118" runat="server">
                                                                                                        <asp:ListItem>Midcycle</asp:ListItem>
                                                                                                        <asp:ListItem>Luteal</asp:ListItem>
                                                                                                        <asp:ListItem>Follicular</asp:ListItem>
                                                                                                        <asp:ListItem>Postmenopausal</asp:ListItem>
                                                                                                    </asp:DropDownList>
                                                                                                </div>
                                                                                                <div id="dd3118" style="display: block">
                                                                                                    <asp:TextBox ID="t3118" runat="server" MaxLength="6" onbeforepaste="BeforePaste_Event()"
                                                                                                             onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()" Width="45px"></asp:TextBox><label>
                                                                                                            µ /dl</label></div>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                            <td>
                                                                                <asp:Panel ID="pn3119" runat="server" Enabled="False">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td width="40%">
                                                                                                <label>
                                                                                                    <em>Estradiol</em></label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <div id="d3119" style="display: none">
                                                                                                    <asp:DropDownList ID="dd3119" runat="server">
                                                                                                        <asp:ListItem>Luteal</asp:ListItem>
                                                                                                        <asp:ListItem>Follicular</asp:ListItem>
                                                                                                        <asp:ListItem>MidCycle</asp:ListItem>
                                                                                                        <asp:ListItem>Postmenopausal</asp:ListItem>
                                                                                                    </asp:DropDownList>
                                                                                                </div>
                                                                                                <div>
                                                                                                    <asp:TextBox ID="t3119" runat="server" MaxLength="6" onbeforepaste="BeforePaste_Event()"
                                                                                                             onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()" Width="45px"></asp:TextBox>
                                                                                                    <label>
                                                                                                        pg/ml</label>
                                                                                                </div>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:Panel ID="pn3120" runat="server" Enabled="False">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td width="20%">
                                                                                                <label>
                                                                                                    Estrane</label>
                                                                                            </td>
                                                                                            <td width="30%">
                                                                                                <div id="d3120" style="display: none">
                                                                                                    <asp:DropDownList ID="dd3120" runat="server">
                                                                                                        <asp:ListItem>Luteal</asp:ListItem>
                                                                                                        <asp:ListItem>Follicular</asp:ListItem>
                                                                                                        <asp:ListItem>MidCycle</asp:ListItem>
                                                                                                        <asp:ListItem>Postmenopausal</asp:ListItem>
                                                                                                    </asp:DropDownList>
                                                                                                </div>
                                                                                                <div>
                                                                                                    <asp:TextBox ID="t3120" runat="server" MaxLength="6" onbeforepaste="BeforePaste_Event()"
                                                                                                             onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()" Width="45px"></asp:TextBox>
                                                                                                    <label>
                                                                                                        pg/mll</label>
                                                                                                </div>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                            <td>
                                                                                <asp:Panel ID="pn3121" runat="server" Enabled="False">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td width="40%">
                                                                                                <label>
                                                                                                    <em>Prolactin</em></label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:TextBox ID="t3121" runat="server" MaxLength="6" onbeforepaste="BeforePaste_Event()"
                                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()" Width="45px"></asp:TextBox>
                                                                                                <label>
                                                                                                    µ /dl</label>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:Panel ID="pn3122" runat="server" Enabled="False">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td width="20%">
                                                                                                <label>
                                                                                                    FSH</label>
                                                                                            </td>
                                                                                            <td width="30%">
                                                                                                <div id="d3122" style="display: none">
                                                                                                    <asp:DropDownList ID="dd3122" runat="server">
                                                                                                        <asp:ListItem>Follicular</asp:ListItem>
                                                                                                        <asp:ListItem>Ovulatory Phase</asp:ListItem>
                                                                                                        <asp:ListItem>Luteal Phase</asp:ListItem>
                                                                                                        <asp:ListItem>Post Menopausal</asp:ListItem>
                                                                                                    </asp:DropDownList>
                                                                                                </div>
                                                                                                <div>
                                                                                                    <asp:TextBox ID="t3122" runat="server" MaxLength="6" onbeforepaste="BeforePaste_Event()"
                                                                                                             onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()" Width="45px"></asp:TextBox>
                                                                                                    <label>
                                                                                                        U/L</label>
                                                                                                </div>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                            <td>
                                                                                <asp:Panel ID="pn3123" runat="server" Enabled="False">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td width="20%">
                                                                                                <label>
                                                                                                    <em>LH</em></label>
                                                                                            </td>
                                                                                            <td width="30%">
                                                                                                <div id="d3123" style="display: none">
                                                                                                    <asp:DropDownList ID="dd3123" runat="server">
                                                                                                        <asp:ListItem>Follicular</asp:ListItem>
                                                                                                        <asp:ListItem>Ovulatory Phase</asp:ListItem>
                                                                                                        <asp:ListItem>Luteal Phase</asp:ListItem>
                                                                                                        <asp:ListItem>Post Menopausal</asp:ListItem>
                                                                                                    </asp:DropDownList>
                                                                                                </div>
                                                                                                <div>
                                                                                                    <asp:TextBox ID="t3123" runat="server" MaxLength="6" onbeforepaste="BeforePaste_Event()"
                                                                                                             onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()" Width="45px"></asp:TextBox>
                                                                                                    <label>
                                                                                                        U/L</label>
                                                                                                </div>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td colspan="2">
                                                                                <asp:Panel ID="pn3124" runat="server" Enabled="False">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td width="20%">
                                                                                                <label>
                                                                                                    &#946;HCG</label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <div id="d3124" style="display: none">
                                                                                                    <asp:DropDownList ID="dd3124" runat="server">
                                                                                                    </asp:DropDownList>
                                                                                                </div>
                                                                                                <div>
                                                                                                    <asp:TextBox ID="t3124" runat="server" MaxLength="6" onbeforepaste="BeforePaste_Event()"
                                                                                                             onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()" Width="45px"></asp:TextBox>
                                                                                                    <label>
                                                                                                        U/L</label>
                                                                                                </div>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td colspan="2">
                                                                                <a id="a3125" runat="server" href="javascript:animatedcollapse.toggle('d3125')" visible="False">
                                                                                    <span class="label_collapse">Pregnancy Test</span></a>
                                                                                <div id="d3125" style="display: none; padding-left: 20px">
                                                                                    <asp:Panel ID="pn3126" runat="server" Enabled="False">
                                                                                        <table border="0" cellpadding="0" cellspacing="0">
                                                                                            <tr>
                                                                                                <td>
                                                                                                    <label>
                                                                                                        <em>HCG</em></label>
                                                                                                </td>
                                                                                                <td>
                                                                                                    <asp:DropDownList ID="dd3126" runat="server">
                                                                                                        <asp:ListItem>Urine</asp:ListItem>
                                                                                                        <asp:ListItem>Serum</asp:ListItem>
                                                                                                    </asp:DropDownList>
                                                                                                </td>
                                                                                                <td>
                                                                                                    <asp:DropDownList ID="dd13126" runat="server" onchange="ShowHCG()">
                                                                                                        <asp:ListItem>Select</asp:ListItem>
                                                                                                        <asp:ListItem>Qualitative</asp:ListItem>
                                                                                                        <asp:ListItem>Quantitative</asp:ListItem>
                                                                                                    </asp:DropDownList>
                                                                                                </td>
                                                                                                <td>
                                                                                                </td>
                                                                                                <td>
                                                                                                    <div id="divHCGResult" style="display: none">
                                                                                                        <asp:TextBox ID="t3126" runat="server" MaxLength="6" onbeforepaste="BeforePaste_Event()"
                                                                                                                 onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()" Width="45px"></asp:TextBox>
                                                                                                        <label>
                                                                                                            mIU/ml</label>
                                                                                                    </div>
                                                                                                </td>
                                                                                                <td>
                                                                                                </td>
                                                                                                <td>
                                                                                                    <div id="divHCGQual" style="display: none">
                                                                                                        <asp:DropDownList ID="dd23126" runat="server">
                                                                                                            <asp:ListItem>Positive</asp:ListItem>
                                                                                                            <asp:ListItem>Negative</asp:ListItem>
                                                                                                        </asp:DropDownList>
                                                                                                    </div>
                                                                                                </td>
                                                                                                <td>
                                                                                                </td>
                                                                                            </tr>
                                                                                        </table>
                                                                                    </asp:Panel>
                                                                                </div>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <a id="a3127" runat="server" href="javascript:animatedcollapse.toggle('d3127')" visible="False">
                                                                    <span class="label_collapse">Stool Analysis</span></a>
                                                                <div id="d3127" style="display: none; padding-left: 20px">
                                                                    <table border="0" cellpadding="0" cellspacing="0" width="90%">
                                                                        <tr>
                                                                            <td>
                                                                                <asp:Panel ID="pn3128" runat="server" Enabled="False">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td width="40%">
                                                                                                <label>
                                                                                                    Colour</label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:DropDownList ID="dd3128" runat="server">
                                                                                                    <asp:ListItem>Yello</asp:ListItem>
                                                                                                    <asp:ListItem>Green</asp:ListItem>
                                                                                                    <asp:ListItem>Black</asp:ListItem>
                                                                                                    <asp:ListItem>Red&gt;</asp:ListItem>
                                                                                                </asp:DropDownList>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                            <td>
                                                                                <asp:Panel ID="pn3129" runat="server" Enabled="False">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td width="40%">
                                                                                                <label>
                                                                                                    Consistency</label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:DropDownList ID="dd3129" runat="server">
                                                                                                    <asp:ListItem>Solid</asp:ListItem>
                                                                                                    <asp:ListItem>Liquid</asp:ListItem>
                                                                                                    <asp:ListItem>Semi-Solid</asp:ListItem>
                                                                                                    <asp:ListItem>Watery</asp:ListItem>
                                                                                                </asp:DropDownList>
                                                                                                <label>
                                                                                                </label>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:Panel ID="pn3130" runat="server" Enabled="False">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td width="40%">
                                                                                                <label>
                                                                                                    Cysts</label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:DropDownList ID="dd3130" runat="server">
                                                                                                    <asp:ListItem>E.Coli</asp:ListItem>
                                                                                                    <asp:ListItem>Giardia</asp:ListItem>
                                                                                                </asp:DropDownList>
                                                                                                <label>
                                                                                                </label>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                            <td>
                                                                                <asp:Panel ID="pn3131" runat="server" Enabled="False">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td width="40%">
                                                                                                <label>
                                                                                                    Occult Blood</label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:DropDownList ID="dd3131" runat="server">
                                                                                                    <asp:ListItem>Positive</asp:ListItem>
                                                                                                    <asp:ListItem>Negative</asp:ListItem>
                                                                                                </asp:DropDownList>
                                                                                                <label>
                                                                                                </label>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:Panel ID="pn3132" runat="server" Enabled="False">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td width="40%">
                                                                                                <label>
                                                                                                    Stool Fat(24 hrs)</label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:TextBox ID="t3132" runat="server" Width="40px"></asp:TextBox>
                                                                                                <label>
                                                                                                    gms/day</label>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                            <td>
                                                                                <asp:Panel ID="pn3133" runat="server" Enabled="False">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td width="40%">
                                                                                                <label>
                                                                                                    Stool Fatty Acid</label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:TextBox ID="t3133" runat="server" Width="40px"></asp:TextBox>
                                                                                                <label>
                                                                                                    %</label>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:Panel ID="pn3134" runat="server" Enabled="False">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td width="40%">
                                                                                                <label>
                                                                                                    Stool Proteins</label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:TextBox ID="t3134" runat="server" Width="40px"></asp:TextBox>
                                                                                                <label>
                                                                                                </label>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                            <td>
                                                                                <asp:Panel ID="pn3135" runat="server" Enabled="False">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td width="40%">
                                                                                                <label>
                                                                                                    Stool Urobilinogen</label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:TextBox ID="t3135" runat="server" Width="40px"></asp:TextBox>
                                                                                                <label>
                                                                                                    mg/day</label>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:Panel ID="pn3136" runat="server" Enabled="False">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td width="40%">
                                                                                                <label>
                                                                                                    Stool &#945;antithypsin</label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:TextBox ID="t3136" runat="server" Width="40px"></asp:TextBox>
                                                                                                <label>
                                                                                                    mg/g</label>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                            <td>
                                                                                <asp:Panel ID="pn3137" runat="server" Enabled="False">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td width="40%">
                                                                                                Stool Reducing Substances
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:TextBox ID="t3137" runat="server"      onkeypress="return ValidateOnlyNumeric(this);"   
                                                                                                    Width="40px"></asp:TextBox>
                                                                                                <label>
                                                                                                    g/dL</label>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                                                    <ContentTemplate>
                                                        <table>
                                                            <tr>
                                                                <td>
                                                                    <asp:Button ID="btnSaveBio" runat="server" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                                        onmouseout="this.className='btn'" OnClick="btnSaveBio_Click" TabIndex="26" Text="Save" />
                                                                    <asp:Button ID="Button1" runat="server" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                                        onmouseout="this.className='btn'" TabIndex="26" Text="Cancel" />
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblMsgBio" runat="server" CssClass="errormsg"></asp:Label>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </ContentTemplate>
                                                </asp:UpdatePanel>
                                            </td>
                                        </tr>
                                    </table>
                                </ContentTemplate>
                            </Ajax:TabPanel>
                            <Ajax:TabPanel runat="server" HeaderText="Hemotology" ID="tp2001" ForeColor="Black"
                                Enabled="false">
                                <HeaderTemplate>
                                    Hemotology
                                </HeaderTemplate>
                                <ContentTemplate>
                                    <table cellspacing="0" width="100%" border="0">
                                        <tr>
                                            <td colspan="2" width="100%">
                                                <asp:Panel ID="pn2002" runat="server" Enabled="False">
                                                    <table width="88%">
                                                        <tr>
                                                            <td align="left" valign="top" width="15%">
                                                                <asp:Label runat="server" CssClass="defaultfontcolor" Text="HB"></asp:Label>
                                                            </td>
                                                            <td align="left" style="height: 15%" valign="top" width="85%">
                                                                <asp:TextBox ID="t2002" runat="server" CssClass="Txtboxsmall" MaxLength="4" onbeforepaste="BeforePaste_Event()"
                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()" OnTextChanged="t2002_TextChanged"></asp:TextBox>
                                                                <label>
                                                                    gm%</label>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </asp:Panel>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" width="100%">
                                                <asp:Panel ID="pn2003" runat="server" Enabled="False">
                                                    <table width="88%">
                                                        <tr>
                                                            <td width="15%" align="left" valign="top">
                                                                <label>
                                                                    TC</label>
                                                            </td>
                                                            <td width="85%" align="left" valign="top" style="height: 15%">
                                                                <asp:TextBox ID="t2003" runat="server" CssClass="Txtboxsmall" MaxLength="6" onPaste="Paste_Event()"
                                                                    onbeforepaste="BeforePaste_Event()"      onkeypress="return ValidateOnlyNumeric(this);"   ></asp:TextBox>
                                                                <label>
                                                                    cells/cumm</label>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </asp:Panel>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="left" valign="top">
                                                <a id="a2004" runat="server" href="javascript:animatedcollapse.toggle('d2004')" visible="False">
                                                    <span class="label_collapse">DC</span></a>
                                            </td>
                                            <td align="left" valign="top" width="100%" style="height: 15%">
                                                <div id="d2004" style="width: 100%; display: none">
                                                    <table width="100%">
                                                        <tr>
                                                            <td>
                                                                <asp:Panel ID="pn2005" runat="server" Enabled="False">
                                                                    <table width="100%">
                                                                        <tr>
                                                                            <td width="93">
                                                                                <label>
                                                                                    N</label>
                                                                            </td>
                                                                            <td width="272">
                                                                                <asp:TextBox ID="t2005" runat="server" CssClass="textbox_hemat" MaxLength="4" onbeforepaste="BeforePaste_Event()"
                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()"></asp:TextBox>
                                                                                <label>
                                                                                    %</label>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </asp:Panel>
                                                            </td>
                                                            <td rowspan="3" width="6%">
                                                            </td>
                                                            <td width="54%">
                                                                <asp:Panel ID="pn2006" runat="server" Enabled="False">
                                                                    <table width="100%">
                                                                        <tr>
                                                                            <td width="15%">
                                                                                <label>
                                                                                    L</label>
                                                                            </td>
                                                                            <td width="144">
                                                                                <asp:TextBox ID="t2006" runat="server" CssClass="textbox_hemat" MaxLength="4" onbeforepaste="BeforePaste_Event()"
                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()"></asp:TextBox>
                                                                                <label>
                                                                                    %</label>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </asp:Panel>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:Panel ID="pn2007" runat="server" Enabled="False">
                                                                    <table width="100%">
                                                                        <tr>
                                                                            <td width="93">
                                                                                <label>
                                                                                    E</label>
                                                                            </td>
                                                                            <td width="272">
                                                                                <asp:TextBox ID="t2007" runat="server" CssClass="textbox_hemat" MaxLength="4" onbeforepaste="BeforePaste_Event()"
                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()"></asp:TextBox>
                                                                                <label>
                                                                                    %</label>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </asp:Panel>
                                                            </td>
                                                            <td>
                                                                <asp:Panel ID="pn2008" runat="server" Enabled="False">
                                                                    <table width="100%">
                                                                        <tr>
                                                                            <td width="15%">
                                                                                <label>
                                                                                    B</label>
                                                                            </td>
                                                                            <td>
                                                                                <asp:TextBox ID="t2008" runat="server" CssClass="textbox_hemat" MaxLength="4" onbeforepaste="BeforePaste_Event()"
                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()"></asp:TextBox>
                                                                                <label>
                                                                                    %</label>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </asp:Panel>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:Panel ID="pn2009" runat="server" Enabled="False">
                                                                    <table width="100%">
                                                                        <tr>
                                                                            <td width="92">
                                                                                <label>
                                                                                    Bounds</label>
                                                                            </td>
                                                                            <td width="273">
                                                                                <asp:TextBox ID="t2009" runat="server" CssClass="textbox_hemat" MaxLength="4" onbeforepaste="BeforePaste_Event()"
                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()"></asp:TextBox>
                                                                                <label>
                                                                                    %</label>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </asp:Panel>
                                                            </td>
                                                            <td>
                                                                <asp:Panel ID="pn2010" runat="server" Enabled="False">
                                                                    <table width="100%">
                                                                        <tr>
                                                                            <td width="15%">
                                                                                <label>
                                                                                    Others</label>
                                                                            </td>
                                                                            <td>
                                                                                <asp:TextBox ID="t2010" runat="server" CssClass="textbox_hemat" MaxLength="4" onbeforepaste="BeforePaste_Event()"
                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()"></asp:TextBox>
                                                                                <label>
                                                                                    %</label>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </asp:Panel>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="2">
                                                                <asp:Panel ID="pn2011" runat="server" Enabled="False">
                                                                    <table width="100%">
                                                                        <tr>
                                                                            <td width="195">
                                                                                <label>
                                                                                    Absolute Eosinophil Count</label>
                                                                            </td>
                                                                            <td width="228">
                                                                                <asp:TextBox ID="t2011" runat="server" CssClass="textbox_hemat" MaxLength="4" onbeforepaste="BeforePaste_Event()"
                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()"></asp:TextBox>
                                                                                <label>
                                                                                    cells/mcl</label>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </asp:Panel>
                                                            </td>
                                                            <td>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">
                                                <asp:Panel ID="pn2012" runat="server" Enabled="False">
                                                    <table width="100%">
                                                        <tr>
                                                            <td width="19%" align="left" valign="top">
                                                                <label>
                                                                    Reticulocyte Count</label>
                                                            </td>
                                                            <td align="left" valign="top" width="34%" style="height: 15%">
                                                                <asp:TextBox ID="t2012" runat="server" CssClass="Txtboxsmall" MaxLength="4" onPaste="Paste_Event()"
                                                                    onbeforepaste="BeforePaste_Event()"      onkeypress="return ValidateOnlyNumeric(this);"   ></asp:TextBox>
                                                                <label>
                                                                    %</label>
                                                            </td>
                                                            <td align="left" style="height: 15%" valign="top" width="47%">
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </asp:Panel>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">
                                                <asp:Panel ID="pn2013" runat="server" Enabled="False">
                                                    <table width="100%">
                                                        <tr>
                                                            <td width="19%" align="left" valign="top">
                                                                <label>
                                                                    ESR</label>
                                                            </td>
                                                            <td align="left" valign="top" width="81%" style="height: 15%">
                                                                <asp:TextBox ID="t2013" runat="server" CssClass="Txtboxsmall" MaxLength="3" onPaste="Paste_Event()"
                                                                    onbeforepaste="BeforePaste_Event()"      onkeypress="return ValidateOnlyNumeric(this);"   ></asp:TextBox>
                                                                <label>
                                                                    mm/30 mins</label>
                                                                <asp:TextBox ID="t12013" runat="server" CssClass="Txtboxsmall" MaxLength="3" onPaste="Paste_Event()"
                                                                    onbeforepaste="BeforePaste_Event()"      onkeypress="return ValidateOnlyNumeric(this);"   ></asp:TextBox>
                                                                <label>
                                                                    mm/hour</label>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </asp:Panel>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" width="100%">
                                                <asp:Panel ID="pn2014" runat="server" Enabled="False">
                                                    <table width="100%">
                                                        <tr>
                                                            <td width="19%" align="left" valign="top">
                                                                <label>
                                                                    PCV</label>
                                                            </td>
                                                            <td width="81%" align="left" valign="top" style="height: 15%">
                                                                <asp:TextBox ID="t2014" runat="server" CssClass="Txtboxsmall" MaxLength="3" onPaste="Paste_Event()"
                                                                    onbeforepaste="BeforePaste_Event()"      onkeypress="return ValidateOnlyNumeric(this);"   ></asp:TextBox>
                                                                <label>
                                                                    %</label>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </asp:Panel>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" width="100%">
                                                <asp:Panel ID="pn2015" runat="server" Enabled="False">
                                                    <table width="100%">
                                                        <tr>
                                                            <td width="19%" align="left" valign="top">
                                                                <label>
                                                                    Platelets</label>
                                                            </td>
                                                            <td width="81%" align="left" valign="top" style="height: 15%">
                                                                <asp:TextBox ID="t2015" runat="server" CssClass="Txtboxsmall" MaxLength="6" onPaste="Paste_Event()"
                                                                    onbeforepaste="BeforePaste_Event()"      onkeypress="return ValidateOnlyNumeric(this);"   ></asp:TextBox>
                                                                <label>
                                                                    cells/cumm</label>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </asp:Panel>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" width="100%">
                                                <asp:Panel ID="pn2055" runat="server" Enabled="False">
                                                    <table width="100%">
                                                        <tr>
                                                            <td width="19%" align="left" valign="top">
                                                                <label>
                                                                    QBC</label>
                                                            </td>
                                                            <td align="left" valign="top" style="height: 15%">
                                                                <asp:DropDownList runat="server" ID="dd12055" CssClass="ddl">
                                                                    <asp:ListItem>mP</asp:ListItem>
                                                                    <asp:ListItem>mF</asp:ListItem>
                                                                    <asp:ListItem>Both</asp:ListItem>
                                                                </asp:DropDownList>
                                                                <asp:DropDownList runat="server" ID="dd22055" CssClass="ddlsmall">
                                                                    <asp:ListItem>Positive</asp:ListItem>
                                                                    <asp:ListItem>Negative</asp:ListItem>
                                                                    <asp:ListItem>Equivocal</asp:ListItem>
                                                                </asp:DropDownList>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </asp:Panel>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="left" valign="top" colspan="2">
                                                <a href="javascript:animatedcollapse.toggle('d2016')" runat="server" id="a2016" visible="False">
                                                    <span class="label_collapse">Peripheral Smear</span></a>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                            </td>
                                            <td align="left" valign="top" width="100%">
                                                <div id="d2016" style="width: 100%; display: none">
                                                    <table>
                                                        <tr>
                                                            <td>
                                                                <a id="a2017" runat="server" href="javascript:animatedcollapse.toggle('d2017')" visible="False">
                                                                    <span class="label_collapse">Red Cells</span></a>
                                                                <div id="d2017" style="width: 100%; display: none">
                                                                    <table width="100%">
                                                                        <tr>
                                                                            <td>
                                                                                <asp:Panel ID="pn2018" runat="server" Enabled="False">
                                                                                    <table>
                                                                                        <tr>
                                                                                            <td>
                                                                                                <label>
                                                                                                    Morphology</label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:RadioButtonList ID="r2018" runat="server" CssClass="defaultfontcolor" onClick="PeripheralRedCellMorphology()"
                                                                                                    RepeatDirection="Horizontal">
                                                                                                    <asp:ListItem>Normal</asp:ListItem>
                                                                                                    <asp:ListItem>AbNormal</asp:ListItem>
                                                                                                </asp:RadioButtonList>
                                                                                            </td>
                                                                                            <td>
                                                                                                <div id="divMorphology" style="display: none;">
                                                                                                    <asp:DropDownList ID="dd2018" runat="server">
                                                                                                        <asp:ListItem>Microcytic Hypochromic</asp:ListItem>
                                                                                                        <asp:ListItem>Normocytic Hypochromic</asp:ListItem>
                                                                                                        <asp:ListItem>Macrocytic Hypochromic</asp:ListItem>
                                                                                                        <asp:ListItem>Spherocytes</asp:ListItem>
                                                                                                        <asp:ListItem>Elliptocytes</asp:ListItem>
                                                                                                    </asp:DropDownList>
                                                                                                </div>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:Panel ID="pn2019" runat="server" Enabled="False">
                                                                                    <table>
                                                                                        <tr>
                                                                                            <td>
                                                                                                <label>
                                                                                                    Distribution</label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:RadioButtonList ID="r2019" runat="server" CssClass="defaultfontcolor" onClick="PeripheralRedCellDistribution()"
                                                                                                    RepeatDirection="Horizontal">
                                                                                                    <asp:ListItem>Normal</asp:ListItem>
                                                                                                    <asp:ListItem>AbNormal</asp:ListItem>
                                                                                                </asp:RadioButtonList>
                                                                                            </td>
                                                                                            <td>
                                                                                                <div id="divDistribution" style="display: none;">
                                                                                                    <asp:DropDownList ID="dd2019" runat="server">
                                                                                                        <asp:ListItem>Scanty</asp:ListItem>
                                                                                                        <asp:ListItem>Clumbed</asp:ListItem>
                                                                                                    </asp:DropDownList>
                                                                                                </div>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <table>
                                                                                    <tr>
                                                                                        <td>
                                                                                            <asp:Label ID="lblOthers" runat="server" CssClass="defaultfontcolor" Enabled="False"
                                                                                                Text="Others"></asp:Label>
                                                                                        </td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td>
                                                                                            <asp:Panel ID="pn2020" runat="server" Enabled="False">
                                                                                                <asp:CheckBox ID="c2020" runat="server" CssClass="defaultfontcolor" Text="Anisocytosis" />
                                                                                            </asp:Panel>
                                                                                        </td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td>
                                                                                            <asp:Panel ID="pn2021" runat="server" Enabled="False">
                                                                                                <asp:CheckBox ID="c2021" runat="server" CssClass="defaultfontcolor" Text="Ppoikilocytosis" />
                                                                                            </asp:Panel>
                                                                                        </td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td>
                                                                                            <asp:Panel ID="pn2022" runat="server" Enabled="False">
                                                                                                <asp:CheckBox ID="c2022" runat="server" CssClass="defaultfontcolor" Text="Polychromasia" />
                                                                                            </asp:Panel>
                                                                                        </td>
                                                                                    </tr>
                                                                                </table>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <a id="a2023" runat="server" href="javascript:animatedcollapse.toggle('d2023')" visible="False">
                                                                    <span class="label_collapse">WBC</span></a>
                                                                <div id="d2023" style="display: none;">
                                                                    <table>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:Panel ID="pn2024" runat="server" Enabled="False">
                                                                                    <table>
                                                                                        <tr>
                                                                                            <td>
                                                                                                <label>
                                                                                                    Distribution</label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:RadioButtonList ID="r2024" runat="server" CssClass="defaultfontcolor" RepeatDirection="Horizontal">
                                                                                                    <asp:ListItem>Normal</asp:ListItem>
                                                                                                    <asp:ListItem>AbNormal</asp:ListItem>
                                                                                                </asp:RadioButtonList>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:Panel ID="pn2025" runat="server" Enabled="False">
                                                                                    <table>
                                                                                        <tr>
                                                                                            <td>
                                                                                                <label>
                                                                                                    Immature Cells</label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:RadioButtonList ID="r2025" runat="server" CssClass="defaultfontcolor" RepeatDirection="Horizontal">
                                                                                                    <asp:ListItem>Absent</asp:ListItem>
                                                                                                    <asp:ListItem>Present</asp:ListItem>
                                                                                                </asp:RadioButtonList>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:Panel ID="pn2026" runat="server" Enabled="False">
                                                                                    <table>
                                                                                        <tr>
                                                                                            <td>
                                                                                                <label>
                                                                                                    Malignant Cells</label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:RadioButtonList ID="r2026" runat="server" CssClass="defaultfontcolor" RepeatDirection="Horizontal">
                                                                                                    <asp:ListItem>Absent</asp:ListItem>
                                                                                                    <asp:ListItem>Present</asp:ListItem>
                                                                                                </asp:RadioButtonList>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <a id="a2027" runat="server" href="javascript:animatedcollapse.toggle('d2027')" visible="False">
                                                                    <span class="label_collapse">Platelets</span></a>
                                                                <div id="d2027" style="display: none;">
                                                                    <table>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:Panel ID="d2028" runat="server" Enabled="False">
                                                                                    <table>
                                                                                        <tr>
                                                                                            <td style="padding-left: 20px">
                                                                                                <label>
                                                                                                    Distribution</label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:RadioButtonList ID="r2028" runat="server" CssClass="defaultfontcolor" RepeatDirection="Horizontal">
                                                                                                    <asp:ListItem>Normal</asp:ListItem>
                                                                                                    <asp:ListItem>Ab Normal</asp:ListItem>
                                                                                                </asp:RadioButtonList>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:Panel ID="pn2029" runat="server" Enabled="False">
                                                                                    <table>
                                                                                        <tr>
                                                                                            <td style="padding-left: 20px">
                                                                                                <label>
                                                                                                    Morphology</label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:RadioButtonList ID="r2029" runat="server" CssClass="defaultfontcolor" RepeatDirection="Horizontal">
                                                                                                    <asp:ListItem>Normal</asp:ListItem>
                                                                                                    <asp:ListItem>Ab Normal</asp:ListItem>
                                                                                                </asp:RadioButtonList>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:Panel ID="pn2030" runat="server" Enabled="False">
                                                                    <table>
                                                                        <tr>
                                                                            <td>
                                                                                <label>
                                                                                    Parasites</label>
                                                                            </td>
                                                                            <td>
                                                                                <asp:RadioButtonList ID="r2030" runat="server" CssClass="defaultfontcolor" onClick="PeripheralParasitesPresent()"
                                                                                    RepeatDirection="Horizontal">
                                                                                    <asp:ListItem>None</asp:ListItem>
                                                                                    <asp:ListItem>Present</asp:ListItem>
                                                                                </asp:RadioButtonList>
                                                                            </td>
                                                                            <td>
                                                                                <div id="divParasites" style="display: none;">
                                                                                    <asp:DropDownList ID="dd2030" runat="server">
                                                                                        <asp:ListItem>Malarial Plasmodium Ovale</asp:ListItem>
                                                                                        <asp:ListItem>Malariel Plasmodium Vivax</asp:ListItem>
                                                                                        <asp:ListItem>Malarial Plasmodium Falciparum</asp:ListItem>
                                                                                        <asp:ListItem>Filarial</asp:ListItem>
                                                                                    </asp:DropDownList>
                                                                                </div>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </asp:Panel>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">
                                                <asp:Panel ID="pn2031" runat="server" Enabled="False">
                                                    <table width="100%">
                                                        <tr>
                                                            <td align="left" valign="top" width="15%">
                                                                <label>
                                                                    Blood Group</label>
                                                            </td>
                                                            <td align="left" valign="top" width="50%" style="height: 15%">
                                                                <asp:DropDownList ID="dd2031" runat="server" Width="50px" CssClass="ddl">
                                                                    <asp:ListItem>A1</asp:ListItem>
                                                                    <asp:ListItem>A2</asp:ListItem>
                                                                    <asp:ListItem>B</asp:ListItem>
                                                                    <asp:ListItem>O</asp:ListItem>
                                                                    <asp:ListItem>A1B</asp:ListItem>
                                                                    <asp:ListItem>A2B</asp:ListItem>
                                                                </asp:DropDownList>
                                                                <asp:DropDownList ID="dd12031" runat="server" Width="80px" CssClass="ddlsmall">
                                                                    <asp:ListItem>Positive</asp:ListItem>
                                                                    <asp:ListItem>Negative</asp:ListItem>
                                                                </asp:DropDownList>
                                                            </td>
                                                            <td align="left" style="height: 15%" valign="top" width="50%">
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </asp:Panel>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">
                                                <asp:Panel ID="pn2032" runat="server" Enabled="False">
                                                    <table width="100%">
                                                        <tr>
                                                            <td align="left" valign="top" width="15%">
                                                                <label>
                                                                    Red Cell Count</label>
                                                            </td>
                                                            <td align="left" valign="top" width="50%" style="height: 15%">
                                                                <asp:TextBox ID="t2032" runat="server" CssClass="Txtboxsmall" MaxLength="4" onPaste="Paste_Event()"
                                                                    onbeforepaste="BeforePaste_Event()"      onkeypress="return ValidateOnlyNumeric(this);"   ></asp:TextBox>
                                                                <label>
                                                                    10<sup>6</sup>/cumm</label>
                                                            </td>
                                                            <td align="left" style="height: 15%" valign="top" width="50%">
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </asp:Panel>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">
                                                <asp:Panel ID="pn2033" runat="server" Enabled="False">
                                                    <table width="100%">
                                                        <tr>
                                                            <td width="15%" align="left" valign="top">
                                                                <label>
                                                                    MCV
                                                                </label>
                                                            </td>
                                                            <td align="left" valign="top" width="43%" style="height: 15%">
                                                                <asp:TextBox ID="t2033" runat="server" CssClass="Txtboxsmall" MaxLength="4" onPaste="Paste_Event()"
                                                                    onbeforepaste="BeforePaste_Event()"      onkeypress="return ValidateOnlyNumeric(this);"   ></asp:TextBox>
                                                                <label>
                                                                    µm<sup>3</sup></label>
                                                            </td>
                                                            <td align="left" style="height: 15%" valign="top" width="44%">
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </asp:Panel>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">
                                                <asp:Panel ID="pn2034" runat="server" Enabled="False">
                                                    <table width="100%">
                                                        <tr>
                                                            <td align="left" valign="top" width="15%">
                                                                <label>
                                                                    MCHC</label>
                                                            </td>
                                                            <td align="left" valign="top" width="50%" style="height: 15%">
                                                                <asp:TextBox ID="t2034" runat="server" CssClass="Txtboxsmall" MaxLength="4" onPaste="Paste_Event()"
                                                                    onbeforepaste="BeforePaste_Event()"      onkeypress="return ValidateOnlyNumeric(this);"   ></asp:TextBox>
                                                                <label>
                                                                    g/dl</label>
                                                            </td>
                                                            <td align="left" style="height: 15%" valign="top" width="50%">
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </asp:Panel>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td height="39" colspan="2">
                                                <asp:Panel ID="pn2035" runat="server" Enabled="False">
                                                    <table width="100%">
                                                        <tr>
                                                            <td align="left" valign="top" width="15%">
                                                                <label>
                                                                    MCH</label>
                                                            </td>
                                                            <td align="left" valign="top" width="50%" style="height: 15%">
                                                                <asp:TextBox ID="t2035" runat="server" CssClass="Txtboxsmall" MaxLength="4" onPaste="Paste_Event()"
                                                                    onbeforepaste="BeforePaste_Event()"      onkeypress="return ValidateOnlyNumeric(this);"   ></asp:TextBox>
                                                                <label>
                                                                    pg/cell</label>
                                                            </td>
                                                            <td align="left" style="height: 15%" valign="top" width="50%">
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </asp:Panel>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="left" valign="top" colspan="2">
                                                <a href="javascript:animatedcollapse.toggle('d2036')" runat="server" id="a2036" visible="False">
                                                    <span class="label_collapse">Others</span></a>
                                        </tr>
                                        <tr>
                                            <td>
                                            </td>
                                            <td align="left" style="height: 15%" valign="top" width="100%">
                                                <div id="d2036" style="width: 100%; display: none">
                                                    <table width="50%">
                                                        <tr>
                                                            <td>
                                                                <asp:Panel ID="pn2037" runat="server" Enabled="False">
                                                                    <table width="100%">
                                                                        <tr>
                                                                            <td colspan="3">
                                                                                <label>
                                                                                </label>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td width="29%">
                                                                                <label>
                                                                                    Direct</label>
                                                                            </td>
                                                                            <td align="left" width="23%">
                                                                                <asp:DropDownList ID="dd2037" runat="server">
                                                                                    <asp:ListItem>Positive</asp:ListItem>
                                                                                    <asp:ListItem>Negative</asp:ListItem>
                                                                                </asp:DropDownList>
                                                                            </td>
                                                                            <td align="left" width="48%">
                                                                                <asp:DropDownList ID="dd12037" runat="server">
                                                                                    <asp:ListItem>1:40</asp:ListItem>
                                                                                    <asp:ListItem>1:80</asp:ListItem>
                                                                                    <asp:ListItem>1:100</asp:ListItem>
                                                                                </asp:DropDownList>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </asp:Panel>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:Panel ID="pn2038" runat="server" Enabled="False">
                                                                    <table width="100%">
                                                                        <tr>
                                                                            <td width="29%">
                                                                                <label>
                                                                                    Indirect</label>
                                                                            </td>
                                                                            <td align="left" width="23%">
                                                                                <asp:DropDownList ID="dd2038" runat="server">
                                                                                    <asp:ListItem>Positive</asp:ListItem>
                                                                                    <asp:ListItem>Negative</asp:ListItem>
                                                                                </asp:DropDownList>
                                                                            </td>
                                                                            <td align="left" width="48%">
                                                                                <asp:DropDownList ID="dd12038" runat="server">
                                                                                    <asp:ListItem>1:40</asp:ListItem>
                                                                                    <asp:ListItem>1:80</asp:ListItem>
                                                                                    <asp:ListItem>1:100</asp:ListItem>
                                                                                </asp:DropDownList>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </asp:Panel>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:Panel ID="pn2039" runat="server" Enabled="False">
                                                                    <table width="100%">
                                                                        <tr>
                                                                            <td width="29%">
                                                                                <label>
                                                                                    Sickling</label>
                                                                            </td>
                                                                            <td align="left" width="23%">
                                                                                <asp:DropDownList ID="dd2039" runat="server">
                                                                                    <asp:ListItem>Absent</asp:ListItem>
                                                                                    <asp:ListItem>Present</asp:ListItem>
                                                                                </asp:DropDownList>
                                                                            </td>
                                                                            <td width="48%">
                                                                                &nbsp;
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </asp:Panel>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:Panel ID="pn2040" runat="server" Enabled="False">
                                                                    <table width="100%">
                                                                        <tr>
                                                                            <td width="29%">
                                                                                <label>
                                                                                    Rh. Antibody</label>
                                                                            </td>
                                                                            <td align="left" width="23%">
                                                                                <asp:DropDownList ID="dd2040" runat="server">
                                                                                    <asp:ListItem>Absent</asp:ListItem>
                                                                                    <asp:ListItem>Present</asp:ListItem>
                                                                                </asp:DropDownList>
                                                                            </td>
                                                                            <td width="48%">
                                                                                &nbsp;
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </asp:Panel>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:Panel ID="pn2041" runat="server" Enabled="False">
                                                                    <table width="100%">
                                                                        <tr>
                                                                            <td width="29%">
                                                                                <label>
                                                                                    Hb.Electrophoresis</label>
                                                                            </td>
                                                                            <td align="left">
                                                                                <asp:RadioButtonList ID="r2041" runat="server" CssClass="defaultfontcolor" onClick="OthersHbElectroPhoresis()"
                                                                                    RepeatDirection="Horizontal">
                                                                                    <asp:ListItem>Normal</asp:ListItem>
                                                                                    <asp:ListItem>Ab Normal</asp:ListItem>
                                                                                </asp:RadioButtonList>
                                                                                <div id="dd2041" style="display: none">
                                                                                    <asp:DropDownList ID="ddlAbnormalValue" runat="server">
                                                                                        <asp:ListItem>Hemoglobin A</asp:ListItem>
                                                                                        <asp:ListItem>Hemoglobin A2</asp:ListItem>
                                                                                        <asp:ListItem>Hemoglobin F</asp:ListItem>
                                                                                        <asp:ListItem>Otherthan A1 A2 NF</asp:ListItem>
                                                                                    </asp:DropDownList>
                                                                                </div>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </asp:Panel>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="left" valign="top" colspan="2">
                                                <a href="javascript:animatedcollapse.toggle('d2042')" runat="server" id="a2042" visible="False">
                                                    <span class="label_collapse">Coagulation profile</span></a>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                            </td>
                                            <td align="left" style="height: 15%" valign="top" width="100%">
                                                <div id="d2042" style="width: 100%; display: none">
                                                    <table align="left" cellpadding="0" cellspacing="0" style="padding-left: 20px" width="100%">
                                                        <tr>
                                                            <td>
                                                                <asp:Panel ID="pn2043" runat="server" Enabled="False">
                                                                    <table width="100%">
                                                                        <tr>
                                                                            <td width="26%">
                                                                                <label>
                                                                                    Bleeding Time</label>
                                                                            </td>
                                                                            <td width="39%">
                                                                                <asp:DropDownList ID="dd2043" runat="server">
                                                                                </asp:DropDownList>
                                                                                <label>
                                                                                    :</label>
                                                                                <asp:DropDownList ID="dd12043" runat="server">
                                                                                </asp:DropDownList>
                                                                            </td>
                                                                            <td width="35%">
                                                                                <label>
                                                                                    mins</label>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </asp:Panel>
                                                            </td>
                                                            <td>
                                                            </td>
                                                            <td colspan="3">
                                                                <asp:Panel ID="pn2044" runat="server" Enabled="False">
                                                                    <table width="100%">
                                                                        <tr>
                                                                            <td align="left" width="22%">
                                                                                <label>
                                                                                    Fibrinogen</label>
                                                                            </td>
                                                                            <td width="32%">
                                                                                <asp:TextBox ID="t2044" runat="server" CssClass="textbox_hemat" onbeforepaste="BeforePaste_Event()"
                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()"></asp:TextBox>
                                                                            </td>
                                                                            <td width="46%">
                                                                                <label>
                                                                                    mg/dl</label>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </asp:Panel>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:Panel ID="pn2045" runat="server" Enabled="False">
                                                                    <table width="100%">
                                                                        <tr>
                                                                            <td width="26%">
                                                                                <label>
                                                                                    Clothing Time</label>
                                                                            </td>
                                                                            <td width="38%">
                                                                                <asp:DropDownList ID="dd2045" runat="server">
                                                                                </asp:DropDownList>
                                                                                <label>
                                                                                    :</label>
                                                                                <asp:DropDownList ID="dd12045" runat="server">
                                                                                </asp:DropDownList>
                                                                            </td>
                                                                            <td width="36%">
                                                                                <label>
                                                                                    mins</label>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </asp:Panel>
                                                            </td>
                                                            <td>
                                                            </td>
                                                            <td colspan="3">
                                                                <asp:Panel ID="pn2046" runat="server" Enabled="False">
                                                                    <table width="100%">
                                                                        <tr>
                                                                            <td width="22%">
                                                                                <label>
                                                                                    d.Dimer</label>
                                                                            </td>
                                                                            <td width="33%">
                                                                                <asp:TextBox ID="t2046" runat="server" CssClass="textbox_hemat" onbeforepaste="BeforePaste_Event()"
                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()"></asp:TextBox>
                                                                            </td>
                                                                            <td width="45%">
                                                                                <label>
                                                                                    µg/ml</label>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </asp:Panel>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:Panel ID="pn2047" runat="server" Enabled="False">
                                                                    <table width="100%">
                                                                        <tr>
                                                                            <td width="26%">
                                                                                <label>
                                                                                    Prothrombin Time</label>
                                                                            </td>
                                                                            <td align="left" width="38%">
                                                                                <asp:DropDownList ID="dd2047" runat="server">
                                                                                </asp:DropDownList>
                                                                            </td>
                                                                            <td width="36%">
                                                                                <label>
                                                                                    Sec</label>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </asp:Panel>
                                                            </td>
                                                            <td>
                                                            </td>
                                                            <td colspan="3">
                                                                <asp:Panel ID="pn2048" runat="server" Enabled="False">
                                                                    <table width="100%">
                                                                        <tr>
                                                                            <td width="22%">
                                                                                <label>
                                                                                    Anti-Thrombin III</label>
                                                                            </td>
                                                                            <td width="33%">
                                                                                <asp:TextBox ID="t2048" runat="server" CssClass="textbox_hemat" onbeforepaste="BeforePaste_Event()"
                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()"></asp:TextBox>
                                                                            </td>
                                                                            <td width="45%">
                                                                                <label>
                                                                                    mg/dl</label>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </asp:Panel>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:Panel ID="pn2049" runat="server" Enabled="False">
                                                                    <table width="100%">
                                                                        <tr>
                                                                            <td width="26%">
                                                                                <label>
                                                                                    Patist</label>
                                                                            </td>
                                                                            <td align="left" width="39%">
                                                                                <asp:DropDownList ID="dd2049" runat="server">
                                                                                </asp:DropDownList>
                                                                            </td>
                                                                            <td width="35%">
                                                                                <label>
                                                                                    Sec</label>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </asp:Panel>
                                                            </td>
                                                            <td>
                                                            </td>
                                                            <td colspan="3">
                                                                <asp:Panel ID="pn2050" runat="server" Enabled="False">
                                                                    <table width="100%">
                                                                        <tr>
                                                                            <td width="22%">
                                                                                <label>
                                                                                    Protein C
                                                                                </label>
                                                                            </td>
                                                                            <td width="33%">
                                                                                <asp:TextBox ID="t2050" runat="server" CssClass="textbox_hemat" onbeforepaste="BeforePaste_Event()"
                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()"></asp:TextBox>
                                                                            </td>
                                                                            <td width="45%">
                                                                                <label>
                                                                                    %</label>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </asp:Panel>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:Panel ID="pn2051" runat="server" Enabled="False">
                                                                    <table width="100%">
                                                                        <tr>
                                                                            <td width="26%">
                                                                                <label>
                                                                                    INR</label>
                                                                            </td>
                                                                            <td align="left" width="39%">
                                                                                <asp:TextBox ID="t2051" runat="server" CssClass="textbox_hemat" onbeforepaste="BeforePaste_Event()"
                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()"></asp:TextBox>
                                                                            </td>
                                                                            <td width="35%">
                                                                                <label>
                                                                                    Sec</label>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </asp:Panel>
                                                            </td>
                                                            <td>
                                                            </td>
                                                            <td colspan="3">
                                                                <asp:Panel ID="pn2052" runat="server" Enabled="False">
                                                                    <table width="100%">
                                                                        <tr>
                                                                            <td width="22%">
                                                                                <label>
                                                                                    Protein S
                                                                                </label>
                                                                            </td>
                                                                            <td width="33%">
                                                                                <asp:TextBox ID="t2052" runat="server" CssClass="textbox_hemat" onbeforepaste="BeforePaste_Event()"
                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()"></asp:TextBox>
                                                                            </td>
                                                                            <td width="45%">
                                                                                <label>
                                                                                    %</label>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </asp:Panel>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:Panel ID="pn2053" runat="server" Enabled="False">
                                                                    <table width="100%">
                                                                        <tr>
                                                                            <td width="33%">
                                                                                <label>
                                                                                    Activated Clotting Time</label>
                                                                            </td>
                                                                            <td align="left" width="32%">
                                                                                <asp:DropDownList ID="dd2053" runat="server">
                                                                                </asp:DropDownList>
                                                                            </td>
                                                                            <td width="35%">
                                                                                <label>
                                                                                    Sec</label>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </asp:Panel>
                                                            </td>
                                                            <td>
                                                            </td>
                                                            <td>
                                                            </td>
                                                            <td>
                                                            </td>
                                                            <td>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:Panel ID="pn2054" runat="server" Enabled="False">
                                                                    <table width="100%">
                                                                        <tr>
                                                                            <td width="33%">
                                                                                <label>
                                                                                    aPTT</label>
                                                                            </td>
                                                                            <td align="left" width="32%">
                                                                                <asp:DropDownList ID="dd2054" runat="server">
                                                                                </asp:DropDownList>
                                                                            </td>
                                                                            <td width="35%">
                                                                                <label>
                                                                                    Sec</label>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </asp:Panel>
                                                            </td>
                                                            <td>
                                                            </td>
                                                            <td>
                                                            </td>
                                                            <td>
                                                            </td>
                                                            <td>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <table>
                                                    <tr>
                                                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                                            <ContentTemplate>
                                                                <td>
                                                                    <asp:Button ID="btnSaveHemat" runat="server" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                                        onmouseout="this.className='btn'" OnClick="btnSaveHemat_Click" TabIndex="26"
                                                                        Text="Save" />
                                                                </td>
                                                                <td>
                                                                    <asp:Button ID="btnCancelHemat" runat="server" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                                        onmouseout="this.className='btn'" OnClick="btnCancelHemat_Click" TabIndex="26"
                                                                        Text="Cancel" />
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblShowHemat" runat="server" CssClass="errormsg"></asp:Label>
                                                                </td>
                                                            </ContentTemplate>
                                                        </asp:UpdatePanel>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                </ContentTemplate>
                            </Ajax:TabPanel>
                            <Ajax:TabPanel ID="tp1001" runat="server" HeaderText="MicroBiology" Enabled="false">
                                <ContentTemplate>
                                    <table cellspacing="1" class="style1" style="height: auto" width="100%" border="0">
                                        <tr>
                                            <td>
                                                <a href="javascript:animatedcollapse.toggle('d1002')" id="a1002" runat="server"><span
                                                    class="label_collapse">TORCH Panel</span></a>
                                                <div id="d1002" style="display: block; padding-left: 30px">
                                                    <table id="Table1" runat="server">
                                                        <tr>
                                                            <td>
                                                                <label id="Label95">
                                                                    Source</label>
                                                            </td>
                                                            <td>
                                                                <label id="Label96">
                                                                    Method</label>
                                                            </td>
                                                            <td colspan="4">
                                                                <label id="Label97">
                                                                    Result</label>
                                                            </td>
                                                        </tr>
                                                        <tr runat="server" id="tr1004">
                                                            <td colspan="5">
                                                                <asp:Panel ID="pn1004" runat="server" Enabled="false">
                                                                    <table>
                                                                        <tr>
                                                                            <td colspan="5">
                                                                                <label id="l1004">
                                                                                    Rubella Virus IgG</label>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:DropDownList ID="dd11004" runat="server" CssClass="dropdownbutton">
                                                                                    <asp:ListItem>Serum</asp:ListItem>
                                                                                    <asp:ListItem>Cerebro Spinal Fluid</asp:ListItem>
                                                                                    <asp:ListItem>Pleural Fluid</asp:ListItem>
                                                                                    <asp:ListItem>Ascitic Fluid</asp:ListItem>
                                                                                    <asp:ListItem>Percardial Fluid</asp:ListItem>
                                                                                    <asp:ListItem>Joint Fluid Knee</asp:ListItem>
                                                                                    <asp:ListItem>Joint Fluid Elbow</asp:ListItem>
                                                                                    <asp:ListItem>Joint Fluid Shoulder</asp:ListItem>
                                                                                    <asp:ListItem>Hydrocode Fluid</asp:ListItem>
                                                                                    <asp:ListItem>Fluid from Syst</asp:ListItem>
                                                                                </asp:DropDownList>
                                                                            </td>
                                                                            <td>
                                                                                <asp:DropDownList ID="dd21004" runat="server" CssClass="dropdownbutton">
                                                                                    <asp:ListItem Value="1">ELISA</asp:ListItem>
                                                                                    <asp:ListItem Value="2">Latex Agglutination</asp:ListItem>
                                                                                    <asp:ListItem Value="4">Chemiluminescence Immunoassay</asp:ListItem>
                                                                                    <asp:ListItem Value="5">DNA Amplification</asp:ListItem>
                                                                                    <asp:ListItem Value="6">Viral Culture</asp:ListItem>
                                                                                </asp:DropDownList>
                                                                            </td>
                                                                            <td>
                                                                                <asp:DropDownList ID="dd31004" runat="server" CssClass="dropdownbutton" onchange="ShowRubella()">
                                                                                    <asp:ListItem>Select</asp:ListItem>
                                                                                    <asp:ListItem>Quantitative</asp:ListItem>
                                                                                    <asp:ListItem>Qualitative</asp:ListItem>
                                                                                </asp:DropDownList>
                                                                            </td>
                                                                            <td>
                                                                                <div id="divRubellaQuan" style="display: none">
                                                                                    <asp:TextBox ID="t1004" runat="server" CssClass="textbox_hemat"></asp:TextBox>
                                                                                    <label>
                                                                                        Iu/ml</label>
                                                                                </div>
                                                                            </td>
                                                                            <td>
                                                                                <div id="divRubellaQual" style="display: none">
                                                                                    <asp:DropDownList ID="dd41004" runat="server" CssClass="dropdownbutton">
                                                                                        <asp:ListItem>Positive</asp:ListItem>
                                                                                        <asp:ListItem>Negative</asp:ListItem>
                                                                                        <asp:ListItem>Equivocal</asp:ListItem>
                                                                                    </asp:DropDownList>
                                                                                </div>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </asp:Panel>
                                                            </td>
                                                        </tr>
                                                        <tr id="tr1005" runat="server">
                                                            <td colspan="5">
                                                                <asp:Panel ID="pn1005" runat="server" Enabled="false">
                                                                    <table>
                                                                        <tr>
                                                                            <td colspan="4">
                                                                                <label id="l1005">
                                                                                    Rubella Virus IgM</label>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:DropDownList ID="dd11005" runat="server" CssClass="dropdownbutton">
                                                                                    <asp:ListItem>Serum</asp:ListItem>
                                                                                    <asp:ListItem>Cerebro Spinal Fluid</asp:ListItem>
                                                                                    <asp:ListItem>Pleural Fluid</asp:ListItem>
                                                                                    <asp:ListItem>Ascitic Fluid</asp:ListItem>
                                                                                    <asp:ListItem>Percardial Fluid</asp:ListItem>
                                                                                    <asp:ListItem>Joint Fluid Knee</asp:ListItem>
                                                                                    <asp:ListItem>Joint Fluid Elbow</asp:ListItem>
                                                                                    <asp:ListItem>Joint Fluid Shoulder</asp:ListItem>
                                                                                    <asp:ListItem>Hydrocode Fluid</asp:ListItem>
                                                                                    <asp:ListItem>Fluid from Syst</asp:ListItem>
                                                                                </asp:DropDownList>
                                                                            </td>
                                                                            <td>
                                                                                <asp:DropDownList ID="dd21005" runat="server" CssClass="dropdownbutton">
                                                                                    <asp:ListItem Value="1">ELISA</asp:ListItem>
                                                                                    <asp:ListItem Value="2">Latex Agglutination</asp:ListItem>
                                                                                    <asp:ListItem Value="4">Chemiluminescence Immunoassay</asp:ListItem>
                                                                                    <asp:ListItem Value="5">DNA Amplification</asp:ListItem>
                                                                                    <asp:ListItem Value="6">Viral Culture</asp:ListItem>
                                                                                </asp:DropDownList>
                                                                            </td>
                                                                            <td>
                                                                                <asp:DropDownList ID="dd31005" runat="server" CssClass="dropdownbutton" onchange="ShowRubella1()">
                                                                                    <asp:ListItem>Select</asp:ListItem>
                                                                                    <asp:ListItem>Quantitative</asp:ListItem>
                                                                                    <asp:ListItem>Qualitative</asp:ListItem>
                                                                                </asp:DropDownList>
                                                                            </td>
                                                                            <td>
                                                                                <div id="divRubellaQuan1" style="display: none">
                                                                                    <asp:TextBox ID="t1005" runat="server" CssClass="textbox_hemat"></asp:TextBox>
                                                                                    <label>
                                                                                        Iu/ml</label>
                                                                                </div>
                                                                            </td>
                                                                            <td>
                                                                                <div id="divRubellaQual1" style="display: none">
                                                                                    <asp:DropDownList ID="dd41005" runat="server" CssClass="dropdownbutton">
                                                                                        <asp:ListItem>Positive</asp:ListItem>
                                                                                        <asp:ListItem>Negative</asp:ListItem>
                                                                                        <asp:ListItem>Equivocal</asp:ListItem>
                                                                                    </asp:DropDownList>
                                                                                </div>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </asp:Panel>
                                                            </td>
                                                        </tr>
                                                        <tr id="tr1006" runat="server">
                                                            <td colspan="5">
                                                                <asp:Panel ID="pn1006" runat="server" Enabled="false">
                                                                    <table>
                                                                        <tr>
                                                                            <td colspan="5">
                                                                                <label id="l1006">
                                                                                    Cytomegalo Virus IgG</label>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:DropDownList ID="dd11006" runat="server" CssClass="dropdownbutton">
                                                                                    <asp:ListItem>Serum</asp:ListItem>
                                                                                    <asp:ListItem>Cerebro Spinal Fluid</asp:ListItem>
                                                                                    <asp:ListItem>Pleural Fluid</asp:ListItem>
                                                                                    <asp:ListItem>Ascitic Fluid</asp:ListItem>
                                                                                    <asp:ListItem>Percardial Fluid</asp:ListItem>
                                                                                    <asp:ListItem>Joint Fluid Knee</asp:ListItem>
                                                                                    <asp:ListItem>Joint Fluid Elbow</asp:ListItem>
                                                                                    <asp:ListItem>Joint Fluid Shoulder</asp:ListItem>
                                                                                    <asp:ListItem>Hydrocode Fluid</asp:ListItem>
                                                                                    <asp:ListItem>Fluid from Syst</asp:ListItem>
                                                                                </asp:DropDownList>
                                                                            </td>
                                                                            <td>
                                                                                <asp:DropDownList ID="dd21006" runat="server" CssClass="dropdownbutton">
                                                                                    <asp:ListItem Value="1">ELISA</asp:ListItem>
                                                                                    <asp:ListItem Value="2">Latex Agglutination</asp:ListItem>
                                                                                    <asp:ListItem Value="4">Chemiluminescence Immunoassay</asp:ListItem>
                                                                                    <asp:ListItem Value="5">DNA Amplification</asp:ListItem>
                                                                                    <asp:ListItem Value="6">Viral Culture</asp:ListItem>
                                                                                </asp:DropDownList>
                                                                            </td>
                                                                            <td>
                                                                                <asp:DropDownList ID="dd31006" runat="server" CssClass="dropdownbutton" onchange="ShowCyto()">
                                                                                    <asp:ListItem>Select</asp:ListItem>
                                                                                    <asp:ListItem>Quantitative</asp:ListItem>
                                                                                    <asp:ListItem>Qualitative</asp:ListItem>
                                                                                </asp:DropDownList>
                                                                            </td>
                                                                            <td>
                                                                                <div id="divCytoQuan" style="display: none">
                                                                                    <asp:TextBox ID="t1006" runat="server" CssClass="textbox_hemat"></asp:TextBox>
                                                                                    <label>
                                                                                        Iu/ml</label>
                                                                                </div>
                                                                            </td>
                                                                            <td>
                                                                                <div id="divCytoQual" style="display: none">
                                                                                    <asp:DropDownList ID="dd41006" runat="server" CssClass="dropdownbutton">
                                                                                        <asp:ListItem>Positive</asp:ListItem>
                                                                                        <asp:ListItem>Negative</asp:ListItem>
                                                                                        <asp:ListItem>Equivocal</asp:ListItem>
                                                                                    </asp:DropDownList>
                                                                                </div>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </asp:Panel>
                                                            </td>
                                                        </tr>
                                                        <tr id="tr1007" runat="server">
                                                            <td colspan="5">
                                                                <asp:Panel ID="pn1007" runat="server" Enabled="false">
                                                                    <table>
                                                                        <tr>
                                                                            <td colspan="5">
                                                                                <label id="l1007">
                                                                                    Cytomegalo Virus IgM</label>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:DropDownList ID="dd11007" runat="server" CssClass="dropdownbutton">
                                                                                    <asp:ListItem>Serum</asp:ListItem>
                                                                                    <asp:ListItem>Cerebro Spinal Fluid</asp:ListItem>
                                                                                    <asp:ListItem>Pleural Fluid</asp:ListItem>
                                                                                    <asp:ListItem>Ascitic Fluid</asp:ListItem>
                                                                                    <asp:ListItem>Percardial Fluid</asp:ListItem>
                                                                                    <asp:ListItem>Joint Fluid Knee</asp:ListItem>
                                                                                    <asp:ListItem>Joint Fluid Elbow</asp:ListItem>
                                                                                    <asp:ListItem>Joint Fluid Shoulder</asp:ListItem>
                                                                                    <asp:ListItem>Hydrocode Fluid</asp:ListItem>
                                                                                    <asp:ListItem>Fluid from Syst</asp:ListItem>
                                                                                </asp:DropDownList>
                                                                            </td>
                                                                            <td>
                                                                                <asp:DropDownList ID="dd21007" runat="server" CssClass="dropdownbutton">
                                                                                    <asp:ListItem Value="1">ELISA</asp:ListItem>
                                                                                    <asp:ListItem Value="2">Latex Agglutination</asp:ListItem>
                                                                                    <asp:ListItem Value="4">Chemiluminescence Immunoassay</asp:ListItem>
                                                                                    <asp:ListItem Value="5">DNA Amplification</asp:ListItem>
                                                                                    <asp:ListItem Value="6">Viral Culture</asp:ListItem>
                                                                                </asp:DropDownList>
                                                                            </td>
                                                                            <td>
                                                                                <asp:DropDownList ID="dd31007" runat="server" CssClass="dropdownbutton" onchange="ShowCyto1()">
                                                                                    <asp:ListItem>Select</asp:ListItem>
                                                                                    <asp:ListItem>Quantitative</asp:ListItem>
                                                                                    <asp:ListItem>Qualitative</asp:ListItem>
                                                                                </asp:DropDownList>
                                                                            </td>
                                                                            <td>
                                                                                <div id="divCytoQuan1" style="display: none">
                                                                                    <asp:TextBox ID="t1007" runat="server" CssClass="textbox_hemat"></asp:TextBox>
                                                                                    <label>
                                                                                        Iu/ml</label>
                                                                                </div>
                                                                            </td>
                                                                            <td>
                                                                                <div id="divCytoQual1" style="display: none">
                                                                                    <asp:DropDownList ID="dd1007" runat="server" CssClass="dropdownbutton">
                                                                                        <asp:ListItem>Positive</asp:ListItem>
                                                                                        <asp:ListItem>Negative</asp:ListItem>
                                                                                        <asp:ListItem>Equivocal</asp:ListItem>
                                                                                    </asp:DropDownList>
                                                                                </div>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </asp:Panel>
                                                            </td>
                                                        </tr>
                                                        <tr id="tr1008" runat="server">
                                                            <td colspan="5">
                                                                <asp:Panel ID="pn1008" runat="server" Enabled="false">
                                                                    <table>
                                                                        <tr>
                                                                            <td colspan="5">
                                                                                <label id="l1008">
                                                                                    Toxoplasma Virus IgG</label>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:DropDownList ID="dd11008" runat="server" CssClass="dropdownbutton">
                                                                                    <asp:ListItem>Serum</asp:ListItem>
                                                                                    <asp:ListItem>Cerebro Spinal Fluid</asp:ListItem>
                                                                                    <asp:ListItem>Pleural Fluid</asp:ListItem>
                                                                                    <asp:ListItem>Ascitic Fluid</asp:ListItem>
                                                                                    <asp:ListItem>Percardial Fluid</asp:ListItem>
                                                                                    <asp:ListItem>Joint Fluid Knee</asp:ListItem>
                                                                                    <asp:ListItem>Joint Fluid Elbow</asp:ListItem>
                                                                                    <asp:ListItem>Joint Fluid Shoulder</asp:ListItem>
                                                                                    <asp:ListItem>Hydrocode Fluid</asp:ListItem>
                                                                                    <asp:ListItem>Fluid from Syst</asp:ListItem>
                                                                                </asp:DropDownList>
                                                                            </td>
                                                                            <td>
                                                                                <asp:DropDownList ID="dd21008" runat="server" CssClass="dropdownbutton">
                                                                                    <asp:ListItem Value="1">ELISA</asp:ListItem>
                                                                                    <asp:ListItem Value="2">Latex Agglutination</asp:ListItem>
                                                                                    <asp:ListItem Value="3">Indirect Immunoflorescence</asp:ListItem>
                                                                                    <asp:ListItem Value="4">Chemiluminescence Immunoassay</asp:ListItem>
                                                                                    <asp:ListItem Value="5">DNA Amplification</asp:ListItem>
                                                                                    <asp:ListItem Value="6">Viral Culture</asp:ListItem>
                                                                                </asp:DropDownList>
                                                                            </td>
                                                                            <td>
                                                                                <asp:DropDownList ID="dd31008" runat="server" CssClass="dropdownbutton" onchange="ShowToxo()">
                                                                                    <asp:ListItem>Select</asp:ListItem>
                                                                                    <asp:ListItem>Quantitative</asp:ListItem>
                                                                                    <asp:ListItem>Qualitative</asp:ListItem>
                                                                                </asp:DropDownList>
                                                                            </td>
                                                                            <td>
                                                                                <div id="divToxoQuan" style="display: none">
                                                                                    <asp:TextBox ID="t1008" runat="server" CssClass="textbox_hemat"></asp:TextBox>
                                                                                    <label>
                                                                                        Iu/ml</label>
                                                                                </div>
                                                                            </td>
                                                                            <td>
                                                                                <div id="divToxoQual" style="display: none">
                                                                                    <asp:DropDownList ID="dd41008" runat="server" CssClass="dropdownbutton">
                                                                                        <asp:ListItem>Positive</asp:ListItem>
                                                                                        <asp:ListItem>Negative</asp:ListItem>
                                                                                        <asp:ListItem>Equivocal</asp:ListItem>
                                                                                    </asp:DropDownList>
                                                                                </div>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </asp:Panel>
                                                            </td>
                                                        </tr>
                                                        <tr id="tr1009" runat="server">
                                                            <td colspan="5">
                                                                <asp:Panel ID="pn1009" runat="server" Enabled="false">
                                                                    <table>
                                                                        <tr>
                                                                            <td colspan="5">
                                                                                <label id="l1009">
                                                                                    Toxoplasma Virus IgM</label>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:DropDownList ID="dd11009" runat="server" CssClass="dropdownbutton">
                                                                                    <asp:ListItem>Serum</asp:ListItem>
                                                                                    <asp:ListItem>Cerebro Spinal Fluid</asp:ListItem>
                                                                                    <asp:ListItem>Pleural Fluid</asp:ListItem>
                                                                                    <asp:ListItem>Ascitic Fluid</asp:ListItem>
                                                                                    <asp:ListItem>Percardial Fluid</asp:ListItem>
                                                                                    <asp:ListItem>Joint Fluid Knee</asp:ListItem>
                                                                                    <asp:ListItem>Joint Fluid Elbow</asp:ListItem>
                                                                                    <asp:ListItem>Joint Fluid Shoulder</asp:ListItem>
                                                                                    <asp:ListItem>Hydrocode Fluid</asp:ListItem>
                                                                                    <asp:ListItem>Fluid from Syst</asp:ListItem>
                                                                                </asp:DropDownList>
                                                                            </td>
                                                                            <td>
                                                                                <asp:DropDownList ID="dd21009" runat="server" CssClass="dropdownbutton">
                                                                                    <asp:ListItem Value="1">ELISA</asp:ListItem>
                                                                                    <asp:ListItem Value="2">Latex Agglutination</asp:ListItem>
                                                                                    <asp:ListItem Value="3">Indirect Immunoflorescence</asp:ListItem>
                                                                                    <asp:ListItem Value="4">Chemiluminescence Immunoassay</asp:ListItem>
                                                                                    <asp:ListItem Value="5">DNA Amplification</asp:ListItem>
                                                                                    <asp:ListItem Value="6">Viral Culture</asp:ListItem>
                                                                                </asp:DropDownList>
                                                                            </td>
                                                                            <td>
                                                                                <asp:DropDownList ID="dd31009" runat="server" CssClass="dropdownbutton" onchange="ShowToxo1()">
                                                                                    <asp:ListItem>Select</asp:ListItem>
                                                                                    <asp:ListItem>Quantitative</asp:ListItem>
                                                                                    <asp:ListItem>Qualitative</asp:ListItem>
                                                                                </asp:DropDownList>
                                                                            </td>
                                                                            <td>
                                                                                <div id="divToxoQuan1" style="display: none">
                                                                                    <asp:TextBox ID="t1009" runat="server" CssClass="textbox_hemat"></asp:TextBox>
                                                                                    <label>
                                                                                        Iu/ml</label>
                                                                                </div>
                                                                            </td>
                                                                            <td>
                                                                                <div id="divToxoQual1" style="display: none">
                                                                                    <asp:DropDownList ID="dd41009" runat="server" CssClass="dropdownbutton">
                                                                                        <asp:ListItem>Positive</asp:ListItem>
                                                                                        <asp:ListItem>Negative</asp:ListItem>
                                                                                        <asp:ListItem>Equivocal</asp:ListItem>
                                                                                    </asp:DropDownList>
                                                                                </div>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </asp:Panel>
                                                            </td>
                                                        </tr>
                                                        <tr id="tr1010" runat="server">
                                                            <td colspan="5">
                                                                <asp:Panel ID="pn1010" runat="server" Enabled="false">
                                                                    <table>
                                                                        <tr>
                                                                            <td colspan="4">
                                                                                <label id="l1010">
                                                                                    Herpes Simplex Virus IgG</label>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:DropDownList ID="dd11010" runat="server" CssClass="dropdownbutton">
                                                                                    <asp:ListItem>Serum</asp:ListItem>
                                                                                    <asp:ListItem>Cerebro Spinal Fluid</asp:ListItem>
                                                                                    <asp:ListItem>Pleural Fluid</asp:ListItem>
                                                                                    <asp:ListItem>Ascitic Fluid</asp:ListItem>
                                                                                    <asp:ListItem>Percardial Fluid</asp:ListItem>
                                                                                    <asp:ListItem>Joint Fluid Knee</asp:ListItem>
                                                                                    <asp:ListItem>Joint Fluid Elbow</asp:ListItem>
                                                                                    <asp:ListItem>Joint Fluid Shoulder</asp:ListItem>
                                                                                    <asp:ListItem>Hydrocode Fluid</asp:ListItem>
                                                                                    <asp:ListItem>Fluid from Syst</asp:ListItem>
                                                                                </asp:DropDownList>
                                                                            </td>
                                                                            <td>
                                                                                <asp:DropDownList ID="dd21010" runat="server" CssClass="dropdownbutton">
                                                                                    <asp:ListItem Value="1">ELISA</asp:ListItem>
                                                                                    <asp:ListItem Value="2">Latex Agglutination</asp:ListItem>
                                                                                    <asp:ListItem Value="4">Chemiluminescence Immunoassay</asp:ListItem>
                                                                                    <asp:ListItem Value="5">DNA Amplification</asp:ListItem>
                                                                                    <asp:ListItem Value="6">Viral Culture</asp:ListItem>
                                                                                </asp:DropDownList>
                                                                            </td>
                                                                            <td>
                                                                                <asp:DropDownList ID="dd31010" runat="server" CssClass="dropdownbutton" onchange="ShowHerpes()">
                                                                                    <asp:ListItem>Select</asp:ListItem>
                                                                                    <asp:ListItem>Quantitative</asp:ListItem>
                                                                                    <asp:ListItem>Qualitative</asp:ListItem>
                                                                                </asp:DropDownList>
                                                                            </td>
                                                                            <td>
                                                                                <div id="divHerpesQuan" style="display: none">
                                                                                    <asp:TextBox ID="t1010" runat="server" CssClass="textbox_hemat"></asp:TextBox>
                                                                                    <label>
                                                                                        Iu/ml</label>
                                                                                </div>
                                                                            </td>
                                                                            <td>
                                                                                <div id="divHerpesQual" style="display: none">
                                                                                    <asp:DropDownList ID="dd41010" runat="server" CssClass="dropdownbutton">
                                                                                        <asp:ListItem>Positive</asp:ListItem>
                                                                                        <asp:ListItem>Negative</asp:ListItem>
                                                                                        <asp:ListItem>Equivocal</asp:ListItem>
                                                                                    </asp:DropDownList>
                                                                                </div>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </asp:Panel>
                                                            </td>
                                                        </tr>
                                                        <tr id="tr1011" runat="server">
                                                            <td colspan="5">
                                                                <asp:Panel ID="pn1011" runat="server" Enabled="false">
                                                                    <table>
                                                                        <tr>
                                                                            <td colspan="4">
                                                                                <label id="l1011">
                                                                                    Herpes Simplex Virus IgM</label>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:DropDownList ID="dd11011" runat="server" CssClass="dropdownbutton">
                                                                                    <asp:ListItem>Serum</asp:ListItem>
                                                                                    <asp:ListItem>Cerebro Spinal Fluid</asp:ListItem>
                                                                                    <asp:ListItem>Pleural Fluid</asp:ListItem>
                                                                                    <asp:ListItem>Ascitic Fluid</asp:ListItem>
                                                                                    <asp:ListItem>Percardial Fluid</asp:ListItem>
                                                                                    <asp:ListItem>Joint Fluid Knee</asp:ListItem>
                                                                                    <asp:ListItem>Joint Fluid Elbow</asp:ListItem>
                                                                                    <asp:ListItem>Joint Fluid Shoulder</asp:ListItem>
                                                                                    <asp:ListItem>Hydrocode Fluid</asp:ListItem>
                                                                                    <asp:ListItem>Fluid from Syst</asp:ListItem>
                                                                                </asp:DropDownList>
                                                                            </td>
                                                                            <td>
                                                                                <asp:DropDownList ID="dd21011" runat="server" CssClass="dropdownbutton">
                                                                                    <asp:ListItem Value="1">ELISA</asp:ListItem>
                                                                                    <asp:ListItem Value="2">Latex Agglutination</asp:ListItem>
                                                                                    <asp:ListItem Value="4">Chemiluminescence Immunoassay</asp:ListItem>
                                                                                    <asp:ListItem Value="5">DNA Amplification</asp:ListItem>
                                                                                    <asp:ListItem Value="6">Viral Culture</asp:ListItem>
                                                                                </asp:DropDownList>
                                                                            </td>
                                                                            <td>
                                                                                <asp:DropDownList ID="dd31011" runat="server" CssClass="dropdownbutton" onchange="ShowHerpes1()">
                                                                                    <asp:ListItem>Select</asp:ListItem>
                                                                                    <asp:ListItem>Quantitative</asp:ListItem>
                                                                                    <asp:ListItem>Qualitative</asp:ListItem>
                                                                                </asp:DropDownList>
                                                                            </td>
                                                                            <td>
                                                                                <div id="divHerpesQuan1" style="display: none">
                                                                                    <asp:TextBox ID="t1011" runat="server" CssClass="textbox_hemat"></asp:TextBox>
                                                                                    <label>
                                                                                        Iu/ml</label>
                                                                                </div>
                                                                            </td>
                                                                            <td>
                                                                                <div id="divHerpesQual1" style="display: none">
                                                                                    <asp:DropDownList ID="dd41011" runat="server" CssClass="dropdownbutton">
                                                                                        <asp:ListItem>Positive</asp:ListItem>
                                                                                        <asp:ListItem>Negative</asp:ListItem>
                                                                                        <asp:ListItem>Equivocal</asp:ListItem>
                                                                                    </asp:DropDownList>
                                                                                </div>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </asp:Panel>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="5">
                                                                <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                                                                    <ContentTemplate>
                                                                        <table>
                                                                            <tr>
                                                                                <td>
                                                                                    <asp:Button ID="btnSaveMicro" runat="server" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                                                        onmouseout="this.className='btn'" OnClick="btnSaveMicro_Click" TabIndex="26"
                                                                                        Text="Save" />
                                                                                </td>
                                                                                <td>
                                                                                    <asp:Button ID="Button2" runat="server" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                                                        onmouseout="this.className='btn'" TabIndex="26" Text="Cancel" />
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td colspan="2">
                                                                                    <asp:Label ID="lblSave" runat="server" CssClass="errormsg"> </asp:Label>
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </ContentTemplate>
                                                                </asp:UpdatePanel>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                </ContentTemplate>
                            </Ajax:TabPanel>
                            <Ajax:TabPanel ID="tp4001" runat="server" HeaderText="Clinical Pathology" Enabled="false">
                                <ContentTemplate>
                                    <table cellspacing="0" border="0" width="100%">
                                        <tr>
                                            <td>
                                                <a id="a4002" runat="server" href="javascript:animatedcollapse.toggle('d4002')" visible="false">
                                                    <span class="label_collapse">Urine Analysis</span></a>
                                                <div id="d4002" style="display: none; padding-left: 20px">
                                                    <table width="50%">
                                                        <tr>
                                                            <td colspan="2">
                                                                <asp:Panel ID="pn4003" runat="server" Enabled="false">
                                                                    <table width="100%">
                                                                        <tr>
                                                                            <td width="30%">
                                                                                <label>
                                                                                    Colour</label>
                                                                            </td>
                                                                            <td>
                                                                                <asp:DropDownList ID="dd4003" runat="server" CssClass="dropdownbutton">
                                                                                    <asp:ListItem>Yellow</asp:ListItem>
                                                                                    <asp:ListItem>White</asp:ListItem>
                                                                                    <asp:ListItem>Brownish</asp:ListItem>
                                                                                    <asp:ListItem>Reddish</asp:ListItem>
                                                                                    <asp:ListItem>Pink</asp:ListItem>
                                                                                    <asp:ListItem>Blue</asp:ListItem>
                                                                                    <asp:ListItem>Green</asp:ListItem>
                                                                                </asp:DropDownList>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </asp:Panel>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="2">
                                                                <asp:Panel ID="pn4004" runat="server" Enabled="false">
                                                                    <table width="100%">
                                                                        <tr>
                                                                            <td width="30%">
                                                                                <label>
                                                                                    PH</label>
                                                                            </td>
                                                                            <td>
                                                                                <asp:DropDownList ID="dd4004" runat="server" CssClass="dropdownbutton">
                                                                                    <asp:ListItem>Acidic</asp:ListItem>
                                                                                    <asp:ListItem>Alkaline</asp:ListItem>
                                                                                    <asp:ListItem>Neutral</asp:ListItem>
                                                                                </asp:DropDownList>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </asp:Panel>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="2">
                                                                <asp:Panel ID="pn4005" runat="server" Enabled="false">
                                                                    <table width="100%">
                                                                        <tr>
                                                                            <td width="30%">
                                                                                <label>
                                                                                    Specific Gravity</label>
                                                                            </td>
                                                                            <td>
                                                                                <asp:TextBox ID="t4005" runat="server" CssClass="textbox_hemat" MaxLength="4" onbeforepaste="BeforePaste_Event()"
                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()"></asp:TextBox>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </asp:Panel>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                    <table width="100%">
                                                        <tr>
                                                            <td>
                                                                <a id="a4006" runat="server" href="javascript:animatedcollapse.toggle('d4006')"><span
                                                                    class="label_collapse">Cells</span></a>
                                                                <div id="d4006" style="display: none; padding-left: 20px">
                                                                    <table width="100%">
                                                                        <tr>
                                                                            <td colspan="2">
                                                                                <asp:Panel ID="pn4007" runat="server" Enabled="false">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td width="30%">
                                                                                                <label>
                                                                                                    RBC<sub>s</sub></label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:TextBox ID="t4007" runat="server" CssClass="textbox_hemat" MaxLength="4" onbeforepaste="BeforePaste_Event()"
                                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()"></asp:TextBox>
                                                                                                <label>
                                                                                                    cells/hpf</label>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                            <td colspan="2" width="43%">
                                                                                <asp:Panel ID="pn4008" runat="server" Enabled="false">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td width="30%">
                                                                                                <label>
                                                                                                    WBC<sub>s</sub></label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:TextBox ID="t4008" runat="server" CssClass="textbox_hemat" MaxLength="4" onbeforepaste="BeforePaste_Event()"
                                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()"></asp:TextBox>
                                                                                                <label>
                                                                                                    cells/hpf</label>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td colspan="2">
                                                                                <asp:Panel ID="pn4009" runat="server" Enabled="false">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td width="30%">
                                                                                                <label>
                                                                                                    Eosinophil</label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:TextBox ID="t4009" runat="server" CssClass="textbox_hemat" MaxLength="4" onbeforepaste="BeforePaste_Event()"
                                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()"></asp:TextBox>
                                                                                                <label>
                                                                                                    eosinophil/ml</label>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                            <td colspan="2">
                                                                                <asp:Panel ID="pn4010" runat="server" Enabled="false">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td width="30%">
                                                                                                <label>
                                                                                                    Pus Cells</label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:TextBox ID="t4010" runat="server" CssClass="textbox_hemat" MaxLength="4" onbeforepaste="BeforePaste_Event()"
                                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()"></asp:TextBox>
                                                                                                <label>
                                                                                                    cells/hpf</label>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td colspan="4">
                                                                                <asp:Panel ID="pn4011" runat="server" Enabled="false" Width="100%">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td width="15%">
                                                                                                <label>
                                                                                                    Casts</label>
                                                                                            </td>
                                                                                            <td width="22%">
                                                                                                <asp:DropDownList ID="dd4011" runat="server" CssClass="dropdownbutton" onchange="UrineCellsCastsPresent()">
                                                                                                    <asp:ListItem Text="None" Value="None"></asp:ListItem>
                                                                                                    <asp:ListItem Text="Present" Value="Present"></asp:ListItem>
                                                                                                </asp:DropDownList>
                                                                                                <label>
                                                                                                    cells/hpf</label>
                                                                                            </td>
                                                                                            <td width="70%">
                                                                                                <div id="divCastsPresent" style="display: block;">
                                                                                                    <table width="100%">
                                                                                                        <tr>
                                                                                                            <td>
                                                                                                                <asp:CheckBox ID="c4150" runat="server" Text="RBC Casts"></asp:CheckBox>
                                                                                                            </td>
                                                                                                            <td>
                                                                                                                <asp:CheckBox ID="c4151" runat="server" Text="Tubular Casts"></asp:CheckBox>
                                                                                                            </td>
                                                                                                            <td>
                                                                                                                <asp:CheckBox ID="c4152" runat="server" Text="WBC Casts"></asp:CheckBox>
                                                                                                            </td>
                                                                                                        </tr>
                                                                                                        <tr>
                                                                                                            <td>
                                                                                                                <asp:CheckBox ID="c4153" runat="server" Text="Parasitic Casts"></asp:CheckBox>
                                                                                                            </td>
                                                                                                            <td>
                                                                                                                <asp:CheckBox ID="c4154" runat="server" Text="Hyaline Casts"></asp:CheckBox>
                                                                                                            </td>
                                                                                                            <td>
                                                                                                                <asp:CheckBox ID="c4156" runat="server" Text="Waxy Casts"></asp:CheckBox>
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
                                                                        <tr>
                                                                            <td colspan="4">
                                                                                <asp:Panel ID="pn4012" runat="server" Enabled="false">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td>
                                                                                                <label>
                                                                                                    Others</label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:TextBox ID="t4012" runat="server" CssClass="textbox_hemat" MaxLength="4" onbeforepaste="BeforePaste_Event()"
                                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()"></asp:TextBox>
                                                                                                <label>
                                                                                                </label>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <a id="a4013" runat="server" href="javascript:animatedcollapse.toggle('d4013')"><span
                                                                    class="label_collapse">Chemistry</span></a>
                                                                <div id="d4013" style="display: none;">
                                                                    <table width="100%">
                                                                        <tr>
                                                                            <td>
                                                                                <asp:Panel ID="pn4014" runat="server" Enabled="false">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td width="40%">
                                                                                                <label>
                                                                                                    Albumin</label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:DropDownList ID="dd4014" runat="server" CssClass="dropdownbutton">
                                                                                                    <asp:ListItem>Absent</asp:ListItem>
                                                                                                    <asp:ListItem>    + </asp:ListItem>
                                                                                                    <asp:ListItem>   + + </asp:ListItem>
                                                                                                    <asp:ListItem>  + + + </asp:ListItem>
                                                                                                    <asp:ListItem> + + + + </asp:ListItem>
                                                                                                </asp:DropDownList>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                            <td>
                                                                                <asp:Panel ID="pn4015" runat="server" Enabled="false">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td width="40%">
                                                                                                <label>
                                                                                                    MicroAlbumin</label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:TextBox ID="t4015" runat="server" CssClass="textbox_hemat" onbeforepaste="BeforePaste_Event()"
                                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()"></asp:TextBox>
                                                                                                <label>
                                                                                                    mg/24hr Urine
                                                                                                </label>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:Panel ID="pn4016" runat="server" Enabled="false">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td width="40%">
                                                                                                <label>
                                                                                                    Sugar</label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:DropDownList ID="dd4016" runat="server" CssClass="dropdownbutton">
                                                                                                    <asp:ListItem>Absent</asp:ListItem>
                                                                                                    <asp:ListItem>   + </asp:ListItem>
                                                                                                    <asp:ListItem>  + +</asp:ListItem>
                                                                                                    <asp:ListItem> + + +</asp:ListItem>
                                                                                                    <asp:ListItem>+ + + +</asp:ListItem>
                                                                                                </asp:DropDownList>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                            <td>
                                                                                <asp:Panel ID="pn4017" runat="server" Enabled="false">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td width="40%">
                                                                                                <label>
                                                                                                    Ketones</label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:DropDownList ID="dd4017" runat="server" CssClass="dropdownbutton">
                                                                                                    <asp:ListItem>Absent</asp:ListItem>
                                                                                                    <asp:ListItem>+</asp:ListItem>
                                                                                                    <asp:ListItem>++</asp:ListItem>
                                                                                                    <asp:ListItem>+++</asp:ListItem>
                                                                                                    <asp:ListItem>++++</asp:ListItem>
                                                                                                </asp:DropDownList>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:Panel ID="pn4018" runat="server" Enabled="false">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td width="40%">
                                                                                                <label>
                                                                                                    Bile Salts</label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:DropDownList ID="dd4018" runat="server" CssClass="dropdownbutton">
                                                                                                    <asp:ListItem>Absent</asp:ListItem>
                                                                                                    <asp:ListItem>Present</asp:ListItem>
                                                                                                </asp:DropDownList>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                            <td>
                                                                                <asp:Panel ID="pn4019" runat="server" Enabled="false">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td width="40%">
                                                                                                <label>
                                                                                                    Bile Pigments</label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:DropDownList ID="dd4019" runat="server" CssClass="dropdownbutton">
                                                                                                    <asp:ListItem>Absent</asp:ListItem>
                                                                                                    <asp:ListItem>Present</asp:ListItem>
                                                                                                </asp:DropDownList>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:Panel ID="pn4020" runat="server" Enabled="false">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td width="40%">
                                                                                                <label>
                                                                                                    Urine Spot Creaat</label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:TextBox ID="t4020" runat="server" CssClass="textbox_hemat" onbeforepaste="BeforePaste_Event()"
                                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()"></asp:TextBox>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                            <td>
                                                                                <asp:Panel ID="pn4021" runat="server" Enabled="false">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td width="40%">
                                                                                                <label>
                                                                                                    Urine Spot Na<sup>+</sup></label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:TextBox ID="t4021" runat="server" CssClass="textbox_hemat" onbeforepaste="BeforePaste_Event()"
                                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()"></asp:TextBox>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:Panel ID="pn4022" runat="server" Enabled="false">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td width="40%">
                                                                                                <label>
                                                                                                    Urine Spot K<sup>+</sup></label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:TextBox ID="t4022" runat="server" CssClass="textbox_hemat" onbeforepaste="BeforePaste_Event()"
                                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()"></asp:TextBox>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                            <td>
                                                                                <asp:Panel ID="pn4023" runat="server" Enabled="false">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td width="40%">
                                                                                                <label>
                                                                                                    Urine Spot Proteins</label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:TextBox ID="t4023" runat="server" CssClass="textbox_hemat" onbeforepaste="BeforePaste_Event()"
                                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()"></asp:TextBox>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:Panel ID="pn4024" runat="server" Enabled="false">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td width="40%">
                                                                                                <label>
                                                                                                    Urinary Uric Acid</label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:TextBox ID="t4024" runat="server" CssClass="textbox_hemat" onbeforepaste="BeforePaste_Event()"
                                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()"></asp:TextBox>
                                                                                                <label>
                                                                                                    mg/d</label>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                            <td>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <a id="a4025" runat="server" href="javascript:animatedcollapse.toggle('d4025')"><span
                                                                    class="label_collapse">Urine Microscopic Examination</span></a>
                                                                <div id="d4025" style="display: none; padding-left: 20px">
                                                                    <table width="100%">
                                                                        <tr>
                                                                            <td colspan="2">
                                                                                <asp:Panel ID="pn4026" runat="server" Enabled="false">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td width="40%">
                                                                                                <label>
                                                                                                    Monilla</label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:DropDownList ID="dd4026" runat="server" CssClass="dropdownbutton">
                                                                                                    <asp:ListItem>0</asp:ListItem>
                                                                                                    <asp:ListItem>2-4</asp:ListItem>
                                                                                                    <asp:ListItem>8-10</asp:ListItem>
                                                                                                </asp:DropDownList>
                                                                                                <label>
                                                                                                    /HPF</label>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                            <td colspan="2">
                                                                                <asp:Panel ID="pn4027" runat="server" Enabled="false">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td width="40%">
                                                                                                <label>
                                                                                                    Bacteria</label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:DropDownList ID="dd4027" runat="server" CssClass="dropdownbutton">
                                                                                                    <asp:ListItem>0</asp:ListItem>
                                                                                                    <asp:ListItem>2-4</asp:ListItem>
                                                                                                    <asp:ListItem>8-10</asp:ListItem>
                                                                                                </asp:DropDownList>
                                                                                                <label>
                                                                                                    /HPF</label>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td colspan="2">
                                                                                <asp:Panel ID="pn4028" runat="server" Enabled="false">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td width="40%">
                                                                                                <label>
                                                                                                    Epithelial Cells</label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:DropDownList ID="dd4028" runat="server" CssClass="dropdownbutton">
                                                                                                    <asp:ListItem>0</asp:ListItem>
                                                                                                    <asp:ListItem>+</asp:ListItem>
                                                                                                    <asp:ListItem>+ +</asp:ListItem>
                                                                                                    <asp:ListItem>+ + +</asp:ListItem>
                                                                                                    <asp:ListItem>+ + + +</asp:ListItem>
                                                                                                </asp:DropDownList>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                            <td colspan="2">
                                                                                <asp:Panel ID="pn4029" runat="server" Enabled="false">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td width="40%">
                                                                                                <label>
                                                                                                    Amorphous Phosphate</label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:DropDownList ID="dd4029" runat="server" CssClass="dropdownbutton">
                                                                                                    <asp:ListItem>0</asp:ListItem>
                                                                                                    <asp:ListItem>2-4</asp:ListItem>
                                                                                                    <asp:ListItem>8-10</asp:ListItem>
                                                                                                </asp:DropDownList>
                                                                                                <label>
                                                                                                    /HPF</label>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td colspan="2">
                                                                                <asp:Panel ID="pn4030" runat="server" Enabled="false">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td width="40%">
                                                                                                <label>
                                                                                                    Red Blood Cells</label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:DropDownList ID="dd4030" runat="server" CssClass="dropdownbutton">
                                                                                                    <asp:ListItem>0</asp:ListItem>
                                                                                                    <asp:ListItem>2-4</asp:ListItem>
                                                                                                    <asp:ListItem>8-10</asp:ListItem>
                                                                                                </asp:DropDownList>
                                                                                                <label>
                                                                                                    HPF</label>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                            <td colspan="2">
                                                                                <asp:Panel ID="pn4031" runat="server" Enabled="false">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td width="40%">
                                                                                                <label>
                                                                                                    Leucocyte</label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:DropDownList ID="dd4031" runat="server" CssClass="dropdownbutton">
                                                                                                    <asp:ListItem>0</asp:ListItem>
                                                                                                    <asp:ListItem>2-4</asp:ListItem>
                                                                                                    <asp:ListItem>8-10</asp:ListItem>
                                                                                                </asp:DropDownList>
                                                                                                <label>
                                                                                                    HPF</label>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td colspan="6">
                                                                                <a id="a4032" runat="server" href="javascript:animatedcollapse.toggle('d4032')" visible="false">
                                                                                    <span class="label_collapse">Casts</span></a>
                                                                                <div id="d4032" style="display: none; padding-left: 20px">
                                                                                    <table>
                                                                                        <tr>
                                                                                            <td>
                                                                                                <asp:Panel ID="pn4033" runat="server" Enabled="false">
                                                                                                    <table width="100%">
                                                                                                        <tr>
                                                                                                            <td>
                                                                                                                <label>
                                                                                                                    RBC Casts</label>
                                                                                                            </td>
                                                                                                            <td>
                                                                                                                <asp:DropDownList ID="dd4033" runat="server">
                                                                                                                    <asp:ListItem>Absent</asp:ListItem>
                                                                                                                    <asp:ListItem>Present</asp:ListItem>
                                                                                                                </asp:DropDownList>
                                                                                                            </td>
                                                                                                        </tr>
                                                                                                    </table>
                                                                                                </asp:Panel>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </div>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <a id="a4034" runat="server" href="javascript:animatedcollapse.toggle('d4034')" visible="false">
                                                                    <span class="label_collapse">24 Hours Urine Sample</span></a>
                                                                <div id="d4034" style="display: none;">
                                                                    <table width="100%">
                                                                        <tr>
                                                                            <td colspan="2">
                                                                                <asp:Panel ID="pn4035" runat="server" Enabled="false">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td width="40%">
                                                                                                <label>
                                                                                                    Volume</label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:TextBox ID="t4035" runat="server" CssClass="textbox_hemat" onbeforepaste="BeforePaste_Event()"
                                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()"></asp:TextBox>
                                                                                                <label>
                                                                                                    ml</label>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                            <td colspan="2">
                                                                                <asp:Panel ID="pn4036" runat="server" Enabled="false">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td width="40%">
                                                                                                <label>
                                                                                                    Color</label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:DropDownList ID="dd4036" runat="server" CssClass="dropdownbutton">
                                                                                                    <asp:ListItem>Yellow</asp:ListItem>
                                                                                                    <asp:ListItem>White</asp:ListItem>
                                                                                                    <asp:ListItem>Brownish</asp:ListItem>
                                                                                                    <asp:ListItem>Reddish</asp:ListItem>
                                                                                                    <asp:ListItem>Pink</asp:ListItem>
                                                                                                    <asp:ListItem>Blue</asp:ListItem>
                                                                                                    <asp:ListItem>Green</asp:ListItem>
                                                                                                </asp:DropDownList>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td colspan="2">
                                                                                <asp:Panel ID="pn4037" runat="server" Enabled="false">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td width="40%">
                                                                                                <label>
                                                                                                    Na<sup>+</sup></label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:TextBox ID="t4037" runat="server" CssClass="textbox_hemat" onbeforepaste="BeforePaste_Event()"
                                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()"></asp:TextBox>
                                                                                                <label>
                                                                                                    mg/day</label>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                            <td colspan="2">
                                                                                <asp:Panel ID="pn4038" runat="server" Enabled="false">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td width="40%">
                                                                                                <label>
                                                                                                    K<sup>+</sup></label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:TextBox ID="t4038" runat="server" CssClass="textbox_hemat" onbeforepaste="BeforePaste_Event()"
                                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()"></asp:TextBox>
                                                                                                <label>
                                                                                                    mg/day</label>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td colspan="2">
                                                                                <asp:Panel ID="pn4039" runat="server" Enabled="false">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td width="40%">
                                                                                                <label>
                                                                                                    Ca<sup>++</sup></label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:TextBox ID="t4039" runat="server" CssClass="textbox_hemat" onbeforepaste="BeforePaste_Event()"
                                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()"></asp:TextBox>
                                                                                                <label>
                                                                                                    mg/day</label>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                            <td colspan="2">
                                                                                <asp:Panel ID="pn4040" runat="server" Enabled="false">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td width="40%">
                                                                                                <label>
                                                                                                    Po<sub>4</sub><sup>--</sup></label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:TextBox ID="t4040" runat="server" CssClass="textbox_hemat" onbeforepaste="BeforePaste_Event()"
                                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()"></asp:TextBox>
                                                                                                <label>
                                                                                                    mg/day</label>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td colspan="2">
                                                                                <asp:Panel ID="pn4041" runat="server" Enabled="false">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td width="40%">
                                                                                                <label>
                                                                                                    VMA</label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:TextBox ID="t4041" runat="server" CssClass="textbox_hemat" onbeforepaste="BeforePaste_Event()"
                                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()"></asp:TextBox>
                                                                                                <label>
                                                                                                    mg/day</label>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                            <td colspan="2">
                                                                                <asp:Panel ID="pn4042" runat="server" Enabled="false">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td width="40%">
                                                                                                <label>
                                                                                                    Metanephrine</label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:TextBox ID="t4042" runat="server" CssClass="textbox_hemat" onbeforepaste="BeforePaste_Event()"
                                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()"></asp:TextBox>
                                                                                                <label>
                                                                                                    mg/day</label>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td colspan="2">
                                                                                <asp:Panel ID="pn4043" runat="server" Enabled="false">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td width="40%">
                                                                                                <label>
                                                                                                    Norepinephrine</label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:TextBox ID="t4043" runat="server" CssClass="textbox_hemat" onbeforepaste="BeforePaste_Event()"
                                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()"></asp:TextBox>
                                                                                                <label>
                                                                                                    mg/day</label>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                            <td colspan="2">
                                                                                <asp:Panel ID="pn4044" runat="server" Enabled="false">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td width="40%">
                                                                                                <label>
                                                                                                    Others</label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:TextBox ID="t4044" runat="server" TextMode="MultiLine"></asp:TextBox>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <a href="javascript:animatedcollapse.toggle('d4045')" id="a4045" runat="server" visible="false">
                                                    <span class="label_collapse">BodyFluidAnalysis</span></a>
                                                <div id="d4045" style="width: 100%; display: none; padding-left: 20px">
                                                    <table width="100%">
                                                        <tr>
                                                            <td colspan="2">
                                                                <asp:Panel ID="pn4046" runat="server" Enabled="false">
                                                                    <table width="100%">
                                                                        <tr>
                                                                            <td width="40%">
                                                                                <label>
                                                                                    Source Of Fluid</label>
                                                                            </td>
                                                                            <td>
                                                                                <asp:DropDownList ID="dd4046" runat="server" CssClass="dropdownbutton">
                                                                                    <asp:ListItem>Cerebro Spinal Fluid</asp:ListItem>
                                                                                    <asp:ListItem>Pleural Fluid</asp:ListItem>
                                                                                    <asp:ListItem>Ascitic Fluid</asp:ListItem>
                                                                                    <asp:ListItem>Percardial Fluid</asp:ListItem>
                                                                                    <asp:ListItem>Joint Fluid Knee</asp:ListItem>
                                                                                    <asp:ListItem>Joint Fluid Elbow</asp:ListItem>
                                                                                    <asp:ListItem>Joint Fluid Shoulder</asp:ListItem>
                                                                                    <asp:ListItem>Hydrocode Fluid</asp:ListItem>
                                                                                    <asp:ListItem>Fluid from Syst</asp:ListItem>
                                                                                </asp:DropDownList>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </asp:Panel>
                                                            </td>
                                                            <td colspan="2" width="58%">
                                                                <asp:Panel ID="pn4047" runat="server" Enabled="false">
                                                                    <table width="100%">
                                                                        <tr>
                                                                            <td width="40%">
                                                                                <label>
                                                                                    Specimen Volume</label>
                                                                            </td>
                                                                            <td>
                                                                                <asp:TextBox ID="t4047" runat="server" CssClass="textbox_hemat" MaxLength="4" onbeforepaste="BeforePaste_Event()"
                                                                                    onkeypress="return NotZero(event,range);" onPaste="Paste_Event()"></asp:TextBox>
                                                                                <label>
                                                                                    ml</label>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </asp:Panel>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="2">
                                                                <asp:Panel ID="pn4048" runat="server" Enabled="false">
                                                                    <table width="100%">
                                                                        <tr>
                                                                            <td width="40%">
                                                                                <label>
                                                                                    Color</label>
                                                                            </td>
                                                                            <td>
                                                                                <asp:DropDownList ID="dd4048" runat="server" CssClass="dropdownbutton">
                                                                                    <asp:ListItem>Yellow</asp:ListItem>
                                                                                    <asp:ListItem>White</asp:ListItem>
                                                                                    <asp:ListItem>Brownish</asp:ListItem>
                                                                                    <asp:ListItem>Reddish</asp:ListItem>
                                                                                    <asp:ListItem>Pink</asp:ListItem>
                                                                                    <asp:ListItem>Blue</asp:ListItem>
                                                                                    <asp:ListItem>Green</asp:ListItem>
                                                                                </asp:DropDownList>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </asp:Panel>
                                                            </td>
                                                            <td colspan="2">
                                                                <asp:Panel ID="pn4049" runat="server" Enabled="false">
                                                                    <table width="100%">
                                                                        <tr>
                                                                            <td width="40%">
                                                                                <label>
                                                                                    Appearance</label>
                                                                            </td>
                                                                            <td>
                                                                                <asp:DropDownList ID="dd4049" runat="server" CssClass="dropdownbutton">
                                                                                    <asp:ListItem>Clear</asp:ListItem>
                                                                                    <asp:ListItem>Turbid</asp:ListItem>
                                                                                    <asp:ListItem>Purulent</asp:ListItem>
                                                                                    <asp:ListItem>Frank pus</asp:ListItem>
                                                                                </asp:DropDownList>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </asp:Panel>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="4">
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="4">
                                                                <a id="a4050" runat="server" href="javascript:animatedcollapse.toggle('d4050')" visible="false">
                                                                    <span class="label_collapse">Cells</span></a>
                                                                <div id="d4050" style="display: none; padding-left: 20px">
                                                                    <table width="100%">
                                                                        <tr>
                                                                            <td colspan="2">
                                                                                <asp:Panel ID="pn4051" runat="server" Enabled="false">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td width="27%">
                                                                                                <label>
                                                                                                    Total</label>
                                                                                            </td>
                                                                                            <td width="73%">
                                                                                                <asp:TextBox ID="t4051" runat="server" CssClass="textbox_hemat" onbeforepaste="BeforePaste_Event()"
                                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()"></asp:TextBox>
                                                                                                <label>
                                                                                                    cells/cumm</label>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                            <td colspan="2" width="66%">
                                                                                <asp:Panel ID="pn4052" runat="server" Enabled="false">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td width="21%">
                                                                                                <label>
                                                                                                    Mononuclear Cells</label>
                                                                                            </td>
                                                                                            <td width="79%">
                                                                                                <asp:TextBox ID="t4052" runat="server" CssClass="textbox_hemat" onbeforepaste="BeforePaste_Event()"
                                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()"></asp:TextBox>
                                                                                                <label>
                                                                                                    cells/cumm</label>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td colspan="4">
                                                                                <a id="a4053" runat="server" href="javascript:animatedcollapse.toggle('d4053')" visible="false">
                                                                                    <span class="label_collapse">Differential Count</span></a>
                                                                                <div id="d4053" style="display: none; padding-left: 20px">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td colspan="2">
                                                                                                <asp:Panel ID="pn4054" runat="server" Enabled="false">
                                                                                                    <table width="100%">
                                                                                                        <tr>
                                                                                                            <td style="padding-left: 20px" width="17%">
                                                                                                                <label>
                                                                                                                    Lymphocytes</label>
                                                                                                            </td>
                                                                                                            <td width="83%">
                                                                                                                <asp:TextBox ID="t4054" runat="server" CssClass="textbox_hemat" onbeforepaste="BeforePaste_Event()"
                                                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()"></asp:TextBox>
                                                                                                                <label>
                                                                                                                    %</label>
                                                                                                            </td>
                                                                                                        </tr>
                                                                                                    </table>
                                                                                                </asp:Panel>
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td colspan="2">
                                                                                                <asp:Panel ID="pn4055" runat="server" Enabled="false">
                                                                                                    <table width="100%">
                                                                                                        <tr>
                                                                                                            <td style="padding-left: 20px" width="17%">
                                                                                                                <label>
                                                                                                                    Monocytes</label>
                                                                                                            </td>
                                                                                                            <td width="83%">
                                                                                                                <asp:TextBox ID="t4055" runat="server" CssClass="textbox_hemat" onbeforepaste="BeforePaste_Event()"
                                                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()"></asp:TextBox>
                                                                                                                <label>
                                                                                                                    %</label>
                                                                                                            </td>
                                                                                                        </tr>
                                                                                                    </table>
                                                                                                </asp:Panel>
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td colspan="2">
                                                                                                <asp:Panel ID="pn4056" runat="server" Enabled="false">
                                                                                                    <table width="100%">
                                                                                                        <tr>
                                                                                                            <td style="padding-left: 20px" width="17%">
                                                                                                                <label>
                                                                                                                    Neutrophils</label>
                                                                                                            </td>
                                                                                                            <td width="83%">
                                                                                                                <asp:TextBox ID="t4056" runat="server" CssClass="textbox_hemat" onbeforepaste="BeforePaste_Event()"
                                                                                                                    onBlur="checkTotal()"      onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()"></asp:TextBox>
                                                                                                                <label>
                                                                                                                    %</label>
                                                                                                            </td>
                                                                                                        </tr>
                                                                                                    </table>
                                                                                                </asp:Panel>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </div>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td colspan="2">
                                                                                <asp:Panel ID="pn4057" runat="server" Enabled="false">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td width="27%">
                                                                                                <label>
                                                                                                    RBS</label>
                                                                                            </td>
                                                                                            <td colspan="3" width="73%">
                                                                                                <asp:TextBox ID="t4057" runat="server" CssClass="textbox_hemat" onbeforepaste="BeforePaste_Event()"
                                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()"></asp:TextBox>
                                                                                                <label>
                                                                                                    cells/cumm</label>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td colspan="2">
                                                                                <asp:Panel ID="pn4058" runat="server" Enabled="false">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td width="27%">
                                                                                                <label>
                                                                                                    Others</label>
                                                                                            </td>
                                                                                            <td colspan="3" width="73%">
                                                                                                <asp:TextBox ID="t4058" runat="server" CssClass="textbox_hemat" onbeforepaste="BeforePaste_Event()"
                                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()"></asp:TextBox>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="4">
                                                                <a href="javascript:animatedcollapse.toggle('d4059')" id="a4059" runat="server" visible="false">
                                                                    <span class="label_collapse">Chemistry</span></a>
                                                                <div id="d4059" style="display: none; padding-left: 20px">
                                                                    <table width="60%">
                                                                        <tr>
                                                                            <td colspan="2">
                                                                                <asp:Panel ID="pn4060" runat="server" Enabled="false">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td width="30%">
                                                                                                <label>
                                                                                                    Total Proteins</label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:TextBox ID="t4060" runat="server" CssClass="textbox_hemat" onPaste="Paste_Event()"
                                                                                                    onbeforepaste="BeforePaste_Event()"      onkeypress="return ValidateOnlyNumeric(this);"   ></asp:TextBox>
                                                                                                <label>
                                                                                                    mg/dl</label>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                            <td colspan="2">
                                                                                <asp:Panel ID="pn4061" runat="server" Enabled="false">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td width="30%">
                                                                                                <label>
                                                                                                    Albumin</label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:TextBox ID="t4061" runat="server" CssClass="textbox_hemat" onPaste="Paste_Event()"
                                                                                                    onbeforepaste="BeforePaste_Event()"      onkeypress="return ValidateOnlyNumeric(this);"   ></asp:TextBox>
                                                                                                <label>
                                                                                                    mg/dl</label>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td colspan="2">
                                                                                <asp:Panel ID="pn4062" runat="server" Enabled="false">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td width="30%">
                                                                                                <label>
                                                                                                    Glucose</label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:TextBox ID="t4062" runat="server" CssClass="textbox_hemat" onPaste="Paste_Event()"
                                                                                                    onbeforepaste="BeforePaste_Event()"      onkeypress="return ValidateOnlyNumeric(this);"   ></asp:TextBox>
                                                                                                <label>
                                                                                                    mg/dl</label>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                            <td colspan="2">
                                                                                <asp:Panel ID="pn4063" runat="server" Enabled="false">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td width="30%">
                                                                                                <label>
                                                                                                    LDH</label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:TextBox ID="t4063" runat="server" CssClass="textbox_hemat" onPaste="Paste_Event()"
                                                                                                    onbeforepaste="BeforePaste_Event()"      onkeypress="return ValidateOnlyNumeric(this);"   ></asp:TextBox>
                                                                                                <label>
                                                                                                    mg/dl</label>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td colspan="2">
                                                                                <asp:Panel ID="pn4064" runat="server" Enabled="false">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td width="30%">
                                                                                                <label>
                                                                                                    Lactate</label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:TextBox ID="t4064" runat="server" CssClass="textbox_hemat" onPaste="Paste_Event()"
                                                                                                    onbeforepaste="BeforePaste_Event()"      onkeypress="return ValidateOnlyNumeric(this);"   ></asp:TextBox>
                                                                                                <label>
                                                                                                    mg/dl</label>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                            <td colspan="2">
                                                                                <asp:Panel ID="pn4065" runat="server" Enabled="false">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td width="30%">
                                                                                                <label>
                                                                                                    Ammonia</label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:TextBox ID="t4065" runat="server" CssClass="textbox_hemat" onPaste="Paste_Event()"
                                                                                                    onbeforepaste="BeforePaste_Event()"      onkeypress="return ValidateOnlyNumeric(this);"   ></asp:TextBox>
                                                                                                <label>
                                                                                                    mg/dl</label>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="4">
                                                                <a id="a4066" runat="server" href="javascript:animatedcollapse.toggle('d4066')" visible="false">
                                                                    <span class="label_collapse">Immunological</span></a>
                                                                <div id="d4066" style="display: none; padding-left: 20px">
                                                                    <table width="80%">
                                                                        <tr>
                                                                            <td width="44%">
                                                                                <asp:Panel ID="pn4067" runat="server" Enabled="false">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td width="34%">
                                                                                                <label>
                                                                                                    Iga</label>
                                                                                            </td>
                                                                                            <td width="66%">
                                                                                                <asp:TextBox ID="t4067" runat="server" CssClass="textbox_hemat" onbeforepaste="BeforePaste_Event()"
                                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()"></asp:TextBox>
                                                                                                <label>
                                                                                                    mg/dl</label>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                            <td width="56%">
                                                                                <asp:Panel ID="pn4068" runat="server" Enabled="false">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td width="17%">
                                                                                                <label>
                                                                                                    Iga Index</label>
                                                                                            </td>
                                                                                            <td width="83%">
                                                                                                <asp:TextBox ID="t4068" runat="server" CssClass="textbox_hemat" onbeforepaste="BeforePaste_Event()"
                                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()"></asp:TextBox>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td colspan="2">
                                                                                <asp:Panel ID="pn4069" runat="server" Enabled="false">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td width="17%">
                                                                                                <label>
                                                                                                    Oligoclonal bonds</label>
                                                                                            </td>
                                                                                            <td colspan="2" width="83%">
                                                                                                <asp:TextBox ID="t4069" runat="server" CssClass="textbox_hemat" onbeforepaste="BeforePaste_Event()"
                                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()"></asp:TextBox>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td colspan="2">
                                                                                <asp:Panel ID="pn4070" runat="server" Enabled="false">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td width="17%">
                                                                                                <label>
                                                                                                    Anti TB IgG</label>
                                                                                            </td>
                                                                                            <td width="19%">
                                                                                                <asp:TextBox ID="t4070" runat="server" CssClass="textbox_hemat" onbeforepaste="BeforePaste_Event()"
                                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()"></asp:TextBox>
                                                                                            </td>
                                                                                            <td width="64%">
                                                                                                <asp:DropDownList ID="dd4070" runat="server">
                                                                                                    <asp:ListItem>Positive</asp:ListItem>
                                                                                                    <asp:ListItem>Negative</asp:ListItem>
                                                                                                    <asp:ListItem>Equivocal</asp:ListItem>
                                                                                                </asp:DropDownList>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td colspan="2">
                                                                                <asp:Panel ID="pn4071" runat="server" Enabled="false">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td width="17%">
                                                                                                <label>
                                                                                                    Anti TB IgM</label>
                                                                                            </td>
                                                                                            <td width="19%">
                                                                                                <asp:TextBox ID="t4071" runat="server" CssClass="textbox_hemat" onbeforepaste="BeforePaste_Event()"
                                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()"></asp:TextBox>
                                                                                            </td>
                                                                                            <td width="64%">
                                                                                                <asp:DropDownList ID="dd4071" runat="server">
                                                                                                    <asp:ListItem>Positive</asp:ListItem>
                                                                                                    <asp:ListItem>Negative</asp:ListItem>
                                                                                                    <asp:ListItem>Equivocal</asp:ListItem>
                                                                                                </asp:DropDownList>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td colspan="2">
                                                                                <asp:Panel ID="pn4072" runat="server" Enabled="false">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td width="17%">
                                                                                                <label>
                                                                                                    Anti TB IgA</label>
                                                                                            </td>
                                                                                            <td width="19%">
                                                                                                <asp:TextBox ID="t4072" runat="server" CssClass="textbox_hemat" onbeforepaste="BeforePaste_Event()"
                                                                                                         onkeypress="return ValidateOnlyNumeric(this);"    onPaste="Paste_Event()"></asp:TextBox>
                                                                                            </td>
                                                                                            <td width="64%">
                                                                                                <asp:DropDownList ID="dd4072" runat="server">
                                                                                                    <asp:ListItem>Positive</asp:ListItem>
                                                                                                    <asp:ListItem>Negative</asp:ListItem>
                                                                                                    <asp:ListItem>Equivocal</asp:ListItem>
                                                                                                </asp:DropDownList>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="4">
                                                                <a href="javascript:animatedcollapse.toggle('d4073')" id="a4073" runat="server" visible="false">
                                                                    <span class="label_collapse">Cytology</span></a>
                                                                <div id="d4073" style="display: none; padding-left: 20px">
                                                                    <table width="50%">
                                                                        <tr>
                                                                            <td colspan="2">
                                                                                <asp:Panel ID="pn4074" runat="server" Enabled="false">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td width="40%">
                                                                                                <label>
                                                                                                    Epithelial Cells</label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:RadioButtonList ID="r4074" runat="server" CssClass="defaultfontcolor" RepeatDirection="Horizontal">
                                                                                                    <asp:ListItem>Absent</asp:ListItem>
                                                                                                    <asp:ListItem>Present</asp:ListItem>
                                                                                                </asp:RadioButtonList>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td colspan="2">
                                                                                <asp:Panel ID="pn4075" runat="server" Enabled="false">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td width="40%">
                                                                                                <label>
                                                                                                    Malignant Cells</label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:RadioButtonList ID="r4075" runat="server" CssClass="defaultfontcolor" onclick="showMalignant()"
                                                                                                    RepeatDirection="Horizontal">
                                                                                                    <asp:ListItem>Absent</asp:ListItem>
                                                                                                    <asp:ListItem>Present</asp:ListItem>
                                                                                                </asp:RadioButtonList>
                                                                                                <div id="divMalignant" style="display: none">
                                                                                                    <asp:DropDownList ID="dd4075" runat="server" CssClass="dropdownbutton">
                                                                                                        <asp:ListItem>Ademocarcinoma</asp:ListItem>
                                                                                                        <asp:ListItem>Squarous Carcintina</asp:ListItem>
                                                                                                        <asp:ListItem>Epithelioma</asp:ListItem>
                                                                                                        <asp:ListItem>Mesothelioma</asp:ListItem>
                                                                                                        <asp:ListItem>Malanoma</asp:ListItem>
                                                                                                    </asp:DropDownList>
                                                                                                </div>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td colspan="2">
                                                                                <asp:Panel ID="pn4076" runat="server" Enabled="false">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td width="40%">
                                                                                                <label>
                                                                                                    Normal Cells</label>
                                                                                            </td>
                                                                                            <td colspan="2">
                                                                                                <asp:RadioButtonList ID="r4076" runat="server" CssClass="defaultfontcolor" RepeatDirection="Horizontal">
                                                                                                    <asp:ListItem>Absent</asp:ListItem>
                                                                                                    <asp:ListItem>Present</asp:ListItem>
                                                                                                </asp:RadioButtonList>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="4">
                                                                <a href="javascript:animatedcollapse.toggle('d4078')" id="a4078" runat="server" visible="false">
                                                                    <span class="label_collapse">Sputum</span></a>
                                                                <div id="d4078" style="display: none; padding-left: 20px">
                                                                    <table width="50%">
                                                                        <tr>
                                                                            <td>
                                                                                <asp:Panel runat="server" ID="pn4080" Enabled="false">
                                                                                    <table>
                                                                                        <tr>
                                                                                            <td>
                                                                                                <label>
                                                                                                    AFB Gram's Stain</label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:DropDownList runat="server" ID="dd4080">
                                                                                                    <asp:ListItem>Positive</asp:ListItem>
                                                                                                    <asp:ListItem>Negative</asp:ListItem>
                                                                                                </asp:DropDownList>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:Panel runat="server" ID="pn4081" Enabled="false">
                                                                                    <table>
                                                                                        <tr>
                                                                                            <td>
                                                                                                <label>
                                                                                                    KOH Mount</label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:DropDownList runat="server" ID="dd4081">
                                                                                                    <asp:ListItem>Positive</asp:ListItem>
                                                                                                    <asp:ListItem>Negative</asp:ListItem>
                                                                                                </asp:DropDownList>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <a href="javascript:animatedcollapse.toggle('d4082')" id="a4082" runat="server" visible="false">
                                                    <span class="label_collapse">Serology</span></a>
                                                <div id="d4082" style="width: 100%; display: none; padding-left: 20px">
                                                    <table>
                                                        <tr>
                                                            <td colspan="3">
                                                                <a id="a4083" runat="server" href="javascript:animatedcollapse.toggle('d4083')" visible="false">
                                                                    <span class="label_collapse">HIV</span></a>
                                                                <div id="d4083" style="display: none; padding-left: 20px;">
                                                                    <table>
                                                                        <tr>
                                                                            <td colspan="2">
                                                                                <asp:Panel ID="pn4084" runat="server" Enabled="false">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td>
                                                                                                <label>
                                                                                                    HIV<sub>1</sub></label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:DropDownList ID="dd4084" runat="server" CssClass="dropdownbutton">
                                                                                                    <asp:ListItem>ELISA</asp:ListItem>
                                                                                                    <asp:ListItem>Western Blot</asp:ListItem>
                                                                                                </asp:DropDownList>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:DropDownList ID="dd14084" runat="server" CssClass="dropdownbutton">
                                                                                                    <asp:ListItem>Negative</asp:ListItem>
                                                                                                    <asp:ListItem>Positive</asp:ListItem>
                                                                                                </asp:DropDownList>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td colspan="2">
                                                                                <asp:Panel ID="pn4085" runat="server" Enabled="false">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td>
                                                                                                <label>
                                                                                                    HIV<sub>2</sub></label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:DropDownList ID="dd4085" runat="server" CssClass="dropdownbutton">
                                                                                                    <asp:ListItem>ELISA</asp:ListItem>
                                                                                                    <asp:ListItem>Western Blot</asp:ListItem>
                                                                                                </asp:DropDownList>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:DropDownList ID="dd14085" runat="server" CssClass="dropdownbutton">
                                                                                                    <asp:ListItem>Negative</asp:ListItem>
                                                                                                    <asp:ListItem>Positive</asp:ListItem>
                                                                                                </asp:DropDownList>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="3">
                                                                <asp:Panel ID="pn4086" runat="server" Enabled="false">
                                                                    <table width="50%">
                                                                        <tr>
                                                                            <td>
                                                                                <label>
                                                                                    Hepatitis Virus</label>
                                                                            </td>
                                                                            <td>
                                                                                <asp:RadioButtonList ID="r4086" runat="server" CssClass="defaultfontcolor" onclick="loadHepatitis()"
                                                                                    RepeatDirection="Horizontal">
                                                                                    <asp:ListItem>Absent</asp:ListItem>
                                                                                    <asp:ListItem>Present</asp:ListItem>
                                                                                </asp:RadioButtonList>
                                                                            </td>
                                                                            <td>
                                                                                &nbsp;
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </asp:Panel>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="3">
                                                                <asp:Panel ID="pn4126" runat="server" Enabled="true">
                                                                    <div id="divHepat" style="display: none; padding-left: 20px">
                                                                        <table>
                                                                            <tr>
                                                                                <td>
                                                                                    <table>
                                                                                        <tr>
                                                                                            <td>
                                                                                                <asp:Panel ID="pn4127" runat="server" Enabled="false">
                                                                                                    <asp:CheckBox ID="c4127" runat="server" CssClass="defaultfontcolor" Text="HBsAg" />
                                                                                                </asp:Panel>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:Panel ID="pn4128" runat="server" Enabled="false">
                                                                                                    <asp:CheckBox ID="c4128" runat="server" CssClass="defaultfontcolor" Text="Anti HBs" />
                                                                                                </asp:Panel>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:Panel ID="pn4129" runat="server" Enabled="false">
                                                                                                    <asp:CheckBox ID="c4129" runat="server" CssClass="defaultfontcolor" Text="HCV" />
                                                                                                </asp:Panel>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td>
                                                                                    <table>
                                                                                        <tr>
                                                                                            <td>
                                                                                                <asp:Panel ID="pn4130" runat="server" Enabled="false">
                                                                                                    <asp:CheckBox ID="c4130" runat="server" CssClass="defaultfontcolor" Text="HBeAg" />
                                                                                                </asp:Panel>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:Panel ID="pn4131" runat="server" Enabled="false">
                                                                                                    <asp:CheckBox ID="c4131" runat="server" CssClass="defaultfontcolor" Text="Anti HBe" />
                                                                                                </asp:Panel>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:Panel ID="pn4132" runat="server" Enabled="false">
                                                                                                    <asp:CheckBox ID="c4132" runat="server" CssClass="defaultfontcolor" Text="HAV" />
                                                                                                </asp:Panel>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td>
                                                                                    <table>
                                                                                        <tr>
                                                                                            <td>
                                                                                                <asp:Panel ID="pn4133" runat="server" Enabled="false">
                                                                                                    <asp:CheckBox ID="c4133" runat="server" CssClass="defaultfontcolor" Text="HBcAg" />
                                                                                                </asp:Panel>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:Panel ID="pn4134" runat="server" Enabled="false">
                                                                                                    <asp:CheckBox ID="c4134" runat="server" CssClass="defaultfontcolor" Text="Anti HBc" />
                                                                                                </asp:Panel>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:Panel ID="pn4135" runat="server" Enabled="false">
                                                                                                    <asp:CheckBox ID="c4135" runat="server" CssClass="defaultfontcolor" Text="HEV" />
                                                                                                </asp:Panel>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </div>
                                                                </asp:Panel>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="3">
                                                                <table>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Panel ID="pn4087" runat="server" Enabled="false">
                                                                                <table>
                                                                                    <tr>
                                                                                        <td colspan="4">
                                                                                            <label id="Label106">
                                                                                                Leptospira IgG</label>
                                                                                        </td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td>
                                                                                            <asp:DropDownList ID="dd4087" runat="server" CssClass="dropdownbutton">
                                                                                                <asp:ListItem>Serum</asp:ListItem>
                                                                                                <asp:ListItem>Cerebro Spinal Fluid</asp:ListItem>
                                                                                                <asp:ListItem>Pleural Fluid</asp:ListItem>
                                                                                                <asp:ListItem>Ascitic Fluid</asp:ListItem>
                                                                                                <asp:ListItem>Percardial Fluid</asp:ListItem>
                                                                                                <asp:ListItem>Joint Fluid Knee</asp:ListItem>
                                                                                                <asp:ListItem>Joint Fluid Elbow</asp:ListItem>
                                                                                                <asp:ListItem>Joint Fluid Shoulder</asp:ListItem>
                                                                                                <asp:ListItem>Hydrocode Fluid</asp:ListItem>
                                                                                                <asp:ListItem>Fluid from Syst</asp:ListItem>
                                                                                            </asp:DropDownList>
                                                                                        </td>
                                                                                        <td>
                                                                                            <asp:DropDownList ID="dd14087" runat="server" CssClass="dropdownbutton">
                                                                                                <asp:ListItem>ELISA</asp:ListItem>
                                                                                                <asp:ListItem>Latex Agglutination</asp:ListItem>
                                                                                                <asp:ListItem>Chemiluminescence Immunoassay</asp:ListItem>
                                                                                                <asp:ListItem>DNA Amplification</asp:ListItem>
                                                                                                <asp:ListItem>Viral Culture</asp:ListItem>
                                                                                            </asp:DropDownList>
                                                                                        </td>
                                                                                        <td>
                                                                                            <asp:DropDownList ID="dd24087" runat="server" CssClass="dropdownbutton" onchange="ShowRubella()">
                                                                                                <asp:ListItem>Select</asp:ListItem>
                                                                                                <asp:ListItem>Quantitative</asp:ListItem>
                                                                                                <asp:ListItem>Qualitative</asp:ListItem>
                                                                                            </asp:DropDownList>
                                                                                        </td>
                                                                                        <td>
                                                                                            <div id="div4" style="display: none">
                                                                                                <asp:TextBox ID="t4087" runat="server" CssClass="textbox_hemat"></asp:TextBox>
                                                                                                <label>
                                                                                                    Iu/ml</label>
                                                                                            </div>
                                                                                        </td>
                                                                                        <td>
                                                                                            <div id="div5" style="display: none">
                                                                                                <asp:DropDownList ID="dd34087" runat="server" CssClass="dropdownbutton">
                                                                                                    <asp:ListItem>Positive</asp:ListItem>
                                                                                                    <asp:ListItem>Negative</asp:ListItem>
                                                                                                    <asp:ListItem>Equivocal</asp:ListItem>
                                                                                                </asp:DropDownList>
                                                                                            </div>
                                                                                        </td>
                                                                                    </tr>
                                                                                </table>
                                                                            </asp:Panel>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Panel ID="pn4088" runat="server" Enabled="false">
                                                                                <table>
                                                                                    <tr>
                                                                                        <td colspan="4">
                                                                                            <label id="Label107">
                                                                                                Leptospira IgM</label>
                                                                                        </td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td>
                                                                                            <asp:DropDownList ID="dd4088" runat="server" CssClass="dropdownbutton">
                                                                                                <asp:ListItem>Serum</asp:ListItem>
                                                                                                <asp:ListItem>Cerebro Spinal Fluid</asp:ListItem>
                                                                                                <asp:ListItem>Pleural Fluid</asp:ListItem>
                                                                                                <asp:ListItem>Ascitic Fluid</asp:ListItem>
                                                                                                <asp:ListItem>Percardial Fluid</asp:ListItem>
                                                                                                <asp:ListItem>Joint Fluid Knee</asp:ListItem>
                                                                                                <asp:ListItem>Joint Fluid Elbow</asp:ListItem>
                                                                                                <asp:ListItem>Joint Fluid Shoulder</asp:ListItem>
                                                                                                <asp:ListItem>Hydrocode Fluid</asp:ListItem>
                                                                                                <asp:ListItem>Fluid from Syst</asp:ListItem>
                                                                                            </asp:DropDownList>
                                                                                        </td>
                                                                                        <td>
                                                                                            <asp:DropDownList ID="dd14088" runat="server" CssClass="dropdownbutton">
                                                                                                <asp:ListItem>ELISA</asp:ListItem>
                                                                                                <asp:ListItem>Latex Agglutination</asp:ListItem>
                                                                                                <asp:ListItem>Chemiluminescence Immunoassay</asp:ListItem>
                                                                                                <asp:ListItem>DNA Amplification</asp:ListItem>
                                                                                                <asp:ListItem>Viral Culture</asp:ListItem>
                                                                                            </asp:DropDownList>
                                                                                        </td>
                                                                                        <td>
                                                                                            <asp:DropDownList ID="dd24088" runat="server" CssClass="dropdownbutton" onchange="ShowRubella()">
                                                                                                <asp:ListItem>Select</asp:ListItem>
                                                                                                <asp:ListItem>Quantitative</asp:ListItem>
                                                                                                <asp:ListItem>Qualitative</asp:ListItem>
                                                                                            </asp:DropDownList>
                                                                                        </td>
                                                                                        <td>
                                                                                            <div id="div6" style="display: none">
                                                                                                <asp:TextBox ID="t4088" runat="server" CssClass="textbox_hemat"></asp:TextBox>
                                                                                                <label>
                                                                                                    Iu/ml</label>
                                                                                            </div>
                                                                                        </td>
                                                                                        <td>
                                                                                            <div id="div7" style="display: none">
                                                                                                <asp:DropDownList ID="dd34088" runat="server" CssClass="dropdownbutton">
                                                                                                    <asp:ListItem>Positive</asp:ListItem>
                                                                                                    <asp:ListItem>Negative</asp:ListItem>
                                                                                                    <asp:ListItem>Equivocal</asp:ListItem>
                                                                                                </asp:DropDownList>
                                                                                            </div>
                                                                                        </td>
                                                                                    </tr>
                                                                                </table>
                                                                            </asp:Panel>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="2">
                                                                <asp:Panel ID="pn4089" runat="server" Enabled="false">
                                                                    <table width="100%">
                                                                        <tr>
                                                                            <td width="30%">
                                                                                <label>
                                                                                    VDRL</label>
                                                                            </td>
                                                                            <td width="15%">
                                                                                <asp:DropDownList ID="dd4089" runat="server">
                                                                                    <asp:ListItem>Negative</asp:ListItem>
                                                                                    <asp:ListItem>Positive</asp:ListItem>
                                                                                </asp:DropDownList>
                                                                            </td>
                                                                            <td>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </asp:Panel>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="2">
                                                                <asp:Panel ID="pn4090" runat="server" Enabled="false">
                                                                    <table width="100%">
                                                                        <tr>
                                                                            <td width="30%">
                                                                                <label>
                                                                                    Rheumatoid Factor</label>
                                                                            </td>
                                                                            <td width="15%">
                                                                                <asp:DropDownList ID="dd4090" runat="server" CssClass="dropdownbutton">
                                                                                    <asp:ListItem>Negative</asp:ListItem>
                                                                                    <asp:ListItem>Positive</asp:ListItem>
                                                                                </asp:DropDownList>
                                                                            </td>
                                                                            <td colspan="2">
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </asp:Panel>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="2">
                                                                <asp:Panel ID="pn4091" runat="server" Enabled="false">
                                                                    <table width="100%">
                                                                        <tr>
                                                                            <td width="30%">
                                                                                <label>
                                                                                    ASO</label>
                                                                            </td>
                                                                            <td width="15%">
                                                                                <asp:DropDownList ID="dd4091" runat="server" CssClass="dropdownbutton">
                                                                                    <asp:ListItem>Negative</asp:ListItem>
                                                                                    <asp:ListItem>Positive</asp:ListItem>
                                                                                </asp:DropDownList>
                                                                            </td>
                                                                            <td width="55%">
                                                                                <asp:DropDownList ID="dd14091" runat="server" CssClass="dropdownbutton">
                                                                                    <asp:ListItem>1:40</asp:ListItem>
                                                                                    <asp:ListItem>1:80</asp:ListItem>
                                                                                    <asp:ListItem>1:100</asp:ListItem>
                                                                                </asp:DropDownList>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </asp:Panel>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="2">
                                                                <asp:Panel ID="pn4092" runat="server" Enabled="false">
                                                                    <table width="100%">
                                                                        <tr>
                                                                            <td width="30%">
                                                                                <label>
                                                                                    TPHA</label>
                                                                            </td>
                                                                            <td width="15%">
                                                                                <asp:DropDownList ID="dd4092" runat="server" CssClass="dropdownbutton">
                                                                                    <asp:ListItem>Serum</asp:ListItem>
                                                                                    <asp:ListItem>Fluid</asp:ListItem>
                                                                                </asp:DropDownList>
                                                                            </td>
                                                                            <td width="12%">
                                                                                <asp:DropDownList ID="dd14092" runat="server" CssClass="dropdownbutton">
                                                                                    <asp:ListItem>ELISA</asp:ListItem>
                                                                                    <asp:ListItem>PCR</asp:ListItem>
                                                                                </asp:DropDownList>
                                                                            </td>
                                                                            <td width="43%">
                                                                                <asp:DropDownList ID="dd24092" runat="server" CssClass="dropdownbutton">
                                                                                    <asp:ListItem>Positive</asp:ListItem>
                                                                                    <asp:ListItem>Negative</asp:ListItem>
                                                                                    <asp:ListItem>Equivocal</asp:ListItem>
                                                                                </asp:DropDownList>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </asp:Panel>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="3">
                                                                <a href="javascript:animatedcollapse.toggle('d4093')" id="a4093" runat='server' visible="false">
                                                                    <span class="label_collapse">Widal</span></a>
                                                                <div id="d4093" style="display: none; padding-left: 20px">
                                                                    <asp:Panel ID="pn4094" runat="server" Enabled="false">
                                                                        <table width="70%">
                                                                            <tr>
                                                                                <td width="29%">
                                                                                    <label>
                                                                                        Type</label>
                                                                                </td>
                                                                                <td width="20%">
                                                                                    <label>
                                                                                        Dilution</label>
                                                                                </td>
                                                                                <td width="51%">
                                                                                    <label>
                                                                                        Result</label>
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td colspan="3">
                                                                                    <asp:Panel ID="pn4121" runat="server" Enabled="false">
                                                                                        <table width="70%">
                                                                                            <tr>
                                                                                                <td width="40%">
                                                                                                    <asp:Label ID="l4121" runat="server" Text="Typhi'H'"></asp:Label>
                                                                                                </td>
                                                                                                <td>
                                                                                                    <asp:DropDownList ID="dd4121" runat="server" CssClass="dropdownbutton">
                                                                                                        <asp:ListItem>1:20</asp:ListItem>
                                                                                                        <asp:ListItem>1:50</asp:ListItem>
                                                                                                        <asp:ListItem>1:100</asp:ListItem>
                                                                                                        <asp:ListItem>1:200</asp:ListItem>
                                                                                                        <asp:ListItem>1:500</asp:ListItem>
                                                                                                    </asp:DropDownList>
                                                                                                </td>
                                                                                                <td>
                                                                                                    <asp:DropDownList ID="dd14121" runat="server" CssClass="dropdownbutton">
                                                                                                        <asp:ListItem>Positive</asp:ListItem>
                                                                                                        <asp:ListItem>Negative</asp:ListItem>
                                                                                                    </asp:DropDownList>
                                                                                                </td>
                                                                                            </tr>
                                                                                        </table>
                                                                                    </asp:Panel>
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td colspan="3">
                                                                                    <asp:Panel ID="pn4122" runat="server" Enabled="false">
                                                                                        <table width="70%">
                                                                                            <tr>
                                                                                                <td width="40%">
                                                                                                    <asp:Label ID="l4122" runat="server" Text="Typhi'O'"></asp:Label>
                                                                                                </td>
                                                                                                <td>
                                                                                                    <asp:DropDownList ID="dd4122" runat="server" CssClass="dropdownbutton">
                                                                                                        <asp:ListItem>1:20</asp:ListItem>
                                                                                                        <asp:ListItem>1:50</asp:ListItem>
                                                                                                        <asp:ListItem>1:100</asp:ListItem>
                                                                                                        <asp:ListItem>1:200</asp:ListItem>
                                                                                                        <asp:ListItem>1:500</asp:ListItem>
                                                                                                    </asp:DropDownList>
                                                                                                </td>
                                                                                                <td>
                                                                                                    <asp:DropDownList ID="dd14122" runat="server" CssClass="dropdownbutton">
                                                                                                        <asp:ListItem>Positive</asp:ListItem>
                                                                                                        <asp:ListItem>Negative</asp:ListItem>
                                                                                                    </asp:DropDownList>
                                                                                                </td>
                                                                                            </tr>
                                                                                        </table>
                                                                                    </asp:Panel>
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td colspan="3">
                                                                                    <asp:Panel ID="pn4123" runat="server" Enabled="false">
                                                                                        <table width="70%">
                                                                                            <tr>
                                                                                                <td width="40%">
                                                                                                    <asp:Label ID="l4123" runat="server" Text="Paratyphi 'H'"></asp:Label>
                                                                                                </td>
                                                                                                <td>
                                                                                                    <asp:DropDownList ID="dd4123" runat="server" CssClass="dropdownbutton">
                                                                                                        <asp:ListItem>1:20</asp:ListItem>
                                                                                                        <asp:ListItem>1:50</asp:ListItem>
                                                                                                        <asp:ListItem>1:100</asp:ListItem>
                                                                                                        <asp:ListItem>1:200</asp:ListItem>
                                                                                                        <asp:ListItem>1:500</asp:ListItem>
                                                                                                    </asp:DropDownList>
                                                                                                </td>
                                                                                                <td>
                                                                                                    <asp:DropDownList ID="dd14123" runat="server" CssClass="dropdownbutton">
                                                                                                        <asp:ListItem>Positive</asp:ListItem>
                                                                                                        <asp:ListItem>Negative</asp:ListItem>
                                                                                                    </asp:DropDownList>
                                                                                                </td>
                                                                                            </tr>
                                                                                        </table>
                                                                                    </asp:Panel>
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td colspan="3">
                                                                                    <asp:Panel ID="pn4124" runat="server" Enabled="false">
                                                                                        <table width="70%">
                                                                                            <tr>
                                                                                                <td width="40%">
                                                                                                    <asp:Label ID="l4124" runat="server" Text="Paratyphi 'O'"></asp:Label>
                                                                                                </td>
                                                                                                <td>
                                                                                                    <asp:DropDownList ID="dd4124" runat="server" CssClass="dropdownbutton">
                                                                                                        <asp:ListItem>1:20</asp:ListItem>
                                                                                                        <asp:ListItem>1:50</asp:ListItem>
                                                                                                        <asp:ListItem>1:100</asp:ListItem>
                                                                                                        <asp:ListItem>1:200</asp:ListItem>
                                                                                                        <asp:ListItem>1:500</asp:ListItem>
                                                                                                    </asp:DropDownList>
                                                                                                </td>
                                                                                                <td>
                                                                                                    <asp:DropDownList ID="dd14124" runat="server" CssClass="dropdownbutton">
                                                                                                        <asp:ListItem>Positive</asp:ListItem>
                                                                                                        <asp:ListItem>Negative</asp:ListItem>
                                                                                                    </asp:DropDownList>
                                                                                                </td>
                                                                                            </tr>
                                                                                        </table>
                                                                                    </asp:Panel>
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </asp:Panel>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="3">
                                                                <a id="a4096" runat="server" href="javascript:animatedcollapse.toggle('d4096')" visible="false">
                                                                    <span class="label_collapse">Collagen Vascular</span></a>
                                                                <div id="d4096" style="display: none; padding-left: 20px">
                                                                    <table width="60%">
                                                                        <tr>
                                                                            <td>
                                                                                <asp:Panel ID="pn4097" runat="server" Enabled="false">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td width="30%">
                                                                                                <label>
                                                                                                    ANA</label>
                                                                                            </td>
                                                                                            <td width="12%">
                                                                                                <asp:DropDownList ID="dd4097" runat="server" CssClass="dropdownbutton">
                                                                                                    <asp:ListItem>Positive</asp:ListItem>
                                                                                                    <asp:ListItem>Negative</asp:ListItem>
                                                                                                </asp:DropDownList>
                                                                                            </td>
                                                                                            <td width="58%">
                                                                                                <div id="divSeroCollagen1">
                                                                                                    <table>
                                                                                                        <tr>
                                                                                                            <td>
                                                                                                                <asp:DropDownList ID="dd14097" runat="server" CssClass="dropdownbutton">
                                                                                                                    <asp:ListItem>1+</asp:ListItem>
                                                                                                                    <asp:ListItem>2+</asp:ListItem>
                                                                                                                    <asp:ListItem>3+</asp:ListItem>
                                                                                                                    <asp:ListItem>4+</asp:ListItem>
                                                                                                                </asp:DropDownList>
                                                                                                            </td>
                                                                                                            <td>
                                                                                                                <asp:DropDownList ID="dd24097" runat="server" CssClass="dropdownbutton">
                                                                                                                    <asp:ListItem>1:20</asp:ListItem>
                                                                                                                    <asp:ListItem>1:40</asp:ListItem>
                                                                                                                    <asp:ListItem>1:80</asp:ListItem>
                                                                                                                    <asp:ListItem>1:100</asp:ListItem>
                                                                                                                </asp:DropDownList>
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
                                                                        <tr>
                                                                            <td>
                                                                                <asp:Panel ID="pn4098" runat="server" Enabled="false">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td width="30%">
                                                                                                <label>
                                                                                                    dsDNA</label>
                                                                                            </td>
                                                                                            <td colspan="2">
                                                                                                <asp:DropDownList ID="dd4098" runat="server" CssClass="dropdownbutton">
                                                                                                    <asp:ListItem>Positive</asp:ListItem>
                                                                                                    <asp:ListItem>Negative</asp:ListItem>
                                                                                                </asp:DropDownList>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td colspan="3">
                                                                                <a id="a4099" runat="server" href="javascript:animatedcollapse.toggle('d4099')" visible="false">
                                                                                    <span class="label_collapse">ANCA</span></a>
                                                                                <div id="d4099" style="display: none; padding-left: 20px">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td>
                                                                                                <asp:Panel ID="pn4100" runat="server" Enabled="false">
                                                                                                    <table width="100%">
                                                                                                        <tr>
                                                                                                            <td width="27%">
                                                                                                                <label>
                                                                                                                    Cytoplasmic</label>
                                                                                                            </td>
                                                                                                            <td width="73%">
                                                                                                                <asp:DropDownList ID="dd4100" runat="server" CssClass="dropdownbutton">
                                                                                                                    <asp:ListItem>Positive</asp:ListItem>
                                                                                                                    <asp:ListItem>Negative</asp:ListItem>
                                                                                                                </asp:DropDownList>
                                                                                                            </td>
                                                                                                        </tr>
                                                                                                    </table>
                                                                                                </asp:Panel>
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td>
                                                                                                <asp:Panel ID="pn4101" runat="server" Enabled="false">
                                                                                                    <table width="100%">
                                                                                                        <tr>
                                                                                                            <td width="27%">
                                                                                                                <label>
                                                                                                                    Perinuclear</label>
                                                                                                            </td>
                                                                                                            <td width="73%">
                                                                                                                <asp:DropDownList ID="dd4101" runat="server" CssClass="dropdownbutton">
                                                                                                                    <asp:ListItem>+</asp:ListItem>
                                                                                                                    <asp:ListItem>-</asp:ListItem>
                                                                                                                </asp:DropDownList>
                                                                                                            </td>
                                                                                                        </tr>
                                                                                                    </table>
                                                                                                </asp:Panel>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </div>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <a href="javascript:animatedcollapse.toggle('d4102')" id="a4102" runat="server" visible="false">
                                                    <span class="label_collapse">Semen Analysis</span></a>
                                                <div id="d4102" style="width: 100%; display: none; padding-left: 20px">
                                                    <table width="90%">
                                                        <tr>
                                                            <td>
                                                                <a href="javascript:animatedcollapse.toggle('d4103')" id="a4103" runat='server' visible="false">
                                                                    <span class="label_collapse">Macroscropic Examination</span></a>
                                                                <div id="d4103" style="width: 100%; display: none; padding-left: 20px">
                                                                    <table width="70%">
                                                                        <tr>
                                                                            <td colspan="2">
                                                                                <asp:Panel ID="pn4104" runat="server" Enabled="false">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td width="30%">
                                                                                                <label>
                                                                                                    Color</label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:DropDownList ID="dd4104" runat="server" CssClass="dropdownbutton">
                                                                                                    <asp:ListItem>White</asp:ListItem>
                                                                                                    <asp:ListItem>Yellow</asp:ListItem>
                                                                                                </asp:DropDownList>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                            <td width="54%" colspan="2">
                                                                                <asp:Panel ID="pn4105" runat="server" Enabled="false">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td width="30%">
                                                                                                <label>
                                                                                                    Reaction</label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:DropDownList ID="dd4105" runat="server" CssClass="dropdownbutton">
                                                                                                    <asp:ListItem>Alkaline</asp:ListItem>
                                                                                                    <asp:ListItem>Neutral</asp:ListItem>
                                                                                                    <asp:ListItem>Acidic</asp:ListItem>
                                                                                                </asp:DropDownList>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td colspan="2">
                                                                                <asp:Panel ID="pn4106" runat="server" Enabled="false">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td width="30%">
                                                                                                <label>
                                                                                                    Volume</label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:TextBox CssClass="textbox_hemat" ID="t4106" runat="server">                                                                    </asp:TextBox>
                                                                                                <label>
                                                                                                    cc</label>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                            <td colspan="2">
                                                                                <asp:Panel ID="pn4107" runat="server" Enabled="false">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td width="30%">
                                                                                                <label>
                                                                                                    Viscosity</label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:DropDownList ID="dd4107" runat="server" CssClass="dropdownbutton">
                                                                                                    <asp:ListItem>Normal</asp:ListItem>
                                                                                                    <asp:ListItem>Low</asp:ListItem>
                                                                                                    <asp:ListItem>High</asp:ListItem>
                                                                                                </asp:DropDownList>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td colspan="2">
                                                                                <asp:Panel ID="pn4108" runat="server" Enabled="false">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td width="30%">
                                                                                                <label>
                                                                                                    Liquification</label>
                                                                                            </td>
                                                                                            <td colspan="3">
                                                                                                <asp:TextBox CssClass="textbox_hemat" ID="t4108" runat="server">                                                                    </asp:TextBox>
                                                                                                <label>
                                                                                                    min</label>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <a href="javascript:animatedcollapse.toggle('d4109')" id="a4109" runat='server' visible="false">
                                                                    <span class="label_collapse">Microscropic Examination</span></a>
                                                                <div id="d4109" style="width: 100%; display: none; padding-left: 20px">
                                                                    <table width="100%" border="0">
                                                                        <tr>
                                                                            <td colspan="2">
                                                                                <asp:Panel ID="pn4110" runat="server" Enabled="false">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td width="14%">
                                                                                                <label>
                                                                                                    Total Count</label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:TextBox CssClass="textbox_hemat" ID="t4110" runat="server">                                                                    </asp:TextBox>
                                                                                                <label>
                                                                                                    million/cmm</label>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td colspan="3">
                                                                                <a href="javascript:animatedcollapse.toggle('d4111')" id="a4111" runat="server" visible="false">
                                                                                    <span class="label_collapse">Motility</span></a>
                                                                                <div id="d4111" style="width: 100%; display: block; padding-left: 20px">
                                                                                    <table width="70%" border="0">
                                                                                        <tr>
                                                                                            <td colspan="2">
                                                                                                <asp:Panel ID="pn4112" runat="server" Enabled="false">
                                                                                                    <table width="100%">
                                                                                                        <tr>
                                                                                                            <td width="30%">
                                                                                                                <label>
                                                                                                                    Active</label>
                                                                                                            </td>
                                                                                                            <td>
                                                                                                                <asp:TextBox CssClass="textbox_hemat" ID="t4112" runat="server">                                                                                    </asp:TextBox>
                                                                                                                <label>
                                                                                                                    %</label>
                                                                                                            </td>
                                                                                                        </tr>
                                                                                                    </table>
                                                                                                </asp:Panel>
                                                                                            </td>
                                                                                            <td width="55%" colspan="2">
                                                                                                <asp:Panel ID="pn4113" runat="server" Enabled="false">
                                                                                                    <table width="100%">
                                                                                                        <tr>
                                                                                                            <td>
                                                                                                                <label>
                                                                                                                    Sluggish</label>
                                                                                                            </td>
                                                                                                            <td>
                                                                                                                <asp:TextBox CssClass="textbox_hemat" ID="t4113" runat="server">                                                                                    </asp:TextBox>
                                                                                                                <label>
                                                                                                                    %</label>
                                                                                                            </td>
                                                                                                        </tr>
                                                                                                    </table>
                                                                                                </asp:Panel>
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td colspan="2">
                                                                                                <asp:Panel ID="pn4114" runat="server" Enabled="false">
                                                                                                    <table width="100%">
                                                                                                        <tr>
                                                                                                            <td width="30%">
                                                                                                                <label>
                                                                                                                    Very Sluggish</label>
                                                                                                            </td>
                                                                                                            <td>
                                                                                                                <asp:TextBox CssClass="textbox_hemat" ID="t4114" runat="server">                                                                                    </asp:TextBox>
                                                                                                                <label>
                                                                                                                    %</label>
                                                                                                            </td>
                                                                                                        </tr>
                                                                                                    </table>
                                                                                                </asp:Panel>
                                                                                            </td>
                                                                                            <td colspan="2">
                                                                                                <asp:Panel ID="pn4115" runat="server" Enabled="false">
                                                                                                    <table width="100%">
                                                                                                        <tr>
                                                                                                            <td>
                                                                                                                <label>
                                                                                                                    Immotile</label>
                                                                                                            </td>
                                                                                                            <td>
                                                                                                                <asp:TextBox CssClass="textbox_hemat" ID="t4115" runat="server">                                                                                    </asp:TextBox>
                                                                                                                <label>
                                                                                                                    %</label>
                                                                                                            </td>
                                                                                                        </tr>
                                                                                                    </table>
                                                                                                </asp:Panel>
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td colspan="2">
                                                                                                <asp:Panel ID="pn4116" runat="server" Enabled="false">
                                                                                                    <table width="100%">
                                                                                                        <tr>
                                                                                                            <td width="30%">
                                                                                                                <label>
                                                                                                                    Hypermotile</label>
                                                                                                            </td>
                                                                                                            <td>
                                                                                                                <asp:TextBox CssClass="textbox_hemat" ID="t4116" runat="server">                                                                                    </asp:TextBox>
                                                                                                                <label>
                                                                                                                    %</label>
                                                                                                            </td>
                                                                                                        </tr>
                                                                                                    </table>
                                                                                                </asp:Panel>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </div>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <a href="javascript:animatedcollapse.toggle('d4117')" id="a4117" runat="server" visible="false">
                                                                    <span class="label_collapse">Morphology</span></a>
                                                                <div id="d4117" style="width: 100%; display: none; padding-left: 20px">
                                                                    <table width="80%">
                                                                        <tr>
                                                                            <td colspan="2">
                                                                                <asp:Panel ID="pn4118" runat="server" Enabled="false">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td width="30%">
                                                                                                <label>
                                                                                                    Normal Sperm</label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:TextBox CssClass="textbox_hemat" ID="t4118" runat="server">                                                                    </asp:TextBox>
                                                                                                <label>
                                                                                                    %</label>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                            <td width="54%" colspan="2">
                                                                                <asp:Panel ID="pn4119" runat="server" Enabled="false">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td width="30%">
                                                                                                <label>
                                                                                                    Abnormal Sperm</label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:TextBox CssClass="textbox_hemat" ID="t4119" runat="server">                                                                    </asp:TextBox>
                                                                                                <label>
                                                                                                    %</label>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td colspan="2">
                                                                                <asp:Panel ID="pn4120" runat="server" Enabled="false">
                                                                                    <table width="100%">
                                                                                        <tr>
                                                                                            <td width="30%">
                                                                                                <label>
                                                                                                    Pus</label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:TextBox CssClass="textbox_hemat" ID="t4120" runat="server">                                                                    </asp:TextBox>
                                                                                                <label>
                                                                                                    HPF</label>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:UpdatePanel ID="UpdatePanel6" runat="server">
                                                    <ContentTemplate>
                                                        <table>
                                                            <tr>
                                                                <td>
                                                                    <asp:Button ID="btnSaveClinic" runat="server" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                                        onmouseout="this.className='btn'" OnClick="btnSaveClinic_Click" Text="Save" />
                                                                </td>
                                                                <td>
                                                                    <asp:Button ID="btnCancelClinic" runat="server" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                                        onmouseout="this.className='btn'" TabIndex="26" Text="Cancel" />
                                                                </td>
                                                                <td>
                                                                    <asp:Label runat="server" ID="lblMicroMsg" CssClass="errormsg"></asp:Label>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </ContentTemplate>
                                                </asp:UpdatePanel>
                                            </td>
                                        </tr>
                                    </table>
                                </ContentTemplate>
                            </Ajax:TabPanel>
                        </Ajax:TabContainer>
                    </div>
                </td>
            </tr>
        </table>
        <uc4:Footer ID="Footer1" runat="server" />
    </div>
    </form>
</body>
</html>
