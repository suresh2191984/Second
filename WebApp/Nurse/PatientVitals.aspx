<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PatientVitals.aspx.cs" Inherits="PatientVitals"
    meta:resourcekey="PageResource1" %>

<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="~/CommonControls/PatientVitals.ascx" TagName="PatientVitalsControl"
    TagPrefix="uc2" %>
<%@ Register Src="~/CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="~/CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Patient Vitals</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
     <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
  <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script src="../Scripts/bid.js" type="text/javascript"></script>

    <script src="../Scripts/animatedcollapse.js" type="text/javascript"></script>

    <script src="../Scripts/jquery-1.2.2.pack.js" type="text/javascript"></script>

    <script src="../Scripts/datetimepicker.js" type="text/javascript"></script>

    <script src="../Scripts/MessageHandler.js" type="text/javascript"></script>

</head>
<body onload="pageLoadFocus('uctlPatientVitals_txtTemp')" oncontextmenu="return false;">
    <form id="frmPatientVitals" runat="server" defaultbutton="btnFinish">

    <script type="text/javascript" language="javascript">
        function PreSBPKeyPress() {
            var key = window.event.keyCode;
            if ((key != 16) && (key != 4) && (key != 9)) {
                var sVal = document.getElementById('uctlPatientVitals_txtSBP').value;
                var ctrlDBP = document.getElementById('uctlPatientVitals_txtDBP');
                if (sVal.length == 3) {
                    ctrlDBP.focus();
                }
            }
        }

        function checkSelection() {
            //             var ctl = document.getElementById('drpOption');
            //             var sVal = ctl.options[ctl.selectedIndex].value;
            ////             if (sVal == "-1") {
            ////                 alert("Select an option");
            ////                 ctl.focus();
            ////                 return false;
            ////             }
            //             return true;

            if (document.getElementById('ddlVitalsType').value == 0 && document.getElementById('hdnVistType').value == 1) {
            
            var userMsg = SListForApplicationMessages.Get('Nurse\\PatientVitals.aspx_2');
               if(userMsg !=null)
               {
               alert(userMsg);
               return false;
               }
               else{
                   alert('Select the vitals type');
                  return false;
                  }
            }
        }
    </script>

    <asp:ScriptManager ID="ScriptManager1" runat="server">
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
                <uc3:Header ID="NurseHeader" runat="server" />
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
                        <table cellpadding="0" cellspacing="0" width="100%" class="defaultfontcolor" align="center">
                            <tr>
                                <td align="center">
                                    <uc6:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                                </td>
                            </tr>
                            <tr id="trVType" style="display: none;" runat="server">
                                <td align="left" nowrap="nowrap">
                                    <asp:Label ID="Label1" runat="server" Text="Select A Type" meta:resourcekey="Label1Resource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlVitalsType" runat="server" CssClass="ddlsmall" TabIndex="10" meta:resourcekey="ddlVitalsTypeResource1">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td height="32" colspan="2" align="left">
                                    <uc2:PatientVitalsControl ID="uctlPatientVitals" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td align="left" nowrap="nowrap">
                                    <asp:Label ID="lblText" Text="Patient Condition" runat="server" meta:resourcekey="lblTextResource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddPatientCondition" runat="server"  CssClass ="ddlsmall" TabIndex="8" meta:resourcekey="ddPatientConditionResource1">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td align="left" nowrap="nowrap">
                                    <asp:Label ID="lblComments" Text="Comments" runat="server" meta:resourcekey="lblCommentsResource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox Rows="4" ID="txtComments" Columns="28" runat="server" MaxLength="1000"
                                        TextMode="MultiLine" TabIndex="9" meta:resourcekey="txtCommentsResource1"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <asp:Label ID="lblselect" runat="server" Text="Select Option to Perform" meta:resourcekey="lblselectResource1"></asp:Label>
                                    <asp:DropDownList ID="drpOption" runat="server" CssClass ="ddlsmall" TabIndex="10" meta:resourcekey="drpOptionResource1">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td>
                                </td>
                                <td>
                                    <asp:Button ID="btnFinish" runat="server" CssClass="btn" onmouseover="this.className='btn1 btnhov1'"
                                        onmouseout="this.className='btn1'" TabIndex="10" Text="Finish" OnClientClick='return checkSelection();'
                                        OnClick="btnFinish_Click" meta:resourcekey="btnFinishResource1" />
                                    <asp:Button ID="btnCancel" runat="server" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                        onmouseout="this.className='btn'" TabIndex="11" Text="Cancel" OnClick="btnCancel_Click"
                                        meta:resourcekey="btnCancelResource1" />
                                    <asp:HiddenField runat="server" ID="hdnVistType" />
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
        </table>
        <uc5:Footer ID="Footer1" runat="server" />
    </div>
    <asp:HiddenField ID="hdnMessages" runat="server" />
    </form>
</body>
</html>
