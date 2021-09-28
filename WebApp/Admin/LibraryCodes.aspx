<%@ Page Language="C#" AutoEventWireup="true" CodeFile="LibraryCodes.aspx.cs" Inherits="Admin_ManageBulkData"
    EnableEventValidation="false" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/PhyBookedSchedule.ascx" TagName="PhysicainSchedule"
    TagPrefix="uc8" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .searchBox
        {
            font-family: Arial, Helvetica, sans-serif;
            text-align: left;
            height: 15px;
            width: 150px;
            border: 1px solid #999999;
            font-size: 11px;
            margin-left: 0px;
            background-image: url('../Images/magnifying-glass.png');
            background-repeat: no-repeat;
            padding-left: 20px !important;
            background-color: #F3E2A9;
        }
        .libraryCodes td { padding:5px;}
        .libraryCodes {
            margin: 20px 0 10px;
            padding: 19px!important;
            width: 490px!important;
        }
    </style>

<%--    <script src="../Scripts/jquery.min.js" language="javascript" type="text/javascript"></script>--%>
   <script src="../Scripts/jquery-1.8.1.min.js" language="javascript" type="text/javascript"></script>

    <script src="../Scripts/JsonScript.js" language="javascript" type="text/javascript"></script>
    <script language="javascript" type="text/javascript">

        function ClearALL() {

            document.getElementById('txtTestName').value = "";
            document.getElementById('txtvalues').value = "";
            document.getElementById('hdnSelectedTest').value = '';




        }
        function clearfn() {

            if (document.getElementById('txtTestName').value.length <= 0) {
                document.getElementById('lblInvType').innerHTML = '';
            }
            else {
                document.getElementById('lblInvType').innerHTML = document.getElementById('hdnInvType').value;
            }
        }

        function SelectedTest(source, eventArgs) {
            document.getElementById('hdnSelectedTest').value = eventArgs.get_value();
            var x = document.getElementById('hdnSelectedTest').value.split("~");
            var Type = x[0].split("^");
            var InvType = Type[2];
            document.getElementById('lblInvType').innerHTML = InvType;



        }
        function delrecord() {
            if (confirm("Are you sure want to Delete Record ?")) {
                return true;
            }
            else {
                return false;
            }
        }
        function IAmSelected(source, eventArgs) {
           

            var varGetVal = eventArgs.get_value();
            //alert(" Key : " + eventArgs.get_text() + "  Value :  " + eventArgs.get_value());
            var ID;
            var name;
            var InvType;


            //            eventArgs.get_value()[0].PatientID;
            var list = eventArgs.get_value().split('^');
            if (list.length > 0) {
                for (i = 0; i < list.length; i++) {
                    if (list[i] != "") {
                        ID = list[0];
                        name = list[1];
                        InvType = list[2];

                        document.getElementById('hdnInvID').value = ID;
                        document.getElementById('hdnInvName').value = name;
                        document.getElementById('hdnInvType').value = InvType;


                    }
                }

            }
            document.getElementById('hdnInvbulkValue').value = "";
        }

        function Items(result) {
          
            var lstItems = result;
            if (lstItems.length > 0) {
                var ddlName = '<%=ddlname.ClientID %>';
                $.each(lstItems, function(index, Item) {
                    $('#' + ddlName).append('<option value="' + Item.Name + '">' + Item.Name + '</option>');
                });
                for (var i = 0; i < lstItems.length; i++) {
                    $('#' + ddlName).append('<option value="' + lstItems[i].Name + '">' + lstItems[i].Name + '</option>');
                }
            }


        }
        function Validate() {
           
            
                       if (document.getElementById("<%=txtTestName.ClientID %>").value =="") {
                        alert('Enter Any Investigation');
                          return false;
                      }
//                      else if (document.getElementById("<%=lstAddItems.ClientID %>").value == "-1") {
//                          alert('Enter Any Value');
//                          return false;
//                      }

        }
        function AddOprItemValues() {
            // debugger;
        //    document.getElementById('hdnInvbulkValue').value = '';
            var txt = $("#<%= txtvalues.ClientID %>");
            var svc = $(txt).val();  //Its Let you know the textbox's value
            var lst = $("#<%=lstAddItems.ClientID %>");
            var options = $("#<%=lstAddItems.ClientID %> option");
            var alreadyExist = false;
//Alex
            if (txt.val() == "" || txt.val() == " ") {
                alert('Please provide value.');
                return false;
            }
            
            $(options).each(function() {
                if ($(this).val() == svc) {
                    alert("Item alread exists");
                    alreadyExist = true;
                    return;
                }
                txt.val("");
                // alert($(this).val());
            });
            if (!alreadyExist)
                $(lst).append('<option value="' + svc + '">' + svc + '</option>');
            document.getElementById('hdnInvbulkValue').value += svc + "^";
            $('#txtvalues').val("");
            return false;
        }


    </script>

</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
        <Services>
            <asp:ServiceReference Path="~/WebService.asmx" />
        </Services>
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
                    <div class="contentdata">
                        
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>
                               
                                <asp:UpdatePanel ID="updatePanel2" runat="server">
                                    <ContentTemplate>
                                        <asp:UpdateProgress ID="UpdateProgress2" runat="server">
                                           <ProgressTemplate>
                                                <div id="progressBackgroundFilter" class="a-center">
                                                </div>
                                                <div id="processMessage" class="a-center w-20p">
                                                    <asp:Image ID="img1" Width="40px" Height="40px" runat="server" ImageUrl="../Images/loading.GIF" meta:resourcekey="img1Resource1" />
                                                </div>
                                            </ProgressTemplate>
                                        </asp:UpdateProgress>
                        <table width="100%" cellpadding="0" cellspacing="0">
                            <tr>
                                <td>
                                        <table class="scheduledataheader2 w-42p libraryCodes show">
                                            <tr>
                                                <td class="a-left w-31p" id="tdtest" runat="server">
                                                    <asp:Label ID="lblTestName" Text="Investigation Name" runat="server"></asp:Label>
                                                </td>
                                                <td id="tdtestname" runat="server" class="a-left">
                                                    <asp:TextBox onkeydown="javascript:clearfn();" CssClass="searchBox" ID="txtTestName"
                                                        runat="server" Width="230px" Wrap="true" AutoPostBack="true" TabIndex="1" OnTextChanged="txtTestName_TextChanged"></asp:TextBox>
                                                    <ajc:AutoCompleteExtender ID="AutoCompleteExtender3" runat="server" TargetControlID="txtTestName"
                                                        EnableCaching="False" MinimumPrefixLength="2" CompletionInterval="0" FirstRowSelected="True"
                                                        CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                        CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" ServiceMethod="GetOrgInvestigations"
                                                        OnClientItemSelected="IAmSelected" ServicePath="~/WebService.asmx" UseContextKey="True"
                                                        DelimiterCharacters="" Enabled="True" OnClientItemOver="SelectedTest">
                                                    </ajc:AutoCompleteExtender>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblInvType" runat="server" ForeColor="Red" Font-Bold="True"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="a-left w-20p">
                                                    <asp:Label runat="server" ID="lblName" Text="Name" Visible="false"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlname" CssClass="ddlsmall" runat="server" Visible="false">
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="a-left">
                                                    <asp:Label runat="server" ID="lblValues" Text="Values"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtvalues" CssClass="Txtboxsmall" runat="server"></asp:TextBox>
                                                </td>
                                                <td>
                                                    <asp:Button ID="btnAdd" runat="server" CssClass="btn1" Text=">> ADD >>" OnClientClick="return AddOprItemValues()" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                </td>
                                                <td>
                                                    <asp:ListBox ID="lstAddItems" runat="server" Height="250px" Width="260px" TabIndex="9">
                                                    </asp:ListBox>
                                                </td>
                                            </tr>
                                            <%--  <tr>
                                                <td align="left">
                                                    <asp:Label runat="server" ID="lblAFlag" Text="Abnormal Flag"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtAflag" CssClass="Txtboxsmall" runat="server"></asp:TextBox>
                                                </td>
                                            </tr>--%>
                                   
                                            <tr>
                                                <td>
                                         
                                                                <asp:Button ID="btnSave" runat="server" CssClass="btn" Text="Save" OnClientClick="return Validate()"
                                                                    OnClick="btnSave_Click" />
<asp:Button ID="btnClear" runat="server" CssClass="btn" Text="Clear" OnClick="btnClear_Click" />
                                                            </td>
                                            <td align="center">
                                                              <asp:Label ID="lbldisplay" runat="server" Text="No Matching Records....!" Visible="false"></asp:Label>  
                                                            </td>
                                                        </tr>
                                                    </table>
                                    <asp:HiddenField ID="hdnInvbulkValue" runat="server" />
                                                </td>
                                       
                                        
                                
							    <td align="left">
                                <fieldset id="fieldgrd" runat="server" visible="false">
                                    <%--<asp:Label ID="lbldisplaytext" runat="server" Text="Investigation Details" Font-Bold="true"></asp:Label>--%>
                                    <legend class="bold">Investigation Details</legend>
                                    <table class="w-100p">
                                        <tr>
                                            <td>
                                                <asp:GridView ID="GrdInvDetails" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                                                    ForeColor="#333333" BorderColor="ActiveCaption" PageSize="10" CssClass="dataheader2 gridView w-100p"
                                                    CellPadding="2" CellSpacing="2" OnPageIndexChanging="GrdInvDetails_PageIndexChanging"
                                                    DataKeyNames="InvestigationID,Name,Value,IsStatus" OnRowDeleting="GrdInvDetails_RowDeleting">
                                                    <HeaderStyle CssClass="dataheader1" />
                                                    <Columns>
                                                        <asp:BoundField DataField="DisplayText" HeaderText="Investigation Name" />
                                                        <%-- <asp:BoundField DataField="Name" HeaderText= "Name" />--%>
                                                        <asp:BoundField DataField="Value" HeaderText="Value" />
                                                        <asp:BoundField DataField="IsStatus" HeaderText="IS Status" Visible="false" />
                                                        <asp:TemplateField HeaderText="Action">
                                                            <ItemTemplate>
                                                                <asp:LinkButton ID="lnkDelte" runat="server" align="center" CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>'
                                                                    CommandName="Delete" OnClientClick="return delrecord();" Text="Delete" CssClass="btn"></asp:LinkButton>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                    </Columns>
                                                </asp:GridView>
                                            </td>
                                        </tr>
                                    </table>
                                </fieldset>
                                </td>
                            </tr>
                        </table>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                <br />
            </ContentTemplate>
        </asp:UpdatePanel>
                    </div>
     <Attune:Attunefooter ID="Attunefooter" runat="server" />              
    <%--<asp:HiddenField ID="hdnInvbulkValue" runat="server" />--%>
    <asp:HiddenField ID="hdnSelectedTest" runat="server" />
    <asp:HiddenField ID="hdnInvID" runat="server" Value="0" />
    <asp:HiddenField ID="hdnInvName" runat="server" Value="" />
    <asp:HiddenField ID="hdnInvType" runat="server" Value="" />
    <asp:HiddenField ID="hdnOrgID" runat="server" Value="0" />
    </form>



</body>
</html>
