package  {
	
	//physics based vector for adobe flash
	public class vector {

		//init global variables
		public var x:Number;
		public var y:Number;

		public function vector(xComponet:Number, yComponet:Number) {
			// constructor code
			
			//assign x and y values to the x and y of the vector
			x = xComponet;
			y = yComponet;
			
		}
		
		public function magnitude():Number{
			
			//use pythagorean theorem to get magnitude of the vector
			return sqrt(pow(x,2) + pow(y,2))
			
		}
		
		//adds another vector to this vector
		public function add(vectorToAdd:vector):void{
			
			x += vectorToAdd.x;
			y += vectorToAdd.y;
			
			}
		
		//allows vector to be multiplied by a scalar
		public function multiplyConstant(c:Number):

			x *= c;
			y *= c;
	}
	
}
