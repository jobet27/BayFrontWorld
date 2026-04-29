import { LightningElement, track } from 'lwc';
import createContact from '@salesforce/apex/SignupController.createContact';

export default class SignupForm extends LightningElement {
    @track firstName = '';
    @track lastName = '';
    @track email = '';
    @track errorMessage = '';
    @track isLoading = false;
    @track isSuccess = false;

    loginUrl = '/login';

    handleFirstNameChange(event) {
        this.firstName = event.target.value;
    }

    handleLastNameChange(event) {
        this.lastName = event.target.value;
    }

    handleEmailChange(event) {
        this.email = event.target.value;
    }

    handleLoginClick(event) {
        event.preventDefault();
        this.dispatchEvent(new CustomEvent('navlogin'));
    }

    handleRegister(event) {
        event.preventDefault();
        this.isLoading = true;
        this.errorMessage = '';

        createContact({ 
            firstName: this.firstName, 
            lastName: this.lastName, 
            email: this.email 
        })
        .then((contactId) => {
            if (contactId) {
                this.isSuccess = true;
                this.isLoading = false;
            } else {
                this.errorMessage = 'Registration failed.';
                this.isLoading = false;
            }
        })
        .catch((error) => {
            this.errorMessage = error.body ? error.body.message : 'An unexpected error occurred.';
            this.isLoading = false;
        });
    }
}