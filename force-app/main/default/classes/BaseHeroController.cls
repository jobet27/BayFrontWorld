/**
 * @description Abstract base class for managing hero images and content across different pages
 * for the BayFront Hotel & Resorts hospitality system.
 */
public abstract class BaseHeroController {
    
    // Common properties
    public String heroTitle { get; protected set; }
    public String heroSubtitle { get; protected set; }
    public String heroImageUrl { get; protected set; }
    
    /**
     * @description Default constructor ensuring null safety
     */
    protected BaseHeroController() {
        this.heroTitle = '';
        this.heroSubtitle = '';
        this.heroImageUrl = getDefaultImage();
    }
    
    /**
     * @description Abstract method to be implemented by child classes to fetch page-specific hero data.
     * @return Map<String, String> containing the hero data (title, subtitle, imageUrl)
     */
    public abstract Map<String, String> getHeroData();
    
    /**
     * @description Returns the default fallback hero image URL.
     * @return String URL of the default hero image
     */
    protected virtual String getDefaultImage() {
        try {
            List<Brand_Logo__mdt> allMetadata = Brand_Logo__mdt.getAll().values();
            for (Brand_Logo__mdt config : allMetadata) {
                if (config.DeveloperName == 'Hero' && String.isNotBlank(config.Brand_Logo__c)) {
                    return sanitizeOutput(config.Brand_Logo__c);
                }
            }
        } catch (Exception e) {
            System.debug(LoggingLevel.ERROR, 'Error fetching default hero image: ' + e.getMessage());
        }
        return '/resource/bayfront_hero';
    }
    
    /**
     * @description Sanitizes string output to prevent XSS and ensure clean data.
     * @param input The string to sanitize
     * @return String The sanitized string
     */
    protected String sanitizeOutput(String input) {
        if (String.isBlank(input)) {
            return '';
        }
        return String.escapeSingleQuotes(input.trim());
    }
    
    /**
     * @description Private inner concrete class to provide a default implementation.
     */
    private class DefaultHeroController extends BaseHeroController {
        public override Map<String, String> getHeroData() {
            Map<String, String> data = new Map<String, String>();
            this.heroTitle = sanitizeOutput('Welcome to BayFront');
            this.heroSubtitle = sanitizeOutput('Luxury. Serenity. Aspirational living.');
            this.heroImageUrl = sanitizeOutput('/resource/bayfront_hero');
            
            data.put('heroTitle', this.heroTitle);
            data.put('heroSubtitle', this.heroSubtitle);
            data.put('heroImageUrl', this.heroImageUrl);
            return data;
        }
    }
    
    /**
     * @description AuraEnabled method for LWCs to retrieve hero data using the default implementation.
     * @return Map<String, String> Hero data
     */
    @AuraEnabled(cacheable=true)
    public static Map<String, String> fetchHeroData() {
        BaseHeroController controller = new DefaultHeroController();
        return controller.getHeroData();
    }
}
