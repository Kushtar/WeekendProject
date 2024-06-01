public with sharing class AccountService {

    @AuraEnabled(cacheable=true)//Needed for it to be callable by LWC
    public static Map<String, String> getAccountDetails(String AccountId){

        String ExternalAccountId;
        String ServiceStartDate;
        String ServiceEndDate;
        String ServiceAddress;

        Account account = [SELECT Id, Name, External_Account_Id__c,
        Service_Start_Date__c, Service_End_Date__c, Service_Address__c
        FROM Account WHERE Id = :AccountId];

        ExternalAccountId=account.External_Account_Id__c;
        ServiceStartDate=String.valueOf(account.Service_Start_Date__c);
        ServiceEndDate=String.valueOf(account.Service_End_Date__c);
        ServiceAddress=account.Service_Address__c;

        Map<String,String> returnMap = new Map<String,String>() ;
        returnMap.put('ExternalAccountId', ExternalAccountId);
        returnMap.put('ServiceStartDate', ServiceStartDate);
        returnMap.put('ServiceEndDate', ServiceEndDate);
        returnMap.put('ServiceAddress', ServiceAddress);

        return returnMap;

    }
}