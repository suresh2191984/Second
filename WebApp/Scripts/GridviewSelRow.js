var SelectedRow = null;
var SelectedRowIndex = null;
var UpperBound = null;
var LowerBound = null;

window.onload = function() {
UpperBound = parseInt(document.getElementById('hdnRowCount').value) - 1;
LowerBound = 0;
SelectedRowIndex = -1;
}

function SelectRow(CurrentRow, RowIndex) {
if (SelectedRow == CurrentRow || RowIndex > UpperBound || RowIndex < LowerBound)
    return;

if (SelectedRow != null) {
    SelectedRow.style.backgroundColor = SelectedRow.originalBackgroundColor;
    SelectedRow.style.color = SelectedRow.originalForeColor;
}

if (CurrentRow != null) {
    CurrentRow.originalBackgroundColor = CurrentRow.style.backgroundColor;
    CurrentRow.originalForeColor = CurrentRow.style.color;
    CurrentRow.style.backgroundColor = '#DCFC5C';
    CurrentRow.style.color = 'Black';
//                CurrentRow.style.font-weight = 'bold';
}

SelectedRow = CurrentRow;
SelectedRowIndex = RowIndex;
setTimeout("SelectedRow.focus();", 0);
}

function SelectSibling(e) {
var e = e ? e : window.event;
var KeyCode = e.which ? e.which : e.keyCode;

if (KeyCode == 40)
    SelectRow(SelectedRow.nextSibling, SelectedRowIndex + 1);
else if (KeyCode == 38)
    SelectRow(SelectedRow.previousSibling, SelectedRowIndex - 1);

return false;
}
