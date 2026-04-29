import { LightningElement, wire, track } from 'lwc';
import getHomepageHero from '@salesforce/apex/HomepageHeroController.getHomepageHero';
import BAYFRONT_HERO from '@salesforce/resourceUrl/bayfront_hero';

export default class HeroComponent extends LightningElement {
    @track heroTitle = 'Experience Luxury by the Bay';
    @track heroSubtitle = 'Where comfort meets the ocean';
    @track heroImageUrl = BAYFRONT_HERO;
    @track error;

    @wire(getHomepageHero)
    wiredHeroData({ error, data }) {
        if (data) {
            this.heroTitle = data.heroTitle || 'Experience Luxury by the Bay';
            this.heroSubtitle = data.heroSubtitle || 'Where comfort meets the ocean';
            this.heroImageUrl = data.heroImageUrl || BAYFRONT_HERO;
            this.error = undefined;
        } else if (error) {
            this.error = error;
            console.error('Error fetching hero data:', error);
        }
    }

    get backgroundStyle() {
        return `background-image: url(${this.heroImageUrl});`;
    }
}