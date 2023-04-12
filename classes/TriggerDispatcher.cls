public class TriggerDispatcher {
  /**": This is the header for the "execute" method, which is a public method that takes in two parameters.
   * The first parameter is of type "TriggerInterface" and represents the trigger handler that will be called.
   * The second parameter is of type "System.TriggerOperation" and represents the type of operation that
   * is being performed (such as before insert, after update, etc.).*/

  public static void run(
    TriggerInterface hanlder,
    system.Triggeroperation operationType
  ) {
    switch on operationType {
      when BEFORE_INSERT {
        hanlder.beforeInsert(Trigger.new);
      }
      when AFTER_INSERT {
        hanlder.afterInsert(Trigger.newMap);
      }
      when BEFORE_UPDATE {
        hanlder.beforeUpdate(Trigger.newMap, Trigger.oldMap);
      }
      when AFTER_UPDATE {
        hanlder.beforeUpdate(Trigger.newMap, Trigger.oldMap);
      }
      when BEFORE_DELETE {
        hanlder.beforeDelete(Trigger.oldMap);
      }
      when AFTER_DELETE {
        hanlder.afterDelete(Trigger.oldMap);
      }
      when AFTER_UNDELETE {
        hanlder.afterUndelete(Trigger.newMap);
      }
    }
  }

	/*public static void run(OpportunityTriggerHandler o, System.TriggerOperation t){
	} */
}
