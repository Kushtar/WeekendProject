import { LightningElement } from "lwc";

export default class LifecycleDemo extends LightningElement {
  constructor() {
    super(); // SUPER method is mandatory and it must be called first
    console.log("Constructor Called");
  }
  tileClickHandler() {
    const tileClicked = new CustomEvent("tileclick", {
      detail: this.meetingRoomInfo,
      bubbles: true
    });
    this.dispatchEvent(tileClicked);
  }
}
