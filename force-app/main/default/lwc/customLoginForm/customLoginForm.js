import { LightningElement, track } from 'lwc';
import login from '@salesforce/apex/LoginFormController.login';

export default class CustomLoginForm extends LightningElement {
    @track username = '';
    @track password = '';
    @track rememberMe = false;
    @track errorMessage = '';
    @track isLoading = false;

    forgotPasswordUrl = '/ForgotPassword';
    signupUrl = '/SelfRegister';

    handleUsernameChange(event) {
        this.username = event.target.value;
    }

    handlePasswordChange(event) {
        this.password = event.target.value;
    }

    handleRememberMeChange(event) {
        this.rememberMe = event.target.checked;
    }

    handleSignupClick(event) {
        event.preventDefault();
        this.dispatchEvent(new CustomEvent('navsignup'));
    }

    handleLogin(event) {
        event.preventDefault();
        this.isLoading = true;
        this.errorMessage = '';

        const urlParams = new URLSearchParams(window.location.search);
        const startUrl = urlParams.get('startURL') || '/';

        login({ username: this.username, password: this.password, startUrl: startUrl })
            .then((result) => {
                if (result) {
                    window.location.href = result;
                } else {
                    this.errorMessage = 'Login failed. Please check your credentials.';
                    this.isLoading = false;
                }
            })
            .catch((error) => {
                this.errorMessage = error.body ? error.body.message : 'An unexpected error occurred.';
                this.isLoading = false;
            });
    }
}
