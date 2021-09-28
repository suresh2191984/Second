<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Liver.ascx.cs" Inherits="HealthPackageControls_Liver" %>
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
      //debugger;
            document.getElementById("ucDynamic_ucLiver_divChkList").style.display = "block";
      }
      function showdivonClick2() {
      //debugger;
            var objDLL = document.getElementById("ucDynamic_ucLiver_divChkList");
            if (objDLL.style.display == "block")
                  objDLL.style.display = "none";
            else 
                  objDLL.style.display = "block";
      }
      function getSelectedItem(lstValue, lstNo, lstID, ctrlType) {
      //debugger;
            var noItemChecked = 0;
            var ddlReport = document.getElementById("ucDynamic_ucLiver_ddlChkList1");
            var selectedItems = "";
            var arr = document.getElementById("ucDynamic_ucLiver_chkLstItem").getElementsByTagName('input');
            var arrlbl = document.getElementById("ucDynamic_ucLiver_chkLstItem").getElementsByTagName('label');
            var objLstId = document.getElementById('ucDynamic_ucLiver_hidList');
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
            document.getElementById('ucDynamic_ucLiver_hidList').value = ddlReport.options[ddlReport.selectedIndex].text;
            document.getElementById('ucDynamic_ucLiver_lblCheckItems').innerText=selectedItems;
      }
//     document.onclick = check;   
//      function check(e) {
//            var target = (e && e.target) || (event && event.srcElement);
//            var obj = document.getElementById('ucDynamic_ucLiver_divChkList');
//            var obj1 = document.getElementById('ucDynamic_ucLiver_ddlChkList');
//            if (target.id != "alst" && !target.id.match("chkLstItem")) {
//                  if (!(target == obj || target == obj1)) {
//                        obj.style.display = 'none'
//                  }
//                  else if (target == obj || target == obj1) {
//                        if (obj.style.display == 'block') {
//                              obj.style.display = 'block';
//                        }
//                        else {
//                              obj.style.display = 'none';
//                              document.getElementById('ucDynamic_ucLiver_ddlChkList').blur();
//                        }
//                  }
//            }
//      }
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
                        <asp:Label ID="lblLiver_78" runat="server" Text="Liver Disease" Font-Bold="true"></asp:Label>
                    </td>
                    <td align="left" colspan="1">
                        <asp:RadioButton ID="rdoYes_78" Text="Yes" runat="server" GroupName="radioExtend"
                            onclick="javascript:showContentHis(this.id);" />
                        <asp:RadioButton ID="rdoNo_78" Text="No" runat="server" GroupName="radioExtend" onclick="javascript:showContentHis(this.id);" />
                        <asp:RadioButton ID="rdoUnknown_78" Text="Unknown" runat="server" GroupName="radioExtend"
                            onclick="javascript:showContentHis(this.id);" />
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
                            <%--                             <asp:TextBox ID="txtLiver_78" runat="server" Width="250px"></asp:TextBox>--%>
                            <asp:PlaceHolder ID="phDDLCHKLiver" runat="server"></asp:PlaceHolder>
                            <asp:Label ID="lblCheckItems" Height="50%" Width="30%" runat="server"></asp:Label>
                            <%--<asp:DropDownList ID="ddlLiver" runat="server">
                            </asp:DropDownList>--%>
                            <asp:CheckBox ID="chkJaundice" Text="Jaundice" runat="server" />
                        </td>
                    </tr>
                </table>
            </div>
        </td>
    </tr>
</table>
<asp:HiddenField ID="hidList" runat="server" />
<%--</div>
--%><%--</ContentTemplate>
</asp:UpdatePanel>--%>