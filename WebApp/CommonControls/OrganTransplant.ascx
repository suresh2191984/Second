<%@ Control Language="C#" AutoEventWireup="true" CodeFile="OrganTransplant.ascx.cs"
    Inherits="CommonControls_OrganTransplant" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="AutoCom" %>
<script language="javascript" type="text/javascript">
      function showdiv() {
            document.getElementById("ucDynamic_ucOrganTransplant_divChkList").style.display = "block";
      }
      function showdivonClick() {
            var objDLL = document.getElementById("ucDynamic_ucOrganTransplant_divChkList");
            if (objDLL.style.display == "block")
                  objDLL.style.display = "none";
            else 
                  objDLL.style.display = "block";
      }
      function getSelectedItem(lstValue, lstNo, lstID, ctrlType) {
            var noItemChecked = 0;
            var ddlReport = document.getElementById("ucDynamic_ucOrganTransplant_ddlChkList");
            var selectedItems = "";
            var arr = document.getElementById("ucDynamic_ucOrganTransplant_chkLstItem").getElementsByTagName('input');
            var arrlbl = document.getElementById("ucDynamic_ucOrganTransplant_chkLstItem").getElementsByTagName('label');
            var objLstId = document.getElementById('ucDynamic_ucOrganTransplant_hidList');
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
            document.getElementById('ucDynamic_ucOrganTransplant_hidList').value = ddlReport.options[ddlReport.selectedIndex].text;
            document.getElementById('ucDynamic_ucOrganTransplant_lblCheckItems').innerText=selectedItems;
            if(selectedItems.search("Organ Transplant"))
            {
                  document.getElementById('ucDynamic_ucOrganTransplant_divOrgan').style.display='block';
            }
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
    <tr class="defaultfontcolor" id="trSurgicalHistory" runat="server" style="display: block;">
        <td colspan="2">
            <table cellpadding="0">
                <tr>
                    <td style="width: 200px">
                        <asp:Label ID="lblSurgicalHistory_966" runat="server" Text="Surgical History" Font-Bold="true"></asp:Label>
                    </td>
                    <td align="left" colspan="1">
                        <asp:RadioButton ID="rdoYes_966" Text="Yes" runat="server" GroupName="radioExtend"
                            onclick="javascript:showContentHis(this.id);" />
                        <asp:RadioButton ID="rdoNo_966" Text="No" runat="server" GroupName="radioExtend" onclick="javascript:showContentHis(this.id);" />
                        <asp:RadioButton ID="rdoUnknown_966" Text="Unknown" runat="server" GroupName="radioExtend"
                            onclick="javascript:showContentHis(this.id);" />
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td>
            <div id="divrdoYes_966" runat="server" style="display: none">
                <table cellpadding="0" align="right" width="100%">
                    <tr>
                        <td>
                            <asp:PlaceHolder ID="phDDLCHK" runat="server"></asp:PlaceHolder>
                            <asp:Label ID="lblCheckItems" Height="50%" Width="30%" runat="server"></asp:Label>
                        </td>
                        <td>
                           <div id="divOrgan" runat="server" style="display:none">
                            <asp:Label ID="lblOrgan" runat="server" Text="Organ Transplanted"></asp:Label>
                            <asp:DropDownList ID="ddlOrganTransplant" runat="server"></asp:DropDownList>
                           </div>
                        </td>
                    </tr>
                </table>
            </div>
        </td>
    </tr>
    <tr>
    </tr>
</table>
<asp:HiddenField ID="hidList" runat="server" />