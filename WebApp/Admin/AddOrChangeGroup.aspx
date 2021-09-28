<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AddOrChangeGroup.aspx.cs"
    Inherits="Admin_AddOrChangeGroup" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Meta Master</title>
    <link href="../Images/favicon.ico" rel="shortcut icon" />

    <script type="text/javascript" language="javascript">

        function RestrictChar(id) {

            var exp = String.fromCharCode(window.event.keyCode)
            var r = new RegExp("[0-9a-zA-Z \r]", "g");
            if (exp.match(r) == null) {
                window.event.keyCode = 0
                return false;
            }
        }


        function checkbox() {
            document.getElementById('chkActive').checked = true;
            document.getElementById('chkvalueActive').checked = true;
        }

        function checksearch() {
            var objMetaName = SListForAppMsg.Get("Admin_AddOrChangeGroup_aspx_01") == null ? "Enter Meta Type Name" : SListForAppMsg.Get("Admin_AddOrChangeGroup_aspx_01");
            var objAlert = SListForAppMsg.Get("Admin_AddOrChangeGroup_aspx_Alert") == null ? "Alert" : SListForAppMsg.Get("Admin_AddOrChangeGroup_aspx_Alert");

            if (document.getElementById('txtgvName').value == "") {
                //alert('Enter Meta Type Name');
                ValidationWindow(objMetaName, objAlert);

                document.getElementById('txtgvName').focus();
                return false;

            }
            return true;
        }


        function checkgrpvalue() {

            var objMetaName = SListForAppMsg.Get("Admin_AddOrChangeGroup_aspx_01") == null ? "Enter Meta Type Name" : SListForAppMsg.Get("Admin_AddOrChangeGroup_aspx_01");
            var objVar2 = SListForAppMsg.Get("Admin_AddOrChangeGroup_aspx_02") == null ? "Enter Meta Value" : SListForAppMsg.Get("Admin_AddOrChangeGroup_aspx_02");
            var objVar3 = SListForAppMsg.Get("Admin_AddOrChangeGroup_aspx_03") == null ? "Enter Value Code" : SListForAppMsg.Get("Admin_AddOrChangeGroup_aspx_03");
            var objVar4 = SListForAppMsg.Get("Admin_AddOrChangeGroup_aspx_04") == null ? "Enter Value Description" : SListForAppMsg.Get("Admin_AddOrChangeGroup_aspx_04");
            var objAlert = SListForAppMsg.Get("Admin_AddOrChangeGroup_aspx_Alert") == null ? "Alert" : SListForAppMsg.Get("Admin_AddOrChangeGroup_aspx_Alert");

            if (document.getElementById('txtgvName').value == "") {
                //alert('Enter Meta Type Name');
                ValidationWindow(objMetaName, objAlert);

                document.getElementById('txtgvName').focus();
                return false;

            }

            else if (document.getElementById('txtgroupvalue').value == "") {
            //alert('Enter Meta Value');
            ValidationWindow(objVar2, objAlert);

                document.getElementById('txtgroupvalue').focus();
                return false;

            }
            else if (document.getElementById('txtgvcode').value == "") {
            //alert('Enter Value Code');
            ValidationWindow(objVar3, objAlert);

                document.getElementById('txtgvcode').focus();
                return false;

            }

            else if (document.getElementById('txtgvdescrip').value == "") {
            //alert('Enter Value Description');
            ValidationWindow(objVar4, objAlert);

                document.getElementById('txtgvdescrip').focus();
                return false;

            }

            return true;



        }


        function checkgrporg() {
            var objVar5 = SListForAppMsg.Get("Admin_AddOrChangeGroup_aspx_05") == null ? "Select Meta Type" : SListForAppMsg.Get("Admin_AddOrChangeGroup_aspx_05");
            var objVar6 = SListForAppMsg.Get("Admin_AddOrChangeGroup_aspx_06") == null ? "Enter Identifying Type" : SListForAppMsg.Get("Admin_AddOrChangeGroup_aspx_06");
            var objVar7 = SListForAppMsg.Get("Admin_AddOrChangeGroup_aspx_07") == null ? "Enter Identifying Value" : SListForAppMsg.Get("Admin_AddOrChangeGroup_aspx_07");
            var objVar2 = SListForAppMsg.Get("Admin_AddOrChangeGroup_aspx_02") == null ? "Enter Meta Value" : SListForAppMsg.Get("Admin_AddOrChangeGroup_aspx_02");
            if (document.getElementById('drpGroupType').options[document.getElementById('drpGroupType').selectedIndex].innerHTML == 'Select') {
                // alert('Select Meta Type');
                ValidationWindow(objVar5, objAlert);
                return false;
            }

            else if (document.getElementById('txtorggroupvalue').value == "") {
            //alert('Enter Meta Value');
            ValidationWindow(objVar2, objAlert);
                document.getElementById('txtorggroupvalue').focus();
                return false;

            }

            else if (document.getElementById('txtorgidtype').value == "") {
            //alert('Enter Identifying Type');
            ValidationWindow(objVar6, objAlert);
                document.getElementById('txtorgidtype').focus();
                return false;

            }
            else if (document.getElementById('txtorgidvalue').value == "") {
            // alert('Enter Identifying Value');
            ValidationWindow(objVar7, objAlert);
                document.getElementById('txtorgidvalue').focus();
                return false;

            }


            return true;



        }

        function checkgrp() {
            var objAlert = SListForAppMsg.Get("Admin_AddOrChangeGroup_aspx_Alert") == null ? "Alert" : SListForAppMsg.Get("Admin_AddOrChangeGroup_aspx_Alert");
            var objMetaName = SListForAppMsg.Get("Admin_AddOrChangeGroup_aspx_01") == null ? "Enter Meta Type Name" : SListForAppMsg.Get("Admin_AddOrChangeGroup_aspx_01");
            var objVar9 = SListForAppMsg.Get("Admin_AddOrChangeGroup_aspx_09") == null ? "Enter Meta Description" : SListForAppMsg.Get("Admin_AddOrChangeGroup_aspx_09");
            var objVar8 = SListForAppMsg.Get("Admin_AddOrChangeGroup_aspx_08") == null ? "Enter Meta Code" : SListForAppMsg.Get("Admin_AddOrChangeGroup_aspx_08");

            if (document.getElementById('txtcode').value == "") {
                //alert('Enter Meta Code');
                ValidationWindow(objVar8, objAlert);
                document.getElementById('txtcode').focus();
                return false;

            }
            else if (document.getElementById('txtgroup').value == "") {
            //alert('Enter Meta Type Name');
            ValidationWindow(objMetaName, objAlert);
                document.getElementById('txtgroup').focus();
                return false;

            }




            else if (document.getElementById('txtdescrip').value == "") {
            //  alert('Enter Meta Description');
            ValidationWindow(objVar9, objAlert);
                document.getElementById('txtdescrip').focus();
                return false;

            }

            return true;



        }

        function rdocheck() {

            if (document.getElementById('rdogrpmaster').checked == true) {
                document.getElementById('divgroup').style.display = 'block';
                document.getElementById('divgrpvalue').style.display = 'none';
                document.getElementById('divGroupOrgMap').style.display = 'none';
                document.getElementById('divGrid').style.display = 'none';
                document.getElementById('txtgroup').value = '';
                document.getElementById('txtcode').value = '';
                document.getElementById('txtcode').disabled = false;
                document.getElementById('txtdescrip').value = '';
                document.getElementById('btnAdd').value = 'ADD';
                document.getElementById('hdnMetaID').value = '0';
                document.getElementById('chkActive').checked = true;
                document.getElementById('chkSystem').checked = false;




            }
            else if (document.getElementById('rdogrpvaluemaster').checked == true) {
                document.getElementById('divgrpvalue').style.display = 'block';
                document.getElementById('divgroup').style.display = 'none';
                document.getElementById('divGroupOrgMap').style.display = 'none';
                document.getElementById('divGrid').style.display = 'none';
                document.getElementById('txtgvName').value = '';
                document.getElementById('txtgroupvalue').value = '';
                document.getElementById('txtgvcode').value = '';
                document.getElementById('txtgvdescrip').value = '';
                document.getElementById('btnAdd1').value = 'ADD';
                document.getElementById('txtorgidtype').value = '';
                document.getElementById('txtorggroupvalue').value = '';
                document.getElementById('txtorgidvalue').value = '';
                document.getElementById('hdnMetaValueID').value = '0';
                document.getElementById('chkvalueActive').checked = true;
                document.getElementById('txtgvName').disabled = false;

            }
            else if (document.getElementById('rdogrporgmap').checked = true) {
                document.getElementById('divGroupOrgMap').style.display = 'block';
                document.getElementById('divgroup').style.display = 'none';
                document.getElementById('divgrpvalue').style.display = 'none';
                document.getElementById('divGrid').style.display = 'none';
                document.getElementById('txtorgidtype').value = '';
                document.getElementById('txtorggroupvalue').value = '';
                document.getElementById('txtorgidvalue').value = '';
                document.getElementById('btnAdd2').value = 'ADD';
                document.getElementById('hdnMetaValueName').value = '0';
                document.getElementById('hdnMetaValuebyMetaID').value = '0';



            }


        }

        function IAmSelected(source, eventArgs) {

            var varGetVal = eventArgs.get_value();
            //alert(" Key : " + eventArgs.get_text() + "  Value :  " + eventArgs.get_value());
            var ID;


            //            eventArgs.get_value()[0].PatientID;
            var list = eventArgs.get_value().split('^');
            if (list.length > 0) {
                for (i = 0; i < list.length; i++) {
                    if (list[i] != "") {
                        ID = list[0];

                        document.getElementById('hdnMetaID').value = ID;


                    }
                }

                document.getElementById('divgrpvalue').style.display = 'none';
                document.getElementById('divgroup').style.display = 'block';
                document.getElementById('divGroupOrgMap').style.display = 'none';
                document.getElementById('divGrid').style.display = 'none';


            }
        }

        function IAmSelected1(source, eventArgs) {

            var varGetVal = eventArgs.get_value();
            //alert(" Key : " + eventArgs.get_text() + "  Value :  " + eventArgs.get_value());
            var ID;


            //            eventArgs.get_value()[0].PatientID;
            var list = eventArgs.get_value().split('^');
            if (list.length > 0) {
                for (i = 0; i < list.length; i++) {
                    if (list[i] != "") {
                        ID = list[0];

                        document.getElementById('hdnMetaValueID').value = ID;


                    }
                    document.getElementById('divgrpvalue').style.display = 'block';
                    document.getElementById('divgroup').style.display = 'none';
                    document.getElementById('divGroupOrgMap').style.display = 'none';
                    document.getElementById('divGrid').style.display = 'none';
                }


            }
        }


        function IAmSelected2(source, eventArgs) {

            var varGetVal = eventArgs.get_text();
            var Name;
            var list = eventArgs.get_text().split('^');
            if (list.length > 0) {
                for (i = 0; i < list.length; i++) {
                    if (list[i] != "") {
                        Name = list[0];

                        document.getElementById('hdnMetaValueName').value = Name;


                    }
                }
                document.getElementById('divgrpvalue').style.display = 'none';
                document.getElementById('divgroup').style.display = 'none';
                document.getElementById('divGroupOrgMap').style.display = 'block';
                document.getElementById('divGrid').style.display = 'none';


            }
        }

        function IAmSelected3(source, eventArgs) {

            var varGetVal = eventArgs.get_value();
            //alert(" Key : " + eventArgs.get_text() + "  Value :  " + eventArgs.get_value());
            var ID;


            //            eventArgs.get_value()[0].PatientID;
            var list = eventArgs.get_value().split('^');
            if (list.length > 0) {
                for (i = 0; i < list.length; i++) {
                    if (list[i] != "") {
                        ID = list[0];

                        document.getElementById('hdnMetaValuebyMetaID').value = ID;


                    }
                }


            }
        }
        function IAmSelected4(source, eventArgs) {

            var varGetVal = eventArgs.get_value();
            //alert(" Key : " + eventArgs.get_text() + "  Value :  " + eventArgs.get_value());
            var ID;


            //            eventArgs.get_value()[0].PatientID;
            var list = eventArgs.get_value().split('^');
            if (list.length > 0) {
                for (i = 0; i < list.length; i++) {
                    if (list[i] != "") {
                        ID = list[0];

                        document.getElementById('hdnIdentifyingValue').value = ID;


                    }
                }


            }
        }

        function validateSearch() {
            var objVar5 = SListForAppMsg.Get("Admin_AddOrChangeGroup_aspx_05") == null ? "Select Meta Type" : SListForAppMsg.Get("Admin_AddOrChangeGroup_aspx_05");
            var groupname = document.getElementById('txtgroup').value;
            if (groupname == '') {
                //alert('Select Meta Type');
                ValidationWindow(objVar5, objAlert);

                document.getElementById('txtgroup').focus();
                return false;
            }
            return true;
        }
    </script>

</head>
<body>
    <form id="GroupMaster" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
        <Services>
            <asp:ServiceReference Path="~/WebService.asmx" />
        </Services>
    </asp:ScriptManager>
      <Attune:Attuneheader ID="Attuneheader" runat="server" />
                    <div class="contentdata">
                       
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>
                                <asp:UpdateProgress ID="Progressbar" AssociatedUpdatePanelID="UpdatePanel1" runat="server">
                                       <ProgressTemplate>
                                        <div id="progressBackgroundFilter" class="a-center">
                                        </div>
                                        <div id="processMessage" class="a-center w-20p">
                                            <asp:Image ID="img1" Width="40px" Height="40px" runat="server" ImageUrl="../Images/loading.GIF" meta:resourcekey="img1Resource1" />
                                        </div>
                                    </ProgressTemplate>

                                    </asp:UpdateProgress>
                                <asp:UpdatePanel ID="updatePanel2" runat="server">
                                    <ContentTemplate>
                                        <table class="w-100p searchPanel">
                                            <tr>
                                                <td>
                                                    <asp:Panel ID="Panel1" runat="server" GroupingText="Meta Master" 
                                                        CssClass="w-40p" meta:resourcekey="Panel1Resource1">
                                                        <table class="dataheader3 defaultfontcolor w-100p">
                                                            <tr>
                                                                <td style="display: none;">
                                                                    <asp:RadioButton ID="rdogrpmaster" runat="server" Text="Meta Type Master" onclick="rdocheck()"
                                                                        GroupName="GRP" TabIndex="1" meta:resourcekey="rdogrpmasterResource1" />
                                                                </td>
                                                                <td>
                                                                    <asp:RadioButton ID="rdogrpvaluemaster" runat="server" Text="Meta Value Master" onclick="rdocheck()"
                                                                        GroupName="GRP" TabIndex="2" 
                                                                        meta:resourcekey="rdogrpvaluemasterResource1" />
                                                                </td>
                                                                <td style="display: none;">
                                                                    <asp:RadioButton ID="rdogrporgmap" runat="server" Text="Meta Mapping" onclick="rdocheck()"
                                                                        GroupName="GRP" TabIndex="3" meta:resourcekey="rdogrporgmapResource1" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </asp:Panel>
                                                    <br />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <div id="divgroup" runat="server" style="display: none">
                                                        <asp:Panel ID="pnlgroup" runat="server" GroupingText="Meta Type Master" 
                                                            CssClass="w-45p" meta:resourcekey="pnlgroupResource1">
                                                            <div class="a-center">
                                                                <asp:Label ID="lblmsg" runat="server" Style="display: none" 
                                                                    meta:resourcekey="lblmsgResource1"></asp:Label>
                                                                <br />
                                                            </div>
                                                          <table class="dataheader3 defaultfontcolor w-100p">
                                                                <tr>
                                                                    <td class="w-30p">
                                                                        <asp:Label ID="lblgroupname" runat="server" Text="Name" 
                                                                            meta:resourcekey="lblgroupnameResource1"></asp:Label>
                                                                    </td>
                                                                    <td class="w-10p">
                                                                        <asp:TextBox ID="txtgroup" runat="server" TabIndex="4" 
                                                                            meta:resourcekey="txtgroupResource1"></asp:TextBox>
                                                                        <ajc:FilteredTextBoxExtender ID="FilteredTextBoxExtender4" runat="server" TargetControlID="txtgroup"
                                                                            FilterType="Numbers, UppercaseLetters, LowercaseLetters" Enabled="True">
                                                                        </ajc:FilteredTextBoxExtender>
                                                                        <ajc:AutoCompleteExtender ID="AutoCompleteExtender3" runat="server" TargetControlID="txtgroup"
                                                                            EnableCaching="False" MinimumPrefixLength="1" CompletionInterval="0" FirstRowSelected="True"
                                                                            CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                                            CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" ServiceMethod="GetGroupName"
                                                                            OnClientItemSelected="IAmSelected" ServicePath="~/WebService.asmx" UseContextKey="True"
                                                                            DelimiterCharacters="" Enabled="True">
                                                                        </ajc:AutoCompleteExtender>
                                                                    </td>
                                                                    <td>
                                                                        <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn" TabIndex="5"
                                                                            OnClick="btnSearch_Click" OnClientClick="return validateSearch()" 
                                                                            meta:resourcekey="btnSearchResource1" />
                                                                        <asp:Button ID="btnReset1" runat="server" Text="Reset" CssClass="btn" TabIndex="6"
                                                                            OnClick="btnReset1_Click" meta:resourcekey="btnReset1Resource1" />
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <asp:Label ID="lblcode" runat="server" Text="Code" 
                                                                            meta:resourcekey="lblcodeResource1"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox ID="txtcode" runat="server" TabIndex="7" 
                                                                            meta:resourcekey="txtcodeResource1"></asp:TextBox>
                                                                        <ajc:FilteredTextBoxExtender ID="FilteredTextBoxExtender1" runat="server" TargetControlID="txtcode"
                                                                            FilterType="Numbers, UppercaseLetters, LowercaseLetters" Enabled="True">
                                                                        </ajc:FilteredTextBoxExtender>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <asp:Label ID="lbldescrip" runat="server" Text="Description" 
                                                                            meta:resourcekey="lbldescripResource1"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox ID="txtdescrip" runat="server" TabIndex="9" 
                                                                            meta:resourcekey="txtdescripResource1"></asp:TextBox>
                                                                        <ajc:FilteredTextBoxExtender ID="FilteredTextBoxExtender2" runat="server" TargetControlID="txtdescrip"
                                                                            FilterType="Numbers, UppercaseLetters, LowercaseLetters" Enabled="True">
                                                                        </ajc:FilteredTextBoxExtender>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                    </td>
                                                                    <td colspan="2">
                                                                        <asp:CheckBox ID="chkActive" runat="server" Text="IsActive" TextAlign="Left" TabIndex="10"
                                                                            onfocus="checkbox()" meta:resourcekey="chkActiveResource1" />
                                                                        <asp:CheckBox ID="chkSystem" runat="server" Text="System Defined" TextAlign="Left"
                                                                            TabIndex="11" meta:resourcekey="chkSystemResource1" />
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td colspan="3" align="center">
                                                                        <asp:Button ID="btnAdd" runat="server" Text="ADD" TabIndex="12" CssClass="btn" OnClick="btnAdd_Click"
                                                                            OnClientClick="return checkgrp()" meta:resourcekey="btnAddResource1" />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </asp:Panel>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <table class="w-100p">
                                                        <tr>
                                                            <td>
                                                                <div id="divgrpvalue" runat="server" style="display: none">
                                                                    <asp:Panel ID="pnlValue" runat="server" GroupingText="Meta Value Master" 
                                                                        Width="40%" meta:resourcekey="pnlValueResource1">
                                                                        <div>
                                                                            <asp:Label ID="lblmsg1" runat="server" Style="display: none" 
                                                                                meta:resourcekey="lblmsg1Resource1"></asp:Label>
                                                                            <br />
                                                                        </div>
                                                                        <table class="dataheader3 defaultfontcolor w-100p">
                                                                            <tr>
                                                                                <td class="w-25p">
                                                                                    <asp:Label ID="lblgvName" runat="server" Text="Meta Type" ForeColor="Red" 
                                                                                        Font-Bold="True" meta:resourcekey="lblgvNameResource1"></asp:Label>
                                                                                </td>
                                                                                <td class="w-19p">
                                                                                    <asp:TextBox ID="txtgvName" runat="server" TabIndex="13" OnTextChanged="txtgvName_TextChanged"
                                                                                        AutoPostBack="True" meta:resourcekey="txtgvNameResource1"></asp:TextBox>
                                                                                    <img src="../Images/starbutton.png" alt="" class="v-middle" />
                                                                                    <ajc:FilteredTextBoxExtender ID="FilteredTextBoxExtender3" runat="server" TargetControlID="txtgvName"
                                                                                        FilterType="Numbers, UppercaseLetters, LowercaseLetters" Enabled="True">
                                                                                    </ajc:FilteredTextBoxExtender>
                                                                                    <ajc:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" TargetControlID="txtgvName"
                                                                                        EnableCaching="False" MinimumPrefixLength="1" CompletionInterval="0" FirstRowSelected="True"
                                                                                        CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                                                        CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" ServiceMethod="GetGroupName"
                                                                                        OnClientItemSelected="IAmSelected1" ServicePath="~/WebService.asmx" UseContextKey="True"
                                                                                        DelimiterCharacters="" Enabled="True">
                                                                                    </ajc:AutoCompleteExtender>
                                                                                </td>
                                                                                <td class="w-12p">                                                                                    
                                                                                    <asp:Button ID="btngvsearch" runat="server" Text="Search" CssClass="btn" TabIndex="14"
                                                                                        OnClick="btngvsearch_Click" OnClientClick="return checksearch()" 
                                                                                        meta:resourcekey="btngvsearchResource1" />
                                                                                </td>
                                                                                <td class="w-11p">
                                                                                    <asp:Button ID="btnReset" runat="server" Text="Reset" CssClass="btn" TabIndex="15"
                                                                                        OnClick="btnReset_Click" meta:resourcekey="btnResetResource1" />
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td>
                                                                                    <asp:Label ID="lblgroupvalue" runat="server" Text="Name" 
                                                                                        meta:resourcekey="lblgroupvalueResource1"></asp:Label>
                                                                                </td>
                                                                                <td>
                                                                                    <asp:TextBox ID="txtgroupvalue" runat="server"  onkeypress="return ValidateMultiLangCharacter(this);"  
                                                                                        TabIndex="16" meta:resourcekey="txtgroupvalueResource1"></asp:TextBox>
                                                                                        <img src="../Images/starbutton.png" alt="" class="v-middle" />
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td>
                                                                                    <asp:Label ID="lblgvcode" runat="server" Text="Code" 
                                                                                        meta:resourcekey="lblgvcodeResource1"></asp:Label>
                                                                                </td>
                                                                                <td>
                                                                                    <asp:TextBox ID="txtgvcode" runat="server" TabIndex="17" 
                                                                                        meta:resourcekey="txtgvcodeResource1"></asp:TextBox>
                                                                                    <img src="../Images/starbutton.png" alt="" class="v-middle" />
                                                                                    <ajc:FilteredTextBoxExtender ID="FilteredTextBoxExtender6" runat="server" TargetControlID="txtgvcode"
                                                                                        FilterType="Numbers, UppercaseLetters, LowercaseLetters" Enabled="True">
                                                                                    </ajc:FilteredTextBoxExtender>
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td>
                                                                                    <asp:Label ID="lblgvdesc" runat="server" Text="Description" 
                                                                                        meta:resourcekey="lblgvdescResource1"></asp:Label>
                                                                                </td>
                                                                                <td>
                                                                                    <asp:TextBox ID="txtgvdescrip" runat="server"    onkeypress="return ValidateMultiLangCharacter(this);"  
                                                                                        TabIndex="18" meta:resourcekey="txtgvdescripResource1"></asp:TextBox>
                                                                                        <img src="../Images/starbutton.png" alt="" class="v-middle" />
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td>
                                                                                </td>
                                                                                <td>
                                                                                    <asp:CheckBox ID="chkvalueActive" runat="server" Text="IsActive" TextAlign="Left"
                                                                                        onfocus="checkbox()" TabIndex="19" 
                                                                                        meta:resourcekey="chkvalueActiveResource1" />
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td colspan="3" class="a-center">
                                                                                    <asp:Button ID="btnAdd1" runat="server" Text="ADD" TabIndex="20" CssClass="btn" OnClick="btnAdd1_Click"
                                                                                        OnClientClick="return checkgrpvalue()" 
                                                                                        meta:resourcekey="btnAdd1Resource1" />
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                        <asp:HiddenField ID="hdnValueID" runat="server" />
                                                                    </asp:Panel>
                                                                </div>
                                                                <div id="divGroupOrgMap" runat="server" style="display: none">
                                                                    <asp:Panel ID="pnlGroupOrgMap" runat="server" GroupingText="Meta Value Mapping" 
                                                                        CssClass="w-40p" meta:resourcekey="pnlGroupOrgMapResource1">
                                                                        <div align="center">
                                                                            <asp:Label ID="lblmsg2" runat="server" Style="display: none" 
                                                                                meta:resourcekey="lblmsg2Resource1"></asp:Label>
                                                                            <br />
                                                                        </div>
                                                                        <table class="dataheader3 defaultfontcolor w-100p">
                                                                            <tr>
                                                                                <td class="w-35p">
                                                                                    <asp:Label ID="lblgtOrgName" runat="server" Text="Meta Type" 
                                                                                        meta:resourcekey="lblgtOrgNameResource1"></asp:Label>
                                                                                </td>
                                                                                <td>
                                                                                    <asp:DropDownList ID="drpGroupType" runat="server" OnSelectedIndexChanged="drpGroupType_SelectedIndexChanged"
                                                                                        AutoPostBack="True" TabIndex="21" meta:resourcekey="drpGroupTypeResource1">
                                                                                    </asp:DropDownList>
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td>
                                                                                    <asp:Label ID="lblorggroupvalue" runat="server" Text="Meta Value" 
                                                                                        meta:resourcekey="lblorggroupvalueResource1"></asp:Label>
                                                                                </td>
                                                                                <td>
                                                                                    <asp:TextBox ID="txtorggroupvalue" runat="server" TabIndex="22" 
                                                                                        meta:resourcekey="txtorggroupvalueResource1"></asp:TextBox>
                                                                                    <ajc:FilteredTextBoxExtender ID="FilteredTextBoxExtender8" runat="server" TargetControlID="txtorggroupvalue"
                                                                                        FilterType="Numbers, UppercaseLetters, LowercaseLetters" Enabled="True">
                                                                                    </ajc:FilteredTextBoxExtender>
                                                                                    <ajc:AutoCompleteExtender ID="AutoCompleteExtender4" runat="server" TargetControlID="txtorggroupvalue"
                                                                                        EnableCaching="False" MinimumPrefixLength="1" CompletionInterval="0" FirstRowSelected="True"
                                                                                        CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                                                        CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" ServiceMethod="GetGroupValuebyName"
                                                                                        ServicePath="~/WebService.asmx" UseContextKey="True" OnClientItemSelected="IAmSelected3"
                                                                                        DelimiterCharacters="" Enabled="True">
                                                                                    </ajc:AutoCompleteExtender>
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td>
                                                                                    <asp:Label ID="lblidtype" runat="server" Text="Identifying Type" 
                                                                                        meta:resourcekey="lblidtypeResource1"></asp:Label>
                                                                                </td>
                                                                                <td>
                                                                                    <asp:TextBox ID="txtorgidtype" runat="server" OnTextChanged="txtorgidtype_TextChanged"
                                                                                        TabIndex="23" AutoPostBack="True" meta:resourcekey="txtorgidtypeResource1"></asp:TextBox>
                                                                                    <ajc:FilteredTextBoxExtender ID="FilteredTextBoxExtender9" runat="server" TargetControlID="txtorgidtype"
                                                                                        FilterType="Numbers, UppercaseLetters, LowercaseLetters" Enabled="True">
                                                                                    </ajc:FilteredTextBoxExtender>
                                                                                    <ajc:AutoCompleteExtender ID="AutoCompleteExtender2" runat="server" TargetControlID="txtorgidtype"
                                                                                        EnableCaching="False" MinimumPrefixLength="1" CompletionInterval="0" FirstRowSelected="True"
                                                                                        CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                                                        CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" ServiceMethod="GetGroupValueNameandID"
                                                                                        OnClientItemSelected="IAmSelected2" ServicePath="~/WebService.asmx" UseContextKey="True"
                                                                                        DelimiterCharacters="" Enabled="True">
                                                                                    </ajc:AutoCompleteExtender>
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td>
                                                                                    <asp:Label ID="lblorgidvalue" runat="server" Text="Identifying Value" 
                                                                                        meta:resourcekey="lblorgidvalueResource1"></asp:Label>
                                                                                </td>
                                                                                <td>
                                                                                    <asp:TextBox ID="txtorgidvalue" runat="server" TabIndex="24" 
                                                                                        meta:resourcekey="txtorgidvalueResource1"></asp:TextBox>
                                                                                    <ajc:FilteredTextBoxExtender ID="FilteredTextBoxExtender10" runat="server" TargetControlID="txtorgidvalue"
                                                                                        FilterType="Numbers, UppercaseLetters, LowercaseLetters" Enabled="True">
                                                                                    </ajc:FilteredTextBoxExtender>
                                                                                    <ajc:AutoCompleteExtender ID="AutoCompleteExtender5" runat="server" TargetControlID="txtorgidvalue"
                                                                                        EnableCaching="False" MinimumPrefixLength="1" CompletionInterval="0" FirstRowSelected="True"
                                                                                        CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                                                        CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" ServiceMethod="GetIdentifyingValue"
                                                                                        OnClientItemSelected="IAmSelected4" ServicePath="~/WebService.asmx" UseContextKey="True"
                                                                                        DelimiterCharacters="" Enabled="True">
                                                                                    </ajc:AutoCompleteExtender>
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td colspan="2" class="a-center">
                                                                                    <asp:Button ID="btnAdd2" runat="server" Text="ADD" TabIndex="25" CssClass="btn" OnClick="btnAdd2_Click"
                                                                                        OnClientClick="return checkgrporg()" meta:resourcekey="btnAdd2Resource1" />
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </asp:Panel>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                    <table class="w-100p">
                                                        <tr>
                                                            <td>
                                                                <div id="divGrid" runat="server" style="display: block">
                                                                    <asp:GridView ID="grdMetaValue" runat="server" DataKeyNames="MetaTypeId,MetaValueID"
                                                                        OnRowCommand="grdMetaValue_RowCommand" OnRowDataBound="grdMetaValue_RowDataBound"
                                                                        CssClass="mytable1 w-75p gridView" ForeColor="Black" CellPadding="4" AutoGenerateColumns="False"
                                                                        AllowPaging="True" OnPageIndexChanging="grdMetaValue_PageIndexChanging" 
                                                                        meta:resourcekey="grdMetaValueResource1">
                                                                        <Columns>
                                                                            <asp:TemplateField HeaderText="MetaValueID" SortExpression="MetaValueID" 
                                                                                Visible="false" meta:resourcekey="TemplateFieldResource1">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="Label1" runat="server" Visible="False" 
                                                                                        Text='<%# Bind("MetaValueID") %>' meta:resourcekey="Label1Resource1"></asp:Label>
                                                                                </ItemTemplate>
                                                                                <EditItemTemplate>
                                                                                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("MetaValueID") %>' 
                                                                                        meta:resourcekey="TextBox1Resource1"></asp:TextBox>
                                                                                </EditItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="MetaTypeId" SortExpression="MetaTypeId" 
                                                                                Visible="false" meta:resourcekey="TemplateFieldResource2">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("MetaTypeId") %>' 
                                                                                        meta:resourcekey="Label2Resource1"></asp:Label>
                                                                                </ItemTemplate>
                                                                                <EditItemTemplate>
                                                                                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("MetaTypeId") %>' 
                                                                                        meta:resourcekey="TextBox2Resource1"></asp:TextBox>
                                                                                </EditItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="TypeName" SortExpression="TypeName" 
                                                                                meta:resourcekey="TemplateFieldResource3">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="Label3" runat="server" Text='<%# Bind("TypeName") %>' 
                                                                                        meta:resourcekey="Label3Resource1"></asp:Label>
                                                                                </ItemTemplate>
                                                                                <EditItemTemplate>
                                                                                    <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("TypeName") %>' 
                                                                                        meta:resourcekey="TextBox3Resource1"></asp:TextBox>
                                                                                </EditItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Value" SortExpression="Value" 
                                                                                meta:resourcekey="TemplateFieldResource4">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="Label4" runat="server" Text='<%# Bind("Value") %>' 
                                                                                        meta:resourcekey="Label4Resource1"></asp:Label>
                                                                                </ItemTemplate>
                                                                                <EditItemTemplate>
                                                                                    <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("Value") %>' 
                                                                                        meta:resourcekey="TextBox4Resource1"></asp:TextBox>
                                                                                </EditItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Code" meta:resourcekey="TemplateFieldResource5">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="Label5" runat="server" Text='<%# Bind("Code") %>' 
                                                                                        meta:resourcekey="Label5Resource1"></asp:Label>
                                                                                </ItemTemplate>
                                                                                <EditItemTemplate>
                                                                                    <asp:TextBox ID="TextBox5" runat="server" Text='<%# Bind("Code") %>' 
                                                                                        meta:resourcekey="TextBox5Resource1"></asp:TextBox>
                                                                                </EditItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Description" SortExpression="Description" 
                                                                                meta:resourcekey="TemplateFieldResource6">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="Label6" runat="server" Text='<%# Bind("Description") %>' 
                                                                                        meta:resourcekey="Label6Resource1"></asp:Label>
                                                                                </ItemTemplate>
                                                                                <EditItemTemplate>
                                                                                    <asp:TextBox ID="TextBox6" runat="server" Text='<%# Bind("Description") %>' 
                                                                                        meta:resourcekey="TextBox6Resource1"></asp:TextBox>
                                                                                </EditItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="IsActive" SortExpression="IsActive" 
                                                                                meta:resourcekey="TemplateFieldResource7">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="Label7" runat="server" Text='<%# Bind("IsActive") %>' 
                                                                                        meta:resourcekey="Label7Resource1"></asp:Label>
                                                                                </ItemTemplate>
                                                                                <EditItemTemplate>
                                                                                    <asp:TextBox ID="TextBox7" runat="server" Text='<%# Bind("IsActive") %>' 
                                                                                        meta:resourcekey="TextBox7Resource1"></asp:TextBox>
                                                                                </EditItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Action" 
                                                                                meta:resourcekey="TemplateFieldResource8">
                                                                                <ItemTemplate>
                                                                                    <asp:LinkButton ID="btnEdit" CommandName="MetaValueEdit" CommandArgument="<%# ((GridViewRow)Container).RowIndex %>"
                                                                                        runat="server" Text="Edit" ForeColor="Blue" Font-Underline="True" Font-Size="12px"
                                                                                        Font-Bold="True" meta:resourcekey="btnEditResource1" />
                                                                                </ItemTemplate>
                                                                                <HeaderStyle HorizontalAlign="Left" />
                                                                                <ItemStyle HorizontalAlign="Left" Width="10%" />
                                                                            </asp:TemplateField>
                                                                        </Columns>
                                                                        <PagerStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                                                        <HeaderStyle CssClass="colorforcontent" ForeColor="White" />
                                                                        <EmptyDataRowStyle BackColor="LightBlue" ForeColor="Black" />
                                                                    </asp:GridView>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                    </ContentTemplate>
                                    <Triggers>
                                        <asp:AsyncPostBackTrigger ControlID="drpGroupType" EventName="SelectedIndexChanged" />
                                    </Triggers>
                                </asp:UpdatePanel>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
             
        <asp:HiddenField ID="hdnMetaID" runat="server" />
        <asp:HiddenField ID="hdnMetaValueID" runat="server" />
        <asp:HiddenField ID="hdnMetaValueName" runat="server" />
        <asp:HiddenField ID="hdnMetaValuebyMetaID" runat="server" />
        <asp:HiddenField ID="hdnIdentifyingValue" runat="server" />
      <Attune:Attunefooter ID="Attunefooter" runat="server" />
    <asp:HiddenField ID="hdnMessages" runat="server" />
    </form>
</body>
</html>
