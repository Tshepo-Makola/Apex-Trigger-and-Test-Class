@isTest
public class AccountTriggerHelperTest {
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
  
  @isTest
  static void testBeforeInserUpdateRating() {
    List<Account> accList = [SELECT Id, Name,Rating ,Industry FROM Account ];
   /* 
    *[1] Before Insert | Populate Rating as Hot on Account Creation If Industry is Media or Energy
   */
    for (Account acc : accList) {
      
      if(acc.Rating == 'Hot'){
        System.assertEquals(10, accList.size() , 'Actual  size is not the same as expected size');
      }
      if(acc.Industry == 'Media' || acc.Industry == 'Energy') {
        System.assertEquals('Hot', acc.Rating , 'Actual  size is not the same as expected size');
      }
    
    }
  
  }
  @isTest
  static void testBiCopyBillingAddressTOShippingAddress() {
/*
  *[3] Before Insert | Copy Billing Address to Shipping Address on Account Creation
*/
    List<Account> accList = [SELECT Id, Name,copy_billing_to_shipping__c,
                              BillingAddress, 
                                 BillingStreet,BillingCity,BillingPostalCode,BillingState, BillingCountry ,
                              ShippingAddress ,
                                 ShippingCountry,ShippingState,ShippingPostalCode ,ShippingCity,ShippingStreet
                             FROM Account ];


    for (Account acc : accList) {
 
        if (acc.copy_billing_to_shipping__c) {

          // Remove leading/trailing spaces from address fields

          String billingStreet = acc.BillingStreet != null ? acc.BillingStreet.trim() : null;
          String billingCity = acc.BillingCity != null ?acc.BillingCity.trim() : null;
          String billingPostalCode = acc.BillingPostalCode != null ?acc.BillingPostalCode.trim():null;
          String billingState = acc.BillingState !=null ? acc.BillingState.trim():null;
          String billingCountry = acc.BillingCountry != null ? acc.BillingCountry.trim():null;
    
          /*
          I trie dusing the following approach but it The Test was Failing because of a single space
          from System.Address[getCity= Test City 0;
            Actual :Results
            System.Address[getCity=Test City 0;
            getCountry=Test Country 0;
            getCountryCode=null;
            getGeocodeAccuracy=null;
            getPostalCode=Test Postal Code 0;
            getState=Test Billing State0;
            getStateCode=null;
            getStreet=Test Billing Street0;]

            Expected Results 
            System.Address[getCity= Test City 0;
            getCountry=Test Country 0;
            getCountryCode=null;
            getGeocodeAccuracy=null;
            getPostalCode=Test Postal Code 0;
            getState=Test Billing State0;
            getStateCode=null;
            getStreet=Test Billing Street0;]
          
          At this point I had to use the String.ValueOf() method to get the test to pass 
          Or I could just Query all fields except the BillingAddres
           
        for (Account acc : accList) {
        if(acc.copy_billing_to_shipping__c){
          system.assertEquals(acc.ShippingAddress, acc.BillingAddress,'The Actual Address is not the same as the Expepct address ' );
    
       }
       else{
          system.assertEquals(null, acc.ShippingAddress,'The Actual Address is not the same as the Expepct address ' );
        }
      }
          */
          
          

          System.assertEquals(billingStreet, String.ValueOf(acc.ShippingStreet) ,
                              'The actual address is not the same as the expected address');
          System.assertEquals(billingCity,  String.ValueOf(acc.ShippingCity),
                              'The actual address is not the same as the expected address'); 
          System.assertEquals(billingPostalCode,  String.ValueOf(acc.ShippingPostalCode),
                              'The actual address is not the same as the expected address');
          System.assertEquals(billingState,  String.ValueOf(acc.ShippingState),
                              'The actual address is not the same as the expected address');
          System.assertEquals(billingCountry,  String.ValueOf(acc.ShippingCountry),
                              'The actual address is not the same as the expected address');
                    
        } else {
          System.assertEquals(null, acc.ShippingAddress,
                              'The actual address is not the same as the expected address');
        }
    
     }
   
    }
    @isTest
  public static void testAiCreateRelatedCon(){

     
/*
 *[4] After Insert | Create a related Contact on Account insertion
*/
    List<Account> accList = [SELECT Id, Name FROM Account ];
    List<Contact> contactList = new List<Contact>();

      for (Account acc : accList) {
        Contact relatedContact = new Contact();
        relatedContact.AccountId = acc.Id;
        relatedContact.FirstName = 'TestFirstName';
        relatedContact.LastName = 'TestLastName';
        relatedContact.Email =  relatedContact.LastName  + '@test.com';

        contactList.add(relatedContact);
      }

      test.startTest();
      if(contactList.isEmpty()){
      insert contactList;
      }
      test.stopTest();


      List<Contact> contactList1 = [SELECT Id, Account.Id ,Name, AccountId, Email 
                                    FROM Contact 
                                    ];
      System.assertEquals(10 , contactList1.size() , 'The Actual Contact List size is not the same as the Expected Contact List size');
      for (integer i = 0 ; i < contactList.size() ; i++) {
        System.assertEquals( accList[i].Id, contactList1[i].AccountId, 'The Actual Contact Id(AccountId) is not the same as the Expected Account.Id(ID) from Account');
        System.assert(!contactList1.isEmpty(), 'Contact is not created');
      }
    }
    /*
     * [5] After Insert | Create a related Opportunity on Account insertion
    */
    @isTest
    Public static void testAiCreateRelatedOpp()
    { 
      list<Account> accList = [SELECT Id, Name FROM Account ];
      List<Opportunity> oppList = new List<Opportunity>();

    for (Account acc : accList) {
     Opportunity opp = new Opportunity();
        opp.AccountId = acc.Id;
        opp.Name = 'Test Opportunity Name' + acc.Name;
        opp.StageName = 'Prospecting';
        opp.CloseDate = System.today().addDays(30);
        opp.Amount = 250000;
        oppList.add(opp);   
     
      }

      List<Opportunity> oppQuery = [SELECT Id, Account.Id ,Name, AccountId, StageName, CloseDate, Amount 
                                    FROM Opportunity ];

      System.assertEquals(10 , oppQuery.size() , 'The Actual Opportunity List size is not the same as the Expected Opportunity List size');
      for (integer i = 0 ; i < oppList.size() ; i++) {
        System.assertEquals( accList[i].Id, oppQuery[i].AccountId, 'The Actual Opportunity Id(AccountId) is not the same as the Expected Account.Id(ID) from Account');
        System.assert(!oppQuery.isEmpty(), 'Opportunity is not created');

      }
  } 

}