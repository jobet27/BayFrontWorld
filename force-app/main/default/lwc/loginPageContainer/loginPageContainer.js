import { LightningElement, track } from 'lwc';

export default class LoginPageContainer extends LightningElement {
    @track isLoginMode = true;

    connectedCallback() {
        document.body.style.overflow = 'hidden';
        this.evaluateMode();
        window.addEventListener('popstate', this.evaluateMode.bind(this));
    }

    disconnectedCallback() {
        document.body.style.overflow = '';
        window.removeEventListener('popstate', this.evaluateMode.bind(this));
    }

    evaluateMode() {
        const path = window.location.pathname.toLowerCase();
        if (path.includes('signup') || path.includes('selfregister') || path.includes('register')) {
            this.isLoginMode = false;
        } else {
            this.isLoginMode = true;
        }
    }

    handleNavSignup() {
        this.isLoginMode = false;
    }

    handleNavLogin() {
        this.isLoginMode = true;
    }
}
