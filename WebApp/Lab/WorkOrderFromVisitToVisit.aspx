<%@ Page Language="C#" AutoEventWireup="true" CodeFile="WorkOrderFromVisitToVisit.aspx.cs"
    Inherits="Lab_WorkOrderFromVisitToVisit" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="../CommonControls/OrderedSamples.ascx" TagName="OrderedSamples"
    TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Work Order From Visit To Visit</title>
    <link href="../StyleSheets/jquery-ui.css" rel="stylesheet" type="text/css" />
    <%--<script src="../Scripts/datetimepicker.js" type="text/javascript"></script> --%>
       <script type="text/javascript" src="../Scripts/datetimepicker_css.js"></script>

    <script language="javascript" type="text/javascript">
        function validateVisit() {
            var visitFilter = false;
            var filterCount = 0;
            var dateCheck = false;
            if (document.getElementById("txtFromVisit").value.trim() != "" && document.getElementById("txtToVisit").value.trim() != "") {
                visitFilter = true;
            }

            if (document.getElementById("txtFrom").value.trim() != "" && document.getElementById("txtTo").value.trim() != "") {
                dateCheck = true;
                // filterCount++;

            }


            if (document.getElementById("txtTestName").value.trim() != "") {
                filterCount++;
            }

            if (document.getElementById("txtWardName").value.trim() != "") {
                filterCount++;
            }

            var ddlLocation = document.getElementById("ddlocation");
            var ddVisitType = document.getElementById("ddVisitType");
            var ddlSource = document.getElementById("ddClientName");

            if (ddlLocation.options[ddlLocation.selectedIndex].value != "-1") {
                filterCount++;
            }
            if (ddVisitType.options[ddVisitType.selectedIndex].value != "-1") {
                filterCount++;
            }
            if (ddlSource.options[ddlSource.selectedIndex].value != "-1") {
                filterCount++;
            }



            if (filterCount == 0 && dateCheck == false && visitFilter == false) {

                alert('Provide From/To Visit Number');
                return false;
            }

            if (filterCount > 0 && dateCheck == false && visitFilter == false) {

                alert('Provide From/To Date');
                return false;
            }

            //        if (filterCount == 0 && dateCheck == false && visitFilter == true) {
            //          
            //            alert('Provide From/To Date');
            //            return false; }



            return true;




            //    
            //        if (document.getElementById("txtFromVisit").value.trim() == "") {
            //            alert('Provide from visit number');
            //            document.getElementById("txtFromVisit").focus();
            //            return false;
            //        }
            //        if (document.getElementById("txtToVisit").value.trim() == "") {
            //            alert('Provide to visit number');
            //            document.getElementById("txtToVisit").focus();
            //            return false;
            //        }



        }
    </script>

</head>
<body oncontextmenu="return false;">
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
        <table cellpadding="4" class="dataheaderInvCtrl w-100p searchPanel">
            <tr class="h-25">
                <td class="a-right w-15p">
                    <asp:Label ID="Rs_FromVisitNo" Text="From Visit No:" runat="server" meta:resourcekey="Rs_FromVisitNoResource1"></asp:Label>
                </td>
                <td class="w-15p">
                    <asp:TextBox ID="txtFromVisit" runat="server" meta:resourcekey="txtFromVisitResource1"
                        CssClass="Txtboxsmall"></asp:TextBox>
                </td>
                <td class="w-20p a-right">
                    <asp:Label ID="Rs_ToVisitNo" Text="To Visit No:" runat="server" meta:resourcekey="Rs_ToVisitNoResource1"></asp:Label>
                </td>
                <td class="w-15p">
                    <asp:TextBox ID="txtToVisit" runat="server" meta:resourcekey="txtToVisitResource1"
                        CssClass="Txtboxsmall"></asp:TextBox>
                </td>
                <td class="w-25p">
                    <table class="w-100p">
                        <tr>
                            <td>
                                Visit Type
                            </td>
                            <td>
                                <asp:DropDownList ID="ddVisitType" runat="server" CssClass="ddlsmall">
                                    <asp:ListItem Text="Select" Value="-1"></asp:ListItem>
                                    <asp:ListItem Text="OP" Value="0"></asp:ListItem>
                                    <asp:ListItem Text="IP" Value="1"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td class="a-right w-25p">
                    <asp:Label ID="Rs_From" Text="From Date" runat="server"></asp:Label>
                </td>
                <td>
                    <table class="w-100p">
                        <tr class="defaultfontcolor">
                            <td>
                                <asp:TextBox runat="server" CssClass="Txtboxsmall" ID="txtFrom" MaxLength="25" size="25"></asp:TextBox>
                            </td>
                            <td id="datecheck" runat="server" align="left">
                                <a href="javascript:NewCssCal('<% =txtFrom.ClientID %>','ddmmyyyy','arrow',true,12,'Y','Y')">
                                    <img src="../Images/Calendar_scheduleHS.png" width="16" height="16" border="0" alt="Pick a date"></a>
                                &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                            </td>
                        </tr>
                    </table>
                </td>
                <td class="w-17p a-right">
                    <asp:Label ID="Rs_To" Text="To Date" runat="server"></asp:Label>
                </td>
                <td>
                    <table class="w-100p">
                        <tr class="defaultfontcolor">
                            <td>
                                <asp:TextBox runat="server" CssClass="Txtboxsmall" ID="txtTo" MaxLength="25" size="25"></asp:TextBox>
                            </td>
                            <td id="Td1" runat="server" class="a-left">
                                <a href="javascript:NewCssCal('<% =txtTo.ClientID %>','ddmmyyyy','arrow',true,12,'Y','N')">
                                    <img src="../Images/Calendar_scheduleHS.png" width="16" height="16" border="0" alt="Pick a date"></a>
                                &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                            </td>
                        </tr>
                    </table>
                </td>
                <td>
                    <table class="w-100p">
                        <tr>
                            <td class="w-27p">
                                Mode
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlMode" runat="server" CssClass="ddlsmall">
                                    <asp:ListItem Text="Select" Value="0"></asp:ListItem>
                                    <asp:ListItem Text="All" Value="-1"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td class="a-right">
                    Location
                </td>
                <td>
                    <asp:DropDownList ID="ddlocation" runat="server" CssClass="ddlsmall">
                    </asp:DropDownList>
                </td>
                <td class="a-right">
                    Source Name
                </td>
                <td colspan="2">
                    <asp:DropDownList ID="ddClientName" CssClass="ddlsmall" runat="server">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td class="a-right">
                    Test Name
                </td>
                <td>
                    <asp:TextBox ID="txtTestName" class="tb1" runat="server" Width="150" CssClass="Txtboxsmall"></asp:TextBox>
                </td>
                <td class="a-right">
                    Ward No
                </td>
                <td>
                    <asp:TextBox CssClass="Txtboxverysmall" ID="txtWardName" runat="server" Width="50"></asp:TextBox>
                </td>
                <td>
                    <asp:Button ID="btnFinish" runat="server" ToolTip="Click here to Generate Work Order"
                        Style="cursor: pointer;" CssClass="btn" onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'"
                        Text=" Generate Work Order " OnClick="btnFinish_Click" OnClientClick="javascript:return validateVisit();"
                        meta:resourcekey="btnFinishResource1" />
                </td>
            </tr>
        </table>
        <asp:Label ID="lblStatus" Visible="False" runat="server" ForeColor="#000333" Text="No Matching Records Found!"></asp:Label>
        <table id="tabPrintButton" style="display: none;" runat="server" cellpadding="0"
            cellspacing="0" border="0" width="100%">
            <tr>
                <td align="right">
                    <asp:HyperLink ID="hypLnkPrint" Font-Bold="True" Font-Size="12px" ForeColor="Black"
                        Target="WorkOrderWindow" runat="server" ToolTip="Click Here To Print Work Order">
                        <img id="imgPrint" runat="server" style="border-width: 0px;" src="~/Images/printer.gif" />
                        <u>
                            <asp:Label ID="Rs_PrintWorkOrder" Text="Print Work Order" runat="server"></asp:Label>
                        </u>
                    </asp:HyperLink>
                </td>
            </tr>
        </table>
        <br />
        <asp:GridView ID="grdResult" runat="server" AllowPaging="True" AutoGenerateColumns="False"
            CellPadding="0" GridLines="both" ForeColor="#333333" HeaderStyle-BorderWidth="0px"
            OnRowDataBound="grdResult_RowDataBound" OnPageIndexChanging="grdResult_PageIndexChanging"
            CssClass="w-100p gridView">
            <Columns>
                <asp:TemplateField HeaderText="Bill No/PID/VisitID">
                    <ItemTemplate>
                        <asp:Label ID="collectedon" runat="server" Text='<%# Eval("CollectedOn") %>' />
                        <br />
                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("PatientNumber") %>' />
                        <br />
                        <asp:Label ID="Label2" runat="server" Text='<%# Eval("StrVisitID") %>' />
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="left" VerticalAlign="Top" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Name/Age/Sex/Ref. Doctor">
                    <ItemTemplate>
                        <asp:Label ID="PatientName" runat="server" Text='<%# Eval("PatientName") %>' />
                        <br />
                        <asp:Label ID="age" runat="server" Text='<%# Eval("Age") %>' />
                        <br />
                        <asp:Label ID="sex" runat="server" Text='<%# Eval("Sex") %>' />
                        <br />
                        <asp:Label ID="physicianname" runat="server" Text='<%# Eval("ReferingPhysicianName") %>' />
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="left" VerticalAlign="Top" />
                </asp:TemplateField>
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:GridView ID="gvDescription" Width="100%" GridLines="both" AutoGenerateColumns="False"
                            runat="server">
                            <Columns>
                                <asp:TemplateField HeaderText="Test Description" ItemStyle-Width="50%">
                                    <ItemTemplate>
                                        <asp:Label ID="lblBilledFor" Text='<%# Eval("Description") %>' runat="server"></asp:Label>
                                    </ItemTemplate>
                                    <HeaderStyle Font-Bold="true" />
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Status" ItemStyle-Width="16%">
                                    <ItemTemplate>
                                        <asp:Label ID="status" Text='<%# Eval("Status") %>' runat="server"></asp:Label>
                                    </ItemTemplate>
                                    <HeaderStyle Font-Bold="true" HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Source" ItemStyle-Width="15%">
                                    <ItemTemplate>
                                        <asp:Label ID="Sources" Text='<%# Eval("Source") %>' runat="server"></asp:Label>
                                    </ItemTemplate>
                                    <HeaderStyle Font-Bold="true" HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Destination" ItemStyle-Width="15%">
                                    <ItemTemplate>
                                        <asp:Label ID="Destination" Text='<%# Eval("Destination") %>' runat="server"></asp:Label>
                                    </ItemTemplate>
                                    <HeaderStyle Font-Bold="true" HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </ItemTemplate>
                </asp:TemplateField>
                <%-- <asp:TemplateField  HeaderText="Status">
                                 <ItemTemplate> 
                                 </ItemTemplate>
                            </asp:TemplateField> 
                            <asp:TemplateField   HeaderText="Source" >
                                 <ItemTemplate> 
                                 </ItemTemplate>
                            </asp:TemplateField> 
                            <asp:TemplateField HeaderText="Destination"  >
                                 <ItemTemplate> 
                                 </ItemTemplate>
                            </asp:TemplateField> --%>
            </Columns>
        </asp:GridView>
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    <asp:HiddenField ID="hdnOrgID" runat="server" />

  <%--  <script type="text/javascript" src="../Scripts/jquery-ui.min.js"></script>--%>

    <%--Script for AutoComplete of Investigation Name--%>

    <script type="text/javascript">
        $(function() {

            $(".tb1").autocomplete({
                source: function(request, response) {
                    $.ajax({
                        url: "../WebService.asmx/FetchInvestigationName",
                        data: "{ 'Name': '" + request.term + "','Orgid': '" + parseInt(document.getElementById('hdnOrgID').value) + "' }",
                        dataType: "json",
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        dataFilter: function(data) { return data; },
                        success: function(data) {
                            response($.map(data.d, function(item) {
                                return {
                                    value: item.Name
                                }
                            }))
                        },
                        error: function(XMLHttpRequest, textStatus, errorThrown) {
                            alert(textStatus);
                        }
                    });
                },
                minLength: 2
            });
        });


        function reloadauto() {

            $(function() {

                $(".tb").autocomplete({
                    source: function(request, response) {
                        $.ajax({
                            url: "../WebService.asmx/FetchDrugList",
                            data: "{ 'drug': '" + request.term + "','Orgid': '" + parseInt(document.getElementById('hdnOrgID').value) + "' }",
                            dataType: "json",
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            dataFilter: function(data) { return data; },
                            success: function(data) {
                                response($.map(data.d, function(item) {
                                    return {
                                        value: item.BrandName
                                    }
                                }))
                            },
                            error: function(XMLHttpRequest, textStatus, errorThrown) {
                                alert(textStatus);
                            }
                        });
                    },
                    minLength: 2
                });
            });
        }
	    
	    
    </script>

    </form>
</body>
</html>
