//-------------------------
//*** GENERAL FUNCTIONS ***
//-------------------------
function CheckListBoxForDuplicates(inLB, inValue)
{
	var lngCTR = 0;
	var boolFound = false;
	while ((!boolFound) && (lngCTR < inLB.options.length))
	{
		boolFound = (inLB.options[lngCTR].value==inValue);
		lngCTR++;
	}

	return boolFound;
}

function OpenWindow(inURL, inName, inHeight, inWidth, inShowStatusBar, inShowToolbar, inShowLocation, inShowMenuBar, inShowScrollBars, inResizable)
{
	var strFeature = "height="+inHeight+",width="+inWidth+",status="+inShowStatusBar+",toolbar="+inShowToolbar+",location="+inShowLocation+",menubar="+inShowMenuBar+",scrollbars="+inShowScrollBars+",resizable="+inResizable;
	//alert(strFeature);
	return window.open(inURL, inName, strFeature);
}

function PromptFeatureComingSoon()
{
	alert('This featuer is under development & will be available soon. Sorry for the inconvenience.');
}

function Trim(inString)
{
	return inString.replace(/ /g, "");
}

//---------------------------
//*** LIST PAGE FUNCTIONS ***
//---------------------------
function ChangePage(inPage)
{
	document.forms['frmDataTable'].elements['htxtPage'].value=inPage;
	document.forms['frmDataTable'].submit();
}

function ConfirmDelete()
{
	return (window.confirm('Are you sure you want to delete the selected records?'))
}

function ExecuteButton(inAction)
{
	document.forms['frmDataTable'].action=inAction;
	document.forms['frmDataTable'].submit();
}

function SelectDeselectList(inForm, inSelect)
{
	for (i=0; i<inForm.elements.length; i++)
	{
		if ((inForm.elements[i].type=="checkbox") && (inForm.elements[i].name!="chkAll"))
		{
			inForm.elements[i].checked=inSelect;
			inForm.elements[i].onclick();
		}
	}
}

function SelectDeselectRow(inForm, inRow, inSelect)
{
	if (inSelect)
	{
		inRow.className = "DataTableRowSelected";
	}
	else
	{
		inForm.chkAll.checked=false;
		inRow.className = "DataTableRow";
	}
}

//-------------------------
//*** COMBOBOX FUNCTIONS ***
//-------------------------
function ClearComboBox(inCB)
{
	if (inCB.length > 0)
	{
		while (inCB.length > 0)
		{
			inCB.options[0]=null;
		}
	}
}

function InsertComboBoxItem(inCB, inValue, inCaption)
{
	inCB.options[inCB.options.length] = new Option(inCaption, inValue);
}

//-------------------------
//*** LISTBOX FUNCTIONS ***
//-------------------------
function MoveListBoxItem(inSourceLB, inDestinationLB, inIndex)
{
	var boolSelected = inSourceLB.options[inIndex].selected;
	inDestinationLB.options[inDestinationLB.length] = new Option(inSourceLB.options[inIndex].text, inSourceLB.options[inIndex].value);
	inDestinationLB.options[inDestinationLB.length-1].selected = boolSelected;
	inSourceLB.options[inIndex] = null;
}

function RemoveAllListBoxItems(inLB, inPromptFlag)
{
	if (inLB.length > 0)
	{
		var boolProceed = true;
		if (inPromptFlag)
		{
			boolProceed = window.confirm('Are you sure you want to remove all the items from the list?')
		}

		if (boolProceed)
		{
			while (inLB.length > 0)
			{
				inLB.options[0]=null;
			}
		}
	}
}

function RemoveListBoxItem(inLB, inIndex, inPromptFlag)
{
	var boolProceed = true;
	if (inPromptFlag)
	{
		boolProceed = window.confirm('Are you sure you want to remove the item from the list?')
	}

	if (boolProceed)
	{
		inLB.options[inIndex]=null;
	}
}

function RemoveSelectedListBoxItems(inLB, inPromptFlag)
{
	if (inLB.selectedIndex != -1)
	{
		var boolProceed = true;
		if (inPromptFlag)
		{
			boolProceed = window.confirm('Are you sure you want to remove the selected items from the list?')
		}

		if (boolProceed)
		{
			while (inLB.selectedIndex != -1)
			{
				inLB.options[inLB.selectedIndex]=null;
			}
		}
	}
}

function SelectAllListBoxItems(inLB, inSelectFlag)
{
	for (var i=0;i<inLB.length;i++)
	{
		inLB.options[i].selected=inSelectFlag;
	}
}

function SelectListBoxItem(inLB, inIndex, inSelectFlag)
{
	if (inLB.length > 0)
	{
		if (inIndex <= (inLB.length-1))
		{
			inLB.options[inIndex].selected=inSelectFlag;
		}
		else
		{
			inLB.options[inLB.length-1].selected=inSelectFlag;
		}
	}
}

function SwapListBoxItems(inLB, inSourceIndex, inDesitnationIndex)
{
	if ((inDesitnationIndex >= 0) && (inDesitnationIndex < inLB.length))
	{
		var strValue = inLB.options[inSourceIndex].value;
		var strText = inLB.options[inSourceIndex].text;
		var boolSelected = inLB.options[inSourceIndex].selected;
		inLB.options[inSourceIndex].value = inLB.options[inDesitnationIndex].value;
		inLB.options[inSourceIndex].text = inLB.options[inDesitnationIndex].text;
		inLB.options[inSourceIndex].selected = inLB.options[inDesitnationIndex].selected;
		inLB.options[inDesitnationIndex].value = strValue;
		inLB.options[inDesitnationIndex].text = strText;
		inLB.options[inDesitnationIndex].selected = boolSelected;
	}
}

//-------------------------
//*** TEXTBOX FUNCTIONS ***
//-------------------------
function ClearTextBox(inTB, inPromptFlag)
{
	if (inTB.value != "")
	{
		var boolProceed = true;
		if (inPromptFlag)
		{
			boolProceed = window.confirm('Are you sure?');
		}

		if (boolProceed)
		{
			inTB.value = "";
		}
	}
}

//----------------------------
//*** LAB TEST INFO WINDOW ***
//----------------------------
function OpenLabTestInfoWindow(inPage)
{
	if (inPage != "")
	{
		window.open(inPage, 'LabTestInfo', 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=0,resizable=0,width=830,height=600');
	}
}
