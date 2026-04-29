import { LightningElement, api } from 'lwc';

export default class HeroOverlay extends LightningElement {
    @api title = '';
    @api subtitle = '';
    @api alignLeft = false;

    get overlayClass() {
        return this.alignLeft ? 'hero-overlay align-left' : 'hero-overlay align-center';
    }
}