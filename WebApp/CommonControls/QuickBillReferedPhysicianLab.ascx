<%@ Control Language="C#" AutoEventWireup="true" CodeFile="QuickBillReferedPhysicianLab.ascx.cs"
    Inherits="CommonControls_QuickBillReferedPhysicianLab" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>

<script type="text/javascript" src="../Scripts/jquery-1.2.2.pack.js"></script>

<script type="text/javascript">
    var ddlText, ddlValue, ddl, lblMesg, ddl1, ddl2;
    ddl1Text = new Array();
    ddl1Value = new Array();



    ddl2Text = new Array();
    ddl2Value = new Array();


    window.onload = loadDDL;

    function loadDDL() {
        document.getElementById('<%= hdnPhysicianValue.ClientID %>').value = "";
        ddl1 = document.getElementById('<%= ddlPhysician.ClientID %>');
        for (var i = 0; i < ddl1.options.length; i++) {
            ddl1Text[ddl1Text.length] = ddl1.options[i].text;
            ddl1Value[ddl1Value.length] = ddl1.options[i].value;
        }

        ddl2 = document.getElementById('<%= ddlRefPhysician.ClientID %>');
        for (var i = 0; i < ddl2.options.length; i++) {
            ddl2Text[ddl2Text.length] = ddl2.options[i].text;
            ddl2Value[ddl2Value.length] = ddl2.options[i].value;
        }
    }

    function FilterItemsReset1(pID) {
        ddl1 = document.getElementById(pID + "_ddlPhysician");
        ddl1.options.length = 0;
        for (var i = 0; i < ddl1Text.length; i++) {
            AddItem1(ddl1Text[i], ddl1Value[i]);
        }

        if (ddl1.options.length == 0) {
            AddItem1("No Physician Found", "");
        }
    }


    function AddItem1(text, value) {
        var opt = document.createElement("option");
        opt.text = text;
        opt.value = value;
        ddl1.options.add(opt);
    }


    function FilterItemsReset2(pID) {
        ddl2 = document.getElementById(pID + "_ddlRefPhysician");
        ddl2.options.length = 0;
        for (var i = 0; i < ddl2Text.length; i++) {
            AddItem2(ddl2Text[i], ddl2Value[i]);
        }

        if (ddl2.options.length == 0) {
            AddItem2("No Physician Found", "");
        }
    }

    function loadArrarsDDL(obj) {

        for (var k = 0; k < ddl2Text.length; k++) {
            ddl2Text.splice(k, ddl2Text.length);
        }
        for (var k = 0; k < ddl2Value.length; k++) {
            ddl2Value.splice(k, ddl2Text.length);
        }



        ddl2 = obj;
        for (var i = 0; i < ddl2.options.length; i++) {
            ddl2Text[ddl2Text.length] = ddl2.options[i].text;
            ddl2Value[ddl2Value.length] = ddl2.options[i].value;
        }
    }


    function SetDDValues(pValues) {
        var pVal = pValues.split("^");
        var pParID = "";

        for (var i = 0; i < document.forms[0].elements.length; i++) {
            element = document.forms[0].elements[i];
            if (element.type == "select-one") {
                if (element.id.split("_")[1] == "ddlRefPhysician") {
                    pParID += element.id.split("_")[0] + "^";
                }
            }
        }
        var istrue = true;
        a = pParID.split("^");
        for (var j = 0; j < a.length; j++) {
            if (a[j] != "") {
                ddl2 = document.getElementById(a[j] + "_ddlRefPhysician");
                ddl2.options.length = 0;

                for (var i = 0; i < pVal.length; i++) {
                    if (pVal[i] != "") {

                        AddItem2(pVal[i].split("~")[1], pVal[i].split("~")[0]);

                    }
                }
                if (istrue) {
                    loadArrarsDDL(ddl2);
                    istrue = false;
                }
                showExternal(a[j] + "_rdoExternal");
            }

        }


    }



    function AddItem2(text, value) {
        var opt = document.createElement("option");
        opt.text = text;
        opt.value = value;
        ddl2.options.add(opt);
    }


    function CacheItems(pID) {
        ddlText = new Array();
        ddlValue = new Array();

        if (document.getElementById(pID + "_divPhysicianName").style.display == 'block') {
            ddl = document.getElementById(pID + "_ddlPhysician");
        }
        else {
            ddl = document.getElementById(pID + "_ddlRefPhysician");
        }

        for (var i = 0; i < ddl.options.length; i++) {
            ddlText[ddlText.length] = ddl.options[i].text;
            ddlValue[ddlValue.length] = ddl.options[i].value;
        }
    }

    function FilterItems(value, ID) {

        var pID = ID.split("_")[0];
        if (document.getElementById(pID + "_rdoInternal").checked) {
            ddl = document.getElementById(pID + "_ddlPhysician")
        }
        if (document.getElementById(pID + "_rdoExternal").checked) {
            ddl = document.getElementById(pID + "_ddlRefPhysician")
        }

        ddl.options.length = 0;
        for (var i = 0; i < ddlText.length; i++) {
            if (ddlText[i].toLowerCase().indexOf(value.toLowerCase()) != -1) {
                AddItem(ddlText[i], ddlValue[i]);
            }
        }

        if (ddl.options.length == 0) {
            AddItem("No Physician Found", "");
        }
    }

    function AddItem(text, value) {
        var opt = document.createElement("option");
        opt.text = text;
        opt.value = value;
        ddl.options.add(opt);
    }

    function onPhysicianChange(ID) {
        var pID = ID.split("_")[0];
        var ddl = document.getElementById(pID + "_ddlPhysician");
        var ddllength = ddl.length;
        for (var i = 0; i < ddllength; i++) {
            if (ddl.options[i].selected) {
                document.getElementById(pID + "_hdnPhysicianValue").value = 'I~' + ddl.options[i].value + '~' + ddl.options[i].text;
                document.getElementById(pID + "_txtNew").value = ddl.options[i].text;
            }
        }
    }

    function onRefPhysicianChange(ID) {
        var pID = ID.split("_")[0];
        var ddl = document.getElementById(pID + "_ddlRefPhysician");
        var ddllength = ddl.length;

        for (var i = 0; i < ddllength; i++) {
            if (ddl.options[i].selected) {
                document.getElementById(pID + "_hdnPhysicianValue").value = 'E~' + ddl.options[i].value + '~' + ddl.options[i].text;
                document.getElementById(pID + "_txtNew").value = ddl.options[i].text;
            }

        }

    }



    function onSpecialityChange(ID) {
        var pID = ID.split("_")[0];
        var ddl = document.getElementById(pID + "_ddlSpeciality");
        var ddllength = ddl.length;

        for (var i = 0; i < ddllength; i++) {

            if (ddl.options[i].selected) {

                document.getElementById(pID + "_hdnSpecialityValue").value = ddl.options[i].value;
            }
        }
    }


    function AddPhysician(ID) {

        var pID = ID.split("_")[0];
        var ddlPhy;
        var type;

        if (document.getElementById(pID + "_divPhysicianName").style.display == 'block') {

            ddlPhy = document.getElementById(pID + "_ddlPhysician");
            type = 'I';
        }
        else {
            ddlPhy = document.getElementById(pID + "_ddlRefPhysician");
            type = 'E';
        }

        var ddlPhyLength = ddlPhy.options.length;
        for (var i = 0; i < ddlPhyLength; i++) {
            if (ddlPhy.options[i].selected) {


                if (ddlPhy.options[i].text != '-----Select-----') {
                    document.getElementById(pID + "_txtNew").value = ddlPhy.options[i].text;
                    document.getElementById(pID + "_hdnPhysicianValue").value = type + '~' + ddlPhy.options[i].value + '~' + ddlPhy.options[i].text

                }

            }

        }
        if (document.getElementById(pID + "_txtNew").value == "None" || document.getElementById(pID + "_txtNew").value == "Type Physician Name") {
            document.getElementById(pID + "_hdnPhysicianValue").value = '';
        }
    }

</script>

<table id="qrefphy" runat="server" border="0" cellpadding="0" cellspacing="0" class="defaultfontcolor">
    <tr id="trDetailType" runat="server" style="display: none;">
        <td width="100%">
            <table>
                <tr style="height: 15px;">
                    <td colspan="4" align="left" style="height: 15px;">
                        <table>
                            <tr>
                                <td>
                                    <asp:Label ID="lblReferringType" runat="server" Text="Referring Physician" Font-Bold="True"
                                        meta:resourcekey="lblReferringTypeResource1"></asp:Label>
                                </td>
                                <td>
                                    &nbsp;&nbsp;<asp:Label ID="Rs_PhysicianType" runat="server" Text="Physician Type"
                                        meta:resourcekey="Rs_PhysicianTypeResource1"></asp:Label>
                                </td>
                                <td nowrap="nowrap" valign="top" align="left">
                                    <asp:CheckBox ID="rdoInternal" ToolTip="Internal" Text="Internal" GroupName="rdoIE"
                                        runat="server" onclick="javascript:showInternal(this.id);" meta:resourcekey="rdoInternalResource1" />
                                    <asp:CheckBox ID="rdoExternal" ToolTip="External" Text="External" GroupName="rdoIE"
                                        runat="server" onclick="javascript:showExternal(this.id);" meta:resourcekey="rdoExternalResource1" />
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td align="left" style="height: 15px;">
                        &nbsp;
                    </td>
                    <td align="left" style="height: 15px;">
                        &nbsp;
                    </td>
                </tr>
                <tr id="trDDLPanel" runat="server" style="display: none;">
                    <td valign="top" align="left">
                    </td>
                    <td nowrap="nowrap" valign="top" align="left">
                        &nbsp;&nbsp;&nbsp;<asp:Label ID="Rs_Name" runat="server" Text="Name:" meta:resourcekey="Rs_NameResource1"></asp:Label>
                        <asp:TextBox ID="txtNew" runat="server" ToolTip="Enter Text Here" onkeyup="FilterItems(this.value,this.id)"
                            onblur="AddPhysician(this.id)" Width="120px" meta:resourcekey="txtNewResource1"></asp:TextBox>
                        <ajc:TextBoxWatermarkExtender ID="TBWE2" runat="server" TargetControlID="txtNew"
                            WatermarkText="Type Physician Name" Enabled="True" />
                    </td>
                    <td nowrap="nowrap" valign="top" align="left">
                        <div id="divRefPhysicianName" style="display: none;" runat="server">
                            <asp:DropDownList ID="ddlRefPhysician" ToolTip="Click here to Select Refering Physician"
                                CssClass="ddlTheme12" runat="server" onchange="onRefPhysicianChange(this.id)"
                                meta:resourcekey="ddlRefPhysicianResource1">
                            </asp:DropDownList>
                        </div>
                        <div id="divPhysicianName" style="display: block;" runat="server">
                            <asp:DropDownList ID="ddlPhysician" ToolTip="Click here to Select Physician" CssClass="ddlTheme12"
                                runat="server" onchange="onPhysicianChange(this.id)" meta:resourcekey="ddlPhysicianResource1">
                            </asp:DropDownList>
                        </div>
                    </td>
                    <td valign="top" align="left">
                        <div id="divAddNewPhysician" runat="server" style="display: none">
                            &nbsp;&nbsp; <a onclick="RefsListPopup();" id="lbtnAddNew" style="color: Red; font-weight: bold;
                                text-decoration: underline; cursor: pointer;" runat="server">
                                <asp:Label ID="Rs_AddNew" Text="Add New" runat="server" meta:resourcekey="Rs_AddNewResource1" />
                            </a>
                        </div>
                    </td>
                    <td valign="top" align="left">
                    </td>
                    <td valign="top" align="left">
                        <div id="divSpeciality" runat="server" style="display: none;">
                            <table id="tblspeciality" runat="server" visible="false">
                                <tr>
                                    <td>
                                        <asp:Label ID="Rs_Speciality" runat="server" Text="Speciality:" meta:resourcekey="Rs_SpecialityResource1"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:UpdatePanel ID="pnlSpeciality" runat="server">
                                            <ContentTemplate>
                                                <asp:DropDownList ID="ddlSpeciality" ToolTip="Click here to Select Speciality" CssClass="ddlTheme12"
                                                    runat="server" onchange="onSpecialityChange(this.id)" meta:resourcekey="ddlSpecialityResource1">
                                                </asp:DropDownList>
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr id="trSimpleType" style="display: block;" runat="server">
        <td style="width: 30%; display: block;" id="tdtextboxSearch" runat="server">
            <table>
                <tr>
                    <td>
                        <asp:Label ID="Rs_ClientName" runat="server"  Text="Referring Physician" Font-Bold="True"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtInternalExternalPhysician" runat="server" Width="200px" TabIndex="37"
                            CssClass="biltextb"></asp:TextBox>
                        <ajc:AutoCompleteExtender ID="AutoCompleteExtenderRefPhy" runat="server" TargetControlID="txtInternalExternalPhysician"
                            EnableCaching="false" FirstRowSelected="true" CompletionInterval="1" CompletionSetCount="10"
                            MinimumPrefixLength="1" CompletionListCssClass="listtwo" CompletionListItemCssClass="listitemtwo"
                            CompletionListHighlightedItemCssClass="hoverlistitemtwo" ServiceMethod="GetInternalExternalPhysician"
                            ServicePath="~/WebService.asmx" OnClientItemSelected="IAmPhySelected">
                        </ajc:AutoCompleteExtender>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<asp:HiddenField ID="hdnPhysicianValue" runat="server"></asp:HiddenField>
<asp:HiddenField ID="hdnSpecialityValue" runat="server"></asp:HiddenField>
<asp:HiddenField ID="hdnSelectedPhysician" runat="server"></asp:HiddenField>
<asp:HiddenField ID="PatVistiRefID" Value="0" runat="server" />
<asp:HiddenField ID="hdnReferralType" Value="0" runat="server"></asp:HiddenField>

<script language="javascript" type="text/javascript">

    function RefsListPopup() {
        window.open("../Admin/AddNewRefPhyPopup.aspx?IsPopup=Y", "Ref", "height=500,width=810,scrollbars=Yes");
    }
</script>

<script type="text/javascript" language="javascript">
    function showInternal(ID) {
        document.getElementById('dvH').style.display = "none";
        var pID = ID.split("_")[0];
        FilterItemsReset1(pID);
        if (document.getElementById(ID).checked == true) {
            document.getElementById(pID + "_divPhysicianName").style.display = 'block';
            document.getElementById(pID + "_divRefPhysicianName").style.display = 'none';
            document.getElementById(pID + "_divAddNewPhysician").style.display = 'none';
            document.getElementById(pID + "_txtNew").value = '';
            document.getElementById(pID + "_rdoExternal").checked = false
            document.getElementById(pID + "_trDDLPanel").style.display = "block";
            document.getElementById(pID + "_hdnReferralType").value = 'I';
            CacheItems(pID);

            var ddl = document.getElementById(pID + "_ddlPhysician");
            for (var i = 0; i < ddl.options.length; i++) {

                if (ddl.options[i].value == document.getElementById(pID + "_hdnSelectedPhysician").value) {
                    ddl.options[i].selected = true;

                }
            }
            document.getElementById(pID + "_txtNew").focus();
        } else {
            document.getElementById(pID + "_trDDLPanel").style.display = "none";
            document.getElementById('dvH').style.display = "block";
            document.getElementById('ddlHospital').selectedIndex = 0;
        }

    }

    function showExternal(ID) {

        document.getElementById('dvH').style.display = "block";
        document.getElementById('ddlHospital').selectedIndex = 0;
        var pID = ID.split("_")[0];
        FilterItemsReset2(pID);
        if (document.getElementById(ID).checked == true) {
            document.getElementById(pID + "_divPhysicianName").style.display = 'none';
            document.getElementById(pID + "_divRefPhysicianName").style.display = 'block';
            document.getElementById(pID + "_divAddNewPhysician").style.display = 'block';
            document.getElementById(pID + "_txtNew").value = '';
            document.getElementById(pID + "_rdoInternal").checked = false;
            document.getElementById(pID + "_trDDLPanel").style.display = "block";
            document.getElementById(pID + "_hdnReferralType").value = 'E';
            CacheItems(pID);
            var ddl = document.getElementById(pID + "_ddlRefPhysician");
            for (var i = 0; i < ddl.options.length; i++) {

                if (ddl.options[i].value == document.getElementById(pID + "_hdnSelectedPhysician").value) {
                    ddl.options[i].selected = true;
                }
            }
            document.getElementById(pID + "_txtNew").focus();
        }
        else {
            document.getElementById(pID + "_divAddNewPhysician").style.display = 'none';
            document.getElementById(pID + "_trDDLPanel").style.display = "none";
            document.getElementById('dvH').style.display = "none";
        }


    }
    function ClearReferringPhysician(pID) {
        document.getElementById(pID + "_rdoInternal").checked = false;
        document.getElementById(pID + "_rdoExternal").checked = false;
        document.getElementById(pID + "_trDDLPanel").style.display = "none";
        document.getElementById('dvH').style.display = "none";
        document.getElementById(pID + "_hdnPhysicianValue").value = "";
    }
    function ShowSelectedPhy(ID) {
        var pID = ID.split("_")[0];
        var ddl = document.getElementById(ID);
        for (var i = 0; i < ddl.options.length; i++) {

            if (ddl.options[i].value == document.getElementById(pID + "_hdnSelectedPhysician").value) {
                ddl.options[i].selected = true;

            }
        }

    }
   
    

</script>

<script language="javascript" type="text/javascript">
    function ClearrefPhysicianValue() {
        document.getElementById('<%= hdnPhysicianValue.ClientID %>').value = "";
    }

    //    function GetPhyList(Obj) {
    //        if (Obj != '') {
    //            var StringSplit = Obj.split('~');
    //            WebService.GetInternalExternalPhysician(StringSplit[1], OrgID, OnLookupComplete);
    //        }
    //    }
    function IAmPhySelected(source, eventArgs) {
         // alert(" Key : " + eventArgs.get_text() + "  Value :  " + eventArgs.get_value());

//        //debugger;
        var PhysicianID;
        var PhysicianName;
        var PhysicianType;

        LabPhysicianName = eventArgs.get_text();
        var list = eventArgs.get_value().split('^');
        if (list.length > 0) {
            for (i = 0; i < list.length; i++) {
                if (list[i] != "") {
                    PhysicianID = list[0];
                    PhysicianName = list[1];
                    PhysicianType = list[2];
                }
            }
        }
        document.getElementById("<%= hdnPhysicianValue.ClientID %>").value = PhysicianType + '~' + PhysicianID + '~' + PhysicianName;
        document.getElementById("<%= hdnReferralType.ClientID %>").value = PhysicianType;

    }

   
    
</script>

