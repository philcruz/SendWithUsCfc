component output="false" accessors="true"
{ 
	property name="apiKeyLive";
	property name="apiKeyTest"; 
	property name="apiUrl";
	property name="liveMode";
	property name="version";
	
	public function init(string apiKeyLive="", string apiKeyTest="", string apiUrl="https://api.sendwithus.com/api/v1/send", liveMode=false)
	{
		variables.apiKeyLive = arguments.apiKeyLive;
		variables.apiKeyTest = arguments.apiKeyTest;
		variables.apiUrl = arguments.apiUrl;
		variables.liveMode = arguments.liveMode;
		variables.version = "0.1.0";
		return this;
	}
	
	public function newSendRequest()
	{
		return createObject("component", "SendRequest");
	}
	
	public function send(required sendRequest)
	{
		var result = "";					
		var apiKey = (variables.liveMode ? variables.apiKeyLive : variables.apiKeyTest);
		var responseData = { statusCode = "", result = "", message = "", requestData = arguments.sendRequest, status=""};
		
		var httpService = new http(url=variables.apiUrl, method="post", username="#apiKey#", password="");
		httpService.addParam(type="body",value=arguments.sendRequest.getAsJson()); 
		
		try
		{			
			result = httpService.send().getPrefix();	
			
			//handle the result
			if (not isNull(result) AND isStruct(result) AND structKeyExists(result, "fileContent"))
				responseData.result = result.fileContent;
			else				
				responseData.status = "Unknown";

			responseData.statusCode = reReplace(result.statusCode, "[^0-9]", "", "ALL");
		}
		catch (Any exc)
		{
				responseData.status = "Unknown";
				responseData.message = exc.message;
		}
		
		if (responseData.statusCode NEQ "200")
		{
			switch(responseData.statusCode)
			{
				case "400":
					responseData.message = responseData.result;
					responseData.status = "Client error";
					break;
				case "403":
					responseData.message = "Authentication failure";
					responseData.result = result;
					responseData.status = "Client error";
					break;
				default:
					responseData.result = result;
					if (isDefined("result.Filecontent") AND lcase(result.Filecontent) contains "connection failure")
					{
						responseData.message = result.ErrorDetail;
						responseData.status = result.Filecontent;
					}
					break;
			}
		}
		else
		{
			responseData.status = "OK";			
		}

		return responseData;

	}
}