<%@ Page Language="C#" AutoEventWireup="true" CodeFile="homecollectiontaskscheduler.aspx.cs"
    Inherits="HomeCollection_homecollectiontaskscheduler" meta:resourcekey="PageResource2" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="~/CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="~/CommonControls/HCBillingPart.ascx" TagName="BPart" TagPrefix="BillingPart" %>
<%@ Register Src="~/CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Home Collection Task Scheduler</title>
 
    <link href="../StyleSheets/TableTools_JUI.css" rel="stylesheet" type="text/css" />
    <!-- <link rel="Stylesheet" type="text/css" href="../StyleSheets/jquery.datatable.css" />-->
    <link type="text/css" href="../StyleSheets/jquery-ui-1.8.19.custom.css" rel="stylesheet" />

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script src="../Scripts/HCCommonBilling.js" type="text/javascript"></script>

    <script src="../Scripts/LabQuickBilling.js" type="text/javascript"></script>

    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
    
    <script src="js/jquery.dataTables.min.js" type="text/javascript"></script>
    <script src="js/bootstrap.min.js" type="text/javascript"></script>
    <link href="js/bootstrap.min.css" rel="stylesheet" type="text/css"></link>
    <link href="js/jquery.dataTables.min.css" rel="stylesheet" type="text/css"></link>
    
    
<script type="text/jscript" >
    $("#chkHeader").prop("checked", false);
    $("[id*=chkHeader]").live("click", function() {
        var chkHeader = $(this);
        var grid = $(this).closest("table");
        $("input[type=checkbox]", grid).each(function() {
            if (chkHeader.is(":checked")) {
                $(this).attr("checked", "checked");
                $("td", $(this).closest("tr")).addClass("selected");
            } else {
                $(this).removeAttr("checked");
                $("td", $(this).closest("tr")).removeClass("selected");
            }
        });
    });
    $("[id*=chkRow]").live("click", function() {
        var grid = $(this).closest("table");
        var chkHeader = $("[id*=chkHeader]", grid);
        if (!$(this).is(":checked")) {
            $("td", $(this).closest("tr")).removeClass("selected");
            chkHeader.removeAttr("checked");
        } else {
            $("td", $(this).closest("tr")).addClass("selected");
            if ($("[id*=chkRow]", grid).length == $("[id*=chkRow]:checked", grid).length) {
                chkHeader.attr("checked", "checked");
            }
        }
    });
</script>
    <script type="text/javascript" language="javascript">
        function popupprint() {
            var prtContent = document.getElementById('divPrintarea');
            var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,status=0');
            //alert(WinPrint);
            WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
            WinPrint.close();
        }
     
        function PhysicianSelectedInternal(source, eventArgs) {

            //debugger;
            var PhysicianID;
            var PhysicianName;
            var PhysicianCode;
            var PhysicianType;
            document.getElementById('txtInternalExternalPhysician').value = eventArgs.get_text();
            var PhyType;
            var list = eventArgs.get_value().split('^');
            if (list.length > 0) {
                for (i = 0; i < list.length; i++) {
                    if (list[i] != "") {
                        PhysicianID = list[1];
                        PhysicianName = list[2];
                        PhysicianCode = list[3];
                        PhysicianType = list[0].trim();
                        PhyType = list[4];
                    }
                }
            }
            document.getElementById('hdnReferedPhyID').value = PhysicianID;
            document.getElementById('hdnReferedPhyName').value = PhysicianName;
        }
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <cc1:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server" ScriptMode="Release"
        CombineScripts="True">
        <Services>
            <asp:ServiceReference Path="~/OPIPBilling.asmx" />
            <asp:ServiceReference Path="~/WebService.asmx" />
            <asp:ServiceReference Path="~/HCService.asmx" />
        </Services>
    </cc1:ToolkitScriptManager>
    <div>
        <div>
            <Attune:Attuneheader ID="Attuneheader" runat="server" />
            <div class="contentdata">
                <asp:UpdatePanel ID="pp" runat="server">
                    <ContentTemplate>
                        <table id="tblVaccinationDetails" runat="server" width="100%" class="dataheader3"
                            style="border: none; display: none;">
                            <tr runat="server">
                                <td runat="server">
                                    <table class="w-100p">
                                        <tr>
                                            <td class="a-left">
                                                <asp:Label ID="lblPatient" runat="server" Text="Patient" ></asp:Label>
                                            </td>
                                            <td class="a-right">
                                                <asp:DropDownList CssClass="mini ddl" ID="ddSalutation" runat="server" >
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td runat="server">
                                    <asp:TextBox ID="txtPatientName" runat="server" ToolTip="Enter a Patient Name" TabIndex="1"
                                        onkeyup="javascript:GetPatientSearchList();" onchange="ClearPatientId();" onblur="javascript:ConverttoUpperCase(this.id);"
                                        CssClass="Txtboxsmall" ></asp:TextBox>&nbsp;<img
                                            id="imgMan" src="../Images/starbutton.png" alt="" />
                                </td>
                                <td id="tdBookingNo1" runat="server" style="display: none;">
                                    <asp:Label ID="Label6" runat="server" Text="Booking Number" ></asp:Label>
                                </td>
                                <td id="tdBookingNo2" runat="server" style="display: none;">
                                    <asp:TextBox ID="txtBookingNumber" CssClass="Txtboxsmall" runat="server" MaxLength="250"
                                        TabIndex="5" ></asp:TextBox>
                                </td>
                                <td id="tdsex1" runat="server">
                                    <asp:Label ID="lblSex" runat="server" Text="Gender" AssociatedControlID="ddlSex"
                                        AccessKey="X"></asp:Label>
                                    &nbsp;&nbsp;
                                </td>
                                <td id="tdsex2" runat="server">
                                    <asp:DropDownList Width="153px" ID="ddlSex" runat="server" CssClass="ddl" TabIndex="2"
                                        >
                                    </asp:DropDownList>
                                    <img src="../Images/starbutton.png" alt="" />
                                </td>
                                <td id="tdAge1" runat="server" align="left">
                                    <asp:Label ID="lblAge" runat="server" Text="Age" ></asp:Label>
                                </td>
                                <td id="tdAge2" runat="server" align="left" style="/* display: table-cell; */width: 190px;">
                                    <asp:TextBox ID="txtDOBNos" autocomplete="off" onblur="ClearDOB();" onkeyup="setDOBYear(this.id,'HC');"
                                        TabIndex="3" onkeypress="return blockNonNumbers(this, event, true, false);" CssClass="Txtboxsmall"
                                        Width="18%" runat="server" MaxLength="3" Style="text-align: justify"  />
                                    <asp:DropDownList onChange="getDOB();setDDlDOBYear(this.id);" ID="ddlDOBDWMY" Width="105px"
                                        runat="server" CssClass="ddl" >
                                    </asp:DropDownList>
                                    <img src="../Images/starbutton.png" alt="" align="middle" />
                                    <img src="../Images/starbutton.png" alt="" align="middle" />
                                </td>
                                <td id="tdlblDOB" runat="server" align="left">
                                    <asp:Label ID="lblDOB" runat="server" Text="DOB" AssociatedControlID="tDOB" AccessKey="B"
                                        ></asp:Label>
                                </td>
                                <td id="tdtxtDOB" align="left" runat="server">
                                    <asp:Label Style="display: none;" ID="lblMarital" runat="server" Text="Marital Status"
                                        ></asp:Label>
                                    <asp:DropDownList Style="display: none;" CssClass="ddl" ID="ddMarital" runat="server"
                                        >
                                    </asp:DropDownList>
                                    <img src="../Images/starbutton.png" style="display: none;" alt="" align="middle" />
                                    <asp:TextBox CssClass="Txtboxsmall" ID="tDOB" runat="server" ToolTip="dd/MM/yyyy"
                                        onblur="javascript:countQuickAge(this.id);" Width="148px" Style="text-align: justify"
                                        onkeypress="return RestrictInput(event)" ValidationGroup="MKE"  />
                                    <ajc:MaskedEditExtender ID="MaskedEditExtender5" runat="server" TargetControlID="tDOB"
                                        Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left" ErrorTooltipEnabled="True"
                                        CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat=""
                                        CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                        CultureTimePlaceholder="" Enabled="True" />
                                    <ajc:CalendarExtender ID="CalendarExtender1" Format="dd/MM/yyyy" runat="server" TargetControlID="tDOB"
                                        PopupButtonID="ImgBntCalc" Enabled="True" />
                                    <img src="../Images/starbutton.png" alt="" align="middle" />
                                    <img src="../Images/starbutton.png" alt="" align="middle" />
                                </td>
                            </tr>
                            <tr id="trSaveDate" style="height: 35px;" runat="server">
                                <td nowrap="nowrap" runat="server">
                                    <asp:Label ID="Label1" runat="server" Text="PinCode" nowrap="nowrap" ></asp:Label>
                                </td>
                                <td runat="server">
                                    <asp:TextBox ID="txtPinCodeBo" runat="server" onkeypress="return blockNonNumbers(this, event, true, false);"
                                        TabIndex="4" ToolTip="Enter Pincode" MaxLength="6" CssClass="Txtboxsmall" onblur="showlocation();ValidatePincodeAndLocation();"
                                        ></asp:TextBox>
                                    <img src="../Images/starbutton.png" alt="" align="middle" />
                                    <img src="../Images/starbutton.png" alt="" align="middle" />
                                    <!--  <img src="../Images/starbutton.png" alt="" align="middle" />  -->
                                </td>
                                <td id="td41" runat="server">
                                    <asp:Label ID="Label3" runat="server" Text="Location" ></asp:Label>
                                </td>
                                <td id="td42" runat="server">
                                    <asp:TextBox ID="txtSuburb" runat="server" TabIndex="5" MaxLength="250" CssClass="Txtboxsmall"
                                        onblur="javascript:ValidatePincodeAndLocation();" ></asp:TextBox>
                                    <img src="../Images/starbutton.png" alt="" align="middle" />
                                    <img src="../Images/starbutton.png" alt="" align="middle" />
                                    <ajc:AutoCompleteExtender ID="AutocompleteGetLocationforHomeCollection" runat="server"
                                        TargetControlID="txtSuburb" EnableCaching="False" OnClientItemSelected="SelectTab"
                                        CompletionListCssClass="listtwo" CompletionInterval="5" CompletionListItemCssClass="listitemtwo"
                                        CompletionListHighlightedItemCssClass="hoverlistitemtwo" ServiceMethod="GetLocationforHomeCollection"
                                        ServicePath="~/HCService.asmx" Enabled="True" DelimiterCharacters="">
                                    </ajc:AutoCompleteExtender>
                                </td>
                                <td id="td43" runat="server">
                                    <asp:Label ID="Label4" runat="server" Text="Cit<u>y</u>" AssociatedControlID="txtCity"
                                        AccessKey="y" ></asp:Label>
                                </td>
                                <td id="td52" runat="server" width="14%">
                                    <asp:TextBox ID="textcity" Style="background-color: #F2F2F2" CssClass="Txtboxsmall"
                                        runat="server" MaxLength="250" ></asp:TextBox>
                                    &nbsp;<img src="../Images/starbutton.png" alt="" />
                                </td>
                                <td nowrap="nowrap" runat="server">
                                    <asp:Label ID="Label5" runat="server" Text="State" nowrap="nowrap" ></asp:Label>
                                </td>
                                <td width="18%" runat="server">
                                    <asp:TextBox ID="textstate" runat="server" CssClass="Txtboxsmall" ></asp:TextBox>
                                    <img src="../Images/starbutton.png" alt="" align="middle" />
                                </td>
                            </tr>
                            <tr id="loc" runat="server">
                                <td runat="server">
                                    <asp:Label ID="lblOrga" runat="server" Text="Organization" ></asp:Label>
                                </td>
                                <td runat="server">
                                    <span>
                                        <asp:DropDownList ID="ddlOrg1" runat="server" TabIndex="6" Width="153px" CssClass="ddlsmall"
                                            onmousedown="expandDropDownListPage(this);" onblur="collapseDropDownList(this);">
                                        </asp:DropDownList>
                                        <ajc:CascadingDropDown ID="CascadingDropDown1" runat="server" TargetControlID="ddlOrg1"
                                            Category="Org" PromptText="------Select------" ServicePath="~/OPIPBilling.asmx"
                                            ServiceMethod="GetOrganizations" Enabled="True" />
                                    </span>
                                </td>
                                <td id="tdloc1" runat="server" align="left">
                                    <asp:Label ID="lblLocation" runat="server" Text="Collection Centre" ></asp:Label>
                                </td>
                                <td id="tdloc2" runat="server" align="left">
                                    <asp:DropDownList ID="ddlLoc" runat="server" CssClass="ddlsmall" TabIndex="7">
                                    </asp:DropDownList>
                                    <ajc:CascadingDropDown ID="CascadeddlLoc" runat="server" TargetControlID="ddlLoc"
                                        ParentControlID="ddlOrg1" PromptText="------Select------" ServiceMethod="GetLocationName"
                                        ServicePath="~/OPIPBilling.asmx" Category="Location" LoadingText="[Loading Locations...]"
                                        Enabled="True" />
                                    <img src="../Images/starbutton.png" alt="" align="middle" />
                                </td>
                                <td id="tdaddtxt" runat="server" nowrap="nowrap">
                                    <asp:Label ID="Label7" runat="server" nowrap="nowrap" Text="Collection Address" ></asp:Label>
                                </td>
                                <td id="tdtxtAddress" runat="server" >
                                    <asp:TextBox ID="txtAddress" TextMode="MultiLine" runat="server" MaxLength="250"
                                        Width="158px" Height="30px" TabIndex="8" 
                                        placeholder="Maximum of 250 characters  "></asp:TextBox>
                                    <img src="../Images/starbutton.png" alt="" />
                                </td>
                                 <td id="Td49" runat="server">
                                    <asp:Label ID="lblExtRefN" runat="server" Text="External Ref.No."  ></asp:Label>
                                </td>
                                <td id="Td50" colspan="3" runat="server">
                                    <asp:TextBox ID="txtExtRefNo" runat="server"  TabIndex="18" MaxLength="50" ReadOnly 
                                         ></asp:TextBox>
                                </td>
                            </tr>
                            <tr style="height: 35px;" runat="server">
                                <td id="tdtime" runat="server" align="left">
                                    <asp:Label ID="Label8" runat="server" Text="Collection Date & Time" ></asp:Label>
                                </td>
                                <td id="tdtimetxt" runat="server">
                                    <asp:TextBox ID="txtTime" runat="server" Width="130px" ToolTip="Collection Date"
                                        TabIndex="9" CssClass="Txtboxsmall" onblur="javascript:timevalidate();" ></asp:TextBox>
                                    <a href="javascript:NewCssCal('txtTime','ddmmyyyy','arrow',true,12);document.getElementById('txtTime').focus();">
                                        <img src="../images/Calendar_scheduleHS.png" id="imgCalc" style="vertical-align: middle;"
                                            alt="Pick a date"></a>
                                    <img src="../Images/starbutton.png" alt="" />
                                </td>
                                <td runat="server">
                                    <asp:Label ID="Label9" runat="server" Text="Technican" ></asp:Label>
                                </td>
                                <td id="td53" runat="server">
                                    <asp:DropDownList ID="ddlUser" runat="server" CssClass="ddlsmall" TabIndex="10" onchange="javascript:ChangeUsers();"
                                       >
                                       <asp:ListItem Text="---Select ALL---" Value=0 Selected></asp:ListItem>
                                    </asp:DropDownList>
                                    <img src="../Images/starbutton.png" alt="" align="middle" />
                                </td>
                                <td width="6%" runat="server">
                                    <asp:Label ID="lblmobi" runat="server" Text="Mobile" ></asp:Label>
                                </td>
                                <td width="17%" runat="server">
                                    <asp:TextBox ID="txtMobile" runat="server" ToolTip="enter a patient mobile number"
                                        TabIndex="11" MaxLength="13" onchange="CheckSMS();" onkeypress="return blockNonNumbers(this, event, true, false);"
                                        CssClass="Txtboxsmall" ></asp:TextBox>
                                    &nbsp;<img id="img1" src="../images/starbutton.png" alt="" />
                                </td>
                                <td nowrap="nowrap" width="6%" runat="server">
                                    <asp:Label ID="label10" runat="server" nowrap="nowrap" Text="Land Line" ></asp:Label>
                                </td>
                                <td width="18%" runat="server">
                                    <asp:TextBox ID="txtTelephoneNo" runat="server" onkeypress="return blockNonNumbers(this, event, true, false);"
                                        ToolTip="enter a patient telephone number" MaxLength="15" TabIndex="12" CssClass="Txtboxsmall"
                                        ></asp:TextBox>
                                </td>
                            </tr>
                            <tr runat="server">
                                <td nowrap="nowrap" runat="server">
                                    <asp:Label ID="lblEmail" runat="server" AccessKey="E" AssociatedControlID="txtEmail"
                                        Text="&lt;u&gt;E&lt;/u&gt;-mail" ></asp:Label>
                                </td>
                                <td nowrap="nowrap" runat="server">
                                    <asp:TextBox ID="txtEmail" runat="server" autocomplete="off" TabIndex="13" onchange="CheckEmail();"
                                        onblur="javascript:return validateMultipleEmailsCommaSeparated(this,',');" CssClass="small"
                                        ></asp:TextBox>
                                </td>
                                <td id="tdRefDrPart" runat="server">
                                    <asp:Label ID="lblRefby" runat="server" AccessKey="D" AssociatedControlID="txtInternalExternalPhysician"
                                        Text="Ref Dr." ></asp:Label>
                                </td>
                                <td id="tdRefDrParttxt" runat="server">
                                    <asp:TextBox ID="txtInternalExternalPhysician" runat="server" TabIndex="14" CssClass="AutoCompletesearchBox Txtboxsmall"
                                        onFocus="return getrefhospid(this.id);"></asp:TextBox>
                                    <ajc:AutoCompleteExtender ID="AutoCompleteExtenderRefPhy" runat="server" CompletionInterval="1"
                                        CompletionListCssClass="wordWheel listMain .box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                        CompletionListItemCssClass="wordWheel itemsMain" EnableCaching="False" OnClientShown="DocPopulated"
                                        FirstRowSelected="True" MinimumPrefixLength="2" OnClientItemSelected="PhysicianSelectedInternal"
                                        ServiceMethod="GetRateCardForBilling" ServicePath="~/OPIPBilling.asmx" OnClientItemOver="PhysicianTempSelected"
                                        TargetControlID="txtInternalExternalPhysician" DelimiterCharacters="" Enabled="True">
                                    </ajc:AutoCompleteExtender>
                                </td>
                                <td runat="server">
                                    <asp:Label ID="Rs_URNType" Text="URN Type" runat="server"  />
                                </td>
                                <td runat="server">
                                    <asp:DropDownList ID="ddlUrnType" runat="server" TabIndex="15" onChange="javascript:return enableurntxt();"
                                        CssClass="ddlsmall" >
                                    </asp:DropDownList>
                                </td>
                                <td runat="server">
                                    <asp:Label ID="Rs_URN" Text="URN No" runat="server"  />
                                </td>
                                <td runat="server">
                                    <input type="hidden" id="hdnUrn" runat="server" value="0" />
                                        <asp:TextBox ID="txtURNo" runat="server" autocomplete="off" CssClass="Txtboxsmall"
                                            MaxLength="50"  onblur="ConverttoUpperCase(this.id);"></asp:TextBox>
                                    
                                </td>
                            </tr>
                            <tr id="tdemail" runat="server">
                                <td colspan="1" nowrap="nowrap" runat="server">
                                    <asp:Label ID="lblDespatchmode" runat="server" Text="Dispatch Mode" ></asp:Label>
                                </td>
                                <td colspan="1" nowrap="nowrap" runat="server">
                                    <asp:CheckBoxList ID="chkDespatchMode" TabIndex="16" runat="server" onclick="DispatchChecked()"
                                        RepeatDirection="Horizontal" >
                                    </asp:CheckBoxList>
                                </td>
                                <td runat="server">
                                    <asp:Label ID="lblFeedback" runat="server" Text="Comments" ></asp:Label>
                                </td>
                                <td colspan="3" runat="server">
                                    <asp:TextBox ID="txtFeedback" runat="server" TextMode="MultiLine" TabIndex="17" Width="468px"
                                        Height="30px" placeholder="Maximum of 100 characters" MaxLength="200" ></asp:TextBox>
                                </td>
                                <td id="tdStatus" runat="server">
                                    <asp:Label ID="Label11" runat="server" Text="Status" ></asp:Label>
                                </td>
                                <td id="tdddlStatus" runat="server">
                                    <asp:DropDownList ID="ddlstats" runat="server" CssClass="ddlsmall" onchange ="getddlstats()" >
                                 
                                       <%-- <asp:ListItem Text="--Select--" Value="0" ></asp:ListItem>
                                        <asp:ListItem Text="Booked" Value="B" ></asp:ListItem>
                                         <asp:ListItem Text="Assigned" Value="A" ></asp:ListItem>
                                           <asp:ListItem Text="TripStarted" Value="TS" ></asp:ListItem>
                                             <asp:ListItem Text="TripCancelled" Value="TC" ></asp:ListItem>
                                              <asp:ListItem Text="ReachedDestination" Value="RD" ></asp:ListItem>
                                               <asp:ListItem Text="Inprogress" Value="IP" ></asp:ListItem>
                                        <asp:ListItem Text="Completed" Value="R" ></asp:ListItem>
                                        <asp:ListItem Text="Cancelled" Value="C" ></asp:ListItem>
                                        <asp:ListItem Text="Rescheduled" Value="RS" ></asp:ListItem>--%>
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr runat="server">
                                <td style='height: 10px;' runat="server">
                                </td>
                            </tr>
                            <tr runat="server">
                                <td runat="server">
                                </td>
                                <td runat="server">
                                </td>
                                <td runat="server">
                                </td>
                                <td colspan="8" runat="server">
                                    <asp:Button ID="btnClear" runat="server" Text="Clear" CssClass="btn" OnClientClick="return clearClick();"
                                        Style="margin-left: 0px" TabIndex="19"  />
                                        <asp:Button ID="update" CssClass="btn" runat="server" OnClientClick="return setVaccValues(this.id);" Text="Update"  />
                                </td>
                            </tr>
                        </table>
                        <div id="divsearch" style="display: none;" runat="server">
                            <table width="100%" cellpadding="0" cellspacing="0" border="0" runat="server" class="defaultfontcolor" style="border: none;">
                                <tr runat="server">
                                    <td runat="server"> 
                                        <table width="100%" class="dataheader3 maintblBook" runat="server">
                                            <tr runat="server">
                                                <td runat="server">
                                                    <tr id="Tr1" runat="server">
                                                        <td id="Td1" runat="server">
                                                            <asp:Label ID="lblOrg" runat="server" Text="Organization"></asp:Label>
                                                        </td>
                                                        <td id="Td2" runat="server">
                                                            <span>
                                                                <asp:DropDownList ID="ddlOrg" runat="server" TabIndex="11" Width="150px" normalWidth="150px"
                                                                    CssClass="ddlsmall" onmousedown="expandDropDownListPage(this);" onblur="collapseDropDownList(this);">
                                                                </asp:DropDownList>
                                                                <ajc:CascadingDropDown ID="CasddlOrg" runat="server" TargetControlID="ddlOrg" Category="Org"
                                                                    PromptText="------Select------" ServicePath="~/OPIPBilling.asmx" ServiceMethod="GetOrganizations"
                                                                    Enabled="True" />
                                                                <img src="../Images/starbutton.png" alt="" align="middle" />
                                                            </span>
                                                        </td>
                                                        <td id="Td3" runat="server">
                                                            <asp:Label ID="lblCollcenter" runat="server" Text="Collection center"></asp:Label>
                                                        </td>
                                                        <td id="Td4" runat="server">
                                                            <asp:DropDownList ID="ddlLocation" runat="server" CssClass="ddlsmall" TabIndex="12">
                                                            </asp:DropDownList>
                                                            <ajc:CascadingDropDown ID="Casdropddllocation" runat="server" TargetControlID="ddlLocation"
                                                                ParentControlID="ddlOrg" PromptText="------Select------" ServiceMethod="GetLocationName"
                                                                ServicePath="~/OPIPBilling.asmx" Category="Location" LoadingText="[Loading Locations...]"
                                                                Enabled="True" />
                                                            <img src="../Images/starbutton.png" alt="" align="middle" />
                                                        </td>
                                                        <td id="Td5" runat="server">
                                                            <asp:Label ID="lblTech" runat="server" Text="Technician"></asp:Label>
                                                        </td>
                                                        <td id="Td6" runat="server">
                                                            <asp:DropDownList ID="drpTech" runat="server" CssClass="ddlsmall">
                                                                <asp:ListItem Text="--Select All--" Value="0"></asp:ListItem>
                                                            </asp:DropDownList>
                                                            <img src="../Images/starbutton.png" alt="" align="middle" />
                                                        </td>
                                                        <td id="Td7" runat="server">
                                                            <asp:Label ID="lblMob" runat="server" Text="Mobile number"></asp:Label>
                                                        </td>
                                                        <td id="Td8" runat="server">
                                                            <asp:TextBox ID="txtMob" runat="server"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr id="Tr2" style="height: 35px;" runat="server">
                                                        <td id="Td9" runat="server">
                                                            <asp:Label ID="lblColl" runat="server" Text="Collection"></asp:Label>
                                                            <asp:HiddenField ID="hdnFirstDayWeek" runat="server" />
                                                            <asp:HiddenField ID="hdnLastDayWeek" runat="server" />
                                                            <asp:HiddenField ID="hdnFirstDayMonth" runat="server" />
                                                            <asp:HiddenField ID="hdnLastDayMonth" runat="server" />
                                                            <asp:HiddenField ID="hdnFirstDayYear" runat="server" />
                                                            <asp:HiddenField ID="hdnLastDayYear" runat="server" />
                                                            <asp:HiddenField ID="hdnDateImage" runat="server" />
                                                            <asp:HiddenField ID="hdnTempFrom" runat="server" />
                                                            <asp:HiddenField ID="hdnTempTo" runat="server" />
                                                            <asp:HiddenField ID="hdnBTempFrom" runat="server" />
                                                            <asp:HiddenField ID="hdnBTempTo" runat="server" />
                                                            <asp:HiddenField ID="hdnTempFromPeriod" runat="server" />
                                                            <asp:HiddenField ID="hdnTempToPeriod" runat="server" />
                                                            <asp:HiddenField ID="hdnLastMonthFirst" runat="server" />
                                                            <asp:HiddenField ID="hdnLastMonthLast" runat="server" />
                                                            <asp:HiddenField ID="hdnLastWeekFirst" runat="server" />
                                                            <asp:HiddenField ID="hdnLastWeekLast" runat="server" />
                                                            <asp:HiddenField runat="server" ID="hdnLastYearFirst" />
                                                            <asp:HiddenField ID="hdnLastYearLast" runat="server" />
                                                            <asp:HiddenField ID="hdnActionCount" runat="server" />
                                                            <asp:HiddenField runat="server" ID="hdnloginRoleName" />
                                                        </td>
                                                        <td id="Td10" runat="server">
                                                            <asp:DropDownList ID="drpCollection" runat="server" onChange="javascript:return ShowRegDate();"
                                                                CssClass="ddlsmall">
                                                                <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                                                            </asp:DropDownList>
                                                            <img src="../Images/starbutton.png" alt="" align="middle" />
                                                            <div id="divRegDate" style="display: none" runat="server">
                                                                <table>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="Rs_FromDate" runat="server" Text="From Date"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <asp:TextBox CssClass="w-70" ID="txtFromDate" runat="server"></asp:TextBox>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="Rs_ToDate" runat="server" Text="To Date"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <asp:TextBox CssClass="w-70" runat="server" ID="txtToDate"></asp:TextBox>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </div>
                                                            <div id="divRegCustomDate" runat="server" style="display: none;">
                                                                <table>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="Rs_FromDate1" runat="server" Text="From Date"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <asp:TextBox CssClass="w-70" ID="txtFromPeriod" runat="server"></asp:TextBox>
                                                                            <asp:ImageButton ID="ImgBntCalcFrom" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                                                CausesValidation="False" />
                                                                                  <cc1:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="txtFromPeriod"
                                                                            Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left" ErrorTooltipEnabled="True"
                                                                            CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat=""
                                                                            CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                                                            CultureTimePlaceholder="" Enabled="True" />
                                                                        <cc1:MaskedEditValidator ID="MaskedEditValidator5" runat="server" ControlExtender="MaskedEditExtender5"
                                                                            ControlToValidate="txtFromPeriod" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                                            Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                                            ValidationGroup="MKE" ErrorMessage="MaskedEditValidator5" meta:resourcekey="MaskedEditValidator5Resource1" />
                                                                        <cc1:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="txtFromPeriod"
                                                                            Format="dd/MM/yyyy" PopupButtonID="ImgBntCalcFrom" Enabled="True" />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="Rs_ToDate1" runat="server" Text="To Date"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <asp:TextBox CssClass="w-70" runat="server" ID="txtToPeriod"></asp:TextBox>
                                                                            <asp:ImageButton ID="ImgBntCalcTo" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                                                CausesValidation="False" />
                                                                                   <cc1:MaskedEditExtender ID="MaskedEditExtender2" runat="server" TargetControlID="txtToPeriod"
                                                                            Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left" ErrorTooltipEnabled="True"
                                                                            CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat=""
                                                                            CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                                                            CultureTimePlaceholder="" Enabled="True" />
                                                                        <cc1:MaskedEditValidator ID="MaskedEditValidator1" runat="server" ControlExtender="MaskedEditExtender5"
                                                                            ControlToValidate="txtToPeriod" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                                            Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                                            ValidationGroup="MKE" ErrorMessage="MaskedEditValidator1" meta:resourcekey="MaskedEditValidator1Resource1" />
                                                                        <cc1:CalendarExtender ID="CalendarExtender3" runat="server" TargetControlID="txtToPeriod"
                                                                            Format="dd/MM/yyyy" PopupButtonID="ImgBntCalcTo" Enabled="True" />
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </div>
                                                        </td>
                                                        <td id="Td11" runat="server">
                                                            <asp:Label ID="lblBookon" runat="server" Text="Booked on"></asp:Label>
                                                        </td>
                                                        <td id="Td12" runat="server">
                                                            <asp:DropDownList ID="drpBooked" runat="server" onChange="javascript:return ShowRegDateBook();"
                                                                CssClass="ddlsmall">
                                                                <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                                                            </asp:DropDownList>
                                                            <img src="../Images/starbutton.png" alt="" align="middle" />
                                                            <div id="divRegDateBook" style="display: none" runat="server">
                                                                <table>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="Label12" runat="server" Text="From Date"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <asp:TextBox CssClass="w-70" ID="txtFromDateBook" runat="server"></asp:TextBox>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="Label13" runat="server" Text="To Date"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <asp:TextBox CssClass="w-70" runat="server" ID="txtToDateBook"></asp:TextBox>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </div>
                                                            <div id="divRegCustomDateBook" runat="server" style="display: none;">
                                                                <table>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="Label14" runat="server" Text="From Date"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <asp:TextBox CssClass="w-70" ID="txtFromPeriodBook" runat="server"></asp:TextBox>
                                                                            <asp:ImageButton ID="ImgBntCalcFromBook" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                                                CausesValidation="False" />
                                                                                 <cc1:MaskedEditExtender ID="MaskedEditExtender3" runat="server" TargetControlID="txtFromPeriodBook"
                                                                            Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left" ErrorTooltipEnabled="True"
                                                                            CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat=""
                                                                            CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                                                            CultureTimePlaceholder="" Enabled="True" />
                                                                        <cc1:MaskedEditValidator ID="MaskedEditValidator2" runat="server" ControlExtender="MaskedEditExtender5"
                                                                            ControlToValidate="txtFromPeriodBook" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                                            Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                                            ValidationGroup="MKE" ErrorMessage="MaskedEditValidator5" meta:resourcekey="MaskedEditValidator5Resource1" />
                                                                        <cc1:CalendarExtender ID="CalendarExtender4" runat="server" TargetControlID="txtFromPeriodBook"
                                                                            Format="dd/MM/yyyy" PopupButtonID="ImgBntCalcFromBook" Enabled="True" />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="Label15" runat="server" Text="To Date"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <asp:TextBox CssClass="w-70" runat="server" ID="txtToPeriodBook"></asp:TextBox>
                                                                            <asp:ImageButton ID="ImgBntCalcToBook" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                                                CausesValidation="False" />
                                                                                    <cc1:MaskedEditExtender ID="MaskedEditExtender4" runat="server" TargetControlID="txtToPeriodBook"
                                                                            Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left" ErrorTooltipEnabled="True"
                                                                            CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat=""
                                                                            CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                                                            CultureTimePlaceholder="" Enabled="True" />
                                                                        <cc1:MaskedEditValidator ID="MaskedEditValidator3" runat="server" ControlExtender="MaskedEditExtender5"
                                                                            ControlToValidate="txtToPeriodBook" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                                            Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                                            ValidationGroup="MKE" ErrorMessage="MaskedEditValidator1" meta:resourcekey="MaskedEditValidator1Resource1" />
                                                                        <cc1:CalendarExtender ID="CalendarExtender5" runat="server" TargetControlID="txtToPeriodBook"
                                                                            Format="dd/MM/yyyy" PopupButtonID="ImgBntCalcToBook" Enabled="True" />
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </div>
                                                        </td>
                                                        <td id="Td13" runat="server">
                                                            <asp:Label ID="lblStatus" runat="server" Text="Status"></asp:Label>
                                                        </td>
                                                        <td id="Td14" runat="server">
                                                            <asp:DropDownList ID="drpStatusBo" runat="server" CssClass="ddlsmall">
                                                             <%--   <asp:ListItem Text="--Select All--" Value="0"></asp:ListItem>
                                                                <asp:ListItem Text="Booked" Value="B" ></asp:ListItem>
                                         <asp:ListItem Text="Assigned" Value="A" ></asp:ListItem>
                                           <asp:ListItem Text="TripStarted" Value="TS" ></asp:ListItem>
                                             <asp:ListItem Text="TripCancelled" Value="TC" ></asp:ListItem>
                                              <asp:ListItem Text="ReachedDestination" Value="RD" ></asp:ListItem>
                                               <asp:ListItem Text="Inprogress" Value="IP" ></asp:ListItem>
                                        <asp:ListItem Text="Completed" Value="R" ></asp:ListItem>
                                        <asp:ListItem Text="Cancelled" Value="C" ></asp:ListItem>
                                        <asp:ListItem Text="Rescheduled" Value="RS" ></asp:ListItem>--%>
                                                            </asp:DropDownList>
                                                            <img src="../Images/starbutton.png" alt="" align="middle" />
                                                        </td>
                                                        <td id="Td15" runat="server">
                                                            <asp:Label ID="lblBookno" runat="server" Text="Booking No"></asp:Label>
                                                        </td>
                                                        <td id="Td16" runat="server">
                                                            <asp:TextBox ID="txtBookNos" runat="server"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr id="Tr3" runat="server">
                                                        <td id="Td17" runat="server">
                                                            <asp:Label ID="lblPincode" runat="server" Text="Pincode"></asp:Label>
                                                        </td>
                                                        <td id="Td18" runat="server">
                                                            <asp:TextBox ID="txtpincode" runat="server" CssClass="Txtboxsmall" onkeypress="return blockNonNumbers(this, event, true, false);"
                                                                ToolTip="Enter Pincode" MaxLength="6" onblur="showlocation();ValidatePincodeAndLocation();"></asp:TextBox>
                                                        </td>
                                                        <td id="Td19" runat="server">
                                                            <asp:Label ID="lblLoc" runat="server" Text="Location"></asp:Label>
                                                        </td>
                                                        <td id="Td20" runat="server">
                                                            <asp:TextBox ID="txtLoc" runat="server" onblur="javascript:ValidatePincodeAndLocation();"
                                                                CssClass="Txtboxsmall"></asp:TextBox>
                                                            <ajc:AutoCompleteExtender ID="AutoCompleteHCGetLoc" runat="server" TargetControlID="txtLoc"
                                                                EnableCaching="False" OnClientItemSelected="SelectTab" CompletionListCssClass="listtwo"
                                                                CompletionInterval="5" CompletionListItemCssClass="listitemtwo" CompletionListHighlightedItemCssClass="hoverlistitemtwo"
                                                                ServiceMethod="GetLocationforHomeCollection" ServicePath="~/HCService.asmx" Enabled="True"
                                                                DelimiterCharacters="">
                                                            </ajc:AutoCompleteExtender>
                                                        </td>
                                                        <td id="td21" runat="server">
                                                            <asp:Label ID="Label2" runat="server" Text="Cit<u>y</u>" AssociatedControlID="txtCity"
                                                                Visible="False" AccessKey="y"></asp:Label>
                                                        </td>
                                                        <td id="td22" runat="server" width="14%">
                                                            <asp:TextBox ID="txtCity" Style="background-color: #F2F2F2" CssClass="Txtboxsmall"
                                                                Visible="False" runat="server" MaxLength="250"></asp:TextBox>
                                                        </td>
                                                        <td id="Td23" nowrap="nowrap" runat="server">
                                                            <asp:Label ID="lblstate" runat="server" Text="State" nowrap="nowrap" Visible="False"></asp:Label>
                                                        </td>
                                                        <td id="Td24" width="18%" runat="server">
                                                            <asp:TextBox ID="txtstate" runat="server" CssClass="Txtboxsmall" Visible="False"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr id="Tr4" style="height: 35px;" runat="server">
                                                        <td id="Td25" runat="server">
                                                        </td>
                                                        <td id="Td26" runat="server">
                                                        </td>
                                                        <td id="Td27" runat="server">
                                                        </td>
                                                        <td id="Td28" runat="server">
                                                            <asp:Button ID="btnClearSearch" runat="server" Text="Clear" CssClass="btn" OnClientClick="return clearClick();"
                                                                Style="margin-left: 0px;" TabIndex="18"  />
                                                            <asp:Button ID="btnSearch" runat="server" CssClass="btn" Text="Search" OnClientClick="enable();GetData();return false;"
                                                                Style="margin-left: 0px;" />
                                                                </td>
                                                            <td id="Td29" runat="server">
                                                            </td>
                                                            <td>
                                      <%--  <asp:ImageButton ID="imgBtnXL" OnClientClick="if(getElementById('hdnXLFlag').value!='1' || getElementById('grdResult')== undefined ) { alert('No Records to Export');return false;} return true;"
                                            runat="server" ImageUrl="../PlatForm/Images/ExcelImage.GIF" ToolTip="Save As Excel" OnClick="lnkExportXL_Click"
                                            meta:resourcekey="imgBtnXLResource1" />
                                        <asp:LinkButton ID="lnkExportXL" Text="Export To XL" OnClientClick="if(getElementById('hdnXLFlag').value!='1' || getElementById('grdResult')== undefined ) { alert('No Records to Export');return false;} return true;"
                                            runat="server" ToolTip="Save As Excel" CssClass="pointer hide" meta:resourcekey="lnkExportXLResource1"
                                            OnClick="lnkExportXL_Click"></asp:LinkButton>
                                        <input type="hidden" runat="server" value="0" id="hdnXLFlag" />--%>
                                         <asp:ImageButton ID="imgBtnXL" style="display: none;" runat="server" ImageUrl="../Images/ExcelImage.GIF"
                                ToolTip="Save As Excel" OnClick="lnkExportXL_Click" TabIndex="13" meta:resourcekey="imgBtnXLResource1" />
                            <asp:LinkButton ID="lnkExportXL" style="display: none;" Text="Export To XL" Font-Underline="True"
                                runat="server" Font-Bold="True" Font-Size="12px" ForeColor="Black" ToolTip="Save As Excel"
                                OnClick="lnkExportXL_Click" TabIndex="14" meta:resourcekey="lnkExportXLResource1"></asp:LinkButton>
                            <input type="hidden" runat="server" value="0" id="hdnXLFlag" />
                                    </td>
                                                            <td id="Td30" runat="server">
                                                            </td>
                                                            <td id="Td32" runat="server">
                                                            </td>
                                                    </tr>
                                                    <tr id="Tr5" runat="server">
                                                        <td id="Td33" runat="server">
                                                        </td>
                                                        <td id="Td34" runat="server">
                                                        </td>
                                                        <td id="Td35" runat="server">
                                                        </td>
                                                        <td id="Td36" runat="server">
                                                        </td>
                                                        <td id="Td37" runat="server">
                                                        </td>
                                                        <td id="Td38" runat="server">
                                                        </td>
                                                        <td id="Td39" runat="server">
                                                        </td>
                                                        <td id="Td40" runat="server">
                                                        </td>
                                                    </tr>
                                                </td>
                                            </tr>
                                        </table>
                                   </td>
                                </tr>
                            </table>
                            <table id="btnSearchArea" class="dataheader3 w-100p" runat="server" width="100%"
                                style="border: none;">
                                <tr id="Tr7" runat="server" class="w-100p">
                                    <td id="Td44" runat="server">
                                        <asp:Label ID="lblTechni" runat="server" Text="Technician"></asp:Label>
                                    </td>
                                    <td id="Td45" runat="server">
                                        <asp:DropDownList ID="ddlTechni" runat="server" CssClass="ddlsmall">
                                            <asp:ListItem Text="--Select All--" Value="0"></asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                    <td id="Td46" runat="server">
                                        <asp:Label ID="lblStat" runat="server" Text="Status"></asp:Label>
                                    </td>
                                    <td id="Td47" runat="server">
                                        <asp:DropDownList ID="ddlStat" runat="server" CssClass="ddlsmall">
                                            <asp:ListItem Text="--Select All--" Value="0"></asp:ListItem>
                                             <asp:ListItem Text="Booked" Value="B" ></asp:ListItem>
                                         <asp:ListItem Text="Assigned" Value="A" ></asp:ListItem>
                                           <asp:ListItem Text="TripStarted" Value="TS" ></asp:ListItem>
                                             <asp:ListItem Text="TripCancelled" Value="TC" ></asp:ListItem>
                                              <asp:ListItem Text="ReachedDestination" Value="RD" ></asp:ListItem>
                                               <asp:ListItem Text="Inprogress" Value="IP" ></asp:ListItem>
                                        <asp:ListItem Text="Completed" Value="R" ></asp:ListItem>
                                        <asp:ListItem Text="Cancelled" Value="C" ></asp:ListItem>
                                        <asp:ListItem Text="Rescheduled" Value="RS" ></asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                    <td id="Td48" runat="server">
                                        <asp:Button ID="btnApply" CssClass="btn" runat="server" Text="Apply" OnClientClick="return uptechApplyclick(this.id);" />
                                    </td>
                                </tr>
                            </table>
                        </div>
                        
                        <table>
                            <tr>
                                <td style="height: 10px;">
                                </td>
                            </tr>
                            <tr class="w-100p">
                                <td class="w-100p">
                                    <div class="w-100p">
                                        <table class="w-100p" id="AddVaccDetails" width="100%" runat="server" style="border: none;
                                            display: none;">
                                            <tr runat="server">
                                                <td class="w-100p" runat="server">
                                                    <table id="tblVaccinationList" class="gridView responstable w-100p fixResponsTable">
                                                        <thead>
                                                            <tr class="fixTableHeader">
                                                                <th>
                                                                    <asp:Label ID="lblsel" runat="server" Text="Select All" ></asp:Label><br />
                                                                    <asp:CheckBox ID="chkHeader" runat="server" unchecked />
                                                                </th>
                                                                <th>
                                                                    <asp:Label ID="lblBookingNo" runat="server" Text="Booking Number" ></asp:Label>
                                                                </th>
                                                                <th>
                                                                    <asp:Label ID="lblPatientName" runat="server" Text="Patient Name" ></asp:Label>
                                                                </th>
                                                                <th>
                                                                    <asp:Label ID="lblAgesex" runat="server" Text="Age & Sex" ></asp:Label>
                                                                </th>
                                                                <th>
                                                                    <asp:Label ID="lblAddress" runat="server" Text="Address" ></asp:Label>
                                                                </th>
                                                                <th>
                                                                    <asp:Label ID="lblMobno" runat="server" Text="Mobile No" ></asp:Label>
                                                                </th>
                                                                <th>
                                                                    <asp:Label ID="lblLoca" runat="server" Text="Location" ></asp:Label>
                                                                </th>
                                                                <th>
                                                                    <asp:Label ID="lblPin" runat="server" Text="PinCode" ></asp:Label>
                                                                </th>
                                                                <th>
                                                                    <asp:Label ID="lblTest" runat="server" Text="Test" ></asp:Label>
                                                                </th>
                                                                <th>
                                                                    <asp:Label ID="lblColCenter" runat="server" Text="Collection Center" ></asp:Label>
                                                                </th>
                                                                <th>
                                                                    <asp:Label ID="lblBookDate" runat="server" Text="Booking Date & Time" ></asp:Label>
                                                                </th>
                                                                <th>
                                                                    <asp:Label ID="lblCollDate" runat="server" Text="Collection Date & Time" ></asp:Label>
                                                                </th>
                                                                <th>
                                                                    <asp:Label ID="lblPay" runat="server" Text="Payment" ></asp:Label>
                                                                </th>
                                                                <th>
                                                                    <asp:Label ID="lblTec" runat="server" Text="Technician" ></asp:Label>
                                                                </th>
                                                                <th>
                                                                    <asp:Label ID="lblSta" runat="server" Text="Status" ></asp:Label>
                                                                </th>
                                                                 <th>
                                                                    <asp:Label ID="lblExtRefNo" runat="server" Text="External Ref. No." ></asp:Label>
                                                                </th>
                                                                <th>
                                                                    <asp:Label ID="lblAction" runat="server" Text="Action" ></asp:Label>
                                                                </th>
                                                            </tr>
                                                        </thead>
                                                        <tbody id="trVaccination" class="">
                                                        </tbody>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </td>
                            </tr>
                        </table>
                           
                
                           <div id="divPrintarea" runat="server" style="overflow: auto; height: auto;" visible="False">
                                                                    <asp:GridView ID="grdResult" runat="server" CssClass="gridView w-95p"
                                                    EmptyDataText="Collection Details Not Available"
                                                                        AutoGenerateColumns="False" Width="100%" meta:resourcekey="grdResultResource1"
                                                                       >
                                                                        <PagerStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                                                        <HeaderStyle CssClass="dataheader1" />
                                                                        <PagerSettings FirstPageText="" LastPageText="" Mode="NumericFirstLast" NextPageText=""
                                                                            PageButtonCount="5" PreviousPageText="" />
                                                                        <Columns>
                                                                         <asp:TemplateField HeaderText="S.No">
                                                                            <ItemTemplate>
                                                                                <%# Container.DataItemIndex + 1 %>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                            <asp:BoundField Visible="False" DataField="BookingID" HeaderText="HomeCollectionDetailsID"
                                                                                meta:resourcekey="BoundFieldResource1" />
                                                                            <asp:BoundField Visible="False" DataField="PatientID" HeaderText="PatientID" meta:resourcekey="BoundFieldResource2" />
                                                                         
                                                                            <asp:BoundField DataField="BookingID" HeaderText="Booking Number" meta:resourcekey="BoundFieldResource3" />
                                                                            <asp:BoundField DataField="PatientNumber" HeaderText="Patient Number" meta:resourcekey="BoundFieldResource3"
                                                                                Visible="False" />
                                                                            <asp:BoundField DataField="PatientName" HeaderText="Patient Name" meta:resourcekey="BoundFieldResource4" />
                                                                            <asp:BoundField DataField="Age" HeaderText="Age/Gender" meta:resourcekey="BoundFieldResource5" />
                                                                            <asp:BoundField DataField="DOB" HeaderText="DOB" Visible="False" meta:resourcekey="BoundFieldResource6" />
                                                                            <asp:BoundField DataField="PhoneNumber" HeaderText="Mobile No" meta:resourcekey="BoundFieldResource7" />
                                                                            <asp:BoundField DataField="CollectionTime" HeaderText="Collection Time" DataFormatString="{0:dd/MMM/yy hh:mm tt}"
                                                                                meta:resourcekey="BoundFieldResource5" />
                                                                            <asp:BoundField DataField="CollectionAddress" HeaderText="Collection Address" meta:resourcekey="BoundFieldResource6" />
                                                                            <asp:BoundField DataField="SourceType" HeaderText="Source Type" meta:resourcekey="BoundFieldResource8" />
                                                                            <asp:BoundField DataField="RoleName" HeaderText="Role Name" meta:resourcekey="BoundFieldResource7" />
                                                                            <asp:BoundField DataField="UserName" HeaderText="User" meta:resourcekey="BoundFieldResource8" />
                                                                            <asp:BoundField DataField="BookingStatus" HeaderText="Status" meta:resourcekey="BoundFieldResource9" />
                                                                            <asp:BoundField DataField="City" meta:resourcekey="BoundFieldResource10" Visible="False" />
                                                                            <asp:BoundField DataField="Comments" HeaderText="Comments" Visible="False" meta:resourcekey="BoundFieldResource11" />
                                                                            <asp:BoundField DataField="Priority" HeaderText="Priority" meta:resourcekey="BoundFieldResource12" />
                                                                            <asp:BoundField DataField="State" HeaderText="State" Visible="False" meta:resourcekey="BoundFieldResource13" />
                                                                            <asp:BoundField DataField="Pincode" HeaderText="Pincode" Visible="False" meta:resourcekey="BoundFieldResource14" />
                                                                            <asp:BoundField DataField="stateid" HeaderText="StateID" Visible="False" meta:resourcekey="BoundFieldResource15" />
                                                                            <asp:BoundField DataField="CityID" HeaderText="CityID" Visible="False" meta:resourcekey="BoundFieldResource16" />
                                                                            <asp:BoundField DataField="BillDescription" HeaderText="BillDescription" Visible="False"
                                                                                meta:resourcekey="BoundFieldResource17" />
                                                                         
                                                                        </Columns>
                                                                    </asp:GridView>
                                                                </div>
             
                        
              
                    </ContentTemplate>
                    <Triggers>
                        <%--  <asp:PostBackTrigger ControlID="btnSearch" />--%>
                         <asp:PostBackTrigger ControlID="imgBtnXL" />
                        <asp:PostBackTrigger ControlID="lnkExportXL" />
                    </Triggers>  
                </asp:UpdatePanel>
                <Attune:Attunefooter ID="Attunefooter" runat="server" />
                <asp:HiddenField ID="hdnHomeCollDtdID" runat="server" />
                <asp:HiddenField ID="hdnPatientID" runat="server" />
                <asp:HiddenField ID="hdnDOB" runat="server" />
                <asp:HiddenField ID="hdnNewDOB" runat="server" />
                <input id="hdnOrgID" type="hidden" value="0" runat="server" />
                <input id="hdnReferedPhyID" type="hidden" value="0" runat="server" />
                 <input id="hdnReferedPhyName" type="hidden"  runat="server" />
                <asp:HiddenField ID="hdnPatientName" runat="server" />
                <asp:HiddenField ID="hdnSelectedPatientID" runat="server" />
                <asp:HiddenField ID="hdnstatus" runat="server" />
                <asp:HiddenField ID="hdnrdosave" runat="server" />
                <input id="hdnGender" runat="server" value="" type="hidden" />
                <asp:HiddenField ID="hdnrdosearch" runat="server" />
                <asp:HiddenField ID="hdnRoleUser" runat="server" />
                <asp:HiddenField ID="hdnRoleId" runat="server" Value="0" />
                <asp:HiddenField ID="hdnUserID" runat="server" Value="0" />
                <%--  <asp:HiddenField ID="hdnorgids1" runat="server" Value="0" />--%>
                <asp:HiddenField ID="hdnlocid" runat="server" Value="0" />
                <asp:HiddenField ID="hdnBookingNumber" runat="server" />
                <asp:HiddenField ID="hdnSelectedBookingID" runat="server" />
                <asp:HiddenField ID="hdncurdatetime" runat="server" />
                <input id="hdnDefaultOrgBillingItems" type="hidden" value="" runat="server" />
                <input id="hdnSelectedClientClientID" type="hidden" value="0" runat="server" />
                <input type="hidden" runat="server" value="N" id="hdnIsMappedItem" />
                <input type="hidden" runat="server" id="hdnDefaultRoundoff" />
                <input type="hidden" runat="server" id="hdnRoundOffType" />
                <input id="hdnPreviousVisitDetails" type="hidden" value="" runat="server" />
                <input id="hdnBookingID" runat="server" type="hidden" />
                <input id="hdnBookingStatus" value ="" runat="server" type="hidden" />
                <asp:HiddenField ID="hdnMessages" runat="server" />
                <%-- <uc5:footer id="Footer1" runat="server" />--%>
                <asp:HiddenField ID="hdnuserselectedval" Value="0" runat="server" />
                <asp:Button ID="btnNoLog" runat="server" Style="display: none" 
                    meta:resourcekey="btnNoLogResource2"  />
                <asp:HiddenField ID="hdnDoFrmVisit" runat="server" />
                <asp:HiddenField ID="hdnDecimalAgeHC" runat="server" />
                <asp:HiddenField ID="hdnSelectTypeID" runat="server" />
                <%--Added for Mobile APP--%>
                <input id="hdnStateID" runat="server" type="hidden" />
                <input id="hdnCityID" runat="server" type="hidden" />
                <input id="hdnDispatch" runat="server" type="hidden" />
                <input id="hdnstate" runat="server" type="hidden" />
                <input id="hdnWholeXls" runat="server" type="hidden" value="" />
                <input id="hdnBookedID" runat="server" type="hidden" value="0" />
                <input id="hdnPageID" runat="server" type="hidden" value="0" />
            </div>
        </div>
    </div>
    </form>
</body>
</html>
<script type="text/javascript" language="javascript">
    $(function() {
        $(".datePicker").datepicker({
            dateFormat: 'dd/mm/yy',
            defaultDate: "+1w",
            changeMonth: true,
            changeYear: true,
            maxDate: 0,
            yearRange: '1900:2100',
            onClose: function(selectedDate) {
                //$(".datePicker").datepicker("option", "maxDate", selectedDate);

                //var date = $("#txtFrom").datepicker('getDate');
                //var d = new Date(date.getFullYear(), date.getMonth() + 1, 0);
                // $("#txtTo").datepicker("option", "maxDate", d);

            }
        });

    });
//    /* Example initialisation */
//    $(document).ready(function() {
//    $('#tblVaccinationList').dataTable({
//            "sPaginationType": "four_button"
//        });
//    });
 function uptechApplyclick(id) {  
var ButtonName = id; 
var OrgID    = document.getElementById('hdnOrgID').value;
var PageID = document.getElementById('hdnPageID').value;
var RoleID = document.getElementById('hdnRoleId').value; 
//if ($("#ddlTechni").val() == "0")  
//alert("Please select Technician in Group Filter search");
//else {
    var DataTable = [];
    var BookingListData = [];
    var PageContextkey = [];
    $("#tblVaccinationList tr:not(:first)").each(function(i, n) {
        var $row = $(n);

        var checked = $row.find("input[class$='Techni']").is(":checked");
        if (checked) {
            var BookingID = '0', PatientName = '', Sex = '', Age = '', DOB = '', Pincode = '', CollectionAddress2 = '', City = '', State = '',
            CityID = '', StateID = '', BookingOrgID = '', OrgAddressID = '', CollectionAddress = '', CollectionTime = '', UserID = '', PhoneNumber = '',
            Loc = '', ddlDOBDWMY = '', CollectionTime = '', BookingStatus = '',TitleCode='',

            LandLineNumber = '', EMail = '', DispatchValue = '', URNTypeID = '', URNO = '', Comments = '', TokenID = '', RefPhysicianName = '', Remarks = '', ExtRefNo = ''



            ////       var wholeData=  $row.find("input[class$='Techni']").attr('id');

            //       TechniTask(wholeData);

            //  $('[name="chkRow"]:checked').each(function(data) {
            //   var rowData = trVaccination..row(this).data();
            var rowData = $row.find("input[class$='Techni']").attr('id');

            //   var BookingID = '';
            //   var BookingStatus = '';
            //   var UserID = '';
            //   var TokenID = '';
            //   var PatientName = '';
            var Tempdata = rowData.split('~');












            //    DataTable.push({ 
            BookingID = parseInt(Tempdata[0]);
            if ($('#ddlStat').val() == 0) {
                BookingStatus = Tempdata[31];
            }
            else {
                if ($('#ddlStat').val() != 'A' && $('#ddlStat').val() != 'C' && $('#ddlStat').val() != 'TC') {
                    ValidationWindow('We can allow Assigned or Cancelled or Trip Cancelled status only.', 'Information');
                    return false;
                }
                else if (Tempdata[31] == 'TS' && Tempdata[31] == 'IP' && Tempdata[31] == 'RD') {
                ValidationWindow('We can allow Assigned or Cancelled or Trip Cancelled status only.', 'Information');
                    return false;
                }
                else {
                    BookingStatus = $('#ddlStat').val();
                }
            }

          //  BookingStatus = $('#ddlStat').val();
            if ($('#ddlTechni').val() == 0) {
                UserID = Tempdata[22];
            }
            else {
                UserID = $('#ddlTechni').val();
            }
            
        //    UserID = parseInt($('#ddlTechni').val());
            TokenID = 'S';
            TitleCode = Tempdata[36];
            PatientName = Tempdata[1];
            Sex = Tempdata[11];
           
            var strdate = Tempdata[13];

            var testdate = reformatDateString(strdate);
            var d = new Date(testdate);
            DOB = d.toJSON();
            var DOB1 = d.toISOString();
           
            Age = Tempdata[12];
            LandLineNumber = Tempdata[24];
            PhoneNumber = Tempdata[23];
            EMail = Tempdata[27];
            Loc = Tempdata[15];
            Pincode = Tempdata[14];
            if (parseInt(Tempdata[32]) == '') {
                CityID = 0;
            }
            else {
                CityID = parseInt(Tempdata[32]);
            }
            if (parseInt(Tempdata[33]) == '') {
                StateID = 0;
            }
            else {
                StateID = parseInt(Tempdata[33]);
            }
            CollectionAddress = Tempdata[3];
            CollectionAddress2 = Tempdata[15];
            City = Tempdata[34];
            State = Tempdata[35];

            Comments = Tempdata[29];


            OrgAddressID = parseInt(Tempdata[19]);


            var COlltime = [];
            var AMrPM = '';
            var time = '';
            COlltime = Tempdata[21].split(' ');
            if (COlltime.length <= 2) {
                AMrPM = COlltime[1].slice(-2);
                time = COlltime[1].replace(COlltime[1].slice(-2), '');
            }
            else {
                AMrPM = COlltime[2];
                time = COlltime[1];
            }
            //   var CollectionTimetes = reformatDateString(COlltime[0].replace(/-/g, '/')) + ' ' + time; /;/ + ' ' + AMrPM;
            var CollectionTimetes = reformatDateString(COlltime[0].replace(/-/g, '/')) + ' ' + time + ' ' + AMrPM;












            //  CollectionTime = Tempdata[21];
            //  var strdate1 = Tempdata[21];

            //  var testdate1 = reformatDateString(strdate1);
          //  debugger;
            var date = new Date(CollectionTimetes); //).format("YYYY-MM-DD HH:mm:ss");
            //  var date = new date(COlltime);
            // var d1 = checkZero(date.getDate()) + "/" + checkZero((date.getMonth() + 1)) + "/" + checkZero(date.getFullYear()) + " " + checkZero(date.getHours()) + ":" + checkZero(date.getMinutes()) + ":" + checkZero(date.getSeconds());
            var d1 = date;
            function checkZero(data) {
                if (data.length == 1) {
                    data = "0" + data;
                }
                return data;
            }
            
            var CollectionTime = CollectionTimetes;
        
            BookingOrgID = parseInt(Tempdata[18]);
            DispatchValue = Tempdata[28];
            URNTypeID = parseInt(Tempdata[25]);
            URNO = Tempdata[26];
            RefPhysicianName = Tempdata[30];
            ExtRefNo = Tempdata[37];
            var ActionType = "";
            switch (BookingStatus) {
                case "A": ActionType = "hca";
                    break;
                case "RS": ActionType = "hcr";
                    break;
                case "C": ActionType = "hccan";
                    break;
            }

            BookingListData.push({
                TitleCode: TitleCode,
                PatientName: PatientName,
                Sex: Sex,
                DOB: DOB,
                Age: Age,
                LandLineNumber: LandLineNumber,
                PhoneNumber: PhoneNumber,
                EMail: EMail,
                OrgAddressID: OrgAddressID,
                CollectionAddress: CollectionAddress,
                UserID: UserID,
                CollectionTime: CollectionTime,
                BookingOrgID: BookingOrgID,
                BookingStatus: BookingStatus,
                CollectionAddress2: CollectionAddress2,
                City: City,
                BookingID: BookingID,
                Comments: Comments,
                State: State,
                Pincode: Pincode,
                CityID: CityID,
                StateID: StateID,

                URNTypeID: URNTypeID,
                URNO: URNO,

                DispatchValue: DispatchValue,


                TokenID: TokenID,
                RefPhysicianName: RefPhysicianName,
                ExtRefNo: ExtRefNo

            });
            PageContextkey.push({
                 ID : OrgAddressID,
                 PatientID : BookingID,
                 RoleID : RoleID,
                 OrgID : OrgID,
                 PatientVisitID : BookingID,
                 PageID : PageID,
                 ButtonName : ButtonName,
                 ActionType : ActionType
                });


        }
    });
           
     
           $.ajax({
               type: "POST",
               url: "../HCService.asmx/UpdateHCBulkBookingDetails",
                 data: JSON.stringify({ lstBookings: BookingListData, lstPageContext: PageContextkey}),
           //  data:{ lstBookings: BookingListData },
               contentType: "application/json; charset=utf-8",
               dataType: "json",
               success: OnSuccess,
               error: function(x) {

                   var d = x;
               },
               failure: function(response) {
                   alert(response.d);
                   return false;
               }
           });
           function OnSuccess(response) {

               ValidationWindow('Updated Successfully', 'Information');
               return false;
               
               $('#AddVaccDetails').show();
               $('#tblVaccinationList').show();
           }
           
   // }
}





     
 

 
 

 

</script>
<script type="text/javascript" language="javascript">
    function DispatchChecked() {

        var checked_checkboxes = $("[id*=chkDespatchMode] input:checked");
        var message = "";
        checked_checkboxes.each(function() {
            var value = $(this).val();
            var text = $(this).closest("td").find("label").html();
            message += text;
            message += ",";
        });
        document.getElementById('hdnDispatch').value = '';
        document.getElementById('hdnDispatch').value = message;

        return false;
    }
    function SelectTab(source, eventArgs) {

        var location = eventArgs.get_value().split('|')[0];
        var locationdetails = location.split('~');
        document.getElementById('txtpincode').value = locationdetails[0];
        document.getElementById('txtPinCodeBo').value = locationdetails[0];

        document.getElementById('txtCity').value = locationdetails[1];
        document.getElementById('txtstate').value = locationdetails[2];
        //Regarding MobileAPP
        document.getElementById('hdnCityID').value = locationdetails[3];
        document.getElementById('hdnStateID').value = locationdetails[4];
        document.getElementById('hdnstate').value = locationdetails[2]

    }
    function Repagination() {
        //        $("#nav").empty();
        var rowsShown = 10;
        var rowsTotal = $('#tblVaccinationList tbody tr').length;
        var numPages = rowsTotal / rowsShown;
        var a = document.getElementsByClassName("activebtn");

        $(this).addClass('activebtn');
        var rowsShown = 10;
        if ($(a).attr('rel') != null) {
            var currPage = $(a).attr('rel');
            //var currPage = 5;
            var startItem = currPage * rowsShown;
            var endItem = startItem + rowsShown;
            $('#tblVaccinationList tbody tr').css('opacity', '0.0').hide().slice(startItem, endItem).
                        css('display', 'table-row').animate({ opacity: 1 }, 300);
        }
        else { $("#nav").empty(); }
    }

    function Pageination() {
        $("#nav").empty();
        var rowsShown = 10;
        var rowsTotal = $('#tblVaccinationList tbody tr').length;
        var numPages = rowsTotal / rowsShown;
        for (i = 0; i < numPages; i++) {
            var pageNum = i + 1;
            $('#nav').append('<a href="#" rel="' + i + '">' + pageNum + '</a> ');
        }
        $('#tblVaccinationList tbody tr').hide();
        $('#tblVaccinationList tbody tr').slice(0, rowsShown).show();
        $('#nav a:first').addClass('activebtn');
        $('#nav a').bind('click', function() {

            $('#nav a').removeClass('activebtn');
            $(this).addClass('activebtn');
            var currPage = $(this).attr('rel');
            var startItem = currPage * rowsShown;
            var endItem = startItem + rowsShown;
            $('#tblVaccinationList tbody tr').css('opacity', '0.0').hide().slice(startItem, endItem).
                        css('display', 'table-row').animate({ opacity: 1 }, 300);
        });

    }

    function checkCodes() {
        var searchText = document.getElementById('txtPinCodeBo').value.toUpperCase().trim();
        searchTable(searchText);
    }
    function clearClick() {
        document.getElementById('hdnBookingStatus').value = '';
        GetData();
        $('#AddVaccDetails').show();
        $('tblVaccinationList').show();
    }

    function searchTable(inputVal) {
        var table = $('#tblVaccinationList');
        if (inputVal.length > 0) {
            table.find('tr').each(function(index, row) {
                var allCells = $(row).find('td');
                if (allCells.length > 0) {
                    var found = false;
                    allCells.each(function(index, td) {
                        var regExp = new RegExp(inputVal, 'i');
                        if (regExp.test($(td).text())) {
                            found = true;
                            return false;
                        }
                    });
                    if (found == true) $(row).show(); else $(row).hide();
                }
                //$(row).css('display', 'table-row');
                //Pageination();
            });
        }
        else {
            $('#tfooterexample').css('display', 'table-row');
            Pageination();
        }
    }

    function ForFutureDate(CDate) {
        //debugger;
        var MyDate = CDate;
        var sysDate = document.getElementById('hdncurdatetime').value;
        var curDay = parseInt(sysDate.split(' ')[0].split('/')[0]);
        var curMon = parseInt(sysDate.split(' ')[0].split('/')[1]);
        var curYear = parseInt(sysDate.split(' ')[0].split('/')[2]);
        var curhour = parseInt(sysDate.split(' ')[1].trim().substring(0, 5).split(':')[0]);
        var curminute = parseInt(sysDate.split(' ')[1].trim().substring(0, 5).split(':')[1]);
        var hour = MyDate.split(' ')[1].trim().substring(0, 5).split(':')[0];
        var minute = MyDate.split(' ')[1].trim().substring(0, 5).split(':')[1];
        var AMPM = MyDate.split(' ')[1].substring(5, 7);
        var campm = sysDate.split(' ')[2];
        minute = parseInt(minute);
        if (AMPM == 'PM') {
            hour = parseInt(hour) + 12;
        }
        if (campm == 'PM' && curhour != 12) {
            curhour = parseInt(curhour) + 12;
        }
        DateOnly = MyDate.split('-');
        var Day = parseInt(DateOnly[0]);
        var Mon = parseInt(DateOnly[1]);
        var Year = parseInt(DateOnly[2]);

        if ((Day < curDay && Mon == curMon && Year == curYear) || (Mon < curMon && Year == curYear) || (Year < curYear)
             || (hour < curhour && Day == curDay && Mon == curMon) || (minute < curminute && hour == curhour && Day == curDay && Mon == curMon)) {
            ValidationWindow("Dont select Collection date and Time as past Date.", "Alert");
            return false;
        }

    }
    
    
</script>

<script type="text/javascript" language="javascript">
 //   var strUpdate = SListForAppDisplay.Get("ServiceMaster_Controls_VaccinationMaster_ascx_05") == null ? "Update" : SListForAppDisplay.Get("ServiceMaster_Controls_VaccinationMaster_ascx_05");
 //   var strModify = SListForAppDisplay.Get("ServiceMaster_Controls_VaccinationMaster_ascx_06") == null ? "Modify" : SListForAppDisplay.Get("ServiceMaster_Controls_VaccinationMaster_ascx_06");
    function reformatDateString(s) {
        var b = s.split(/\D/);
        return b.reverse().join('-');
    }

    function getddlstats() {
        var selectedValue = document.getElementById('ddlstats').value;
        var tempstatus = document.getElementById('hdnBookingStatus').value;
        //alert(tempstatus + ', ' + selectedValue);

        if (selectedValue != 'A' && selectedValue != 'C' && selectedValue != 'TC') {
            $('#ddlstats option').prop('selected', function() {
                return this.defaultSelected;
            });
            ValidationWindow('We can allow only Assigned or Cancelled or Trip Cancelled', 'Information');
        }
        else if (tempstatus == 'TS' || tempstatus == 'RD' || tempstatus == 'IP') {
            $('#ddlstats option').prop('selected', function() {
                return this.defaultSelected;
            });
            ValidationWindow('Trip Started already', 'Information');
        }
    }



    function setVaccValues(id) {
        var ButtonName = id;
        var PageContextkey = [];
        var BookingListData = [];
        var OrgID = document.getElementById('hdnOrgID').value;
        var PageID = document.getElementById('hdnPageID').value;
        var RoleID = document.getElementById('hdnRoleId').value; 
        DispatchChecked();
        var BookingList = [];
        var BookingID = document.getElementById('hdnBookingID').value;
        var TitleCode = $('#ddSalutation').val();
        var PatientName = document.getElementById('txtPatientName').value;
        var Sex = document.getElementById('ddlSex').value;
        var Age1 = document.getElementById('txtDOBNos').value + ' ' + document.getElementById('ddlDOBDWMY').value;

        var Age = Age1.trim();
        var Pincode = document.getElementById('txtPinCodeBo').value;
        var CollectionAddress2 = document.getElementById('txtSuburb').value;
        var City = document.getElementById('textcity').value;
        var State = document.getElementById('textstate').value.trim();
        var CityID;
        if (document.getElementById('hdnCityID').value == '') {
            CityID = 0;
        }
        else {
            CityID = document.getElementById('hdnCityID').value;
        }
       
        var StateID;
        if (document.getElementById('hdnStateID').value == '') {
            StateID = 0;
        }
        else {
            StateID = document.getElementById('hdnStateID').value;
        }

        var BookingOrgID = document.getElementById('ddlOrg1').value;
        var OrgAddressID = $('#ddlLocation').val();
        var CollectionAddress = document.getElementById('txtAddress').value;

        var COlltime = [];
        var AMrPM = '';
        var time = '';
        COlltime = document.getElementById('txtTime').value.split(' ');
        if (COlltime.length <= 2) {
            AMrPM = COlltime[1].slice(-2);
            time = COlltime[1].replace(COlltime[1].slice(-2), '');
        }
        else {
            AMrPM = COlltime[2];
            time = COlltime[1];
        }
        var CollectionTime = reformatDateString(COlltime[0].replace(/-/g, '/')) + ' ' + time + ' ' + AMrPM; 
   
        var strdate = document.getElementById('tDOB').value;
       
        var testdate = reformatDateString(strdate);
     
        var DOB = testdate;

        if ($('#ddlUser').val() == '') {
            var UserID = '';
        }
        else {
            var UserID = $('#ddlUser').val();
        }
        var PhoneNumber = document.getElementById('txtMobile').value;

        var LandLineNumber = document.getElementById('txtTelephoneNo').value;
        var EMail = document.getElementById('txtEmail').value;
        var DispatchValue = document.getElementById('hdnDispatch').value;
        var URNTypeID = $('#ddlUrnType').val();
        var URNO = document.getElementById('txtURNo').value;
        var Comments = document.getElementById('txtFeedback').value;
        var TokenID = "U";

        var RefPhysicianName = document.getElementById('txtInternalExternalPhysician').value;
        //   var BookingStatus = $('#ddlstats').val();
        var BookingStatus = $("#ddlstats :selected").text();
        var ActionType = "hcr";
        switch (BookingStatus) {
            case "A": ActionType = "hca";
                break;
            case "RS": ActionType = "hcr";
                break;
            case "C": ActionType = "hccan";
                break;
          //  default: ActionType = "hcr"; 
           
        }
        var ExtRefNo = document.getElementById('txtExtRefNo').value;
//        if ($('#ddlstats').val() != 'A' && $('#ddlstats').val() != 'C') {
//            alert('We can allow only Assigned or Cancelled.');
//            return false;
//        }
        var Flag = 1;
        BookingList.push({
        TitleCode:TitleCode,
        PatientName: PatientName,
        Sex: Sex,
        DOB: DOB,
        Age: Age,
        LandLineNumber: LandLineNumber,
        PhoneNumber: PhoneNumber,
        EMail: EMail,
        OrgAddressID: parseInt(OrgAddressID),
        CollectionAddress: CollectionAddress,
        UserID: parseInt(UserID),
        CollectionTime: CollectionTime,
        BookingOrgID: parseInt(BookingOrgID),
          BookingStatus: BookingStatus,
           CollectionAddress2: CollectionAddress2,
            City: City,
            BookingID: parseInt(BookingID),
             Comments: Comments,
             State: State,
             Pincode: Pincode,
            CityID: CityID,
            StateID: StateID,
           
           URNTypeID: parseInt(URNTypeID),
            URNO:URNO,
         
            DispatchValue: DispatchValue,
           
           
            TokenID: TokenID,
            RefPhysicianName: RefPhysicianName,
            ExtRefNo: ExtRefNo







           
          
           
          

        });
        debugger;
        PageContextkey.push({
            ID: OrgAddressID,
            PatientID: BookingID,
            RoleID: RoleID,
            OrgID: OrgID,
            PatientVisitID: BookingID,
            PageID: PageID,
            ButtonName: ButtonName,
            ActionType: ActionType
        });

        var _flag = true;
        if ($("#tblVaccinationList")[0].rows.length > 1) {
            $('[id$="tblVaccinationList"] tbody tr').each(function(i, n) {
                var currentRow = $(n);
                var gBookingID = currentRow.find("span[id$='BookingID']").html();
                var gTitleCode = currentRow.find("span[id$='TitleCode']").html();
                var gPatientName = currentRow.find("span[id$='PatientName']").html();
                var gSex = currentRow.find("span[id$='Sex']").html();
                var gAge = currentRow.find("span[id$='Age']").html();
                var gDOB = currentRow.find("span[id$='DOB']").html();
                var gLoc = currentRow.find("span[id$='Loc']").html();
                var gCity = currentRow.find("span[id$='City']").html();
                var gState = currentRow.find("span[id$='State']").html();
                var gddlLoc = currentRow.find("span[id$='ddlLoc']").html();
                var gCollectionAddress = currentRow.find("span[id$='CollectionAddress']").html();
                var gCollectionAddress2 = currentRow.find("span[id$='CollectionAddress2']").html();
                var gPhoneNumber = currentRow.find("span[id$='PhoneNumber']").html();
                var gLandLineNumber = currentRow.find("span[id$='LandLineNumber']").html();
                var gPincode = currentRow.find("span[id$='Pincode']").html();
                var gName = currentRow.find("span[id$='Name']").html();
                var gEMail = currentRow.find("span[id$='EMail']").html();
                var gBillDescription = currentRow.find("span[id$='BillDescription']").html();
                var gCreatedAt = currentRow.find("span[id$='CreatedAt']").html();
                var gCollectionTime = currentRow.find("span[id$='CollectionTime']").html();
                var gPaymentStatus = currentRow.find("span[id$='PaymentStatus']").html();
                var gUserName = currentRow.find("span[id$='UserName']").html();
                var gBookingStatus = currentRow.find("span[id$='BookingStatus']").html();
                var gRemarks = currentRow.find("span[id$='Remarks']").html();
                var gComments = currentRow.find("span[id$='Comments']").html();
                var gExtRefNo = currentRow.find("span[id$='ExtRefNo']").html();
                if (PatientName == gPatientName) {
                    _flag = false;
                }
            });
        }
        if (_flag) {

          //  var lstBookings = BookingList;
            saveVaccDetails();
        }
//        else {
//            var userMsg = SListForAppMsg.Get("ServiceMaster_Controls_VaccinationMaster_ascx_03") == null ? "Item Already Exist" : SListForAppMsg.Get("ServiceMaster_Controls_VaccinationMaster_ascx_03");
//            ValidationWindow(userMsg, errorMsg);
//        }
        $('#btnVaccUpdate').hide();

        if ($("#tblVaccinationList")[0].rows.length > 1) {
            $('[id$="tblVaccinationList"] tbody tr').each(function(i, n) {
                var currentRow = $(n);
                currentRow.find("input:button[id$='btnEdit']").show();


            });
        }

        function saveVaccDetails() {

            $.ajax({
                type: "POST",

                url: "../HCService.asmx/UpdateHCBookingDetails",
                data: JSON.stringify({ lstBookings: BookingList, lstPageContext: PageContextkey }),
          //    url:"../HCService.asmx/UpdateHCBulkBookingDetails",
              //  data: "lstBookings: " + JSON.stringify(BookingList), 
          //      data: JSON.stringify({ lstBookings: BookingList }),
                //  data: JSON.stringify({ lstBookings: BookingList }),
                //  data: { lstBookings: lstBookingList },
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                //    async: true,
                //    cache: false,
                success: OnSuccess,
                failure: function(response) {
                    alert(response.d);
                }

                //           success: OnSuccess,
                //            error: function(x) {
                //                var d = x;
                //            },
                //            failure: function(response) {
                //                alert(response.d);
                //                return false;
                //            }
            });
        }
        function OnSuccess(response) {
            ValidationWindow('Booking ID : ' + response.d + ' Updated successfully ', 'Information');
            
           // $('#tblVaccinationDetails').show();
            $('#AddVaccDetails').show();
            $('#tblVaccinationList').show();
        }
//        function OnSuccess(response) {
//            alert('Booking ID : ' + response.d + ' Updated successfully ');

//            $('#tblVaccinationDetails').show();
//            $('#AddVaccDetails').show();
//            $('#tblVaccinationList').show();
//        }
           


         //   VaccClear();
        
            $('#hdnBookingID').val('0');
        }
 //   }
  
    function EditVaccTemp(obj, ele) {

    //    $('#VaccinationMaster_btnVaccAdd').val('Modify').show();
     //   $('#VaccinationMaster_btnVaccAdd').text(strModify);
        if ($("#tblVaccinationList")[0].rows.length > 1) {
            $('[id$="tblVaccinationList"] tbody tr').each(function(i, n) {
                var currentRow = $(n);
                currentRow.find("input:button[id$='btnEdit']").hide();


            });
        }
        var TempTable = ele.split('~');
        var DataTable = [];
        DataTable.push({
        BookingID: TempTable[0],
        TitleCode:TempTable[36],
        PatientName: TempTable[1],
        Sex: TempTable[11],
        Age: TempTable[12],
     //   ddlDOBDWMY: TempTable[12].split(' ')[1],
        DOB: TempTable[13],
        Loc: TempTable[15],
        Pincode: TempTable[14],
        CollectionAddress: TempTable[3],
        CollectionAddress2: TempTable[20],
        City: TempTable[34],
        State: TempTable[35],
        PhoneNumber: TempTable[23],
        Comments: TempTable[29],
        LandLineNumber: TempTable[24],
        EMail: TempTable[27],
        CollectionTime: TempTable[21],
        UserID: TempTable[22],
        DispatchValue: TempTable[28],
        UrnTypeID: TempTable[25],
        URNo: TempTable[26],
        RefPhysicianName: TempTable[30],
        BookingStatus: TempTable[31],
        ExtRefNo:TempTable[37]
        });
        EditVaccDetails(DataTable);
    }
    function EditVaccination(obj, ele) {

     //   $('#VaccinationMaster_btnVaccAdd').val('Update').show();
     //   $('#VaccinationMaster_btnVaccAdd').text(strUpdate);
      //  $('#VaccinationMaster_btnVaccSave').val('Save').hide();
      
        if ($("#tblVaccinationList")[0].rows.length > 1) {
            $('[id$="tblVaccinationList"] tbody tr').each(function(i, n) {
                var currentRow = $(n);
                currentRow.find("input:button[id$='btnEdit']").hide();


            });
        }
        // assigning to the textbox

        var TempTable = ele.split('~');
        var DataTable = [];
        DataTable.push({
   
        BookingID: TempTable[0],
	//	 TitleCode:TempTable[32],
        TitleCode:TempTable[36],
        PatientName: TempTable[1],
        Sex: TempTable[11],
        Age: TempTable[12].split(' ')[0],
        ddlDOBDWMY: TempTable[12].split(' ')[1],
        DOB: TempTable[13],
        Loc:TempTable[15],
        Pincode: TempTable[14],
        CollectionAddress:TempTable[3],
        CollectionAddress2: TempTable[20],
        City: TempTable[34],
        State: TempTable[35],
        PhoneNumber: TempTable[23],
        Comments : TempTable[29],
        LandLineNumber: TempTable[24],
         EMail :TempTable[27],
        CollectionTime : TempTable[21],
        UserID : TempTable[22],
       DispatchValue:TempTable[28],
       UrnTypeID:TempTable[25],
       URNO:TempTable[26],
       RefPhysicianName: TempTable[30],
       BookingStatus: TempTable[31],
      ExtRefNo:TempTable[37]
        });
        EditVaccDetails(DataTable);
    }
/* text assingn in */
function EditVaccDetails(DataTable) {
       document.getElementById('hdnBookingStatus').value = '';
        $('#tblVaccinationDetails').show();
        $('#divsearch').hide();
//       
   var    BookingID='0',PatientName='',Sex='',Age='',DOB='',Pincode='',CollectionAddress2='',City= '',State='',
CityID = '', StateID = '', BookingOrgID = '', OrgAddressID = '', CollectionAddress = '', CollectionTime = '', UserID = '', PhoneNumber = '',
Loc = '', ddlDOBDWMY = '', CollectionTime = '', BookingStatus='',TitleCode='',

LandLineNumber = '', EMail = '', DispatchValue = '', UrnTypeID = '', URNO = '', Comments = '', TokenID = '', RefPhysicianName = '', Remarks = '', ExtRefNo=''

   $.each(DataTable, function(i, obj) {

       BookingID = obj.BookingID;
       TitleCode = obj.TitleCode;
       PatientName = obj.PatientName;
       Loc = obj.Loc;

       Sex = obj.Sex;
       Age = obj.Age;
       ddlDOBDWMY = obj.ddlDOBDWMY;
       DOB = obj.DOB;
       Pincode = obj.Pincode;

       City = obj.City;
       State = obj.State;
       Remarks = obj.Remarks;
       PhoneNumber = obj.PhoneNumber;
       CollectionAddress = obj.CollectionAddress;
       EMail = obj.EMail;
       Comments = obj.Comments;
       LandLineNumber = obj.LandLineNumber;
       CollectionTime = obj.CollectionTime;
       UserID = obj.UserID;
       DispatchValue = obj.DispatchValue;
       UrnTypeID = obj.UrnTypeID;
       URNO = obj.URNO;
       RefPhysicianName = obj.RefPhysicianName;
       BookingStatus = obj.BookingStatus;
       ExtRefNo = obj.ExtRefNo;
   });

   document.getElementById('hdnBookingID').value = BookingID;
   $("#ddSalutation > [value=" + TitleCode + "]").attr("selected", "true");
  // $('#ddSalutation').val(TitleCode);
        document.getElementById('txtPatientName').value = PatientName;
        document.getElementById('ddlSex').value = Sex;
        document.getElementById('txtDOBNos').value = Age;
        document.getElementById('ddlDOBDWMY').value = ddlDOBDWMY;
        document.getElementById('tDOB').value = DOB;
        document.getElementById('txtSuburb').value = Loc;

        document.getElementById('txtPinCodeBo').value = Pincode;
        document.getElementById('textstate').value = State;
    //    document.getElementById('hdnStateID').value = Inp[8].split(':')[1];


        document.getElementById('textcity').value = City;
      //  $('#ddlLocation').val(Inp[10]);
        $('#ddlUser').val(UserID);
        document.getElementById('txtTime').value = CollectionTime;
        document.getElementById('txtMobile').value = PhoneNumber;
        document.getElementById('txtTelephoneNo').value = LandLineNumber;
        document.getElementById('txtAddress').value = CollectionAddress;
        document.getElementById('txtEmail').value = EMail;
        document.getElementById('txtFeedback').value = Comments;
        $("#ddlUrnType > [value=" + UrnTypeID + "]").attr("selected", "true");
                   //  $('#ddlUrnType').val(UrnTypeID);
        document.getElementById('txtURNo').value = URNO;
        document.getElementById('hdnBookingStatus').value = BookingStatus;
        
        $("#ddlstats > [value=" + BookingStatus + "]").attr("selected", "true");
            //   $('#ddlstats').val(BookingStatus);
        document.getElementById('txtInternalExternalPhysician').value = RefPhysicianName;
        document.getElementById('txtExtRefNo').value = ExtRefNo;
               if (document.getElementById('txtEmail').value != '') {
                   document.getElementById('chkDespatchMode_0').checked = true;
               }
               else {
                   //elements.cells[0].childNodes[0].checked = false;
                   document.getElementById('chkDespatchMode_0').checked = false;

               }
               if (document.getElementById('txtMobile').value != '') {
                   document.getElementById('chkDespatchMode_1').checked = true;
               }
               else {
                   //elements.cells[0].childNodes[0].checked = false;
                   document.getElementById('chkDespatchMode_1').checked = false;

               }
               var Dispatch = [];
               if (DispatchValue != '') {
                   Dispatch = DispatchValue.split(',');
               }
               else {
                   Dispatch = '';
               }
               if (Dispatch.length > 0)
               {
                   $.each(Dispatch, function(index, value) {
               if (Dispatch[0] == "Email") {
                           document.getElementById('chkDespatchMode_0').checked = true;
                       }
                       if (Dispatch[1] == "Sms") {
                           document.getElementById('chkDespatchMode_1').checked = true;
                       }
                       if (Dispatch[2] == "Courier") {
                           document.getElementById('chkDespatchMode_2').checked = true;
                       }
                      



                   });


                }
        if (DataTable[0].BookingID == '0') {
            $('[id$="tblVaccinationList"] tbody tr').each(function(i, n) {
                var currentRow = $(n);

                var gBookingID = currentRow.find("span[id$='BookingID']").html();
                var gTitleCode = currentRow.find("span[id$='TitleCode']").html();
                var gPatientName = currentRow.find("span[id$='PatientName']").html();
                var gSex = currentRow.find("span[id$='Sex']").html();
                var gAge = currentRow.find("span[id$='Age']").html();
                var gDOB = currentRow.find("span[id$='DOB']").html();
                var gLoc = currentRow.find("span[id$='Loc']").html();
                var gCity = currentRow.find("span[id$='City']").html();
                var gState = currentRow.find("span[id$='State']").html();
                var gddlLoc = currentRow.find("span[id$='ddlLoc']").html();
                var gCollectionAddress = currentRow.find("span[id$='CollectionAddress']").html();
                var gCollectionAddress2 = currentRow.find("span[id$='CollectionAddress2']").html();
                var gPhoneNumber = currentRow.find("span[id$='PhoneNumber']").html();
                var gLandLineNumber = currentRow.find("span[id$='LandLineNumber']").html();
                var gPincode = currentRow.find("span[id$='Pincode']").html();
                var gName = currentRow.find("span[id$='Name']").html();
                var gEMail = currentRow.find("span[id$='EMail']").html();
                var gBillDescription = currentRow.find("span[id$='BillDescription']").html();
                var gCreatedAt = currentRow.find("span[id$='CreatedAt']").html();
                var gCollectionTime = currentRow.find("span[id$='CollectionTime']").html();
                var gPaymentStatus = currentRow.find("span[id$='PaymentStatus']").html();
                var gUserName = currentRow.find("span[id$='UserName']").html();
                var gBookingStatus = currentRow.find("span[id$='BookingStatus']").html();
                var gRemarks = currentRow.find("span[id$='Remarks']").html();
                var gComments = currentRow.find("span[id$='Comments']").html();
                if (BookingID == gBookingID && PatientName == gPatientName) {
                    currentRow.remove();
                }
                var gExtRefNo = currentRow.find("span[id$='ExtRefNo']").html();

            });
        }
        if (DataTable[0].BookingID != '0') {
            $('[id$="tblVaccinationList"] tbody tr').each(function(i, n) {
                var currentRow = $(n);
                var gBookingID = currentRow.find("span[id$='BookingID']").html();
                var gTitleCode = currentRow.find("span[id$='TitleCode']").html();
                var gPatientName = currentRow.find("span[id$='PatientName']").html();
                var gSex = currentRow.find("span[id$='Sex']").html();
                var gAge = currentRow.find("span[id$='Age']").html();
                var gDOB = currentRow.find("span[id$='DOB']").html();
                var gLoc = currentRow.find("span[id$='Loc']").html();
                var gCity = currentRow.find("span[id$='City']").html();
                var gState = currentRow.find("span[id$='State']").html();
                var gddlLoc = currentRow.find("span[id$='ddlLoc']").html();
                var gCollectionAddress = currentRow.find("span[id$='CollectionAddress']").html();
                var gCollectionAddress2 = currentRow.find("span[id$='CollectionAddress2']").html();
                var gPhoneNumber = currentRow.find("span[id$='PhoneNumber']").html();
                var gLandLineNumber = currentRow.find("span[id$='LandLineNumber']").html();
                var gPincode = currentRow.find("span[id$='Pincode']").html();
                var gName = currentRow.find("span[id$='Name']").html();
                var gEMail = currentRow.find("span[id$='EMail']").html();
                var gBillDescription = currentRow.find("span[id$='BillDescription']").html();
                var gCreatedAt = currentRow.find("span[id$='CreatedAt']").html();
                var gCollectionTime = currentRow.find("span[id$='CollectionTime']").html();
                var gPaymentStatus = currentRow.find("span[id$='PaymentStatus']").html();
                var gUserName = currentRow.find("span[id$='UserName']").html();
                var gBookingStatus = currentRow.find("span[id$='BookingStatus']").html();
                var gRemarks = currentRow.find("span[id$='Remarks']").html();
                var gComments = currentRow.find("span[id$='Comments']").html();
                if (BookingID == gBookingID && PatientName == gPatientName) {
                    currentRow.remove();
                    //currentRow.css("background", "#4DDBFF");
                }
                var gExtRefNo = currentRow.find("span[id$='ExtRefNo']").html();
            });
        }
    }
</script>

<script language="javascript" type="text/javascript">
    function expandDropDownListPage(elementRef) {
        elementRef.style.width = '210px';
    }

    function collapseDropDownList(elementRef) {
        elementRef.style.width = elementRef.normalWidth;

    }
    function getrefhospid(source, eventArgs) {


        var sval = 0;

        var OrgID = document.getElementById('hdnOrgID').value;
        var rec = "0"; //document.getElementById('hdfReferalHospitalID').value;
        var sval = "RPH" + "^" + OrgID + "^" + rec;
        $find('AutoCompleteExtenderRefPhy').set_contextKey(sval);

    }
    function GetPatientSearchList() {
        //debugger;
        var PatientNamesearch = $('#txtPatientName').val();
       // var rdoSearchType = $("#rblSearchType").find(":checked").val();
        var rdoSearchType = "4";
        if (rdoSearchType != "4") {// If value is 4 then Search Type is none.
            monkeyPatchAutocompleteTableApp();
            $('#txtPatientName').autocomplete({
                source: function(request, response) {
                    $.ajax({
                        type: "POST",
                        url: "../HCService.asmx/GetPatientListforBookings",
                        data: "{'prefixText':'" + PatientNamesearch + "','contextKey':'Y','flag':" + rdoSearchType + "}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        crossDomain: true,
                        success: function(result) {
                            debugger;
                            index = 0;
                            var autoCompleteArray = new Array();
                            autoCompleteArray = $.map(result.d, function(item) {

                                var Name = item.split(',')[1].split(':')[1].split('~');
                                return {
                                    label: Name[0],
                                    PatientName: Name[1],
                                    PatientNumber: Name[3],
                                    MobileNumber: Name[5],
                                    DOB: Name[7],
                                    Age: Name[9],
                                    Address: Name[23],
                                    City: Name[27],
                                    TelephoneNo: Name[31],
                                    Sex: Name[11],
                                    EMail: Name[13],
                                    pincode: Name[21],
                                    location: Name[25],
                                    state: Name[17],
                                    CityID: Name[15],
                                    StateID: Name[19],
                                    BookingID: Name[33]
                                };
                            });
                            response(autoCompleteArray);
                        }
                    });
                },
                minlength: 0,
                select: function(event, ui) {
                    $('#txtPatientName').val(ui.item.PatientName);
                    IAmSelected(ui, event);
                    return false;
                }
            });
        }
    }
    function GetData() {

        try {

            var today = new Date();
            var dd = today.getDate();
            var mm = today.getMonth() + 1; //January is 0!
            var yyyy = today.getFullYear();

            if (dd < 10) {
                dd = '0' + dd
            }

            if (mm < 10) {
                mm = '0' + mm
            }

            today = yyyy + '/' + mm + '/' + dd;



            var PatientID = 0;
            var BFromDate = ""; //'01/06/2015';
            var BToDate = ""; //'21/06/2015';
            var OrgID;



            var UserID = document.getElementById('drpTech').value;
         
            var CollecOrgAddrID;
            var Location;
            var Pincode;
            var BookingStatus;
            var pFromDate;
            var pToDate;
            var pCollectionFromDate;
            var pCollectionToDate;


            var UserID = document.getElementById('drpTech').value;
            CollecOrgAddrID = document.getElementById('ddlLocation').value;
            OrgID = document.getElementById('ddlOrg').value;
            Location = document.getElementById("txtLoc").value;
            Pincode = document.getElementById('txtpincode').value;
            BookingStatus = document.getElementById("drpStatusBo").value;
            pFromDate = document.getElementById('txtFromDateBook').value;
            pToDate = document.getElementById('txtToDateBook').value;
            pCollectionFromDate = document.getElementById('txtFromDate').value;
            pCollectionToDate = document.getElementById('txtToDate').value;
            var CollecOrgID = OrgID;
          
            if ($('#drpCollection').val() == 3) {
                pCollectionFromDate = document.getElementById('txtFromPeriod').value;
                pCollectionToDate = document.getElementById('txtToPeriod').value;

            }
            else if ($('#drpCollection').val() == 4) {

                pCollectionFromDate = today + ' 00:00 AM';
                pCollectionToDate = today + ' 23:59 PM';

            }

            if ($('#drpBooked').val() == 3) {
                pFromDate = document.getElementById('txtFromPeriodBook').value;
                pToDate = document.getElementById('txtToPeriodBook').value;
            }

            else if ($('#drpBooked').val() == 4) {
                pFromDate = today + ' 00:00 AM';
                pToDate = today + ' 23:59 PM';
            }



            var LoginOrgID = CollecOrgAddrID;



            var BookingNumber = document.getElementById("txtBookNos").value;
            var MobileNumber = document.getElementById("txtMob").value;

            var Task = "Search";
            var TelePhone = "";
            var pName = "";
           
            var PageSize = 5;
            var currentPageNo = 1;

            if (BookingNumber == "" || BookingNumber == null) {
                BookingNumber = 0;
            }
            $.ajax({
                type: "POST",
                url: "../HCService.asmx/GetHCBookingDetails",
              
                contentType: "application/json; charset=utf-8",
                data: "{CollecttionFromdate:'" + pCollectionFromDate + "',CollecttionTodate:'" + pCollectionToDate + "',Fromdate:'" + pFromDate + "',Todate:'" + pToDate + "',CollecOrgID:'" + CollecOrgID + "',LoginOrgID:'" + LoginOrgID + "',Status:'" + BookingStatus + "',Task:'" + Task + "',Location:'" + Location + "',Pincode:'" + Pincode + "',UserID:'" + UserID + "',MobileNumber:'" + MobileNumber + "',TelePhone:'" + TelePhone + "',pName:'" + pName + "',PageSize:'" + PageSize + "',currentPageNo:'" + currentPageNo + "',BookingNumber:" + BookingNumber + "}",
                dataType: "json",
                async: true,
                paging: true,
                success: function(data) {
                    var Items = data.d;
                    BindTaskTable(Items);
                    $('#AddVaccDetails').show();
                  
               //     document.getElementById('lnkExportXL').style.display = "block";
                    document.getElementById('imgBtnXL').style.display = "block";
                  
               
                },
                failure: function(msg) {
                    //alert('error');
                    return false;
                }
             
            });
        }
        catch (e) {
            alert("Error");
        }
        // return false;
    }
    function BindTaskTable(DataTable) {                              //  Function for BIND FEETYPE GROUP SUB GROUP LIST
        $('#trVaccination').empty();
        var lstSpecialGroup = [];
        var btnEdit = '', selchk = '';
        $.each(DataTable, function(i, obj) {
//        language: 
//        {
//            searchPanes: 
//            {
//                emptyPanes: 'There are no panes to display. :/'
//            }
//        },
      //  var remrks = obj.Remarks;
      //  var Inp = [];
      //  var Inp = remrks.split('~');
            dtTR = $('<tr/>');
            // id="'+obj.BookingID+'"  value="'+obj.BookingID+'"  var btnEdit = '<input id="btnEdit" value="Edit" type="button" class="ui-icon with-out-bkg ui-icon-pencil b-none pointer inline-block" onclick="EditVaccination(this,name);"  name="' + obj.VaccinationID + '~' + obj.VaccinationName + '~' + obj.ServiceCode + '~' + obj.VaccDescription + '~' + obj.IsAmountEditable + '~' + obj.IsRefundable + '~' + obj.IsDiscountable + '~' + obj.IsTaxable + '~' + obj.Status + '" />';

            if (obj.BookingStatus == 'Assigned' || obj.BookingStatus == 'Booked' || obj.BookingStatus == 'Canceled' || obj.BookingStatus == 'Trip Can-celled') {
                selchk = '<input type="checkbox" name="chkRow" Class="Techni" id="' + +obj.BookingID + '~' + obj.PatientName + '~' + obj.Age + '~' + obj.CollectionAddress + '~' + obj.PhoneNumber + '~' + obj.CollectionAddress2 + '~' + obj.Name + '~' + obj.BillDescription + '~' + obj.DOB + '~' + obj.Remarks + '~' + obj.BookingStatus + '"/>';
            }
            else {
                selchk = '';
            }
            
            var Sel = $('<td class="a-center"/>').html(selchk);
            //   var sCode = obj.ServiceCode == 'null' ? ' ' : obj.PatientName;
            var BookingID = $('<td class="a-left"/>').html("<span id='BookingID'>" + obj.BookingID + "</span>");
            var TitleCode = $('<td class="a-center hide" />').html("<span id='TitleCode'>" + obj.TitleCode + "</span>");
            var PatientName = $('<td class="a-left"/>').html("<span id='PatientName'>" + obj.PatientName + "</span>");
            var Age = $('<td class="a-left"/>').html("<span id='Age'>" + obj.Age + "</span>");
            var Sex = $('<td class="a-left hide"/>').html("<span id='Sex'>" + obj.Sex + "</span>");
            var DOB = $('<td class="a-left hide"/>').html("<span id='DOB'>" + obj.DOB + "</span>");
            var Loc = $('<td class="a-left hide"/>').html("<span id='Loc'>" + obj.Loc + "</span>");

            var City = $('<td class="a-center " />').html("<span id='City'>" + obj.City + "</span>");
            var State = $('<td class="a-center hide" />').html("<span id='State'>" + obj.State + "</span>");

            var ddlLoc = $('<td class="a-center  hide" />').html("<span id='ddlLoc'>" + obj.ddlLoc + "</span>");
            var CollectionAddress = $('<td class="a-left" style="width:5px;"/>').html("<span id='CollectionAddress'>" + obj.CollectionAddress + "</span>");
            var CollectionAddress2 = $('<td class="a-center"/>').html("<span id='CollectionAddress2'>" + obj.CollectionAddress2 + "</span>");
            var PhoneNumber = $('<td class="a-left"/>').html("<span id='PhoneNumber'>" + obj.PhoneNumber + "</span>");

            var LandLineNumber = $('<td class="a-left  hide"/>').html("<span id='LandLineNumber'>" + obj.LandLineNumber + "</span>");
            var Pincode = $('<td class="a-center" />').html("<span id='Pincode'>" + obj.Pincode + "</span>");
            var Name = $('<td class="a-left" />').html("<span id='Name'>" + obj.Name + "</span>");
            var EMail = $('<td class="a-left  hide" />').html("<span id='EMail'>" + obj.EMail + "</span>");
            var BillDescription = $('<td class="a-center" />').html("<span id='BillDescription'>" + obj.BillDescription + "</span>");
            var CreatedAt = $('<td class="a-center" />').html("<span id='CreatedAt'>" + formatJsonDateTime(obj.CreatedAt) + "</span>");
            var CollectionTime = $('<td class="a-center" />').html("<span id='CollectionTime'>" + formatJsonDateTime(obj.CollectionTime) + "</span>");
            var PaymentStatus = $('<td class="a-center" />').html("<span id='PaymentStatus'>" + obj.PaymentStatus != null ? obj.PaymentStatus : "" + "</span>");
            var UserName = $('<td class="a-center" />').html("<span id='UserName'>" + obj.UserName + "</span>");
            var BookingStatus = $('<td class="a-center" />').html("<span id='BookingStatus'>" + obj.BookingStatus + "</span>");
            var Remarks = $('<td class="a-center hide" />').html("<span id='Remarks'>" + obj.Remarks + "</span>");
            var Comments = $('<td class="a-center hide" />').html("<span id='Comments'>" + obj.Comments + "</span>");
            //obj.BookingStatus == 'Assigned' || obj.BookingStatus == 'Booked' || obj.BookingStatus == 'Canceled' || obj.BookingStatus == 'Trip Can-celled'
            var ExtRefNo = $('<td class="a-left" style="width:5px;"/>').html("<span id='ExtRefNo'>" + obj.Altmobilenotwo != null ? obj.Altmobilenotwo : "" + "</span>");
            if (obj.BookingStatus != 'Completed') {
                btnEdit = '<input id="btnEdit" value="Edit" type="button" class="ui-icon with-out-bkg ui-icon-pencil b-none pointer inline-block" onclick="EditVaccination(this,name);"  name="' + obj.BookingID + '~' + obj.PatientName + '~' + obj.Age + '~' + obj.CollectionAddress + '~' + obj.PhoneNumber + '~' + obj.CollectionAddress2 + '~' + obj.Name + '~' + obj.BillDescription + '~' + obj.DOB + '~' + obj.Remarks + '~' + obj.BookingStatus + '"/>'
            }
            else {
                btnEdit = '<input id="btnEdit" value="Edit" type="button" class="ui-icon with-out-bkg ui-icon-pencil b-none pointer inline-block" disabled = "disabled" />'
            }


            //   + '~' + obj.Sex + '~' + obj.Pincode + '~' + obj.City + '~' + obj.CityID +
            //    '~' + obj.State + '~' + obj.Stateid + '~' + obj.OrgAddressID +


            /*'~' + obj.Age +
            Select   Convert(varchar(30),BookingID)+'~'+PatientName + '~'+Sex + '~'+Age+ '~'+
            Convert(varchar(30),DOB,103) +'~'+Pincode+'~'+CollectionAddress2+'~'+City +':'+COnvert(varchar(30),CityID)   +'~'+State +':'+ isnull(COnvert(varchar(30),Stateid),'')  + '~'+COnvert
            (varchar(30),BookingOrgID) +'~' 
            +Convert(varchar(30),OrgAddressID) +'~'+CollectionAddress +'~'+Convert(varchar(30),FORMAT(CollectionTime,'dd/MM/yyyy hh:mm tt'))+'~'+
            Convert(varchar(30),UserID)+'~'+PhoneNumber+'~'+LandLineNumber+'~'+isnull(COnvert(varchar(30),URNTypeID),'')+'~' +isnull( URNO,'') +'~'+  Email+'~'+
            isnull(DispatchValue,'') +'~'+Comments +'~'+ isnull( RefPhysicianName,'') +'~'+ isnull( BookingStatus,'')+'~'+   isnull(COnvert(varchar(30),CityID),'')+ '~'+isnull(COnvert(varchar(30),Stateid),'')  + '~'+ isnull( City,'')+'~'+ isnull( State,'') from Bookings
            where Bookingid=50052





*/
            var tdAction = $('<td class="a-center" />').html(btnEdit);
            dtTR.append(Sel).append(BookingID).append(PatientName).append(Sex).append(Age).append(DOB).append(Loc)
            .append(State).append(ddlLoc).append(CollectionAddress)
              .append(PhoneNumber).append(LandLineNumber).append(CollectionAddress2).append(Pincode).append(EMail).append(Name).append(BillDescription)
              .append(CreatedAt).append(CollectionTime).append(PaymentStatus).append(UserName).append(BookingStatus).append(Remarks).append(ExtRefNo).append(tdAction);
            $('#trVaccination').append(dtTR);
           
            // object creation to pass for edit
            lstSpecialGroup.push({

                //  var rem = Remarks.split('~'),
                BookingID: BookingID,
                PatientName: PatientName,
                Sex:Sex,
                Age: Age,
                DOB: DOB,
                Loc: Loc,
                State: State,
                ddlLoc:ddlLoc,
                CollectionAddress: CollectionAddress,
                PhoneNumber: PhoneNumber,
                LandLineNumber: LandLineNumber,
                CollectionAddress2: CollectionAddress2,
                Pincode: Pincode,
                EMail:EMail,
                Name: Name,
               
                BillDescription: BillDescription,
                CreatedAt: CreatedAt,
                CollectionTime: CollectionTime,
                PaymentStatus: PaymentStatus,
              
                UserID: UserName,
                BookingStatus: BookingStatus,
                Remarks: Remarks,

ExtRefNo:ExtRefNo


            });
        });
        if ($('#tblVaccinationList tr').length > 0) {
            //document.getElementById('AddVaccDetails').style.display = "table";
            $('#AddVaccDetails').removeClass().addClass('displaytb w-100p');
            //document.getElementById('AddVaccButton').style.display = "block";
            $('#AddVaccButton').removeClass().addClass('show');

        }
        $('#btnVaccSave').hide();
        //   VaccClear();
        return false;
    }
    function enable() {
        //   $('#printDiv > tr').remove();
        $("#trVaccination").empty();
    }
  
</script>
   <script language="javascript" type="text/javascript">
       function CheckEmail() {
           //var elements = document.getElementById('chkDespatchMode');
           if (document.getElementById('txtEmail').value != '') {
               document.getElementById('chkDespatchMode_0').checked = true;
               //elements.cells[0].childNodes[0].checked = true;
           }
           else {
               //elements.cells[0].childNodes[0].checked = false;
               document.getElementById('chkDespatchMode_0').checked = false;

           }

       }
       function enableurntxt() {
           var comp = document.getElementById('ddlUrnType');
           if (comp.value != 0) {
               document.getElementById('txtURNo').disabled = false;
               document.getElementById('txtURNo').style.backgroundColor = "white";
               return false;
           }
           else
               document.getElementById('txtURNo').disabled = true;
           document.getElementById('txtURNo').style.backgroundColor = "#F2F2F2";
       }
        </script>
<script src="../Scripts/jquery.dataTables.min.js" type="text/javascript"></script>

<script src="../Scripts/jquery.table2excel.js" type="text/javascript"></script>

<script src="../Scripts/jquery-ui.js" type="text/javascript"></script>

<script src="../Scripts/JsonScript.js" type="text/javascript"></script>

<script src="../Scripts/HCTable.js" type="text/javascript"></script>
<script src="../Scripts/datetimepicker_css.js" type="text/javascript"></script>

<script language="javascript" type="text/javascript">
    //////Date Year - week - Custom



    function ShowRegDate() {
        document.getElementById('txtFromDate').value = "";
        document.getElementById('txtToDate').value = "";

        document.getElementById('hdnTempFrom').value = "";
        document.getElementById('hdnTempTo').value = "";

        document.getElementById('hdnTempFromPeriod').value = "0";
        document.getElementById('hdnTempToPeriod').value = "0";
        if (document.getElementById('drpCollection').value == "0") {

            document.getElementById('txtFromDate').value = document.getElementById('hdnFirstDayWeek').value;
            document.getElementById('txtToDate').value = document.getElementById('hdnLastDayWeek').value;

            document.getElementById('txtFromDate').disabled = true;
            document.getElementById('txtToDate').disabled = true;
            document.getElementById('hdnTempFrom').value = document.getElementById('hdnFirstDayWeek').value;
            document.getElementById('hdnTempTo').value = document.getElementById('hdnLastDayWeek').value;

            document.getElementById('divRegDate').style.display = 'block';
            document.getElementById('divRegDate').style.display = 'block';
            document.getElementById('divRegDate').style.display = 'inline';
            document.getElementById('divRegDate').style.display = 'inline';
            document.getElementById('divRegCustomDate').style.display = 'none';
            document.getElementById('divRegCustomDate').style.display = 'none';
        }
        if (document.getElementById('drpCollection').value == "1") {
            document.getElementById('txtFromDate').disabled = true;
            document.getElementById('txtToDate').disabled = true;
            document.getElementById('txtFromDate').value = document.getElementById('hdnFirstDayMonth').value;
            document.getElementById('txtToDate').value = document.getElementById('hdnLastDayMonth').value;
            document.getElementById('hdnTempFrom').value = document.getElementById('hdnFirstDayMonth').value;
            document.getElementById('hdnTempTo').value = document.getElementById('hdnLastDayMonth').value;

            document.getElementById('divRegDate').style.display = 'block';
            document.getElementById('divRegDate').style.display = 'block';
            document.getElementById('divRegDate').style.display = 'inline';
            document.getElementById('divRegDate').style.display = 'inline';
            document.getElementById('divRegCustomDate').style.display = 'none';
            document.getElementById('divRegCustomDate').style.display = 'none';
        }
        if (document.getElementById('drpCollection').value == "2") {
            document.getElementById('txtFromDate').disabled = true;
            document.getElementById('txtToDate').disabled = true;
            document.getElementById('txtFromDate').value = document.getElementById('hdnFirstDayYear').value;
            document.getElementById('txtToDate').value = document.getElementById('hdnLastDayYear').value;
            document.getElementById('hdnTempFrom').value = document.getElementById('hdnFirstDayYear').value;
            document.getElementById('hdnTempTo').value = document.getElementById('hdnLastDayYear').value

            document.getElementById('divRegDate').style.display = 'block';
            document.getElementById('divRegDate').style.display = 'block';
            document.getElementById('divRegDate').style.display = 'inline';
            document.getElementById('divRegDate').style.display = 'inline';
            document.getElementById('divRegCustomDate').style.display = 'none';
            document.getElementById('divRegCustomDate').style.display = 'none';

        }
        if (document.getElementById('drpCollection').value == "3") {
            document.getElementById('divRegDate').style.display = 'none';
            document.getElementById('divRegDate').style.display = 'none';
            document.getElementById('divRegCustomDate').style.display = 'block';
            document.getElementById('divRegCustomDate').style.display = 'block';
            document.getElementById('divRegCustomDate').style.display = 'inline';
            document.getElementById('divRegCustomDate').style.display = 'inline';
            document.getElementById('hdnTempFromPeriod').value = "1";
            document.getElementById('hdnTempToPeriod').value = "1";

        }
        if (document.getElementById('drpCollection').value == "-1") {
            document.getElementById('txtFromDate').disabled = true;
            document.getElementById('txtToDate').disabled = true;

            document.getElementById('divRegDate').style.display = 'none';
            document.getElementById('divRegDate').style.display = 'none';
            document.getElementById('divRegCustomDate').style.display = 'none';
            document.getElementById('divRegCustomDate').style.display = 'none';


        }
        if (document.getElementById('drpCollection').value == "4") {
            document.getElementById('txtFromDate').disabled = true;
            document.getElementById('txtToDate').disabled = true;

            document.getElementById('divRegDate').style.display = 'none';
            document.getElementById('divRegDate').style.display = 'none';
            document.getElementById('divRegCustomDate').style.display = 'none';
            document.getElementById('divRegCustomDate').style.display = 'none';


        }

        if (document.getElementById('drpCollection').value == "5") {
            document.getElementById('txtFromDate').disabled = true;
            document.getElementById('txtToDate').disabled = true;
            document.getElementById('txtFromDate').value = document.getElementById('hdnLastWeekFirst').value;
            document.getElementById('txtToDate').value = document.getElementById('hdnLastWeekLast').value;
            document.getElementById('hdnTempFrom').value = document.getElementById('hdnLastWeekFirst').value;
            document.getElementById('hdnTempTo').value = document.getElementById('hdnLastWeekLast').value;

            document.getElementById('divRegDate').style.display = 'block';
            document.getElementById('divRegDate').style.display = 'block';
            document.getElementById('divRegDate').style.display = 'inline';
            document.getElementById('divRegDate').style.display = 'inline';
            document.getElementById('divRegCustomDate').style.display = 'none';
            document.getElementById('divRegCustomDate').style.display = 'none';
        }
        if (document.getElementById('drpCollection').value == "6") {
            document.getElementById('txtFromDate').disabled = true;
            document.getElementById('txtToDate').disabled = true;
            document.getElementById('txtFromDate').value = document.getElementById('hdnLastMonthFirst').value;
            document.getElementById('txtToDate').value = document.getElementById('hdnLastMonthLast').value;
            document.getElementById('hdnTempFrom').value = document.getElementById('hdnLastMonthFirst').value;
            document.getElementById('hdnTempTo').value = document.getElementById('hdnLastMonthLast').value;

            document.getElementById('divRegDate').style.display = 'block';
            document.getElementById('divRegDate').style.display = 'block';
            document.getElementById('divRegDate').style.display = 'inline';
            document.getElementById('divRegDate').style.display = 'inline';
            document.getElementById('divRegCustomDate').style.display = 'none';
            document.getElementById('divRegCustomDate').style.display = 'none';
        }
        if (document.getElementById('drpCollection').value == "7") {
            document.getElementById('txtFromDate').disabled = true;
            document.getElementById('txtToDate').disabled = true;
            document.getElementById('txtFromDate').value = document.getElementById('hdnLastYearFirst').value;
            document.getElementById('txtToDate').value = document.getElementById('hdnLastYearLast').value;
            document.getElementById('hdnTempFrom').value = document.getElementById('hdnLastYearFirst').value;
            document.getElementById('hdnTempTo').value = document.getElementById('hdnLastYearLast').value;

            document.getElementById('divRegDate').style.display = 'block';
            document.getElementById('divRegDate').style.display = 'block';
            document.getElementById('divRegDate').style.display = 'inline';
            document.getElementById('divRegDate').style.display = 'inline';
            document.getElementById('divRegCustomDate').style.display = 'none';
            document.getElementById('divRegCustomDate').style.display = 'none';
        }
    }




    function ShowRegDateBook() {
        document.getElementById('txtFromDateBook').value = "";
        document.getElementById('txtToDateBook').value = "";

        document.getElementById('hdnTempFrom').value = "";
        document.getElementById('hdnTempTo').value = "";

        document.getElementById('hdnTempFromPeriod').value = "0";
        document.getElementById('hdnTempToPeriod').value = "0";
        if (document.getElementById('drpBooked').value == "0") {

            document.getElementById('txtFromDateBook').value = document.getElementById('hdnFirstDayWeek').value;
            document.getElementById('txtToDateBook').value = document.getElementById('hdnLastDayWeek').value;

            document.getElementById('txtFromDateBook').disabled = true;
            document.getElementById('txtToDateBook').disabled = true;
            document.getElementById('hdnTempFrom').value = document.getElementById('hdnFirstDayWeek').value;
            document.getElementById('hdnTempTo').value = document.getElementById('hdnLastDayWeek').value;

            document.getElementById('divRegDateBook').style.display = 'block';
            document.getElementById('divRegDateBook').style.display = 'block';
            document.getElementById('divRegDateBook').style.display = 'inline';
            document.getElementById('divRegDateBook').style.display = 'inline';
            document.getElementById('divRegCustomDateBook').style.display = 'none';
            document.getElementById('divRegCustomDateBook').style.display = 'none';
        }
        if (document.getElementById('drpBooked').value == "1") {
            document.getElementById('txtFromDateBook').disabled = true;
            document.getElementById('txtToDateBook').disabled = true;
            document.getElementById('txtFromDateBook').value = document.getElementById('hdnFirstDayMonth').value;
            document.getElementById('txtToDateBook').value = document.getElementById('hdnLastDayMonth').value;
            document.getElementById('hdnTempFrom').value = document.getElementById('hdnFirstDayMonth').value;
            document.getElementById('hdnTempTo').value = document.getElementById('hdnLastDayMonth').value;

            document.getElementById('divRegDateBook').style.display = 'block';
            document.getElementById('divRegDateBook').style.display = 'block';
            document.getElementById('divRegDateBook').style.display = 'inline';
            document.getElementById('divRegDateBook').style.display = 'inline';
            document.getElementById('divRegCustomDateBook').style.display = 'none';
            document.getElementById('divRegCustomDateBook').style.display = 'none';
        }
        if (document.getElementById('drpBooked').value == "2") {
            document.getElementById('txtFromDateBook').disabled = true;
            document.getElementById('txtToDateBook').disabled = true;
            document.getElementById('txtFromDateBook').value = document.getElementById('hdnFirstDayYear').value;
            document.getElementById('txtToDateBook').value = document.getElementById('hdnLastDayYear').value;
            document.getElementById('hdnTempFrom').value = document.getElementById('hdnFirstDayYear').value;
            document.getElementById('hdnTempTo').value = document.getElementById('hdnLastDayYear').value

            document.getElementById('divRegDateBook').style.display = 'block';
            document.getElementById('divRegDateBook').style.display = 'block';
            document.getElementById('divRegDateBook').style.display = 'inline';
            document.getElementById('divRegDateBook').style.display = 'inline';
            document.getElementById('divRegCustomDateBook').style.display = 'none';
            document.getElementById('divRegCustomDateBook').style.display = 'none';

        }
        if (document.getElementById('drpBooked').value == "3") {
            document.getElementById('divRegDateBook').style.display = 'none';
            document.getElementById('divRegDateBook').style.display = 'none';
            document.getElementById('divRegCustomDateBook').style.display = 'block';
            document.getElementById('divRegCustomDateBook').style.display = 'block';
            document.getElementById('divRegCustomDateBook').style.display = 'inline';
            document.getElementById('divRegCustomDateBook').style.display = 'inline';
            document.getElementById('hdnTempFromPeriod').value = "1";
            document.getElementById('hdnTempToPeriod').value = "1";

        }
        if (document.getElementById('drpBooked').value == "-1") {
            document.getElementById('txtFromDateBook').disabled = true;
            document.getElementById('txtToDateBook').disabled = true;

            document.getElementById('divRegDateBook').style.display = 'none';
            document.getElementById('divRegDateBook').style.display = 'none';
            document.getElementById('divRegCustomDateBook').style.display = 'none';
            document.getElementById('divRegCustomDateBook').style.display = 'none';


        }
        if (document.getElementById('drpBooked').value == "4") {
            document.getElementById('txtFromDateBook').disabled = true;
            document.getElementById('txtToDateBook').disabled = true;

            document.getElementById('divRegDateBook').style.display = 'none';
            document.getElementById('divRegDateBook').style.display = 'none';
            document.getElementById('divRegCustomDateBook').style.display = 'none';
            document.getElementById('divRegCustomDateBook').style.display = 'none';


        }

        if (document.getElementById('drpBooked').value == "5") {
            document.getElementById('txtFromDateBook').disabled = true;
            document.getElementById('txtToDateBook').disabled = true;
            document.getElementById('txtFromDateBook').value = document.getElementById('hdnLastWeekFirst').value;
            document.getElementById('txtToDateBook').value = document.getElementById('hdnLastWeekLast').value;
            document.getElementById('hdnTempFrom').value = document.getElementById('hdnLastWeekFirst').value;
            document.getElementById('hdnTempTo').value = document.getElementById('hdnLastWeekLast').value;

            document.getElementById('divRegDateBook').style.display = 'block';
            document.getElementById('divRegDateBook').style.display = 'block';
            document.getElementById('divRegDateBook').style.display = 'inline';
            document.getElementById('divRegDateBook').style.display = 'inline';
            document.getElementById('divRegCustomDateBook').style.display = 'none';
            document.getElementById('divRegCustomDateBook').style.display = 'none';
        }
        if (document.getElementById('drpBooked').value == "6") {
            document.getElementById('txtFromDateBook').disabled = true;
            document.getElementById('txtToDateBook').disabled = true;
            document.getElementById('txtFromDateBook').value = document.getElementById('hdnLastMonthFirst').value;
            document.getElementById('txtToDateBook').value = document.getElementById('hdnLastMonthLast').value;
            document.getElementById('hdnTempFrom').value = document.getElementById('hdnLastMonthFirst').value;
            document.getElementById('hdnTempTo').value = document.getElementById('hdnLastMonthLast').value;

            document.getElementById('divRegDateBook').style.display = 'block';
            document.getElementById('divRegDateBook').style.display = 'block';
            document.getElementById('divRegDateBook').style.display = 'inline';
            document.getElementById('divRegDateBook').style.display = 'inline';
            document.getElementById('divRegCustomDateBook').style.display = 'none';
            document.getElementById('divRegCustomDateBook').style.display = 'none';
        }
        if (document.getElementById('drpBooked').value == "7") {
            document.getElementById('txtFromDateBook').disabled = true;
            document.getElementById('txtToDateBook').disabled = true;
            document.getElementById('txtFromDateBook').value = document.getElementById('hdnLastYearFirst').value;
            document.getElementById('txtToDateBook').value = document.getElementById('hdnLastYearLast').value;
            document.getElementById('hdnTempFrom').value = document.getElementById('hdnLastYearFirst').value;
            document.getElementById('hdnTempTo').value = document.getElementById('hdnLastYearLast').value;

            document.getElementById('divRegDateBook').style.display = 'block';
            document.getElementById('divRegDateBook').style.display = 'block';
            document.getElementById('divRegDateBook').style.display = 'inline';
            document.getElementById('divRegDateBook').style.display = 'inline';
            document.getElementById('divRegCustomDateBook').style.display = 'none';
            document.getElementById('divRegCustomDateBook').style.display = 'none';
        }
    }
    function getDateTimeNow() {
        var now = new Date();
        var year = now.getFullYear();
        var month = now.getMonth() + 1;
        var day = now.getDate();
        var hour = now.getHours();
        var minute = now.getMinutes();
        var second = now.getSeconds();
        var AMrPM = "";
        if (month.toString().length == 1) {
            var month = '0' + month;
        }
        if (day.toString().length == 1) {
            var day = '0' + day;
        }
        if (hour.toString().length == 1) {
            var hour = '0' + hour;
        }
        if (minute.toString().length == 1) {
            var minute = '0' + minute;
        }
        if (second.toString().length == 1) {
            var second = '0' + second;
        }
        if (hour >= 12) {
            AMrPM = 'PM';
        }
        else {
            AMrPM = 'AM';
        }
        var dateTime = day + '/' + month + '/' + year + ' ' + hour + ':' + minute + ' ' + AMrPM;
        return dateTime;
    }
    function formatJsonDateTime(jsonDate) {
        var monthNames = [
        "Jan", "Feb", "Mar",
        "Apr", "May", "Jun", "Jul",
        "Aug", "Sep", "Oct",
        "Nov", "Dec"
    ];
        var oldDate = new Date(parseInt(jsonDate.slice(6, -2)));
        var month;
        var hours = oldDate.getHours();
        var minutes = oldDate.getMinutes();
        var ampm = hours >= 12 ? 'pm' : 'am';
        hours = hours % 12;
        hours = hours ? hours : 12; // the hour '0' should be '12'
        minutes = minutes < 10 ? '0' + minutes : minutes;
        hours = hours < 10 ? '0' + hours : hours;
        var strTime = hours + ':' + minutes + ' ' + ampm;

        //    if ((1 + oldDate.getMonth()) == 12) {
        //        month = monthNames[0 + oldDate.getMonth()]
        //    }
        //    else {
        month = monthNames[0 + oldDate.getMonth()]
        //    }
        //var DateTime = (oldDate.getDate() + '/' + (1 + oldDate.getMonth()) + '/' + oldDate.getFullYear() + ' ' + oldDate.getHours() + ":" + oldDate.getMinutes().toString().slice(-2));
        //var DateTime = (oldDate.getDate() + '/' + (month) + '/' + oldDate.getFullYear() + ' ' + oldDate.getHours() + ":" + oldDate.getMinutes().toString().slice(-2));
        var DateTime = (oldDate.getDate() + '/' + (month) + '/' + oldDate.getFullYear() + ' ' + strTime);
        return DateTime;
    }

    function formatJsonDate(jsonDate) {

        //    var dateString = jsonDate.substr(10);
        //    var currentTime = new Date(parseInt(dateString));
        //    var month = currentTime.getMonth() + 1;
        //    var day = currentTime.getDate();
        //    var year = currentTime.getFullYear();
        //    var date = day + "/" + month + "/" + year;
        //    return date;
        var monthNames = [
        "Jan", "Feb", "Mar",
        "Apr", "May", "Jun", "Jul",
        "Aug", "Sep", "Oct",
        "Nov", "Dec"
    ];

        var month;
        var oldDate = new Date(parseInt(jsonDate.slice(6, -2)));
        //    if ((1 + oldDate.getMonth()) == 12) {
        //        month = monthNames[0 + oldDate.getMonth()]
        //    }
        //    else {
        month = monthNames[0 + oldDate.getMonth()]
        //    }

        var DateTime = (oldDate.getDate() + '/' + (month) + '/' + oldDate.getFullYear());

        return DateTime;
    }
    function monkeyPatchAutocompleteTableApp() {

        var oldFn = $.ui.autocomplete.prototype._renderItem;
        $.ui.autocomplete.prototype._renderItem = function(ul, item) {
            //debugger;

            var re = new RegExp("(?![^&;]+;)(?!<[^<>]*)(" + this.term + ")(?![^<>]*>)(?![^&;]+;)", "gi");
            var t = item.label.replace(re, "<span style='font-weight:bold;'>$1</span>");
            if (index == 0) {
                //ul.prepend("<table><tr><td><li style='padding:0;margin:0;'><div class='borderGrey lh25 bold' style='min-width:640px;padding:0;margin:0;background:#f5f5f5;'><div class='borderGreyR w-30p inline-block'>Patient Name</div><div class='borderGreyR w-20p inline-block'>Patient Number</div><div class='borderGreyR w-28p inline-block'>Mobile Number</div><div class='w-20p inline-block'> Age </div></div></li></td></tr></table>")---<td class='w-25p activeheader'>Patient Number</td>
                //ul.prepend("<table  class='gridView'><tr class='gridHeader'><td class='w-10p borderGreyR activeheader'>BookingID</td><td class='w-25p borderGreyR activeheader'>Patient Name</td><td class='w-25p activeheader'>Patient Number</td><td class='gridHeader w-30p activeheader'>Mobile Number</td><td class='w-30p activeheader'> Age </td><td class='hide'> Address </td></li></td></tr></table>")
                // ul.prepend("<table  class='gridView'><tr class='gridHeader'><td class='w-10p borderGreyR activeheader'>BookingID</td><td class='w-25p borderGreyR activeheader'>Patient Name</td><td class='gridHeader w-30p activeheader'>Mobile Number</td><td class='w-30p activeheader'> Age </td><td class='hide w-30p'> Address </td></li></td></tr></table>")
                ul.prepend("<table  class='gridView'><tr class='gridHeader'><td class='w-10p borderGreyR activeheader'>BookingID</td><td class='w-25p borderGreyR activeheader'>Patient Name</td><td class='w-25p activeheader'>Patient Number</td><td class='gridHeader w-30p activeheader'>Mobile Number</td><td class='w-30p activeheader'> Age </td><td class='hide'> Address </td></li></td></tr></table>")

                index = 1;
            }
            //return $("<li></li>")
            return $("<tr></tr>")
                  .data("item.autocomplete", item)
            //   .append("<td class='borderGreyR w-30p  table-cell'>" + item.BookingID + "</td><td  class='borderGreyR w-30p table-cell'>" + item.PatientName + "</td><td  class='borderGreyR w-30p table-cell'>" + item.MobileNumber + "</td><td class='w-30p table-cell'>" + item.Age + "</td><td class=' w-30p hide'>" + item.Address + "</td></td></a></td>")
									     .append("<td class='borderGreyR w-12p  table-cell'>" + item.BookingID + "</td><td  class='borderGreyR w-25p table-cell'>" + item.PatientName + "</td><td  class='borderGreyR w-25p table-cell'>" + item.PatientNumber + "</td><td  class='borderGreyR w-30p table-cell'>" + item.MobileNumber + "</td><td class='w-30p table-cell'>" + item.Age + "</td><td class='hide'>" + item.Address + "</td></td></a></td>")
            //.append("<td class='borderGreyR w-12p  table-cell'>" + item.BookingID + "</td><td class='borderGreyR w-25p table-cell'>" + item.PatientName + "</td><td class='borderGreyR w-25p inline-block'>" + item.PatientNumber + "</td><td class='borderGreyR w-25p inline-block'>" + item.MobileNumber + "</td><td class='borderGreyR w-25p inline-block'>" + item.Age + "</td><td class='hide'>" + item.Address + "</td></td></a></td>")----<td  class='borderGreyR w-25p table-cell'>" + item.PatientNumber + "</td>

                  .appendTo(ul);

            //}
        };
    }
 
    function ClearPatientId() {
        document.getElementById('hdnSelectedPatientID').value = '';
    }
    function changedate() {
        NewCssCal('txtTime', 'ddmmyyyy', 'arrow', true, 12);
    }
    function showlocation() {

        var value = document.getElementById('txtPinCodeBo').value;
        if (value == '' || value == null) {
            var value = document.getElementById('txtpincode').value;

        }

        $.ajax({
            type: "POST",
            url: "../HCService.asmx/GetLocationforHomeCollectionpincode",
            data: '{"pincode": "' + value + '"}',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(data) {
                $.each(data.d, function(key, jsonvalue) {
                    debugger;

                    $("#txtpincode").val(jsonvalue.Pincode);
                    $("#txtSuburb").val(jsonvalue.LocationName);
                    $("#txtCity").val(jsonvalue.CityName);
                    $("#txtstate").val(jsonvalue.StateName);
                    $("#hdnStateID").val(jsonvalue.StateID);
                    $("#hdnCityID").val(jsonvalue.CityID);

                    $("#txtLoc").val(jsonvalue.LocationName);

                });

            }


        });

    }
    function ChangeUsers() {
        var UserID = document.getElementById('ddlUser').value;
        //alert(UserID);
        document.getElementById('hdnUserID').value = UserID;
    }

    function timevalidate() {
        var userid = document.getElementById('ddlUser').value;
        var collectiontime = document.getElementById('txtTime').value;


        $.ajax({

            type: "POST",
            url: "../HCService.asmx/GetHomeCollectionTime",

            // data:{userid:userid,collectiontime:collectiontime},
            // data: "{'userid': '" + userid + "','collectiontime':'"+ collectiontime +"'}",

            data: JSON.stringify({ "userid": userid, "collectiontime": collectiontime }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",

            success: function(data) {
                $.each(data.d, function(key, jsonvalue) {

                    if (jsonvalue.PatientID > 0) {

                        var colltime = confirm('Already ' + jsonvalue.PatientID + ' patient(s) booked for the same time slot. Are you sure you want to continue?.');
                        if (colltime) {
                            document.getElementById('ddlPriority').focus();
                            return false;
                        }
                        else {

                            document.getElementById('txtTime').focus();
                            return false;
                        }
                    }

                });

            }


        });
    }
</script>

<script language="javascript" type="text/javascript">
    $(window).on('beforeunload', function() {
        $('#preloader').hide();
    });
    </script>