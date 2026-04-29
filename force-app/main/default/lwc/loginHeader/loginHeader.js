import { LightningElement, wire } from 'lwc';
import getBrandData from '@salesforce/apex/BrandLogoController.getBrandData';

export default class LoginHeader extends LightningElement {
    brandName;
    logoUrl;
    tagline;

    @wire(getBrandData)
    wiredBrandData({ error, data }) {
        if (data) {
            this.brandName = data.brandName;
            this.logoUrl = data.logoUrl;
            this.tagline = data.tagline;
        } else if (error) {
            console.error('Error loading brand data:', error);
            this.brandName = 'BayFront Hotel & Resorts';
        }
    }

    get displayBrandText() {
        return this.brandName || 'BayFront Hotel & Resorts';
    }

    handleHomeClick(event) {
        event.preventDefault();
        window.location.href = '/';
    }
}
