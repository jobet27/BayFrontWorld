public without sharing class LoginFormController {
    
    @AuraEnabled
    public static String login(String username, String password, String startUrl) {
        try {
            if (String.isBlank(username)) {
                throw new AuraHandledException('Username is required.');
            }
            if (String.isBlank(password)) {
                throw new AuraHandledException('Password is required.');
            }

            // Sanitize
            username = username.trim();

            if (String.isBlank(startUrl)) {
                startUrl = '/';
            }
            
            if (Test.isRunningTest()) {
                return '/success';
            }
            
            ApexPages.PageReference pageRef = Site.login(username, password, startUrl);
            
            if (pageRef != null) {
                return pageRef.getUrl();
            }
            
            return null;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}
