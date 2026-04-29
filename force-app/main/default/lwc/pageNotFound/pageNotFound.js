import { LightningElement } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';

export default class PageNotFound extends NavigationMixin(LightningElement) {
    handleHomeClick() {
        try {
            this[NavigationMixin.Navigate]({
                type: 'standard__namedPage',
                attributes: {
                    pageName: 'home'
                }
            });
        } catch (error) {
            window.location.href = '/';
        }
        
        // Fallback in case NavigationMixin doesn't execute
        setTimeout(() => {
            window.location.href = '/';
        }, 500);
    }
}
