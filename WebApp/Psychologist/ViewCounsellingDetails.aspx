<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ViewCounsellingDetails.aspx.cs"
    Inherits="Psychologist_ViewCounsellingDetails" meta:resourcekey="PageResource1" %>

<%@ Register Src="../EMR/PrintExam.ascx" TagName="PrintExam" TagPrefix="uc1" %>
<%@ Register Src="../EMR/PrintHistory.ascx" TagName="PrintHistory" TagPrefix="uc2" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        body
        {
            background-position: top;
            background-repeat: repeat-x;
            background-color: #ADD6FF;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <div class="contentdata" id="divMain">
            <asp:Label ID="lblPrescription" CssClass="defaultfontcolorCaseSheet" 
                runat="server" meta:resourcekey="lblPrescriptionResource1"></asp:Label>
            <div id="printdiv">
                <table width="100%" id="tdCounsellingCaseShhet2" style="font-family: Tahoma;">
                    <tr style="width: 100">
                        <td width="100%" style="height: 50%;">
                            <asp:Label ID="lblCounselling" Text="coun" runat="server" 
                                meta:resourcekey="lblCounsellingResource1"></asp:Label>
                        </td>
                    </tr>
                </table>
                <table width="100%" style="font-family: Tahoma;">
                    <tr id="trreivew" runat="server" style="display: none;">
                        <td>
                            <asp:Label ID="lblReview" runat="server" meta:resourcekey="lblReviewResource1"></asp:Label>
                        </td>
                    </tr>
                </table>
                <table width="100%" style="font-family: Tahoma;">
                    <tr align="left">
                        <td id="tdExam" runat="server" style="display: none;">
                            <b><u>PSYCHIATRY EXAMINATION </u></b>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblExam" runat="server" meta:resourcekey="lblExamResource1"></asp:Label>
                        </td>
                    </tr>
                </table>
                <table width="100%" id="Table1" runat="server" style="font-family: Tahoma; display:none">
                    <tr>
                        <td>
                            <table width="100%" style="height: auto;">
                                <tr>
                                    <td>
                                        <uc2:PrintHistory ID="PrintHistory1" runat="server" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <uc1:PrintExam ID="PrintExam1" runat="server" />
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
    </form>
</body>
</html>
