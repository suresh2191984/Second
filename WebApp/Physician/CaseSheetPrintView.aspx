<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CaseSheetPrintView.aspx.cs"
    Inherits="Physician_CaseSheetPrintView" meta:resourcekey="PageResource1" %>

<%@ Register Src="../CommonControls/PatientPrescription.ascx" TagName="PatientPrescription"
    TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc2" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Print CaseSheet</title>
   <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
    <script src="../Scripts/Common.js" type="text/javascript"></script>    
    <script type="text/javascript" language="javascript">
        function PrintMe() {
            window.parent.print();
        }
    </script>

</head>
<body onContextMenu="return false;">
    <form id="form1" runat="server" defaultbutton="btnPrint">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <table>
        <tr>
            <td align="left">
                <table>
                    <tr>
                        <td align="left">
                            <%--<asp:Literal ID="lblCS" runat="server"></asp:Literal>--%>
                            <uc2:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td class="defaultfontcolor">
                            <asp:Label ID="Rs_MEDICATIONTOBEFOLLOWED" Text="MEDICATION TO BE FOLLOWED" 
                                runat="server" meta:resourcekey="Rs_MEDICATIONTOBEFOLLOWEDResource1"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <uc1:PatientPrescription ID="PatientPrescription1" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td nowrap="nowrap">
                            <input type="button" id="btnPrint" value="Print" onclick="javascript:PrintMe();" class="btn" onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" />
                            <input type="button" value="Close" onclick="javascript:window.close();" class="btn" onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" />
                            <%--<input type="button" value="Home" runat="server" OnClick="btnHome_Click" class="btn" onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" />--%>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    </form>
</body>
</html>
