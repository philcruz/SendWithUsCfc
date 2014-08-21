SendWithUsCFC
=========

This repository contains the source code for the ColdFusion/CFML library for sending email via the [sendwithus](https://www.sendwithus.com) API.

Installation
============

Copy the sendwithuscfc folder to your webroot. If don't install the files into your webroot, create a mapping for "/sendwithuscfc" to wherever it is installed.

Example 
=======
```js

	//initialize the api object
	api = CreateObject("component", "sendWithUsCfc.SendWithUsApi")
		.init(apiKeyLive="live-api-key", apiKeyTest="test-api-key", liveMode=false);
		
	//construct the send request	
	sendRequest = api.newSendRequest()
	.setEmailId("email-template-id-goes here")
	.setRecipient({"address":"joe@somedomain.com"})
	.setSender({"address": "support@the-sending-domain.com", "name": "Support"})
	.setEmailData({"first_name": "Fred"});

	//call the api to send the email
	apiResponse = api.send(sendRequest);
	
	// did we succeed?
    if (apiResponse.statusCode EQ "200")
        // Yes!  Look at apiResponse.result 
    else
        // check apiResponse.message and/or apiResponse.status
```
