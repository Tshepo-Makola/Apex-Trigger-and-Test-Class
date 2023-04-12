public with sharing class CaseTriggerHelper {

    /*
    *[6] After Insert | Populate Latest Case No on Account on Case creation
    */
    public static void aILatestCaseNumToAccount(Map<Id, Case> newRecordMap){

    List<Account> accountList = new List<Account>();

    for (Case cs : newRecordMap.values()) {
        Account acc = new Account();
        acc.Id = cs.AccountId;
        acc.Latetest_Case_Number__c	 = cs.CaseNumber;
        accountList.add(acc);
        }
        //Schema.SObjectType.Account.isCreatable() is used to check if the Account object is creatable or not
        if (Account.SObjectType.getDescribe().isUpdateable()) {
        if(!accountList.isEmpty()) {
                update accountList;
            }
            
        }
    }

    }

