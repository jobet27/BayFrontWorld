import { LightningElement, api, wire } from 'lwc';
import getBrandData from '@salesforce/apex/BrandLogoController.getBrandData';

export default class NavbarBrand extends LightningElement {
    @api brandText; // Keep for backward compatibility

    brandName;
    logoUrl;
    tagline;

    hasBrandName = false;

    @wire(getBrandData)
    wiredBrandData({ error, data }) {
        if (data) {
            this.brandName = data.brandName;
            this.logoUrl = data.logoUrl;
            this.tagline = data.tagline;
            this.hasBrandName = (data.hasBrandName === 'true');
        } else if (error) {
            console.error('Error loading brand data:', error);
            this.brandName = this.brandText || 'BayFront Hotel & Resorts';
            this.hasBrandName = false;
        }
    }

    get displayBrandText() {
        return this.brandName || this.brandText || 'BayFront Hotel & Resorts';
    }

    handleHomeClick(event) {
        event.preventDefault();
        this.dispatchEvent(new CustomEvent('homeclick'));
    }
}