/**
 * @description Controller for the homepage hero section.
 * Extends BaseHeroController to provide specific content for the homepage.
 */
public with sharing class HomepageHeroController extends BaseHeroController {
    
    /**
     * @description Override getHeroData to fetch homepage-specific hero details.
     * @return Map<String, String> containing hero data
     */
    public override Map<String, String> getHeroData() {
        Map<String, String> data = new Map<String, String>();
        
        this.heroTitle = sanitizeOutput('Experience Luxury by the Bay');
        this.heroSubtitle = sanitizeOutput('Where comfort meets the ocean');
        
        // Attempt to fetch from Custom Metadata
        try {
            List<Brand_Logo__mdt> allMetadata = Brand_Logo__mdt.getAll().values();
            Brand_Logo__mdt heroConfig = null;
            for (Brand_Logo__mdt config : allMetadata) {
                if (config.DeveloperName == 'Hero') {
                    heroConfig = config;
                    break;
                }
            }
            if (heroConfig == null && !allMetadata.isEmpty()) {
                heroConfig = allMetadata[0];
            }
            if (heroConfig != null && String.isNotBlank(heroConfig.Brand_Logo__c)) {
                this.heroImageUrl = sanitizeOutput(heroConfig.Brand_Logo__c);
            } else {
                this.heroImageUrl = getDefaultImage();
            }
        } catch (Exception e) {
            System.debug(LoggingLevel.ERROR, 'Error fetching Hero Metadata: ' + e.getMessage());
            this.heroImageUrl = getDefaultImage();
        }
        
        data.put('heroTitle', this.heroTitle);
        data.put('heroSubtitle', this.heroSubtitle);
        data.put('heroImageUrl', this.heroImageUrl);
        
        return data;
    }
    
    /**
     * @description AuraEnabled method for LWCs to retrieve homepage hero data.
     * @return Map<String, String> Hero data
     */
    @AuraEnabled(cacheable=true)
    public static Map<String, String> getHomepageHero() {
        HomepageHeroController controller = new HomepageHeroController();
        return controller.getHeroData();
    }
}
