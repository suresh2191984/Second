<%@ Control Language="C#" AutoEventWireup="true" CodeFile="RefPhysicianPatSearch.ascx.cs"
    Inherits="CommonControls_RefPhysicianPatSearch" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<link rel="stylesheet" type="text/css" href="../StyleSheets/style.css" />
<%--<asp:Panel ID="pnlPSearch" runat="server" DefaultButton="btnSearch">--%>

<script language="javascript" type="text/javascript">
    function ShowChildGrid(Val) {
        var UTCName = 'uctlPatientSearch_';
        //document.getElementById(UTCName+'HdnID').value = Val;
        var ParantGrd = document.getElementById('uctlPatientSearch_' + 'grdResult');
        for (var i = 0; ParantGrd.rows.length; i++) {
            document.getElementById(UTCName + 'HdnID').value = ParantGrd.rows[i].rowIndex;
            //   document.getElementById('uctlPatientSearch_' + 'DivChild').visible = false;
        }
    }

    function SetRID(ID) {
        document.getElementById('<%= HdnID.ClientID  %>').value = ID;


    }
    function SelectVisit(id, vid, pid, PName) {

        chosen = "";
        var len = document.forms[0].elements.length;
        for (var i = 0; i < len; i++) {
            if (document.forms[0].elements[i].type == "radio") {
                document.forms[0].elements[i].checked = false;
            }
        }
        document.getElementById(id).checked = true;
        document.getElementById('uctlPatientSearch_' + 'hdnVID').value = vid;
        document.getElementById('uctlPatientSearch_' + 'PID').value = pid;
        document.getElementById('uctlPatientSearch_' + 'hdnPNAME').value = PName;
    }

   

 
</script>

<style type="text/css">
    .homecontainer
    {
        background-color: #F4F4F4;
        font-family: Arial,Helvetica,sans-serif… font-size:10pt;
        font-size-adjust: none;
        font-stretch: normal;
        font-style: normal;
        font-variant: normal;
        font-weight: normal;
        height: auto !important;
        left: 6px;
        line-height: normal;
        overflow: visible;
        top: 10px;
        width: 100%;
    }
</style>
<asp:ScriptManager ID="ScriptManager1" runat="server">
</asp:ScriptManager>
<table width="100%" border="0" cellpadding="4" cellspacing="0" class="defaultfontcolor">
    <tr>
        <td style="width: 13%">
            <asp:HiddenField ID="HdnID" runat="server" />
            <asp:HiddenField ID="HdnPID" runat="server" />
            <asp:HiddenField ID="hdnVisitDetail" runat="server" />
            <asp:HiddenField ID="hdnVID" runat="server" />
            <asp:HiddenField ID="PID" runat="server" />
            <asp:HiddenField ID="hdnPNAME" runat="server" />
            <asp:Label ID="Rs_PatientNo" Text="PatientNo" runat="server" meta:resourcekey="Rs_PatientNoResource1"></asp:Label>
        </td>
        <td style="width: 39%">
            <asp:TextBox ID="txtPatientNo" runat="server" MaxLength="16" onkeypress="return onEnterKeyPress(event);" CssClass ="Txtboxsmall"
                meta:resourcekey="txtPatientNoResource1"></asp:TextBox>
        </td>
        <td style="width: 20%">
            <asp:Label Text="Patient Name" ID="Rs_PatientName" runat="server" meta:resourcekey="Rs_PatientNameResource1"></asp:Label>
        </td>
        <td style="width: 28%">
            <asp:TextBox ID="txtPatientName" OnChange="javascript:GetText(document.getElementById('uctlPatientSearch_txtPatientName').value);" CssClass="Txtboxsmall"
                MaxLength="255" runat="server" meta:resourcekey="txtPatientNameResource1"></asp:TextBox>
            <cc1:AutoCompleteExtender ID="AutoCompleteProduct" runat="server" TargetControlID="txtPatientName"
                EnableCaching="False" FirstRowSelected="True" MinimumPrefixLength="2" CompletionListCssClass="listtwo"
                CompletionListItemCssClass="listitemtwo" CompletionListHighlightedItemCssClass="hoverlistitemtwo"
                ServiceMethod="GetPatientListWithDetails" ServicePath="~/InventoryWebService.asmx"
                DelimiterCharacters="" Enabled="True">
            </cc1:AutoCompleteExtender>
        </td>
    </tr>
    <tr>
        <td>
            <asp:Label Text="Patient Age" ID="Rs_PatientAge" runat="server" meta:resourcekey="Rs_PatientAgeResource1"></asp:Label>
        </td>
        <td>
            <asp:TextBox ID="txtDOB" runat="server"  CssClass ="Txtboxverysmall" MaxLength="3" Width="50px" meta:resourcekey="txtDOBResource1"></asp:TextBox>
            <!--  <asp:ImageButton ID="ImgBntCalc"  runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                    CausesValidation="False" /> -->
        </td>
        <td>
            <asp:Label Text="Spouse/Father Name" ID="Rs_SpouseFatherName" runat="server" meta:resourcekey="Rs_SpouseFatherNameResource1"></asp:Label>
        </td>
        <td>
            <asp:TextBox ID="txtRelation" runat="server" MaxLength="50"  CssClass ="Txtboxsmall" meta:resourcekey="txtRelationResource1"></asp:TextBox>
        </td>
    </tr>
    <tr>
        <td>
            <asp:Label Text="Location" ID="Rs_Location" runat="server" meta:resourcekey="Rs_LocationResource1"></asp:Label>
        </td>
        <td>
            <asp:TextBox ID="txtLocation" runat="server" CssClass ="Txtboxsmall" meta:resourcekey="txtLocationResource1"></asp:TextBox>
        </td>
        <td nowrap="nowrap">
            <asp:Label ID="Others" Text="Others" runat="server" meta:resourcekey="OthersResource2"></asp:Label>
            <asp:DropDownList runat="server" ID="ddOthers" CssClass ="ddl" onchange="document.getElementById('uctlPatientSearch_txtOthers').focus();"
                meta:resourcekey="ddOthersResource1">
                <asp:ListItem Selected="True" Text="Select" Value="-1" meta:resourcekey="ListItemResource1"></asp:ListItem>
                <asp:ListItem Selected="False" Text="Occupation" Value="Occupation" meta:resourcekey="ListItemResource2"></asp:ListItem>
                <asp:ListItem Selected="False" Text="Mobile" Value="Mobile" meta:resourcekey="ListItemResource3"></asp:ListItem>
                <asp:ListItem Selected="False" Text="City" Value="City" meta:resourcekey="ListItemResource4"></asp:ListItem>
            </asp:DropDownList>
        </td>
        <td>
            <asp:TextBox ID="txtOthers" runat="server" CssClass="Txtboxsmall" meta:resourcekey="txtOthersResource1"></asp:TextBox>
        </td>
    </tr>
    <tr>
        <td>
            <asp:Label ID="Rs_URNo" Text="URNo" runat="server" meta:resourcekey="Rs_URNoResource1"></asp:Label>
        </td>
        <td colspan="2">
            <asp:TextBox ID="txtURNo" runat="server" MaxLength="50" meta:resourcekey="txtURNoResource1"></asp:TextBox>
            &nbsp;<asp:DropDownList ID="ddlUrnType" runat="server" CssClass ="ddl"  meta:resourcekey="ddlUrnTypeResource1">
            </asp:DropDownList>
        </td>
        <td>
            <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn" onmouseover="this.className='btn1 btnhov1'"
                onmouseout="this.className='btn1'" OnClick="btnSearch_Click" OnClientClick="return CheckPatientSearch();"
                meta:resourcekey="btnSearchResource1" />
            &nbsp;
            <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn" onmouseover="this.className='btn1 btnhov1'"
                onmouseout="this.className='btn1'" OnClick="btnCancel_Click" meta:resourcekey="btnCancelResource1" />
        </td>
    </tr>
    <tr>
        <td>
            &nbsp;
        </td>
        <td>
            &nbsp;
        </td>
        <td>
            &nbsp;
        </td>
        <td>
            &nbsp;
        </td>
    </tr>
    <tr>
        <td colspan="4">
            &nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="lblResult" runat="server" meta:resourcekey="lblResultResource1"></asp:Label>
        </td>
    </tr>
    <tr>
        <td colspan="4" align="center">
            <table width="100%" border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td colspan="4">
                        <table border="0" id="GrdHeader" runat="server" style="display: none" width="100%">
                            <tr class="dataheader1">
                                <td align="left" style="width: 30px">
                                    <asp:Label ID="Rs_Select" Text="Select" runat="server" meta:resourcekey="Rs_SelectResource1"></asp:Label>
                                </td>
                                <td style="width: 80px">
                                    <asp:Label ID="Rs_PatientNumber" Text="Patient Number" runat="server" meta:resourcekey="Rs_PatientNumberResource1"></asp:Label>
                                </td>
                                <td style="width: 120px">
                                    <asp:Label ID="Rs_Name" Text="Name" runat="server" meta:resourcekey="Rs_NameResource1"></asp:Label>
                                </td>
                                <td style="display: none; width: 80px">
                                </td>
                                <td style="width: 80px">
                                    <asp:Label ID="Rs_Age" Text="Age" runat="server" meta:resourcekey="Rs_AgeResource1"></asp:Label>
                                </td>
                                <td style="width: 100px">
                                    <asp:Label ID="Rs_URNNo" Text="URN No" runat="server" meta:resourcekey="Rs_URNNoResource1"></asp:Label>
                                </td>
                                <td style="width: 90px">
                                    <asp:Label ID="Rs_MobileNumber" Text="Mobile Number" runat="server" meta:resourcekey="Rs_MobileNumberResource1"></asp:Label>
                                </td>
                                <td style="width: 80px">
                                    <asp:Label ID="Rs_Address1" Text="Address" runat="server" meta:resourcekey="Rs_Address1Resource1"></asp:Label>
                                </td>
                                <td style="width: 100px; display: none">
                                    <asp:Label ID="Rs_Address2" Text="Address" runat="server" meta:resourcekey="Rs_Address2Resource1"></asp:Label>
                                </td>
                                <td style="display: none">
                                </td>
                            </tr>
                        </table>
                        <table border="0" width="100%">
                            <tr>
                                <td colspan="10">
                                    <asp:GridView ID="grdResult" Width="100%" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                                        DataKeyNames="PatientID" PagerSettings-Mode="NextPrevious" OnRowDataBound="grdResult_RowDataBound"
                                        OnRowCommand="grdResult_RowCommand" OnPageIndexChanging="grdResult_PageIndexChanging"
                                        PageSize="15" meta:resourcekey="grdResultResource1">
                                        <PagerStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                        <%--<HeaderStyle CssClass="dataheader1" />--%>
                                        <PagerSettings FirstPageText="" LastPageText="" Mode="NumericFirstLast" NextPageText=""
                                            PageButtonCount="5" PreviousPageText="" />
                                        <Columns>
                                            <asp:BoundField Visible="false" DataField="PatientID" HeaderText="PatientID" meta:resourcekey="BoundFieldResource1" />
                                            <asp:TemplateField meta:resourcekey="TemplateFieldResource1">
                                                <ItemTemplate>
                                                    <table border="0" width="100%" align="left">
                                                        <tr>
                                                            <td style="width: 5%;" nowrap="nowrap">
                                                                <asp:RadioButton ID="rdSel" runat="server" ToolTip="Select Row" GroupName="PatientSelect" />
                                                            </td>
                                                            <td align="center" style="width: 14%" nowrap="nowrap">
                                                                <%# DataBinder.Eval(Container.DataItem, "PatientNumber")%>
                                                            </td>
                                                            <td align="left" width="20%" nowrap="nowrap">
                                                                <asp:ImageButton ID="imgClick" ToolTip="Click here To View Visit details" runat="server"
                                                                    ImageUrl="~/Images/collapse.jpg" CommandName="ShowChild" CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>' />
                                                                <%--<img src="../expand.gif" id="imgClick" alt='<%# DataBinder.Eval(Container, "RowIndex") %>' onclick="SetRID(<%# DataBinder.Eval(Container, "RowIndex") %>)" />--%>
                                                                <asp:LinkButton ID="lblNaME" ToolTip="Click here To View Visit details" ForeColor="Black"
                                                                    runat="server" CommandName="ShowVisit" Text='<%# Bind("Name") %>' CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>'></asp:LinkButton>
                                                            </td>
                                                            <td align="left" style="display: none">
                                                                <asp:TextBox ID="txtPatientId" Text='<%#Bind("PatientID") %>' runat="server"></asp:TextBox>
                                                            </td>
                                                            <td align="left" width="12%">
                                                                <asp:Label ID="lblAge" runat="server" Text='<%#Bind("Age") %>'></asp:Label>
                                                            </td>
                                                            <td align="left" style="width: 15%" nowrap="nowrap">
                                                                <%# DataBinder.Eval(Container.DataItem, "URNO")%>
                                                            </td>
                                                            <td align="left" width="12%">
                                                                <%# DataBinder.Eval(Container.DataItem, "MobileNumber")%>
                                                            </td>
                                                            <td align="center" width="15%">
                                                                <%# DataBinder.Eval(Container.DataItem, "Address")%>
                                                            </td>
                                                            <td align="left" style="display: none">
                                                                <%# DataBinder.Eval(Container.DataItem, "OrgID")%>
                                                            </td>
                                                            <td align="center" style="display: none">
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="10">
                                                                <asp:TemplateField HeaderText="Questions" HeaderStyle-HorizontalAlign="Center" runat="server">
                                                                    <itemtemplate>
                                                                                   
                                                                                    <div style="width: 100%;">
                                                                                    <div id="NoRecord" runat="server" style=" height:20Px; display:none; background-color:#3093cf;">
                                                                                    <asp:Label ID="lblNoRecord" runat="server" Text="No Records Found."></asp:Label>
                                                                                    </div>
                                                                                            <div runat="server"  id="DivChild" style="display:none; background-color:#3093cf;" >
                                                                                             
                                                                                                  
                                                                                                    <asp:GridView ID="ChildGrid" EmptyDataText="No Record Found" runat="server" AllowPaging="True" CellPadding="1" AutoGenerateColumns="False"
                                                                                                        DataKeyNames="PatientVisitID,Name" Width="98%" OnRowDataBound="ChildGrid_RowDataBound"
                                                                                                        ForeColor="#ffffff" OnPageIndexChanging="ChildGrd_PageIndexChanging" PageSize="2" PagerSettings-Mode="NextPrevious"
                                                                                                        CssClass="mytable1" PagerSettings-Visible="true">
                                                                                                        <PagerTemplate>
                                                                                                            <tr>
                                                                                                                <td colspan="5" align="center">
                                                                                                                    <asp:ImageButton ID="lnkPrev" CommandName="Page" runat="server" CausesValidation="false"
                                                                                                                        CommandArgument="Prev" ImageUrl="~/Images/previousimage.png" Width="18px" Height="18px" />
                                                                                                                    <asp:ImageButton ID="lnkNext" CommandName="Page" runat="server" CausesValidation="false"
                                                                                                                        CommandArgument="Next" ImageUrl="~/Images/nextimage.png" Width="18px" Height="18px" />
                                                                                                                </td>
                                                                                                            </tr>
                                                                                                        </PagerTemplate>
                                                                                                        <HeaderStyle CssClass="dataheader1" />
                                                                                                        <Columns>
                                                                                                            <asp:BoundField Visible="false" DataField="PatientVisitID" HeaderText="PatientVisitID" />
                                                                                                            <asp:TemplateField HeaderText="Select">
                                                                                                                <ItemTemplate>
                                                                                                                    <asp:RadioButton ID="rdSel" runat="server" ToolTip="Select Row" GroupName="VisitSelect" />
                                                                                                                </ItemTemplate>
                                                                                                            </asp:TemplateField>
                                                                                                            <asp:BoundField DataField="PatientName" HeaderText="Patient Name" />
                                                                                                            <asp:BoundField DataField="VisitDate" DataFormatString="{0:dd MMM yyyy}" HeaderText="Visit Date" />
                                                                                                            
                                                                                                            <asp:BoundField DataField="ReferingPhysicianName" HeaderText="Ref Physician" />
                                                                                                            <%--<asp:TemplateField HeaderText="Reporting Radiologist">
                                                                                                            <ItemTemplate>
                                                                                                                <asp:Label Text='<% Bind("PerformingPhysicain") %>' ID="lblReportingRadiologist" runat="server" />
                                                                                                            </ItemTemplate>
                                                                                                        </asp:TemplateField>--%>
                                                                                                        
                                                                                                        <asp:BoundField DataField="Investigation" HeaderText="Investigation List" />
                                                                                                        <asp:BoundField DataField="PerformingPhysicain" HeaderText="Reporting Radiologist" />
                                                                                                                        <asp:BoundField DataField="VisitPurposeName" HeaderText="Visit Purpose" />
                                                                                                            <asp:BoundField DataField="Status" HeaderText="Report Status" />
                                                                                                            <%--  <asp:TemplateField HeaderText="Physician Name">
                                                                                                                        <ItemTemplate>
                                                                                                                            <asp:Label ID="lblPhysicianName" runat='server' Text='<%#Bind("Name") %>'></asp:Label>
                                                                                                                        </ItemTemplate>
                                                                                                                    </asp:TemplateField>
                                                                                                            <asp:BoundField DataField="Location" HeaderText="Location" />--%>
                                                                                                        </Columns>
                                                                                                    </asp:GridView>&nbsp;
                                                                                                   
                                                                                                        <asp:DropDownList ID="ddlVisitActionName" CssClass="ddlTheme" runat="server">
                                                                                                        </asp:DropDownList>
                                                                                                        <asp:Button ID="btnGo" runat="server" Text="Go" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                                                                             onmouseout="this.className='btn'" OnClick="btnGo_Click"  />
                                                                                                                                                                                              </div>
                                                                                       
                                                                                    </div>
                                                                                </itemtemplate>
                                                                </asp:TemplateField>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<asp:HiddenField ID="ShowID" runat="server" />

<script language="javascript" type="text/javascript">
    function ShowTable() {
        if (document.getElementById('<%=ShowID.ClientID %>').value == "") {
            document.getElementById('<%=ShowID.ClientID %>').value = "Show";
        }
        else
            form1.submit();

    }
    function GetText(pName) {
        if (pName != "") {
            // var Temp = pName.split('(');
            //if (Temp.length >= 2) {
            document.getElementById('<%=txtPatientName.ClientID %>').value = pName;
            // }
        }
    }
    function CheckVisitID(DDlID) {

        if (document.getElementById('<%=hdnVID.ClientID %>').value == '') {
            document.getElementById(DDlID).focus();
            var userMsg = SListForApplicationMessages.Get('CommonControls\\RefPhysicianPatSearch.ascx_1');
            if (userMsg != null) {
                alert(userMsg);
            } else {
                alert('Please Select Visit Detail');
            }
            return false;
        }
        else if (document.getElementById(DDlID) != undefined) {
            document.getElementById('<%=hdnVisitDetail.ClientID %>').value = document.getElementById(DDlID)[document.getElementById(DDlID).selectedIndex].innerHTML
            document.getElementById('<%=hdnRowInx.ClientID %>').value = document.getElementById(DDlID).selectedIndex;
            return true;
        }
    }
</script>

<input type="hidden" id="pid" name="pid" />
<input type="hidden" id="patOrgID" name="patOrgID" />
<input type="hidden" id="hdnRowInx" runat="server" name="hdnRowInx" />
<%--</asp:Panel>--%>