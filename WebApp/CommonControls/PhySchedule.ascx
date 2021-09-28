<%@ Control Language="C#" AutoEventWireup="true" CodeFile="PhySchedule.ascx.cs" Inherits="CommonControls_PhySchedule" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
<style type="text/css">
    </style>
<asp:UpdateProgress ID="prog1" runat="server">
    <ProgressTemplate>
        <div id="progressBackgroundFilter" class="a-center">
        </div>
        <div id="processMessage" class="a-center w-20p">
            <asp:Image ID="img1" Width="40px" Height="40px" runat="server" ImageUrl="../Images/loading.GIF"
                meta:resourcekey="img1Resource1" />
        </div>
    </ProgressTemplate>
</asp:UpdateProgress>
<asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>

        <script language="javascript">
            function ChangeStyle(idval) {
                document.getElementById('<%= hdnMonth.ClientID %>').value = idval;
                document.getElementById('<%= btnSub.ClientID %>').click();
                document.getElementById(idval).style.cssclass = 'Mheader';

                var len = document.forms[0].elements.length;
                for (var j = 0; j < len; j++) {
                    if (document.forms[0].elements[j].type == "button") {

                        if (idval == document.forms[0].elements[j].id) {
                            document.forms[0].elements[j].className = "btnSel";

                        }
                        else {
                            document.forms[0].elements[j].className = "btn";
                        }
                    }
                }
            }

            function SelectedData(idData) {
                var tempData = document.getElementById(idData);
                var temValue = tempData.value;
                var idVal = document.getElementById('<%= hdnSelectedID.ClientID %>').value;
                var idUnique = document.getElementById('<%= hdnCheckedState.ClientID %>').value;

                if (tempData.checked == true) {
                    idVal = idVal + "~" + temValue;
                    idUnique = idUnique + '~' + idData;
                }
                else {
                    var iSplit = new Array();
                    var idSplit = new Array();

                    iSplit = idVal.split('~');
                    idSplit = idUnique.split('~');

                    var icount = 0;
                    if (iSplit.length > 0) {
                        for (icount = 0; icount < iSplit.length; icount++) {
                            if (iSplit[icount] == temValue) {
                                iSplit[icount] = "";
                                idSplit[icount] = "";
                            }
                        }
                    }
                    var SIDtempDatas = "";
                    var SIDtempIDs = "";
                    for (icount = 0; icount < iSplit.length; icount++) {
                        if (iSplit[icount] != "") {
                            SIDtempDatas += iSplit[icount] + "~";
                            SIDtempIDs += idSplit[icount] + "~";
                        }
                    }
                    idVal = SIDtempDatas;
                    idUnique = SIDtempIDs;
                }
                if (idVal != "") {

                    if ("<%= PostDifferentPage %>" == "") {

                        document.getElementById('<%= btnRelatedsch.ClientID %>').style.display = 'block';
                        document.getElementById('<%= btnRelated.ClientID %>').style.display = 'none';
                    }
                    else {
                        document.getElementById('<%= btnRelated.ClientID %>').style.display = 'block';
                        document.getElementById('<%= btnRelatedsch.ClientID %>').style.display = 'none';
                    }
                }
                else {
                    document.getElementById('<%= btnRelated.ClientID %>').style.display = 'none';
                    document.getElementById('<%= btnRelatedsch.ClientID %>').style.display = 'none';
                }
                document.getElementById('<%= hdnSelectedID.ClientID %>').value = idVal;
                document.getElementById('<%= hdnCheckedState.ClientID %>').value = idUnique;

                //        chkBoxesSelect();

                return false;

            }

            //    function chkBoxesSelect() {
            //        var iVals = document.getElementById('<%= hdnCheckedState.ClientID %>').value;
            //        if (iVals != "") {
            //            var idSplit = new Array();
            //            idSplit = iVals.split('~');
            //            for (var i = 0; i < idSplit.length; i++) {
            //                
            //                
            //            }
            //        }
            //    }
    
        </script>

        <table id="Table7" class="w-100p">
            <tr>
                <td colspan="6" class="blackfontcolormedium">
                    <asp:Label ID="Rs_Schedules" runat="server" Text="Schedules" meta:resourcekey="Rs_SchedulesResource1"></asp:Label>
                </td>
                <td class="blackfontcolormedium">
                </td>
            </tr>
            <tr>
                <td class="blackfontcolormedium a-right" colspan="7">
                    <div style="display: none;">
                        <asp:Label ID="Rs_Select_Spec" runat="server" Text="Select Specialty :" meta:resourcekey="Rs_Select_SpecResource1"></asp:Label>
                        &nbsp;&nbsp;
                        <asp:DropDownList ID="ddlSpeciality" runat="server" CssClass="ddlsmall" AutoPostBack="True"
                            OnSelectedIndexChanged="lNext_Click" meta:resourcekey="ddlSpecialityResource1">
                            <%-- andews  <asp:ListItem Text="--All--" Selected="True" Value="0" meta:resourcekey="ListItemResource1"></asp:ListItem>--%>
                        </asp:DropDownList>
                    </div>
                    <div style="display: none;">
                        <asp:Label ID="Rs_Remind_Pati" runat="server" Text="Remind Patients by :" meta:resourcekey="Rs_Remind_PatiResource1"></asp:Label>
                        &nbsp;&nbsp;
                        <asp:DropDownList ID="ddlReminder" runat="server" CssClass="ddlsmall" >
                   <%--  andrews       <asp:ListItem Text="E-Mail" Value="email" Selected="True" meta:resourcekey="ListItemResource2"></asp:ListItem>
                            <asp:ListItem Text="SMS" Value="SMS" meta:resourcekey="ListItemResource3"></asp:ListItem>
                            <asp:ListItem Text="Both(SMS And E-Mail)" meta:resourcekey="ListItemResource4"></asp:ListItem>--%>
                        </asp:DropDownList>
                        <asp:Button ID="btnRemind" Text="Remind" CssClass="btn" runat="server" meta:resourcekey="btnRemindResource1" />
                    </div>
                    <asp:Button ID="btnRelated" Style="display: none;" Text="View Schedules" CssClass="btn"
                        runat="server" meta:resourcekey="btnRelatedResource1" />
                    <asp:Button ID="btnRelatedsch" runat="server" CssClass="btn" Style="display: none;"
                        Text="View Schedules" OnClick="btnRelated_Click" meta:resourcekey="btnRelatedschResource1" />
                </td>
            </tr>
            <tr>
                <td colspan="7">
                    <table id="tblHide" runat="server" class="a-center w-100p">
                        <tr runat="server">
                            <th colspan="6" class="a-left v-middle" scope="col" runat="server">
                                <div id="dvMonths" runat="server">
                                </div>
                            </th>
                        </tr>
                        <tr runat="server">
                            <th colspan="6" nowrap="nowrap" class="dataheader a-center v-middle" scope="col"
                                runat="server">
                                <asp:LinkButton ID="lnkWeek1" Style="color: Black; font-weight: normal;" runat="server"
                                    OnClick="lNext_Click" Text="Week1" meta:resourcekey="lnkWeek1Resource1"></asp:LinkButton>
                                &nbsp;|&nbsp;
                                <asp:LinkButton ID="lnkWeek2" Style="color: Black; font-weight: normal;" runat="server"
                                    OnClick="lNext_Click" Text="Week2" meta:resourcekey="lnkWeek2Resource1"></asp:LinkButton>
                                &nbsp;|&nbsp;
                                <asp:LinkButton ID="lnkWeek3" Style="color: Black; font-weight: normal;" runat="server"
                                    OnClick="lNext_Click" Text="Week3" meta:resourcekey="lnkWeek3Resource1"></asp:LinkButton>
                                &nbsp;|&nbsp;
                                <asp:LinkButton ID="lnkWeek4" Style="color: Black; font-weight: normal;" runat="server"
                                    OnClick="lNext_Click" Text="Week4" meta:resourcekey="lnkWeek4Resource1"></asp:LinkButton>
                                &nbsp;|&nbsp;
                                <asp:LinkButton ID="lnkWeek5" Style="color: Black; font-weight: normal;" runat="server"
                                    OnClick="lNext_Click" Text="Week5" meta:resourcekey="lnkWeek5Resource1"></asp:LinkButton>
                                &nbsp;|&nbsp;
                                <asp:LinkButton ID="lnkWeek6" Style="color: Black; font-weight: normal;" runat="server"
                                    OnClick="lNext_Click" Text="Week5" meta:resourcekey="lnkWeek6Resource1"></asp:LinkButton>
                            </th>
                        </tr>
                        <tr runat="server">
                            <td runat="server">
                                <div class="a-center">
                                    <span id="phySch_TabContainer1_TabPanel1_lday1">
                                        <asp:Label ID="lday1" runat="server" meta:resourcekey="lday1Resource1"></asp:Label></span></div>
                            </td>
                            <td runat="server">
                                <div class="a-center">
                                    <span id="phySch_TabContainer1_TabPanel1_lday2">
                                        <asp:Label ID="lday2" runat="server" meta:resourcekey="lday2Resource1"></asp:Label></span></div>
                            </td>
                            <td runat="server">
                                <div class="a-center">
                                    <span id="phySch_TabContainer1_TabPanel1_lday3">
                                        <asp:Label ID="lday3" runat="server" meta:resourcekey="lday3Resource1"></asp:Label></span></div>
                            </td>
                            <td runat="server">
                                <div class="a-center">
                                    <span id="phySch_TabContainer1_TabPanel1_lday4">
                                        <asp:Label ID="lday4" runat="server" meta:resourcekey="lday4Resource1"></asp:Label></span></div>
                            </td>
                            <td runat="server">
                                <div class="a-center">
                                    <span id="phySch_TabContainer1_TabPanel1_lday5">
                                        <asp:Label ID="lday5" runat="server" meta:resourcekey="lday5Resource1"></asp:Label></span></div>
                            </td>
                            <td runat="server">
                                <div class="a-center">
                                    <span id="phySch_TabContainer1_TabPanel1_lday6">
                                        <asp:Label ID="lday6" runat="server" meta:resourcekey="lday6Resource1"></asp:Label></span></div>
                            </td>
                        </tr>
                        <tr runat="server">
                            <td class="v-top" runat="server">
                                <asp:Repeater ID="rDay1" runat="server">
                                    <ItemTemplate>
                                        <table class="w-100p">
                                            <tr>
                                                <td colspan="2" class="tokenbooking">
                                                    <asp:Label ID="lPName" Text='<%# Eval("Details") %>' runat="server" 
                                                        meta:resourcekey="lPNameResource1"></asp:Label>
                                                    <br />
                                                    <span class="font8" style="font-style: normal;">
                                                        <asp:Label ID="Rs_Select" runat="server" Text="Select to Compare/Book" 
                                                        meta:resourcekey="Rs_SelectResource1"></asp:Label>
                                                        <input type="checkbox" id="chkDetails" onclick="SelectedData(this.id);" runat="server"
                                                            value='<%# Eval("ScheduleID") %>' />
                                                    </span>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="a-center" bgcolor="#33FFFF">
                                                    <span class="innertable">
                                                        <asp:Label ID="Rs_Available" runat="server" Text="Available" 
                                                        meta:resourcekey="Rs_AvailableResource1"></asp:Label><br />
                                                        (<%#Eval("TotalSlots")%>)</span>
                                                </td>
                                                <td class="a-center" bgcolor="#CCFFFF">
                                                    <span class="innertable">
                                                        <asp:Label ID="Rs_Booked" runat="server" Text="Booked" 
                                                        meta:resourcekey="Rs_BookedResource1"></asp:Label><br />
                                                        (<%#Eval("Booked")%>)</span>
                                                </td>
                                            </tr>
                                        </table>
                                    </ItemTemplate>
                                </asp:Repeater>
                                <div id="divnoSchedules" runat="server" visible="False">
                                    <asp:Label ID="Rs_No_data" runat="server" Text="No data Available" 
                                        meta:resourcekey="Rs_No_dataResource1"></asp:Label></div>
                            </td>
                            <td class="v-top" runat="server">
                                <asp:Repeater ID="rDay2" runat="server">
                                    <ItemTemplate>
                                        <table class="w-100p">
                                            <tr>
                                                <td colspan="2" class="tokenbooking">
                                                    <asp:Label ID="lPName" Text='<%# Eval("Details") %>' runat="server" 
                                                        meta:resourcekey="lPNameResource2"></asp:Label>
                                                    <br />
                                                    <span class="font8" style="font-style: normal;">
                                                        <asp:Label ID="Rs_Select1" runat="server" Text="Select to Compare/Book " 
                                                        meta:resourcekey="Rs_Select1Resource1"></asp:Label>
                                                        <input type="checkbox" id="chkDetails" onclick="SelectedData(this.id);" runat="server"
                                                            value='<%# Eval("ScheduleID") %>' />
                                                    </span>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="a-center" bgcolor="#33FFFF">
                                                    <span class="innertable">
                                                        <asp:Label ID="Rs_Available1" runat="server" Text="Available" 
                                                        meta:resourcekey="Rs_Available1Resource1"></asp:Label><br />
                                                        (<%#Eval("TotalSlots")%>)</span>
                                                </td>
                                                <td class="a-center" bgcolor="#CCFFFF">
                                                    <span class="innertable">
                                                        <asp:Label ID="Rs_Booked1" runat="server" Text="Booked" 
                                                        meta:resourcekey="Rs_Booked1Resource1"></asp:Label><br />
                                                        (<%#Eval("Booked")%>)</span>
                                                </td>
                                            </tr>
                                        </table>
                                    </ItemTemplate>
                                </asp:Repeater>
                                <div id="divnoSchedules1" runat="server" visible="False">
                                    <asp:Label ID="Rs_No_data1" runat="server" Text="No data Available" 
                                        meta:resourcekey="Rs_No_data1Resource1"></asp:Label></div>
                            </td>
                            <td class="v-top" runat="server">
                                <asp:Repeater ID="rDay3" runat="server">
                                    <ItemTemplate>
                                        <table class="w-100p">
                                            <tr>
                                                <td colspan="2" class="tokenbooking">
                                                    <asp:Label ID="lPName" Text='<%# Eval("Details") %>' runat="server" 
                                                        meta:resourcekey="lPNameResource3"></asp:Label>
                                                    <br />
                                                    <span class="font8" style="font-style: normal;">
                                                        <asp:Label ID="Rs_Select2" runat="server" Text="Select to Compare/Book" 
                                                        meta:resourcekey="Rs_Select2Resource1"></asp:Label>
                                                        <input type="checkbox" id="chkDetails" onclick="SelectedData(this.id);" runat="server"
                                                            value='<%# Eval("ScheduleID") %>' />
                                                    </span>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="a-center" bgcolor="#33FFFF">
                                                    <span class="innertable">
                                                        <asp:Label ID="Rs_Available2" runat="server" Text="Available" 
                                                        meta:resourcekey="Rs_Available2Resource1"></asp:Label><br />
                                                        (<%#Eval("TotalSlots")%>)</span>
                                                </td>
                                                <td class="a-center" bgcolor="#CCFFFF">
                                                    <span class="innertable">
                                                        <asp:Label ID="Rs_Booked2" runat="server" Text="Booked" 
                                                        meta:resourcekey="Rs_Booked2Resource1"></asp:Label><br />
                                                        (<%#Eval("Booked")%>)</span>
                                                </td>
                                            </tr>
                                        </table>
                                    </ItemTemplate>
                                </asp:Repeater>
                                <div id="divnoSchedules2" runat="server" visible="False">
                                    <asp:Label ID="Rs_No_data2" runat="server" Text="No data Available" 
                                        meta:resourcekey="Rs_No_data2Resource1"></asp:Label></div>
                            </td>
                            <td class="v-top" runat="server">
                                <asp:Repeater ID="rDay4" runat="server">
                                    <ItemTemplate>
                                        <table class="w-100p">
                                            <tr>
                                                <td colspan="2" class="tokenbooking">
                                                    <asp:Label ID="lPName" Text='<%# Eval("Details") %>' runat="server" 
                                                        meta:resourcekey="lPNameResource4"></asp:Label>
                                                    <br />
                                                    <span class="font8" style="font-style: normal;">
                                                        <asp:Label ID="Rs_Select3" runat="server" Text="Select to Compare/Book " 
                                                        meta:resourcekey="Rs_Select3Resource1"></asp:Label>
                                                        <input type="checkbox" id="chkDetails" onclick="SelectedData(this.id);" runat="server"
                                                            value='<%# Eval("ScheduleID") %>' />
                                                    </span>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="a-center" bgcolor="#33FFFF">
                                                    <span class="innertable">
                                                        <asp:Label ID="Rs_Available3" runat="server" Text="Available" 
                                                        meta:resourcekey="Rs_Available3Resource1"></asp:Label><br />
                                                        (<%#Eval("TotalSlots")%>)</span>
                                                </td>
                                                <td class="a-center" bgcolor="#CCFFFF">
                                                    <span class="innertable">
                                                        <asp:Label ID="Rs_Booked3" runat="server" Text="Booked" 
                                                        meta:resourcekey="Rs_Booked3Resource1"></asp:Label><br />
                                                        (<%#Eval("Booked")%>)</span>
                                                </td>
                                            </tr>
                                        </table>
                                    </ItemTemplate>
                                </asp:Repeater>
                                <div id="divnoSchedules3" runat="server" visible="False">
                                    <asp:Label ID="Rs_No_data3" runat="server" Text="No data Available" 
                                        meta:resourcekey="Rs_No_data3Resource1"></asp:Label></div>
                                <p>
                                </p>
                                <p>
                                    &nbsp;</p>
                            </td>
                            <td class="v-top" runat="server">
                                <asp:Repeater ID="rDay5" runat="server">
                                    <ItemTemplate>
                                        <table class="w-100p">
                                            <tr>
                                                <td colspan="2" class="tokenbooking">
                                                    <asp:Label ID="lPName" Text='<%# Eval("Details") %>' runat="server" 
                                                        meta:resourcekey="lPNameResource5"></asp:Label>
                                                    <br />
                                                    <span style="font-size: 8px; font-style: normal;">
                                                        <asp:Label ID="Rs_Select4" runat="server" Text="Select to Compare/Book" 
                                                        meta:resourcekey="Rs_Select4Resource1"></asp:Label>
                                                        <input type="checkbox" id="chkDetails" onclick="SelectedData(this.id);" runat="server"
                                                            value='<%# Eval("ScheduleID") %>' />
                                                    </span>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="a-center" bgcolor="#33FFFF">
                                                    <span class="innertable">
                                                        <asp:Label ID="Rs_Available4" runat="server" Text="Available" 
                                                        meta:resourcekey="Rs_Available4Resource1"></asp:Label><br />
                                                        (<%#Eval("TotalSlots")%>)</span>
                                                </td>
                                                <td class="a-center" bgcolor="#CCFFFF">
                                                    <span class="innertable">
                                                        <asp:Label ID="Rs_Booked4" runat="server" Text="Booked" 
                                                        meta:resourcekey="Rs_Booked4Resource1"></asp:Label><br />
                                                        (<%#Eval("Booked")%>)</span>
                                                </td>
                                            </tr>
                                        </table>
                                    </ItemTemplate>
                                </asp:Repeater>
                                <div id="divnoSchedules4" runat="server" visible="False">
                                    <asp:Label ID="Rs_No_data4" runat="server" Text="No data Available" 
                                        meta:resourcekey="Rs_No_data4Resource1"></asp:Label></div>
                            </td>
                            <td class="v-top" runat="server">
                                <asp:Repeater ID="rDay6" runat="server">
                                    <ItemTemplate>
                                        <table class="w-100p">
                                            <tr>
                                                <td colspan="2" class="tokenbooking">
                                                    <asp:Label ID="lPName" Text='<%# Eval("Details") %>' runat="server" 
                                                        meta:resourcekey="lPNameResource6"></asp:Label></span>
                                                    <br />
                                                    <span class="font8" style="font-style: normal;">
                                                        <asp:Label ID="Rs_Select5" runat="server" Text="Select to Compare/Book " 
                                                        meta:resourcekey="Rs_Select5Resource1"></asp:Label>
                                                        <input type="checkbox" id="chkDetails" onclick="SelectedData(this.id);" runat="server"
                                                            value='<%# Eval("ScheduleID") %>' />
                                                    </span>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="a-center" bgcolor="#33FFFF">
                                                    <span class="innertable">
                                                        <asp:Label ID="Rs_Available5" runat="server" Text="Available" 
                                                        meta:resourcekey="Rs_Available5Resource1"></asp:Label><br />
                                                        (<%#Eval("TotalSlots")%>)</span>
                                                </td>
                                                <td class="a-center" bgcolor="#CCFFFF">
                                                    <span class="innertable">
                                                        <asp:Label ID="Rs_Booked5" runat="server" Text="Booked" 
                                                        meta:resourcekey="Rs_Booked5Resource1"></asp:Label><br />
                                                        (<%#Eval("Booked")%>)</span>
                                                </td>
                                            </tr>
                                        </table>
                                    </ItemTemplate>
                                </asp:Repeater>
                                <div id="divnoSchedules5" runat="server" visible="False">
                                    <asp:Label ID="Rs_No_data5" runat="server" Text="No data Available" 
                                        meta:resourcekey="Rs_No_data5Resource1"></asp:Label></div>
                            </td>
                        </tr>
                    </table>
                    <asp:HiddenField ID="hdnMonth" runat="server" />
                    <asp:HiddenField ID="hdnWeek" runat="server" />
                    <asp:HiddenField ID="hdnSpeciality" runat="server" />
                    <asp:HiddenField ID="hdnSelectedID" runat="server" />
                    <asp:HiddenField ID="hdnCheckedState" runat="server" />
                </td>
            </tr>
        </table>
    </ContentTemplate>
</asp:UpdatePanel>
<asp:Button ID="btnSub" runat="server" OnClick="lNext_Click" Style="display: none;"
    meta:resourcekey="btnSubResource1" />
