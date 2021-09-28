<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PatientViewReport.aspx.cs"
    Inherits="Patient_PatientViewReport" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader" TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>

    <script src="../Scripts/jquery-1.3.2.js" type="text/javascript"></script>

    <script src="../Scripts/datetimepicker_css.js" type="text/javascript"></script>

    <link type="text/css" href="../StyleSheets/jquery-ui-1.8.19.custom.css" rel="stylesheet" />

    <script type="text/javascript">
        function onClickLnkTRF(obj) {
            $('#trPDF').show();
            $('#ifPDF').attr('src', obj);
        }
        function ClosePopUp() {
            $find('modalPopUp').hide();
        }
        function DisabledEffect() {
            if (confirm("Are you sure you want to logout?")) {
                return true;
            }
            return;
        }
        function ClearSearchFields() {
            document.getElementById('txtVisitNumber').value = '';
            document.getElementById('txtPatientName').value = '';
            return false;

        }
        function RedirectToReport(ctrl) {
            var url = $(ctrl).attr('ReportUrl');
            if (url == null || url == "") {

                ValidationWindow("No Image Available", "Alert");
            }
            else
                window.open(url, '_blank');

            return false;
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
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
           <Attune:Attuneheader ID="Attuneheader" runat="server" />
                    <div class="contentdata">
                        
                        <table class="dataheaderInvCtrl w-100p searchPanel">
                            <tr>
                                <td rowspan="1" class="a-right w-10p">
                                    <span class="richcombobox w-75">
                                        <asp:Label ID="lblVisitnumber" runat="server" Text="Visit Number"></asp:Label>
                                    </span>
                                    <%--                                    <asp:Label ID="Rs_FromVisitNo"  Text="Visit No" runat="server" 
                                        meta:resourcekey="Rs_FromVisitNoResource1"></asp:Label>--%>
                                </td>
                                <td rowspan="1" class="w-20p">
                                    <asp:TextBox ID="txtVisitNumber" runat="server" CssClass="Txtboxsmall" Width="120px"></asp:TextBox>
                                </td>
                                <td rowspan="1" class="a-left w-8p">
                                    <asp:Label ID="lblPatientName" Text="Patient Name" runat="server"></asp:Label>
                                </td>
                                <td rowspan="1" class="w-17p">
                                    <asp:TextBox ID="txtPatientName" runat="server" CssClass="Txtboxsmall" Width="120px"></asp:TextBox>
                                </td>
                                <td rowspan="1" class="a-left w-8p">
                                    <asp:Label ID="lblStaus" Text="Status" runat="server"></asp:Label>
                                </td>
                                <td rowspan="1" class="w-20p">
                                    <span class="richcombobox">
                                        <asp:DropDownList CssClass="ddlsmall" ID="ddstatus"  runat="server">
                                            <asp:ListItem Text="Approved" Value="Approve"></asp:ListItem>
                                        </asp:DropDownList>
                                    </span>
                                </td>
                            </tr>
                            <tr>
                                <td rowspan="1" class="a-right w-10p">
                                    <span class="richcombobox w-75">
                                        <asp:Label ID="Rs_From" Text="From Date" runat="server"></asp:Label>
                                    </span>
                                </td>
                                <td>
                                    <table class="w-100p">
                                        <tr class="defaultfontcolor">
                                            <td rowspan="2">
                                                <asp:TextBox ID="txtFDate" CssClass="Txtboxsmall" Width="120px" runat="server" meta:resourcekey="txtFDateResource1"></asp:TextBox>
                                                <a href="javascript:NewCssCal('txtFDate','ddmmyyyy','arrow',true,12)">
                                                    <img src="../images/Calendar_scheduleHS.png" id="imgCalc" alt="Pick a date"></a>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td rowspan="1" class="a-left">
                                    <asp:Label ID="Rs_To" Text="To Date" runat="server"></asp:Label>
                                </td>
                                <td>
                                    <table class="w-100p">
                                        <tr class="defaultfontcolor">
                                            <td rowspan="1">
                                                <asp:TextBox ID="txtTDate" CssClass="Txtboxsmall" Width="120px" runat="server" meta:resourcekey="txtTDateResource1"></asp:TextBox>
                                                <a href="javascript:NewCssCal('txtTDate','ddmmyyyy','arrow',true,12)">
                                                    <img src="../images/Calendar_scheduleHS.png" id="img2" alt="Pick a date"></a>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td class="a-left">
                                </td>
                                <td>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="3" class="a-right">
                                    <asp:Button ID="btnSearch" runat="server" ToolTip="Click here to Generate Work Order"
                                        Style="cursor: pointer;" CssClass="btn" onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'"
                                        Text="Search" OnClick="btnGo_Click" Width="61px" />
                                </td>
                                <td colspan="3" class="a-left">
                                    <asp:Button ID="btnClear" runat="server" Text="Clear" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                        onmouseout="this.className='btn'" TabIndex="14" OnClientClick="return ClearSearchFields();"
                                        Width="61px" />
                                </td>
                            </tr>
                        </table>
                        <div class="a-center">
                            <asp:UpdatePanel ID="UpdatePanel" runat="server">
                                <ContentTemplate>
                                    <asp:UpdateProgress ID="Progressbar" AssociatedUpdatePanelID="UpdatePanel" runat="server">
                                        <ProgressTemplate>
                                             <div id="progressBackgroundFilter">
                                            </div>
                                            <div id="processMessage" style="width: 20%" align="left">
                                                <asp:Image ID="imgProgressbar" runat="server" ImageUrl="~/Images/scs_progress_bar.gif" />
                                                <br />
                                                <br />
                                                <asp:Label ID="Rs_Pleasewait" Text="Please wait while we fetch your report...." runat="server" /> 
                                            </div> 
                                        </ProgressTemplate>
                                    </asp:UpdateProgress>
                                    <asp:GridView ID="grdPatientView"  runat="server" CellSpacing="1" CellPadding="1"
                                        AllowPaging="True" PageSize="5" AutoGenerateColumns="False" ForeColor="#333333"
                                        CssClass="mytable1 w-70p gridView" OnRowDataBound="grdPatientView_RowDataBound" OnRowCommand="grdPatientView_RowCommand"
                                        DataKeyNames="PatientID,PatientVisitID">
                                        <HeaderStyle CssClass="dataheader1" />
                                        <RowStyle Font-Bold="False" HorizontalAlign="Left" />
                                        <Columns>
                                            <asp:TemplateField HeaderText="Patient Report">
                                                <ItemTemplate>
                                                    <div class="a-center">
                                                        <table class="dataheaderInvCtrl w-100p">
                                                            <tr>
                                                                <td class="a-right w-25p" style="background-color: #3a86da;">
                                                                    <asp:Label ID="lblVisitDate" runat="server" Text="Visit Date" ForeColor="White"></asp:Label>
                                                                </td>
                                                                <td class="a-left w-25p" style="background-color: #3a86da;">
                                                                    <asp:Label ID="lblDate" runat="server" Text='<%#  Eval("VisitDate")%>' ForeColor="White"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td colspan="2" class="a-center">
                                                                    <asp:GridView ID="grdOrderedinv" runat="server" AutoGenerateColumns="False" CellPadding="4"
                                                                    OnRowDataBound="dlChildInvName_ItemDataBound"   PageSize="100" ForeColor="Black" GridLines="Both" CssClass="mytable1 w-99p gridView">
                                                                        <Columns>
                                                                            <asp:BoundField DataField="Name" HeaderText="Test Name" />
                                                                            <asp:BoundField DataField="Status" HeaderText="Status" />
                                                                               <asp:TemplateField HeaderText="Image">
                                                           <ItemTemplate   >
                                                           
                                                    <%--<asp:Label ID="lnkShow1"  runat="server"  Text='<%#Eval("EMail") %>' >
                                                    </asp:Label>--%>
                                                       <asp:LinkButton ID="lnkShow" ForeColor="Black" Font-Bold="True" Font-Underline="True"
                                                        runat="server" Visible="False" Text="Show" CommandName="ShowReport" meta:resourcekey="lnkShowResource1"
                                                        OnClientClick="return RedirectToReport(this);"></asp:LinkButton>
                                                </ItemTemplate>
                                            </asp:TemplateField>
											
                                                                        </Columns>
                                                                    </asp:GridView>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td colspan="2" class="a-center pointer">
                                                                    <%--<asp:Label runat="server" ToolTip="Click Here to View" ID="lnkViewReport" Font-Underline="true"
                                                                Font-Bold="true" ForeColor="Black">Show Report</asp:Label>--%>
                                                                    <asp:LinkButton ID="lnkShowReport" runat="server" CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>'
                                                                        CommandName="ShowReport" Text="Show Report"></asp:LinkButton>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                    <br />
                                    <asp:GridView ID="grdPatientDetails" runat="server" CellSpacing="1" CellPadding="1"
                                        AllowPaging="True" PageSize="5" AutoGenerateColumns="False" ForeColor="#333333"
                                        CssClass="mytable1 w-90p gridView" DataKeyNames="PatientID,PatientVisitID,RoundNo" OnRowDataBound="grdPatientDetails_RowDataBound"
                                        OnRowCommand="grdPatientDetails_RowCommand" OnPageIndexChanging="grdPatientDetails_PageIndexChanging">
                                        <HeaderStyle CssClass="dataheader1" />
                                        <RowStyle Font-Bold="False" HorizontalAlign="Center" />
                                        <Columns>
                                            <asp:BoundField DataField="PatientNumber" HeaderText="Visit Number" ItemStyle-HorizontalAlign="Center" />
                                            <asp:BoundField DataField="VisitDate" HeaderText="Order Date/Time" ItemStyle-Wrap="false" />
                                            <asp:BoundField DataField="PatientID" HeaderText="Patient ID" Visible="false" />
                                            <asp:BoundField DataField="AliasName" HeaderText="Patient Name" />
                                            <%-- <asp:BoundField DataField="SEX" HeaderText="Gender" ItemStyle-HorizontalAlign="Center" />--%>
                                            <%--<asp:BoundField DataField="DOB" HeaderText="Date of Birth" DataFormatString="{0:dd/MM/yy hh:mm tt}"
                                            ItemStyle-Wrap="false" />--%>
                                            <%--<asp:BoundField DataField="Age" HeaderText="Age" />--%>
                                            <asp:BoundField DataField="Name" HeaderText="Test Name" />
                                            <asp:BoundField DataField="Status" HeaderText="Test Status" />
                                            <asp:BoundField DataField="RoundNo" HeaderText="Round No" Visible="false" />
                                            <asp:TemplateField HeaderText="Show Report">
                                                <ItemTemplate>
                                                    <asp:ImageButton ID="Image1" ImageUrl="../Images/pdf.ico" runat="server" CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>'
                                                        CommandName="ShowReport" CssClass="pointer" Style=" margin-left: 30px" />
                                                    <%-- <asp:HyperLink ID="HyperLink1" ImageUrl="../Images/pdf.ico" CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>'
                                                        CommandName="ShowReport" runat="server" Style="cursor: pointer; margin-left: 30px" />--%>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                    <ajc:ModalPopupExtender ID="modalPopUp" runat="server" DropShadow="false" PopupControlID="pnlOthers"
                                        BackgroundCssClass="modalBackground" Enabled="True" TargetControlID="btnDummy">
                                    </ajc:ModalPopupExtender>
                                    <asp:Panel ID="pnlOthers" runat="server" Style="display: none; height: 600px; width: 1050px;
                                        vertical-align: bottom; top:80px;">
                                        <table class="a-center w-100p">
                                            <tr>
                                                <td class="a-right">
                                                    <img class="w-5p pointer" src="../Images/Close_Red_Online_small.png" alt="Close" id="img1" onclick="ClosePopUp()"
                                                        style="height: 50%;" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <iframe id="ifPDF" runat="server" width="1000" height="550"></iframe>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <input type="button" id="btnDummy" runat="server" style="display: none;" />
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </div>
                    </div>
           <Attune:Attunefooter ID="Attunefooter" runat="server" />      
    </form>
</body>
</html>
