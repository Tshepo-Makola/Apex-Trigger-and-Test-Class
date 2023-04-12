public class AccountTriggerHandler implements TriggerInterface {
  
  public void beforeInsert(List<SObject> newReclist) {
    //Make sure Typecast record list to Account
    AccountTriggerHelper.beforeInserUpdateRating((List<Account>) newReclist);
    AccountTriggerHelper.biCopyBillingAddressTOShippingAddress((List<Account>) newReclist);

  }
  public Void afterInsert(Map<Id, SObject> newRecordMap) {
    AccountTriggerHelper.aICreateRelatedCon( (Map<Id, Account>) newRecordMap);
    AccountTriggerHelper.aICreateRelatedOpp( (Map<Id, Account>) newRecordMap);
  }
  public void beforeUpdate(
    Map<Id, SObject> newRecMap, Map<Id, SObject> oldRecMap
  ) {
    return;
  }
  public void afterUpdate(
    Map<Id, SObject> newRecMap, Map<Id, SObject> oldRecMap
  ) {
    return;
  }
  public void beforeDelete(Map<Id, SObject> oldRecMap) {
    return;
  }
  public void afterDelete(Map<Id, SObject> oldRecMap) {
    return;
  }
  public void afterUndelete(Map<Id, SObject> olRecdMap) {
    return;
  }
}
