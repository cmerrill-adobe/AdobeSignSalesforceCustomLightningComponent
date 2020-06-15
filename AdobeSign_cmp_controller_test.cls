@isTest
private class AdobeSign_cmp_controller_test {
    
    @testSetup static void setup() {
        echosign_dev1__Agreement_Template__c t = new echosign_dev1__Agreement_Template__c();
        t.Name = 'test template';
        t.echosign_dev1__Master_Object_Type__c = 'Account';
        insert t;
        
        Account a = new Account();
        a.Name = 'test account';
        insert a;
    }

	private static testMethod void test() {

        Test.startTest();
        
            echosign_dev1__Agreement_Template__c t = [SELECT id FROM echosign_dev1__Agreement_Template__c WHERE name = 'test template' LIMIT 1];
            Account a = [SELECT id FROM Account WHERE name = 'test account' limit 1];
            
            List<echosign_dev1__Agreement_Template__c> ts = AdobeSign_cmp_controller.templates( a.id );
            system.assertEquals( ts.size(), 1 ); 
            
            ts = AdobeSign_cmp_controller.templates( '' );
            
            string objectName = AdobeSign_cmp_controller.objectName( a.id );
            system.assertNotEquals( objectName, null );
            
            string noObject = AdobeSign_cmp_controller.objectName( '' );
            system.assertEquals( noObject, null );
            
            id agreementId = AdobeSign_cmp_controller.createAgreement( t.id, a.id );
            system.assertNotEquals( agreementId, null );
            
            string testLabel = AdobeSign_cmp_controller.objectLabel('blank-object');
            system.assertEquals( testLabel, '' ); 
            
            List<echosign_dev1__SIGN_Agreement__c> agreements = AdobeSign_cmp_controller.agreements( a.id );
            system.assertEquals( agreements.size(), 1 ); 
        
        Test.stopTest();   
        
       
         

	}

}