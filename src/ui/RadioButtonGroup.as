package ui 
{
	public class RadioButtonGroup 
	{
		public var buttons:Vector.<RadioButton> = new Vector.<RadioButton>;
		
		public var callback:Function = null
		
		public function RadioButtonGroup(callback:Function = null, ...buttons) 
		{
			this.callback = callback;
			
			//we add the buttons provided to the constructor, if any
			if (buttons) addList(buttons);
		}
		
		public function add(button:RadioButton):void
		{
			button.group = this;
			buttons.push(button);
		}
		
		public function addList(...buttons):void
		{
			if (!buttons) return;
			if (buttons[0] is Array || buttons[0] is Vector.<RadioButton>)
			{
				//if the parameter is an array or vector of radio buttons, we add the buttons in the vector / array
				for each(var b:RadioButton in buttons[0]) add(b);
			}
			else
			{
				//if the parameters are simply a comma separated list of buttons, we add those instead
				for each(var r:RadioButton in buttons) add(r);
			}
		}
		
		public function remove(button:RadioButton):void
		{
			button.group = null;
			buttons.splice(getIndex(button), 1);
		}
		
		public function removeList(...buttons):void
		{
			if (!buttons) return;
			if (buttons[0] is Array || buttons[0] is Vector.<RadioButton>)
			{
				//if the parameter is an array or vector of radio buttons, we remove the buttons in the vector / array
				for each(var b:RadioButton in buttons[0]) remove(b);
			}
			else
			{
				//if the parameters are simply a comma separated list of buttons, we remove those instead
				for each(var r:RadioButton in buttons) remove(r);
			}
		}
		
		public function removeAll():void
		{
			for each(var b:RadioButton in buttons) b.group = null;
			//fastest way to clear a vector
			buttons.length = 0;
		}
		
		public function getAt(index:int):RadioButton
		{
			return buttons[index];
		}
		
		public function getIndex(button:RadioButton):int
		{
			return buttons.indexOf(button);
		}
		
		internal function click(target:RadioButton, params:Object):void
		{	
			if (callback != null) callback(params);
			
			for each(var b:RadioButton in buttons) b.checked = false;
			target.checked = true;
		}
	}
}