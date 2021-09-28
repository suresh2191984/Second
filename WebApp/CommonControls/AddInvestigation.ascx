<%@  Control Language="C#" AutoEventWireup="true" CodeFile="AddInvestigation.ascx.cs" Inherits="CommonControls_AddInvestigation"  %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register TagPrefix="FCKeditorV2" Namespace="FredCK.FCKeditorV2" Assembly="FredCK.FCKeditorV2" %>
<%@ Register Assembly="FreeTextBox" Namespace="FreeTextBoxControls" TagPrefix="FTB" %>

    <link href="../StyleSheets/TabMenu.css" rel="stylesheet" type="text/css" />
    


    <script src="../Scripts/animatedcollapse.js" type="text/javascript"></script>


    <script src="../Scripts/datetimepicker.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">

////        

        function SearchCheck() {
            var AlertType = SListForAppMsg.Get('Investigation_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('Investigation_Header_Alert');
            var vInvestigationName = SListForAppMsg.Get('Investigation_AddInvestigation_aspx_01') == null ? "Enter the InvestigationName" : SListForAppMsg.Get('Investigation_AddInvestigation_aspx_01');
            if (document.getElementById('txtSearch').value == '') {
                //alert("Enter the InvestigationName");
                ValidationWindow(vInvestigationName, AlertType);
                document.getElementById('txtSearch').focus();
                return false;
            }
            return true;
        }


        function txtBoxValidation() {
            var AlertType = SListForAppMsg.Get('Investigation_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('Investigation_Header_Alert');
            var vInvestigationName = SListForAppMsg.Get('Investigation_AddInvestigation_aspx_01') == null ? "Enter the InvestigationName" : SListForAppMsg.Get('Investigation_AddInvestigation_aspx_01');
            var vTCode = SListForAppMsg.Get('Investigation_AddInvestigation_aspx_02') == null ? "Please Enter TCode" : SListForAppMsg.Get('Investigation_AddInvestigation_aspx_02');
            var _temp = 0; var flag = 'Correct';

            if (document.getElementById('TabContainer1_TabAddInvestigation_AI_txtInvestigation').value.trim() == "") {
             //   alert("Enter the InvestigationName");
                ValidationWindow(vInvestigationName, AlertType);
                document.getElementById('TabContainer1_TabAddInvestigation_AI_txtInvestigation').focus();
                return false;
            }

            $('#TabContainer1_TabAddInvestigation_AI_grdInvCodingScheme tbody tr td input:text').each(function() {
                if ($(this)[0].value == '') {
                    flag = 'Wrong';
                }
                else {
                    _temp = 1;
                    return false;
                    
                }

            });
            if (flag == 'Wrong' &&_temp==0) {
              //  alert("Please Enter TCode");
                ValidationWindow(vTCode, AlertType);
                _temp = '';
                return false;
            }
        }



        function DisplayTab(tabName) {
            $('#TabsMenu li').removeClass('active');
            if (tabName == 'SPL') {
                document.getElementById('tdCodingSchemeMaster').style.display = 'table-cell';
                $('#li2').addClass('active');
                document.getElementById('tdAddInvestigations').style.display = 'none';
            }
            if (tabName == 'CLI') {
                document.getElementById('tdCodingSchemeMaster').style.display = 'none';
                $('#li1').addClass('active');
                document.getElementById('tdAddInvestigations').style.display = 'table-cell';
            }
        }


//        function GetIsPrimary(ele) {
//            var AlertType = SListForAppMsg.Get('Investigation_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('Investigation_Header_Alert');
//            var vCodingSchemeName = SListForAppMsg.Get('Investigation_AddInvestigation_aspx_03') == null ? "CodingSchemeName Already Exist" : SListForAppMsg.Get('Investigation_AddInvestigation_aspx_03');
//            var vPrimaryCodingScheme = SListForAppMsg.Get('Investigation_AddInvestigation_aspx_04') == null ? "Primary CodingScheme Already Selected" : SListForAppMsg.Get('Investigation_AddInvestigation_aspx_04');
//            $("#grdCodingScheme tbody tr").each(function() {
//                var tr = $(this).closest("tr");

//                if ($(tr).find("input:hidden[id$=hdnCodeTypeID]").val() != undefined) {

//                    var hdnBtnVal = $("input:hidden[id$=HdnCodingSchemeID]").val();
//                    var CodeSchemeName = $(tr).find("input:hidden[id$=hdnCodeSchemeName]").val();
//                    var Isprimary = $(tr).find("input:hidden[id$=hdnPrimary]").val();

//                    if (hdnBtnVal == '') {
//                        var txtboxvalue = $("input:text[id$=txtCodingSchemeName]").val();
//                        if (txtboxvalue == CodeSchemeName) {
//                         //   alert("CodingSchemeName Already Exist");
//                            ValidationWindow(vCodingSchemeName, AlertType);
//                            return false;
//                        }
//                        if ($("input:checkbox[id$=chkboxIsPrimary]").is(':checked')) {
//                            if ("Y" == Isprimary) {
//                             //   alert("Primary CodingScheme Already Selected");
//                                ValidationWindow(vPrimaryCodingScheme, AlertType);
//                                $(ele).attr('checked', false);
//                                return false;
//                            }
//                        }
//                    }


//                    else {

//                        var hdnCodeid = $(tr).find("input:hidden[id$=hdnCodeTypeID]").val();
//                        if (hdnBtnVal != hdnCodeid) {
//                            var txtval = $("input:text[id$=txtCodingSchemeName]").val();
//                            if (txtval == CodeSchemeName) {
//                              //  alert("CodingSchemeName Already Exist");
//                                ValidationWindow(vCodingSchemeName, AlertType);
//                                return false;
//                            }
//                            if ($("input:checkbox[id$=chkboxIsPrimary]").is(':checked')) {
//                                if ("Y" == Isprimary) {
//                                    $(ele).attr('checked', false);
//                                //    alert("Primary CodingScheme Already Selected");
//                                    ValidationWindow(vPrimaryCodingScheme, AlertType);
//                                    return false;
//                                }
//                            }
//                        }
//                    }
//                }
//            });
//        }


        //            $('#grdCodingScheme tbody tr td span').each(function() {
        //                if (($(this).html()).match('YES')) {
        //                    flag = 'set';
        //                }
        //            });

        //            if (flag != '') {
        //                $(ele).attr('checked', false);
        //                alert('IsPrimary Coding Scheme already Selected!!!!!!!!');
        //                return false;
        //            }




        function pcheckitem() {
            var AlertType = SListForAppMsg.Get('Investigation_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('Investigation_Header_Alert');
            var vCodingScheme = SListForAppMsg.Get('Investigation_AddInvestigation_aspx_05') == null ? "Provide the CodingScheme Name" : SListForAppMsg.Get('Investigation_AddInvestigation_aspx_05')

            if (document.getElementById('txtCodingSchemeName').value == '') {
               // alert('Provide the CodingScheme Name');
                ValidationWindow(vCodingScheme, AlertType);
                document.getElementById('txtCodingSchemeName').focus();
                return false;
            }


        }
    </script>

    <script type="text/javascript">
        function extractRow(rid, CodingSchemeId, CodingSchemeName, Isprimary) {
  
            var len = document.forms[0].elements.length;
            for (var i = 0; i < len; i++) {
                if (document.forms[0].elements[i].type == "radio") {
                    document.forms[0].elements[i].checked = false;
                }
            }
            document.getElementById(rid).checked = true;
            document.getElementById('HdnCodingSchemeID').value = CodingSchemeId;
            document.getElementById('txtCodingSchemeName').value = CodingSchemeName;
            document.getElementById('<%=BtnSaveCodingScheme.ClientID %>').value = "Update";
            document.getElementById('hdnBtnSaveCodingScheme').value = "Update";     
            if (Isprimary == 'Y') {
                document.getElementById('chkboxIsPrimary').checked = true;
            }
            else {
                document.getElementById('chkboxIsPrimary').checked = false;
            }
            return false;
        }

        function CheckCodingSchemeName() {
            var AlertType = SListForAppMsg.Get('Investigation_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('Investigation_Header_Alert');
            var vCodingSchemeName = SListForAppMsg.Get('Investigation_AddInvestigation_aspx_06') == null ? "Sorry CodingSchemeName Already exist" : SListForAppMsg.Get('Investigation_AddInvestigation_aspx_06');
            var vGetCodingSchemeMaster = SListForAppMsg.Get('Investigation_AddInvestigation_aspx_07') == null ? "Error in GetCodingSchemeMaster" : SListForAppMsg.Get('Investigation_AddInvestigation_aspx_07');
            var CodingSchemeName = document.getElementById('<%= txtCodingSchemeName.ClientID %>').value;
            var orgID = document.getElementById('<%= hdnOrgID.ClientID %>').value;
            $.ajax({
                type: "POST",
                url: "../WebService.asmx/GetCodingSchemeMaster",
                data: "{CodingSchemeName: '" + CodingSchemeName + "',OrgID: '" + orgID + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,
                success: function Success(data) {
                    var lstLocation = data.d;
                    if (lstLocation.length > 0) {
                       // alert('Sorry CodingSchemeName Already exist');
                        ValidationWindow(vCodingSchemeName, AlertType);
                        document.getElementById('<%= txtCodingSchemeName.ClientID %>').value = "";
                        document.getElementById('<%= txtCodingSchemeName.ClientID %>').focus();
                    }
                    else {
                        return true;

                    }
                },
                error: function(xhr, ajaxOptions, thrownError) {
                  //  alert('Error in GetCodingSchemeMaster ');
                    ValidationWindow(vGetCodingSchemeMaster, AlertType);
                    return true;
                }
            });
        }

    </script>

    <style type="text/css">
        .floatLeft
        {
            width: 27%;
            float: left;
        }
        .floatRight
        {
            width: 70%;
            float: right;
        }
        .container
        {
            overflow: hidden;
        }
        .style2
        {
            width: 371px;
        }
        .style3
        {
            width: 140px;
        }
        .b-tab
        {
            border-top: 1px solid #959595;
        }
    </style>
    <script type="text/javascript">
        function validatePageNumber() {
            var AlertType = SListForAppMsg.Get('Investigation_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('Investigation_Header_Alert');
            var vPageNotValid = SListForAppMsg.Get('Investigation_AddInvestigation_aspx_08') == null ? "The Page is not valid" : SListForAppMsg.Get('Investigation_AddInvestigation_aspx_08');
            var Totalpage = document.getElementById('<%= hdntotalpage.ClientID %>').value;
            var pageno = document.getElementById('txtpageNo').value;
            if (document.getElementById('txtpageNo').value == "" ||  document.getElementById('txtpageNo').value == 0) {
               // alert("The Page is not valid");
                ValidationWindow(vPageNotValid, AlertType);
                document.getElementById('txtpageNo').value = "";
                return false;
            }
            if (parseInt(pageno) > parseInt(Totalpage)) {
                //alert("The Page is not valid");
                ValidationWindow(vPageNotValid, AlertType);
                document.getElementById('txtpageNo').value = "";
                return false;
            }         
        }
</script>

        <asp:UpdatePanel ID="UpdatePanel" runat="server">
            <ContentTemplate>
                <asp:UpdateProgress ID="UpdateProgress12" AssociatedUpdatePanelID="UpdatePanel" runat="server">
                    <ProgressTemplate>
                        <div id="progressBackgroundFilter" class="a-center">
                        </div>
                        <div id="processMessage" class="a-center w-20p">
                            <asp:Image ID="img1" Width="40px" Height="40px" runat="server" ImageUrl="../Images/loading.GIF"
                                meta:resourcekey="img1Resource1" />
                        </div>
                    </ProgressTemplate>
                </asp:UpdateProgress>
                <table class="w-100p searchPanel">
                   <%-- <tr>
                        <td class="v-top">
                           <%-- <div id='TabsMenu' class="a-left b-tab">
                                <ul>
                                    <li id="li1" class="active" onclick="DisplayTab('CLI')"><a href='#'><span><%=Resources.Investigation_ClientDisplay.Investigation_AddInvestigation_aspx_01%>
                                    </span></a></li>
                                    <li id="li2" onclick="DisplayTab('SPL')"><a href="#"><span><%=Resources.Investigation_ClientDisplay.Investigation_AddInvestigation_aspx_02%> </span></a>
                                    </li>
                                </ul>
                            </div>
                        </td>
                    </tr>--%>
                   <tr>
                        <td class="b-tab">
                            <br />
                        </td>
                    </tr>
                    <tr>
                        <td id="tdCodingSchemeMaster">
                            <div id="divcodeschememaster" style="visibility: hidden">
                                <table class="a-center">
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblCodingSchemeName" runat="server" Text="Coding Scheme Name" meta:resourcekey="lblCodingSchemeNameResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtCodingSchemeName" CssClass="small" runat="server" onblur="CheckCodingSchemeName();return ConverttoUpperCase(this.id);"
                                                meta:resourcekey="txtCodingSchemeNameResource1"></asp:TextBox>
                                        </td>
                                        <td>
                                            <asp:CheckBox ID="chkboxIsPrimary" runat="server" Text="Is Primary" onclick="GetIsPrimary(this);"
                                                meta:resourcekey="chkboxIsPrimaryResource1" />
                                        </td>
                                    </tr>
                                </table>
                                <table class="a-center">
                                    <tr>
                                        <td>
                                            <br />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="a-center" style="visibility: hidden">
                                            <asp:Button ID="BtnSaveCodingScheme" runat="server" CssClass="btn" OnClick="BtnSaveCodingScheme_OnClick"
                                                OnClientClick="javascript:return pcheckitem();" Text="Save" meta:resourcekey="BtnSaveCodingSchemeResource1" />
                                            <asp:HiddenField ID="hdnBtnSave" runat="server" Value="" />
                                        </td>
                                        <td>
                                            <br />
                                        </td>
                                        <td class="a-center">
                                            <asp:Button ID="BtnClearCodingScheme" runat="server" OnClientClick="javascript:return FnClearValues();"
                                                CssClass="btn" Text="Clear" OnClick="BtnClearCodingScheme_OnClick" meta:resourcekey="BtnClearCodingSchemeResource1" />
                                        </td>
                                        <td>
                                            <br />
                                        </td>
                                        <td class="a-center" style="visibility: hidden">
                                            <asp:Button ID="BtnDltCodingScheme" runat="server" CssClass="btn" Text="Delete" OnClick="BtnDltCodingScheme_OnClick"
                                                meta:resourcekey="BtnDltCodingSchemeResource1" />
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div>
                                <table class="w-100p">
                                    <tr>
                                        <td class="w-100p">
                                           <%-- <asp:GridView ID="grdCodingScheme" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                                                CellPadding="1" CellSpacing="1" CssClass="mytable1 gridView w-100p m-auto" ForeColor="#333333"
                                                OnPageIndexChanging="grdCodingScheme_PageIndexChanging" OnRowDataBound="grdCodingScheme_RowDataBound"
                                                PageSize="10" meta:resourcekey="grdCodingSchemeResource1">
                                                <HeaderStyle CssClass="dataheader1" />
                                                <RowStyle Font-Bold="False" HorizontalAlign="Left" />
                                                <Columns>
                                                    <asp:TemplateField HeaderText="Select" Visible="false" meta:resourcekey="TemplateFieldResource1">
                                                        <ItemTemplate>
                                                            <asp:RadioButton ID="rdSel" runat="server" GroupName="OrderSelect" meta:resourcekey="rdSelResource1"
                                                                ToolTip="Select Row" />
                                                            <asp:HiddenField ID="hdnCodeTypeID" runat="server" Value='<%# Eval("CodeTypeID") %>' />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Coding Scheme Name" meta:resourcekey="TemplateFieldResource2">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblCodingSchemeName" runat="server" Text='<%# Eval("CodingSchemaName") %>'
                                                                meta:resourcekey="lblCodingSchemeNameResource2"></asp:Label>
                                                            <asp:HiddenField ID="hdnCodeSchemeName" runat="server" Value='<%# Eval("CodingSchemaName") %>' />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Is Primary" meta:resourcekey="TemplateFieldResource3">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblIsPrimary" runat="server" Text='<%# Eval("IsPrimary").ToString()=="Y"?"YES":"NO" %>'
                                                                meta:resourcekey="lblIsPrimaryResource1"></asp:Label>
                                                            <asp:HiddenField ID="hdnPrimary" runat="server" Value='<%# Eval("IsPrimary") %>' />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                </Columns>
                                                <PagerStyle CssClass="dataheader1" HorizontalAlign="Center" />
                                            </asp:GridView>
--%>                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td id="tdAddInvestigations" class="a-left" style="display: none;">
                            <%--  <div class="container" width="50%">--%>
                            <%--  <div id="divInvestigation" runat="server" class="floatLeft">--%>
                            <table class="w-100p">
                                <%--<tr>
                                                            <td align="left" class="style3">
                                                        <asp:Label ID="lblInv" runat="server" Font-Bold="True" Font-Names="Verdana" Font-Size="9pt"
                                                            meta:resourcekey="lblInvResource1" Text="Add InvestigationName"></asp:Label>
                                                    </td>
                                                        </tr>--%>
                                <tr>
                                    <td class="w-20p">
                                        <asp:Label ID="lblInvestigation" runat="server" Font-Names="Verdana" Font-Size="9pt"
                                            Font-Bold="True" meta:resourcekey="lblInvestigationResource1" Text="Investigation Name"></asp:Label>
                                    </td>
                                    <td class="w-15p">
                                        <asp:TextBox ID="txtInvestigation" runat="server" CssClass="small" meta:resourcekey="txtInvestigationResource1"
                                            Width="123px"></asp:TextBox>
                                        <img src="../Images/starbutton.png" alt="" class="v-middle" />
                                    </td>
                                    <td class="w-65p">
                                        <asp:Button ID="btnGo" runat="server" CssClass="btn w-59" meta:resourcekey="btnGoResource1"
                                            OnClick="btnGo_Click" OnClientClick="return txtBoxValidation();" Style="cursor: pointer;"
                                            Text="Save" ToolTip="ADD THE INVESTIGATION" />
                                    </td>
                                </tr>
                            </table>
                            <%-- </div>--%>
                            <%--<div id="grdinvestigation" runat="server" class="floatRight">--%>
                            <table id="Table1" class="w-75p" runat="server">
                                <tr>
                                    <td>
                                        <asp:GridView ID="grdInvCodingScheme" runat="server" AllowPaging="False" AutoGenerateColumns="False"
                                            CssClass="mytable1 gridView w-100p m-auto" ForeColor="#333333" OnPageIndexChanging="grdInvCodingScheme_PageIndexChanging"
                                            OnRowDataBound="grdInvCodingScheme_OnRowDataBound" meta:resourcekey="grdInvCodingSchemeResource1">
                                            <Columns>
                                                <asp:TemplateField meta:resourcekey="TemplateFieldResource4">
                                                    <HeaderTemplate>
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblCodingSchemeNameMaster" runat="server" Text='<%# Eval("CodingSchemaName") %>'
                                                            meta:resourcekey="lblCodingSchemeNameMasterResource1"></asp:Label>
                                                        <asp:Label ID="lblCodingSchemeNameMasterID" runat="server" Style="display: none"
                                                            Text='<%# Eval("CodeTypeID") %>' meta:resourcekey="lblCodingSchemeNameMasterIDResource1"></asp:Label>
                                                        <asp:Label ID="lblCodeMasterID" runat="server" Style="display: none" Text='<%# Eval("CodeMasterID") %>'
                                                            meta:resourcekey="lblCodeMasterIDResource1"></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField meta:resourcekey="TemplateFieldResource5">
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="txtCodingSchemeNameMaster" runat="server" CssClass="small" Text='<%# Eval("CodeName") %>'
                                                            meta:resourcekey="txtCodingSchemeNameMasterResource1"></asp:TextBox>
                                                        <asp:ImageButton ID="starbutton" runat="server" ImageUrl="~/Images/starbutton.png" Enabled="false"
                                                            meta:resourcekey="starbuttonResource1" />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>
                                        </asp:GridView>
                                    </td>
                                </tr>
                            </table>
                            <%-- </div>--%>
                            <%--</div>--%>
                            <table class="a-left w-100p">
                                <tr>
                                    <td class="w-19p">
                                        <asp:Label ID="LBLsea" runat="server" Font-Bold="True" Font-Names="Verdana" Font-Size="9pt"
                                            meta:resourcekey="LBLseaResource1" Text="Search InvestigationName"></asp:Label>
                                    </td>
                                    <%--<td align="left">
                                                            <asp:Label ID="lblSearch" runat="server" Font-Bold="True" meta:resourcekey="lblSearchResource1"
                                                                Text="InvestigationName"></asp:Label>
                                                    </td>--%>
                                    <td class="w-16p">
                                        <asp:TextBox ID="txtSearch" runat="server" CssClass="small" meta:resourcekey="txtSearchResource1"
                                            Style="margin-left: 2px;"></asp:TextBox>
                                    </td>
                                    <td class="w-20p">
                                        <asp:Button ID="btnSearch" runat="server" CssClass="btn w-58" meta:resourcekey="btnSearchResource1"
                                            OnClick="btnSearch_Click" Style="cursor: pointer;" Text="Search" ToolTip="SEARCH INVESTIGATIONNAME" />
                                        <%-- <asp:ImageButton ID="imgBtnXL" runat="server" ImageUrl="../Images/ExcelImage.GIF"
                                                            meta:resourcekey="imgBtnXLResource1" OnClick="imgBtnXL_Click" ToolTip="Save As Excel"
                                                            Visible="false" />--%>
                                    </td>
                                    <td class="a-right">
                                        <div id="ExportXL" runat="server">
                                            <asp:Label ID="lblExport" runat="server" Text="Export To Excel" Font-Bold="True"
                                                Font-Names="Verdana" Font-Size="9pt" meta:resourcekey="lblExportResource1"></asp:Label>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            <asp:ImageButton ID="ImageBtnExport" runat="server" Visible="true" ImageUrl="~/Images/ExcelImage.GIF"
                                                meta:resourcekey="imgBtnXLResource1" Style="width: 16px" OnClick="ImageBtnExport_Click" />
                                        </div>
                                    </td>
                                </tr>
                            </table>
                            <asp:GridView ID="GridExport" runat="server" CssClass="mytable1 gridView w-100p m-auto"
                                CellPadding="3" meta:resourcekey="GridExportResource1">
                            </asp:GridView>
                            <%--<asp:Label ID="lblStatus" Visible="false" runat="server" ForeColor="#333" Text="No Matching Records Found!"></asp:Label>--%>
                            <table class="w-100p">
                                <tr>
                                    <td>
                                        <asp:GridView ID="grdinv" runat="server" AutoGenerateColumns="False" CssClass="mytable1 gridView w-100p m-auto"
                                            EmptyDataText="No Matching Records Found!" OnPageIndexChanging="grdinv_PageIndexChanging"
                                            OnRowCommand="grdinv_RowCommand" DataKeyNames="InvestigationID,CodeName,InvestigationName"
                                            meta:resourcekey="grdinvResource2">
                                            <Columns>
                                                <asp:BoundField DataField="InvestigationID" HeaderText="InvestigationID" ItemStyle-HorizontalAlign="center"
                                                    meta:resourcekey="BoundFieldResource3">
                                                    <ItemStyle HorizontalAlign="left" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="CodeName" HeaderText="PrimaryCode" ItemStyle-HorizontalAlign="center"
                                                    meta:resourcekey="BoundFieldResource4">
                                                    <ItemStyle HorizontalAlign="left" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="InvestigationName" HeaderText="InvestigationName" ItemStyle-HorizontalAlign="center"
                                                    meta:resourcekey="BoundFieldResource5">
                                                    <ItemStyle HorizontalAlign="left" />
                                                </asp:BoundField>
                                                <asp:TemplateField HeaderText="Action" meta:resourcekey="TemplateFieldResource6">
                                                    <ItemTemplate>
                                                        <table class="mytable1 w-100p">
                                                            <tr>
                                                                <td class="a-center w-50p">
<asp:LinkButton ID="lnkEdit" CssClass="editIcons" runat="server" Text="Edit" CommandName="EditINV"
                                                                        CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>' meta:resourcekey="lnkEditResource1"></asp:LinkButton>
                                                                    
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>
                                            <PagerStyle CssClass="dataheader1" HorizontalAlign="Center" />
                                            <HeaderStyle CssClass="dataheader1" />
                                        </asp:GridView>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="a-left">
                                        <table class="w-80p">
                                            <tr id="GrdFooter" runat="server" style="display: none; background: none" class="dataheaderInvCtrl">
                                                <td class="defaultfontcolor a-center">
                                                    <asp:Label ID="Lblpage" runat="server" Text="Page" meta:resourcekey="LblpageResource1"></asp:Label>
                                                    <asp:Label ID="lblCurrent" runat="server" Font-Bold="True" ForeColor="Red" meta:resourcekey="lblCurrentResource1"></asp:Label>
                                                    <asp:Label ID="Labelof" runat="server" Text="Of" meta:resourcekey="LabelofResource1"></asp:Label>
                                                    <asp:Label ID="lblTotal" runat="server" Font-Bold="True" meta:resourcekey="lblTotalResource1"></asp:Label>
                                                    <asp:Button ID="btnPrevious" runat="server" Text="Previous" CssClass="btn" OnClick="btnPrevious_Click"
                                                        meta:resourcekey="btnPreviousResource1" />
                                                    <asp:Button ID="btnNext" runat="server" Text="Next" CssClass="btn" OnClick="btnNext_Click"
                                                        meta:resourcekey="btnNextResource1" />
                                                    <asp:HiddenField ID="hdnCurrent" runat="server" />
                                                    <asp:Label ID="Labelpagetogo" runat="server" Text="Enter The Page To Go:" meta:resourcekey="LabelpagetogoResource1"></asp:Label>
                                                    <asp:TextBox ID="txtpageNo" runat="server" CssClass="w-30"  onkeypress="return ValidateOnlyNumeric(this);" 
                                                        AutoComplete="off" meta:resourcekey="txtpageNoResource1"></asp:TextBox>
                                                    <asp:Button ID="btnGoes" runat="server" Text="Go" CssClass="btn" OnClick="btnGoes_Click"
                                                        OnClientClick="javascript:return validatePageNumber();" meta:resourcekey="btnGoesResource1" />
                                                    <asp:HiddenField ID="hdnTrustedlist" runat="server" Value="0" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
                <input type="hidden" id="hdnInvestigationID" runat="server" />
                <asp:HiddenField ID="HdnCodingSchemeID" runat="server" />
                <asp:HiddenField ID="hdnBtnSaveCodingScheme" runat="server" />
                <asp:HiddenField ID="hdntotalpage" runat="server" />
                <asp:HiddenField ID="hdnMessages" runat="server" />
            </ContentTemplate>
            <Triggers>
                <asp:PostBackTrigger ControlID="ImageBtnExport" />
            </Triggers>
        </asp:UpdatePanel>
        <asp:HiddenField ID="hdnOrgID" runat="server" />
   

