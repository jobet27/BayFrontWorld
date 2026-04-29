import { LightningElement } from 'lwc';

export default class HomepageFooter extends LightningElement {
    currentYear = new Date().getFullYear();
    brandName = 'BayFront View';
}
