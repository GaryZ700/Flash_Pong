package  {
	import flash.display.Stage;
	import flash.events.Event;
	
	public class pong {

		//init global public variables
		public var gameMode:String;
		
		//initi global private variables 
		private var stage:Stage
		private var ballArg:physics;
		private var topPaddle:physics;
		private var rightPaddle:physics;
		private var ballObj:physics;

		//code specific only to this specific game of pong 
		public function pong(stageArg:Stage, ballObjArg:physics, topPaddleArg:physics, rightPaddleArg:physics) {
			// constructor code
			
			stage = stageArg;
			ballObj = ballObjArg;
			topPaddle = topPaddleArg;
			rightPaddle = rightPaddleArg;
			gameMode = "ball";
			
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
		
			
		
		}

//********************************************************************************************
//public functions defined here
		
		//will set team colors for pong 
		//team1, 
		public function setColor(team1, team2){
			
				
			}

	}
	
}
