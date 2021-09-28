<%@ Control Language="C#" AutoEventWireup="true" CodeFile="FoodMenuWardmapping.ascx.cs"
    Inherits="CommonControls_FoodMenuWardmapping" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<div class="contentdata1">
 <asp:UpdatePanel ID="UpdatePanelfoodmenu" runat="server">
  <contenttemplate>
    <table width="100%" class="dataheader2 defaultfontcolor" cellpadding="0" cellspacing="2">
     <tr>
         <td colspan="8" align="center">
          &nbsp;<asp:Label ID="lblmsg" runat="server" meta:resourcekey="lblmsgResource1"></asp:Label>
           </td>
          </tr>
        <tr>
            <td style="height: 50px; width: 150px">
                <asp:Label ID="lblbuilding" Text="Building Name :" runat="server" 
                    meta:resourcekey="lblbuildingResource1"></asp:Label>
            </td>
            <td style="height: 50px; width: 200px">
                <asp:DropDownList ID="ddbuilding" CssClass ="ddlsmall" runat="server" 
                    Onchange="GetWardList();" meta:resourcekey="ddbuildingResource1">
                </asp:DropDownList>
                &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
            </td>
            <td style="height: 50px; width: 100px">
                <asp:Label ID="lbward" Text="Ward Name :" runat="server" 
                    meta:resourcekey="lbwardResource1"></asp:Label>
            </td>
            <td style="height: 50px; width: 200px">
                <asp:DropDownList ID="ddward" CssClass ="ddlsmall" runat="server" 
                    meta:resourcekey="ddwardResource1">
                    <asp:ListItem Text="--Select--" Value="-1" meta:resourcekey="ListItemResource1"></asp:ListItem>
                </asp:DropDownList>
                &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
            </td>
            <td style="height: 50px; width: 100px">
                <asp:Label ID="lbroomtype" Text="Room Type :" runat="server" 
                    meta:resourcekey="lbroomtypeResource1"></asp:Label>
            </td>
            <td style="height: 50px; width: 200px">
                <asp:DropDownList ID="ddroomtype" CssClass ="ddlsmall" runat="server" 
                    meta:resourcekey="ddroomtypeResource1">
                </asp:DropDownList>
                &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
            </td>
            <td style="height: 50px; width: 100px">
                <asp:Label ID="lbFoodmenu" Text="Food Menu :"  runat="server" 
                    meta:resourcekey="lbFoodmenuResource1"></asp:Label>
            </td>
            <td style="height: 50px; width: 200px">
                <asp:TextBox ID="txtfoodmenu" TabIndex="25"  MaxLength="150" CssClass="searchBox" Width="150px"
                
                    runat="server" meta:resourcekey="txtfoodmenuResource1"></asp:TextBox>
                &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                <ajc:AutoCompleteExtender ID="A4" runat="server" TargetControlID="txtfoodmenu" EnableCaching="False"
                    MinimumPrefixLength="2" CompletionInterval="1" FirstRowSelected="True" OnClientItemSelected="FoodMenuItem"
                    CompletionListCssClass="listtwo" CompletionListItemCssClass="hoverlistitemtwo" 
                    CompletionListHighlightedItemCssClass="listitemtwo" ServiceMethod="pGetMasterFoodMenuName"
                    ServicePath="~/NutritionWebService.asmx" UseContextKey="True" DelimiterCharacters=""
                    Enabled="True">
                </ajc:AutoCompleteExtender>
            </td>
        </tr>
            <tr>
            <td align="center" style="height: 80px;" colspan="7">
             
              <asp:Button ID="btnADD" Text="Save" runat="server" CssClass="btn" OnClientClick="return Add_id();" 
                    OnClick="btnADD_Click" meta:resourcekey="btnADDResource1" />
                <asp:Button ID="btn_cancel" Text="Cancel" runat="server" CssClass="btn" 
                    OnClientClick="return FoodMenuWardFnClear();" meta:resourcekey="btn_cancelResource1" />
            </td>
        </tr>
    </table>
    <table width="100%" class="dataheader2 defaultfontcolor" cellpadding="0" cellspacing="2">
        <tr>
            <td align="center">
                <asp:GridView ID="grdResult" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                    CellPadding="1" CellSpacing="1" CssClass="mytable1"  OnPageIndexChanging="grdResult_PageIndexChanging"
                    OnRowDataBound="grdResult_RowDataBound" Width="100%" 
                    meta:resourcekey="grdResultResource1">
                    <Columns>
                        <asp:TemplateField HeaderText="Select" 
                            meta:resourcekey="TemplateFieldResource1">
                            <ItemStyle HorizontalAlign="Center" Width="2%" />
                            <ItemTemplate>
                                <asp:RadioButton ID="rdSel" runat="server" GroupName="OrderSelect" meta:resourcekey="rdSelResource1"
                                    ToolTip="Select Row"/>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField Visible="False" meta:resourcekey="TemplateFieldResource2">
                            <ItemStyle HorizontalAlign="Center" Width="2%" />
                            <ItemTemplate>
                                <asp:Label ID="lblfoodmenumapping" runat="server" 
                                    Text='<%# Eval("FoodMenuWardMapping") %>' 
                                    meta:resourcekey="lblbuildingnameResource1"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField Visible="False" meta:resourcekey="TemplateFieldResource3">
                            <ItemStyle HorizontalAlign="Center" Width="2%" />
                            <ItemTemplate>
                                <asp:Label ID="lblbuilid" runat="server" Text='<%# Eval("BuildingID") %>' 
                                    meta:resourcekey="lblwardnameResource1"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="BuildingName" 
                            meta:resourcekey="TemplateFieldResource4">
                            <ItemStyle HorizontalAlign="Center" Width="2%" />
                            <ItemTemplate>
                                <asp:Label ID="lblbuildingname" runat="server" 
                                    Text='<%# Eval("BuildingName") %>' 
                                    meta:resourcekey="lblfoodmenumappingResource1"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="WardName" 
                            meta:resourcekey="TemplateFieldResource5">
                            <ItemStyle HorizontalAlign="Center" Width="2%" />
                            <ItemTemplate>
                                <asp:Label ID="lblwardname" runat="server" Text='<%# Eval("WardName") %>' 
                                    meta:resourcekey="lblbuilidResource1"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField Visible="False" meta:resourcekey="TemplateFieldResource6">
                            <ItemStyle HorizontalAlign="Center" Width="2%" />
                            <ItemTemplate>
                                <asp:Label ID="lblwardid" runat="server" Text='<%# Eval("WardID") %>' 
                                    meta:resourcekey="lblroomtypenameResource1"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="RoomTypeName" 
                            meta:resourcekey="TemplateFieldResource7">
                            <ItemStyle HorizontalAlign="Center" Width="2%" />
                            <ItemTemplate>
                                <asp:Label ID="lblroomtypename" runat="server" 
                                    Text='<%# Eval("RoomTypeName") %>' meta:resourcekey="lblwardidResource1"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField Visible="False" meta:resourcekey="TemplateFieldResource8">
                            <ItemStyle HorizontalAlign="Center" Width="2%" />
                            <ItemTemplate>
                                <asp:Label ID="lblroomtypeid" runat="server" Text='<%# Eval("RoomTypeID") %>' 
                                    meta:resourcekey="lblfoodmenunmeResource1"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="FoodMenuName" 
                            meta:resourcekey="TemplateFieldResource9">
                            <ItemStyle HorizontalAlign="Left" Width="2%" />
                            <ItemTemplate>
                                <asp:Label ID="lblfoodmenunme" runat="server" 
                                    Text='<%# Eval(" FoodMenuName") %>' meta:resourcekey="lblroomtypeidResource1"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField Visible="false" meta:resourcekey="TemplateFieldResource10">
                            <ItemStyle HorizontalAlign="Center" Width="2%" />
                            <ItemTemplate>
                                <asp:Label ID="lblfoodmenuid" runat="server" Text='<%# Eval("FoodMenuID ") %>' 
                                    meta:resourcekey="lblfoodmenuidResource1"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <PagerStyle CssClass="dataheader1" HorizontalAlign="Center" />
                 <HeaderStyle CssClass="dataheader1" />
                </asp:GridView>
            </td>
        </tr>
    </table>
    <asp:HiddenField ID="hdnfoodmenuID" runat="server" />
    <asp:HiddenField ID="hdnbuildingID" runat="server" />
    <asp:HiddenField ID="hdnWardID" runat="server" />
    <asp:HiddenField ID="hdnRoomtypeID" runat="server" />
    <asp:HiddenField ID="hdnWardList" runat="server" />
    <asp:HiddenField ID="hdnRoomTypeList" runat="server" />
    <asp:HiddenField ID="commonval" runat="server" />
    <asp:HiddenField ID="hdnbtnADD" runat="server" />
    <asp:HiddenField ID="hdnfoodmenuwardmapping" runat="server" Value="0" />
 </contenttemplate>
</asp:UpdatePanel>
</div>
<script type ="text/javascript" language ="javascript" >

var slist1 ={Update:'<%=Resources.ClientSideDisplayTexts.Common_Update %>',clear:'<%=Resources.ClientSideDisplayTexts.Common_clear %>',
ADD:'<%=Resources.ClientSideDisplayTexts.Common_Save %>',Cancel:'<%=Resources.ClientSideDisplayTexts.Common_cancel %>'};
</script>
<script type="text/javascript" language="javascript">
    function FoodMenuItem(source, eventArgs) {
      
            var txtfoodmenuname = eventArgs.get_text();
            var txtfoodmenuID = eventArgs.get_value();
            document.getElementById('<%= txtfoodmenu.ClientID %>').value = txtfoodmenuname;
            document.getElementById('<%= hdnfoodmenuID.ClientID %>').value = txtfoodmenuID;
        }
    
         function GetWardList() {
           
     var drpbuild = document.getElementById('<%= ddbuilding.ClientID %>').options[document.getElementById('<%= ddbuilding.ClientID %>').selectedIndex].value;
        var options = document.getElementById('<%= hdnWardList.ClientID %>').value;
        var drpward = document.getElementById('<%= ddward.ClientID %>');
         drpward.options.length = 1;
        var list = options.split('^');
        for (i = 0; i < list.length; i++) {
        if (list[i] != "") {
                var res = list[i].split('~');
      if (drpbuild == res[0]) {
                    var optn = document.createElement("option");
                        drpward.options.add(optn);
                    optn.text = res[2];
                    optn.value = res[1];
                       }
                   }
       
          }
    }
    function Add_id()
    {

        if (document.getElementById('<%= ddbuilding.ClientID %>').selectedIndex == 0) {  
        var userMsg = SListForApplicationMessages.Get('CommonControls\\FoodMenuWardmapping.ascx_1');
                    if (userMsg != null) {
                        alert(userMsg);
                        return false;
                    }
                    else {
            alert('select the Building Name'); 
                  return false;
                  }
            document.getElementById('<%= ddbuilding.ClientID %>').focus();
            return false;
            }
        if (document.getElementById('<%= ddward.ClientID %>').selectedIndex == 0){ 
          var userMsg = SListForApplicationMessages.Get('CommonControls\\FoodMenuWardmapping.ascx_2');
                    if (userMsg != null) {
                        alert(userMsg);
                        return false;
                    }
                    else { 
            alert('select the Ward Name');
            return false ;
            }
            document.getElementById('<%= ddward.ClientID %>').focus();
            return false;
       }
        if (document.getElementById('<%= ddroomtype.ClientID %>').selectedIndex == 0){  
        var userMsg = SListForApplicationMessages.Get('CommonControls\\FoodMenuWardmapping.ascx_3');
                    if (userMsg != null) {
                        alert(userMsg);
                        return false;
                    }
                    else { 
            alert('select the RoomType Name');
            return false ;
            }
            document.getElementById('<%= ddroomtype.ClientID %>').focus();
            return false;
       }
        if (document.getElementById('<%= txtfoodmenu.ClientID %>').value.trim() == ""){  
        var userMsg = SListForApplicationMessages.Get('CommonControls\\FoodMenuWardmapping.ascx_4');
                    if (userMsg != null) {
                        alert(userMsg);
                        return false;
                    }
                    else {  
            alert('select the Foodmenu Name');
            return false ;
            }
            document.getElementById('<%= txtfoodmenu.ClientID %>').focus();
            return false; 
       }  
        var val =document.getElementById('<%= ddward.ClientID %>').options[document.getElementById('<%= ddward.ClientID %>').selectedIndex].value; 
        document.getElementById ('<%= commonval.ClientID %>').value = val;
         
    }
        function FoodMenuWardextractRow(rid,foodmenuwardmapping,buildingid,foodmenuid,foodmenuname,wardid,wardname,roomtypeid,roomtypename)
        { 

             document.getElementById('<%= lblmsg.ClientID %>').innerHTML = "";
            var len = document.forms[0].elements.length;
            for (var i = 0; i < len; i++) {
                if (document.forms[0].elements[i].type == "radio") {
                    document.forms[0].elements[i].checked = false;
                }
            }
            document.getElementById(rid).checked = true;
            document.getElementById('<%= hdnfoodmenuwardmapping.ClientID %>').value = foodmenuwardmapping ;
            document.getElementById('<%= ddbuilding.ClientID %>').value = buildingid ;
            GetWardList();
            document.getElementById('<%= hdnfoodmenuID.ClientID %>').value =foodmenuid ;
            document.getElementById('<%= hdnRoomtypeID.ClientID %>').value =roomtypeid;
            document.getElementById('<%= txtfoodmenu.ClientID %>').value = foodmenuname;
            document.getElementById('<%= ddward.ClientID %>').value = wardid ;
            document.getElementById('<%= hdnWardID.ClientID %>').value = wardid ;
            document.getElementById('<%=ddroomtype.ClientID %>').value = roomtypeid ;
            document.getElementById('<%=btnADD.ClientID %>').value =  slist1 .Update ;
            document.getElementById('<%= hdnbtnADD.ClientID %>').value = slist1 .Update ;
            document.getElementById('<%=btn_cancel.ClientID %>').value = slist1.clear ;
        }
        
        
         function FoodMenuWardFnClear() {

            document.getElementById('<%= ddroomtype.ClientID %>').value = 0;
            document.getElementById('<%= ddbuilding.ClientID %>').value = 0;
            document.getElementById('<%= ddward.ClientID %>').value = -1;
            document.getElementById('<%= hdnfoodmenuwardmapping.ClientID %>').value = 0;
            document.getElementById('<%= txtfoodmenu.ClientID %>').value = '';
            document.getElementById('<%= btnADD.ClientID %>').value = slist1 .ADD;
            document.getElementById('<%= hdnbtnADD.ClientID %>').value = slist1 .ADD ;
              document.getElementById('<%=btn_cancel.ClientID %>').value = slist1 .Cancel;
              document.getElementById('<%= lblmsg.ClientID %>').innerHTML = "";
          var gridId = document.getElementById("<%= grdResult.ClientID %>");
        var gdrowcount = document.getElementById("<%= grdResult.ClientID %>").rows.length;
        for (var i = 1; i < gdrowcount; i++) {
            var inputs = gridId.rows[i].getElementsByTagName('input');
            for (var j = 0; j < inputs.length; j++) {
                if (inputs[j].type == "radio")
                    inputs[j].checked = false;
            }
        }
             return false;
        }
       
</script>