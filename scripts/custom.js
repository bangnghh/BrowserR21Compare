/** 
 * @fileoverview Deals with all of the client specific javascript functions
 *
 */

/**
 * This function should be used to run client specific code for enquiries
 * @return {void}
 */
function runEnquiryRequest()
{
	// get the 'generalForm' reference, adjusting for Fragment name as necessary
	var enqselForm = FragmentUtil.getForm("enqsel");

	//This is where the client specific style sheet is set
	enqselForm.clientStyleSheet.value = "/transforms/custom/clientEnquiry.xsl";
	retrieveEnquiryData();
}

function showFragmentError(fragment)
{
fragment.populateWithString("<div style='color:black'>There is a problem with the system. Please contact the System Administrator</div>");
}

/**
 * This function should be used to set the SessionExpiryMessage
 */
  function setSessionExpiryMsg(graceSeconds)
{
  var sessionExpiryMsg = "Session will expire in approximately "+ graceSeconds +" seconds."+
                  "\nHit OK if you want to maintain this session"+
                  "\n\n(If you cancel, or do not respond within "+ graceSeconds +" seconds."+
                  " you will be redirected to the log in page)";
	return sessionExpiryMsg;
}

/**
 * This is the routine that should be called when retrieving contract information
 * from the server for a specific contract
 * @return {void}
 */
function runContractRequest()
{
	//This is where the client specific style sheet is set

	// get the 'appreq' form reference, adjusting for Fragment name as necessary
	var appreqForm = FragmentUtil.getForm(currentForm_GLOBAL);
	appreqForm.clientStyleSheet.value = "/transforms/custom/clientContract.xsl";

	retrieveContractData();
}

/**
 * A function to demonstrate passing in arguments...
 * @param {String} arg1 The first argument
 * @param {String} arg2 The second argument
 * @return {void}
 */
function test(arg1,arg2)
{
alert(arg1+' '+ arg2);
}


/**
 * This is an example function that can be used to process the result of a question
 * raised from a web validate request
 * @return {void}
 */
function checkAnswer( field, answer )
{
	// What button was selected on the dialog box ?
	if (answer == true)
	{
		// They selected the Yes button ...
	}
	else
	{
		// They selected the Cancel button
	}
}

/**
 * Run a preview version..
 * @param {String} arg1 The first argument
 * @param {String} arg2 The second argument
 * @return {void}
 */
function prevVersion(arg1,arg2)
{
	var transId  = "";
	var applName = getFormField( currentForm_GLOBAL, 'application' );
	var appValue = applName.value;
        var verName  = getFormField( currentForm_GLOBAL, 'version' );
        var verValue = verName.value;
        var lockInfo = getFormField( currentForm_GLOBAL, 'lockDateTime' );
        var lockValue = lockInfo.value;
        if(lockValue == "")
             {
        	var verFunc = "S" ;
        }
       else
	{
		var verFunc = "I";
		}
	
        	
     	var fieldId  = getFormField( currentForm_GLOBAL, 'transactionId' );
	var transId  = fieldId.value;
        var verIndex = verValue.substring(verValue.length - 4, verValue.length -1 );
        var browser = navigator.appName.substring ( 0, 9 );
        
        if( verIndex == '.AS')
           {
             var asCnt    =  verValue.substring(verValue.length - 1, verValue.length);
             if (asCnt == 1)
                {
                	prevVer = verValue.substring(0, verValue.length - 4);
                }
        else
        	{
        		
            	  var asNewCnt =  asCnt - 1;
            	  var orgVer   =  verValue.substring(0, verValue.length - 4);
            	  var asValue  =  '.AS' + asNewCnt ;
            	  var prevVer  =  orgVer + asValue ;
            	  }
            
     }	
     
	cmdname = appValue + prevVer + " " + verFunc + " " + transId ;
	
	
	docommand(cmdname,browser);
}

/**
 * Run next version..
 * @param {String} arg1 The first argument
 * @param {String} arg2 The second argument
 * @return {void}
 */
function nxtVersion(arg1,arg2)
{
	
	var transId  = "";
	var applName = getFormField( currentForm_GLOBAL, 'application' );
	var appValue = applName.value;
        var verName  = getFormField( currentForm_GLOBAL, 'version' );
        var verValue = verName.value;
        var lockInfo = getFormField( currentForm_GLOBAL, 'lockDateTime' );
        var lockValue = lockInfo.value;
        if(lockValue == "")
             {
        	var verFunc = "S" ;
        }
       else
	{
		var verFunc = "I";
		}
     	var fieldId  = getFormField( currentForm_GLOBAL, 'transactionId' );
	var transId  = fieldId.value;
        var verIndex = verValue.substring(verValue.length - 4, verValue.length -1 );
        var browser = navigator.appName.substring ( 0, 9 );
        
        if( verIndex == '.AS')
           {
             	  var asCnt    =  verValue.substring(verValue.length - 1, verValue.length);                     	        		
            	  ++asCnt ;
            	  var orgVer   =  verValue.substring(0, verValue.length - 4);
            	  var asValue  =  '.AS' + asCnt ;
            	  var nxtVer  =  orgVer + asValue ;
            	  
            
           }
        else
        	{
                var asValue =  '.AS1';		
        	var nxtVer  =  verValue + asValue;
        }
        
	cmdname = appValue + nxtVer + " " + verFunc + " "+ transId ;
	
	
	docommand(cmdname,browser);
}

/*
  javascript for changePassword.jsp 
  ajax call to the FtressChange PasswordServlet and 
  therby replacing the div with success or error response

*/
function getFormFieldsAsParams(form) {
				var fields=new String();

                var value1 = FragmentUtil.getElement("OldPassword");
				var name1 = value1.name;
				var nameValue1 = value1.value;
     			fields += name1 + "=" + nameValue1 + "&";        
                var value2 = FragmentUtil.getElement("NewPassword");
				var name2 = value2.name;
				var nameValue2 = value2.value;
     			fields += name2 + "=" + nameValue2 + "&";
                var value3 = FragmentUtil.getElement("ConfirmPassword");
				var name3 = value3.name;
				var nameValue3 = value3.value;
       			fields += name3 + "=" + nameValue3 + "&";
				var value4 = FragmentUtil.getElement("formToken");
       			if(value4){
       				var name4 = value4.name;
    				var nameValue4 = value4.value;
       				fields += name4 + "=" + nameValue4 + "&";
       			}
				return fields.substr(0, fields.length-1);
}

function postForm(form) {
				var http = false;
				
				if(navigator.appName == "Microsoft Internet Explorer") {
					http = new ActiveXObject("Microsoft.XMLHTTP");
				} else {
					http = new XMLHttpRequest();
				}
				
				var URL = form.target;
				var params = getFormFieldsAsParams(form);


				http.open('POST', URL, true);
				http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");	
				http.setRequestHeader("Content-length", params.length);
				http.setRequestHeader("Connection", "close");
				http.send(params);
				
				http.onreadystatechange=function() {

					if(http.readyState == 4) {
					  	document.getElementById("content").innerHTML = http.responseText;
					}
				};
}
function validateForm(objForm) {
				var curField = null;
				curField = document.getElementById("rsa_passcode");
				if (curField!=null && curField.value==""){
					document.getElementById("error").innerHTML = "Field : Passcode mandatory";
					return;
				}
				curField = document.getElementById("rsa_pin");
				if (curField!=null && curField.value==""){
					document.getElementById("error").innerHTML = "Field : PIN mandatory";
					return;
				}
				curField = document.getElementById("rsa_sms_token");
				if (curField!=null && curField.value==""){
					document.getElementById("error").innerHTML = "Field : SMS Passcode mandatory";
					return;
				}
				curField = document.getElementById("nexttoken");
				if (curField!=null && curField.value==""){
					document.getElementById("error").innerHTML = "Field : NextToken mandatory";
					return;
				}
				curField = document.getElementById("newpin");
				if (curField!=null && curField.value==""){
					document.getElementById("error").innerHTML = "Field : New PIN mandatory";
					return;
				}
				curField = document.getElementById("confirm_newpin");
				if (curField!=null && curField.value==""){
					document.getElementById("error").innerHTML = "Field : Confirm mandatory";
					return;
				}
				if(curField!=null){
					var newpin = document.getElementById("newpin").value;
					var confirm_newpin = document.getElementById("confirm_newpin").value;
					if(newpin != null && confirm_newpin != null && newpin == confirm_newpin){
						postForm(objForm);
						return;
					}else{
						document.getElementById("error").innerHTML = "New PIN and Confirm does not match";
						return;
					}
				}
				postForm(objForm);
}

function getFormFieldsAsParams1(form) {
				var fields=new String();
                var value1 = FragmentUtil.getElement("transPassword");
                var name1 = value1.name;
				var nameValue1 = value1.value;
                var value2 = FragmentUtil.getElement("formToken");
                fields += name1 + "=" + nameValue1 + "&";
                if (value2){
                	var name2 = value2.name;
    				var nameValue2 = value2.value;
         			fields += name2 + "=" + nameValue2 + "&"; 
    			}              
				return fields.substr(0, fields.length-1);
}

function postForm1(form) {
				var http = false;
			
				if(navigator.appName == "Microsoft Internet Explorer") {
					http = new ActiveXObject("Microsoft.XMLHTTP");
				} else {
					http = new XMLHttpRequest();
				}
				var URL = form.target;
                var params = getFormFieldsAsParams1(form);
		               
				http.open('POST', URL, true);
				http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");	
				http.setRequestHeader("Content-length", params.length);
				http.setRequestHeader("Connection", "close");
				http.send(params);
				
				http.onreadystatechange=function() {

					if(http.readyState == 4) {
					  	document.getElementById("content").innerHTML = http.responseText;
					}
				};
}
function cancelForm(form) {
   	           var http = false;
				
				if(navigator.appName == "Microsoft Internet Explorer") {
					http = new ActiveXObject("Microsoft.XMLHTTP");
				} else {
					http = new XMLHttpRequest();
				}
				
				var URL = form.target;
				var params  = "command=globusCommand";
			    params += "&requestType=" + _NO__REQUEST_;
			    params += "&routineArgs=" + "";
			    params += "&companyId=" + document.getElementById("cmpID").value;
			    params += "&application=" + document.getElementById("applctn").value;
			    params += "&user=" + document.getElementById("usrID").value;
			    params += "&transactionId=" + encodeURIComponent(document.getElementById("txnID").value);
			    params += "&unlock=" + document.getElementById("applctn").value + " " + encodeURIComponent(document.getElementById("txnID").value);
			    params += "&closing=" + "Y";
			    params += "&pwprocessid=" + "";
			    // To get the fragment name , traverse to the parent of content DIV id
			    params += "&windowName=" + document.getElementById("content").parentNode.getAttribute("fragmentname");
			    params += "&screenMode=" + "";

				http.open('POST', URL, true);
				http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");	
				http.setRequestHeader("Content-length", params.length);
				http.setRequestHeader("Connection", "close");
				http.send(params);
				
				http.onreadystatechange=function() {

					if(http.readyState == 4) {
					  	document.getElementById("content").innerHTML = http.responseText;
					}
				};
}
/*
Java Script to handle the Enter Key in Transaction Authentication pages
*/

function processKey(e)
{
      var key;     
      if(window.event)
            key = window.event.keyCode; //IE
      else
            key = e.which; //firefox     
            
 if (key == 13)  {
    postForm1(window.document.forms['FtressPasswordForm']) ;
  }
 return (key != 13);
}

function sessionLogout(contextURL){
	window.open(contextURL,"_top");
}

function doHighlight(el)
{ 
	var newstyle = "";
	//Find the ToolBar table node
	var StyleElement = el.parentNode;
	while((StyleElement.nodeName != 'TABLE')) { 
			StyleElement = StyleElement.parentNode;
	} 
	//Select all highlighted Hyperlink elements within the toolbar node - the Tools
	var allOnElements = FragmentUtil.getElementsByClassName("textbtnOn", "A", StyleElement);
	i=0;
	while (i<allOnElements.length) { 
			newstyle = allOnElements[i].className.replace(" textbtnOn", "");
			allOnElements[i].setAttribute("className", newstyle);
			allOnElements[i].setAttribute("class", newstyle);
			i++;
	}
	//replace the style attribute with the new one that has the highlight function in it
	newstyle = el.className + " textbtnOn" ;
	el.setAttribute("className", newstyle);
	el.setAttribute("class", newstyle);
}

//print option for ARC-IB preview versions
function doVersionPrint(theaction)
{
	if (top.noFrames)
	{       

		// Get the current fragment name from the current window usually, but use the target context if supplied
		var fragmentName = window.Fragment.getCurrentFragmentName();
		if (theaction==_PRINT_)
		{
			if(FragmentUtil.isCompositeScreen() && top.noFrames == true)
			{
				
				var frags = document.getElementsByTagName('.fragmentContainer.notPrintableFragment'), i;
				for (i = 0; i < frags.length; ++i) 
				{
					frags[i].style.display = "";
				}

				var tdElement= document.getElementById(fragmentName);
				tdElement.className = tdElement.className.replace("notPrintableFragment","printableFragment");
				//get the tbody element
				//form the new html document to be printed

				for(var p = tdElement.parentNode; p && p.nodeName != "body"; p = p.parentNode)
				{
					if(p.className != null && p.className.indexOf("fragmentContainer") != -1)
					{
						if(p.className.indexOf("printableFragment") == -1)
						{
							p.className = p.className.replace(
									"notPrintableFragment","printableFragment");
						}
					}
				} 
				print();
				
				// Since onafterprint event is not working in Chrome as expected  
				// setTimeout with 0 millisecond wait is alternative hack for Chrome. This introduces no delay in execution. 
				setTimeout (function() { afterPrint();	}, 0);				
				function afterPrint()
				{
					tdElement.className = tdElement.className.replace("printableFragment","notPrintableFragment");
					for(var p = tdElement.parentNode; p && p.nodeName != "body"; p = p.parentNode)
					{
						if(p.className != null && p.className.indexOf("fragmentContainer") != -1)
						{
							if(p.className.indexOf("notPrintableFragment") == -1)
							{
								p.className = p.className.replace(
										"printableFragment","notPrintableFragment");
							}
						}
					}
				}			

			}
			else
			{
				print();
			}

		}
	}
}
	/*
** Arguments Details
** fieldname  : Complete Id of the fieldName whose value should be changed
** fieldValue : Value that should be assigned to the above field
** action     : Action to be carried out after changing the value of the field
*/

function Setandsubmit(fieldname,fieldValue,action)
{
	if(fieldname!=null && (fieldname.substr(0,10)!="fieldName:"))
	{
		fieldName = "fieldName:" + fieldname;
	}
	var appreqForm = FragmentUtil.getForm(currentForm_GLOBAL);
	var fieldElement;
	var rawfieldElement = fieldName.substr(10,fieldName.length);
	if(appreqForm!=null)
	{
		fieldElement = appreqForm[fieldName];
	}
	if(fieldElement==null)
	{
		fieldElement = document.getElementById(fieldName);
	}
	
	if(fieldElement!=null)
	{
		fieldElement.value = fieldValue;
		doToolbar('', action, '', '');
		
	} 
	else 
	{
		alert("No Field with ID "+rawfieldElement+" is available");
	}	
}

function Setandcommit(fieldname,fieldValue,action)
{
	if(fieldname!=null && (fieldname.substr(0,10)!="fieldName:"))
	{
		fieldName = "fieldName:" + fieldname;
	}
	var appreqForm = FragmentUtil.getForm(currentForm_GLOBAL);
	var fieldElement;
	var rawfieldElement = fieldName.substr(10,fieldName.length);
	if(appreqForm!=null)
	{
		fieldElement = appreqForm[fieldName];
	}
	if(fieldElement==null)
	{
		fieldElement = document.getElementById(fieldName);
	}
	
	if(fieldElement!=null)
	{
	if(fieldElement.value!="")
	{
		fieldElement.value = fieldElement.value + "*" + fieldValue;
		doToolbar('', action, '', '');
		}
		else
		{
		 doToolbar('', action, '', '');
		 }
	} 
	else 
	{
		alert("No Field with ID "+rawfieldElement+" is available");
	}
	
}

function processInvalidSession(){
	var baseURL = window.location.protocol + "//" + location.host + "/" + getWebServerContextRoot();
	window.location = baseURL + "/modelbank/unprotected/SessionLoggedout.jsp";
}

function scanDoc(fieldName, fieldValue)
{
	var alterFldName = '', alterApp = '', alterId = '';
	
	if (fieldName != null) {
		var alterFields = fieldName.split("|");
		var noAlterFlds = alterFields.length;
		var idx;
				
		for (idx = 0; idx < noAlterFlds; idx++) {
			var appFldArr = alterFields[idx].split("_");
			if (appFldArr.length <= 2) {
				var alterFldName = appFldArr[0];
				if (alterFldName != null)
				{
					if (alterFldName.substr(0,10) != "fieldName:") 
					{
						alterFldName = "fieldName:" + alterFldName;						
					}
				    var alterField  = getFormField( currentForm_GLOBAL, alterFldName);
					if (alterField != null){
					    var alterVal  = alterField.value;    
					    if (alterVal != null && alterVal != "") {
					    	alterApp = appFldArr[0];
					    	alterId = alterVal;
					    	break;
					    }
					}								
				}
			}
		}		
	}
	
    var idField  = getFormField( currentForm_GLOBAL, 'transactionId' );
	var transId  = idField.value;    
    
    var appField  = getFormField( currentForm_GLOBAL, 'application' );
	var app  = appField.value;    	
	
	var imgRef = transId + '|' + alterId;
	var imgApp = app + '|' + alterFldName;
	
	if (transId != null && app != null) {
	    docommand('IM.DOCUMENT.IMAGE,EM.NEW I F3 IMAGE.REFERENCE=' + imgRef + ' IMAGE.APPLICATION=' + imgApp);		
	}
}