

function ReadGvInvDevicesRowData() {
    if ($.trim($("#ddlConsumptionType option:selected").val()) == "0") {
        ValidationWindow('Please Select Consumption Type.', 'Alert');
        return false;
    }
    
      $('#hdnInvDevicesData').val('');
      var lstInvDevices = [];

      $('[id$="gvInvestigationDevices"] tbody tr').each(function(i, n) {
          var currentRow = $(n);
          var tdInvID = $.trim(currentRow.find("input[id$='hdnInvetigationID']").val());
          var tdNoOfTimes = $.trim(currentRow.find("input[id$='txtNoOfTimes']").val());
          var tdConsumptionType = $.trim($("#ddlConsumptionType option:selected").text());
          var ddlDeviceID = $.trim($("#ddlAnalyzerName option:selected").val());
          //$('#ddlConsumptionType').c();
          var tdtxtDate = $.trim($('#txtDate').val());

          if (tdNoOfTimes == '') {
              tdNoOfTimes = "0";
          }

          if ($.isNumeric(tdInvID) == true) {
              if (parseInt(tdNoOfTimes) > 0) {
                  lstInvDevices.push({
                      InvestigationID: tdInvID,
                      DeviceID: ddlDeviceID,
                      ConsumptionType: tdConsumptionType,
                      ConsumptionCount: tdNoOfTimes,
                      TestDate: ToInternalDateTime(tdtxtDate) 
                  });
              }
          }
      });

      if (lstInvDevices.length > 0) {
          $('[id$="hdnInvDevicesData"]').val(JSON.stringify(lstInvDevices));
      }
      else {
          ValidationWindow('No matching records found.', 'Alert');
          return false;
      }
      //alert($('#hdnInvDevicesData').val());
}

 function ApplyNoOfTimes() {

            var NoOFtimes = $('#txtNoOfTimes').val();            

            $('[id$="gvInvestigationDevices"] tbody tr').each(function(i, n) {
                var currentRow = $(n);
                currentRow.find("input[id$='txtNoOfTimes']").val(NoOFtimes);

            });
  return false;
}

function fun_searchTable(tableID,searchControlID ) {
    inputVal = $(searchControlID).val();
    var table = $(tableID);
    
    table.find('tr').each(function(index, row) {
        var allCells = $(row).find('td');
        if (allCells.length > 0) {
            var found = false;
            allCells.each(function(index, td) {
                var regExp = new RegExp(inputVal, 'i');
                if (regExp.test($(td).text())) {
                    found = true;
                    return false;
                }
            });
            if (found == true) $(row).show(); else $(row).hide();
        }
    });
    return false;
}

