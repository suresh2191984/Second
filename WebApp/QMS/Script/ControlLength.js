

// SWS string-no-special-chars-with-space
//  SWTS string-no-special-chars-without-space
var keys = {
             "AnalyzerName": [50, 'NSWS'],
             "ProductCode": [50,'NSWTS'],
             "AnalyzerModel": [50, 'NSWS'],
             "AnalyzerThroughPut": [15,'number'],
             "AnalyteName": [255,'string'],
             "AnalyteDecimalPlaces":[5,'number'],
             "AnalyteCutOffTime":[5,'number'],
             "AssayCode":[20,'string'],
             "MobileNumber": [12,'number'],
             "ManufacturerName":[100,'NSWS'],
             "ManufacturerCode":[100,'NSWTS'],
             "EmailID":[200,'string'],
             "VendorName":[200,'NSWS'],
             "Vendorcode":[50,'NSWTS'],
             "PanNo":[20,'NSWTS'],
             "SPOCName": [100, 'NSWS'],
             "Landlineno":[12,'number'],
             "FaxNo":[15,'number'],
             "CityName": [100, 'NSWS'],
             "PostalCode":[10,'number'],
             "Address":[500,'string'],
//             "PermenentAddress":[1000,'string'],
             "Termsandconditions":[1600,'string'],
             "LotName":[100,'NSWS'],
             "LotCode":[100,'NSWTS'],
             "LotDescription": [100, 'NSWS'],
             "ManufacturerRefRange":[10,'string'],
             "ManufacturerMean": [10,'string'],
             "Run":[10,'string'],
             "LabRefRange": [20,'string'],
             "LabMean":[10,'string'],
             "LabSD":[10,'string'],
             "Description": [1000, 'string'],
             "Description-NoSC":[1000,'NSWS'],
             "EQAResultValue": [15, 'decimal-withMinus'],
             "Zscore":[30, 'decimal'],
             "Deviation":[50, 'decimal'],
             "Correction":[50, 'decimal'],
             "QCValue":[20,'decimal-withPlace'],
             "PlanScheduleID": [10, 'number'],
             "TotalMark":[10,'number'],
             "MarksObtained": [10, 'number'],
             "Remarks": [255, 'string'],
             "EventTypeCode": [10, 'NSWTS'],
             "AuditScope": [510, 'string'],
             "AuditCriteria": [255, 'string'],
             "Venue": [200, 'string'],
             "Topic": [510, 'string'],
             "Agenda": [510, 'string'],
             "EventName": [100, 'string'],
             "Trainer": [20, 'NSWTS'],
             "GuestMail": [20, 'NSWTS'],
             "PointsDiscussed": [255, 'string'],
             "ActionProposed": [255, 'string'],
             "Observation": [255, 'string'],
             "NABLClause": [60, 'string'],
             "ISOClause": [60, 'string'],
             "NCNO": [15, 'number'],
             "Description":[255, 'string'],
"Classification":[255, 'string'],
"ActivityAssesed":[255, 'string'],
"ProposedAction":[255, 'string'],
"ActionTaken":[255, 'string'],
"AuditAgency": [512, 'string'],
"MajorNC": [10, 'number'],
"MinorNC": [10, 'number'],
"AuditorsList": [512, 'string']




             
             

//             "Correction":1000,
//             "Correctiveaction":1000,
//             "PreventiveAction":1000,
//             "ActionTaken":1000,
//             "Comments":1000
             };

(function($) {

    function MaxLength(select, options) {
        this.$select = $(select);

    }


    MaxLength.prototype = {

};
$.fn.maxLength = function(option, parameter, extraOptions) {
    //    return this.each(function() {


    $(this).keypress(function() {
        var data = $(this).attr('Val-Key');
        var val = $(this).val();
        var maxlen = keys[data];
        if (val != null && val != '') {
            if (maxlen!=null && maxlen.length > 0) {
                if (val.length >= maxlen[0]) {
                    event.preventDefault();
                }
                if (maxlen.length > 1) {

                    dataType(maxlen[1], event, val, this);

                }

            }
        }
        else if (maxlen.length > 1) {

        dataType(maxlen[1], event, val, this);

        }


    });


}

function dataType(daType, e,val,ctrl) {

    switch (daType) {
        case "string":
            return true;

        case "NSWTS":
            var regex = new RegExp("^[a-zA-Z0-9]+$");
            var str = String.fromCharCode(!e.charCode ? e.which : e.charCode);
            if (regex.test(str)) {
                return true;
            }
            else {
                e.preventDefault();
                return false;
            }
        case "NSWS":
            var regex = new RegExp("^[a-zA-Z0-9- ]+$");
            var str = String.fromCharCode(!e.charCode ? e.which : e.charCode);
            if (regex.test(str)) {
                return true;
            }
            else {
                e.preventDefault();
                return false;
            }
        case "number":
            var regex = new RegExp("^[0-9]+$");
            var str = String.fromCharCode(!e.charCode ? e.which : e.charCode);
            if (regex.test(str)) {
                return true;
            }
            else {
                e.preventDefault();
                return false;
            }
            break;
        case "decimal":

            if ((e.which != 46) && (e.which < 48 || e.which > 57)) {
                e.preventDefault();
            }
            else if ((val== "" && e.which == 46) || (val.indexOf('.') != -1 && e.which == 46)) {
                e.preventDefault();
            }
            break;
        case "decimal-withPlace":

            if ((e.which != 46) && (e.which < 48 || e.which > 57)) {
                e.preventDefault();
            }
            else if ((val == "" && e.which == 46) || (val.indexOf('.') != -1 && e.which == 46)) {
                e.preventDefault();
            }

            break;
            
            case "decimal-withMinus":
                if ((e.which != 46) && (e.which != 45)  && (e.which < 48 || e.which > 57)) {
                    e.preventDefault();
                }
                else if ((val == "" && e.which == 46) || (val.indexOf('.') != -1 && e.which == 46) || (val.indexOf('-') != -1 && e.which == 45)) {
                    e.preventDefault();
                }
                break;
            

        default:
            return true;
    }

}
$.fn.maxLength.Constructor = MaxLength;

$(function() {
$("input[Val-Key]").maxLength();
$("textarea[Val-Key]").maxLength();

});


})(window.jQuery);