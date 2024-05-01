trigger AggrementTrigger on NewAgreement__c (before insert) {
        
        for(NewAgreement__c newpck : Trigger.new){
         AgreementClass.createKushtarObject(newpck.name);
    }
}