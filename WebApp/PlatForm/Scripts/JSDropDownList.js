function SetDropDownListTooltip(sender, AllowToolTip) { //, AllowToolTip
    
    if (AllowToolTip) {
        sender.title = sender.options[sender.selectedIndex].text;
    }

    //obj.title = obj.options[obj.selectedIndex].title;
}