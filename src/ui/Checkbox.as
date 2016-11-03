package ui 
{	
	public class Checkbox extends Button 
	{
		protected var _checked:Boolean = false;
		
		public function Checkbox(x:Number=0, y:Number=0, text:String = "", width:Number = 150, height:Number = 150, callback:Function = null, params:Object = null, checked:Boolean = false) 
		{
			super(x, y, text, width, height, callback, params);
			
			this.checked = checked;
		}
		
		override protected function click():void 
		{
			checked = !checked;
			
			if (callback != null)
			{
				if (params != null) callback(checked, params);
				else callback(checked);
			}
		}
		
		public function get checked():Boolean 
		{
			return _checked;
		}
		
		public function set checked(value:Boolean):void 
		{
			if (_checked != value)
			{
				_checked = value;
				changeCheck();
			}
		}
		
		public function setChecked(value:Boolean):void
		{
			checked = value;
		}
		
		protected function changeCheck():void
		{
			
		}
	}
}