@IsTest
public class LoginFormControllerTest {
    @IsTest
    static void testLogin() {
        Test.startTest();
        String result = LoginFormController.login('test@test.com', 'password', '/');
        System.assertEquals('/success', result, 'Login should return success in test context');
        
        try {
            LoginFormController.login('', 'password', '/');
            System.assert(false, 'Should throw exception for empty username');
        } catch (AuraHandledException e) {
            System.assert(true);
        }
        Test.stopTest();
    }
}
