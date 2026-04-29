/**
 * @description Test class for BrandLogoController
 * 
 * @author Jobet
 * @date 2026-04-29
 */
@isTest
private class BrandLogoControllerTest {
    
    @isTest
    static void testGetBrandNameWithMock() {
        Brand_Logo__mdt mock = (Brand_Logo__mdt) JSON.deserialize(
            '{"Brand_Name__c":"Test Brand Name"}', 
            Brand_Logo__mdt.class
        );
        BrandLogoController.mockConfig = mock;

        Test.startTest();
        String brandName = BrandLogoController.getBrandName();
        Test.stopTest();

        System.assertEquals('Test Brand Name', brandName, 'The brand name should be retrieved from the configured record.');
    }

    @isTest
    static void testGetBrandNameFallback() {
        BrandLogoController.mockConfig = null;
        
        Test.startTest();
        String brandName = BrandLogoController.getBrandName();
        Test.stopTest();

        System.assertNotEquals(null, brandName, 'Brand name should not be null.');
    }

    @isTest
    static void testGetLogoUrlWithMock() {
        Brand_Logo__mdt mock = (Brand_Logo__mdt) JSON.deserialize(
            '{"Brand_Logo__c":"https://example.com/logo.png"}', 
            Brand_Logo__mdt.class
        );
        BrandLogoController.mockConfig = mock;

        Test.startTest();
        String logoUrl = BrandLogoController.getLogoUrl();
        Test.stopTest();

        System.assertEquals('https://example.com/logo.png', logoUrl, 'The logo URL should be retrieved from the configured record.');
    }

    @isTest
    static void testGetTagline() {
        Test.startTest();
        String tagline = BrandLogoController.getTagline();
        Test.stopTest();

        System.assertEquals(BrandLogoController.DEFAULT_TAGLINE, tagline, 'The tagline should match the default value.');
    }

    @isTest
    static void testGetBrandData() {
        Brand_Logo__mdt mock = (Brand_Logo__mdt) JSON.deserialize(
            '{"Brand_Name__c":"Test Brand Name", "Brand_Logo__c":"https://example.com/logo.png"}', 
            Brand_Logo__mdt.class
        );
        BrandLogoController.mockConfig = mock;

        Test.startTest();
        Map<String, String> brandData = BrandLogoController.getBrandData();
        Test.stopTest();

        System.assertEquals('Test Brand Name', brandData.get('brandName'), 'Brand name should match mock.');
        System.assertEquals('https://example.com/logo.png', brandData.get('logoUrl'), 'Logo URL should match mock.');
        System.assertEquals(BrandLogoController.DEFAULT_TAGLINE, brandData.get('tagline'), 'Tagline should match default.');
    }

    @isTest
    static void testExceptionHandling() {
        BrandLogoController.mockConfig = null;
        BrandLogoController.throwMockException = true;

        Test.startTest();
        String brandName = BrandLogoController.getBrandName();
        String logoUrl = BrandLogoController.getLogoUrl();
        Test.stopTest();

        System.assertEquals(BrandLogoController.DEFAULT_BRAND_NAME, brandName, 'Fallback brand name expected on exception.');
        System.assertEquals('', logoUrl, 'Empty logo URL expected on exception.');
    }

    @isTest
    static void testGetAllFallbackWithSpecificRecord() {
        BrandLogoController.mockConfig = null;
        BrandLogoController.throwMockException = false;
        
        Brand_Logo__mdt mockRecord = (Brand_Logo__mdt) JSON.deserialize(
            '{"Brand_Name__c":"Specific Record"}', 
            Brand_Logo__mdt.class
        );
        Map<String, Brand_Logo__mdt> mockMap = new Map<String, Brand_Logo__mdt>{
            'Bayfront_View_Hotel' => mockRecord
        };
        BrandLogoController.mockAllMetadata = mockMap;

        Test.startTest();
        String brandName = BrandLogoController.getBrandName();
        Test.stopTest();

        System.assertEquals('Specific Record', brandName, 'Should retrieve from the specific record matching DeveloperName.');
    }

    @isTest
    static void testGetAllFallbackWithAnyRecord() {
        BrandLogoController.mockConfig = null;
        BrandLogoController.throwMockException = false;
        
        Brand_Logo__mdt mockRecord = (Brand_Logo__mdt) JSON.deserialize(
            '{"Brand_Name__c":"Any Record"}', 
            Brand_Logo__mdt.class
        );
        Map<String, Brand_Logo__mdt> mockMap = new Map<String, Brand_Logo__mdt>{
            'Other_Hotel_Config' => mockRecord
        };
        BrandLogoController.mockAllMetadata = mockMap;

        Test.startTest();
        String brandName = BrandLogoController.getBrandName();
        Test.stopTest();

        System.assertEquals('Any Record', brandName, 'Should fallback to the first record in the map.');
    }

    @isTest
    static void testGetAllFallbackWithNoRecord() {
        BrandLogoController.mockConfig = null;
        BrandLogoController.throwMockException = false;
        BrandLogoController.mockAllMetadata = new Map<String, Brand_Logo__mdt>();

        Test.startTest();
        String brandName = BrandLogoController.getBrandName();
        Test.stopTest();

        System.assertEquals(BrandLogoController.DEFAULT_BRAND_NAME, brandName, 'Should fallback to default brand name when no records exist.');
    }
}
