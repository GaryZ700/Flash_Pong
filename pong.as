package  {
	import flash.display.Stage;
	import flash.events.Event;
	import flash.display.MovieClip;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	public class pong {

		//init global public variables
		public var gameMode:String;
		
		//initi global private variables 
		private var stage:Stage
		private var ballArg:physics;
		private var topPaddle:physics;
		private var rightPaddle:physics;
		private var ballObj:physics;
		private var shooterManager:shooter;
		private var hasShot:Boolean;
		private var shootTimer:Timer;

		//code specific only to this specific game of pong 
		public function pong(stageArg:Stage, ballObjArg:physics, topPaddleArg:physics, rightPaddleArg:physics, shooterManagerArg:shooter) {
			// constructor code
			
			stage = stageArg;
			ballObj = ballObjArg;
			topPaddle = topPaddleArg;
			rightPaddle = rightPaddleArg;
			gameMode = "ball";
			shooterManager = shooterManagerArg;
			hasShot = false;
			shootTimer = new Timer(20,1);
			shootTimer.addEventListener(TimerEvent.TIMER_COMPLETE, function callBack(event:TimerEvent){hasShot = false; shootTimer.reset();});
			
			//set up event listener for AI
			stage.addEventListener(Event.ENTER_FRAME, AI);
		}


//********************************************************************************************
//private functions defined here 

	//AI function to control the enemy player
	//has no return value 
	//event, is event from on frame enter
	private function AI(event:Event){
			
			if(gameMode=="battle")
				battleAI();
			else
				ballAI();
		}
			
//--------------------------------------------------------------------------------------------

	//function to handle AI for playing ball 
	//has no return value 
	private function ballAI(){
		
		if(ballObj.velocity.magnitude() != 0){
			if(ballObj.object.x < topPaddle.object.x)
				topPaddle.acclerate(topPaddle.LEFT);
			else if(ballObj.object.x > topPaddle.object.x)
				topPaddle.acclerate(topPaddle.RIGHT);
					
			if(ballObj.object.y < rightPaddle.object.y - 3)
				rightPaddle.acclerate(topPaddle.UP);
			else if(ballObj.object.y > topPaddle.object.y + 3)
				rightPaddle.acclerate(topPaddle.DOWN);
			}
		
		}
		
//--------------------------------------------------------------------------------------------

	//function to handle AI for battle mode 
	//has no return value 
	private function battleAI(){
			
		if(!hasShot){
			
			for(var e=0; e < shooterManager.enemiesOnScreen.length; e++){
				
				var alien:physics = shooterManager.enemiesOnScreen[e];
				if(alien.getProperty("owner") == 2){
					trace("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
					continue;
					
				}
				//check if alien in line of sight 
				if(alien.object.x > topPaddle.object.x + .5)
					topPaddle.acclerate(topPaddle.RIGHT);
				else if(alien.object.x < topPaddle.object.x - 0.5)
					topPaddle.acclerate(topPaddle.LEFT);
				else{
					shooterManager.spawnPellet(topPaddle.object.x,topPaddle.object.y+20,topPaddle.velocity.x/3.5,9,2);		
					hasShot = true;
					shootTimer.start();
				}
				}}
		}

//********************************************************************************************
//public functions defined here
		
		//will set team colors for pong 
		//team1, 
		public function setColor(team1, team2){
			}

	}
	
}
