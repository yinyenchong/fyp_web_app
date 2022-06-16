import { Controller } from "stimulus"



export default class extends Controller {
  
  static targets = [ "fieldToReset" ]
    
  // on start    
  connect(){
      console.log("Reset connected")

  }  
  
  // on stop
  disconnect() {
      console.log("Reset disconnected")
  }
    
    
  reset() {
    this.element.reset()
    console.log("Reset being called")
  }
  

}
