package  {
	
	import physics
	import flash.display.Stage;
	import flash.display.MovieClip;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	//class to handle all code for a shooter based game 
	public class shooter {

		//create all public variables here 
		public var pelletReference:Class;
		
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
	
	private function spawnWave(event:TimerEvent, waveTimer:Timer){
		
			trace("spawn in an enemy wave");
			trace(waveTimer.running);

			//spawn in wave 1 of enemies 
			for(var e=1; e<wave[0].length; e++){
				
					stage.addChild(wave[0][e].object);
					wave[0][e].unPause();
				
				}
				
			//delete spent wave 
			wave.splice(0);
			
			//check if timershould be restarted 
			if(wave.length > 0)
				waveTimer.start();

		}

//********************************************************************************************
//Public Functions defined here
		
		//function to spawn a pellet at a specifed location
		//has no return value
		public function spawnPellet(x:Number, y:Number, vX, vY){
			
				//create a new pellet instance 
				var pellet = new pelletReference()
				
				//set pellet name and its position 
				pellet.name = "pellet" + pellets.length + 1;
				pellet.x = x;
				pellet.y = y;
				
				//add in pellet to the stage
				stage.addChild(pellet);
				
				trace("TEST1");
				
				//create a physics object for the pellet
				var pelletObj:physics = new physics(stage, pellet, vX, vY, 0, 0, 0);
			
				//add in pelletObj to pellets holder
				pellets.push(pelletObj);
				
				trace("TEST2");
				
				//update collision checks
				updateCollision([pelletObj], colliders);
				trace("TEST3");
			}


//--------------------------------------------------------------------------------------------
		
		//destroy function destroys both the pellet and the object it collided with 
		//has no return value
		//pellet, pellet that has collided with another object
		public function destroy(collider:physics, pellet:physics){
					
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
			
			}
			
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
	public function removePellet(collider:physics, pellet:physics){
					
			for(var p=0; p<pellets.length; p++){
					
						if(pellets[p].object.name == pellet.object.name){
							
							pellets.splice(p,1);
						}
					}
		
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

	//public function to create an enemy wave 
	//has no return value 
	//lines, number of enmie lines per wave 
	//shape, string of shape type for each wave 
	//xSpeed, how much should each enemey move in the x direction 
	//y speed, how much should each enemy move in the y direction 
	public function createEnemyWave(lines:Number, enemyNumber:Number, xSpeed:Number=0, ySpeed:Number=0.7, lineDistance=4){
			
			//iterate through all the lines in a wave
			for(var l=0; l<lines; l++){
				
				//add in new arary to the array 
				wave.push([]);
				trace(enemies[0])
				//iterate through all the enmies in a line 
				for(var e=0; e<enemyNumber; e++){
					
				//create new enemy physics object 
				var enemy:physics = new physics(stage, new enemies[0](), xSpeed, ySpeed, 0, 0, 0);
				enemy.pause();

				//set enemy x and y 
				enemy.object.x = (stage.stageWidth/enemyNumber) * (e+1) - enemy.object.width;
				enemy.object.y = -enemy.object.height/1.5;
				
				wave[l].push(enemy);
					
				}}
			
			//get delta time for lines 
			//((enemy.object.height/ySpeed) / 40) * 1000 
			var waveTimer:Timer = new Timer( 50 , 10);
			waveTimer.addEventListener(TimerEvent.TIMER_COMPLETE, function spawnWaveWrapper(event:TimerEvent){spawnWave(event, waveTimer);});
			waveTimer.start();
		
		}

	}
	
}
