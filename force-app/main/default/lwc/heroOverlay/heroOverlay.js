import { LightningElement, api, track } from 'lwc';

export default class HeroOverlay extends LightningElement {
    @api title = '';
    @api subtitle = '';
    @api alignLeft = false;
    @track isHidden = false;

    connectedCallback() {
        if (window.location.pathname.includes('error') || 
            window.location.pathname.includes('404') || 
            window.location.pathname.includes('not-found') ||
            window.location.pathname.includes('login') ||
            window.location.pathname.includes('signup') ||
            window.location.pathname.includes('SelfRegister')) {
            this.isHidden = true;
        }
    }

    get overlayClass() {
        return this.alignLeft ? 'hero-overlay align-left' : 'hero-overlay align-center';
    }
}