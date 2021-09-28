<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PatientList.aspx.cs" Inherits="Inventory_PatientList" meta:resourcekey="PageResource1" %>

<%@ Register Src="../CommonControls/Theme.ascx" TagName="Theme" TagPrefix="t1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>

<script src="../Scripts/Common.js" language="javascript" type="text/javascript"></script>

<head runat="server">
    <title></title>

    <script language="javascript" type="text/javascript">
        function Setval(obj) {
            var x = obj.value.split('~');
            document.getElementById('hdnName').value = x[1];
            document.getElementById('hdnPatientNo').value = x[2];
            document.getElementById('hdnPatientID').value = x[0];
            document.getElementById('hdnStatus').value = x[4];
            document.getElementById('hdnTitle').value = x[3];

        }
        function nameValidate() {

            if (document.getElementById('hdnName').value == "" && document.getElementById('hdnPatientNo').value == "") {
                var userMsg = SListForApplicationMessages.Get('Reception\\PatientList.aspx_1');
                if (userMsg != null) {
                    alert(userMsg);
                } else {
                    alert('Select the patient');
                }
                return false;
            }
            else {
                if (document.getElementById('hdnStatus').value == "OP") {
                    var patientName = document.getElementById('hdnName').value;
                    var patientNumber = document.getElementById('hdnPatientNo').value;

                    window.opener.PatientsResult(patientName, patientNumber);
                    //                    window.opener.document.getElementById('txtPatientName').value = document.getElementById('hdnName').value;
                    //                    window.opener.document.getElementById('txtPatientNumber').value = document.getElementById('hdnPatientNo').value;
                    // 
                    //                    window.opener.document.getElementById('txtPatientName').readOnly = false;
                    //                    window.opener.document.getElementById('txtPatientNumber').readOnly = false ;
                    //                    window.opener.document.getElementById('ddSalutation').disabled = true;
                    window.close();
                    return true;
                }
                else {
                    var userMsg = SListForApplicationMessages.Get('Reception\\PatientList.aspx_2');
                    if (userMsg != null) {
                        alert(userMsg);
                    }
                    else { alert('This action cannot be performed for inpatients'); }
                    return false
                }
            }
        }
        function winClose() {

            window.close();
        }
        
        
    
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <div style="display: none;">
        <t1:Theme ID="Theme1" runat="server" />
    </div>
    <%--  <div class="dataone">--%>
    <div class="contentdatapopup">
        <table width="100%" border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td align="center">
                    <asp:ScriptManager ID="ScriptManager1" runat="server">
                    </asp:ScriptManager>
                    <br />
                    <br />
                    <asp:GridView ID="grdResult" Width="100%" runat="server" CellPadding="4" AutoGenerateColumns="False"
                        OnRowDataBound="grdResult_RowDataBound" DataKeyNames="PatientID" ForeColor="#333333"
                        CssClass="mytable1" meta:resourcekey="grdResultResource1">
                        <HeaderStyle CssClass="dataheader1" />
                        <Columns>
                            <asp:TemplateField ItemStyle-Width="2%" HeaderText="Select" 
                                HeaderStyle-HorizontalAlign="Left" meta:resourcekey="TemplateFieldResource1">
                                <ItemTemplate>
                                    <input id="rdSel" name="radio" runat="server" group="gp1" onclick="Setval(this)"
                                        type="radio" />
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                <ItemStyle Width="2%"></ItemStyle>
                            </asp:TemplateField>
                            <asp:BoundField DataField="Name" HeaderText="Patient Name" HeaderStyle-HorizontalAlign="left"
                                ItemStyle-Width="15%" ItemStyle-HorizontalAlign="Left" 
                                meta:resourcekey="BoundFieldResource1">
                                <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Left" Width="15%"></ItemStyle>
                            </asp:BoundField>
                            <asp:BoundField DataField="PatientNumber" HeaderText="Patient No" ItemStyle-Width="15%"
                                HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" 
                                meta:resourcekey="BoundFieldResource2">
                                <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Left" Width="15%"></ItemStyle>
                            </asp:BoundField>
                            <%--<asp:BoundField HeaderText="Mobile Number"  DataField="MobileNumber"  />--%>
                        </Columns>
                    </asp:GridView>
                </td>
            </tr>
            <tr>
                <td>
                    <br />
                </td>
            </tr>
            <tr>
                <td align="center">
                    <asp:Button ID="btnSearch" runat="server" Text="OK" CssClass="btn1" onmouseover="this.className='btn1 btnhov1'"
                        onmouseout="this.className='btn1'" Width="55px" 
                        OnClientClick="javascript:nameValidate();return false;" 
                        meta:resourcekey="btnSearchResource1" />
                    &nbsp;&nbsp;
                    <input type="hidden" id="hdnName" runat="server" />
                    <input type="hidden" id="hdnPatientNo" runat="server" />
                    <input type="hidden" id="hdnPatientID" runat="server" />
                    <input type="hidden" id="hdnStatus" runat="server" />
                    <input type="hidden" id="hdnTitle" runat="server" />
                    <a style="cursor: pointer; text-decoration: none; font-weight: bold; color: Blue;"
                        href="javascript:winClose();"><asp:Label ID="Rs_CloseWindow" 
                        Text="Close Window" runat="server" meta:resourcekey="Rs_CloseWindowResource1"></asp:Label> </a>
                </td>
            </tr>
            <tr>
                <td>
                    <br />
                </td>
            </tr>
        </table>
    </div>
    <%--</div>--%>
    <asp:HiddenField ID="hdnSelectedValues" runat="server" />
    </form>
</body>
</html>
