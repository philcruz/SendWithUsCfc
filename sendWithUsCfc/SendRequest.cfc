component output="false" accessors="true"
{ 
	property name="emailId";
	property name="recipient"; 
	property name="sender";
	property name="emailData";
	property name="ccRecipients";
	
	public function init()
	{
		return this;
	}
	
	public function getAsJson()
	{
		var theRequest = {};
		theRequest["email_id"] = this.getEmailId();
		theRequest["recipient"] = this.getRecipient();
		theRequest["sender"] = this.getSender();
		theRequest["email_data"] = this.getEmailData();
		theRequest["cc"] = this.getCcRecipients();
		return serializeJson(theRequest);
	}
}