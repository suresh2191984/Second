var etxt = '<div class="form-group field-options">\
<label class="false-label">Options</label>\
<div class="sortable-options-wrap">\
<ol class="sortable-options ui-sortable">\
   </ol>\
   <div class="option-actions"><a class="add add-opt" onclick="AddOptions(this);">Add Option +</a>\
   </div></div></div>';
   
  var ehtext='<div class="form-group subtype-wrap">\
<label >Type</label>\
<div class="input-wrap">\
<select class="fld-subtype form-control"><option  value="h1">h1</option><option value="h2">h2</option><option  value="h3">h3</option></select></div></div>';

var ControlsArray = {
"input": [{ 'html': '<input control-type="input" class="form-control ctrlInput" type="text" value="" />'}],
"select": [{ 'html': '<select control-type="select" class="form-control ctrlSelect"><option value="option1">option1</option> <option value="option2">option2</option><option value="option3">option3</option> </select>', 'editText': etxt },
  { 'options': 'option 1'}],
  "textarea": [{ 'html': '<textarea control-type="textarea" class="form-control" rows="3"></textarea>'}],
  "radio-group":[{'html':'<div class="fb-radio-group form-group field-radio-group-1522306862240-preview">\
<div control-type="radio-group"  class="radio-group"><div class="radio" onclick="SetRadio(this);"><input  class=""  value="option-1" type="radio">\
<label >Option 1</label></div><div class="radio" onclick="SetRadio(this);">\
<input  class=""  value="option-2" type="radio">\
<label >Option 2</label></div><div class="radio" onclick="SetRadio(this);">\
<input class=""  value="option-3" type="radio">\
<label >Option 3</label></div></div></div>', 'editText': etxt}],
        "header": [{ 'html': '1', 'editText': ehtext}],
        "number": [{ 'html': '<input control-type="number" onkeypress="onlynumbers(event);" class="form-control ctrlInput" type="text" value="" />', 'editText;]': ''}],
        "NwithUnits": [{ 'html': '<input control-type="NwithUnits" onkeypress="onlynumbers(event);" class="form-control ctrlInput NwithUnits" type="text" value="" ><select control-type="select"  class="form-control NwithUnits" ><option value="option-1">option1</option><option value="option-2">option2</option></select>', 'editText;]': etxt}]
    }

