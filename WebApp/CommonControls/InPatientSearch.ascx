<%@ Control Language="C#" AutoEventWireup="true" CodeFile="InPatientSearch.ascx.cs"
    Inherits="CommonControls_InPatientSearch" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<style type="text/css">
    .divPicturePopup
    {
        display: none;
        z-index: 1000;
        position: absolute;
        background-color: White;
        padding: 2px;
        border: solid 1px black;
    }
    table.gridView .dataheader1.gridHeader td {color:#fff;}
    
</style>
<asp:Panel ID="pnlPSearch" runat="server" DefaultButton="btnSearch" meta:resourcekey="pnlPSearchResource1">
    <table class="defaultfontcolor w-100p">
        <tr>
            <td class="w-100p">
                <table class="w-100p dataheader3">
                    <tr>
                        <td class="w-15p">
                         <asp:Label ID="lbpatnum" runat="server" Text="Patient No" meta:resourcekey="lbpatnumResource1" ></asp:Label>
                        </td>
                        <td class="w-39p">
                            <asp:TextBox ID="txtPatientNo" runat="server" MaxLength="16" onkeypress="return onEnterKeyPress(event);"
                              CssClass="Txtboxsmall"   meta:resourcekey="txtPatientNoResource1"></asp:TextBox>
                        </td>
                        <td class="w-20p">
                           <asp:Label ID="lbpatname" runat="server" Text="Patient Name" meta:resourcekey="lbpatnameResource1" ></asp:Label>
                        </td>
                        <td class="w-28p">
                            <asp:TextBox ID="txtPatientName" runat="server" CssClass="Txtboxsmall"  MaxLength="255" meta:resourcekey="txtPatientNameResource1"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                <asp:Label ID="lbpatno" runat="server" Text="Patient Age" meta:resourcekey="lbpatnoResource1"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtDOB" runat="server" CssClass="Txtboxsmall"  MaxLength="3" Width="50px" meta:resourcekey="txtDOBResource1"></asp:TextBox>
                            <!--  <asp:ImageButton ID="ImgBntCalc"  runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                    CausesValidation="False" /> -->
                        </td>
                        <td>
                        <asp:Label ID="lbroomno" runat="server" Text="Room No" meta:resourcekey="lbroomnoResource1" ></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtRoomNo" runat="server" MaxLength="3" CssClass="Txtboxsmall"  meta:resourcekey="txtRoomNoResource1"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                        <asp:Label ID="lbmobnum" runat="server" Text="Mobile No"  meta:resourcekey="lbmobnumResource1" ></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtCellNo" runat="server" MaxLength="12" CssClass="Txtboxsmall"  meta:resourcekey="txtCellNoResource1"></asp:TextBox>
                        </td>
                        <td nowrap="nowrap">
                     <asp:Label ID="lpofadmis" runat="server" Text="Purpose of Admission" meta:resourcekey="lpofadmisResource1" ></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtPurpose" Visible="False" Width="15px"  CssClass="Txtboxsmall" runat="server" meta:resourcekey="txtPurposeResource1"></asp:TextBox>
                            <asp:DropDownList ID="purposeOfAdmission" runat="server" CssClass="ddlsmall" TabIndex="39" meta:resourcekey="purposeOfAdmissionResource1">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td>
                        <asp:Label ID="lbnat" runat="server" Text="Nationality" meta:resourcekey="lbnatResource1"  ></asp:Label>
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlNationality" runat="server" TabIndex="14" CssClass="ddlsmall"  meta:resourcekey="ddlNationalityResource1">
                            </asp:DropDownList>
                        </td>
                        <td>
                          <asp:Label ID="lbcorpinsur" runat="server" Text="Corporate/Insurance" meta:resourcekey="lbcorpinsurResource1" ></asp:Label>
                        </td>
                        <td>
                            <table>
                                <tr>
                                    <td>
                                        <asp:DropDownList ID="ddlType" onChange="javascript:return ShowDDl();" runat="server" CssClass="ddlsmall"
                                            meta:resourcekey="ddlTypeResource1">
                                        </asp:DropDownList>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlTpaName" Style="display: none" runat="server" CssClass="ddlsmall" meta:resourcekey="ddlTpaNameResource1">
                                        </asp:DropDownList>
                                        <asp:DropDownList ID="ddlCorporate" Style="display: none" runat="server" CssClass="ddlsmall" meta:resourcekey="ddlCorporateResource1">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblSmartCardNo" Text="Smart Card No" runat="server" meta:resourcekey="lblSmartCardNoResource1" />
                        </td>
                        <td>
                            <asp:TextBox ID="txtSmartCardNo" runat="server"  CssClass="Txtboxsmall" meta:resourcekey="txtSmartCardNoResource1" />
                        </td>
                        <td>
                            <asp:Label ID="lblIPNo" runat="server" Text="IP No" meta:resourcekey="lblIPNoResource1"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtIPNo" runat="server" CssClass="Txtboxsmall"  MaxLength="16" meta:resourcekey="txtIPNoResource1"></asp:TextBox>
                        </td>
                    </tr>
                    <tr runat="server" id="trRegisterPanel">
                        <td id="Td1" runat="server">
                          <asp:Label ID="lblregdt" runat="server" Text="Registered Date" meta:resourcekey="lblregdtResource1" ></asp:Label>
                            <asp:HiddenField ID="hdnFirstDayWeek" runat="server" />
                            <asp:HiddenField ID="hdnLastDayWeek" runat="server" />
                            <asp:HiddenField ID="hdnFirstDayMonth" runat="server" />
                            <asp:HiddenField ID="hdnLastDayMonth" runat="server" />
                            <asp:HiddenField ID="hdnFirstDayYear" runat="server" />
                            <asp:HiddenField ID="hdnLastDayYear" runat="server" />
                            <asp:HiddenField ID="hdnDateImage" runat="server" />
                            <asp:HiddenField ID="hdnTempFrom" runat="server" />
                            <asp:HiddenField ID="hdnTempTo" runat="server" />
                            <asp:HiddenField ID="hdnTempFromPeriod" runat="server" />
                            <asp:HiddenField ID="hdnTempToPeriod" runat="server" />
                            <asp:HiddenField ID="hdnLastMonthFirst" runat="server" />
                            <asp:HiddenField ID="hdnLastMonthLast" runat="server" />
                            <asp:HiddenField ID="hdnLastWeekFirst" runat="server" />
                            <asp:HiddenField ID="hdnLastWeekLast" runat="server" />
                            <asp:HiddenField runat="server" ID="hdnLastYearFirst" />
                            <asp:HiddenField ID="hdnLastYearLast" runat="server" />
                            
                        </td>
                        <td id="Td2" colspan="3" runat="server">
                            <asp:DropDownList ID="ddlRegisterDate" onChange="javascript:return ShowRegDate();"
                             CssClass="ddlsmall" runat="server">
                            </asp:DropDownList>
                            <div id="divRegDate" style="display: none" runat="server">
                           <asp:Label ID="lbfrmdt" runat="server" Text="From Date" meta:resourcekey="lbfrmdtResource1" ></asp:Label> 
                                <asp:TextBox Width="70px" ID="txtFromDate" runat="server"></asp:TextBox>
                        <asp:Label ID="lbtodt" runat="server" Text="To Date" meta:resourcekey="lbtodtResource1" ></asp:Label> 
                                <asp:TextBox Width="70px" runat="server" ID="txtToDate"></asp:TextBox>
                            </div>
                            <div id="divRegCustomDate" runat="server" style="display: none;">
                             <asp:Label ID="lblfromdate" runat="server" Text="From Date" meta:resourcekey="lblfromdateResource1" ></asp:Label>
                                <asp:TextBox Width="70px" ID="txtFromPeriod" runat="server"></asp:TextBox>
                                <asp:ImageButton ID="ImgBntCalcFrom" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                    CausesValidation="False" />
                                <cc1:MaskedEditExtender ID="MaskedEditExtender5" runat="server" TargetControlID="txtFromPeriod"
                                    Mask="99/99/9999" MaskType="Date" ErrorTooltipEnabled="True" CultureAMPMPlaceholder=""
                                    CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                                    CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                                    Enabled="True" />
                                <cc1:MaskedEditValidator ID="MaskedEditValidator5" runat="server" ControlExtender="MaskedEditExtender5"
                                    ControlToValidate="txtFromPeriod" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                    Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                    ValidationGroup="MKE" ErrorMessage="MaskedEditValidator5" />
                                <cc1:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="txtFromPeriod"
                                    Format="dd/MM/yyyy" PopupButtonID="ImgBntCalcFrom" Enabled="True" />
                               <asp:Label ID="lbtodate" runat="server" Text="To Date" meta:resourcekey="lbtodateResource1" ></asp:Label> 
                                <asp:TextBox Width="70px" runat="server" ID="txtToPeriod"></asp:TextBox>
                                <asp:ImageButton ID="ImgBntCalcTo" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                    CausesValidation="False" />
                                <cc1:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="txtToPeriod"
                                    Mask="99/99/9999" MaskType="Date" ErrorTooltipEnabled="True" CultureAMPMPlaceholder=""
                                    CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                                    CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                                    Enabled="True" />
                                <cc1:MaskedEditValidator ID="MaskedEditValidator1" runat="server" ControlExtender="MaskedEditExtender5"
                                    ControlToValidate="txtToPeriod" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                    Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                    ValidationGroup="MKE" ErrorMessage="MaskedEditValidator1" />
                                <cc1:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="txtToPeriod"
                                    Format="dd/MM/yyyy" PopupButtonID="ImgBntCalcTo" Enabled="True" />
                            </div>
                        </td>
                    </tr>
                    <tr runat="server" id="trAdmissionPanel">
                        <td id="Td3" runat="server">
                          <asp:Label ID="lbadmsdt" runat="server" Text="Admission Date" meta:resourcekey="lbadmsdtResource1" ></asp:Label>
                            <asp:HiddenField ID="AdhdnFirstDayWeek" runat="server" />
                            <asp:HiddenField ID="AdhdnLastDayWeek" runat="server" />
                            <asp:HiddenField ID="AdhdnFirstDayMonth" runat="server" />
                            <asp:HiddenField ID="AdhdnLastDayMonth" runat="server" />
                            <asp:HiddenField ID="AdhdnFirstDayYear" runat="server" />
                            <asp:HiddenField ID="AdhdnLastDayYear" runat="server" />
                            <asp:HiddenField ID="AdhdnDateImage" runat="server" />
                            <asp:HiddenField ID="AdhdnTempFrom" runat="server" />
                            <asp:HiddenField ID="AdhdnTempTo" runat="server" />
                            <asp:HiddenField ID="AdhdnTempFromPeriod" runat="server" />
                            <asp:HiddenField ID="AdhdnTempToPeriod" runat="server" />
                            <asp:HiddenField ID="AdhdnLastMonthFirst" runat="server" />
                            <asp:HiddenField ID="AdhdnLastMonthLast" runat="server" />
                            <asp:HiddenField ID="AdhdnLastWeekFirst" runat="server" />
                            <asp:HiddenField ID="AdhdnLastWeekLast" runat="server" />
                            <asp:HiddenField runat="server" ID="AdhdnLastYearFirst" />
                            <asp:HiddenField ID="AdhdnLastYearLast" runat="server" />
                        </td>
                        <td id="Td4" colspan="3" runat="server">
                            <asp:DropDownList ID="ddlAdmissionDate" onChange="javascript:return ShowAdmDate();"
                           CssClass="ddlsmall" runat="server">
                            </asp:DropDownList>
                            <div id="divAdmDate" style="display: none" runat="server">
                            <asp:Label ID="lblfrmdt" runat="server" Text="From Date" meta:resourcekey="lblfrmdtResource1" ></asp:Label> 
                                <asp:TextBox Width="70px" ID="AdtxtFromDate" runat="server"></asp:TextBox>
                              <asp:Label ID="lbltodt" runat="server" Text="To Date" meta:resourcekey="lbltodtResource1" ></asp:Label> 
                                <asp:TextBox Width="70px" runat="server" ID="AdtxtToDate"></asp:TextBox>
                            </div>
                            <div id="divAdmCustomDate" runat="server" style="display: none;">
                                <asp:Label ID="lbfromdate" runat="server" Text="From Date" meta:resourcekey="lbfromdateResource1" ></asp:Label>
                                <asp:TextBox Width="70px" ID="AdtxtFromPeriod" runat="server"></asp:TextBox>
                                <asp:ImageButton ID="AdImgBntCalcFrom" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                    CausesValidation="False" />
                                <cc1:MaskedEditExtender ID="AdMaskedEditExtender5" runat="server" TargetControlID="AdtxtFromPeriod"
                                    Mask="99/99/9999" MaskType="Date" ErrorTooltipEnabled="True" CultureAMPMPlaceholder=""
                                    CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                                    CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                                    Enabled="True" />
                                <cc1:MaskedEditValidator ID="AdMaskedEditValidator5" runat="server" ControlExtender="AdMaskedEditExtender5"
                                    ControlToValidate="AdtxtFromPeriod" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                    Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                    ValidationGroup="MKE" ErrorMessage="AdMaskedEditValidator5" />
                                <cc1:CalendarExtender ID="AdCalendarExtender1" runat="server" TargetControlID="AdtxtFromPeriod"
                                    Format="dd/MM/yyyy" PopupButtonID="AdImgBntCalcFrom" Enabled="True" />
                                <asp:Label ID="lbltodate" runat="server" Text="To Date" meta:resourcekey="lbltodateResource1" ></asp:Label> 
                                <asp:TextBox Width="70px" runat="server" ID="AdtxtToPeriod"></asp:TextBox>
                                <asp:ImageButton ID="AdImgBntCalcTo" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                    CausesValidation="False" />
                                <cc1:MaskedEditExtender ID="AdMaskedEditExtender1" runat="server" TargetControlID="AdtxtToPeriod"
                                    Mask="99/99/9999" MaskType="Date" ErrorTooltipEnabled="True" CultureAMPMPlaceholder=""
                                    CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                                    CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                                    Enabled="True" />
                                <cc1:MaskedEditValidator ID="AdMaskedEditValidator1" runat="server" ControlExtender="AdMaskedEditExtender5"
                                    ControlToValidate="AdtxtToPeriod" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                    Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                    ValidationGroup="MKE" ErrorMessage="AdMaskedEditValidator1" />
                                <cc1:CalendarExtender ID="AdCalendarExtender2" runat="server" TargetControlID="AdtxtToPeriod"
                                    Format="dd/MM/yyyy" PopupButtonID="AdImgBntCalcTo" Enabled="True" />
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4" align="center">
                            <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn" onmouseover="this.className='btn1 btnhov1'"
                                onmouseout="this.className='btn1'" OnClick="btnSearch_Click" OnClientClick="return CheckINPatientSearch();"
                                meta:resourcekey="btnSearchResource1" />
                            &nbsp;
                            <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn" onmouseover="this.className='btn1 btnhov1'"
                                onmouseout="this.className='btn1'" OnClick="btnCancel_Click" meta:resourcekey="btnCancelResource1" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>
                <asp:CheckBox ID="chkDischarge" Visible="False" runat="server" Text="Need Recent Discharge Patient's Only"
                    meta:resourcekey="chkDischargeResource1" />
            </td>
        </tr>
        <tr>
            <td>
                &nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="lblResult" runat="server" meta:resourcekey="lblResultResource1"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="a-center">
                <table class="w-100p">
                    <tr>
                        <td>
                            <table border="0" id="GrdHeader" runat="server" style="display: table;" class="w-100p gridView">
                                <tr id="Tr1" class="dataheader1 gridHeader" runat="server">
                                    <td id="Td5" class="a-left w-2p" runat="server">
                                    </td>
                                    <td id="Td6" class="a-center w-17p" runat="server">
                       <asp:Label ID="lblname" runat="server" Text="Name" meta:resourcekey="lblnameResource1"></asp:Label>
                                    </td>
                                    <td id="Td7" class="a-center w-7p" runat="server">
                                        <asp:Label ID="lblPatientNumberHeader" runat="server" Text='Patient No.'></asp:Label>
                                    </td>
                                    <td id="Td8" class="a-center w-7p" runat="server">
                                 <asp:Label ID="lblage" runat="server" Text="Age" meta:resourcekey="lblageResource1"></asp:Label>
                                    </td>
                                    <td id="Td9" class="a-center w-10p" runat="server">
                      <asp:Label ID="lblroomno" runat="server" Text="Room/Bed No" meta:resourcekey="lblroomnoResource1"></asp:Label>
                                   </td>
                                    <td id="Td10" class="a-center w-8p" runat="server">
              <asp:Label ID="lblphnum" runat="server" Text="Phone  Number" meta:resourcekey="lblphnumResource1"></asp:Label>
                                    </td>
                                    <td id="Td11" class="a-center w-15p" runat="server">
                         <asp:Label ID="lbladdress" runat="server" Text="Address" meta:resourcekey="lbladdressResource1"></asp:Label>
                                    </td>
                                    <td id="Td12" class="a-center w-7p" runat="server">
                              <asp:Label ID="lbdateofadms" runat="server" Text="Date Of Adm" meta:resourcekey="lbdateofadmsResource1"></asp:Label>
                                    </td>
                                    <td id="Td13" class="a-center w-7p" runat="server">
                   <asp:Label ID="lblpurposeofadms" runat="server" Text="Purpose Of Adm" meta:resourcekey="lblpurposeofadmsResource1"></asp:Label>
                                    </td>
                                    <td id="Td14" class="a-center w-6p" style="display:none;" runat="server">
                               <asp:Label ID="lbcurrdue" runat="server" Text="Curr. Due" meta:resourcekey="lbcurrdueResource1"></asp:Label>
                                    </td>
                                    <td id="Td15" class="a-center w-6p" runat="server">
                         <asp:Label ID="lblpreauthamt" runat="server" Text="Pre AuthAmt" meta:resourcekey="lblpreauthamtResource1"></asp:Label>
                                    </td>
                                    <td id="Td16" class="a-center w-2p" runat="server">
                                        &nbsp;
                                    </td>
                                    <td id="Td17" class="a-center w-3p" runat="server">
                                        &nbsp;
                                    </td>
                                </tr>
                            </table>
                            <table class="w-100p">
                                <tr>
                                    <td>
                                        <asp:GridView ID="grdResult" runat="server" AutoGenerateColumns="False"
                                            DataKeyNames="PatientID" OnRowDataBound="grdResult_RowDataBound" OnRowCommand="grdResult_RowCommand"
                                            meta:resourcekey="grdResultResource1" CssClass="w-100p gridView">
                                            <Columns>
                                                <asp:BoundField DataField="PatientID" HeaderText="PatientID" meta:resourcekey="BoundFieldResource1"
                                                    Visible="False" />
                                                <asp:TemplateField meta:resourcekey="TemplateFieldResource1">
                                                    <ItemTemplate>
                                                        <table id="TabChild" runat="server" class="a-left w-100p">
                                                            <tr id="Tr2" runat="server">
                                                                <td id="Td18" runat="server" nowrap="nowrap" class="w-2p">
                                                                    <asp:RadioButton ID="rdSel" runat="server" GroupName="PatientSelect" ToolTip="Select Row" />
                                                                    
                                                                </td>
                                                                <td id="tdName" runat="server" class="a-left w-17p">
                                                                    <%# DataBinder.Eval(Container.DataItem, "Name") %>
                                                                </td>
                                                                <td id="tdPatientNo" runat="server" class="a-left w-7p">
                                                                    <asp:Label ID="lblPatientNumber" runat="server" Text='<%# Bind("PatientNumber") %>'></asp:Label>
                                                                    <asp:Label ID="lblSeperator" runat="server" Text="/"></asp:Label>
                                                                    <asp:Label ID="lblIPNumber" runat="server" Text='<%# Bind("IPNumber") %>'></asp:Label>
                                                                </td>
                                                                <td id="tdAge" runat="server" class="a-left w-7p" nowrap="nowrap">
                                                                    <asp:Label ID="lblAge" runat="server" Text='<%# Bind("Age") %>'></asp:Label>
                                                                </td>
                                                                <td id="tdBedDetail" runat="server" class="a-left w-10p">
                                                                    <%# DataBinder.Eval(Container.DataItem, "BedDetail") %>
                                                                </td>
                                                                <td id="tdPhoneNumbers" runat="server" align="left" style="width: 8%">
                                                                    <asp:Label ID="lblMobileNumber" runat="server" Text='<%# Bind("MobileNumber") %>'></asp:Label>
                                                                </td>
                                                                <td id="tdAddress" runat="server" class="a-left w-15p">
                                                                    <asp:Label ID="lblAddress" runat="server" Text='<%# Bind("Address") %>'></asp:Label>
                                                                </td>
                                                                <td id="tdRegistrationDTTM" runat="server" class="a-center w-7p">
                                                                    <asp:Label ID="lblRegDate" runat="server" Text='<%# Bind("AdmissionDate") %>'></asp:Label>
                                                                </td>
                                                                <td id="tdPurposeOfAdmissionName" runat="server" class="a-center w-7p">
                                                                    <%# DataBinder.Eval(Container.DataItem, "PurposeOfAdmissionName") %>
                                                                </td>
                                                                <td id="tdDueDetails" runat="server" class="a-right w-6p" style=" display:none;">
                                                                    <%# DataBinder.Eval(Container.DataItem, "DueDetails") %>
                                                                </td>
                                                                <td id="tdPreAuthAmount" runat="server" class="a-center w-6p">
                                                                    <asp:Label ID="lblPreAuthAmount" runat="server" Text='<%# Bind("PreAuthAmount") %>'></asp:Label>
                                                                    <asp:Label ID="lblIsCreditBill" runat="server" Text='<%# Bind("IsCreditBill") %>'
                                                                        Visible="False"></asp:Label>
                                                                </td>
                                                                <td id="PicPatient" runat="server" class="a-right w-2p">
                                                                    <asp:ImageButton ID="imgPatient" runat="server" Height="13px" ImageUrl="~/Images/PhotoViewer.png"
                                                                        Width="13px" />
                                                                </td>
                                                                <td id="tdimgDelete" runat="server" class="a-center w-3p">
                                                                    <asp:ImageButton ID="imgDelete" runat="server" CommandArgument='<%# Eval("PatientID") %>'
                                                                        CommandName="Discharge" ImageUrl="~/Images/report.gif" ToolTip="Do you want to Discharge this Patient?" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>
                                        </asp:GridView>
                                    </td>
                                </tr>
                                <tr id="GrdFooter" runat="server" style="display: none" class="dataheaderInvCtrl">
                                    <td id="Td19" align="center" class="defaultfontcolor" runat="server">
                                        <asp:Label ID="Label1" runat="server" Text="Page"></asp:Label>
                                        <asp:Label ID="lblCurrent" runat="server" Font-Bold="True" ForeColor="Red"></asp:Label>
                                        <asp:Label ID="Label2" runat="server" Text="Of"></asp:Label>
                                        <asp:Label ID="lblTotal" runat="server" Font-Bold="True"></asp:Label>
                                        <asp:Button ID="Btn_Previous" runat="server" Text="Previous" CssClass="btn" OnClick="Btn_Previous_Click" />
                                        <asp:Button ID="Btn_Next" runat="server" Text="Next" CssClass="btn" OnClick="Btn_Next_Click" />
                                        <asp:HiddenField ID="hdnCurrent" runat="server" />
                                        <asp:Label ID="Label3" runat="server" Text="Enter The Page To Go:"></asp:Label>
                                        <asp:TextBox ID="txtpageNo" runat="server"  CssClass="Txtboxverysmall"    onkeypress="return ValidateOnlyNumeric(this);"  ></asp:TextBox>
                                        <asp:Button ID="btnGo1" runat="server" Text="Go" CssClass="btn" OnClick="btnGo_Click1" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <div id="divFullImage" class="divPicturePopup">
        <img alt="Patient Picture" id="imgPopupPatient" runat="server" src="~/Images/ProfileDefault.jpg" />
    </div>
    <input type="hidden" id="pid" name="pid" />
    <input type="hidden" id="PNumber" name="PNumber" />
    <input type="hidden" id="patOrgID" name="patOrgID" />
    <input type="hidden" id="hdnIsSurgeryPatient" name="hdnIsSurgeryPatient" />
    <input type="hidden" id="hdnPatientRegistrationStatus" name="hdnPatientRegistrationStatus" />

    <script type="text/javascript" language="javascript">
        function ShowPicture(id, PictureName) {
            var position = $("#" + id).position();
            document.getElementById('<%=imgPopupPatient.ClientID %>').setAttribute('src', '<%=ResolveUrl("~/Reception/PatientImageHandler.ashx?FileName=' + PictureName + '")%>');
            document.getElementById('divFullImage').style.display = 'block';
            document.getElementById('divFullImage').style.left = position.left - 150;
            document.getElementById('divFullImage').style.top = position.top + 20;
        }

        function HidePicture() {
            document.getElementById('divFullImage').style.display = 'none';
        }
        if (document.getElementById('<%=hdnTempFromPeriod.ClientID %>').value == "1" && document.getElementById('<%=hdnTempToPeriod.ClientID %>').value == "1") {
            document.getElementById('<%=divRegDate.ClientID %>').style.display = 'none';
            document.getElementById('<%=divRegDate.ClientID %>').style.display = 'none';
            document.getElementById('<%=divRegCustomDate.ClientID %>').style.display = 'block';
            document.getElementById('<%=divRegCustomDate.ClientID %>').style.display = 'block';
            document.getElementById('<%=divRegCustomDate.ClientID %>').style.display = 'inline';
            document.getElementById('<%=divRegCustomDate.ClientID %>').style.display = 'inline';
        }
        if (document.getElementById('<%=hdnTempFrom.ClientID %>').value != "" && document.getElementById('<%=hdnTempTo.ClientID %>').value != "") {
            document.getElementById('<%=divRegDate.ClientID %>').style.display = 'block';
            document.getElementById('<%=divRegDate.ClientID %>').style.display = 'block';
            document.getElementById('<%=divRegCustomDate.ClientID %>').style.display = 'none';
            document.getElementById('<%=divRegCustomDate.ClientID %>').style.display = 'none';
            document.getElementById('<%=divRegDate.ClientID %>').style.display = 'inline';
            document.getElementById('<%=divRegDate.ClientID %>').style.display = 'inline';
        }
        if (document.getElementById('<%=AdhdnTempFromPeriod.ClientID %>').value == "1" && document.getElementById('<%=AdhdnTempToPeriod.ClientID %>').value == "1") {
            document.getElementById('<%=divAdmDate.ClientID %>').style.display = 'none';
            document.getElementById('<%=divAdmDate.ClientID %>').style.display = 'none';
            document.getElementById('<%=divAdmCustomDate.ClientID %>').style.display = 'block';
            document.getElementById('<%=divAdmCustomDate.ClientID %>').style.display = 'block';
            document.getElementById('<%=divAdmCustomDate.ClientID %>').style.display = 'inline';
            document.getElementById('<%=divAdmCustomDate.ClientID %>').style.display = 'inline';
        }
        if (document.getElementById('<%=AdhdnTempFrom.ClientID %>').value != "" && document.getElementById('<%=AdhdnTempTo.ClientID %>').value != "") {
            document.getElementById('<%=divAdmDate.ClientID %>').style.display = 'block';
            document.getElementById('<%=divAdmDate.ClientID %>').style.display = 'block';
            document.getElementById('<%=divAdmCustomDate.ClientID %>').style.display = 'none';
            document.getElementById('<%=divAdmCustomDate.ClientID %>').style.display = 'none';
            document.getElementById('<%=divAdmDate.ClientID %>').style.display = 'inline';
            document.getElementById('<%=divAdmDate.ClientID %>').style.display = 'inline';
        }
    </script>

</asp:Panel>

<script type="text/javascript">
    function ShowRegDate() {
        document.getElementById('<%=txtFromDate.ClientID %>').value = "";
        document.getElementById('<%=txtToDate.ClientID %>').value = "";

        document.getElementById('<%=hdnTempFrom.ClientID %>').value = "";
        document.getElementById('<%=hdnTempTo.ClientID %>').value = "";

        document.getElementById('<%=hdnTempFromPeriod.ClientID %>').value = "0";
        document.getElementById('<%=hdnTempToPeriod.ClientID %>').value = "0";
        if (document.getElementById('<%= ddlRegisterDate.ClientID %>').value == "0") {

            document.getElementById('<%=txtFromDate.ClientID %>').value = document.getElementById('<%=hdnFirstDayWeek.ClientID %>').value;
            document.getElementById('<%=txtToDate.ClientID %>').value = document.getElementById('<%=hdnLastDayWeek.ClientID %>').value;

            document.getElementById('<%=txtFromDate.ClientID %>').disabled = true;
            document.getElementById('<%=txtToDate.ClientID %>').disabled = true;
            document.getElementById('<%=hdnTempFrom.ClientID %>').value = document.getElementById('<%=hdnFirstDayWeek.ClientID %>').value;
            document.getElementById('<%=hdnTempTo.ClientID %>').value = document.getElementById('<%=hdnLastDayWeek.ClientID %>').value;

            document.getElementById('<%=divRegDate.ClientID %>').style.display = 'block';
            document.getElementById('<%=divRegDate.ClientID %>').style.display = 'block';
            document.getElementById('<%=divRegDate.ClientID %>').style.display = 'inline';
            document.getElementById('<%=divRegDate.ClientID %>').style.display = 'inline';
            document.getElementById('<%=divRegCustomDate.ClientID %>').style.display = 'none';
            document.getElementById('<%=divRegCustomDate.ClientID %>').style.display = 'none';
        }
        if (document.getElementById('<%= ddlRegisterDate.ClientID %>').value == "1") {
            document.getElementById('<%=txtFromDate.ClientID %>').disabled = true;
            document.getElementById('<%=txtToDate.ClientID %>').disabled = true;
            document.getElementById('<%=txtFromDate.ClientID %>').value = document.getElementById('<%=hdnFirstDayMonth.ClientID %>').value;
            document.getElementById('<%=txtToDate.ClientID %>').value = document.getElementById('<%=hdnLastDayMonth.ClientID %>').value;
            document.getElementById('<%=hdnTempFrom.ClientID %>').value = document.getElementById('<%=hdnFirstDayMonth.ClientID %>').value;
            document.getElementById('<%=hdnTempTo.ClientID %>').value = document.getElementById('<%=hdnLastDayMonth.ClientID %>').value;

            document.getElementById('<%=divRegDate.ClientID %>').style.display = 'block';
            document.getElementById('<%=divRegDate.ClientID %>').style.display = 'block';
            document.getElementById('<%=divRegDate.ClientID %>').style.display = 'inline';
            document.getElementById('<%=divRegDate.ClientID %>').style.display = 'inline';
            document.getElementById('<%=divRegCustomDate.ClientID %>').style.display = 'none';
            document.getElementById('<%=divRegCustomDate.ClientID %>').style.display = 'none';
        }
        if (document.getElementById('<%= ddlRegisterDate.ClientID %>').value == "2") {
            document.getElementById('<%=txtFromDate.ClientID %>').disabled = true;
            document.getElementById('<%=txtToDate.ClientID %>').disabled = true;
            document.getElementById('<%=txtFromDate.ClientID %>').value = document.getElementById('<%=hdnFirstDayYear.ClientID %>').value;
            document.getElementById('<%=txtToDate.ClientID %>').value = document.getElementById('<%=hdnLastDayYear.ClientID %>').value;
            document.getElementById('<%=hdnTempFrom.ClientID %>').value = document.getElementById('<%=hdnFirstDayYear.ClientID %>').value;
            document.getElementById('<%=hdnTempTo.ClientID %>').value = document.getElementById('<%=hdnLastDayYear.ClientID %>').value

            document.getElementById('<%=divRegDate.ClientID %>').style.display = 'block';
            document.getElementById('<%=divRegDate.ClientID %>').style.display = 'block';
            document.getElementById('<%=divRegDate.ClientID %>').style.display = 'inline';
            document.getElementById('<%=divRegDate.ClientID %>').style.display = 'inline';
            document.getElementById('<%=divRegCustomDate.ClientID %>').style.display = 'none';
            document.getElementById('<%=divRegCustomDate.ClientID %>').style.display = 'none';

        }
        if (document.getElementById('<%= ddlRegisterDate.ClientID %>').value == "3") {
            document.getElementById('<%=divRegDate.ClientID %>').style.display = 'none';
            document.getElementById('<%=divRegDate.ClientID %>').style.display = 'none';
            document.getElementById('<%=divRegCustomDate.ClientID %>').style.display = 'block';
            document.getElementById('<%=divRegCustomDate.ClientID %>').style.display = 'block';
            document.getElementById('<%=divRegCustomDate.ClientID %>').style.display = 'inline';
            document.getElementById('<%=divRegCustomDate.ClientID %>').style.display = 'inline';
            document.getElementById('<%=hdnTempFromPeriod.ClientID %>').value = "1";
            document.getElementById('<%=hdnTempToPeriod.ClientID %>').value = "1";

        }
        if (document.getElementById('<%= ddlRegisterDate.ClientID %>').value == "-1") {
            document.getElementById('<%=txtFromDate.ClientID %>').disabled = true;
            document.getElementById('<%=txtToDate.ClientID %>').disabled = true;

            document.getElementById('<%=divRegDate.ClientID %>').style.display = 'none';
            document.getElementById('<%=divRegDate.ClientID %>').style.display = 'none';
            document.getElementById('<%=divRegCustomDate.ClientID %>').style.display = 'none';
            document.getElementById('<%=divRegCustomDate.ClientID %>').style.display = 'none';


        }
        if (document.getElementById('<%= ddlRegisterDate.ClientID %>').value == "4") {
            document.getElementById('<%=txtFromDate.ClientID %>').disabled = true;
            document.getElementById('<%=txtToDate.ClientID %>').disabled = true;
            document.getElementById('<%=txtFromDate.ClientID %>').value = "";
            document.getElementById('<%=txtToDate.ClientID %>').value = "";
            document.getElementById('<%=txtFromPeriod.ClientID %>').value = "";
            document.getElementById('<%=txtToPeriod.ClientID %>').value = "";
            document.getElementById('<%=divRegDate.ClientID %>').style.display = 'none';
            document.getElementById('<%=divRegDate.ClientID %>').style.display = 'none';
            document.getElementById('<%=divRegCustomDate.ClientID %>').style.display = 'none';
            document.getElementById('<%=divRegCustomDate.ClientID %>').style.display = 'none';


        }
        if (document.getElementById('<%= ddlRegisterDate.ClientID %>').value == "5") {
            document.getElementById('<%=txtFromDate.ClientID %>').disabled = true;
            document.getElementById('<%=txtToDate.ClientID %>').disabled = true;
            document.getElementById('<%=txtFromDate.ClientID %>').value = document.getElementById('<%=hdnLastWeekFirst.ClientID %>').value;
            document.getElementById('<%=txtToDate.ClientID %>').value = document.getElementById('<%=hdnLastWeekLast.ClientID %>').value;
            document.getElementById('<%=hdnTempFrom.ClientID %>').value = document.getElementById('<%=hdnLastWeekFirst.ClientID %>').value;
            document.getElementById('<%=hdnTempTo.ClientID %>').value = document.getElementById('<%=hdnLastWeekLast.ClientID %>').value;

            document.getElementById('<%=divRegDate.ClientID %>').style.display = 'block';
            document.getElementById('<%=divRegDate.ClientID %>').style.display = 'block';
            document.getElementById('<%=divRegDate.ClientID %>').style.display = 'inline';
            document.getElementById('<%=divRegDate.ClientID %>').style.display = 'inline';
            document.getElementById('<%=divRegCustomDate.ClientID %>').style.display = 'none';
            document.getElementById('<%=divRegCustomDate.ClientID %>').style.display = 'none';
        }
        if (document.getElementById('<%= ddlRegisterDate.ClientID %>').value == "6") {
            document.getElementById('<%=txtFromDate.ClientID %>').disabled = true;
            document.getElementById('<%=txtToDate.ClientID %>').disabled = true;
            document.getElementById('<%=txtFromDate.ClientID %>').value = document.getElementById('<%=hdnLastMonthFirst.ClientID %>').value;
            document.getElementById('<%=txtToDate.ClientID %>').value = document.getElementById('<%=hdnLastMonthLast.ClientID %>').value;
            document.getElementById('<%=hdnTempFrom.ClientID %>').value = document.getElementById('<%=hdnLastMonthFirst.ClientID %>').value;
            document.getElementById('<%=hdnTempTo.ClientID %>').value = document.getElementById('<%=hdnLastMonthLast.ClientID %>').value;

            document.getElementById('<%=divRegDate.ClientID %>').style.display = 'block';
            document.getElementById('<%=divRegDate.ClientID %>').style.display = 'block';
            document.getElementById('<%=divRegDate.ClientID %>').style.display = 'inline';
            document.getElementById('<%=divRegDate.ClientID %>').style.display = 'inline';
            document.getElementById('<%=divRegCustomDate.ClientID %>').style.display = 'none';
            document.getElementById('<%=divRegCustomDate.ClientID %>').style.display = 'none';
        }
        if (document.getElementById('<%= ddlRegisterDate.ClientID %>').value == "7") {
            document.getElementById('<%=txtFromDate.ClientID %>').disabled = true;
            document.getElementById('<%=txtToDate.ClientID %>').disabled = true;
            document.getElementById('<%=txtFromDate.ClientID %>').value = document.getElementById('<%=hdnLastYearFirst.ClientID %>').value;
            document.getElementById('<%=txtToDate.ClientID %>').value = document.getElementById('<%=hdnLastYearLast.ClientID %>').value;
            document.getElementById('<%=hdnTempFrom.ClientID %>').value = document.getElementById('<%=hdnLastYearFirst.ClientID %>').value;
            document.getElementById('<%=hdnTempTo.ClientID %>').value = document.getElementById('<%=hdnLastYearLast.ClientID %>').value;

            document.getElementById('<%=divRegDate.ClientID %>').style.display = 'block';
            document.getElementById('<%=divRegDate.ClientID %>').style.display = 'block';
            document.getElementById('<%=divRegDate.ClientID %>').style.display = 'inline';
            document.getElementById('<%=divRegDate.ClientID %>').style.display = 'inline';
            document.getElementById('<%=divRegCustomDate.ClientID %>').style.display = 'none';
            document.getElementById('<%=divRegCustomDate.ClientID %>').style.display = 'none';
        }
    }

    function ShowDDl() {

        var obj = document.getElementById('<%= ddlType.ClientID %>');

        if (obj.options[obj.selectedIndex].value == 1) {
            document.getElementById('<%= ddlCorporate.ClientID %>').style.display = "block";
            document.getElementById('<%= ddlTpaName.ClientID %>').style.display = "none";
            document.getElementById('<%= ddlTpaName.ClientID %>').selectedIndex = "0";
        }
        else if (obj.options[obj.selectedIndex].value == 2) {
            document.getElementById('<%= ddlTpaName.ClientID %>').style.display = "block";
            document.getElementById('<%= ddlCorporate.ClientID %>').style.display = "none";
            document.getElementById('<%= ddlCorporate.ClientID %>').selectedIndex = "0";
        }
        else {
            document.getElementById('<%= ddlCorporate.ClientID %>').selectedIndex = "0";
            document.getElementById('<%= ddlTpaName.ClientID %>').selectedIndex = "0";
            document.getElementById('<%= ddlCorporate.ClientID %>').style.display = "none";
            document.getElementById('<%= ddlTpaName.ClientID %>').style.display = "none";
        }
        return false;
    }
    function CheckINPatientSearch() {

        if (document.getElementById('<%= txtIPNo.ClientID %>') != null && document.getElementById('<%= chkDischarge.ClientID %>') != null) {
            if (document.getElementById('<%= txtIPNo.ClientID %>').style.visibility == 'visible' && document.getElementById('<%= chkDischarge.ClientID %>').style.visibility == 'visible') {


                if (document.getElementById('<%= txtPatientNo.ClientID %>').value == '' && document.getElementById('<%= txtPatientName.ClientID %>').value == '' &&
    document.getElementById('<%= txtDOB.ClientID %>').value == '' && document.getElementById('<%= txtRoomNo.ClientID %>').value == '' && document.getElementById('<%= txtSmartCardNo.ClientID %>').value == '' &&
    document.getElementById('<%= txtCellNo.ClientID %>').value == '' && document.getElementById('<%= purposeOfAdmission.ClientID %>').value == '0' && document.getElementById('<%= ddlType.ClientID %>').value == '0' &&
    document.getElementById('<%= txtIPNo.ClientID %>').value == '' &&
    document.getElementById('<%= ddlNationality.ClientID %>').value == '0' &&
    document.getElementById('<%= ddlRegisterDate.ClientID %>').value == '-1' && document.getElementById('<%= ddlAdmissionDate.ClientID %>').value == '-1' &&


    (document.getElementById('<%= chkDischarge.ClientID %>').checked == false)) {
                    var userMsg = SListForApplicationMessages.Get('CommonControls\\InpatientSearch.ascx_1');
                    if (userMsg != null) {
                        alert(userMsg);
                    }
                    else {
                        alert('Please Enter any one search category');
                    }
                    document.getElementById('<%= txtPatientNo.ClientID %>').focus();
                    return false;
                }
            }
            if (document.getElementById('<%= ddlRegisterDate.ClientID%>').value == '3') {
                if (document.getElementById('<%= txtFromPeriod.ClientID%>').value == '' || document.getElementById('<%= txtToPeriod.ClientID%>').value == '') {
                    //Reception\PatientSearch.aspx_2
                    var userMsg = SListForApplicationMessages.Get('Reception\\PatientSearch.aspx_2');
                    if (userMsg != null) {
                        alert(userMsg);
                    }
                    else {
                        alert('Select Date');
                    }

                    return false;
                }
            }
            if (document.getElementById('<%= ddlAdmissionDate.ClientID%>').value == '3') {
                if (document.getElementById('<%= AdtxtFromPeriod.ClientID%>').value == '' || document.getElementById('<%= AdtxtToPeriod.ClientID%>').value == '') {
                    var userMsg = SListForApplicationMessages.Get('Reception\\PatientSearch.aspx_2');
                    if (userMsg != null) {
                        alert(userMsg);
                    }
                    else {
                        alert('Select Date');
                    }
                    return false;
                }
            }
        }
        if (document.getElementById('<%= txtIPNo.ClientID %>') != null && document.getElementById('<%= chkDischarge.ClientID %>') == null) {
            if (document.getElementById('<%= txtIPNo.ClientID %>').style.visibility == 'visible') {
                if (document.getElementById('<%= txtPatientNo.ClientID %>').value == '' && document.getElementById('<%= txtPatientName.ClientID %>').value == '' &&
    document.getElementById('<%= txtDOB.ClientID %>').value == '' && document.getElementById('<%= txtRoomNo.ClientID %>').value == '' && document.getElementById('<%= txtSmartCardNo.ClientID %>').value == '' &&
    document.getElementById('<%= txtCellNo.ClientID %>').value == '' && document.getElementById('<%= purposeOfAdmission.ClientID %>').value == '0' && document.getElementById('<%= ddlType.ClientID %>').value == '0' &&
    document.getElementById('<%= ddlNationality.ClientID %>').value == '0' &&
    document.getElementById('<%= ddlRegisterDate.ClientID %>').value == '-1' && document.getElementById('<%= ddlAdmissionDate.ClientID %>').value == '-1' &&
    document.getElementById('<%= txtIPNo.ClientID %>').value == '') {

                    var userMsg = SListForApplicationMessages.Get('CommonControls\\InpatientSearch.ascx_1');
                    if (userMsg != null) {
                        alert(userMsg);
                    }
                    else {
                        alert('Please Enter any one search category');
                    }
                    document.getElementById('<%= txtPatientNo.ClientID %>').focus();
                    return false;
                }
            }
            if (document.getElementById('<%= ddlRegisterDate.ClientID%>').value == '3') {
                if (document.getElementById('<%= txtFromPeriod.ClientID%>').value == '' || document.getElementById('<%= txtToPeriod.ClientID%>').value == '') {
                    var userMsg = SListForApplicationMessages.Get('Reception\\PatientSearch.aspx_2');
                    if (userMsg != null) {
                        alert(userMsg);
                    }
                    else {
                        alert('Select Date');
                    }

                    return false;
                }
            }
            if (document.getElementById('<%= ddlAdmissionDate.ClientID%>').value == '3') {
                if (document.getElementById('<%= AdtxtFromPeriod.ClientID%>').value == '' || document.getElementById('<%= AdtxtToPeriod.ClientID%>').value == '') {
                    var userMsg = SListForApplicationMessages.Get('Reception\\PatientSearch.aspx_2');
                    if (userMsg != null) {
                        alert(userMsg);
                    }
                    else {
                        alert('Select Date');
                    }


                    return false;
                }
            }
        }
        if (document.getElementById('<%= txtIPNo.ClientID %>') == null && document.getElementById('<%= chkDischarge.ClientID %>') != null) {
            if (document.getElementById('<%= chkDischarge.ClientID %>').style.visibility == 'visible') {
                if (document.getElementById('<%= txtPatientNo.ClientID %>').value == '' && document.getElementById('<%= txtPatientName.ClientID %>').value == '' &&
    document.getElementById('<%= txtDOB.ClientID %>').value == '' && document.getElementById('<%= txtRoomNo.ClientID %>').value == '' && document.getElementById('<%= txtSmartCardNo.ClientID %>').value == '' &&
    document.getElementById('<%= txtCellNo.ClientID %>').value == '' && document.getElementById('<%= purposeOfAdmission.ClientID %>').value == '0' && document.getElementById('<%= ddlType.ClientID %>').value == '0' &&
    document.getElementById('<%= ddlNationality.ClientID %>').value == '0' &&
    document.getElementById('<%= ddlRegisterDate.ClientID %>').value == '-1' && document.getElementById('<%= ddlAdmissionDate.ClientID %>').value == '-1' &&
    (document.getElementById('<%= chkDischarge.ClientID %>').checked == false)) {

                    var userMsg = SListForApplicationMessages.Get('CommonControls\\InpatientSearch.ascx_1');
                    if (userMsg != null) {
                        alert(userMsg);
                    }
                    else {
                        alert('Please Enter any one search category');
                    }
                    document.getElementById('<%= txtPatientNo.ClientID %>').focus();
                    return false;
                }
            }
            if (document.getElementById('<%= ddlRegisterDate.ClientID%>').value == '3') {
                if (document.getElementById('<%= txtFromPeriod.ClientID%>').value == '' || document.getElementById('<%= txtToPeriod.ClientID%>').value == '') {
                    var userMsg = SListForApplicationMessages.Get('Reception\\PatientSearch.aspx_2');
                    if (userMsg != null) {
                        alert(userMsg);
                    }
                    else {
                        alert('Select Date');
                    }

                    return false;
                }
            }
            if (document.getElementById('<%= ddlRegisterDate.ClientID%>').value == '3') {
                if (document.getElementById('<%= txtFromPeriod.ClientID%>').value == '' || document.getElementById('<%= txtToPeriod.ClientID%>').value == '') {
                    var userMsg = SListForApplicationMessages.Get('Reception\\PatientSearch.aspx_2');
                    if (userMsg != null) {
                        alert(userMsg);
                    }
                    else {
                        alert('Select Date');
                    }


                    return false;
                }
            }
        }
        if (document.getElementById('<%= txtIPNo.ClientID %>') == null && document.getElementById('<%= chkDischarge.ClientID %>') == null) {



            if (document.getElementById('<%= txtPatientNo.ClientID %>').value == '' && document.getElementById('<%= txtPatientName.ClientID %>').value == '' &&
                    document.getElementById('<%= txtDOB.ClientID %>').value == '' && document.getElementById('<%= txtRoomNo.ClientID %>').value == '' && document.getElementById('<%= txtSmartCardNo.ClientID %>').value == '' &&
                    document.getElementById('<%= txtCellNo.ClientID %>').value == '' && document.getElementById('<%= purposeOfAdmission.ClientID %>').value == '0' && document.getElementById('<%= ddlNationality.ClientID %>').value == '0' && document.getElementById('<%= ddlType.ClientID %>').value == '0' &&
                    document.getElementById('<%= ddlRegisterDate.ClientID %>').value == '-1' && document.getElementById('<%= ddlAdmissionDate.ClientID %>').value == '-1') {

                var userMsg = SListForApplicationMessages.Get('CommonControls\\InpatientSearch.ascx_1');
                if (userMsg != null) {
                    alert(userMsg);
                }
                else {
                    alert('Please Enter any one search category');
                }
                document.getElementById('<%= txtPatientNo.ClientID %>').focus();
                return false;
            }
            if (document.getElementById('<%= ddlRegisterDate.ClientID%>').value == '3') {
                if (document.getElementById('<%= txtFromPeriod.ClientID%>').value == '' || document.getElementById('<%= txtToPeriod.ClientID%>').value == '') {
                    //Reception\PatientSearch.aspx_2
                    alert('Select Date');

                    return false;
                }
            }
            if (document.getElementById('<%= ddlAdmissionDate.ClientID%>').value == '3') {
                if (document.getElementById('<%= AdtxtFromPeriod.ClientID%>').value == '' || document.getElementById('<%= AdtxtToPeriod.ClientID%>').value == '') {
                    //Reception\PatientSearch.aspx_2
                    var userMsg = SListForApplicationMessages.Get('Reception\\PatientSearch.aspx_2');
                    if (userMsg != null) {
                        alert(userMsg);
                    }
                    else {
                        var userMsg = SListForApplicationMessages.Get('Reception\\PatientSearch.aspx_2');
                        if (userMsg != null) {
                            alert(userMsg);
                        }
                        else {
                            alert('Select Date');
                        }

                    }


                    return false;
                }
            }

        }
        return true;
    }

    //    function ShowAlertMsg(key) {
    //        var userMsg = SListForApplicationMessages.Get(key);
    //        if (userMsg != null) {
    //            alert(userMsg);
    //        }
    //        else if (key == "CommonControls\\InPatientSearch.ascx.cs_1") {
    //        alert('This cannot be performed as the Room is not occupied by this patient');
    //        }
    //        return false;
    //    }


    function ShowAlertMsg(key) {
        var userMsg = SListForApplicationMessages.Get(key);
        if (userMsg != null) {
            alert(userMsg);
            return false;
        }
        else {
            alert('This cannot be performed as the Room is not occupied by this patient');
            return false;
        }
        return false;
    }


    function ShowAdmDate() {
        document.getElementById('<%=AdtxtFromDate.ClientID %>').value = "";
        document.getElementById('<%=AdtxtToDate.ClientID %>').value = "";

        document.getElementById('<%=AdhdnTempFrom.ClientID %>').value = "";
        document.getElementById('<%=AdhdnTempTo.ClientID %>').value = "";

        document.getElementById('<%=AdhdnTempFromPeriod.ClientID %>').value = "0";
        document.getElementById('<%=AdhdnTempToPeriod.ClientID %>').value = "0";
        if (document.getElementById('<%=ddlAdmissionDate.ClientID %>').value == "0") {

            document.getElementById('<%=AdtxtFromDate.ClientID %>').value = document.getElementById('<%=AdhdnFirstDayWeek.ClientID %>').value;
            document.getElementById('<%=AdtxtToDate.ClientID %>').value = document.getElementById('<%=AdhdnLastDayWeek.ClientID %>').value;

            document.getElementById('<%=AdtxtFromDate.ClientID %>').disabled = true;
            document.getElementById('<%=AdtxtToDate.ClientID %>').disabled = true;
            document.getElementById('<%=AdhdnTempFrom.ClientID %>').value = document.getElementById('<%=AdhdnFirstDayWeek.ClientID %>').value;
            document.getElementById('<%=AdhdnTempTo.ClientID %>').value = document.getElementById('<%=AdhdnLastDayWeek.ClientID %>').value;

            document.getElementById('<%=divAdmDate.ClientID %>').style.display = 'block';
            document.getElementById('<%=divAdmDate.ClientID %>').style.display = 'block';
            document.getElementById('<%=divAdmDate.ClientID %>').style.display = 'inline';
            document.getElementById('<%=divAdmDate.ClientID %>').style.display = 'inline';
            document.getElementById('<%=divAdmCustomDate.ClientID %>').style.display = 'none';
            document.getElementById('<%=divAdmCustomDate.ClientID %>').style.display = 'none';
        }
        if (document.getElementById('<%= ddlAdmissionDate.ClientID %>').value == "1") {
            document.getElementById('<%=AdtxtFromDate.ClientID %>').disabled = true;
            document.getElementById('<%=AdtxtToDate.ClientID %>').disabled = true;
            document.getElementById('<%=AdtxtFromDate.ClientID %>').value = document.getElementById('<%=AdhdnFirstDayMonth.ClientID %>').value;
            document.getElementById('<%=AdtxtToDate.ClientID %>').value = document.getElementById('<%=AdhdnLastDayMonth.ClientID %>').value;
            document.getElementById('<%=AdhdnTempFrom.ClientID %>').value = document.getElementById('<%=AdhdnFirstDayMonth.ClientID %>').value;
            document.getElementById('<%=AdhdnTempTo.ClientID %>').value = document.getElementById('<%=AdhdnLastDayMonth.ClientID %>').value;

            document.getElementById('<%=divAdmDate.ClientID %>').style.display = 'block';
            document.getElementById('<%=divAdmDate.ClientID %>').style.display = 'block';
            document.getElementById('<%=divAdmDate.ClientID %>').style.display = 'inline';
            document.getElementById('<%=divAdmDate.ClientID %>').style.display = 'inline';
            document.getElementById('<%=divAdmCustomDate.ClientID %>').style.display = 'none';
            document.getElementById('<%=divAdmCustomDate.ClientID %>').style.display = 'none';
        }
        if (document.getElementById('<%= ddlAdmissionDate.ClientID %>').value == "2") {
            document.getElementById('<%=AdtxtFromDate.ClientID %>').disabled = true;
            document.getElementById('<%=AdtxtToDate.ClientID %>').disabled = true;
            document.getElementById('<%=AdtxtFromDate.ClientID %>').value = document.getElementById('<%=AdhdnFirstDayYear.ClientID %>').value;
            document.getElementById('<%=AdtxtToDate.ClientID %>').value = document.getElementById('<%=AdhdnLastDayYear.ClientID %>').value;
            document.getElementById('<%=AdhdnTempFrom.ClientID %>').value = document.getElementById('<%=AdhdnFirstDayYear.ClientID %>').value;
            document.getElementById('<%=AdhdnTempTo.ClientID %>').value = document.getElementById('<%=AdhdnLastDayYear.ClientID %>').value

            document.getElementById('<%=divAdmDate.ClientID %>').style.display = 'block';
            document.getElementById('<%=divAdmDate.ClientID %>').style.display = 'block';
            document.getElementById('<%=divAdmDate.ClientID %>').style.display = 'inline';
            document.getElementById('<%=divAdmDate.ClientID %>').style.display = 'inline';
            document.getElementById('<%=divAdmCustomDate.ClientID %>').style.display = 'none';
            document.getElementById('<%=divAdmCustomDate.ClientID %>').style.display = 'none';

        }
        if (document.getElementById('<%= ddlAdmissionDate.ClientID %>').value == "3") {
            document.getElementById('<%=divAdmDate.ClientID %>').style.display = 'none';
            document.getElementById('<%=divAdmDate.ClientID %>').style.display = 'none';
            document.getElementById('<%=divAdmCustomDate.ClientID %>').style.display = 'block';
            document.getElementById('<%=divAdmCustomDate.ClientID %>').style.display = 'block';
            document.getElementById('<%=divAdmCustomDate.ClientID %>').style.display = 'inline';
            document.getElementById('<%=divAdmCustomDate.ClientID %>').style.display = 'inline';
            document.getElementById('<%=AdhdnTempFromPeriod.ClientID %>').value = "1";
            document.getElementById('<%=hdnTempToPeriod.ClientID %>').value = "1";

        }
        if (document.getElementById('<%= ddlAdmissionDate.ClientID %>').value == "-1") {
            document.getElementById('<%=AdtxtFromDate.ClientID %>').disabled = true;
            document.getElementById('<%=AdtxtToDate.ClientID %>').disabled = true;

            document.getElementById('<%=divAdmDate.ClientID %>').style.display = 'none';
            document.getElementById('<%=divAdmDate.ClientID %>').style.display = 'none';
            document.getElementById('<%=divAdmCustomDate.ClientID %>').style.display = 'none';
            document.getElementById('<%=divAdmCustomDate.ClientID %>').style.display = 'none';


        }
        if (document.getElementById('<%= ddlAdmissionDate.ClientID %>').value == "4") {
            document.getElementById('<%=AdtxtFromDate.ClientID %>').disabled = true;
            document.getElementById('<%=AdtxtToDate.ClientID %>').disabled = true;
            document.getElementById('<%=AdtxtFromDate.ClientID %>').value = "";
            document.getElementById('<%=AdtxtToDate.ClientID %>').value = "";
            document.getElementById('<%=AdtxtFromPeriod.ClientID %>').value = "";
            document.getElementById('<%=AdtxtToPeriod.ClientID %>').value = "";
            document.getElementById('<%=divAdmDate.ClientID %>').style.display = 'none';
            document.getElementById('<%=divAdmDate.ClientID %>').style.display = 'none';
            document.getElementById('<%=divAdmCustomDate.ClientID %>').style.display = 'none';
            document.getElementById('<%=divAdmCustomDate.ClientID %>').style.display = 'none';


        }
        if (document.getElementById('<%= ddlAdmissionDate.ClientID %>').value == "5") {
            document.getElementById('<%=AdtxtFromDate.ClientID %>').disabled = true;
            document.getElementById('<%=AdtxtToDate.ClientID %>').disabled = true;
            document.getElementById('<%=AdtxtFromDate.ClientID %>').value = document.getElementById('<%=AdhdnLastWeekFirst.ClientID %>').value;
            document.getElementById('<%=AdtxtToDate.ClientID %>').value = document.getElementById('<%=AdhdnLastWeekLast.ClientID %>').value;
            document.getElementById('<%=AdhdnTempFrom.ClientID %>').value = document.getElementById('<%=AdhdnLastWeekFirst.ClientID %>').value;
            document.getElementById('<%=AdhdnTempTo.ClientID %>').value = document.getElementById('<%=AdhdnLastWeekLast.ClientID %>').value;

            document.getElementById('<%=divAdmDate.ClientID %>').style.display = 'block';
            document.getElementById('<%=divAdmDate.ClientID %>').style.display = 'block';
            document.getElementById('<%=divAdmDate.ClientID %>').style.display = 'inline';
            document.getElementById('<%=divAdmDate.ClientID %>').style.display = 'inline';
            document.getElementById('<%=divAdmCustomDate.ClientID %>').style.display = 'none';
            document.getElementById('<%=divAdmCustomDate.ClientID %>').style.display = 'none';
        }
        if (document.getElementById('<%= ddlAdmissionDate.ClientID %>').value == "6") {
            document.getElementById('<%=AdtxtFromDate.ClientID %>').disabled = true;
            document.getElementById('<%=AdtxtToDate.ClientID %>').disabled = true;
            document.getElementById('<%=AdtxtFromDate.ClientID %>').value = document.getElementById('<%=AdhdnLastMonthFirst.ClientID %>').value;
            document.getElementById('<%=AdtxtToDate.ClientID %>').value = document.getElementById('<%=AdhdnLastMonthLast.ClientID %>').value;
            document.getElementById('<%=AdhdnTempFrom.ClientID %>').value = document.getElementById('<%=AdhdnLastMonthFirst.ClientID %>').value;
            document.getElementById('<%=AdhdnTempTo.ClientID %>').value = document.getElementById('<%=AdhdnLastMonthLast.ClientID %>').value;

            document.getElementById('<%=divAdmDate.ClientID %>').style.display = 'block';
            document.getElementById('<%=divAdmDate.ClientID %>').style.display = 'block';
            document.getElementById('<%=divAdmDate.ClientID %>').style.display = 'inline';
            document.getElementById('<%=divAdmDate.ClientID %>').style.display = 'inline';
            document.getElementById('<%=divAdmCustomDate.ClientID %>').style.display = 'none';
            document.getElementById('<%=divAdmCustomDate.ClientID %>').style.display = 'none';
        }
        if (document.getElementById('<%= ddlAdmissionDate.ClientID %>').value == "7") {
            document.getElementById('<%=AdtxtFromDate.ClientID %>').disabled = true;
            document.getElementById('<%=AdtxtToDate.ClientID %>').disabled = true;
            document.getElementById('<%=AdtxtFromDate.ClientID %>').value = document.getElementById('<%=AdhdnLastYearFirst.ClientID %>').value;
            document.getElementById('<%=AdtxtToDate.ClientID %>').value = document.getElementById('<%=AdhdnLastYearLast.ClientID %>').value;
            document.getElementById('<%=AdhdnTempFrom.ClientID %>').value = document.getElementById('<%=AdhdnLastYearFirst.ClientID %>').value;
            document.getElementById('<%=AdhdnTempTo.ClientID %>').value = document.getElementById('<%=AdhdnLastYearLast.ClientID %>').value;

            document.getElementById('<%=divAdmDate.ClientID %>').style.display = 'block';
            document.getElementById('<%=divAdmDate.ClientID %>').style.display = 'block';
            document.getElementById('<%=divAdmDate.ClientID %>').style.display = 'inline';
            document.getElementById('<%=divAdmDate.ClientID %>').style.display = 'inline';
            document.getElementById('<%=divAdmCustomDate.ClientID %>').style.display = 'none';
            document.getElementById('<%=divAdmCustomDate.ClientID %>').style.display = 'none';
        }
    }


</script>

