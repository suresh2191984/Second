<%@ Page Language="C#" AutoEventWireup="true" CodeFile="WorkListFromVisitToVisit.aspx.cs"
    Inherits="Investigation_WorkListFromVisitToVisit" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>

<%@ Register Src="../CommonControls/OrderedSamples.ascx" TagName="OrderedSamples"
    TagPrefix="uc5" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Work List From Visit To Visit</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
    
    
    
    <script type="text/javascript" src="../Scripts/datetimepicker_css.js"></script>
     <link href="../StyleSheets/jquery-ui.css" rel="stylesheet" type="text/css"/>



    <script language="javascript" type="text/javascript">
        function validate100Visits() {
            var AlertType = SListForAppMsg.Get('Investigation_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('Investigation_Header_Alert');
            var vSelectedRange = SListForAppMsg.Get('Investigation_WorkListFromVisitToVisit_aspx_01') == null ? "Your selected range exceeds 300 visit" : SListForAppMsg.Get('Investigation_WorkListFromVisitToVisit_aspx_01');

            var VisitNo1 = document.getElementById('txtFromVisit').value;
            var VisitNo2 = document.getElementById('txtToVisit').value;
            var Visitid = (VisitNo2 - VisitNo1);
            if (Visitid > 300) {
                //alert('Your selected range exceeds 300 visit');
                ValidationWindow(vSelectedRange, AlertType);
                return false;
            }
            else {
                return true;
            }
        }
        function validateVisit() {
            var AlertType = SListForAppMsg.Get('Investigation_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('Investigation_Header_Alert');
            var vFromDate = SListForAppMsg.Get('Investigation_WorkListFromVisitToVisit_aspx_02') == null ? "Provide from Date/Visit No." : SListForAppMsg.Get('Investigation_WorkListFromVisitToVisit_aspx_02');
            var vToDate = SListForAppMsg.Get('Investigation_WorkListFromVisitToVisit_aspx_03') == null ? "Provide to Date/Visit No." : SListForAppMsg.Get('Investigation_WorkListFromVisitToVisit_aspx_03');

            if ((document.getElementById("txtFrom").value.trim() == "") && (document.getElementById("txtFromVisit").value.trim() == "")) {
                //alert('Provide from Date/Visit No.');
                ValidationWindow(vFromDate, AlertType);
                document.getElementById("txtFrom").focus();
                return false;
            }
            if ((document.getElementById("txtTo").value.trim() == "") && (document.getElementById("txtToVisit").value.trim() == "")) {
                //alert('Provide to Date/Visit No.');
                ValidationWindow(vToDate, AlertType);
                document.getElementById("txtFrom").focus();
                return false;
            }
           return validate100Visits();
        }
    </script>

    <style type="text/css">
        .style2
        {
            width: 223px;
        }
    </style>
</head>
<body oncontextmenu="return true;">
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    
     <Attune:Attuneheader ID="Attuneheader" runat="server" />
       
                    <div class="contentdata">
                       
                        <table class="dataheaderInvCtrl searchPanel">
                            <tr class="h-25">
                                <td class="a-right w-10p">
                    <%=Resources.Investigation_ClientDisplay.Investigation_WorkListFromVisitToVisit_aspx_01 %>
                                </td>
                                <td class="w-26p">
                    <asp:TextBox ID="txtFromVisit" runat="server" CssClass="Txtboxsmall" meta:resourcekey="txtFromVisitResource1"></asp:TextBox>
                                </td>
                                <td class="a-right w-10p">
                    <%=Resources.Investigation_ClientDisplay.Investigation_WorkListFromVisitToVisit_aspx_02 %>
                                </td>
                                <td class="w-20p">
                    <asp:TextBox ID="txtToVisit" runat="server" CssClass="Txtboxsmall" meta:resourcekey="txtToVisitResource1"></asp:TextBox>
                                </td>
                             
                                                <td class="w-10p a-right">
                    <%=Resources.Investigation_ClientDisplay.Investigation_WorkListFromVisitToVisit_aspx_03 %>
                                                </td>
                                                <td style="width: 30%;" align="left">
                    <asp:DropDownList ID="ddlVisitType" runat="server" CssClass="ddl" meta:resourcekey="ddlVisitTypeResource1">
                        <asp:ListItem Value="-1" Text="Both" Selected="True" meta:resourcekey="ListItemResource1"></asp:ListItem>
                        <asp:ListItem Value="0" Text="OP" meta:resourcekey="ListItemResource2"></asp:ListItem>
                        <asp:ListItem Value="1" Text="IP" meta:resourcekey="ListItemResource3"></asp:ListItem>
                    </asp:DropDownList>
                                                </td>
                                          
                                      
                            </tr>
                            <tr>
                                <td class="a-right">
                    <%=Resources.Investigation_ClientDisplay.Investigation_WorkListFromVisitToVisit_aspx_04 %>
                                </td>
                                <td>
                                    <table class="w-100p">
                                        <tr class="defaultfontcolor">
                                            <td>
                                <asp:TextBox runat="server" ID="txtFrom" MaxLength="25" size="25" CssClass="Txtboxsmall"
                                    meta:resourcekey="txtFromResource1"></asp:TextBox>
                                            </td>
                                          <td id="datecheck" runat="server" align="left" width="60%">
                                                <a href="javascript:NewCssCal('<% =txtFrom.ClientID %>','ddmmyyyy','arrow',true,12,'Y','Y')">
                                                    <img src="../Images/Calendar_scheduleHS.png" width="16" height="16" border="0" alt="Pick a date"></a>
                                                &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td class="a-right">
                    <%=Resources.Investigation_ClientDisplay.Investigation_WorkListFromVisitToVisit_aspx_05 %>
                                </td>
                                <td>
                                    <table class="w-100p">
                                        <tr class="defaultfontcolor">
                                            <td class="w-20p a-left">
                                <asp:TextBox runat="server" ID="txtTo" MaxLength="25" size="25" CssClass="Txtboxsmall"
                                    meta:resourcekey="txtToResource1"></asp:TextBox>
                                            </td>
                                            <td id="Td1" runat="server" align="left" width="30%">
                                                 <a href="javascript:NewCssCal('<% =txtTo.ClientID %>','ddmmyyyy','arrow',true,12,'Y','N')">
                                                    <img src="../Images/Calendar_scheduleHS.png" width="16" height="16" border="0" alt="Pick a date"></a>
                                                &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                               
                                                <td class="a-right">
                    <%=Resources.Investigation_ClientDisplay.Investigation_WorkListFromVisitToVisit_aspx_06 %>
                                                </td>
                                                <td class="a-left">
                    <asp:DropDownList ID="ddlMode" runat="server" CssClass="ddlsmall" Width="80px" meta:resourcekey="ddlModeResource1">
                        <asp:ListItem Text="Select" Value="0" meta:resourcekey="ListItemResource4"></asp:ListItem>
                        <asp:ListItem Text="All" Value="-1" meta:resourcekey="ListItemResource5"></asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                       
                            </tr>
                            <tr>
                                <td class="a-right">
                    <%=Resources.Investigation_ClientDisplay.Investigation_WorkListFromVisitToVisit_aspx_07 %>
                                </td>
                                <td >
                    <asp:DropDownList ID="ddlLocation" runat="server" CssClass="ddlsmall" meta:resourcekey="ddlLocationResource1">
                                    </asp:DropDownList>
                                </td>
                                <td class="a-right">
                    <%=Resources.Investigation_ClientDisplay.Investigation_WorkListFromVisitToVisit_aspx_08 %>
                                </td>
                                <td>
                    <asp:DropDownList ID="ddlClients" ToolTip="Select Client" runat="server" CssClass="ddlsmall"
                        meta:resourcekey="ddlClientsResource1">
                                    </asp:DropDownList>
                                </td>
                                
                                            <td class="v-top a-right">
                    <asp:Label ID="lblPreference" Text="Preference" runat="server" meta:resourcekey="lblPreferenceResource1"></asp:Label>
                                            </td>
                                            <td class="v-top">
                                                <span class="richcombobox w-80">
                        <asp:DropDownList ID="ddlPreference" CssClass="ddl" runat="server" Width="80px" meta:resourcekey="ddlPreferenceResource1">
                                                    </asp:DropDownList>
                                                </span>
                                            </td>
                                       
                            </tr>
                            <tr>
                                <td class="a-right">
                    <%=Resources.Investigation_ClientDisplay.Investigation_WorkListFromVisitToVisit_aspx_09 %>
                                </td>
                                <td>
                    <asp:TextBox ID="txtInvName" class="tb1" runat="server" meta:resourcekey="txtInvNameResource1"></asp:TextBox>
                                </td>
                                <td class="a-right">
                    <%=Resources.Investigation_ClientDisplay.Investigation_WorkListFromVisitToVisit_aspx_10 %>
                                </td>
                                <td>
                    <asp:TextBox ID="txtWardName" runat="server" CssClass="Txtboxsmall" meta:resourcekey="txtWardNameResource1"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="a-right">
                    <%=Resources.Investigation_ClientDisplay.Investigation_WorkListFromVisitToVisit_aspx_11 %>
                                </td>
                                <td>
                    <asp:DropDownList ID="ddlPriority" runat="server" CssClass="ddlsmall" meta:resourcekey="ddlPriorityResource1">
                        <asp:ListItem Text="Select" Value="-1" Selected="True" meta:resourcekey="ListItemResource6"></asp:ListItem>
                        <asp:ListItem Text="VIP" Value="0" meta:resourcekey="ListItemResource7"></asp:ListItem>
                        <asp:ListItem Text="Emergency" Value="1" meta:resourcekey="ListItemResource8"></asp:ListItem>
                                    </asp:DropDownList>
                    <asp:CheckBox ID="chkIsIncludevalues" runat="server" Checked="True" Text="Include Result Values"
                        meta:resourcekey="chkIsIncludevaluesResource1" />
                                </td>
                                <td class="a-right">
                    <%=Resources.Investigation_ClientDisplay.Investigation_WorkListFromVisitToVisit_aspx_12 %>
                                </td>
                                <td>
                    <asp:DropDownList ID="ddlDept" runat="server" CssClass="ddlsmall" meta:resourcekey="ddlDeptResource1">
                                    </asp:DropDownList>
                                </td>
                                <td class="a-left">
                                    <asp:Button ID="btnFinish" runat="server" ToolTip="Click here to Generate Work List"
                                        Style="cursor: pointer;" CssClass="btn" onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'"
                                        Text=" Generate Work List " UseSubmitBehavior="true" OnClick="btnFinish_Click"
                                        OnClientClick="javascript:return validateVisit();"   meta:resourcekey="btnFinishResource1"  />
                                </td>
                                <td></td>
                            </tr>
                        </table>
                        
                        <asp:Label ID="lblStatus" Visible="false" runat="server" ForeColor="#333" Text="No Matching Records Found!"
						 meta:resourcekey="lblStatusResource1"></asp:Label>
                        <table id="tabPrintButton" style="display:inline ;" runat="server" class="w-100p" >
                            <tr>
                                <td class="a-right">
                                    <asp:HyperLink ID="hypLnkPrint" Font-Bold="true" Font-Size="12px" ForeColor="#000000"
                        Target="WorkListWindow" runat="server" ToolTip="Click Here To Print Work List"
                        meta:resourcekey="hypLnkPrintResource1">
                        <img id="imgPrint" runat="server" style="border-width: 0px;" src="~/Images/printer.gif" />
                        &nbsp;<u> Print</u></asp:HyperLink>
                                </td>
                            </tr>
                        </table>
                        
        <asp:Label ID="lbltxtSTR" Visible="False" BackColor="AliceBlue" runat="server" Text="** IS IN CANCEL STATUS"
            meta:resourcekey="lbltxtSTRResource1"></asp:Label>
                        <asp:Table ID="listTab" runat="server" CssClass="w-100p searchPanel"
                            BorderColor="#000" ForeColor="#000"  meta:resourcekey="listTabResource1">
                        </asp:Table>
                    </div>
      <Attune:Attunefooter ID="Attunefooter" runat="server" />         
     <asp:HiddenField ID="hdnOrgID" runat="server" />
     <asp:HiddenField ID="hdnMessages" runat="server" />
<%--     <script type="text/javascript" src="../Scripts/jquery.min.js"></script>
     <script type="text/javascript" src="../Scripts/jquery-ui.min.js"></script> --%>
     

 <%--Script for AutoComplete of Investigation Name--%>
<script type="text/javascript">
    $(function() {
    $("#txtInvName").addClass("Txtboxsmall");
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
