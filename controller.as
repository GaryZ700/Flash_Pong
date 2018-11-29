package{
	
	import flash.events.KeyboardEvent
	import flash.ui.Keyboard
	import flash.display.Stage;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import keyBindingObj;
	


//controller class to simplify input for the game 
public class controller{
	
	//create public variables
	public var keyAction:Object = {"whileDown":-2, "onDown":-1, "onUp":1, "whileUp":2};
	public var keyboard = Keyboard;
	
	//create private vars
	private var stage:Stage;
	private var keyBindings:Array;
	private var timers
	
	//controller intialization function 
	//returns new instance of the controller class 
	//stageArg, reference to the stage in the main flash document
	public function controller(stageArg:Stage):void{
			
			//init variables with arguments
			stage = stageArg;
			
			//init keyBindings array 
			keyBindings = [];
			
			//add event listeners to view when keys are pressed up or down 
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyUp);
			
			}
				
	//keyDown function
	//has no return value 
	//event, reference to keyboard event that invoked the function 
	public function keyDown(event:KeyboardEvent):void{
		
		//iterate through all keyBindings
		for(var i=0; i<keyBindings.length; i++){
			
			var keyBinding:keyBindingObj = keyBindings[i];
			
			//check if key pushed down has a binding
			if(keyBinding.key == event.keyCode ){
				
				//check if key event is based on key up or key down event
				if(keyBinding.keyAction < 0)
					//if key action is meant to be run on key up, invoke the action 
					keyBinding.action();
					
				//if action is meant to run only while the key is up, then inform the keybinder that the key is up
				else if(keyBinding.keyAction == 2)
					keyBinding.removeWhileKeyAction();
				
			}
		}
	}
	
	;
	public function keyUp(event:KeyboardEvent):void{

		//iterate through all keyBindings
		for(var i=0; i<keyBindings.length; i++){
			
			var keyBinding:keyBindingObj = keyBindings[i];
			
			//check if key pushed down has a binding
			if(keyBinding.key == event.keyCode ){
				
				//check if key event is based on key up or key down event
				if(keyBinding.keyAction > 0)
					//if key action is meant to be run on key up, invoke the action 
					keyBinding.action();
					
				//if action is meant to run only while the key is up, then inform the keybinder that the key is up
				else if(keyBinding.keyAction == -2)
					keyBinding.removeWhileKeyAction();
				
			}
		}
	}
	
	//function to create a new key binding
	//has no return value 
	//nameArg, string name of key binding so that this specific binding can be referenced latere
	//keyArg, character code of keyboard to bind action to 
	//actionArg, function to execute when specific action occurs with key	
	public function addKeyBinding(name:String, key:uint, keyAction:int, action:Function){
		
			//add new keyBinding to the keyBindings array
			keyBindings.push(new keyBindingObj(stage, name, key, keyAction, action));
		}
	
	//function to remove a key binding
	public function removeKeyBinding(name:String){
		
			//loop through all keybindings
			for(var i=0; i<keyBindings.length; i++){
				
					if(keyBindings[i].name == name){
						keyBindings.splice(i,1);
						break;
				
					}
				}
		
		
		}
	
	//function to tempoarily pause a keybinding for a set period of time
	//returns true if key was sucessfully paused, returns false if key name not in keyBindings 
	//keyName, string of keyBinding name to pause 
	//time, number of how long to pause the keybinding for in milliseconds
	public function pauseKeyBinding(keyName:String, time:Number):Boolean{
		
		var pauseTimer:Timer = new Timer(time);
		var pausedBinding:keyBindingObj = keyBindings[0];
		keyBindings.splice(0,1);
		pauseTimer.addEventListener(TimerEvent.TIMER_COMPLETE, function unPauseBindingInit(event:TimerEvent){});
		pauseTimer.start();
		
		return true;
	
	}
	
	//unPauseKeyBinding function, allows paused key binding to continue regualar operation 
	private function unPauseKeyBinding(pausedKeyBinding:keyBindingObj){
		
		keyBindings.push(pausedKeyBinding);
		
		}
	
	//findBindingByName function
	private function findBindingByName(){}
	
	
}


}