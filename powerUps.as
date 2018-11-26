package  {
	
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.events.Event;
	import flash.display.Stage;
	import flash.utils.getQualifiedClassName;
	import physics;
	
	public class powerUps {
		
		//create all private variables
		private var stage:Stage;
		private var powerUpsList:Object;
		private var powerUpEvents:Array;


		//function to initailze new instance of the powerUp class 
		//returns new instance of the powerUps class
		public function powerUps(stageArg:Stage) {
	
			//init all variables set by the user 
			stage = stageArg;
	
			//init all private variables
			powerUpsList = {};
			powerUpEvents = [];
		}
//********************************************************************************************
//init all private functions here 
	
	//function to handle complete timer events
	//has no return value 
	public function timerComplete(event:TimerEvent){
		
		trace("Timer");
		
		//discover which event timer has completed 
		for(var i=0; i<timerComplete.length; i++){
				trace(i);
				//check if timer has stopper running, and that 
				//if only single powerup instance is allowed, ensure only 1 is actually on stage
				if(!powerUpEvents[i].timer.running && powerUpNotOnStage(powerUpEvents[i])){
					  
						//create a new instance of the powerup child
						var powerUp = new powerUpEvents[i].powerUp();
					
						//set powerUp to spawn at a random position
						var area:Object = powerUpEvents[i].area;
						powerUp.x = Math.random() * area.length + area.x;
						powerUp.y = Math.random() * area.height + area.y;
						
						//set instance name 
						powerUp.name = getQualifiedClassName(powerUpEvents[i].powerUp);
					
						//spawn in this power up as this timer has stopped running
						stage.addChild(powerUp);
						trace("Added PowerUp");
						//check if more occurances of the powerUp should be spawned 
						if(powerUpEvents[i].occurances > 0)
						{	
							//if yes, then decrement the number of occurances by 1
							powerUpEvents[i].occurances -= 1;
							
							//if the number of occurnnces left is equal to 0, set occurances to -1 to prevent more occurances from occuring
							//but if occurnaces left is is not equal to 0, then reset and restart the timer
							if(powerUpEvents[i].occurances != 0){
								powerUpEvents[i].timer.reset();
								powerUpEvents[i].timer.start();
							}
							
							else
								powerUpEvents[i].occurances = -1;
							
						}
						
						//if number of occurances was alreadly set to 0, then reset the timer as the user wants this event to continue indefinetly
						else{
							    powerUpEvents[i].timer.reset();
								powerUpEvents[i].timer.start();
								trace("Reset Timer");
							}
					
					}
			
			}

		}

//--------------------------------------------------------------------------------------------

	//function to check if instance of a power up is on the stage already
	//returns either true or false 
	//powerUpEvent, object that contains information regarding the powerup
	private function powerUpNotOnStage(powerUpEvent:Object):Boolean{
		
			//check if user only wants one powerup on the stage
			if(powerUpEvent.multiple)
				return true
			else{
				
				//get first instance of the power up on the stage
				var powerUp = stage.getChildByName(getQualifiedClassName(powerUpEvent.powerUp));
				
				//check if powerUp is null 
				if(powerUp == null)
					return true
				else
					return false
			}
		}

//********************************************************************************************
//init all public functions here 
	
	//function that allows user to add in power up event controller by a timer
	//has no return value
	//spawnTimeMin, number that represents the minmum time in milliseconds before a new power up is spawned 
	//spawnTimeMax, number that represents the maxiumum time in milliseconds before a new power up is spawned 
	//occurances, number of times that the object should be spawned onto the stage, 0 = infinite 
	//powerUp, reference to the powerUp object class to spawn onto the stage
	//multiple, bool that represents whether multiple of the same powerups should spawn onto the screen at the same time
	public function addTimerEvent(spawnArea:Object, spawnTimeMin:Number, spawnTimeMax:Number, occurances:Number, powerUp:Object, multiple:Boolean=false){
		
			//create a new temporary timer 
			var tempTimer = new Timer(spawnTimeMax, 1);
		
			//add in a new event to the powerUpEvents array
			powerUpEvents.push(
							   
							   {
									"area":spawnArea,
									"time":[spawnTimeMin, spawnTimeMax],
									"occurances":occurances,
									"multiple":multiple,
									"powerUp":powerUp,
									"timer":tempTimer
									
								});
							
			//add event listener to timer and start the timer 
			powerUpEvents[powerUpEvents.length-1].timer.addEventListener(TimerEvent.TIMER_COMPLETE, timerComplete);
			powerUpEvents[powerUpEvents.length-1].timer.start();

	}
	
//--------------------------------------------------------------------------------------------

	//function to allow user to add power up to this class
	//has no return value
	//name, string of power up name to asociate with the specifed power up
	//graphic refers to class of master movie clip that contains the power up
	public function addPowerUp(name:String, graphic){
		
			//add in power up to powerUpsList
			powerUpsList[name] = graphic;
		
		}

//--------------------------------------------------------------------------------------------

}
}