package 
{

	//physics based vector for adobe flash
	public class physicsVector
	{

		//init public global variables
		public var x:Number;
		public var y:Number;

		//initalization function for the physics vector class
		//returns new instance of the physics vector class 
		//xCompnet, number for x portion of vector
		//ycomponert, number for y protion of vector 
		public function physicsVector(xComponet:Number, yComponet:Number)
		{

			//assign x and y values to the x and y of the vector
			x = xComponet;
			y = yComponet;

		}
		
//********************************************************************************************
// Public Functions

		//magnitude function, returns magnitude of the vector
		//returns a number that represents the magnitude of the vector
		public function magnitude():Number
		{
			//use pythagorean theorem to get magnitude of the vector
			return Math.sqrt(Math.pow(x,2) + Math.pow(y,2));
		}

//--------------------------------------------------------------------------------------------

		//add function adds another vector to this vector 
		//returns vector of addition, as well as modifying the this vector 
		//vectorToAdd, phyiscsVector to add to this vector 
		//modify, if true, this vector will be modified, if false a new vector will be created and this vector will remain unmodified, default is true
		public function add(vectorToAdd:physicsVector, modify:Boolean=true):physicsVector
		{
			var newVector:physicsVector = new physicsVector(x+vectorToAdd.x, y+vectorToAdd.y);
			
			if(modify == true){
				x +=  vectorToAdd.x;
				y +=  vectorToAdd.y;
			}
			
			return newVector;
		}

//--------------------------------------------------------------------------------------------

		//allows vector to be multiplied by a scalar
		//has no return value 
		//c: number to multiply this vector by 
		public function multiplyConstant(c:Number):void
		{

			x *=  c;
			y *=  c;
		}

//--------------------------------------------------------------------------------------------

		//rotate function, rotates vector by specifed theta
		//has no return value 
		//theta, number of angle in degrees to rotate this vector
		public function rotate(theta:Number)
		{

			//get transformed x and y at specifed theta
			var transformedY:Number = x * Math.cos(theta) - y * Math.sin(theta);
			var transformedX:Number = x * Math.sin(theta) + y * Math.cos(theta);

			//update x and y of this vector 
			x = transformedX;
			y = transformedY;

		}

//--------------------------------------------------------------------------------------------

		//create a new vector with with as the as the base vector 
		//returns a physicsVector with the specifed modifications 
		//c, constant to multiply the vector's base by 
		public function newVector(c:Number=1)
		{

			return new physicsVector(x*c, y*c);

		}

//--------------------------------------------------------------------------------------------

		//take a base vector, and modifies the base vector such that it maintains the same magnitude, 
		//but takes an opposite direction to this vector
		public function antiVector(baseVector:physicsVector):physicsVector
		{


			return new physicsVector(1,1);

		}
		
//--------------------------------------------------------------------------------------------

		//random function, sets this vector to a random vector
		//has no return value 
		//magnitudeMin, minimum value for the magnitude of this vector, default is 0
		//magnitudeMax, maximum vale for the magnitude fo this vector, default is 100
		//setX: True, use main and max to set x componet, and then set y, the inverse is true for false
		//theta of vector is random
		public function random(magnitudeMin:Number=0, magnitudeMax:Number=100, setX=true){
			
			//compute random magnitude
			var randomMagnitude:Number = (Math.random() * (magnitudeMax - magnitudeMin)) + magnitudeMin;
			
			//compute random number between 0 and max magnitude
			var randNum:Number = Math.random() * magnitudeMax;
			
			//solve for 2nd random number
			var randNum2:Number = Math.sqrt(randomMagnitude*randomMagnitude - randNum*randNum);
				
		
			//randomly decide which random number is the ycomponet and which is the xcomponet
			if(setX && randNum > randNum2)
				{//set 1st random number as x compnet
				x = randNum;
				y = randNum2;
				}
			else{
				//set randNum2 as the x value 
				x = randNum2;
				y = randNum;
			}
			}
	}
}