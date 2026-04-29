import { LightningElement, wire, track, api } from 'lwc';
import getBrandData from '@salesforce/apex/BrandLogoController.getBrandData';

export default class HeroLogo extends LightningElement {
    @api showText = false;
    @track logoUrl = '';
    @track brandName = 'BayFront Hotel & Resorts';

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