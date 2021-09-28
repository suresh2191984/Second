
var SelectedCheckBox = [];

function BindAutocomplete(CTRL, URL, Prefix, txtSamColPersonid) {
    var SelectedID;

    var Resultdata = [];
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: URL,
        data: JSON.stringify({ Prefix: Prefix }),
        dataType: "json",
        async: false,
        success: function(data) {
            $(txtSamColPersonid).val('-1');
            val = data.d;
            var len = data.d.length;
            $.each(val, function(i, Zon) {
                var obj = new Object();
                var value = Zon.Name;
                var id = Zon.UserID;
                obj = { "value": value, "id": id };
                Resultdata.push(obj);

            });
            var availableTags = [
                { "value": "Some Name", "id": 1 }, { "value": "Some Othername", "id": 2}];
            var test = [];

            $('#' + CTRL).autocomplete({
                source: Resultdata, //JSON.stringify(data.d) //
                select: function(event, ui) {
                    $(txtSamColPersonid).val(ui.item.id);
                    //  $(txtSamColPersonid).text(ui.item.id);
                    //                //    $('#' + CTRL).val(ui.value);
                },
                minLength: 2,
                max: 6
            });
        }




    });


}


function CollectionPersonApplyALL() {

//    if (SelectedCheckBox.length > 0) {
//        $.ajax({
//            type: "POST",
//            contentType: "application/json; charset=utf-8",
//            url: "SampleScheduling.aspx/UpdateSampeleCollected",
//            data: JSON.stringify({ SelectedCheckBox: SelectedCheckBox ,CollectionPerson:lblSampleColPersonVal.textContent}),
//            dataType: "json",
//            async: false,
//            success: function(data) {
//                

//                
//            }




//        });


    }






function GridCheckBox(id) {

    document.getElementById("hdnCheckBoxList").value = 0;

   
    if (this.event.srcElement.checked) 
        SelectedCheckBox.push(id);
    
    else
        SelectedCheckBox.pop(id);



    document.getElementById("hdnAssignCollPerson").value = lblSampleColPersonVal.textContent.toString();
    document.getElementById("hdnCheckBoxList").value = SelectedCheckBox.toString();
}


function SampColPersonBlur(hdn, lbl) {
    $(hdn).val(lbl.innerText);
   
}

function ClearTempCheckList() {
    lblSampleColPersonVal.textContent=0;
    SelectedCheckBox = [];
}

function SearchCollectionPerson() {
    document.getElementById('hdnSampleColPersonValSearch').value = lblSampleColPersonValSearch

}






   
    
    