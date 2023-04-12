public with sharing class OpportunityTriggerHelper {
   
    /* 
     *[2] Before Insert | Populate Description on Opportunity Creation based on Amount value
    */ 
        public static void beforeInsertUpdateOpportunityDesc(List<Opportunity> opportunityList)
        {
            
            for (Opportunity opp : opportunityList) { 
                if (opp.Amount >= 100000 && opp.Amount <= 500000)
                {
                    opp.Description = 'Hot opportunity';
                }
                else if(opp.Amount <= 100000){
                    opp.Description = 'Cold opportunity';
                }
           
            }
           
        }
        /*
         * [7] After Insert | Populate Latest Opportunity Amount on Account 
         * on Opportunity Creation
        */
       public static void aIAddOppToAccount(Map<Id,Opportunity> newMap) {
        
        List<Account> accountList = new List<Account>();

        for(Opportunity opp : newMap.values()){
            if(opp.Amount != null && opp.AccountId != null){
                Account account = new Account();
                account.Id = opp.AccountId;
                account.Latest_Opportunity_Amount__c = opp.Amount;
                accountList.add(account);
            }
       }
       //Schema.SObjectType.Account.isUpdateable()
       if(Account.sObjectType.getDescribe().isUpdateable()) {
             if(!accountList.isEmpty()){
                update accountList;
             }
       }

    }
}