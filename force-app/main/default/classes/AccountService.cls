public with sharing class AccountService {

    @AuraEnabled(cacheable=true)//Needed for LWC to call it using wire service
    public static Map<String, String> getAccountDetails(String AccountId){

        String ExternalAccountId;
        String ServiceStartDate;
        String ServiceEndDate;
        String ServiceAddress;
        String Name;

        Account account = [SELECT Id, Name, External_Account_Id__c,
        Service_Start_Date__c, Service_End_Date__c, Service_Address__c
        FROM Account WHERE Id = :AccountId];

        ExternalAccountId=account.External_Account_Id__c;
        ServiceStartDate=String.valueOf(account.Service_Start_Date__c);
        ServiceAddress=account.Service_Address__c;
        Name=account.Name;

        Map<String,String> returnMap = new Map<String,String>() ;
        returnMap.put('ExternalAccountId', ExternalAccountId);
        returnMap.put('ServiceStartDate', ServiceStartDate);
        returnMap.put('Name', Name);
        returnMap.put('ServiceAddress', ServiceAddress);

        return returnMap;

    }

    @AuraEnabled//Needed for LWC to call imperatively
    public static Boolean submitToExternalSystem(
        String ServiceId,
        String NewServiceStartDate,
        String RequestType
        ){

            Account accountDetails = [SELECT Id, Name, External_Account_Id__c,
            Service_Start_Date__c
            FROM Account WHERE Id = :ServiceId];

        //Make Http Call Out
        // Define the endpoint URL you want to call. Using the Named Credentional
        String endpoint = 'callout:TargetOrg/services/apexrest/changeEnrollment';
        
        // Create a new HTTP request
        HttpRequest request = new HttpRequest();
        request.setEndpoint(endpoint);
        request.setMethod('POST'); // or 'POST', 'PUT', 'DELETE', etc.
        
        //Set headers or parameters
        request.setHeader('Authorization', 'Bearer '+ UserInfo.getSessionId());
        request.setHeader('Content-Type', 'application/json');
        String body='{"ExternalId": "'+accountDetails.External_Account_Id__c+'", "ServiceStartDate": "'+NewServiceStartDate+'", "Type":"Change"}';
        system.debug(body);
        request.setBody(body);
        
        // Create a new HTTP object to send the request
        Http http = new Http();
        
        // Send the request and store the response
        HttpResponse response = http.send(request);
        
        // Process the response
        if (response.getStatusCode() == 200) {
            // Successful response
            String responseBody = response.getBody();
            System.debug('Response: ' + responseBody);
        } else {
            // Error Response handling
            system.debug(response);
            System.debug('Error: ' + response.getStatusCode() + ' ' + response.getStatus());
        }    



        return true;
    }
}