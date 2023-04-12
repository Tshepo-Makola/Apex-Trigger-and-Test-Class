# Apex-Trigger-and-Test-Class
Answering Scenarios from Sanjay Gupta Tech School  https://www.youtube.com/playlist?list=PL-gW8Fj5TGroRDGRx53DqVE9Lz-cTVVMJ
Take note that I have used a Custom Trigger Framework unlike the Sanjay Gupta , The approaches of solving the problems 
Differs from Sanjay Gupta's but the Outcome is the same 
Have created a Custom Trigger Framework 
The Trigger frameWork  is made up of 

-Trigger Interface 
*All the trigger Handlers must implement this interface 

-Trigger Dispartcher 
   * has  the "execute" method, which is a public method that takes in two parameters.
   * The first parameter is of type "TriggerInterface" and represents the trigger handler that will be called.
   * The second parameter is of type "System.TriggerOperation" and represents the type of operation that
   * is being performed (such as before insert, after update, etc.).*/
   *This is acts as a mediator between Trigger handler and the Trigger

-Trigger Helper
  * This is where we implement the logic for the trigger and The function must be called into the Trigger Hangler Class
  *This class is there to avoid messy code inside the trigger Handler Class.


-Trigger Handler 
  * This class is there to manage the execution of Apex triggers (Before insert , after insert ...etc). 
  * This receives a function from TriggerHelperclass(contains the logic of the trigger) 
 

note that you get just return; nothing to avoid the code from failing to committed to the org if you haven't implemented a trigger handler for 
The for an trigger event.
e.g 
public Void afterInsert(Map<Id, SObject> newRecordMap) {
       
          OpportunityTriggerHelper.aIAddOppToAccount((Map<Id,Opportunity>)newRecordMap);
        }
        public void beforeUpdate(
          Map<Id, SObject> newRecMap, Map<Id, SObject> oldRecMap
        ) {
          return;
        }
        ......................................................................................
-Trigger  
  
  The main logic of the trigger is contained in the method from  to "TriggerDispatcher class , which takes two arguments.
   * The first argument is a new instance of the "TriggerHandler" class, which is the class that contains the business logic for the trigger.
  * The second argument is "Trigger.operationType", which is a built-in variable in Salesforce that 
  represents the type of operation that caused the trigger to fire (e.g. "INSERT", "UPDATE", "DELETE", etc.).
