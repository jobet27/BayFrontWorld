@IsTest
public class SignupControllerTest {
    @IsTest
    static void testCreateContact() {
        Test.startTest();
        String contactId = SignupController.createContact('John', 'Doe', 'john.doe@test.com');
        System.assertNotEquals(null, contactId);
        Test.stopTest();
    }

    @IsTest
    static void testEnableCustomerUser() {
        Account a = new Account(Name = 'Test Account');
        insert a;
        Contact c = new Contact(FirstName = 'John', LastName = 'Doe', Email = 'john.doe@test.com', AccountId = a.Id);
        insert c;
        
        Test.startTest();
        String result = SignupController.enableCustomerUser(c.Id, 'password123');
        System.assertEquals('/success', result);
        Test.stopTest();
    }
}
