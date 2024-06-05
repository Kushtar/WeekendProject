import { LightningElement, api, wire } from 'lwc';
import accountDetails from '@salesforce/apex/AccountService.getAccountDetails';
import submitToExternalSystem from '@salesforce/apex/AccountService.submitToExternalSystem';

export default class ButtonBasic extends LightningElement {
    //Get RecordId from URL
    @api recordId;

    showModal=false;
    typeSelection=true;
    dateSelection=false;
    changeAuthorizationPage=false;
    updateButton=false;
    submitButtonChange=false;
    changeConfirmationPage=false;
    cancelOrCloseButton='Cancel';
    cancelAuthorizationPage=false;
    submitButtonCancel=false;
    cancelConfirmationPage=false;

    //Variable from Apex
    ExternalAccountId;
    ServiceStartDate
    Name
    ServiceAddress


    @wire(accountDetails, { AccountId: '$recordId' })
    accountDetailsResponse({ error, data }) {
        if (data) {
            console.log(data);
            this.ExternalAccountId = data.ExternalAccountId;
            this.ServiceStartDate=data.ServiceStartDate;
            this.Name=data.Name;
            this.ServiceAddress=data.ServiceAddress;
        }
        if(error){
            console.log(error);
        }
    }

    handleClick() {
        this.showModal=true;
    }
    handleChangeEnrollment(){
        this.typeSelection=false;
        this.dateSelection=true;
        this.updateButton=true;

    }

    handleCancelEnrollment(){
        this.typeSelection=false;
        this.cancelAuthorizationPage=true;
        this.submitButtonCancel=true;
    }

    handleUpdate(){
        this.dateSelection=false;
        this.changeAuthorizationPage=true;
        this.updateButton=false;
        this.submitButtonChange=true;
    }

    handleSubmitChange(){
        this.changeAuthorizationPage=false;
        this.changeConfirmationPage=true;
        this.submitButtonChange=false;
        this.cancelOrCloseButton='Close';
        this.submit();
    }

    handleSubmitCancel(){
        this.cancelAuthorizationPage=false;
        this.submitButtonCancel=false;
        this.cancelOrCloseButton='Close';
        this.cancelConfirmationPage=true;

    }

    handleNewDate(event){
        this.NewServiceStartDate=event.target.value;
    }

    handleClose(){
        this.showModal=false;
        this.showModal=false;
        this.typeSelection=true;
        this.dateSelection=false;
        this.changeAuthorizationPage=false;
        this.updateButton=false;
        this.submitButtonChange=false;
        this.changeConfirmationPage=false;
        this.cancelOrCloseButton='Cancel';
        this.cancelAuthorizationPage=false;
        this.submitButtonCancel=false;
        this.cancelConfirmationPage=false;
    }

    submit(){
        submitToExternalSystem({
            ServiceId: this.recordId,
            NewServiceStartDate: this.NewServiceStartDate,
            RequestType: 'Change'
        }).then(response => {
            this.responseFromApex = response
            console.log(response);
        }).catch(error => {
            console.error('Failed to submit', error.body.message);
        })

    }
}
