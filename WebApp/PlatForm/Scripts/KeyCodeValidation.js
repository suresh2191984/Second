//Function to allow only alphabets + Other Language
function ValidateMultiLangCharacter(e) {
    var key = window.event ? e.keyCode : e.which;
    var text = String.fromCharCode(event.keyCode);
    var unicodeWord = RegExSelector();
    if (unicodeWord.test(text)) {
        return true;
    }
    else {
        return false;
    }
    return true;

}
//End

//Function to allow only alphabets + other Language and number and Special Character
function ValidateMultiLangChar(e) {
    var key = window.event ? e.keyCode : e.which;
    var text = String.fromCharCode(event.keyCode);
    var unicodeWord = RegExpSelector();
    if (unicodeWord.test(text)) {
        return true;
    }
    else {
        return false;
    }
    return true;

}
//end

//Function to allow only Number and Special Character
function ValidateSpecialAndNumeric(e) {
    var key = window.event ? e.keyCode : e.which;
    var text = String.fromCharCode(event.keyCode);
    var unicodeWord = RegExSpecialAndNumeric();
    if (unicodeWord.test(text)) {
        return true;
    }
    else {
        return false;
    }
    return true;

}
//End

//Function to allow only Numbers
function ValidateOnlyNumeric(e) {
    var key = window.event ? e.keyCode : e.which;
    var text = String.fromCharCode(event.keyCode);
    var unicodeWord = RegExOnlyNumeric();
    if (unicodeWord.test(text)) {
        return true;
    }
    else {
        return false;
    }
    return true;

}
//End


//Function to allow only alphabets + other Language and number and Special Character
function ValidateMultiLangCharAndSpecficChar(e) {
    var key = window.event ? e.keyCode : e.which;
    var text = String.fromCharCode(event.keyCode);
    var unicodeWord = RegexAlphaSpecialNumeric();
    if (unicodeWord.test(text)) {
        return true;
    }
    else {
        return false;
    }
    return true;

}
function RegexAlphaSpecialNumeric() {

    var unicodeWord;
    var LangCode = $('#Attuneheader_ddlLanguage').val();
    switch (LangCode) {
        case 'en-GB':
        case 'id-ID':
            unicodeWord = new XRegExp("[A-Za-z0-9\-/%\(\)]");
            break;
        case 'ta-IN':
            unicodeWord = new XRegExp("[A-Za-z\\p{Tamil}\s]");
            break;
        case 'ar-SA':
            unicodeWord = new XRegExp("[A-Za-z\\p{Arabic}\s]");
            break;
        case 'vi-VN':
            unicodeWord = new XRegExp("[A-Za-z \\p{Latin}\s]");
            break;
        case 'es-ES':
            unicodeWord = new XRegExp("[A-Za-z\\p{Hebrew}\\s]");
            break;
        case 'zh-CN':
            unicodeWord = new XRegExp("[A-Za-z\\p{Han}\\s]");
            break;
    }
    return unicodeWord;
    
}




function RegExSelector() {

    var unicodeWord;
    var LangCode = $('#Attuneheader_ddlLanguage').val();
    switch (LangCode) {
        case 'en-GB':
        case 'id-ID':
            unicodeWord = new XRegExp("[A-Za-z\\s]");
            break;
        case 'ta-IN':
            unicodeWord = new XRegExp("[A-Za-z\\p{Tamil}\s]");
            break;
        case 'ar-SA':
            unicodeWord = new XRegExp("[A-Za-z\\p{Arabic}\s]");
            break;
        case 'vi-VN':
            unicodeWord = new XRegExp("[A-Za-z\\p{Latin}\s\b]");
            break;
		case 'es-ES':
            unicodeWord = new XRegExp("[A-Za-z\\p{Hebrew}\\s]");
            break;	
		 case 'zh-CN':
            unicodeWord = new XRegExp("[A-Za-z\\p{Han}\\s]");
            break;
    }
    return unicodeWord;
}
function RegExpSelector() {

    var unicodeWord;
    var LangCode = $('#Attuneheader_ddlLanguage').val();
    switch (LangCode) {
        case 'en-GB':
        case 'id-ID':
	      unicodeWord = new XRegExp("[A-Za-z0-9\d\\p{Common}\s]");
            break;
		case 'es-ES':
            unicodeWord = new XRegExp("[A-Za-z0-9\d\\p{Hebrew}\\p{Common}\s]");
            break;
        case 'ta-IN':
            unicodeWord = new XRegExp("[A-Za-z0-9\d\\p{Tamil}\\p{Common}\s]");
            break;
        case 'ar-SA':
            unicodeWord = new XRegExp("[A-Za-z0-9\d\\p{Arabic}\\p{Common}\s]");
            break;
        case 'vi-VN':
            unicodeWord = new XRegExp("[A-Za-z0-9\d\\p{Latin}\\p{Common}\s]");
            break;
		 case 'zh-CN':
            unicodeWord = new XRegExp("[A-Za-z0-9\d\\p{Han}\\p{Common}\s]");
            break;
		
            
    }
    return unicodeWord;
}
function RegExSpecialAndNumeric() {

    var unicodeWord;
    var LangCode = $('#Attuneheader_ddlLanguage').val();
    switch (LangCode) {
        case 'en-GB':
        case 'id-ID':
	case 'ta-IN':
	case 'es-ES':
	case 'ar-SA':	
	case 'vi-VN':
    case 'id-ID':
	case 'zh-CN':
            unicodeWord = new XRegExp("[0-9\d\\p{Common}]");
            break;
        			
    }
    return unicodeWord;
}

function RegExOnlyNumeric() {

    var unicodeWord;
    var LangCode = $('#Attuneheader_ddlLanguage').val();
    switch (LangCode) {
        case 'en-GB':
        case 'id-ID':
	case 'ta-IN':
	case 'es-ES':
	case 'ar-SA':	
	case 'vi-VN':
	case 'zh-CN':
            unicodeWord = new XRegExp("[0-9]");
            break;
                     			
    }
    return unicodeWord;
}