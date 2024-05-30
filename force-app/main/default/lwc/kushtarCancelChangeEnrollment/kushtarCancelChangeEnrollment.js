import { LightningElement } from 'lwc';

export default class ButtonBasic extends LightningElement {
    clickedButtonLabel;
    showModal=false;
    typeSelection=true;
    dateSelection=false;
    changeAuthorizationPage=false;
    updateButton=false;
    submitButton=false;
    changeConfirmationPage=false;
    cancelOrCloseButton='Cancel';

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
    }

    handleUpdate(){
        this.dateSelection=false;
        this.changeAuthorizationPage=true;
        this.updateButton=false;
        this.submitButton=true;
    }

    handleSubmit(){
        this.changeAuthorizationPage=false;
        this.changeConfirmationPage=true;
        this.submitButton=false;
        this.cancelOrCloseButton='Close';
    }

    handleClose(){
        this.showModal=false;
    }


}
