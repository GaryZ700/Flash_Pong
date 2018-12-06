package  {
	
	import physics;
	import flash.display.Stage;
	import flash.display.MovieClip;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import fl.motion.Color;
	import flash.events.FullScreenEvent;
	
	//class to handle all code for a shooter based game 
	public class shooter extends EventDispatcher{

		//create all public variables here 
		public var pelletReference:Class;
		public var enemiesOnStage:Number;
		public var enemiesOnScreen:Array;


		
		//careate all private variables here
		private var stage:Stage;
		private var pellets:Array;
		private var colliders:Array;
		private var enemies:Array;
		private var wave:Array;

		//function to create a new instance of the shooter class method
		//returns new instance of the shooter class method
		//stage, reference to doucment's main stage
		public function shooter(stageArg:Stage, pelletReferenceArg:Class) {
			// constructor code
			
			//init all variables passed in by the user 
			stage = stageArg;
			pelletReference = pelletReferenceArg;
			
			//init all varaiables the user does not pass in 
			pellets = [];
			colliders = [];
			enemies = [];
			wave = [];
			enemiesOnStage = 0;
			enemiesOnScreen = [];
		}

//********************************************************************************************
//Private Functions Defined Here

	//function that updates collision checking of new pellets
	//has no return value
	private function updateCollision(pellets:Array, colliders:Array){
		
			//loop throuugh all the enemies present
			for(var c=0; c<colliders.length; c++){
					
					//loop through all the pellets 
					for(var p=0; p<pellets.length; p++){
						
							//add in pellet as a collision object to the collider
							colliders[c][0].addCollisionObj(pellets[p], colliders[c][1]);
							
						}
				}
	}
	
//--------------------------------------------------------------------------------------------
	
	//spawnWave, spawns enemy wave onto the screen 
	//has no return value
	//event, event to handle timer event, function meant to only be called with a timer_completion event
	//waveTimer, timer object that invoked the spawnWave function 
	private function spawnWave(event:TimerEvent, waveTimer:Timer){
		
		trace("spawn in an enemy wave");
		//get current enemy line 
		var line:Array = wave[0].shift();
			
		//spawn in wave 1 of enemies 
		for(var e=0; e<line.length; e++){
				
				stage.addChild(line[e].object);
				line[e].unPause();
					
			}
				
		//update counter to keep track of how many enemies are on the stage
		enemiesOnStage += line.length;
			
		trace(wave[0].length);

		trace(wave[0].length);
		//check if wave timer should be restarted 
		if(wave[0].length > 0)
			waveTimer.start();
		else{
			wave.shift();
			}
		}

//********************************************************************************************
//Public Functions defined here
		
		//function to spawn a pellet at a specifed location
		//has no return value
		public function spawnPellet(x:Number, y:Number, vX:Number, vY:Number, owner:Number=0){
			
				var pellet;
				//create a new pellet instance 
				if(owner == 2)
					pellet = new pellet2();
				else
					pellet = new pelletReference()
				
				//set pellet name and its position 
				pellet.name = "pellet" + pellets.length + 1;
				pellet.x = x;
				pellet.y = y;
				
				//add in pellet to the stage
				stage.addChild(pellet);
								
				//create a physics object for the pellet
				var pelletObj:physics = new physics(stage, pellet, vX, vY, 0, 0, 0);
				pelletObj.setProperty("owner", owner);
				//add in pelletObj to pellets holder
				pellets.push(pelletObj);
								
				//update collision checks
				updateCollision([pelletObj], colliders);
			}

//--------------------------------------------------------------------------------------------
		
		//destroy function destroys both the pellet and the object it collided with 
		//has no return value
		//pellet, pellet that has collided with another object
		public function destroy(collider:physics, pellet:physics){
				
				if(stage.contains(collider.object) && stage.contains(pellet.object)){
				
					stage.removeChild(collider.object);
					stage.removeChild(pellet.object);
				
					for(var p=0; p<pellets.length; p++){
					
							if(pellets[p].object.name == pellet.object.name)
								pellets.splice(p,1);
					
						}
				
					for(var c=0; c<colliders.length; c++){
						
							if(colliders[c] == collider)
								colliders.splice(c, 1);
					
						}
						
					//decrement enemies on stage count by 1
					//also check whether or not any enemies are left on the stage to raise an event that the wave has completed
					enemiesOnStage -= 1;
				 	
					if(enemiesOnStage == 0)
						dispatchEvent(new Event("WAVE_COMPLETE"));

			
			}}
			
//--------------------------------------------------------------------------------------------
		
		//addCollider function that allows the user to add in a collider to collide with the pellets
		//has no return value
		//object, physics object to check for when a pellet collides with this
		//action, action to take when physics object collides with this, default function is the destory function 
		public function addCollider(object:physics, action:Function=null){
			
				//update collision on this collider
				updateCollision(pellets, [object]);
				
				//add in collider to colliders
				colliders.push([object, action]);
				
				
			}
			
//--------------------------------------------------------------------------------------------
	
	//remove function removes pellet, but does not destory the object the pellet collided with 
	//has no return value
	public function removePellet(collider:physics, pellet:physics, list=null){
					
			if(list == null)
				list = pellets;
			for(var p=0; p<list.length; p++){
					
						if(list[p].object.name == pellet.object.name){
							
							list.splice(p,1);
						}
					}
		
		}

//--------------------------------------------------------------------------------------------

	//public function to allow function to be called upon wave completion
	//has no return value
	//action, function that is to be called when wave is completed
	public function addWaveCompleteEvent(action:Function){
		
			
		
		}

//--------------------------------------------------------------------------------------------

	//function to add in an enemy for shooting waves 
	//has no return value 
	//enemey, reference to enemy class
	public function addEnemy(enemy:Class){
		
			//add enemy to enemies list 
			enemies.push(enemy);
		
		}

//--------------------------------------------------------------------------------------------
		
	//function to remove enemey from stage and also decrement alien count by one, and raises WAVE_COMPLETE event if all enemies removed from the stage
	//has no return value 
	//enemy, phyics of enmey to remove
	public function removeEnemy(enemy:physics){
		
			removePellet(null, enemy, enemiesOnScreen);
			stage.removeChild(enemy.object);
			enemy.pause();
			enemiesOnStage -= 1;
			if(enemiesOnStage == 0)
				dispatchEvent(new Event("WAVE_COMPLETE"));
				
		
		}	
		
//--------------------------------------------------------------------------------------------

	//public function to create an enemy wave 
	//has no return value 
	//lines, number of enmie lines per wave 
	//shape, string of shape type for each wave 
	//xSpeed, how much should each enemey move in the x direction 
	//y speed, how much should each enemy move in the y direction 
	//spawn point, location of where enemy wave should start from
	//	is a string of either "top", "bottom", "left", or "right", default is "top"
	//tint, color object of how to modify enemies colors
	//collisionFunction, code to handle what happens when a pellet collides with an alien, default is the destroy function
	public function createEnemyWave(lines:Number, enemyNumber:Number, xSpeed:Number=0, ySpeed:Number=0.7, spawnPoint:String="top", tint:Color=null, collisionFunction:Function=null, alienBoundry:Function=null, boundry:Array=null, owner:Number=0){
			
			wave.push([]);	
			
			//set up dx and dy to ensure enemies are placed on the correct specifed loaction of the screen
			//and have appropriate velocities for that position
			var dy:Number = 0;
			var dx:Number = 0;
			owner = 2;
			switch(spawnPoint){
				
				case "bottom": 
					owner = 1;
					ySpeed*= -1;
					dy = stage.stageHeight;
					break;
				
				case "left": break;
				case "right": break;
				
				}
				
			if(collisionFunction == null)
				collisionFunction = this.destroy;
			
			var waveIndex:Number = wave.length - 1;
			
			//iterate through all the lines in a wave
			for(var l=0; l<lines; l++){
				
				//add in new arary to the array 
				wave[waveIndex][l] = []
				
				//iterate through all the enmies in a line 
				for(var e=0; e<enemyNumber; e++){
					
				//create new enemy physics object 
				var enemy:physics = new physics(stage, new enemies[0](), xSpeed, ySpeed, 0, 0, 0);
				enemy.pause();

				//set enemy x and y 
				enemy.object.x = (stage.stageWidth/enemyNumber) * (e+1) - enemy.object.width + dx;
				enemy.object.y = (-enemy.object.height/1.5) + dy;
				
				//if a tint was specifed then apply it 
				if(tint != null)
					enemy.object.transform.colorTransform = tint;
				
				enemy.addCollisionObj(boundry[0], alienBoundry);
				enemy.addCollisionObj(boundry[1], alienBoundry);
				enemy.setProperty("owner", owner);
				enemy.object.name = "alien" + e.toString();
				//add in enemy as a pellet colider
				addCollider(enemy, collisionFunction);
				enemiesOnScreen.push(enemy);
				wave[waveIndex][l].push(enemy);
					
					}
				
				}
			
			//get delta time for lines 
			var waveTimer:Timer = new Timer(2500,1);
			waveTimer.addEventListener(TimerEvent.TIMER_COMPLETE, function spawnWaveWrapper(event:TimerEvent){spawnWave(event, waveTimer);});
			waveTimer.start();
		
		}

	}
	
}
