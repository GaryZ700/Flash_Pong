package  {
	
	public class gameObject {

		import flash.display.Stage;
		import flash.display.MovieClip;
		import flash.events.Event;
		import flash.utils.Timer;
		import physics;
		
		//create all public vars
		public var physics:physics;

		//create all private vars
		private stage:Stage;
		private object:MovieClip;

		//creates new instance of the gameobject class 
		public function gameObject(stageArg:Stage,  objectArg:MovieClip) {
			// constructor code
			
			//intialzie all variables that make use of arguments
			stage = stageArg;
			object = objectArg;
			physics = new physics(stage, object);
			
			//init this object's main function 
			stage.addEventListener(Event.ENTER_FRAME, main);
			
		}
		
		
	
}
