import { LightningElement, track, api } from 'lwc';

export default class Navbar extends LightningElement {
    @api brandText = 'BayFront Hotel & Resorts';
    @api bookNowText = 'Book Now';
    @api bookingUrl = '/booking';
    @track isScrolled = false;
    @track isHidden = false;
    @track isMenuOpen = false;

    connectedCallback() {
        if (window.location.pathname.includes('error') || 
            window.location.pathname.includes('404') || 
            window.location.pathname.includes('not-found') ||
            window.location.pathname.includes('login') ||
            window.location.pathname.includes('signup') ||
            window.location.pathname.includes('SelfRegister')) {
            this.isHidden = true;
        }
        window.addEventListener('scroll', this.handleScroll);
    }

    disconnectedCallback() {
        window.removeEventListener('scroll', this.handleScroll);
    }

    handleScroll = () => {
        if (window.scrollY > 50) {
            this.isScrolled = true;
        } else {
            this.isScrolled = false;
        }
    };

    get navClass() {
        let classes = 'navbar';
        if (this.isScrolled) {
            classes += ' scrolled';
        }
        if (this.isMenuOpen) {
            classes += ' menu-open';
        }
        return classes;
    }

    get menuClass() {
        return this.isMenuOpen ? 'nav-menu active' : 'nav-menu';
    }

    get hamburgerClass() {
        return this.isMenuOpen ? 'hamburger active' : 'hamburger';
    }

    toggleMobileMenu() {
        this.isMenuOpen = !this.isMenuOpen;
    }

    handleHomeClick() {
        console.log('Navigate to Home');
        this.isMenuOpen = false;
    }

    handleLinkClick(event) {
        const href = event.detail && event.detail.href ? event.detail.href : '';
        console.log('Navigate to:', href);
        this.isMenuOpen = false;
    }

    handleBookNow() {
        console.log('Book Now clicked');
    }
}