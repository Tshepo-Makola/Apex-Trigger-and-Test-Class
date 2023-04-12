@isTest
public with sharing class OppprotunityTriggerHelperTest {

    @TestSetup 
    public static void setup() {
        List<Opportunity> oppList = new List<Opportunity>();

        for (integer i = 0; i < 10; i++) {
            Opportunity opp = new Opportunity();
          if(i<5)  { 
            opp.Name = 'Opportunity Test ' + i;
            opp.Amount = 350000;
            opp.StageName = 'Prospecting';
            opp.CloseDate = Date.today().addDays(30);
            
            oppList.add(opp);
        }
          else 
          if(i>=5 && i<10) {
            opp.Name = 'Opportunity Test ' + i;
            opp.Amount = 95000;
            opp.StageName = 'Closed Won';
            opp.CloseDate = Date.today();
      
            oppList.add(opp);
        }
     }

         insert oppList;

    }



    @isTest
    public static void testUpdateOpportunityDesc() {
       List<Opportunity> opportunityList = [SELECT Id , Amount, Description, StageName 
                                            FROM Opportunity ];

       System.assertEquals(10, opportunityList.size(), 'The actual size is not the same as the expected size');
        
         for (Opportunity opp : opportunityList) {
              if (opp.Amount >= 100000 && opp.Amount <= 500000 ) {
                System.assertEquals('Hot opportunity', opp.Description, 'The actual description is not the same as the expected description');
                System.assertEquals('Prospecting' , opp.StageName, 'The actual stage is not the same as the expected stage');
                System.assert(opp.Amount != null, 'The amount must not be empty');
          
              
            
              } 
             else if(opp.Amount <=10000 ) {
                System.assertEquals('Cold opportunity', opp.Description, 'The actual description is not the same as the expected description');
                System.assertEquals('Closed Won' , opp.StageName, 'The actual stage is not the same as the expected stage');
                System.assert(opp.Amount != null, 'The amount must not be empty');
              
              }
   
         }
    }
   
 @IsTest
 static void testAiAddOppToAccount() {

  List<Account> accounts = new List<Account>();
  List<Opportunity> opportunities = new List<Opportunity>();

 
  for (integer i = 0 ; i<5; i++) {
    Account acc = new Account();
    acc.Name = 'Account Test Opportunity ' + i;
    accounts.add(acc);
     
   }
 
  insert accounts;



  for(Account account : accounts)
  {
    Opportunity opp = new Opportunity();
    opp.Name = 'Opportunity Test ' + account.Name;
    opp.Amount = 350000;
    opp.StageName = 'Prospecting';
    opp.CloseDate = Date.today().addDays(30);
    opp.AccountId = account.Id;
    opportunities.add(opp);

  }
  Test.startTest();
  insert opportunities;
  Test.StopTest();

  
List<Account> updateAccountList = [SELECT id, Latest_Opportunity_Amount__c 
                                    FROM Account      
                                    WHERE Id =: accounts[0].Id
                                    ];

System.assertEquals(350000, updateAccountList[0].Latest_Opportunity_Amount__c, 'The actual amount is not the same as the expected amount');


  } 

}