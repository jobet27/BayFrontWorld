import { LightningElement, wire, track, api } from 'lwc';
import getHomepageHero from '@salesforce/apex/HomepageHeroController.getHomepageHero';
import BAYFRONT_HERO from '@salesforce/resourceUrl/bayfront_hero';

export default class HeroBanner extends LightningElement {
    @api title = 'Experience Luxury by the Bay';
    @api subtitle = 'Where comfort meets the ocean';
    @api imageUrl = BAYFRONT_HERO;
    @api bookingUrl = '/booking';

    @track error;

    @wire(getHomepageHero)
    wiredHeroData({ error, data }) {
        if (data) {
            this.title = data.heroTitle || this.title;
            this.subtitle = data.heroSubtitle || this.subtitle;
            this.imageUrl = data.heroImageUrl || this.imageUrl;
            this.error = undefined;
        } else if (error) {
            this.error = error;
            console.error('Error fetching hero data:', error);
        }
    }
}
