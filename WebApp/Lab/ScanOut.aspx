<%@ Page Language="C#" AutoEventWireup="true" EnableEventValidation="false" CodeFile="ScanOut.aspx.cs"
    Inherits="Lab_ScanOut" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Scan Out</title>
    <link href="../StyleSheets/jquery-ui.css" rel="stylesheet" type="text/css" />

    <script src="../Scripts/ReceiveBatchSheet.js" type="text/javascript"></script>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script src="../Scripts/jquery.dataTables.min.js" type="text/javascript"></script>

    <script type="text/javascript" src="../Scripts/TableTools.js"></script>

    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server" defaultbutton="btnSubmit" defaultfocus="barcodeid">
    <asp:ScriptManager ID="ctlTaskScriptMgr" ScriptMode="Release" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div id='wrapper' class="contentdata">
        <asp:UpdatePanel ID="updatePanel1" UpdateMode="Conditional" runat="server">
            <ContentTemplate>
                <asp:UpdateProgress ID="Progressbar" AssociatedUpdatePanelID="updatePanel1" runat="server">
                    <ProgressTemplate>
                        <div id="progressBackgroundFilter" class="a-center">
                        </div>
                        <div id="processMessage" class="a-center w-20p">
                            <asp:Image ID="img1" Width="40px" Height="40px" runat="server" ImageUrl="../Images/loading.GIF" />
                        </div>
                    </ProgressTemplate>
                </asp:UpdateProgress>
                <asp:Panel ID="pnlContents" runat="server">
                    <table border="0" class="searchPanel w-100p">
                        <tr style="width: 100%">
                            <td style="width: 10%">
                                <table class="searchPanel w-100p">
                                    <tr style="width: 100%">
                                        <td style="width: 10%">
                                            <tr style="width: 100%">
                                                <td style="width: 10%">
                                                </td>
                                                <td>
                                                </td>
                                            </tr>
                                            <tr style="width: 100%; height: 10pt;">
                                                <td>
                                                    &nbsp;
                                                </td>
                                            </tr>
                                            <tr>
                                                <asp:Label ID="Label1" runat="server" Text="Lab Number/Barcode"></asp:Label>
                                                <asp:TextBox ID="barcodeid" runat="server" MaxLength="12" Style="width: 100px;" onkeypress="return isNumber(event)"></asp:TextBox>
                                                &nbsp;<img align="middle" alt="" src="../Images/starbutton.png" />
                                                <asp:Label ID="lbldept" runat="server" Text="Team"></asp:Label>
                                                &nbsp;&nbsp;
                                                <asp:DropDownList ID="ddlDepartment" runat="server" Style="max-width: 200px !important;"
                                                    CssClass="ddl" onchange="submitbutton();">
                                                </asp:DropDownList>
                                                &nbsp;&nbsp;
                                                <asp:Button ID="btnSubmit" runat="server" CssClass="btn pointer" OnClick="btnSubmit_Click"
                                                    OnClientClick="javascript:return submitbutton();" onmouseout="this.className='btn'"
                                                    onmouseover="this.className='btn btnhov'" Text="Submit" ToolTip="Click here to Search" />
                                        </td>
                                    </tr>
                            </td>
                        </tr>
                    </table>
                    </td> </tr> </table>
                    <div style="width: 100%; height: 250px;">
                        <asp:GridView ID="GridView1" runat="server" CssClass="mytable1 w-100p gridView" AutoGenerateColumns="False"
                            AllowPaging="true" OnPageIndexChanging="OnPageIndexChanging" PageSize="10" OnRowDataBound="GridView1_RowDataBound"
                            PagerStyle-Font-Bold="true" ForeColor="#333333" PagerSettings-Mode="NumericFirstLast"
                            OnSelectedIndexChanged="GridView1_SelectedIndexChanged">
                            <PagerSettings FirstPageText="First" LastPageText="Last" Mode="NumericFirstLast"
                                PageButtonCount="5" />
                            <Columns>
                                <asp:TemplateField HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="5%" HeaderText="Sl.No"
                                    ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <%# Container.DataItemIndex + 1 %>
                                        <asp:HiddenField ID="hfBarcodenumber" Value='<%# Eval("BarcodeNumber") %>' runat="server" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="LabNumber" HeaderText="Lab Number" />
                                <asp:BoundField DataField="BarcodeNumber" HeaderText="Barcode" />
                                <asp:BoundField DataField="SampleType" HeaderText="Sample Type" />
                                <asp:BoundField DataField="Container" HeaderText="Container" />
                                <asp:BoundField DataField="TeamName" HeaderText="Team Custody" />
                                <asp:BoundField DataField="PatientRegisterdType" HeaderText="Patient Registered Type" />
                                <asp:BoundField DataField="ReceivedTime" HeaderText="Received Time" />
                                <asp:BoundField DataField="ScanCount" HeaderText="Scan Count" />
                                <%--<asp:BoundField DataField="Status" HeaderText="Status" />--%>
                                <asp:BoundField DataField="SampleStatus" HeaderText="Sample Status" />
                                <asp:BoundField DataField="CollectionCenter" HeaderText="Collection Center" />
                                <asp:TemplateField HeaderText="Report Due Date" ItemStyle-Width="10%">
                                    <ItemTemplate>
                                        <asp:Label ID="tatDate" runat="server" Text='<%#Eval("ReportDateTime").ToString()=="01/01/1753 00:00:00" || Eval("ReportDateTime").ToString()=="01/01/0001 00:00:00" ? " ":Eval("ReportDateTime") %>' />
                                    </ItemTemplate>
                                    <ItemStyle Width="10%" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Print">
                                    <ItemTemplate>
                                        <asp:CheckBox Enabled="false" ID="chkSecondaryBarcode" runat="server" Text=" " />
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <PagerStyle CssClass="PagerStyle" />
                        </asp:GridView>
                    </div>
                    <div id="SampleDetail" style="height: 210px !important; overflow-y: scroll !Important;">
                        <ajc:TabContainer ID="grouptab" runat="server" ActiveTabIndex="0">
                            <ajc:TabPanel ID="SampleDetails" runat="server" HeaderText="Sample Details">
                                <HeaderTemplate>
                                    Sample Details
                                </HeaderTemplate>
                                <ContentTemplate>
                                    <asp:GridView ID="GridView2" AllowPaging="false" ForeColor="#333333" PageSize="5"
                                        runat="server" Font-Size="Smaller" CssClass="mytable1 w-100p gridView" AutoGenerateColumns="False"
                                        OnPageIndexChanging="GridView2_PageIndexChanging" OnRowDataBound="GridView2_RowDataBound">
                                        <PagerSettings FirstPageText="First" LastPageText="Last" Mode="NumericFirstLast"
                                            PageButtonCount="5" />
                                        <Columns>
                                            <asp:TemplateField HeaderText="S.No">
                                                <ItemTemplate>
                                                    <%# Container.DataItemIndex + 1 %>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Report Due Date" ItemStyle-Width="10%">
                                                <ItemTemplate>
                                                    <asp:Label ID="tatDate" runat="server" Text='<%#Eval("ReportDateTime").ToString()=="01/01/1753 00:00:00"? " ":Eval("ReportDateTime") %>' />
                                                </ItemTemplate>
                                                <ItemStyle Width="10%" />
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="RegisteredLocation" HeaderText="Registered Location" />
                                            <asp:BoundField DataField="ProcessingLocation" HeaderText="Processing Location" />
                                            <asp:BoundField DataField="LocationName" HeaderText="Out Source Location" />
                                            <asp:BoundField DataField="DeptName" HeaderText="Department" />
                                            <%--<asp:BoundField DataField="Name" HeaderText="Test Panel" />--%>
                                            <asp:BoundField DataField="InvestigationName" HeaderText="Test Name" />
                                            <asp:BoundField DataField="InvestigationCode" HeaderText="Test Code" />
                                            <asp:BoundField DataField="Status" HeaderText="Test Status" />
                                        </Columns>
                                    </asp:GridView>
                                </ContentTemplate>
                            </ajc:TabPanel>
                            <ajc:TabPanel ID="TabPanel1" runat="server" HeaderText="Sample Details">
                                <HeaderTemplate>
                                    Tracking
                                </HeaderTemplate>
                                <ContentTemplate>
                                    <div class="contentdata">
                                        <asp:GridView ID="GridView3" runat="server" PageSize="5" AllowPaging="false" CssClass="mytable1 w-100p gridView "
                                            AutoGenerateColumns="False" ForeColor="#333333" PagerStyle-Font-Bold="true" PagerSettings-Mode="NumericFirstLast"
                                            OnPageIndexChanging="GridView3_PageIndexChanging">
                                            <PagerSettings FirstPageText="First" LastPageText="Last" Mode="NumericFirstLast"
                                                PageButtonCount="5" />
                                            <Columns>
                                                <asp:TemplateField HeaderText="S.No">
                                                    <ItemTemplate>
                                                        <%# Container.DataItemIndex + 1 %>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:BoundField DataField="Status" HeaderText="Event Type" />
                                                <asp:BoundField DataField="TeamName" HeaderText="Team" />
                                                <asp:BoundField DataField="CreatedAt" HeaderText="Event Date" />
                                                <asp:BoundField DataField="Location" HeaderText="Location" />
                                                <%--<asp:BoundField DataField="DeptName" HeaderText="Department" />--%>
                                                <asp:BoundField DataField="LoginName" HeaderText="User Name" />
                                            </Columns>
                                            <%--<PagerStyle CssClass="PagerStyle" />--%>
                                        </asp:GridView>
                                    </div>
                                </ContentTemplate>
                            </ajc:TabPanel>
                        </ajc:TabContainer>
                    </div>
                </asp:Panel>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    <asp:HiddenField ID="hdnMessages" runat="server" />
    </form>

    <script type="text/javascript">

        $(document).ready(function() {
            $('#SampleDetail').css("display", "none");
            hidegrid();
        });
        function isNumber(evt) {
            evt = (evt) ? evt : window.event;
            var charCode = (evt.which) ? evt.which : evt.keyCode;
            if (charCode > 31 && (charCode < 48 || charCode > 57)) {
                return false;
            }
            return true;
        }
        function hidegrid() {
            if ($('#GridView1:visible') == true) {
                $('#SampleDetail').css("display", "block");
            }
            else {
                $('#SampleDetail').css("display", "none");
                $('#wrapper').addClass("contentdata");
            }

        }

        function CheckValidation_alert() {
            var ddl = document.getElementById("ddlDepartment");
            ddl = ddl.options[ddl.selectedIndex].value;


            if (ddl == 0) {
                AlertType = SListForAppMsg.Get("Lab_ScanOut_aspx_alert") != null ? SListForAppMsg.Get("Lab_ScanOut_aspx_alert") : "Alert";
                msg = SListForAppMsg.Get("Lab_ScanOut_aspx_05") != null ? SListForAppMsg.Get("Lab_ScanOut_aspx_05") : "Select Team";
                ValidationWindow(msg, AlertType);
                return false;
            } else if (document.getElementById('<%=barcodeid.ClientID%>').value == "") {
                AlertType = SListForAppMsg.Get("Lab_ScanOut_aspx_alert") != null ? SListForAppMsg.Get("Lab_ScanOut_aspx_alert") : "Alert";
                msg = SListForAppMsg.Get("Lab_ScanOut_aspx_04") != null ? SListForAppMsg.Get("Lab_ScanOut_aspx_04") : "Enter Barcode no or Patient Lab Number.";
                ValidationWindow(msg, AlertType);
                // ValidationWindow("Enter Barcode", "Alert");
                return false;
            }



        }


        function validateGrid() {
            //var gridCount = document.getElementById("<%= GridView1.ClientID %>").rows.length;
            var gridCount = $("#GridView1 tr").length;
            if (gridCount == 0) {

                AlertType = SListForAppMsg.Get("Lab_ScanOut_aspx_alert") != null ? SListForAppMsg.Get("Lab_ScanOut_aspx_alert") : "Alert";
                msg = SListForAppMsg.Get("Lab_ScanOut_aspx_03") != null ? SListForAppMsg.Get("Lab_ScanOut_aspx_03") : "No Data Presents";
                ValidationWindow(msg, AlertType);
                return false;
            }
        }

        function PrintPanel() {
            //var panel = document.getElementById("<%=pnlContents.ClientID %>");
            var printWindow = window.open('', '', 'left=100,top=100,width=1000,height=1000,tollbar=0,scrollbars=1,status=0,resizable=1');
            printWindow.document.write('<html><head>');
            printWindow.document.write('<meta charset="utf-8" /></head><body >');
            printWindow.document.write(panel.innerHTML);
            printWindow.document.write('</body></html>');
            printWindow.document.close();
            setTimeout(function() {
                printWindow.print();
            }, 500);
            return false;
        }

        function submitbutton() {
            debugger;
            var s = true;
            if ($('#barcodeid').val() == '') {
                ValidationWindow('Please enter Lab Number/Barcode.', 'Alert');
                s = false;
                hidegrid();
            }
            else if ($('#ddlDepartment').val() == '-1') {
                ValidationWindow('Please select Team.', 'Alert');
                s = false;
                hidegrid();
            }
            return s;
        }

        function highlite(m) {
            debugger;
            var tr = null;
            var gv = document.getElementById("<%= GridView1.ClientID %>");
            var items = $('#GridView1 input[name$="chkPrint"]');
            var count = 0;
            //            if (items.length > 0) {
            //                for (var i = 0; i < items.length; i++) {
            //                    count = 1 + i;
            //                    if (items[i].checked) {
            //                        $('#GridView1 tr').eq(count).removeAttr("style");
            //                        $('#GridView1 tr').eq(count).css("cssText", "background-color:#99E5E5 !important;");
            //                    }
            //                    else {
            var c = 1 + parseInt(m);
            $('#GridView1 tr').eq(c).removeAttr("style");
            $('#GridView1 tr').eq(c).css("cssText", "background-color:yellow !important;");
            //}
            //}
            //}


        }
      
       
    </script>

</body>
</html>
