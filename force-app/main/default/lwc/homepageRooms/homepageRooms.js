import { LightningElement, track } from 'lwc';
import BAYFRONT_HERO from '@salesforce/resourceUrl/bayfront_hero';

export default class HomepageRooms extends LightningElement {
    @track isHidden = false;

    connectedCallback() {
        if (window.location.pathname.includes('error') || 
            window.location.pathname.includes('404') || 
            window.location.pathname.includes('not-found')) {
            this.isHidden = true;
        }
    }
    rooms = [
        {
            id: 1,
            name: 'Oceanfront Sunset Villa',
            price: '₱35,000',
            description: 'Private infinity pool, panoramic ocean views, and direct beach access.',
            image: BAYFRONT_HERO
        },
        {
            id: 2,
            name: 'Grand Deluxe Suite',
            price: '₱25,000',
            description: 'Elegantly furnished with a spacious living area and private terrace.',
            image: BAYFRONT_HERO
        },
        {
            id: 3,
            name: 'Panoramic Skyline Room',
            price: '₱15,000',
            description: 'Modern aesthetic with floor-to-ceiling windows overlooking the coast.',
            image: BAYFRONT_HERO
        }
    ];
}
