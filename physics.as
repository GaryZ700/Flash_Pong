package  {
		
	
	public class physics {
		
		import flash.display.Stage;
		import flash.display.MovieClip;
		import flash.events.Event;
		import physicsVector;

		//init private variables for the class 
		private var object:MovieClip;
		public var velocity:physicsVector;
		public var accleration:physicsVector;
		private var friction:Number;
		
		//public variables
		public var UP:physicsVector = new physicsVector(0,-1);
		public var DOWN:physicsVector = new physicsVector(0,1);
		public var LEFT:physicsVector = new physicsVector(-1,0);
		public var RIGHT:physicsVector = new physicsVector(1,0);
		

		//creates a physics object for a movieClip object
		public function physics(stageArg:Stage, objectArg:MovieClip, vX:Number=0, vY:Number=0, aX:Number=0, aY:Number=0,frictionArg=0.01) {
			// constructor code

			//initialize all class variables
			object = objectArg;
			velocity = new physicsVector(vX, vY);
			accleration = new physicsVector(aX, aY);
			friction = 1-frictionArg;
			
			//allow physics to update on each frame entered 
			stageArg.addEventListener(Event.ENTER_FRAME, update);
			
		}
		
		//function to update the velocity of the object
		private function update(event:Event):void{
			
			//update velocity with accleration
			velocity.add(accleration)
			accleration = new physicsVector(0,0);
			
			object.x += velocity.x;
			object.y += velocity.y;
			
			velocity.multiplyConstant(friction);
			
			}
			
		//function to update friction portion of the physics engine
		private function frictionUpdate(){
			
			
			}
			
		public function acclerate(direction:physicsVector){
				accleration.add(direction);
			}
	}
	
}
