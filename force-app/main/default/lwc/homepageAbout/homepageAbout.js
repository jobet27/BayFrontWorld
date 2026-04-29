import { LightningElement } from 'lwc';
import BAYFRONT_HERO from '@salesforce/resourceUrl/bayfront_hero';

export default class HomepageAbout extends LightningElement {
    aboutTitle = 'Sanctuary of the Soul';
    aboutSubtitle = 'DISCOVER BAYFRONT';
    aboutDescription = 'Nestled on the pristine white sands of the coast, BayFront offers a breathtaking escape where modern luxury meets raw tropical beauty. Every detail of our resort is crafted to create an atmosphere of pure serenity and effortless elegance.';
    
    get imageUrl() {
        return BAYFRONT_HERO;
    }
}
