package  {
	
	//physics based vector for adobe flash
	public class physicsVector {

		//init global variables
		public var x:Number;
		public var y:Number;

		public function physicsVector(xComponet:Number, yComponet:Number) {
			// constructor code
			
			//assign x and y values to the x and y of the vector
			x = xComponet;
			y = yComponet;
			
		}
		
		public function magnitude():Number{
			
			//use pythagorean theorem to get magnitude of the vector
			return Math.sqrt(Math.pow(x,2) + Math.pow(y,2))
			
		}
		
		//adds another vector to this vector
		public function add(vectorToAdd:physicsVector):void{
			
			x += vectorToAdd.x;
			y += vectorToAdd.y;
			
			}
		
		//allows vector to be multiplied by a scalar
		public function multiplyConstant(c:Number):void{

			x *= c;
			y *= c;
	}
	
	//take a base vector, and modifies the base vector such that it maintains the same magnitude, 
	//but takes an opposite direction to this vector
	public function antiVector(baseVector:physicsVector):physicsVector{
		
		
		return new physicsVector(1,1);
		
		}
	
	
}
	
	
	
}
