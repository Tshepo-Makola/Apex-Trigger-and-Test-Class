public with sharing class ContactTriggerHelper {
  public static void afterInsertTrigger(
    List<Contact> newRecList,
    Map<Id, Contact> newMap
  ) {
    Set<Id> uniquesIds = newMap.keySet();
    for (Contact c : newRecList) {
      if (String.isNotBlank(c.AccountId)) {
        uniquesIds.add(c.AccountId);
      }
    }
    List<Account> accountsToUdpate = new List<Account>();
    if (Schema.sObjectType.Contact.isAccessible()) {
      List<AggregateResult> results = [
        SELECT AccountId, COUNT(Id) Tot_Active_Contacts
        FROM Contact
        WHERE AccountId IN :uniquesIds AND Active__c = TRUE
        GROUP BY AccountId
      ];

      for (AggregateResult result : results) {
        String accountId = (String) result.get('AccountId');
        Integer count = (Integer) result.get('Tot_Active_Contacts');

        Account acc = new Account(Id = accountId, Contact_Number__c = Count);

        AccountsToUdpate.add(acc);
      }
      if (Account.SObjectType.getDescribe().isUpdateable()) {
        update AccountsToUdpate;
      }
    }
  }
  /*
   * After Update Trigger method
   */
  public static void afterUpdateTrigger(
    List<Contact> newRecList,
    Map<Id, Contact> oldMap
  ) {
    Set<Id> uniquesIds = new Set<Id>();

    for (Contact c : newRecList) {
      if (
        String.isNotBlank(c.AccountId) &&
        c.Active__c != oldMap.get(c.Id).Active__c
      ) {
        uniquesIds.add(c.AccountId);
      } else if (c.Active__c != oldMap.get(c.Id).Active__c) {
        uniquesIds.add(c.AccountId);
        uniquesIds.add(oldMap.get(c.Id).AccountId);
      }
    }
    List<Account> accountsToUdpate = new List<Account>();
    if (Schema.sObjectType.Contact.isAccessible()) {
      List<AggregateResult> results = [
        SELECT AccountId, COUNT(Id) Tot_Active_Contacts
        FROM Contact
        WHERE AccountId IN :uniquesIds AND Active__c = TRUE
        GROUP BY AccountId
      ];

      for (AggregateResult result : results) {
        String accountId = (String) result.get('AccountId');
        Integer count = (Integer) result.get('Tot_Active_Contacts');

        Account acc = new Account(Id = accountId, Contact_Number__c = count);

        accountsToUdpate.add(acc);
      }
      if (Account.SObjectType.getDescribe().isUpdateable()) {
        update accountsToUdpate;
      }
    }
  }
}
