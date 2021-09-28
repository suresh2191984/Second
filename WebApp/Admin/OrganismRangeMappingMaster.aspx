<%@ Page Language="C#" AutoEventWireup="true" CodeFile="OrganismRangeMappingMaster.aspx.cs"
    Inherits="Admin_OrganismRangeMappingMaster" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .div1
        {
            display: block;
            padding: 2px;
            margin-bottom: 55px; /* SIMPLY SET THIS PROPERTY AS MUCH AS YOU WANT. This changes the space below div1 */
            text-align: justify;
        }
    </style>
    <link href="../Scripts/DataTable/css/cdn.JQuery.datatables.min.css" rel="stylesheet"
        type="text/css" />

    <script type="text/javascript" language="javascript" src="../Scripts/jQuery-3.4.1.min.js"></script>

    <script type="text/javascript">
    var lstOrganismDrugsNameList=[];
    
    $(document).ready(function(){
    LoadOrganismNames();

  });
    function LoadOrganismNames() {
            var OrgID = $('input:hidden[name=hdnOrgID]').val();
        
            //alert(OrgID);
           $.ajax({
                type: "POST",
                url: "../WebService.asmx/GetOrganismNames",
                data: "{'OrgID':" + OrgID + "}",
                contentType: "application/json; charset=utf-8",
                dataType:"json",
                success: function success(data) { 
                var oData=data.d;
                if(oData!='')
                {
                $("#ddlorganismNameList").html("<option value='0'> Select </option>");
                 for (var i = 0; i < oData.length; i++) {
                        //var opt = new Option(oData[i].Name);
                        var opt='<option value='+oData[i].ID+'>'+oData[i].Name + '</option>';
                        $("#ddlorganismNameList").append(opt);
                    }
                }
                   
                },
                error: function(xhr, ajaxOptions, thrownError) {
                        alert("Error in GetOrganismNames Web Method Calling");  
                        return false;
                    }
            }); 
        } 
     
        function GetOrganismDetails(organismID){
        try {
        //alert( $(organismID).val());
              var OrganismSelectedID = $(organismID).val();
              var InvestigationID = 0;
              var organismCode = "";
              var type = "";
            $.ajax({
                type: "POST",
                url: "../WebService.asmx/GetOrganismDrugDetails",
               data: "{invID: " + InvestigationID + ", organismID:" + OrganismSelectedID + ", organismCode:'" + organismCode + "', type:'" + type + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success:AjaxGetOrganismDrugListSucceeded,   
                error: function(xhr, ajaxOptions, thrownError) {
                $('#divOrganismNamelist').hide();
                $('#tblOrganismDrugNameList').hide();
                alert("Error in GetOrganismDrugDetails Web Method Calling");  
                        return false;
                }
            });
        }
        catch (e) {
        $('#divOrganismNamelist').hide();
        $('#tblOrganismDrugNameList').hide();
            return false;
        }
        } 
        
        function AjaxGetOrganismDrugListSucceeded(result)
        {
        try
        {  
        lstOrganismDrugsNameList=[];
        $('#tblOrganismDrugNameList').DataTable( {
         createdRow: function (row, data, dataIndex) {
            $($(row).find('td')[1]).attr('Cname','Susceptibility');
            $($(row).find('td')[2]).attr('Cname','Intermediate')
            $($(row).find('td')[3]).attr('Cname','Resistant')
        },
        data: result.d,
        destroy: true,
        columns: [
         { data: 'DrugName' },
         { data: 'Susceptibility',
           className: "editbox"
//           ,
//         "render": function ( data, type, row, meta ) {
//         if(data !=null && data !=''){
//         return data;
//         }
//         else{
//         return '<input type="text" class="" id="'+row.DrugID+'" value="'+data+'">';
//         }
//        
//          }
         },
        { data: 'Intermediate',
        className: "editbox"
//        ,
//         "render": function ( data, type, row, meta ) {
//         if(data !=null && data !=''){
//         return data;
//         }
//         else{
//         return '<input type="text" class="" id="'+row.DrugID+'" value="'+data+'">';
//         }
//        
//       }
        },
        
        { data: 'Resistant',
        className: "editbox"
//        ,
//         "render": function ( data, type, row, meta ) {
//         if(data !=null && data !=''){
//         return data;
//         }
//         else{
//         return '<input type="text" class="" id="'+row.DrugID+'" value="'+data+'">';
//         }
//        
//         }
          },
           { data: 'DrugName',
         "render": function ( data, type, row, meta ) {
        
         return '<label DrugID="'+row.DrugID+'" style ="text-decoration:underline;cursor:pointer;color:blue;" for="edit" AType="edit" onClick="onEditClick(this);" >Edit</label>'+' '+'<label DrugID="'+row.DrugID+'" AType="delete" style ="text-decoration:underline;cursor:pointer;color:blue; display:none;" for="delete" onClick="onEditClick(this);">Delete</label>';
         
        
            
             }
           }
        ],
       dom: 'Bfrtip',
        buttons: [
            {
                extend: 'copyHtml5',
                exportOptions: {
                    columns: [ 0, 1, 2, 3 ]
                }
            },
            {
                extend: 'excelHtml5',
                exportOptions: {
                    columns: [ 0,1,2,3 ]
                }
            },
            {
                extend: 'pdfHtml5', 
                exportOptions: { 
                    columns: [ 0, 1, 2, 3 ] 
                }
            }
        ]
        });  
        $('#divOrganismNamelist').show(); 
        $('#btnSaveData').show();
        }
     catch(e){}
        }
        
        function onEditClick(ctrl)
        { 
            var obj={};
            obj.DrugID=$(ctrl).attr('DrugID');
            var $trow =$(ctrl).closest('tr');
            var Atype=$(ctrl).attr('AType');
            if (Atype=='delete')
            { 
            obj.Atype="D";
            SetLstValues(obj);
            $('#tblOrganismDrugNameList').dataTable().fnDeleteRow($trow);
            }
            else{
                if(Atype=='edit' )
                {
                 $(ctrl.nextElementSibling).show();
                $(ctrl.nextElementSibling).text('Update');
                $(ctrl.nextElementSibling).attr('AType','update');
                $(ctrl).text('Cancel');
                $(ctrl).attr('AType','cancel');
                }
                if(Atype=='cancel')
                { 
                  //$(ctrl.nextElementSibling).text('Delete'); 
                  $(ctrl.nextElementSibling).text('');
                  //$(ctrl.nextElementSibling).attr('AType','delete');
                  $(ctrl).text('Edit');
                  $(ctrl).attr('AType','edit');
                }
                else if(  Atype=='update')
                { 
                  $(ctrl.previousElementSibling).text('Edit');
                $(ctrl.previousElementSibling).attr('AType','edit');
                //$(ctrl).text('Delete');
                $(ctrl).text('');  
               // $(ctrl).attr('AType','delete');
                }
        
        var isUpdate=0;
        $.each($trow.find('.editbox'),function(id,val)
        {
             if($(val).find('input').length ==0 && Atype=='edit')
             {
               $(val).attr('OValue',$(val).text());
               tbox='<input type="text" maxlength="5" value="'+$(val).text()+'">';
               $(val).html(tbox);
             }
             else if($(val).find('input').length ==1 && Atype=='update')
             {
                
               obj[$(val).attr('Cname')]=$($(val).find('input')[0]).val();
               obj.Atype='U';
                if ($(val).attr('OValue')== $($(val).find('input')[0]).val())
                  isUpdate++;
                  
              $(val).html($($(val).find('input')[0]).val());
                 
             }
             else if (Atype=='cancel')
             {
             $(val).html( $(val).attr('OValue')); 
             }
        
        });
        if(isUpdate < 3 &&  Atype=='update')
        SetLstValues(obj);
          }
        }
        
        function SetLstValues(obj)
        {
          array=$.grep(lstOrganismDrugsNameList, function(val) {
          return (val.DrugID==obj.DrugID );
          });
          if (array.length >  0)
          {
          $.each(lstOrganismDrugsNameList,function(id,val){
          if(val.DrugID==obj.DrugID)
          {
          lstOrganismDrugsNameList[id].Susceptibility=obj.Susceptibility;
          lstOrganismDrugsNameList[id].Intermediate=obj.Intermediate;
          lstOrganismDrugsNameList[id].Resistant=obj.Resistant;
          lstOrganismDrugsNameList[id].Atype=obj.Atype; 
          }
          });
          
          }
          else
          lstOrganismDrugsNameList.push(obj);
        }
        
        function SaveData()
        {
        var lstOrganismDrugsRangeValues = [];
        lstOrganismDrugsRangeValues = lstOrganismDrugsNameList;
        if(lstOrganismDrugsRangeValues.length > 0)
        {
        var lst="{'lstOrganismDrugsRangeValues':'" + lstOrganismDrugsRangeValues + "'}";
            $.ajax({
                    type: "POST",
                    url: "../WebService.asmx/SaveOrganismRangeValues",
                    data: JSON.stringify({lstOrganismDrugsRangeValues:lstOrganismDrugsRangeValues}),//"{'lstOrganismDrugsRangeValues':'" + lstOrganismDrugsRangeValues + "'}",
                    dataType: "json",
                    contentType: "application/json; charset=utf-8", 
                    success: function Success(data){ 
                    //alert("Saved Successfully.");
                    },
                    error: function(xhr, ajaxOptions, thrownError) { 
                        alert("Error while Save SaveOrganismRangeValues.");  
                        return false;
                    }
            });
            alert("Saved Successfully.");
          }
          else{
          alert('No changes were found!.');
          return false;
          }
        } 
    
    </script>

</head>
<body>
    <form id="ivgdrug" runat="server">
    <asp:ScriptManager ID="scriptmanager1" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
        <div id="divOrganismName" class="div1 m-auto">
            <table class="w-50p m-auto">
                <tr>
                    <td class="h-20" style="font-weight: normal;">
                        <asp:Label ID="lblorganismName" runat="server" Text="Organism Name"></asp:Label>
                    </td>
                    <td class="h-20" style="font-weight: normal;">
                        <asp:DropDownList ID="ddlorganismNameList" runat="server" CssClass="ddlsmall" onChange="GetOrganismDetails(this)">
                        </asp:DropDownList>
                    </td>
                    <%--<td class="h-20 w-30p" style="font-weight: normal;">
                        <asp:Button ID="btnload" runat="server" Text="Load" />
                    </td>--%>
                </tr>
            </table>
        </div>
        <div>
        </div>
        <div id="divOrganismNamelist" runat="server" class="w-80p m-auto" style="display: none;">
            <table id="tblOrganismDrugNameList" class="w-80p cell-border">
                <thead align="center">
                    <tr class="w-80p">
                        <th>
                            Antibiotic
                        </th>
                        <th colspan="3">
                            breakpoints
                        </th>
                        <th>
                            action
                        </th>
                    </tr>
                    <tr>
                        <td>
                        </td>
                        <td>
                            Susceptibility (S)
                        </td>
                        <td>
                            Intermediate (I)
                        </td>
                        <td>
                            Resistant (R)
                        </td>
                        <td>
                        </td>
                    </tr>
                </thead>
                <tbody>
                </tbody>
            </table> 
        </div>
        <div id="btndiv" align="center">
            <table>
                <tr>
                    <td>
                        <asp:Button ID="btnSaveData" CssClas="btn" Style="display: none;" runat="server"
                            Text="Save" OnClientClick=" return SaveData();" />
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    <asp:HiddenField ID="hdnOrgID" runat="server" />
    </form>
    <%-- <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.js"></script> 
    <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/buttons/1.6.0/js/dataTables.buttons.min.js"></script> 
    <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/buttons/1.6.0/js/buttons.flash.min.js"></script> 
    <script type="text/javascript" charset="utf8" src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script> 
    <script type="text/javascript" charset="utf8" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/pdfmake.min.js"></script> 
    <script type="text/javascript" charset="utf8" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/vfs_fonts.js"></script> 
    <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/buttons/1.6.0/js/buttons.html5.min.js"></script> 
    <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/buttons/1.6.0/js/buttons.print.min.js"></script>--%>
 

    <script src="../Scripts/Jquery-1.10.19.datatable.min.js" type="text/javascript"></script>

    <script src="../Scripts/1.5.6.buttons.min.js" type="text/javascript"></script>

    <script src="../Scripts/1.5.6.buttonHtml5.min.js" type="text/javascript"></script>

    <script src="../Scripts/1.5.6.buttons.print.min.js" type="text/javascript"></script>

    <script src="../Scripts/0.1.53.pdfmake.min.js" type="text/javascript"></script>

    <script src="../Scripts/0.1.53.vfs_fonts.js" type="text/javascript"></script>

    <script src="../Scripts/3.1.3-JSZip.min.js" type="text/javascript"></script>

</body>
</html>
