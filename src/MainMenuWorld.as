package 
{
	import flash.ui.MouseCursor;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.World;
	import ui.Button;
	import ui.skins.*;
	import ui.skins.officeweek.*;
	
	public class MainMenuWorld extends World
	{
		private var slayerVictoryF:FancyTextField;
		private var moneyCheat:Boolean = false;
		
		public function MainMenuWorld() 
		{
		}
		
		override public function begin():void
		{
			super.begin();
			FP.screen.color = 0x225280;
			add(new FancyTextField(FP.screen.width / 2 - 512, 32, "Background",
			1024, 64, 40));
			add(new FancyChatField(FP.screen.width / 2 - 512, FP.screen.height / 3 - 128, "Having been unemployed for some time, the always ambitious Katherine was relieved to be hired into a pretty well paid position at Bimnocorp. Not that she had worried very much. She knew people of her age and education were fairly well sought after in big companies right now, and back in school she had always been top of the class. She had merits to show for it, too." + 
			"\n The only thing she found slightly disturbing was that she hadn't been able to quite figure out exactly what Bimnocorp actually did, but she assumed that they were probably being secretive about it for some good reason. And a reason she was about to learn." + 
			"\n Her first week would start on Monday and she was planning on doing anything to climb to the top, no matter how much studying and hard work it would take. Katherine mused, she was excited to get started.",
			1024, 256, 17));
			add(new BasicButton(FP.screen.width / 2 - 256, 3 * FP.screen.height / 4 - 128, "Start your employement", 512, 256, startNew, 64));
			//add(new BasicTextInput(0, 500, "123"));
			slayerVictoryF = new FancyTextField(FP.screen.width / 2 + 256 + 12, 3 * FP.screen.height / 4 - 128, "To SlayerEndX13, and to those who accomplish the same feat as him" +
			" I give my greatest gratulations! Because you have proven that through hard work you can do anything, the gift of wealth without work, is yours, everytime you lay your eyes upon this message. Now go have some fun!", 300, 256, 16);
			slayerVictoryF.visible = false;
			add(slayerVictoryF);
			
		}
		
		override public function update():void 
		{
			Input.mouseCursor = MouseCursor.AUTO;
			super.update();
			if (Input.keyString.match("SlayerEnd27") != null) {
				slayerVictoryF.visible = true;
				moneyCheat = true;
			}
		}
		
		private function startNew():void {
			if (moneyCheat == false) {
				FP.world = new OfficeWorld();
			} else {
				FP.world = new OfficeWorld(328571.5);
			}
		}
		
	}

}