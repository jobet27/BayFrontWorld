import { LightningElement } from 'lwc';
import BAYFRONT_HERO from '@salesforce/resourceUrl/bayfront_hero';

export default class HomepageExperiences extends LightningElement {
    experiences = [
        {
            id: 1,
            title: 'Celestial Spa & Wellness',
            category: 'REJUVENATE',
            image: BAYFRONT_HERO
        },
        {
            id: 2,
            title: 'Savor Michelin Dining',
            category: 'CUISINE',
            image: BAYFRONT_HERO
        },
        {
            id: 3,
            title: 'Infinity Ocean Tours',
            category: 'ADVENTURE',
            image: BAYFRONT_HERO
        }
    ];
}
