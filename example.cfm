<cfscript>
	
	//update with your actual api keys
	apiKeyLive = "live-key-goes-here";
	apiKeyTest = "test-key-goes-here";
	liveMode = false;
	
    //instantiate the api
	api = CreateObject("component", "sendWithUsCfc.SendWithUsApi")
		.init(apiKeyLive=apiKeyLive, apiKeyTest=apiKeyTest, liveMode=liveMode);
		
	//construct the send request	
	sendRequest = api.newSendRequest()
	.setEmailId("email-template-id-goes here")
	.setRecipient({"address":"joe@somedomain.com"})
	.setSender({"address": "support@the-sending-domain.com", "name": "Support"})
	.setEmailData({"first_name": "Fred"})
	.setCcRecipients([{ "name":"Sales Team","address":"sales@the-sending-domain.com"}, {"name": "Support", "address": "support@the-sending-domain.com"}]);

	//call the api to send the email
	apiResponse = api.send(sendRequest);

</cfscript>


<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=utf-8">
	<title>SendWithUsCfc Example</title>
</head>
<body>

<!--- handle the response from the api --->
<cfif apiResponse.statusCode EQ "200" >
	<h3>Success!</h3>
	<cfset sendReceipt = deserializeJSON(apiResponse.result) />
	<cfdump var=#sendReceipt# label="sendReceipt" expand="false" />
<cfelse>
	<h3>Error</h3>
	<cfoutput>
		#apiResponse.statusCode#<br />
		#apiResponse.status#<br />
		#apiResponse.message#</cfoutput>
</cfif>


</body>
</html>




