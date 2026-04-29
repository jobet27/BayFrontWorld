import { LightningElement, api, track } from 'lwc';

export default class HeroImage extends LightningElement {
    @api imageUrl = '';
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
}
