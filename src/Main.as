package
{
	import com.greensock.plugins.HexColorsPlugin;
	import com.greensock.plugins.TweenPlugin;
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	
	public class Main extends Engine
	{
		[Embed(source = "../assets/fonts/mytype.ttf", fontFamily = "Mytype", embedAsCFF = "false")] private var MYTYPE:Class;
		
		public function Main():void 
		{
			super(1152, 704);
		}
		
		override public function init():void 
		{
			super.init();
			
			TweenPlugin.activate([HexColorsPlugin]);
			
			FP.world = new MainMenuWorld();
			//FP.world = new OfficeWorld();
		}
	}
	
}