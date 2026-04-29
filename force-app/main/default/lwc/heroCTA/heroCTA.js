import { LightningElement, api } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';

export default class HeroCTA extends NavigationMixin(LightningElement) {
    @api buttonLabel = 'Book Now';
    @api url = '';

    handleClick() {
        if (this.url) {
            this[NavigationMixin.Navigate]({
                type: 'standard__webPage',
                attributes: {
                    url: this.url
                }
            });
        }
        
        this.dispatchEvent(new CustomEvent('ctaclick', {
            detail: { url: this.url }
        }));
    }
}
