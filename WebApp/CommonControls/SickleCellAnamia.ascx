<%@ Control Language="C#" AutoEventWireup="true" CodeFile="SickleCellAnamia.ascx.cs"
    Inherits="CommonControls_SickleCellAnamia" %>
<%--<%@ Register Src="EditEMR.ascx" TagName="EMR" TagPrefix="uc8" %>
--%>

<script type="text/javascript">
   function showdiv1() {
            document.getElementById("ucDynamic_ucSickleCellAnamia_divChkList").style.display = "block";
      }
      function showdivonClick1() {
            var objDLL = document.getElementById("ucDynamic_ucSickleCellAnamia_divChkList");
            if (objDLL.style.display == "block")
                  objDLL.style.display = "none";
            else 
                  objDLL.style.display = "block";
      }
      function getSelectedItem1(lstValue, lstNo, lstID, ctrlType) {
            var noItemChecked = 0;
            var ddlReport = document.getElementById("ucDynamic_ucSickleCellAnamia_ddlChkList");
            var selectedItems = "";
            var arr = document.getElementById("ucDynamic_ucSickleCellAnamia_chkLstItem").getElementsByTagName('input');
            var arrlbl = document.getElementById("ucDynamic_ucSickleCellAnamia_chkLstItem").getElementsByTagName('label');
            var objLstId = document.getElementById('ucDynamic_ucSickleCellAnamia_hidListAnaemia');
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
            document.getElementById('ucDynamic_ucSickleCellAnamia_hidListAnaemia').value = ddlReport.options[ddlReport.selectedIndex].text;
            document.getElementById('ucDynamic_ucSickleCellAnamia_lblCheckItemsAnaemia').innerText=selectedItems;
      }
     document.onclick = check1;   
      function check1(e) {
            var target = (e && e.target) || (event && event.srcElement);
            var obj = document.getElementById('ucDynamic_ucSickleCellAnamia_divChkList');
            var obj1 = document.getElementById('ucDynamic_ucSickleCellAnamia_ddlChkList');
            var obj2 = document.getElementById('ucDynamic_ucLiver_divChkList');
            var obj3 = document.getElementById('ucDynamic_ucLiver_ddlChkList');
            var obj4 = document.getElementById('ucDynamic_ucParasiticInfections_divChkList');
            var obj5 = document.getElementById('ucDynamic_ucParasiticInfections_ddlChkList');
            var obj6 = document.getElementById('ucDynamic_ucHumanPituitaryHormone_divChkList');
            var obj7 = document.getElementById('ucDynamic_ucHumanPituitaryHormone_ddlChkList');
            if (target.id != "alst" && !target.id.match("chkLstItem")) {
                  if (!(target == obj || target == obj1 || target == obj2 || target == obj3|| target == obj4|| target == obj5|| target == obj6|| target == obj7)) {
                        obj.style.display = 'none';
                        obj2.style.display='none';
                        obj4.style.display='none';
                        obj6.style.display='none';
                  }
                  else if (target == obj || target == obj1 || target == obj2 || target == obj3|| target == obj4|| target == obj5|| target == obj6|| target == obj7) {
                        if (obj.style.display == 'block') {
                              obj.style.display = 'block';
                        }
                        else {
                              obj.style.display = 'none';
                              document.getElementById('ucDynamic_ucSickleCellAnamia_ddlChkList').blur();
                              document.getElementById('ucDynamic_ucLiver_ddlChkList1').blur();
                              document.getElementById('ucDynamic_ucParasiticInfections_ddlChkList').blur();
                              document.getElementById('ucDynamic_ucHumanPituitaryHormone_ddlChkList').blur();
                        }
                  }
            }
      }
</script>

<table cellpadding="0" width="100%">
    <tr class="defaultfontcolor" id="trSickleCellAnamia" runat="server" style="display: block;">
        <td colspan="2">
            <table cellpadding="0" width="100%">
                <tr>
                    <td style="width:200px">
                        <asp:Label ID="lblSickleCellAnamia_465" Width="30px" runat="server" Text="Anaemia" Font-Bold="true"></asp:Label>
                    </td>
                    <td align="left" colspan="1">
                        <asp:RadioButton ID="rdoYes_465" Text="Yes" runat="server" GroupName="radioExtend"
                            onclick="javascript:showContentHis(this.id);" />
                        <asp:RadioButton ID="rdoNo_465" Text="No" runat="server" GroupName="radioExtend"
                            onclick="javascript:showContentHis(this.id);" />
                        <asp:RadioButton ID="rdoUnknown_465" Text="Unknown" runat="server" GroupName="radioExtend"
                            onclick="javascript:showContentHis(this.id);" />
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td colspan="2">
            <div id="divrdoYes_465" runat="server" style="display: none">
                <table cellpadding="0" align="center" width="100%">
                    <tr>
                        <td>
                        <asp:PlaceHolder ID="phDDLCHKAnaemia" runat="server"></asp:PlaceHolder>
                        <asp:Label ID="lblCheckItemsAnaemia" Height="50%" Width="30%" runat="server"></asp:Label>
                            <%--<asp:DropDownList ID="ddlAnaemia" runat="server">
                            </asp:DropDownList>--%>
                        </td>
                        <td>
                            &nbsp;&nbsp;
                            <asp:Label ID="lblType" Text="Type" runat="server"></asp:Label>
                            <asp:DropDownList ID="ddlType_465" runat="server" onchange="javascript:showOthersBoxHis(this.id);">
                            </asp:DropDownList>
                        </td>
                        <td>
                            <div id="divddlType_465" runat="server" style="display: none">
                                <asp:TextBox ID="txtothers_465" runat="server" meta:resourcekey="txtothers_465Resource1"></asp:TextBox>
                            </div>
                        </td>
                    </tr>
                </table>
            </div>
        </td>
    </tr>
</table>
<asp:HiddenField ID="hidListAnaemia" runat="server" />