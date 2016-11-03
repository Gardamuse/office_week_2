package ui 
{
	import flash.geom.Point;
	import flash.ui.MouseCursor;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Stamp;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	public class Button extends Component
	{
		protected const NORMAL:int = 0;
		protected const HOVER:int = 1;
		protected const DOWN:int = 2;
		
		public var clicked:Boolean = false;
		
		protected var text:String;
		public var callback:Function;
		public var params:Object;
		private var key:int;
		private var keyHeldDown:Boolean = false;
		
		public function Button(x:Number=0, y:Number=0, text:String = "", width:Number = 150, height:Number = 50, callback:Function = null, params:Object = null, keyConstant:int = 1) 
		{
			super(x, y);
			
			key = keyConstant;

			this.callback = callback;
			this.params = params;
			this.text = text;
			
			setHitbox(width, height);
		}
		
		override public function update():void 
		{
			super.update();
			if (Input.pressed(key)) keyHeldDown = true;
			if (collidePoint(x, y, world.mouseX, world.mouseY) || keyHeldDown)
			{	
				if(!keyHeldDown)Input.mouseCursor = MouseCursor.BUTTON;
				
				if (Input.mousePressed || keyHeldDown) clicked = true;
				
				if (clicked) changeState(DOWN);
				else changeState(HOVER);
				
				if (clicked && (Input.mouseReleased || Input.released(key))) click();
			}
			else
			{
				if (clicked) changeState(HOVER);
				else changeState(NORMAL);
				
			}

			if (Input.mouseReleased || Input.released(key)) clicked = false;
			if (Input.released(key)) keyHeldDown = false;
			
		}
		
		protected var lastState:int = 0;
		
		protected function changeState(state:int = 0):void
		{
			lastState = state;
		}
		
		protected function click():void
		{
			if (callback != null)
			{
				if (params != null) callback(params);
				else callback();
			}
		}
		
	}
}