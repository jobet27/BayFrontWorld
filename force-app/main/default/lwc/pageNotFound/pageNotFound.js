import { LightningElement } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';

export default class PageNotFound extends NavigationMixin(LightningElement) {
    handleHomeClick() {
        this[NavigationMixin.Navigate]({
            type: 'standard__namedPage',
            attributes: {
                pageName: 'home'
            }
        });
    }
}
