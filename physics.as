﻿package  {
	import flash.events.TimerEvent;
		
	
	public class physics {
		
		import flash.display.Stage;
		import flash.display.MovieClip;
		import flash.events.Event;
		import flash.events.TimerEvent;
		import flash.utils.Timer;
		import physicsVector;
		
		//create public variables
		//constant vectors for the four core directions
		public const UP:physicsVector = new physicsVector(0,-1);
		public const DOWN:physicsVector = new physicsVector(0,1);
		public const LEFT:physicsVector = new physicsVector(-1,0);
		public const RIGHT:physicsVector = new physicsVector(1,0);
		public const ZERO:physicsVector = new physicsVector(0,0);
		
		//physics quantities
		public var velocity:physicsVector;
		public var accleration:physicsVector;
		public var angularVelocity:Number;
		public var collisionVector:physicsVector;

		//create private variables for the class 
		private var object:MovieClip;
		private var friction:Number;
		private var collisionObjs:Array;
		private var pauseTimer:Timer;
		private var pause = false;
		private var lockedMovements:Array;

		//creates a physics object for a movieClip object
		//returns new instance of the physics class 
		//stageArg, reference to main flash document stage object
		//objectArg, reference to movie clip that belongs to this object 
		//vX: starting x velocity 
		//vY: starting y velocity
		//aX: starting X accleration 
		//aY: starting Y accleration 
		//frictionArg: amount of friction that should always act upon the object, default value is 0.01
		//angularVelcity: angular velocity of the object, default value is 0
		public function physics(stageArg:Stage, objectArg:MovieClip, vX:Number=0, vY:Number=0, aX:Number=0, aY:Number=0,frictionArg=0.01,  angularVelocityArg=0) {
			// constructor code

			//initialize all class variables
			object = objectArg;
			velocity = new physicsVector(vX, vY);
			accleration = new physicsVector(aX, aY);
			friction = 1-frictionArg;
			angularVelocity = angularVelocityArg;
			
			//init variables that user does not set intialization value for
			collisionObjs = [];
			lockedMovements = [];
			pause = false;
			collisionVector = ZERO;
			
			//allow physics to update on each frame entered 
			stageArg.addEventListener(Event.ENTER_FRAME, update);
		}

//********************************************************************************************
// Private functions

		//updateCollision function checks if any collisions have occured
		//has no return value 
		private function updateCollision(){
			
				//iterate thrugh all collision objects
				for(var i:int=0; i < collisionObjs.length; i++){
					
					//get collision obj from collision objs
					var collisionObj:Array = collisionObjs[i];
					
					//check if this object has collided with the colllision object
					if(object.hitTestObject(collisionObj[0].object)){
						
						//if yes, run the associated action with this collision
						//and pass in this obj and the object this object collided with
						collisionObj[1](collisionObj[0]);
						
						//merge velocity between the two objects if the user desieres so
						//if(collisionObj[2] != null)
							//velocity.add( collisionObj[2].velocity.newVector(1) );
							
					}
				}
			
			}
			
//--------------------------------------------------------------------------------------------
			
		//update function updates the velocity of the object
		//has no return value
		//event, event object that comes from onFrameEnter listener
		private function update(event:Event){
			
			//check if object should be paused
			if(!pause){
			
				//update velocity with accleration
				velocity.add(accleration)
				
				//reset accleration
				accleration = new physicsVector(0,0);
			
				//update the object position from its velocity
				object.x += velocity.x;
				object.y += velocity.y;
			
			}
			
			//apply friction to the objec's velocity
			velocity.multiplyConstant(friction);
			
			//check if collisions have occured
			updateCollision();
			
			}
			
//********************************************************************************************
//Public Functions

		//modFriction function allows the user to modify friction acting upon object 
		//frictionArg is percent of motion that should decrese each frame due to friction
		public function modFriction(frictionArg:Number):void{
			
				//modify fricition number such that it leaves behind the remaining percent of motion
				friction = 1-frictionArg;
			
			}
			
		
		//acclerate function, causes object to acclerate in specified direction
		//returns True if accleration was successful, returns false if accleration did not occur because direction was locked
		//direction, physicsVector specifying direction of the accleration 
		public function acclerate(direction:physicsVector){
			
				//check if object is acclerating in a direction that is locked
				//iterate through all locked directions
				for(var i=0; i<lockedMovements.length; i++){
					
					//if locked direction is equal to direction, then return false
					if(lockedMovements[i].x == direction.x && lockedMovements[i].y == direction.y)
						return false;					
					}
			
				//acclerate object and return true
				accleration.add(direction);
				return true;
			}
			
//--------------------------------------------------------------------------------------------
			
		//allows user to add in obj to check for collisions with, and a function execute on collision with said obj
		//has no return value 
		//obj, movie clip of object to detect collisions with 
		//action, function to invoke after collision
		//physicsObj, reference to physicsObj containging the object if it exists
		public function addCollisionObj(obj:physics, action:Function, physicsObj:physics=null){
			
				collisionObjs.push([obj, action, physicsObj]);
			
			}

//--------------------------------------------------------------------------------------------
			
		//function to prevent object from moving along certain vectors of motion
		//has no return value 
		//vector, physicsVector that specfies direction in which object is not meant to move, magnitude of vector does not matter, only direction 
		//time, number that specifes how long should the direction remained locked for
		public function lockMovements(direction:physicsVector, time:Number=0){
			
				//add vector to locked movements
				lockedMovements.push(direction);
				
				//check if time is greater than zero, and thus movement lock is not permanent
				if(time>0){
					
					//get index of where new locked movement was added
					var index:Number = lockedMovements.length - 1;
					
					//create new timer with specified values and add event listener with function to remove movementLock
					var movementLockTimer:Timer = new Timer(time, 1);
					movementLockTimer.addEventListener(TimerEvent.TIMER_COMPLETE, function removeMovementTimer(event:TimerEvent){
					
						lockedMovements.splice(index);
													   
						});
						
					//start the movment lock timer
					movementLockTimer.start();
					
					}
			} 

//--------------------------------------------------------------------------------------------
		
		//function to set the collision, vector, this vector determines what happens when an object collides with this object
		//has no return value 
		public function setCollisionVector(direction:physicsVector){
			
				collisionVector = direction;
			
			}
		
//********************************************************************************************
//Public Functions that provide various movement abillities for the physics object 

		//bounce function, causes object to bounce off when a collision occurs
		public function bounce(collisionObj:physics){
			
				if(collisionObj.collisionVector.x > 0 && velocity.x < 0  ||
				   collisionObj.collisionVector.x < 0 && velocity.x > 0)
				   		velocity.x *= -1;
						
				if(collisionObj.collisionVector.y > 0 && velocity.y < 0  ||
				   collisionObj.collisionVector.y < 0 && velocity.y > 0)
				   		velocity.y *= -1;
					
				velocity.add(collisionObj.velocity.newVector(0.1));
			
			}
			
//--------------------------------------------------------------------------------------------
			
		//function stop, completly stop obj momvement, is a collision action meant to be used with physics update function  
		//has no return value
		//collisionObj, object that collided into this object
		public function stop(collisionObj:physics){
			
				//set velocity and accleration to 0 to stop the objects 
				velocity.multiplyConstant(0);
				accleration.multiplyConstant(0);
						
			}
	}
	
}