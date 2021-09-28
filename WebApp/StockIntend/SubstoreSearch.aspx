<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SubstoreSearch.aspx.cs" Inherits="StockIntend_SubstoreSearch"
    EnableEventValidation="false" meta:resourcekey="PageResource2" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>SubStore Search</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />

    <script src="../scripts/MessageHandler.js" language="javascript" type="text/javascript"></script>--%>
</head>
<body oncontextmenu="return true;">
    <form id="form1" runat="server" >
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
        <div id="divProjection">
            <table class="searchPanel w-100p">
                <tr>
                    <td>
                        <asp:Label ID="lblMsg" runat="server" meta:resourcekey="lblMsgResource2"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>
                                <table class="w-100p">
                                    <tr>
                                        <td id="divcheck" class="v-top">
                                            <asp:CheckBox ID="CheckRaisedTo" Text=" Indents Raised To Other Location" onclick="checkboxSelection(this.id)"
                                                CssClass="hide" runat="server" meta:resourcekey="CheckRaisedToResource1" />
                                            <asp:CheckBox ID="CheckRaisedFrom" Text=" Indents Raised From Other Location" onclick="checkboxSelection(this.id)"
                                                CssClass="hide" runat="server" meta:resourcekey="CheckRaisedFromResource1" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <table class="w-100p">
                                                <tr>
                                                    <td nowrap="nowrap">
                                                        <asp:Label ID="Rs_FromDate" Text="From Date" runat="server" meta:resourcekey="Rs_FromDateResource2"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtFrom" runat="server"  onkeypress="return ValidateSpecialAndNumeric(this);"
                                                            CssClass="datePicker small" meta:resourcekey="txtFromResource2" />
                                                    </td>
                                                    <td class="a-left" nowrap="nowrap">
                                                        <asp:Label ID="Rs_ToDate" Text="To Date" runat="server" meta:resourcekey="Rs_ToDateResource2"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtTo" runat="server"   onkeypress="return ValidateSpecialAndNumeric(this);"
                                                            CssClass="datePicker small" meta:resourcekey="txtToResource2" />
                                                    </td>
                                                    <td class="a-left" nowrap="nowrap">
                                                        <asp:Label ID="Rs_IndentType" Text="Indent Type" runat="server" meta:resourcekey="Rs_IndentTypeResource2"
                                                            Visible="False"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList ID="ddlIndentType" runat="server" CssClass="small hide" meta:resourcekey="ddlIndentTypeResource2">
                                                            <asp:ListItem Value="0" meta:resourcekey="ListItemResource7"></asp:ListItem>
                                                            <asp:ListItem Value="1" meta:resourcekey="ListItemResource8"></asp:ListItem>
                                                        </asp:DropDownList>
                                                        &nbsp;<img src="../PlatForm/Images/starbutton.png" alt="" class="a-center hide" />
                                                    </td>
                                                </tr>
                                                <tr id="trTrusted" runat="server">
                                                    <td id="Td1" nowrap="nowrap" runat="server">
                                                        <asp:Label ID="lblStatus" Text="Status" runat="server" meta:resourcekey="lblStatusResource2"></asp:Label>
                                                    </td>
                                                    <td id="Td2" runat="server">
                                                        <asp:DropDownList ID="ddlStatus" runat="server" CssClass="small" meta:resourcekey="ddlStatusResource2">
                                                            <asp:ListItem Value="3" meta:resourcekey="ListItemResource12"></asp:ListItem>
                                                            <asp:ListItem Value="4" meta:resourcekey="ListItemResource13"></asp:ListItem>
                                                            <asp:ListItem Value="5" meta:resourcekey="ListItemResource3"></asp:ListItem>
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td id="Td3" class="a-left" nowrap="nowrap" runat="server">
                                                        <asp:Label ID="Rs_IndentNo" Text="Return No" runat="server" meta:resourcekey="Rs_IndentNoResource2"></asp:Label>
                                                    </td>
                                                    <td id="Td4" runat="server">
                                                        <asp:TextBox ID="txtIntendNo" onkeypress="return ValidateMultiLangChar(this);" runat="server"
                                                            CssClass="small" meta:resourcekey="txtIntendNoResource2"></asp:TextBox>
                                                    </td>
                                                    <td id="Td5" nowrap="nowrap" runat="server">
                                                        <asp:Label ID="lblSelectOrg" runat="server" Text="Select Org" Visible="False" meta:resourcekey="lblSelectOrgResource2"></asp:Label>
                                                    </td>
                                                    <td id="Td6" runat="server">
                                                        <asp:DropDownList ID="ddlTrustedOrg" AutoPostBack="True" TabIndex="1" runat="server"
                                                            CssClass="small" OnSelectedIndexChanged="ddlTrustedOrg_SelectedIndexChanged1"
                                                            meta:resourcekey="ddlTrustedOrgResource1" Visible="False">
                                                        </asp:DropDownList>
                                                        &nbsp;<img src="../PlatForm/Images/starbutton.png" alt="" class="a-center hide"  />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="left" nowrap="nowrap">
                                                        <asp:Label ID="lblLocation" Text="Location" runat="server" meta:resourcekey="lblLocationResource2"
                                                            Visible="False"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList ID="ddlLocation" runat="server" CssClass="small" meta:resourcekey="ddlLocationResource2"
                                                            Visible="False">
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </td>
                </tr>
                <tr>
                    <td colspan="5" class="a-center">
                        <asp:Button ID="btnSearch" ToolTip="Search" runat="server" Text="Search" CssClass="btn"
                            OnClientClick="javascript:return CheckDates('');" OnClick="btnSearch_Click"
                            meta:resourcekey="btnSearchResource2" />
                    </td>
                </tr>
            </table>
            <table id="tblGrid" class="w-100p">
                <tr>
                    <td>
                        <div id="divgvIntend" runat="server">
                            <%--<asp:UpdatePanel ID="Up2" runat="server">
                                            <ContentTemplate>--%>
                            <asp:GridView ID="gvIntend" EmptyDataText="No matching records found " runat="server"
                                AutoGenerateColumns="False" CssClass="gridView w-100p a-center" OnRowDataBound="gvIntend_RowDataBound"
                                AllowPaging="True" PageSize="20" OnPageIndexChanging="gvIntend_PageIndexChanging"
                                meta:resourcekey="gvIntendResource2">
                                <Columns>
                                    <asp:TemplateField HeaderText="Select" ItemStyle-HorizontalAlign="Left" meta:resourcekey="TemplateFieldResource2">
                                        <ItemTemplate>
                                            <asp:RadioButton ID="rdSel" GroupName="SelectRow" ToolTip="Select Row" runat="server"
                                                meta:resourcekey="rdSelResource2" />
                                            <asp:HiddenField ID="hdnIntendID" Value='<%# Eval("IntendID") %>' runat="server" />
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="IntendNo" HeaderText="Return No" ItemStyle-HorizontalAlign="Left"
                                        meta:resourcekey="BoundFieldResource8">
                                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                    </asp:BoundField>
                                    <%--<asp:BoundField DataField="IntendDate" DataFormatString="{0:d}" ItemStyle-HorizontalAlign="Left"
                                        HeaderText="Return Date" meta:resourcekey="BoundFieldResource9">
                                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                    </asp:BoundField>--%>
                                    <asp:TemplateField HeaderText="Return Date" meta:resourcekey="BoundFieldResource9">
                                        <ItemTemplate>
                                            <span>
                                                <%#((DateTime)DataBinder.Eval(Container.DataItem, "IntendDate")).ToString(DateTimeFormat)%></span>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <%--<asp:BoundField DataField="IntendIssuedDate" DataFormatString="{0:d}"
                                                        HeaderText="Indent Issued Date" meta:resourcekey="BoundFieldResource10">
                                                    </asp:BoundField>--%>
                                    <asp:BoundField DataField="Status" HeaderText="Status" ItemStyle-HorizontalAlign="Left"
                                        meta:resourcekey="BoundFieldResource11">
                                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="LocName" HeaderText="Location" ItemStyle-HorizontalAlign="Left"
                                        meta:resourcekey="BoundFieldResource12">
                                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="LocationID" HeaderText="Raise Location" ItemStyle-HorizontalAlign="Left"
                                        Visible="false" meta:resourcekey="BoundFieldResource13">
                                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="ToLocationID" HeaderText="Issued Location" ItemStyle-HorizontalAlign="Left"
                                        Visible="false" meta:resourcekey="BoundFieldResource14">
                                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="IndentReceivedNo" HeaderText="IndentReceived No" ItemStyle-HorizontalAlign="Left"
                                        meta:resourcekey="BoundFieldResource2">
                                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="StockType" HeaderText="Org Type" ItemStyle-HorizontalAlign="Left"
                                        meta:resourcekey="BoundFieldResource3">
                                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:BoundField Visible="false" DataField="TaskId" HeaderText="TaskId" ItemStyle-HorizontalAlign="Left"
                                        meta:resourcekey="BoundFieldResource4">
                                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                    </asp:BoundField>
                                </Columns>
                                <PagerStyle CssClass="gridPager" HorizontalAlign="Center" />
                                <HeaderStyle CssClass="gridHeader" />
                            </asp:GridView>
                            <asp:GridView ID="gvStockTansfer" EmptyDataText="No matching records found " runat="server"
                                AutoGenerateColumns="False" CssClass="gridView w-100p a-center" OnRowDataBound="gvtranfer_RowDataBound"
                                AllowPaging="True" PageSize="20" OnPageIndexChanging="gvtranfer_PageIndexChanging"
                                meta:resourcekey="gvIntendResource2">
                                <Columns>
                                    <asp:TemplateField HeaderText="Select" ItemStyle-HorizontalAlign="Left" meta:resourcekey="TemplateFieldResource2">
                                        <ItemTemplate>
                                            <asp:RadioButton ID="rdSel" GroupName="SelectRow" ToolTip="Select Row" runat="server"
                                                meta:resourcekey="rdSelResource2" />
                                            <asp:HiddenField ID="hdnIntendID" Value='<%# Eval("IntendID") %>' runat="server" />
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="IntendNo" HeaderText="Return No" ItemStyle-HorizontalAlign="Left"
                                        meta:resourcekey="BoundFieldResource5">
                                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                    </asp:BoundField>
                                    <%--<asp:BoundField DataField="IntendDate" DataFormatString="{0:d}" ItemStyle-HorizontalAlign="Left"
                                        HeaderText="Return Date" meta:resourcekey="BoundFieldResource6">
                                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                    </asp:BoundField>--%>
                                    <asp:TemplateField HeaderText="Return Date" meta:resourcekey="BoundFieldResource6">
                                        <ItemTemplate>
                                            <span>
                                                <%#((DateTime)DataBinder.Eval(Container.DataItem, "IntendDate")).ToString(DateTimeFormat)%></span>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <%--<asp:BoundField DataField="IntendIssuedDate" DataFormatString="{0:d}"
                                                        HeaderText="Indent Issued Date" meta:resourcekey="BoundFieldResource10">
                                                    </asp:BoundField>--%>
                                    <asp:BoundField DataField="Status" HeaderText="Status" ItemStyle-HorizontalAlign="Left"
                                        meta:resourcekey="BoundFieldResource11">
                                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="LocName" HeaderText="Location" ItemStyle-HorizontalAlign="Left"
                                        meta:resourcekey="BoundFieldResource12">
                                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="LocationID" HeaderText="Raise Location" ItemStyle-HorizontalAlign="Left"
                                        Visible="false" meta:resourcekey="BoundFieldResource13">
                                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="ToLocationID" HeaderText="Issued Location" ItemStyle-HorizontalAlign="Left"
                                        Visible="false" meta:resourcekey="BoundFieldResource14">
                                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="IndentReceivedNo" HeaderText="StockIssue Received No"
                                        ItemStyle-HorizontalAlign="Left" meta:resourcekey="BoundFieldResource7">
                                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="StockType" HeaderText="Org Type" ItemStyle-HorizontalAlign="Left"
                                        meta:resourcekey="BoundFieldResource10">
                                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                    </asp:BoundField>
                                    <%--   <asp:BoundField DataField="IntendReceivedDetailID" HeaderText="Location" Visible="false" ></asp:BoundField>
                                                  --%>
                                </Columns>
                                <PagerStyle CssClass="gridPager" HorizontalAlign="Center" />
                                <HeaderStyle CssClass="gridHeader" />
                            </asp:GridView>
                            <%--</ContentTemplate>
                                        </asp:UpdatePanel>  --%>
                        </div>
                    </td>
                </tr>
            </table>
        </div>
        <div id="divAction" runat="server" class="hide">
            <table class="w-100p">
                <tr id="trGo">
                    <td class="a-center">
                        <asp:Label ID="Rs_Info" Text="Select a Record and perform one of the following" runat="server"
                            meta:resourcekey="Rs_InfoResource1"></asp:Label>
                        <asp:DropDownList ID="ddlAction" runat="server" CssClass="small hide" onchange="fnGetAction()"
                            meta:resourcekey="ddlActionResource2">
                        </asp:DropDownList>
                        &nbsp;
                        <asp:Button ID="btnGO" runat="server" OnClientClick="javascript:return intendValidation();"
                            CssClass="btn" Text="GO" OnClick="btnGO_Click"
                            meta:resourcekey="btnGOResource2" />
                    </td>
                </tr>
                <tr id="trMsg" class="hide">
                    <td colspan="2" class="a-center">
                        <asp:Label ID="lblNtAcessRcrd" runat="server" Text="you don't have access the record"
                            meta:resourcekey="lblNtAcessRcrdResource2"></asp:Label>
                    </td>
                </tr>
            </table>
        </div>
        <input type="hidden" id="hdnId" runat="server" />
        <input type="hidden" id="hdnStatus" runat="server" />
        <input type="hidden" id="hdnCS" runat="server" />
        <input type="hidden" id="hdnLocationID" runat="server" />
        <input type="hidden" id="hdnIntendReceivedID" runat="server" />
        <input type="hidden" id="hdnIntendReceivedDetailID" runat="server" />
        <input type="hidden" id="hdnCurrentlocation" runat="server" />
        <input type="hidden" id="hdnTolocationID" runat="server" />
        <input type="hidden" id="hdnIndentType" runat="server" />
        <input type="hidden" id="hdnReceivedOrgID" runat="server" />
        <input type="hidden" id="hdnlocation" runat="server" />
        <input type="hidden" id="hdnSelectOrgid" runat="server" />
        <input type="hidden" id="hdnFromLocationID" runat="server" />
        <input type="hidden" id="hdnorgid" runat="server" />
        <input type="hidden" id="hdnInventoryLocationID" runat="server" />
        <input type="hidden" id="hdnIsSubStoreReturn" runat="server" value="N" />
        <input type="hidden" id="hdnIsIndentType" runat="server" value="0" />
        <input type="hidden" id="hdnTaskId" runat="server" value="0" />
    </div>
    <asp:HiddenField ID="hdnMessages" runat="server" />
    <asp:HiddenField ID="hdnDDLActionText" runat="server" />
    <asp:HiddenField ID="hdnDDLActionValue" runat="server" />
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    </form>

    <script language="javascript" type="text/javascript">
        var errorMsg = SListForAppMsg.Get('StockIntend_Error') == null ? "Alert" : SListForAppMsg.Get('StockIntend_Error');
        var informMsg = SListForAppMsg.Get('StockIntend_Information') == null ? "Information" : SListForAppMsg.Get('StockIntend_Information');
        var okMsg = SListForAppMsg.Get('StockIntend_Ok') == null ? "Ok" : SListForAppMsg.Get('StockIntend_Ok')
        var cancelMsg = SListForAppMsg.Get('StockIntend_Cancel') == null ? "Cancel" : SListForAppMsg.Get('StockIntend_Cancel');
        var userMsg;
        function GetLocationlist() {


            var drpOrgid = document.getElementById('ddlTrustedOrg').options[document.getElementById('ddlTrustedOrg').selectedIndex].value;

            document.getElementById('hdnSelectOrgid').value = drpOrgid;
            //            var options = document.getElementById('hdnlocation').value;
            //            var ddlLocation = document.getElementById('ddlLocation');
            //            //var ddlUser = document.getElementById('ddlUser');
            //          //  var userList = document.getElementById('hdnUserlist').value;

            //            //ddlUser.options.length = 0;
            //            ddlLocation.options.length = 0;
            ////            var optn1 = document.createElement("option");
            ////            ddlUser.options.add(optn1);
            ////            optn1.text = "-----Select-----";
            ////            optn1.value = "0";

            //            var list = options.split('^');
            //            for (i = 0; i < list.length; i++) {
            //                if (list[i] != "") {
            //                    var res = list[i].split('~');



            //                    if (drpOrgid == res[0]) {
            //                        var optn = document.createElement("option");
            //                        ddlLocation.options.add(optn);
            //                        optn.text = res[2];
            //                        optn.value = res[1];
            //                    }

            //                }
            //            }
        }
        //



        //        function locationdetails() {
        //            var Trustedorgid = document.getElementById('ddlTrustedOrg').options[document.getElementById('ddlTrustedOrg').selectedIndex].value;
        //            if (Trustedorgid > 0) {

        //               document.getElementById('hdnSelectOrgid').value = Trustedorgid;
        //            }
        //           
        //            var Fromlocationid = document.getElementById('ddlLocation').options[document.getElementById('ddlLocation').selectedIndex].value;

        //            if (Fromlocationid > 0) {

        //                document.getElementById('hdnFromLocationID').value = Fromlocationid;
        //            }

        //        }


        function checkboxSelection(ID) {

            if ((document.getElementById('hdnCS').value == 'CS-POS') || (document.getElementById('hdnCS').value == 'CS')) {
                document.getElementById('CheckRaisedFrom').checked = true;
                if (ID == "CheckRaisedFrom") {
                    document.getElementById('CheckRaisedFrom').checked = true;
                    document.getElementById('CheckRaisedTo').checked = false;




                } else {
                    document.getElementById('CheckRaisedFrom').checked = false;
                    document.getElementById('CheckRaisedTo').checked = true;


                }
            }

        }




        //old =======================================================================



        function RaisedCheckBox() {


            if ((document.getElementById('hdnCS').value == 'CS-POS') || (document.getElementById('hdnCS').value == 'CS')) {

                document.getElementById('CheckRaisedFrom').visible = true;
                document.getElementById('CheckRaisedTo').visible = true;
                //document.getElementById('CheckRaisedTo').checked = true;

                if (document.getElementById('CheckRaisedFrom').checked == true) {

                    //document.getElementById('lblLocation').style.display = 'none';
                    //document.getElementById('ddlLocation').style.display = 'none';
                    //document.getElementById('lblRaiseLocation').style.display = 'none';
                    //document.getElementById('ddlRaiselocation').style.display = 'none';
                    //document.getElementById('lblIssueLocation').style.display = 'block';
                    //document.getElementById('ddlIssuelocation').style.display = 'block';
                    $('#lblLocation').removeClass().addClass('hide');
                    $('#ddlLocation').removeClass().addClass('hide');
                    $('#lblRaiseLocation').removeClass().addClass('hide');
                    $('#ddlRaiselocation').removeClass().addClass('hide');
                    $('#lblIssueLocation').removeClass().addClass('show');
                    $('#ddlIssuelocation').removeClass().addClass('show');

                    //                        document.getElementById('lblLocation').visible = false;
                    //                        document.getElementById('ddlLocation').visible = false;
                    //                        document.getElementById('lblRaiseLocation').visible = false;
                    //                        document.getElementById('ddlRaiselocation').visible = false;
                    //                        document.getElementById('lblIssueLocation').visible = true;
                    //                        document.getElementById('ddlIssuelocation').visible = true;
                    //                        document.getElementById('divLocation').style.display = 'none';
                    //                        document.getElementById('divlblRaiseLocation').style.display = 'none';
                    //                        document.getElementById('divlblIssueLocation').style.display = 'block';



                }
                else if (document.getElementById('CheckRaisedTo').checked == true) {

                    //                        document.getElementById('divLocation').style.display = 'none';
                    //                        document.getElementById('divlblRaiseLocation').style.display = 'block';
                    //                        document.getElementById('divlblIssueLocation').style.display = 'none';


                    //document.getElementById('lblLocation').style.display = 'none';
                    //document.getElementById('ddlLocation').style.display = 'none';
                    //document.getElementById('lblRaiseLocation').style.display = 'block';
                    //document.getElementById('ddlRaiselocation').style.display = 'block';
                    //document.getElementById('lblIssueLocation').style.display = 'none';
                    //document.getElementById('ddlIssuelocation').style.display = 'none';
                    $('#lblLocation').removeClass().addClass('hide');
                    $('#ddlLocation').removeClass().addClass('hide');
                    $('#lblRaiseLocation').removeClass().addClass('show');
                    $('#ddlRaiselocation').removeClass().addClass('show');
                    $('#lblIssueLocation').removeClass().addClass('hide');
                    $('#ddlIssuelocation').removeClass().addClass('hide');


                    //                        document.getElementById('lblLocation').visible = false;
                    //                        document.getElementById('ddlLocation').visible = false;
                    //                        document.getElementById('lblRaiseLocation').visible = true;
                    //                        document.getElementById('ddlRaiselocation').visible = true;
                    //                        document.getElementById('lblIssueLocation').visible = false;
                    //                        document.getElementById('ddlIssuelocation').visible = false;

                }
                else {

                    //                        document.getElementById('lblLocation').visible = false;
                    //                        document.getElementById('ddlLocation').visible = false;
                    //                        document.getElementById('lblRaiseLocation').visible = false;
                    //                        document.getElementById('ddlRaiselocation').visible = false;
                    //                        document.getElementById('lblIssueLocation').visible = false;
                    //                        document.getElementById('ddlIssuelocation').visible = false;


                    //document.getElementById('lblLocation').style.display = 'none';
                    //document.getElementById('ddlLocation').style.display = 'none';
                    //document.getElementById('lblRaiseLocation').style.display = 'none';
                    //document.getElementById('ddlRaiselocation').style.display = 'none';
                    //document.getElementById('lblIssueLocation').style.display = 'none';
                    //document.getElementById('ddlIssuelocation').style.display = 'none';

                    $('#lblLocation').removeClass().addClass('hide');
                    $('#ddlLocation').removeClass().addClass('hide');
                    $('#lblRaiseLocation').removeClass().addClass('hide');
                    $('#ddlRaiselocation').removeClass().addClass('hide');
                    $('#lblIssueLocation').removeClass().addClass('hide');
                    $('#ddlIssuelocation').removeClass().addClass('hide');

                    //                        document.getElementById('divLocation').style.display = 'none';
                    //                        document.getElementById('divlblRaiseLocation').style.display = 'none';
                    //                        document.getElementById('divlblIssueLocation').style.display = 'none';

                }

            }

            else {
                //                    document.getElementById('lblLocation').visible = true;
                //                    document.getElementById('ddlLocation').visible = true;
                //                    document.getElementById('lblRaiseLocation').visible = false;
                //                    document.getElementById('ddlRaiselocation').visible = false;
                //                    document.getElementById('lblIssueLocation').visible = false;
                //                    document.getElementById('ddlIssuelocation').visible = false;

                //document.getElementById('lblLocation').style.display = 'block';
                //document.getElementById('ddlLocation').style.display = 'block';
                //document.getElementById('lblRaiseLocation').style.display = 'none';
                //document.getElementById('ddlRaiselocation').style.display = 'none';
                //document.getElementById('lblIssueLocation').style.display = 'none';
                //document.getElementById('ddlIssuelocation').style.display = 'none';

                $('#lblLocation').removeClass().addClass('show');
                $('#ddlLocation').removeClass().addClass('show');
                $('#lblRaiseLocation').removeClass().addClass('hide');
                $('#ddlRaiselocation').removeClass().addClass('hide');
                $('#lblIssueLocation').removeClass().addClass('hide');
                $('#ddlIssuelocation').removeClass().addClass('hide');


                //document.getElementById('divcheck').style.display = 'none';
                $('#divcheck').removeClass().addClass('hide');

                //document.getElementById('CheckRaisedFrom').style.display = 'none';
                //document.getElementById('CheckRaisedTo').style.display = 'none';
                $('#CheckRaisedFrom').removeClass().addClass('hide');
                $('#CheckRaisedTo').removeClass().addClass('hide');

                document.getElementById('CheckRaisedFrom').visible = false;
                document.getElementById('CheckRaisedTo').visible = false;

            }
        }


        function CheckDates(splitChar) {

            var drpIndentType = $('#ddlIndentType').val();
            $('#hdnIsIndentType').val(drpIndentType);
            //            var drpOrgid = document.getElementById('ddlTrustedOrg').options[document.getElementById('ddlTrustedOrg').selectedIndex].value;

            //            if ((drpOrgid == 0) || (drpOrgid <= 0)) {
            //                userMsg = SListForApplicationMessages.Get('SelectRole.aspx_1');
            //                if (userMsg != null) {
            //                    alert(userMsg);
            //                    return false;
            //                }
            //                else {
            //                    alert("Select Organization");
            //                    return false;
            //                }
            //                return false;


            //            }


            //            if (document.getElementById('CheckRaisedTo').checked == true) {

            //                document.getElementById('CheckRaisedFrom').checked = false;
            //            }
            
            if (document.getElementById('txtFrom').value == '') {

                var userMsg = SListForAppMsg.Get("StockIntend_SubstoreSearch_aspx_01") == null ? "Select From Date" : SListForAppMsg.Get("StockIntend_SubstoreSearch_aspx_01");
                ValidationWindow(userMsg, errorMsg);
                return false;

            }
            else if (document.getElementById('txtTo').value == '') {

                var userMsg = SListForAppMsg.Get("StockIntend_SubstoreSearch_aspx_02") == null ? "Select To Date" : SListForAppMsg.Get("StockIntend_SubstoreSearch_aspx_02");
                ValidationWindow(userMsg, errorMsg);
                return false;

            }
            else {
                //Assign From And To Date from Controls 
                DateFrom = document.getElementById('txtFrom').value;
                DateTo = document.getElementById('txtTo').value;
                
                //Argument Value 0 for validating Current Date And To Date 
                //Argument Value 1 for validating Current From And To Date 
                //if (doDateValidation(DateTo, DateNow, 0)) {
                if (CheckFromToDate(DateFrom, DateTo)) {
                        //alert("Validation Succeeded");



                        //  intendcheckboxvalidation();
                        return true;

                    }
                    else {
                        return false;
                    }
                //}
                //else {
                //    return false;
                //}
            }


            //            var getFromLocation = $('#ddlFromLocation option:selected').val();
            //            var getToLocation = $('#ddlLocation option:selected').val();
            //            if (getFromLocation != '-1' && getToLocation != '-1') {
            //                if (getFromLocation == getToLocation) {
            //                    userMsg = SListForApplicationMessages.Get('Inventory\\Intend.aspx_3');
            //                    if (userMsg != null) {
            //                        alert(userMsg);
            //                        return false;
            //                    }
            //                    else {
            //                        alert('change To locations');
            //                        return false;
            //                    }
            //                }
            //            }
        }


        function doDateValidation(from, to, bit) {
            var dayFlag = true;
            var monthFlag = true;
            var i = from.length - 1;
            if (Number(to[i]) >= Number(from[i])) {
                if (Number(to[i]) == Number(from[i])) {
                    monthFlag = false;
                }
                i--;
                if (Number(to[i]) >= Number(from[i])) {
                    if (Number(to[i]) == Number(from[i])) {
                        dayFlag = false;
                    }
                    i--;
                    if (Number(to[i]) >= Number(from[i])) {
                        i--;
                        return true;
                    }
                    else {
                        if (dayFlag) {
                            return true;
                        }
                        else {
                            if (bit == 0) {

                                var userMsg = SListForAppMsg.Get("StockIntend_SubstoreSearch_aspx_03") == null ? "Invalid Date" : SListForAppMsg.Get("StockIntend_SubstoreSearch_aspx_03");
                                ValidationWindow(userMsg, errorMsg);
                                return false;

                            }
                            else {

                                var userMsg = SListForAppMsg.Get("StockIntend_SubstoreSearch_aspx_03") == null ? "Invalid Date" : SListForAppMsg.Get("StockIntend_SubstoreSearch_aspx_03");
                                ValidationWindow(userMsg, errorMsg);
                                return false;

                            }
                            return false;
                        }
                    }
                }
                else if (monthFlag) {
                    return true;
                }
                else {
                    if (bit == 0) {

                        var userMsg = SListForAppMsg.Get("StockIntend_SubstoreSearch_aspx_03") == null ? "Invalid Date" : SListForAppMsg.Get("StockIntend_SubstoreSearch_aspx_03");
                        ValidationWindow(userMsg, errorMsg);
                        return false;

                    }
                    else {

                        var userMsg = SListForAppMsg.Get("StockIntend_SubstoreSearch_aspx_03") == null ? "Invalid Date" : SListForAppMsg.Get("StockIntend_SubstoreSearch_aspx_03");
                        ValidationWindow(userMsg, errorMsg);
                        return false;

                    }
                    return false;
                }
            }
            else {
                if (bit == 0) {

                    var userMsg = SListForAppMsg.Get("StockIntend_SubstoreSearch_aspx_03") == null ? "Invalid Date" : SListForAppMsg.Get("StockIntend_SubstoreSearch_aspx_03");
                    ValidationWindow(userMsg, errorMsg);
                    return false;

                }
                else {

                    var userMsg = SListForAppMsg.Get("StockIntend_SubstoreSearch_aspx_03") == null ? "Invalid Date" : SListForAppMsg.Get("StockIntend_SubstoreSearch_aspx_03");
                    ValidationWindow(userMsg, errorMsg);
                    return false;

                }
                return false;
            }
        }


        //Uncheckes all the radio inside the grid except one at a time -GridSingleRadioCheck
        function SelectIntendRowCommon(rid, IntId, Intstatus, locationID, IntendReceivedID, IntendReceivedDetailID, ToLocationID, ReceivedOrgID, orgid, TaskId) {

            $('#ddlAction').show();
            $('#ddlAction').empty();
            chosen = "";
            var len = document.forms[0].elements.length;
            for (var i = 0; i < len; i++) {
                if (document.forms[0].elements[i].type == "radio") {
                    document.forms[0].elements[i].checked = false;
                }
            }
            document.getElementById(rid).checked = true;
            document.getElementById('hdnId').value = IntId;
            document.getElementById('hdnStatus').value = Intstatus;
            document.getElementById('hdnLocationID').value = locationID;
            document.getElementById('hdnIntendReceivedID').value = IntendReceivedID;
            document.getElementById('hdnIntendReceivedDetailID').value = IntendReceivedDetailID;
            document.getElementById('hdnTolocationID').value = ToLocationID;
            document.getElementById('hdnReceivedOrgID').value = ReceivedOrgID;
            document.getElementById('hdnorgid').value = orgid;
            document.getElementById('hdnTaskId').value = TaskId;
            //$('#btnSetAction').click();
            fnSetActions();
        }


        function fnSetActions() {

            $.ajax({
                type: "GET",
                url: '../InventoryCommon/setAction.ashx?IsSubStoreReturn=Y&hdnLocationID=' + document.getElementById('hdnLocationID').value + '&hdnTolocationID=' + document.getElementById('hdnTolocationID').value + '&hdnStatus=' + document.getElementById('hdnStatus').value + '&InventoryLocationID=' + document.getElementById('hdnInventoryLocationID').value + '&InventoryIndentType=' + document.getElementById('hdnIsIndentType').value,
                contentType: "application/json; charset=utf-8",
                dataType: "html",
                async: true,
                success: function(data) {
                    if (data != '||') {
                        BindDDLACTION(data);
                    }
                    else {
                        $('#ddlAction').hide();
                    }
                },
                failure: function(msg) {

                    var userMsg = SListForAppMsg.Get("StockIntend_SubstoreSearch_aspx_04") == null ? "error" : SListForAppMsg.Get("StockIntend_SubstoreSearch_aspx_04");
                    ValidationWindow(userMsg, errorMsg);
                    return false;

                }
            });

        }

        function BindDDLACTION(data) {
            $('#ddlAction').empty();
            var getValue = data.split('|');
            var actionValue = getValue[0].split('@');
            var actionUrl = getValue[1].split('@');
            var actionCode = getValue[2].split('@');
            if (actionValue.length > 0) {
                for (var i = 0; i < actionValue.length; i++) {
                    $('#ddlAction').append('<option ac="' + actionCode[i] + '" value="' + actionUrl[i] + '">' + actionValue[i] + '</option>');

                    if (i == 0) {
                        $('#hdnDDLActionText').val(actionValue[i]);
                        $('#hdnDDLActionValue').val(actionUrl[i]);
                    }
                }
            }
        }



        //        function checkDetails() {
        //            if (document.getElementById('ddlStatus').value == '0') {
        //                alert('Select the Indent Status ');
        //                document.getElementById('ddlLocation').focus();
        //                return false;
        //            }
        //            if (document.getElementById('ddlUser').value == '0') {
        //                alert('Select the received by ');
        //                document.getElementById('ddlUser').focus();
        //                return false;
        //            }
        //        }


        function intendcheckboxvalidation() {
            if ((document.getElementById('hdnCS').value == 'CS-POS') || (document.getElementById('hdnCS').value == 'CS')) {
                if ((document.getElementById('CheckRaisedTo').checked != true) && (document.getElementById('CheckRaisedFrom').checked != true)) {

                    var userMsg = SListForAppMsg.Get("StockIntend_SubstoreSearch_aspx_05") == null ? "Select any one indent type" : SListForAppMsg.Get("StockIntend_SubstoreSearch_aspx_05");
                    ValidationWindow(userMsg, errorMsg);
                    return false;

                    //document.getElementById('divgvIntend').style.display = "none";
                    $('#divgvIntend').removeClass().addClass('hide');
                    return false;

                }
                else {
                    return true;
                    //document.getElementById('divgvIntend').style.display = "block";
                    $('#divgvIntend').removeClass().addClass('show');
                }
            }
            else {
                return true;
            }



        }


        function indentValidationForCS() {

            if ((document.getElementById('hdnCS').value == 'CS-POS') || (document.getElementById('hdnCS').value == 'CS')) {

                if ((document.getElementById('CheckRaisedTo').checked == true)) {

                    if (document.getElementById('hdnStatus').value == 'Pending') {


                        if ((document.getElementById('ddlAction').options[document.getElementById('ddlAction').selectedIndex].text == 'View Indent')) {
                            //alert('This Intend is not yet');

                            return true;
                        }
                        else {

                            var userMsg = SListForAppMsg.Get("StockIntend_SubstoreSearch_aspx_06") == null ? "This intend is not suitable" : SListForAppMsg.Get("StockIntend_SubstoreSearch_aspx_06");
                            ValidationWindow(userMsg, errorMsg);
                            return false;

                        }
                    }

                }





            }

            if ((document.getElementById('hdnCS').value == 'CS-POS') || (document.getElementById('hdnCS').value == 'CS')) {



                if ((document.getElementById('CheckRaisedFrom').checked == true)) {

                    if (document.getElementById('hdnStatus').value == 'Pending') {

                        if ((document.getElementById('ddlAction').options[document.getElementById('ddlAction').selectedIndex].text == 'View Indent') || (document.getElementById('ddlAction').options[document.getElementById('ddlAction').selectedIndex].text == 'Issued Stock')) {
                            //alert('This Intend is not yet');

                            return true;
                        }
                        else {

                            var userMsg = SListForAppMsg.Get("StockIntend_SubstoreSearch_aspx_06") == null ? "This intend is not suitable" : SListForAppMsg.Get("StockIntend_SubstoreSearch_aspx_06");
                            ValidationWindow(userMsg, errorMsg);
                            return false;

                        }
                    }



                }
            }


        }


        function intendValidation() {

            if (document.getElementById('hdnId').value == '') {

                var userMsg = SListForAppMsg.Get("StockIntend_SubstoreSearch_aspx_07") == null ? "Select an intend" : SListForAppMsg.Get("StockIntend_SubstoreSearch_aspx_07");
                ValidationWindow(userMsg, errorMsg);
                return false;

            }


            if (document.getElementById('hdnStatus').value == 'Issued') {
                if ((document.getElementById('ddlAction').options[document.getElementById('ddlAction').selectedIndex].getAttribute('ac') == 'View Indent') || (document.getElementById('ddlAction').options[document.getElementById('ddlAction').selectedIndex].getAttribute('ac') == 'Received Indent')) {
                    return true;
                }
                else {

                    var userMsg = SListForAppMsg.Get("StockIntend_SubstoreSearch_aspx_08") == null ? "This indent is not Suitable...." : SListForAppMsg.Get("StockIntend_SubstoreSearch_aspx_08");
                    ValidationWindow(userMsg, errorMsg);
                    return false;

                }
            }
            if (document.getElementById('hdnStatus').value == 'Inprogress') {
                if (document.getElementById('ddlAction').options[document.getElementById('ddlAction').selectedIndex].getAttribute('ac') == 'Issue Indent') {

                    var userMsg = SListForAppMsg.Get("StockIntend_SubstoreSearch_aspx_09") == null ? "This indent is not approved yet" : SListForAppMsg.Get("StockIntend_SubstoreSearch_aspx_09");
                    ValidationWindow(userMsg, errorMsg);
                    return false;

                }
            }

            if ((document.getElementById('hdnCS').value != 'CS-POS') && (document.getElementById('hdnCS').value != 'CS')) {
                if (document.getElementById('hdnStatus').value == 'Received') {
                    if ((document.getElementById('ddlAction').options[document.getElementById('ddlAction').selectedIndex].getAttribute('ac') == 'View Indent') && (document.getElementById('ddlAction').options[document.getElementById('ddlAction').selectedIndex].getAttribute('ac') != 'Issued Stock')) {

                        return true;
                    }
                    else {

                        var userMsg = SListForAppMsg.Get("StockIntend_SubstoreSearch_aspx_08") == null ? "This indent is not Suitable...." : SListForAppMsg.Get("StockIntend_SubstoreSearch_aspx_08");
                        ValidationWindow(userMsg, errorMsg);
                        return false;

                    }
                }
            }

            if ($('#CheckRaisedFrom').length > 0 && document.getElementById('CheckRaisedFrom').checked == true) {

                if (document.getElementById('hdnStatus').value == 'Received') {
                    if ((document.getElementById('ddlAction').options[document.getElementById('ddlAction').selectedIndex].getAttribute('ac') == 'View Indent') && (document.getElementById('ddlAction').options[document.getElementById('ddlAction').selectedIndex].getAttribute('ac') != 'Issued Stock')) {

                        return true;
                    }
                    else {

                        var userMsg = SListForAppMsg.Get("StockIntend_SubstoreSearch_aspx_08") == null ? "This indent is not Suitable...." : SListForAppMsg.Get("StockIntend_SubstoreSearch_aspx_08");
                        ValidationWindow(userMsg, errorMsg);
                        return false;

                    }
                }

            }

            if (document.getElementById('hdnStatus').value == 'Received') {
                if ((document.getElementById('ddlAction').options[document.getElementById('ddlAction').selectedIndex].getAttribute('ac') == 'View SubStoreReturn') && (document.getElementById('ddlAction').options[document.getElementById('ddlAction').selectedIndex].getAttribute('ac') != 'Issued Stock')) {

                    return true;
                }
                else {

                    var userMsg = SListForAppMsg.Get("StockIntend_SubstoreSearch_aspx_08") == null ? "This indent is not Suitable...." : SListForAppMsg.Get("StockIntend_SubstoreSearch_aspx_08");
                    ValidationWindow(userMsg, errorMsg);
                    return false;

                }
            }
        } 
    </script>

    <script language="javascript" type="text/javascript">
        function onCalendarShown2() {

            var cal = $find("calendar2");
            //Setting the default mode to month
            cal._switchMode("months", true);

            //Iterate every month Item and attach click event to it
            if (cal._monthsBody) {
                for (var i = 0; i < cal._monthsBody.rows.length; i++) {
                    var row = cal._monthsBody.rows[i];
                    for (var j = 0; j < row.cells.length; j++) {
                        Sys.UI.DomEvent.addHandler(row.cells[j].firstChild, "click", call2);
                    }
                }
            }
        }

        function onCalendarHidden2() {
            var cal = $find("calendar2");
            //Iterate every month Item and remove click event from it
            if (cal._monthsBody) {
                for (var i = 0; i < cal._monthsBody.rows.length; i++) {
                    var row = cal._monthsBody.rows[i];
                    for (var j = 0; j < row.cells.length; j++) {
                        Sys.UI.DomEvent.removeHandler(row.cells[j].firstChild, "click", call2);
                    }
                }
            }

        }

        function call2(eventElement) {
            var target = eventElement.target;
            switch (target.mode) {
                case "month":
                    var cal = $find("calendar2");
                    cal._visibleDate = target.date;
                    cal.set_selectedDate(target.date);
                    cal._switchMonth(target.date);
                    cal._blur.post(true);
                    cal.raiseDateSelectionChanged();
                    break;
            }
        }
 

    </script>

    <script language="javascript" type="text/javascript">
        function onCalendarShown() {

            var cal = $find("calendar1");
            //Setting the default mode to month
            cal._switchMode("months", true);

            //Iterate every month Item and attach click event to it
            if (cal._monthsBody) {
                for (var i = 0; i < cal._monthsBody.rows.length; i++) {
                    var row = cal._monthsBody.rows[i];
                    for (var j = 0; j < row.cells.length; j++) {
                        Sys.UI.DomEvent.addHandler(row.cells[j].firstChild, "click", call);
                    }
                }
            }
        }

        function onCalendarHidden() {
            var cal = $find("calendar1");
            //Iterate every month Item and remove click event from it
            if (cal._monthsBody) {
                for (var i = 0; i < cal._monthsBody.rows.length; i++) {
                    var row = cal._monthsBody.rows[i];
                    for (var j = 0; j < row.cells.length; j++) {
                        Sys.UI.DomEvent.removeHandler(row.cells[j].firstChild, "click", call);
                    }
                }
            }

        }

        function call(eventElement) {
            var target = eventElement.target;
            switch (target.mode) {
                case "month":
                    var cal = $find("calendar1");
                    cal._visibleDate = target.date;
                    cal.set_selectedDate(target.date);
                    cal._switchMonth(target.date);
                    cal._blur.post(true);
                    cal.raiseDateSelectionChanged();
                    break;
            }
        }
    </script>

    <script type="text/javascript">
        var slist = { Pending: '<%=Resources.StockIntend_ClientDisplay.StockIntend_SubstoreSearch_aspx_01%>', Approved: '<%=Resources.StockIntend_ClientDisplay.StockIntend_SubstoreSearch_aspx_02%>',
            ApprovedIntend: '<%=Resources.StockIntend_ClientDisplay.StockIntend_SubstoreSearch_aspx_03%>', Inprogress: '<%=Resources.StockIntend_ClientDisplay.StockIntend_SubstoreSearch_aspx_04%>',
            Issued: '<%=Resources.StockIntend_ClientDisplay.StockIntend_SubstoreSearch_aspx_05%>', IssuedStock: '<%=Resources.StockIntend_ClientDisplay.StockIntend_SubstoreSearch_aspx_06%>',
            IssueIntend: '<%=Resources.StockIntend_ClientDisplay.StockIntend_SubstoreSearch_aspx_07%>', ReceivedIndent: '<%=Resources.StockIntend_ClientDisplay.StockIntend_SubstoreSearch_aspx_08%>',
            ViewIntend: '<%=Resources.StockIntend_ClientDisplay.StockIntend_SubstoreSearch_aspx_09%>'
        };
    </script>

    <script type="text/javascript">

        function fnGetAction() {
            $('#hdnDDLActionText').val($('#ddlAction option:selected').text());
            $('#hdnDDLActionValue').val($('#ddlAction option:selected').val());
        }
    </script>

</body>
</html>
