package  {
		
	
	public class physics {
		
		import flash.display.Stage;
		import flash.display.MovieClip;
		import flash.events.Event;
		import physicsVector;

		//init private variables for the class 
		private var object:MovieClip;
		private var friction:Number;
		private var collisionObjs:Array;
		
		//public variables
		public var UP:physicsVector = new physicsVector(0,-1);
		public var DOWN:physicsVector = new physicsVector(0,1);
		public var LEFT:physicsVector = new physicsVector(-1,0);
		public var RIGHT:physicsVector = new physicsVector(1,0);
		public var velocity:physicsVector;
		public var accleration:physicsVector;
		

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
			
			collisionObjs = [];
			
		}
		
		//checks if any collisions have occured
		private function updateCollision(){
			
				for(var i:int=0; i < collisionObjs.length; i++){
					
					//get collision obj from collision objs
					var collisionObj:Array = collisionObjs[i];
					
					//check if this object has collided with the colllision object
					if(object.hitTestObject(collisionObj[0]))
						//if yes, run the associated action with this collision
						//and pass in this obj and the object this object collided with
						collisionObj[1](collisionObj[0]);
				}
			
			}
		
		//function to update the velocity of the object
		private function update(event:Event):void{
			
			//update velocity with accleration
			velocity.add(accleration)
			accleration = new physicsVector(0,0);
			
			object.x += velocity.x;
			object.y += velocity.y;
			
			velocity.multiplyConstant(friction);
			
			//check if collisions have occured
			updateCollision();
			
			}
			
		
		//function to allow user to modify friction acting upon object 
		public function modFriction(frictionArg:Number):void{
			
				friction = 1-frictionArg;
			
			}
			
		
		public function acclerate(direction:physicsVector){
				accleration.add(direction);
			}
			
		//allows user to add in obj to check for collisions with, and a function execute on collision with said obj
		public function addCollisionObj(obj:MovieClip, action:Function){
			
				collisionObjs.push([obj, action]);
			
			}
		
			
		//public functions to handle various collisions between objects 
		public function bounce(collisionObj){
			
				velocity.multiplyConstant(-1);
			
			}
			
		public function stop(collisionObj){
			
				velocity.multiplyConstant(-.25);
				
			}
	}
	
}
