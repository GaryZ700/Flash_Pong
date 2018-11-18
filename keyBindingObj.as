package  {
	
	public class keyBindingObj {

		import flash.display.Stage;
		import flash.events.Event;

		//public variables 
		public var name:String;
		public var key:uint;
		public var keyAction:int;
		public var action:Function;
		
		//private variables 
		private var stage:Stage;
		private var whileKeyAction:Function;

		//create new instance of the keyBinding Object class
		//returns new instance of hte keyBindingObj
		//stageArg, reference to the main flash document stage
		//nameArg, string name of key binding so that this specific binding can be referenced latere
		//keyArg, character code of keyboard to bind action to 
		//actionArg, function to execute when specific action occurs with key
		public function keyBindingObj(stageArg:Stage, nameArg:String, keyArg:uint, keyActionArg:int, actionArg:Function) {
			
			//set all approriate variables to arguments passed in 
			stage = stageArg;
			name = nameArg;
			key = keyArg;
			keyAction = keyActionArg;
			
			//check if action should only be run while key is down
			if(Math.abs(keyActionArg)==2){
				whileKeyAction = function whileKeyAction(event:Event){actionArg()};
				action = function whileKeyActionInit(){stage.addEventListener(Event.ENTER_FRAME, whileKeyAction)};
			}
		
		}
		
		//removeWhileKeyAction function, removes while loop for when key action is to be repeated while key is pressed either up or down 
		public function removeWhileKeyAction(){
			
			stage.removeEventListener(Event.ENTER_FRAME, whileKeyAction);
			
		}
		
		

	}
	
}
