package  {
	
	
	public class gameManager {

		import flash.display.Stage;
		import controller;
		
		//create public variables
		public var controls:controller;
		
		//create private variables
		private var stage:Stage;
		private keyBindings:Array;
		

		//creates new instance of the gameManager class 
		public function gameManager(stageArg:Stage, keyBindingsArg=[]) {
			// constructor code
			
			//init variables that make use of arguments
			stage = stageArg;
			keyBindings = keyBindingsArg;
		}


		//function to create new key bindings 
		public function newKeyBinding(key:uint, action:Function){
			
				//update keyBindings array
				keyBindings.push([key,action]);
			
			
			}
	}
	
}
