import { LightningElement, api } from 'lwc';

export default class CtaButton extends LightningElement {
    @api buttonText = 'Book Now';

    handleClick() {
        this.dispatchEvent(new CustomEvent('buttonclick'));
    }
}