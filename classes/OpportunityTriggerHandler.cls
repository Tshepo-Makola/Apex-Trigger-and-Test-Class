 public class OpportunityTriggerHandler implements TriggerInterface {
  
        public void beforeInsert(List<SObject> newReclist) {
          //Make sure Typecast record list to Opprtunity
          OpportunityTriggerHelper.beforeInsertUpdateOpportunityDesc((List<Opportunity>) newReclist);
         
      
        }
        public Void afterInsert(Map<Id, SObject> newRecordMap) {
       
          OpportunityTriggerHelper.aIAddOppToAccount((Map<Id,Opportunity>)newRecordMap);
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
      