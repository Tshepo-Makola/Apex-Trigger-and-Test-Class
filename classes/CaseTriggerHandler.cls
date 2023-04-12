public with sharing class CaseTriggerHandler implements TriggerInterface {

   public void beforeInsert(List<SObject> newReclist)
   {
    return ;
   }
   public  Void afterInsert(Map<Id, SObject> newRecordMap){

    CaseTriggerHelper.aILatestCaseNumToAccount((Map<Id, Case>) newRecordMap);
    }
    public void beforeUpdate(Map<Id, SObject> newRecMap, Map<Id, SObject> oldRecMap)
    {
        return ;
    }
    public void afterUpdate(Map<Id, SObject> newRecMap, Map<Id, SObject> oldRecMap)
    {
        return;
    }
    public void beforeDelete(Map<Id, SObject> oldRecMap)
    {
        return ;
    }
    public void afterDelete(Map<Id, SObject> oldRecMap)
    {
        return ;
    }
    public void afterUndelete(Map<Id, SObject> olRecdMap)
    {
        return ;
    }
}