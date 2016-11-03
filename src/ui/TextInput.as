package ui 
{
	import flash.events.KeyboardEvent;
	import flash.ui.MouseCursor;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	public class TextInput extends Component
	{
		protected var _text:String = "";
		
		protected var multiline:Boolean = false;
		
		public static var focus:TextInput;
		private var _focused:Boolean = false;
		
		public function TextInput(x:Number=0, y:Number=0, text:String = "", multiline:Boolean = false, width:Number = 150, height:Number = 30) 
		{
			super(x, y);
			
			this.multiline = multiline;
			
			this.text = text;
			
			type = "uiTextInput";
			
			setHitbox(width, height);
		}
		
		override public function added():void 
		{
			super.added();
			
			FP.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		}
		
		protected function onKeyDown(e:KeyboardEvent):void
		{
			if (world != FP.world) return;
			if (TextInput.focus != this) return;
			
			if (e.keyCode == Key.BACKSPACE) text = _text.substr(0, _text.length - 1);
			else if (e.keyCode == Key.ENTER && multiline) text += "\n";
		}
		
		override public function removed():void 
		{
			super.removed();
			
			FP.stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		}
		
		protected function onFocus(focused:Boolean):void
		{
			
		}
		
		override public function update():void 
		{
			super.update();
			trace(text);
			if (TextInput.focus == this)
			{
				if (!_focused)
				{
					onFocus(true);
					_focused = true;
				}
			}
			else if (_focused)
			{
				onFocus(false);
				_focused = false;
			}
			
			if (Input.mousePressed)
			{
				if (collidePoint(x, y, world.mouseX, world.mouseY))
				{
					TextInput.focus = this;
					Input.keyString = "";
				}
				else if (!world.collidePoint("uiTextInput", world.mouseX, world.mouseY)) TextInput.focus = null;
			}
			
			if (TextInput.focus == this && Input.keyString != "")
			{
				text += Input.keyString;
				Input.keyString = "";
			}
			
			if (collidePoint(x, y, world.mouseX, world.mouseY)) Input.mouseCursor = MouseCursor.IBEAM;
		}
		
		public function get text():String 
		{
			return _text;
		}
		
		public function set text(value:String):void 
		{
			if (_text != value)
			{
				_text = value;
				changeText();
			}
		}
		
		protected function changeText():void
		{
			
		}
	}
}