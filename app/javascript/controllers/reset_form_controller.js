import { Controller } from "stimulus"



export default class extends Controller {
  
  static targets = [ "textReset" ]
    
  // on start    
  connect(){
      console.log("Reset connected")

  }  
  
  // on stop
  disconnect() {
      console.log("Reset disconnected")
  }
    
  //reset() {
  reset() {
    this.element.reset()
    
    //this.reset(this.textTarget)
    this.textResetTarget.reset()
    console.log("Reset being called")
  }
  

}
