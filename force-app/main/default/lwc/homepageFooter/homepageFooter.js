import { LightningElement, track } from 'lwc';

export default class HomepageFooter extends LightningElement {
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
    currentYear = new Date().getFullYear();
    brandName = 'BayFront View';
}
