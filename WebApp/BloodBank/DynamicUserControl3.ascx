<%@ Control Language="C#" AutoEventWireup="true" CodeFile="DynamicUserControl3.ascx.cs" Inherits="BloodBank_DynamicUserControl3" %>
<%--<%@ Register Src="EditEMR.ascx" TagName="EMR" TagPrefix="uc8" %>--%>
<%--<asp:UpdatePanel ID="pnl" runat="server">
<ContentTemplate>--%>
<%--<script type ="text/javascript">
    function fn() {
        //debugger;
        alert('fn');
    }
</script>--%>
<%--<div id="divDI1" onclick="showResponses('Diab1_divDI1','Diab1_divDI2','divDI3',1);" 
style="cursor: pointer; display: block;" runat="server"> 
&nbsp;<img src="../Images/showBids.gif" alt="Show" /> 
<asp:Label ID="Label1" Text="Diabetes Mellitus" Font-Bold="True" 
runat="server" /> 
</div> 
<div id="divDI2" style="cursor: pointer; display: none; cursor: pointer;" onclick="showResponses('Diab1_divDI1','Diab1_divDI2','divDI3',0);" 
runat="server"> 
&nbsp;<img src="../Images/hideBids.gif" alt="hide" /> 
<asp:Label ID="Label2" Text="Diabetes Mellitus" Font-Bold="True" 
runat="server" /> 
</div> 
<div id="divDI3" style="display: none;width:100%" title="Diabetes Mellitus">--%>

<script type="text/javascript">
      function showdiv() {
            document.getElementById("ucDynamic3_divChkList").style.display = "block";
      }
      function showdiv2() {
            document.getElementById("ucDynamic4_divChkList2").style.display = "block";
      }
      function showdivonClick2() {
            var objDLL = document.getElementById("ucDynamic3_divChkList");
            if (objDLL.style.display == "block")
                  objDLL.style.display = "none";
            else 
                  objDLL.style.display = "block";
      }
      function showdivonClick3() {
            var objDLL = document.getElementById("ucDynamic4_divChkList2");
            if (objDLL.style.display == "block")
                  objDLL.style.display = "none";
            else 
                  objDLL.style.display = "block";
      }
      function getSelectedItem(lstValue, lstNo, lstID, ctrlType) {
            var noItemChecked = 0;
            var ddlReport = document.getElementById("ucDynamic3_ddlChkList1");
            var selectedItems = "";
            var arr = document.getElementById("ucDynamic3_chkLstItem").getElementsByTagName('input');
            var arrlbl = document.getElementById("ucDynamic3_chkLstItem").getElementsByTagName('label');
            var objLstId = document.getElementById('ucDynamic3_hidList');
            for (i = 0; i < arr.length; i++) {
                  checkbox = arr[i];
                  if (i == lstNo) {
                        if (ctrlType == 'anchor') {
                              if (!checkbox.checked) {
                                    checkbox.checked = true;
                              }
                              else {
                                    checkbox.checked = false;
                              }
                        }
                  }
                  if (checkbox.checked) {
                        if (selectedItems == "") {
                              selectedItems = arrlbl[i].innerText;
                        }
                        else {
                              selectedItems = selectedItems + "," + arrlbl[i].innerText;
                        }
                        noItemChecked = noItemChecked + 1;
                  }
            }
            ddlReport.title = selectedItems;
            var Text = ddlReport.options[ddlReport.selectedIndex].text;
            if (noItemChecked == 1)
                  ddlReport.options[ddlReport.selectedIndex].text = lstValue;
            else
                  ddlReport.options[ddlReport.selectedIndex].text = noItemChecked + " Items";
            document.getElementById('ucDynamic3_hidList').value = ddlReport.options[ddlReport.selectedIndex].text;
            document.getElementById('ucDynamic3_lblCheckItems').innerText=selectedItems;
      }
       function getSelectedItem2(lstValue, lstNo, lstID, ctrlType) {
            var noItemChecked = 0;
            var ddlReport = document.getElementById("ucDynamic4_ddlChkList2");
            var selectedItems = "";
            var arr = document.getElementById("ucDynamic4_chkLstItem2").getElementsByTagName('input');
            var arrlbl = document.getElementById("ucDynamic4_chkLstItem2").getElementsByTagName('label');
            var objLstId = document.getElementById('ucDynamic4_hidList2');
            for (i = 0; i < arr.length; i++) {
                  checkbox = arr[i];
                  if (i == lstNo) {
                        if (ctrlType == 'anchor') {
                              if (!checkbox.checked) {
                                    checkbox.checked = true;
                              }
                              else {
                                    checkbox.checked = false;
                              }
                        }
                  }
                  if (checkbox.checked) {
                        if (selectedItems == "") {
                              selectedItems = arrlbl[i].innerText;
                        }
                        else {
                              selectedItems = selectedItems + "," + arrlbl[i].innerText;
                        }
                        noItemChecked = noItemChecked + 1;
                  }
            }
            ddlReport.title = selectedItems;
            var Text = ddlReport.options[ddlReport.selectedIndex].text;
            if (noItemChecked == 1)
                  ddlReport.options[ddlReport.selectedIndex].text = lstValue;
            else
                  ddlReport.options[ddlReport.selectedIndex].text = noItemChecked + " Items";
            document.getElementById('ucDynamic4_hidList2').value = ddlReport.options[ddlReport.selectedIndex].text;
            document.getElementById('ucDynamic4_lblCheckItems2').innerText=selectedItems;
      }
     document.onclick = check;   
      function check(e) {
            var target = (e && e.target) || (event && event.srcElement);
            var obj = document.getElementById('ucDynamic3_divChkList');
            var obj1 = document.getElementById('ucDynamic3_ddlChkList1');
            var obj2 = document.getElementById('ucDynamic4_divChkList2');
            var obj3 = document.getElementById('ucDynamic4_ddlChkList2');
            if (target.id != "alst" && !target.id.match("chkLstItem")) {
                  if (!(target == obj || target == obj1 || target == obj2 || target == obj3)) {
                        obj.style.display = 'none';
                        obj2.style.display = 'none';
                  }
                  else if (target == obj || target == obj1 || target == obj2 || target == obj3) {
                        if (obj.style.display == 'block') {
                              obj.style.display = 'block';
                        }
                        else {
                              obj.style.display = 'none';
                              document.getElementById('ucDynamic3_ddlChkList1').blur();
                        }
                        if(obj2.style.display == 'block'){
                              obj2.style.display='block';
                        }
                        
                        else {
                              obj2.style.display = 'none';
                              document.getElementById('ucDynamic4_ddlChkList2').blur();
                        }
                  }
            }
      }
</script>

<table cellpadding="0" width="100%">
    <%--<tr class="defaultfontcolor">
        <td style="font-weight: bold; height: 6px; color: #000; font-size: 12px" align="center">
            <asp:Label ID="lblSkin_928" runat="server" Text="Skin"></asp:Label>
        </td>
    </tr>--%>
    <tr class="defaultfontcolor" id="trLiver" runat="server" style="display: block;">
        <td colspan="2">
            <table cellpadding="0" width="100%">
                <tr>
                    <td style="width: 200px">
                        <asp:Label ID="lblHeading" runat="server" Font-Bold="True" 
                            meta:resourcekey="lblHeadingResource1"></asp:Label>
                    </td>
                    <td align="left" colspan="1">
                        <asp:RadioButton ID="rdoYes_78" Text="Yes" runat="server" GroupName="radioExtend"
                            onclick="javascript:showContentHis(this.id);" 
                            meta:resourcekey="rdoYes_78Resource1" />
                        <asp:RadioButton ID="rdoNo_78" Text="No" runat="server" GroupName="radioExtend" 
                            onclick="javascript:showContentHis(this.id);" 
                            meta:resourcekey="rdoNo_78Resource1" />
                        <asp:RadioButton ID="rdoUnknown_78" Text="Unknown" runat="server" GroupName="radioExtend"
                            onclick="javascript:showContentHis(this.id);" 
                            meta:resourcekey="rdoUnknown_78Resource1" />
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td colspan="2">
            <div id="divrdoYes_78" runat="server" style="display: none">
                <table cellpadding="0" align="center" width="100%">
                    <%--<tr>
                            <td colspan="3">
                                <asp:Label ID="Label24" Visible="false" runat="server" Text="Type"></asp:Label>
                            </td>
                        </tr>--%>
                    <tr>
                        <td>
                            <%--<asp:TextBox ID="txtLiver_78" runat="server" Width="250px"></asp:TextBox>--%>
                            <asp:PlaceHolder ID="phDDLCHKLiver" runat="server"></asp:PlaceHolder>
                            <asp:Label ID="lblCheckItems" Height="50%" Width="30%" runat="server" 
                                meta:resourcekey="lblCheckItemsResource1"></asp:Label>
                            <%--<asp:DropDownList ID="ddlLiver" runat="server">
                            </asp:DropDownList>--%>
                            <%--<asp:CheckBox ID="chkJaundice" Text="Jaundice" runat="server" />--%>
                        </td>
                    </tr>
                </table>
            </div>
        </td>
    </tr>
</table>
<asp:HiddenField ID="hidList" runat="server" />
<asp:HiddenField ID="hidList2" runat="server" />
<%--</div>
--%><%--</ContentTemplate>
</asp:UpdatePanel>--%>