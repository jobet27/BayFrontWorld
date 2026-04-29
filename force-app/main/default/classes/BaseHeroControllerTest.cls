@isTest
public class BaseHeroControllerTest {
    
    // Concrete test implementation of the abstract class
    private class TestHeroController extends BaseHeroController {
        public override Map<String, String> getHeroData() {
            Map<String, String> data = new Map<String, String>();
            this.heroTitle = sanitizeOutput('Test Title');
            this.heroSubtitle = sanitizeOutput('Test Subtitle');
            this.heroImageUrl = sanitizeOutput('https://example.com/test.png');
            
            data.put('heroTitle', this.heroTitle);
            data.put('heroSubtitle', this.heroSubtitle);
            data.put('heroImageUrl', this.heroImageUrl);
            return data;
        }

        public String testSanitizeOutput(String input) {
            return sanitizeOutput(input);
        }
    }

    @isTest
    static void testBaseHeroControllerLogic() {
        Test.startTest();
        TestHeroController controller = new TestHeroController();
        Map<String, String> data = controller.getHeroData();
        Test.stopTest();
        
        System.assertNotEquals(null, data, 'Data should not be null');
        System.assertEquals('Test Title', data.get('heroTitle'), 'Title should be sanitized');
        System.assertEquals('Test Subtitle', data.get('heroSubtitle'), 'Subtitle should be sanitized');
        System.assertEquals('https://example.com/test.png', data.get('heroImageUrl'), 'Image URL should be sanitized');
    }
    
    @isTest
    static void testSanitizeOutput() {
        Test.startTest();
        TestHeroController controller = new TestHeroController();
        String result = controller.testSanitizeOutput('  Test Input with spaces  ');
        String nullResult = controller.testSanitizeOutput(null);
        Test.stopTest();
        
        System.assertEquals('Test Input with spaces', result, 'Should trim spaces');
        System.assertEquals('', nullResult, 'Should return empty string on null');
    }

    @isTest
    static void testFetchHeroDataStatic() {
        Test.startTest();
        Map<String, String> data = BaseHeroController.fetchHeroData();
        Test.stopTest();
        
        System.assertNotEquals(null, data, 'Data should not be null');
        System.assertEquals('Welcome to BayFront', data.get('heroTitle'), 'Title should match default');
    }
}
