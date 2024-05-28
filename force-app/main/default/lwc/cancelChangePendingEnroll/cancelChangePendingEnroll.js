import { LightningElement } from 'lwc';

export default class CancelChangePendingEnroll extends LightningElement {

    clickedButtonLabel;
    openModal=false;

    handleClick(event) {
        this.clickedButtonLabel = event.target.label;
    }
    handleStart() {
        this.openModal=true;
    }
    handleClose() {
        this.openModal=false;
    }
}