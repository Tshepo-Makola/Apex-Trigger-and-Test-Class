@isTest
public with sharing class CaseTriggerHelperTest {


    @TestSetup
    private static void setup() {
	 List<Account> accList = new List<Account>();

    for(integer i = 0 ; i < 10 ; i++) {
      Account acc = new Account();
      if(i < 5){
      acc.Industry = 'Media';
      acc.Name = 'TestAccount' + i;
      acc.BillingCity = 'Test City ' + i ;
      acc.BillingCountry = 'Test Country ' + i;
      acc.BillingPostalCode = 'Test Postal Code ' + i;
      acc.BillingState = 'Test Billing State' + i;
      acc.BillingStreet = 'Test Billing Street' + i;
      acc.copy_billing_to_shipping__c = true;
      

      accList.add(acc);

      }
      else{
      acc.Industry = 'Energy';
      acc.Name = 'Test Account ' + i;
      acc.BillingCity = 'Test City ' + i ;
      acc.BillingCountry = 'Test Country ' + i;
      acc.BillingPostalCode = 'Test Postal Code ' + i;
      acc.BillingState = 'Test Billing State' + i;
      acc.BillingStreet = 'Test Billing Street' + i;
      acc.copy_billing_to_shipping__c = false;




        accList.add(acc);
      }
    }

    insert accList;
  
  }
    
@IsTest
    static void testAILatestCaseNumToAccount() {
        
    List<Account> accountList = [SELECT Id, Name , Latetest_Case_number__c FROM Account ];
        
    List<Case> cases = new List<Case>();

        for (account acc : accountList) {
            case cs = new Case();
            
          	cs.AccountId = acc.Id;
            cs.Origin = 'Phone';
            cs.Status = 'New';
            cases.add(cs);
        }
        test.startTest();
        insert cases;
        test.stopTest();
        
   	System.assertEquals(10 , accountList.size() , 'Expected is not the same as Actual');
      
      List<Case> caseList = [SELECT Id ,AccountId , CaseNumber ,Origin,Status
                             FROM Case]; 
      List<Account> acctList = [SELECT Id, Name , Latetest_Case_number__c 
                                FROM Account ];
   
        
    For(integer i = 0 ; i < cases.Size(); i++)
    {
        System.assertEquals(caseList[i].AccountId, accountList[i].Id, 'Expected is not the same as Actual');
        System.assertEquals(acctList[i].Latetest_Case_number__c, caseList[i].CaseNumber,'The Expected number is not the same as the expected number');
		
    }

 }
}