public interface TriggerInterface {
  void beforeInsert(List<SObject> newReclist);
  Void afterInsert(Map<Id, SObject> newRecordMap);
  void beforeUpdate(Map<Id, SObject> newRecMap, Map<Id, SObject> oldRecMap);
  void afterUpdate(Map<Id, SObject> newRecMap, Map<Id, SObject> oldRecMap);
  void beforeDelete(Map<Id, SObject> oldRecMap);
  void afterDelete(Map<Id, SObject> oldRecMap);
  void afterUndelete(Map<Id, SObject> olRecdMap);
}

