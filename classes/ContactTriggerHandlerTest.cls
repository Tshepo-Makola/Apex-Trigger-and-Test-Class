@isTest
public with sharing class ContactTriggerHandlerTest {
  //List of Account

  /*
  *In Order to create a contact  your Org must atleast have one or more 
  accounts  
  *Test data is Transient which means it does not affect
   The Data in your Org
  */
  @isTest
  public static void afterInsertTest1() {
    /*
    *Account 
    ------------------------------------------------------------------
    */
    List<Account> accList = new List<account>();
    Account account1 = new Account(Name = 'TestName1', Rating = 'Hot');
    Account account2 = new Account(Name = 'TestName2', Rating = 'Cold');

    accList.add(account1);
    accList.add(account2);
    insert accList;

    /*
    *Contacts 
    ------------------------------------------------------------------
    */
    list<Contact> contactList = new List<Contact>();
    Contact contact1 = new Contact(
      LastName = 'Test Contact 1',
      AccountId = accList[0].Id
    );
    Contact contact2 = new Contact(
      LastName = 'Test Contact 2',
      AccountId = accList[1].Id
    );

    Contact contact6 = new Contact(
      LastName = 'Test Contact 6',
      AccountId = accList[0].Id
    );
    Contact contact3 = new Contact(
      LastName = 'Test Contact 3',
      AccountId = accList[1].Id
    );

    Contact contact4 = new Contact(
      LastName = 'Test Contact 4',
      AccountId = accList[0].Id
    );
    Contact contact5 = new Contact(
      LastName = 'Test Contact 5',
      AccountId = accList[1].Id
    );

    contactList.add(contact1);
    contactList.add(contact2);
    contactList.add(contact3);
    contactList.add(contact4);
    contactList.add(contact5);
    contactList.add(contact6);

    insert contactList;
    /*
     * Check if all contacts are Insertserted
     * Check if all Accounts are inserted
     */
    /*
    *Account 
    ------------------------------------------------------------------
    */
    List<account> accts = [
      SELECT Id, Name, Rating, Contact_Number__c
      FROM Account
    ];
    System.assertEquals(
      2,
      accts.size(),
      'The Actual value(Size) Of Accounts is not Same as the Expected value(Size) of the Accounts'
    );
    System.assertEquals(
      'Hot',
      accList[0].Rating,
      'The Actual value is not Same as the Expected value'
    );

    System.assertEquals(
      'Cold',
      accList[1].Rating,
      'The Actual value is not Same as the Expected value'
    );
    System.assertEquals(
      null,
      accList[0].Contact_Number__c,
      'The Actual value is not Same as the Expected value'
    );
    System.assertEquals(
      null,
      accList[1].Contact_Number__c,
      'The Actual value is not Same as the Expected value'
    );

    /*
    *Contacts
    ------------------------------------------------------------------
    */

    List<Contact> contacts = [
      SELECT Id, LastName, AccountId, Active__c
      FROM Contact
    ];
    System.assertEquals(
      6,
      contacts.size(),
      'The Actual value(Size) Of Contacts is not Same as the Expected value(Size) of the Contacts'
    );

    System.assertEquals(
      'Test Contact 1',
      contacts[0].LastName,
      'The Actual value is not Same as the Expected value'
    );

    System.assertEquals(
      false,
      contacts[0].Active__c,
      'The Actual value is not Same as the Expected value'
    );
    System.assertEquals(
      false,
      contacts[1].Active__c,
      'The Actual value is not Same as the Expected value'
    );
  }

  @isTest
  public static void afterInsertTest2() {
    /*
    *Account 
    ------------------------------------------------------------------
    */
    List<Account> accList = new List<account>();
    Account account1 = new Account(Name = 'TestName1', Rating = 'Hot');
    Account account2 = new Account(Name = 'TestName2', Rating = 'Cold');

    accList.add(account1);
    accList.add(account2);
    insert accList;

    /*
    *Contacts 
    ------------------------------------------------------------------
    */
    //Account 1 has Three (TestName1) active contact

    list<Contact> contactList = new List<Contact>();
    Contact contact1 = new Contact(
      LastName = 'Test Contact 1',
      AccountId = accList[0].Id,
      Active__c = true //active contact
    );
    Contact contact6 = new Contact(
      LastName = 'Test Contact 6',
      AccountId = accList[0].Id,
      Active__c = true //active contact
    );
    Contact contact4 = new Contact(
      LastName = 'Test Contact 4',
      AccountId = accList[0].Id,
      Active__c = true //active contact
    );

    //Account 2 has one (TestName2) active contact
    Contact contact3 = new Contact(
      LastName = 'Test Contact 3',
      AccountId = accList[1].Id,
      Active__c = true // active contact
    );
    Contact contact2 = new Contact(
      LastName = 'Test Contact 2',
      AccountId = accList[1].Id
    );

    Contact contact5 = new Contact(
      LastName = 'Test Contact 5',
      AccountId = accList[1].Id
    );

    contactList.add(contact1); //active contact
    contactList.add(contact2);
    contactList.add(contact3); //active contact
    contactList.add(contact4); // active contact
    contactList.add(contact5);
    contactList.add(contact6); //active contact

    insert contactList;
    /*
     * Check if all contacts are Insertserted
     * Check if all Accounts are inserted
     */
    /*
    *Account 
    ------------------------------------------------------------------
    */
    List<account> accts = [
      SELECT Id, Name, Rating, Contact_Number__c
      FROM Account
    ];

    for (Account acc : accts) {
      if (acc.Name == 'TestName1') {
        System.assertEquals(
          3,
          acc.Contact_Number__c,
          'Exapected is not as the same as the actual number of Active Contacts in TestName1'
        );
      }
      if (acc.Name == 'TestName2') {
        System.assertEquals(
          1,
          acc.Contact_Number__c,
          'Exapected is not as the same as the actual number of Active Contacts in TestName2'
        );
      }
    }

    /*
    *Contacts
    ------------------------------------------------------------------
    */

    List<Contact> contacts = [
      SELECT Id, LastName, AccountId, Active__c
      FROM Contact
    ];

    for (Contact cnt : contacts) {
      if (cnt.LastName == 'Test Contact 1') {
        System.assertEquals(
          true,
          cnt.Active__c,
          'The Actual value is not Same as the Expected value'
        );
      }

      if (cnt.LastName == 'Test Contact 2') {
        System.assertEquals(
          false,
          cnt.Active__c,
          'The Actual value is not Same as the Expected value'
        );
      }
      if (cnt.LastName == 'Test Contact 3') {
        System.assertEquals(
          true,
          cnt.Active__c,
          'The Actual value is not Same as the Expected value'
        );
      }
      if (cnt.LastName == 'Test Contact 4') {
        System.assertEquals(
          true,
          cnt.Active__c,
          'The Actual value is not Same as the Expected value'
        );
      }
      if (cnt.LastName == 'Test Contact 5') {
        System.assertEquals(
          false,
          cnt.Active__c,
          'The Actual value is not Same as the Expected value'
        );
        if (cnt.LastName == 'Test Contact 6') {
          System.assertEquals(
            true,
            cnt.Active__c,
            'The Actual value is not Same as the Expected value'
          );
        }
      }
    }
  }
  @isTest
  public static void afterBulkInsertInsertTest3() {
    /* Account List for storing List of account records (3)*/

    List<Account> accountsList = new List<Account>();
    accountsList.add(new Account(Name = 'TestName1', Rating = 'Hot'));
    accountsList.add(new Account(Name = 'TestName2', Rating = 'Cold'));

    /*bul;k Testing data
     * Adding 1000 records Contacts record and associating them with Account 1
     * assigning Active__c = true  to all newly inserted contacts
     * adding Bulk Test Data For loops are required
     *Lable half all of the hot and Cold
     */

    List<Contact> contactsList = new List<Contact>();

    for (Integer i = 1; i <= 500; ++i) {
      ContactTriggerHandlerTest.generateRandomNumber();
      contactsList.add(
        new Contact(
          LastName = 'ContactTestName' + String.valueOf(i),
          AccountId = accountsList[
              ContactTriggerHandlerTest.generateRandomNumber()
            ]
            .Id,
          Active__c = true //active contact
        )
      );
    }

    /*Bulk Testing
     * Adding 1000 records Contacts record and associating them with Account 2
     * assigning Active__c = False  to all newly inserted contacts
     * adding Bulk Test Data For loops are required
     * choosing Randomly between 0 (included ) and 1 (included)
     */
    for (Integer i = 501; i <= 1000; ++i) {
      contactsList.add(
        new Contact(
          LastName = 'ContactTestName' + String.valueOf(i),
          AccountId = accountsList[
              ContactTriggerHandlerTest.generateRandomNumber()
            ]
            .Id,
          Active__c = false //active contact
        )
      );
    }

    insert contactsList;
    //Testing Account List
    System.assertEquals(
      2,
      AccountsList.size(),
      'The Actual value is not Same as the Expected value'
    );
    //Total number of Contacts test

    System.assertEquals(
      1000,
      contactsList.size(),
      'The Actual value is not Same as the Expected value'
    );
    /* Retrieving Active contacts and storing them in the active Contact List
     * ------------------------------------------------------------------------
     * -----------------------------------------------------------------------*/

    List<Contact> activeList = new List<Contact>();
    List<Contact> inactiveList = new List<Contact>();

    list<Contact> allContacts = [
      SELECT Id, LastName, AccountId, Active__c
      FROM Contact
    ];

    for (Contact ct : allContacts) {
      if (ct.active__c == true) {
        activeList.add(ct);
      }
      if (ct.active__c == false) {
        inactiveList.add(ct);
      }
    }

    System.AssertEquals(
      500,
      activeList.size(),
      'The Actual value is not Same as the Expected value'
    );
    System.AssertEquals(
      500,
      inactiveList.size(),
      'The Actual value is not Same as the Expected value'
    );

    //Total number of Active Contacts test
  }

  public static Integer generateRandomNumber() {
    Integer min = 0;
    Integer max = 1;
    Integer randomInt = Integer.valueOf(
      Math.floor(Math.random() * (max - min + 1) + min)
    );

    return randomInt;
  }
}
