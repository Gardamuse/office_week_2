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
	
	public class TextField extends Component
	{
		protected const NORMAL:int = 0;
		protected const HOVER:int = 1;
		protected const DOWN:int = 2;
		
		
		protected var text:String;
		public var callback:Function;
		public var params:Object;
		
		public function TextField(x:Number=0, y:Number=0, text:String = "", width:Number = 150, height:Number = 50, callback:Function = null, params:Object = null) 
		{
			super(x, y);
			
			this.callback = callback;
			this.params = params;
			this.text = text;
			
			setHitbox(width, height);
		}
		
		override public function update():void 
		{
			super.update();
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