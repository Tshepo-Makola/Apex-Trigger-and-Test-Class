public with sharing class AccountTriggerHelper {
 /*
  * Before Insert | Populate Rating as Hot on Account Creation If Industry is Media or Energy
*/
  public static void beforeInserUpdateRating(List<Account> newReclist) {
    //List for storing details of accounts
  
    for (Account acct : newReclist) {
      if (acct.Industry == 'Media' || acct.Industry == 'Energy') {
        acct.Rating = 'Hot';
      }
    }
  }
  /*
   *Before Insert | Copy Billing Address to Shipping Address on Account Creation
  */
   public static void biCopyBillingAddressTOShippingAddress(List<Account> newReclist) {
    //List for storing details of accounts
    List<Account> accounts = new List<Account>();

    for (account acc : newReclist){
      //Coping Billing Address to Shipping Address if the checkbox is checked
      if (acc.copy_billing_to_shipping__c){
        
        acc.ShippingCity = acc.BillingCity ;
        acc.ShippingCountry = acc.BillingCountry ;
        acc.ShippingPostalCode = acc.BillingPostalCode ;
        acc.ShippingState = acc.BillingState ;
        acc.ShippingStreet = acc.BillingStreet ;
        acc.ShippingLatitude = acc.BillingLatitude ;
        acc.ShippingLongitude = acc.BillingLongitude ;
}

    } 
}
/*
 *[4] After Insert | Create a related Contact on Account insertion
*/

  public static void aICreateRelatedCon(Map<Id, Account> newRecordMap)
  {
    list<Contact> contactList = new list<Contact>();

    for (Account acc : newRecordMap.values()) {
      Contact newContact = new Contact();
      newContact.FirstName = 'Test';
      newContact.LastName = 'Contact';
      newContact.AccountId = acc.Id;
      newContact.Email = 'Take@gmail.com';
      
      contactList.add(newContact);

    }
    //Schema.sobjectType.Opportunity.isCreateable()
    if(Contact.sObjectType.getDescribe().isCreateable()) {
      if(!contactList.isEmpty()) {
        insert contactList;
      }
    } 
  }

  /*
     * [5] After Insert | Create a related Opportunity on Account insertion
    */
  public static void aICreateRelatedOpp(Map<Id, Account> newRecordMap)
  {
    List<Opportunity> oppList = new List<Opportunity>();

    for (Account acc : newRecordMap.values())
    {
      Opportunity newOpportunity = new Opportunity();

      newOpportunity.Name = 'Test Opportunity';
      newOpportunity.AccountId = acc.Id;
      newOpportunity.StageName = 'Prospecting';
      newOpportunity.CloseDate = Date.today().addDays(30);
      oppList.add(newOpportunity);
    }
    //Schema.sobjectType.Opportunity.isCreateable()
    if(Opportunity.sObjectType.getDescribe().isCreateable()) {
      if(!oppList.isEmpty()) {
        insert oppList;
      }
    }
  }
  
}
