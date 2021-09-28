<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PhysioCaseSheet.aspx.cs"
    Inherits="InPatient_PhysioCaseSheet" meta:resourcekey="PageResource1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/PatientHeader.ascx" TagName="PatientHeader" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/ComplaintICDCode.ascx" TagName="ComplaintICDCode"
    TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc9" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <script type="text/javascript">
        function PrintPhysio() {

            var prtContent = document.getElementById('printdiv');

            var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=1,status=0,Addressbar=no');
            WinPrint.document.write(prtContent.innerHTML);

            WinPrint.document.close();

            WinPrint.focus();

            WinPrint.print();
        }

        function ShowAll(chkBox) {
            if (chkBox.checked == true) {
                document.getElementById('tdCurrent').style.display = "none";
                document.getElementById('tdConsolidate').style.display = "block";
            }
            else {
                document.getElementById('tdCurrent').style.display = "block";
                document.getElementById('tdConsolidate').style.display = "none";
            }
        }
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="scm1" runat="server">
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
                <uc3:PatientHeader ID="patientHeader" runat="server" />
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
                    <div class="contentdata" id="divMain">
                        <ul>
                            <li>
                                <uc9:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                                <asp:Label ID="lblPrescription" CssClass="defaultfontcolorCaseSheet" 
                                    runat="server" meta:resourcekey="lblPrescriptionResource1"></asp:Label>
                            </li>
                        </ul>
                        <table width="100%">
                            <tr>
                                <td>
                                    <div id="printdiv">
                                        <table style="width: 100%;">
                                            <tr>
                                                <td id="tdCurrent" style="display:block;" runat="server">
                                                    <asp:Label ID="lblPhysio" runat="server" meta:resourcekey="lblPhysioResource1"></asp:Label>
                                                </td>
                                                <td id="tdConsolidate" style="display:none;" runat="server">
                                                    <asp:Label ID="lblConsolidate" runat="server"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td align="center">
                                    <asp:Button ID="btnHome" runat="server" Text="Ok" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                        onmouseout="this.className='btn'" OnClick="btnHome_Click" 
                                        meta:resourcekey="btnHomeResource1" />
                                    <input type="button" name="btnPrint" id="btnPrint" value="Print" class="btn" onclick="PrintPhysio()"
                                        runat="server" />
                                    <asp:Button ID="btnEdit" runat="server" Text="Edit" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                        onmouseout="this.className='btn'" OnClick="btnEdit_Click" 
                                        meta:resourcekey="btnEditResource1" />                                    
                                    <asp:Button ID="btnBack" runat="server" Text="Back" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                        onmouseout="this.className='btn'" OnClick="btnBack_Click" 
                                        meta:resourcekey="btnBackResource1" />
                                    <input type="checkbox" onclick="javascript:ShowAll(this);" visible="false" runat="server" id="chkShowAll" value="Show All" />
                                    <asp:Label ID="lblShowAll" Text="Consolidate Casesheet" runat="server"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
        </table>        
        <uc2:Footer ID="Footer" runat="server" />
    </div>
    </form>
</body>
</html>
