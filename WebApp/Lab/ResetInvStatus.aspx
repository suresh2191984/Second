<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ResetInvStatus.aspx.cs" Inherits="Lab_ResetInvStatus" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Mass Unloading</title>
    
    <script src="../Scripts/jquery-1.8.1.min.js" type="text/javascript"></script>

    <script src="../Scripts/JsonScript.js" type="text/javascript"></script>
    <script type="text/javascript" src="../Scripts/InvPattern.js"></script>

    <script src="../Scripts/ResultCapture.js" type="text/javascript"></script>
    <style type="text/css">
        .searchBox
        {
            font-family: Arial, Helvetica, sans-serif;
            text-align: left;
            height: 15px;
            width: 150px;
            border: 1px solid #999999;
            font-size: 11px;
            margin-left: 0px;
            background-image: url('../Images/magnifying-glass.png');
            background-repeat: no-repeat;
            padding-left: 20px;
            background-color: #F3E2A9;
        }
        .listMain
        {
            width: 350px !important;
        }
    </style>

    <script language="javascript" type="text/javascript">
        function ClearTestDetails() {
            if (document.getElementById('txtInvestigationName') != null) {
                document.getElementById('txtInvestigationName').value = '';
            }
            if (document.getElementById('hdnTestName') != null) {
                document.getElementById('hdnTestName').value = '';
            }
            if (document.getElementById('hdnTestType') != null) {
                document.getElementById('hdnTestType').value = '';
            }
        }
        function SelectedInvestigation(source, eventArgs) {
            var TestDetails = eventArgs.get_value();
            var TestName1 = TestDetails.split('~')[0];
            var TestName = TestName1.split(':')[0];
            var TestType = TestDetails.split('~')[2];
            $('#hdnTestName').val(TestName);
            $('#hdnTestType').val(TestType);
        }


        function BatchValidation() {
            try {
                var ddlDevice = $("#ddlInstrument :selected").val();
                var ddlDept = $("#ddlDept :selected").val();
                var ddlHeader = $("#ddlHeader :selected").val();
                var ddlProtocol = $("#ddlProtocol :selected").val();
                if (ddlProtocol == '0' && ddlHeader == '0' && ddlDept == '0' && ddlDevice == '0' && ($('#txtFromVisitID').val() == "" || $('#txtFromVisitID').val() == "0") && ($('#txtToVisitID').val() == "" || $('#txtToVisitID').val() == "0") && ($('#txtWorkListID').val() == "" || $('#txtWorkListID').val() == "0") && $('#txtInvestigationName').val() == "") {
                    alert('Select atleast 1 field');
                    return false;
                }
            }
            catch (e) {
                return false;
            }
        }
        function CheckAll() {
            var datacount = document.getElementById('hdnloadedvalues').value;

            for (i = 1; i <= datacount; i++) {

                if (document.getElementById('datalist_ctl00_chkAll').checked == true) {
                    document.getElementById('datalist_ctl0' + i + '_chklist').checked = true;

                }
                else {

                    document.getElementById('datalist_ctl0' + i + '_chklist').checked = false;
                }
            }
        }
        function GetDeviceValue(OrgId, VisitId, InvestigationID) {
            try {
                $.ajax({
                    type: "POST",
                    url: "../WebService.asmx/GetDeviceValue",
                    data: "{OrgId: " + OrgId + ", VisitId:'" + VisitId + "', InvestigationID:'" + InvestigationID + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function Success(data) {
                        var lstDeviceValue = data.d;
                        if (lstDeviceValue.length > 0) {
                            $.each(lstDeviceValue, function(i, obj) {
                                alert("Device value for " + obj.Name + " is " + obj.DeviceValue);
                            });
                        }
                        else {
                            alert("No Device Value Found");
                        }
                    },
                    error: function(xhr, ajaxOptions, thrownError) {
                        alert(xhr.status);
                    }
                });
            }
            catch (e) {
                return false;
            }
        }

        function onSave() {
            try {

                var lstResult = [];

                $("[id$='datalist'] input[type=checkbox]:checked").each(function() {
                    var ctrId = $(this).attr('id');

                    var $tr = $(this).closest('tr');
                    if (ctrId.indexOf('chkAll') == -1) {
                        lstResult.push(
                        {
                            PatientInvID: $tr.find("input:hidden[id$='hdnPatientInvID']").val()
                        });
                    }
                });
                if (lstResult.length > 0) {
                    $("[id$='hdnvalues']").val(JSON.stringify(lstResult));
                }
                else {
                    alert("Select anyone test");
                    return false;
                }
            }
            catch (e) {
                return false;
            }
        }
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
        <Services>
            <asp:ServiceReference Path="~/WebService.asmx" />
        </Services>
    </asp:ScriptManager>

    <script language="javascript" type="text/javascript">

    </script>
        <Attune:Attuneheader ID="Attuneheader" runat="server" />
 
                    <div class="contentdata">
                      
                        <asp:UpdatePanel ID="up1" runat="server" >
                        <ContentTemplate >
                        <asp:Panel ID="Panel1" runat="server" DefaultButton="btnBatchSearch">
                            <div id="DivSearchArea" class="filterdataheader2" style="display: block;">
                                <table class="w-100p searchPanel">
                                    <tr>
                                        <td class="w-9p a-right">
                                            <asp:Label ID="lblanalyzer" class="style1" runat="server" Text="Analyzer Name"></asp:Label>
                                          
                                        </td>
                                        <td class="w-12p a-left">
                                            <span class="richcombobox" style="width: 130px;">
                                                <asp:DropDownList ID="ddlInstrument" CssClass="ddl" runat="server" Width="130px">
                                                </asp:DropDownList>
                                                
                                            </span>
                                        </td>
                                        <td class="w-8p">
                                            <asp:CheckBox ID="chkIsMaster" runat="server" Text="From Master" />
                                        </td>
                                        <td class="w-8p a-right">
                                            <asp:Label ID="lblDept" class="style1" runat="server" Text="Department"></asp:Label>
                                        </td>
                                        <td class="w-12p a-left">
                                            <span class="richcombobox" style="width: 130px;">
                                                <asp:DropDownList ID="ddlDept" CssClass="ddl" runat="server" Width="130px">
                                                </asp:DropDownList>
                                            </span>
                                           
                                        </td>
                                        <td class="w-8p a-right">
                                            <asp:Label ID="lblHeader" class="style1" runat="server" Text="Header / Section"></asp:Label>
                                        </td>
                                        <td class="w-15p a-left">
                                            <span class="richcombobox" style="width: 170px;">
                                                <asp:DropDownList ID="ddlHeader" CssClass="ddl" runat="server" Width="170px">
                                                </asp:DropDownList>
                                            </span>
                                        </td>
                                        <td class="w-8p a-right">
                                            <asp:Label ID="lblProtocol" class="style1" runat="server" Text="Protocol Group"></asp:Label>
                                        </td>
                                        <td class="w-9p a-left">
                                            <span class="richcombobox" style="width: 130px;">
                                                <asp:DropDownList ID="ddlProtocol" CssClass="ddl" runat="server" Width="130px">
                                                </asp:DropDownList>
                                            </span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="a-right">
                                            <asp:Label ID="lblFromVisitID" class="style1" runat="server" Text="From Visit Number"></asp:Label>
                                        </td>
                                        <td colspan="2" class="a-left">
                                            <asp:TextBox ID="txtFromVisitID" Width="125px" CssClass="Txtboxsmall" runat="server"></asp:TextBox>
                                        </td>
                                        <td class="a-right">
                                            <asp:Label ID="lblToVisitID" class="style1" runat="server" Text="To Visit Number"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtToVisitID" Width="125px" CssClass="Txtboxsmall" runat="server"></asp:TextBox>
                                        </td>
                                        <td class="a-right">
                                            <asp:Label ID="lblInvestigationName" class="style1" runat="server" Text="Test Name"></asp:Label>
                                        </td>
                                        <td class="a-left">
                                            <asp:TextBox ID="txtInvestigationName" CssClass="searchBox" runat="server" onfocus="javascript:ClearTestDetails();"></asp:TextBox>
                                            <ajc:AutoCompleteExtender ID="AutoInvestigations" MinimumPrefixLength="2" runat="server"
                                                TargetControlID="txtInvestigationName" ServiceMethod="FetchInvestigationNameForResult"
                                                ServicePath="~/WebService.asmx" EnableCaching="False" CompletionInterval="2"
                                                CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" Enabled="True"
                                                DelimiterCharacters=";,:" OnClientItemSelected="SelectedInvestigation">
                                            </ajc:AutoCompleteExtender>
                                            &nbsp;
                                            <asp:HiddenField ID="hdnTestName" runat="server" Value="" />
                                            <asp:HiddenField ID="hdnTestType" runat="server" Value="" />
                                        </td>
                                        <td class="a-right">
                                            <asp:Label ID="lblWorkListID" class="style1" runat="server" Text="WorkList ID"></asp:Label>
                                        </td>
                                        <td class="a-left">
                                            <asp:TextBox ID="txtWorkListID" CssClass="Txtboxsmall" Width="125px" runat="server"></asp:TextBox>
                                        </td>
                                        <td class="a-center">
                                            <asp:Button ID="btnBatchSearch" Font-Bold="true" runat="server" Text="Search" OnClick="btnBatchSearch_Click"
                                                OnClientClick="return BatchValidation()" CssClass="btn" Width="120" Height="30" />
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </asp:Panel>
                        <asp:Panel CssClass="dataheaderInvCtrl" runat="server" ID="pnlDept">
                            <asp:DataList Width="100%" ID="datalist" runat="server" CellSpacing="10" HorizontalAlign="Justify"
                                GridLines="Horizontal">
                                <HeaderTemplate>
                                    <table class="w-100p" id="tblcontent1">
                                        <tr>
                                            <td>
                                                <asp:CheckBox ID="chkAll" runat="server" onclick="CheckAll();" Visible="true" ToolTip="select row" />
                                            </td>
                                            <td style="width: 150px;">
                                                <asp:Label ID="lblName" class="style1" runat="server" Text="Name" Font-Bold="true"></asp:Label>
                                            </td>
                                            <td class="w-100">
                                                <asp:Label ID="lblvno" class="style1" runat="server" Text="Visit Number" Font-Bold="true"></asp:Label>
                                            </td>
                                            <td class="w-100">
                                                <asp:Label ID="lblbno" class="style1" runat="server" Text="Barcode Number" Font-Bold="true"></asp:Label>
                                            </td>
                                            <td class="w-60">
                                                <asp:Label ID="lblage" class="style1" runat="server" Text="Age" Font-Bold="true"></asp:Label>
                                            </td>
                                            <td class="w-50">
                                                <asp:Label ID="lblsex" class="style1" runat="server" Text="Sex" Font-Bold="true"></asp:Label>
                                            </td>
                                            <td style="width: 300px;">
                                                <asp:Label ID="lblinvno" class="style1" runat="server" Text="Investigation Name"
                                                    Font-Bold="true"></asp:Label>
                                            </td>
                                            <td style="width: 300px;">
                                                <asp:Label ID="lblanal" class="style1" runat="server" Text="Analyzer Name" Font-Bold="true"></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <table class="w-100p" id="tblcontent">
                                        <tr>
                                            <td>
                                                <asp:CheckBox ID="chklist" runat="server"></asp:CheckBox>
                                            </td>
                                            <td>
                                                <asp:HiddenField ID="hdnPatientInvID" runat="server" Value='<%#Eval("PatientInvID")%>' />
                                            </td>
                                            <td style="width: 150px;">
                                                <asp:Label ID="lblname" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "Name")%>'> </asp:Label>
                                                
                                            </td>
                                            <td class="w-100">
                                                <asp:Label ID="lblvisitnum" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "VisitNumber")%>'> </asp:Label>
                                            </td>
                                            <td class="w-100">
                                                <asp:Label ID="lblBarcode" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "BarcodeNumber")%>'> </asp:Label>
                                            </td>
                                            <td class="w-70">
                                                <asp:Label ID="lblage" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "Age")%>'> </asp:Label>
                                            </td>
                                            <td class="w-70">
                                                <asp:Label ID="lblsex" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "Sex")%>'> </asp:Label>
                                            </td>
                                            <td style="width: 300px;">
                                                <asp:Label ID="lblInvestigationname" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "InvestigationName")%>'> </asp:Label>
                                            </td>
                                            <td style="width: 300px;">
                                                <asp:Label ID="lblInstrumentname" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "InstrumentName")%>'> </asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </ItemTemplate>
                            </asp:DataList>
                            <table class="w-100p">
                                <tr>
                                    <td class="a-center">
                                        <asp:Button Text="UnLoad" ID="btnsave" runat="server" OnClientClick="onSave()" OnClick="btnsave_Click"
                                            CssClass="btn" Visible="false"  />
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                        
                        </ContentTemplate> 
                        </asp:UpdatePanel> 
                    </div>
        <Attune:Attunefooter ID="Attunefooter" runat="server" />
        <asp:HiddenField ID="hdnActionName" runat="server" Value="EnterResult" />
        <asp:HiddenField ID="hdnDefaultDropDownStatus" runat="server" Value="" />
        <asp:HiddenField ID="hdnloadedvalues" runat="server" Value="" />
        <asp:HiddenField ID="hdnvalues" runat="server" Value="" />
        <asp:HiddenField ID="hdnstatuschange" runat="server" Value="" />
        <asp:HiddenField runat="server" ID="hdnIsDeltaCheckWant" Value="false" />
        <asp:HiddenField ID="hdnOrgID" runat="server" />


    <script type="text/javascript" language="javascript">
        $(document).ready(function() { //check all
            $("#datalist_ctl00_chkAll").click(
             function() {
                 $("INPUT[id$='chklist']").attr('checked',
			$("#datalist_ctl00_chkAll").is(':checked'));
             });
        });
    </script>

    </form>
</body>
</html>
