import { LightningElement, wire, track, api } from 'lwc';
import getBrandData from '@salesforce/apex/BrandLogoController.getBrandData';

export default class HeroLogo extends LightningElement {
    @api showText = false;
    @track logoUrl = '';
    @track brandName = 'BayFront Hotel & Resorts';
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

    @wire(getBrandData)
    wiredBrandData({ error, data }) {
        if (data) {
            this.logoUrl = data.logoUrl;
            this.brandName = data.brandName;
        } else if (error) {
            console.error('Error fetching brand data:', error);
        }
    }
}