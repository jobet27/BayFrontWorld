import { LightningElement, api } from 'lwc';

export default class Navlinks extends LightningElement {
    @api isMenuOpen = false;
    
    get menuClass() {
        return this.isMenuOpen ? 'nav-menu active' : 'nav-menu';
    }

    toggleDropdown(event) {
        event.preventDefault();
        const dropdownItem = event.currentTarget.parentElement;
        
        const allDropdowns = this.template.querySelectorAll('.nav-item.dropdown');
        allDropdowns.forEach(item => {
            if (item !== dropdownItem && item.classList.contains('active')) {
                item.classList.remove('active');
                item.querySelector('.dropdown-toggle').setAttribute('aria-expanded', 'false');
            }
        });

        const isOpen = dropdownItem.classList.toggle('active');
        event.currentTarget.setAttribute('aria-expanded', isOpen ? 'true' : 'false');
    }

    handleHomeClick(event) {
        event.preventDefault();
        this.dispatchEvent(new CustomEvent('navhome'));
        this.closeAllDropdowns();
    }

    handleLinkClick(event) {
        event.preventDefault();
        const href = event.currentTarget.getAttribute('href');
        this.dispatchEvent(new CustomEvent('navclick', { detail: { href } }));
        this.closeAllDropdowns();
    }

    closeAllDropdowns() {
        const allDropdowns = this.template.querySelectorAll('.nav-item.dropdown');
        allDropdowns.forEach(item => {
            item.classList.remove('active');
            item.querySelector('.dropdown-toggle').setAttribute('aria-expanded', 'false');
        });
    }
}