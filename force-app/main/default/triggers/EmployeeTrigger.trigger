trigger EmployeeTrigger on NewEmployee__c (after insert) {

    for(NewEmployee__c emp : Trigger.new){
       EmployeeService.createKushtarObject(emp.name);
    }
}