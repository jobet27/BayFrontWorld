@isTest
public class HomepageHeroControllerTest {
    
    @isTest
    static void testGetHeroData() {
        Test.startTest();
        HomepageHeroController controller = new HomepageHeroController();
        Map<String, String> data = controller.getHeroData();
        Test.stopTest();
        
        System.assertNotEquals(null, data, 'Data should not be null');
        System.assertEquals('Experience Luxury by the Bay', data.get('heroTitle'), 'Title should match');
        System.assertEquals('Where comfort meets the ocean', data.get('heroSubtitle'), 'Subtitle should match');
        System.assert(String.isNotBlank(data.get('heroImageUrl')), 'Image URL should not be blank');
    }
    
    @isTest
    static void testGetHomepageHeroStatic() {
        Test.startTest();
        Map<String, String> data = HomepageHeroController.getHomepageHero();
        Test.stopTest();
        
        System.assertNotEquals(null, data, 'Data should not be null');
        System.assertEquals('Experience Luxury by the Bay', data.get('heroTitle'), 'Title should match');
    }
}
