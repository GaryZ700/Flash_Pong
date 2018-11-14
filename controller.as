package{
	import flash.display.Stage;


//controller class to simplify input for the game 
public class controller{
	
	//import Keyboard events
	import flash.events.KeyboardEvent
	import flash.ui.Keyboard
	
	public function controller(stage:Stage):void{
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyUp);
			
		}
	
	//create public keys object
	public var keys:Object = {
			
			"up":false,
			"down":false,
			"right":false,
			"left":false
		
		};
		
	public function keyDown(event:KeyboardEvent):void{

		if(event.keyCode == Keyboard.UP)
			{keys["up"] = true;} else if(event.keyCode == Keyboard.DOWN)
			{keys["down"] = true;}else if(event.keyCode == Keyboard.LEFT)
			{keys["left"] = true;}else if(event.keyCode == Keyboard.RIGHT)
			{keys["right"] = true;}	
	}
	
	
	public function keyUp(event:KeyboardEvent):void{
		trace("up");
		if(event.keyCode == Keyboard.UP)
			{keys["up"] = false;}else if(event.keyCode == Keyboard.DOWN)
			{keys["down"] = false;}else if(event.keyCode == Keyboard.LEFT)
			{keys["left"] = false;}else if(event.keyCode == Keyboard.RIGHT)
			{keys["right"] = false;}	
	}
	
}}