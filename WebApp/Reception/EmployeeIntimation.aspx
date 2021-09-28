<%@ Page Language="C#" AutoEventWireup="true" CodeFile="EmployeeIntimation.aspx.cs"
    Inherits="Reception_EmployeeIntimation" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Employee Intimation</title>
    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
   <%-- <script src="jquery-1.10.2.js" type="text/javascript"></script>--%>
 
    <%-- <script src="../Scripts/jquery-1.10.2.min.js" type="text/javascript"></script>
    <script src="../Scripts/jquery.min.js" language="javascript" type="text/javascript"></script>
    <script src="../scripts/MessageHandler.js" language="javascript" type="text/javascript"></script>
    <link rel="stylesheet" type="text/css" href="http://ajax.aspnetcdn.com/ajax/jquery.dataTables/1.9.4/css/jquery.dataTables.css" />
    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/TabMenu.css" rel="stylesheet" type="text/css" />
    <link type="text/css" href="../StyleSheets/jquery-ui-1.8.19.custom.css" rel="stylesheet" />
    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/jquery.dataTables.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/jquery.dataTables_themeroller.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/TableTools_JUI.css" rel="stylesheet" type="text/css" />--%>
    <style type="text/css">
        .dataheader3
        {
            margin-right: 2px;
        }
        .displayFalse
        {
            display: none;
        }
        .w-5p
        {
            width: 5% !important;
        }
        .csslblComments
        {
            word-wrap: break-word;
            word-break: break-all;
            white-space: normal;
            width: 582px;
            text-align: left !important;
        }
    </style>

    <script type="text/javascript">
    
    
        function ClearInvoiceBill() {
            var comment = $('#btnSave').val();
            if (comment == "Update") {
                alert('You can not Reset at Update Mode');
                return false;
            }
            document.getElementById('ddlCatagory').selectedIndex = 0;
            document.getElementById('ddlType').selectedIndex = 0;
           document.getElementById('ddlnotifyto').selectedIndex = 0;   //surya
            document.getElementById('<%=txtValues.ClientID %>').value = "";
            return true;
        }
        function CheckDel() {
            var comment = $('#btnSave').val();
            if (comment == "Update") {
                alert('You can not Delete at Update Mode');
                return false;
            }
            else {
                return true;
            }
        }
        function checkDate(obj) {
            var catagory = $('#ddlCatagory option:selected').text();
            if (catagory == "---Select---") {
                alert('Please select Catagory value');
                return false;
            }
            var type = $('#ddlType option:selected').text();
            if (type == "--Select--") {
                alert('Please select Type value');
                return false;
            }
            var comment = document.getElementById('<%=txtValues.ClientID %>').value;
            if (comment == "") {
                alert('Value field is mandatory');
                return false;
            }

            var commentSplit = comment.split(',');
            var totalValueArr = [];
            for (i = 0; i < commentSplit.length; i++) {
                var value = commentSplit[i];
                var mailformat = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
                var phoneno = /^\d{10}$/;
                if (value.match(mailformat) && type == "Email") {
                    totalValueArr.push({ 'Value': value });
                }
                else if (value.match(phoneno) && type == "Sms") {
                    totalValueArr.push({ 'Value': value });
                }
            }

            ///////////////////////surya start///////////
            var totalValueArr1 = [];
            for (i = 0; i < commentSplit.length; i++) {
                var value = commentSplit[i];
                var mailformat = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
                var phoneno = /^\d{10}$/;
                if (value.match(mailformat) && type == "CC") {
                    totalValueArr1.push({ 'Value': value });
                }
                else if (value.match(phoneno) && type == "BCC") {
                    totalValueArr1.push({ 'Value': value });
                }
            }
            
            
            ////////////////////////////////////surya end/////////////
            var arrCount = totalValueArr.length;
            var loopCount = 0;
            if (arrCount == 0) {
                document.getElementById('<%=txtValues.ClientID %>').value = '';
                alert("You have entered an invalid Value!");
                return false;
            }
            else {
                document.getElementById('<%=txtValues.ClientID %>').value = '';
                $(totalValueArr).each(function() {
                    loopCount += 1;
                    if (loopCount == arrCount)
                        document.getElementById('<%=txtValues.ClientID %>').value += this.Value;
                    else
                        document.getElementById('<%=txtValues.ClientID %>').value += this.Value + ',';
                });

            }
        }
        
         </script>

</head>
<body oncontextmenu="return false;">
    <form id="form1" runat="server">
    <asp:ScriptManager ID="scrpt" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
        <asp:UpdatePanel ID="updateGrid" runat="server">
            <ContentTemplate>
                <table width="98%" class="dataheader2 defaultfontcolor" border="0" cellpadding="4"
                    cellspacing="0">
                    <tr>
                        <td align="center">
                            <table width="80%">
                                <%-- class="displayFalse"--%>
                                <tr align="left">
                                    <td>
                                        <asp:Label ID="lblCatagory" runat="server" Text="Catagory"></asp:Label>
                                    </td>
                                    <td class="w-20p">
                                        <asp:DropDownList ID="ddlCatagory" runat="server" align="center">
                                            <%--<asp:ListItem>------Select------</asp:ListItem>
                                                            <asp:ListItem>RollingAdvance</asp:ListItem>--%>
                                        </asp:DropDownList>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblType" runat="server" Text="Type"></asp:Label>
                                    </td>
                                    <td class="w-15p">
                                        <asp:DropDownList ID="ddlType" runat="server">
                                            <%--<asp:ListItem>--Select--</asp:ListItem>
                                                            <asp:ListItem>Email</asp:ListItem>
                                                            <asp:ListItem>Sms</asp:ListItem>--%>
                                        </asp:DropDownList>
                                    </td>
                                  <%--  surya Start--%>
                                  
                                       <td>
                                        <asp:Label ID="lblnotifyto" runat="server" Text="Notify To"></asp:Label>
                                    </td>
                                    <td class="w-15p">
                                        <asp:DropDownList ID="ddlnotifyto" runat="server" >
                                            <%--<asp:ListItem>--Select--</asp:ListItem>
                                                            <asp:ListItem>Email</asp:ListItem>
                                                            <asp:ListItem>Sms</asp:ListItem>--%>
                                        </asp:DropDownList>
                                    </td>
                                    
                                 <%--   surya end--%>
                                    <td>
                                        <asp:Label ID="lblValues" runat="server" Text="Values"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtValues" Width="275px" runat="server" TextMode="MultiLine">
                                        </asp:TextBox>
                                        &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="4" align="right">
                                        <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                            onmouseout="this.className='btn'" Width="60px" OnClientClick="javascript:return checkDate(this);"
                                            OnClick="btnSave_Click" />
                                    </td>
                                    <td colspan="4" align="left">
                                        <input id="btnReset" class="btn" style="width: 60px;" type="button" value="Reset"
                                            onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" width="60px"
                                            onclick="ClearInvoiceBill();" />
                                    </td>
                                </tr>
                            </table>
                            <table width="80%">
                                <tr>
                                    <td colspan="6" align="center">
                                        <asp:GridView ID="grdResult" runat="server" AutoGenerateColumns="false" CellPadding="1"
                                            CssClass="mytable1 dataheader3" ShowFooter="false" HeaderStyle-CssClass="dataheader1"
                                            OnRowCommand="grdResult_RowCommand" Width="100%">
                                            <Columns>
                                                <asp:TemplateField HeaderText="Sno.">
                                                    <ItemTemplate>
                                                        <asp:Label runat="server" ID="lblSno" Text='<%#Eval("Sno")%>' />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="CommId" HeaderStyle-CssClass="displayFalse" ItemStyle-CssClass="displayFalse"
                                                    FooterStyle-CssClass="displayFalse">
                                                    <ItemTemplate>
                                                        <asp:Label runat="server" ID="lblCommId" Text='<%#Eval("CommunicationConfigID")%>' />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="NotificationCategory">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblCategory" runat="server" Text='<%#Eval("NotificationCategory") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="NotificationType">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblType" runat="server" Text='<%#Eval("NotificationType") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <%--surya--%>
                                                  <asp:TemplateField HeaderText="EmailType">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblnotifyto" runat="server" Text='<%#Eval("EmailType") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                
                                                <%--surya end--%>
                                         
                                                <asp:TemplateField HeaderText="Values" ItemStyle-CssClass="csslblComments" HeaderStyle-CssClass="csslblComments"
                                                    FooterStyle-CssClass="csslblComments">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblComments" runat="server" Text='<%#Eval("CommunicationConfigValues") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="OrgID" HeaderStyle-CssClass="displayFalse" ItemStyle-CssClass="displayFalse"
                                                    FooterStyle-CssClass="displayFalse">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblOrgID" runat="server" Text='<%#Eval("OrgID") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Edit" ShowHeader="false" HeaderStyle-Width="80px">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="btnedit" CausesValidation="false" runat="server" CommandArgument='<%#Eval("CommunicationConfigID")+"^"+Eval("NotificationCategory") +"^"+Eval("NotificationType")+"^"+Eval("CommunicationConfigValues") +"^"+Eval("EmailType")%>'
                                                            Text='Edit'></asp:LinkButton>&nbsp;|&nbsp;<asp:LinkButton ID="btnDelete" OnClientClick="return CheckDel()"
                                                                CausesValidation="false" runat="server" CommandName="Del" CommandArgument='<%#Eval("CommunicationConfigID")+"^"+Eval("NotificationCategory") +"^"+Eval("NotificationType")+"^"+Eval("CommunicationConfigValues")+"^"+Eval("EmailType") %>'
                                                                Text='Delete'></asp:LinkButton>
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
                <input type="hidden" id="hdnOrgId" runat="server" />
                <asp:HiddenField ID="hdnConfigID" runat="server" />
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    <asp:HiddenField ID="hdnMessages" runat="server" />
    </form>
    <%-- <script type="text/javascript" src="../Scripts/jquery.dataTables.min.js"></script>
    <script src="../Scripts/jquery.dataTables.min_new.js" type="text/javascript"></script>
    <script type="text/javascript" src="../Scripts/ZeroClipboard.js"></script>
    <script type="text/javascript" src="../Scripts/TableTools.js"></script>
    <script type="text/javascript" src="../Scripts/TableTools.min.js"></script>--%>
    <script type="text/javascript">
        $(function() {

            $('#ddlType').change(function() {
                var Type;
                Type = $('#ddlType option:selected').val();
                if (Type == '0') {
                    $("#txtValues").val() = '';
                    
                }
                else {
                    $("#txtValues").val() = '';
                   


                }


            });

            //new changes for ddlcategory
            $(function() {

            $('#ddlcategory').change(function() {
                var Category;
                Category = $('#ddlcategory option:selected').val();
                $("#txtValues").val() = Category == "-1" ? "" : "";
//                if (Category == '-1') {
//                    $("#txtValues").val() = '';
//                    
//                }
//                else {
//                    $("#txtValues").val() = '';
//                }


            });

                       
            //end ddlcategory
            
            
              //new changes for ddlnotifyto
            $(function() {

            $('#ddlnotifyto').change(function() {
                var Notify To;
                
                Notify To = $('#ddlnotifyto option:selected').val();
              
                if ( Notify To == '0') {
                    $("#txtValues").val() = '';
                    
                }
                else {
                    $("#txtValues").val() = '';
                   


                }


            });

                       
            //end ddlnotifyto
            
               

            $("#txtValues").on("keydown", function(e) {

                if (event.code != 'Delete' && event.code != 'Backspace') {
                    var dropdown_val = $("#ddlType option:selected").val();
                   
                    if ((e.which < 48 || e.which > 57) && dropdown_val === $.trim('Sms')) {
                        // $("#transac_errmsg" + transaction_hid).html("Digits only").show().fadeOut("slow");
                       
                        e.preventDefault();
                    }

                    if ((e.which <= 64 && e.which >= 91) || (e.which <= 96 && e.which >= 123) && dropdown_val === $.trim('Email')) {
                        // $("#transac_errmsg" + transaction_hid).html("Letters only").show().fadeOut("slow");
                      
                        e.preventDefault();
                    }


                }

            });



        });
        </script>
        
      <%--  surya start--%>
      
      
      <script type="text/javascript">
          $(function() {

          $('#ddlnotifyto').change(function() {
                  var Type;
                  Type = $('#ddlnotifyto option:selected').val();
                  if (Type == 'Email') {
                      $("#txtValues").val() = '';

                  }
                  else {
                      $("#txtValues").val() = '';



                  }


              });

//              $("#txtValues").on("keydown", function(e) {

//                  if (event.code != 'Delete' && event.code != 'Backspace') {
//                      var dropdown_val = $("#ddlType option:selected").val();

//                      if ((e.which < 48 || e.which > 57) && dropdown_val === $.trim('Sms')) {
//                          // $("#transac_errmsg" + transaction_hid).html("Digits only").show().fadeOut("slow");

//                          e.preventDefault();
//                      }

//                      if ((e.which <= 64 && e.which >= 91) || (e.which <= 96 && e.which >= 123) && dropdown_val === $.trim('Email')) {
//                          // $("#transac_errmsg" + transaction_hid).html("Letters only").show().fadeOut("slow");

//                          e.preventDefault();
//                      }


//                  }

//              });



//          });
        </script>
      
      
        
   <%--     surya end--%>
        
        
        
</body>
</html>
