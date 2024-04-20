trigger EmployeeTrigger on NewEmployee__c (after insert) {

    for(NewEmployee__c emp : Trigger.new){
        KushtarObject__c newKObject = new KushtarObject__c();
        newKObject.TriggerText__c = '04/19/2024 '+emp.name + ' After Insert Trigger ';
        newKObject.name=emp.name;
        insert newKObject;
    }

}