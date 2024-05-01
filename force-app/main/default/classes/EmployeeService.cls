public class EmployeeService {
    public static void createKushtarObject(String Name) {
        KushtarObject__c newKObject = new KushtarObject__c();
        newKObject.TriggerText__c = '04/19/2024 '+ Name + ' After Insert Trigger ';
        newKObject.name=Name;
        insert newKObject;
    }
}