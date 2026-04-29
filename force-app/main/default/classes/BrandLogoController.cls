/**
 * @description Centralized service/controller that provides brand identity data for UI components
 * (Lightning Web Components, Experience Cloud sites, and external integrations).
 * 
 * Provides safe null handling and fallback default values.
 * 
 * @author Jobet
 * @date 2026-04-29
 */
public with sharing class BrandLogoController {
    
    @TestVisible
    private static final String DEFAULT_BRAND_NAME = 'BayFront Hotel & Resorts';
    @TestVisible
    private static final String DEFAULT_TAGLINE = 'Luxury. Comfort. Experience.';
    
    @TestVisible
    private static Brand_Logo__mdt mockConfig;
    @TestVisible
    private static Boolean throwMockException = false;
    @TestVisible
    private static Map<String, Brand_Logo__mdt> mockAllMetadata;
    private static Brand_Logo__mdt cachedConfig;

    /**
     * Retrieves the Brand Name. 
     * Fallback to 'BayFront Hotel & Resorts' if not configured or empty.
     * @return String brand name
     */
    @AuraEnabled(cacheable=true)
    public static String getBrandName() {
        try {
            if (throwMockException) {
                throw new IllegalArgumentException('Mock Exception');
            }
            Brand_Logo__mdt brandConfig = getBrandConfig();
            if (brandConfig != null && String.isNotBlank(brandConfig.Brand_Name__c)) {
                return brandConfig.Brand_Name__c;
            }
        } catch (Exception e) {
            System.debug(LoggingLevel.ERROR, 'Error retrieving Brand Name: ' + e.getMessage());
        }
        return DEFAULT_BRAND_NAME;
    }

    /**
     * Retrieves the Logo URL.
     * @return String logo URL or empty string if not configured
     */
    @AuraEnabled(cacheable=true)
    public static String getLogoUrl() {
        try {
            if (throwMockException) {
                throw new IllegalArgumentException('Mock Exception');
            }
            Brand_Logo__mdt brandConfig = getBrandConfig();
            if (brandConfig != null && String.isNotBlank(brandConfig.Brand_Logo__c)) {
                return brandConfig.Brand_Logo__c;
            }
        } catch (Exception e) {
            System.debug(LoggingLevel.ERROR, 'Error retrieving Logo URL: ' + e.getMessage());
        }
        return '';
    }

    /**
     * Retrieves the optional Brand Tagline.
     * Fallback to 'Luxury. Comfort. Experience.'
     * @return String brand tagline
     */
    @AuraEnabled(cacheable=true)
    public static String getTagline() {
        // Tagline is optional and not currently defined in Custom Metadata schema.
        // Returning default fallback value.
        return DEFAULT_TAGLINE;
    }

    /**
     * Retrieves all brand data combined in a Map.
     * Useful for fetching multiple properties in a single server call.
     * @return Map<String, String> brand data mapping
     */
    @AuraEnabled(cacheable=true)
    public static Map<String, String> getBrandData() {
        Map<String, String> brandData = new Map<String, String>();
        brandData.put('brandName', getBrandName());
        brandData.put('logoUrl', getLogoUrl());
        brandData.put('tagline', getTagline());
        
        Brand_Logo__mdt config = getBrandConfig();
        Boolean hasRealName = (config != null && String.isNotBlank(config.Brand_Name__c));
        brandData.put('hasBrandName', String.valueOf(hasRealName));
        
        return brandData;
    }

    /**
     * Helper method to fetch and cache Custom Metadata configurations.
     * Bulk-safe design by caching the results in-memory.
     * @return Brand_Logo__mdt the first configuration record found
     */
    private static Brand_Logo__mdt getBrandConfig() {
        if (mockConfig != null) {
            return mockConfig;
        }
        if (cachedConfig == null) {
            Map<String, Brand_Logo__mdt> allMetadata = (mockAllMetadata != null) ? mockAllMetadata : Brand_Logo__mdt.getAll();
            
            if (allMetadata.containsKey('Bayfront_View_Hotel')) {
                cachedConfig = allMetadata.get('Bayfront_View_Hotel');
            } else if (!allMetadata.isEmpty()) {
                cachedConfig = allMetadata.values()[0];
            } else {
                cachedConfig = new Brand_Logo__mdt();
            }
        }
        return cachedConfig;
    }
}