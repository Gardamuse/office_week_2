package 
{
	import flash.ui.MouseCursor;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.World;
	import ui.Button;
	import ui.Checkbox;
	import ui.skins.*;
	import ui.skins.officeweek.*;
	
	public class OfficeWorld extends World
	{
		private var cam:SelfCam;
		private var model:Model;
		
		//UI variables
		private var bx:Number = 128;
		private var by:Number = 64;
		private var col0:int = 512;
		private var row0:int = 0;
		
		//Textfields
		private var moneyF:BasicTextField = new BasicTextField(col(1), row(3), "", bx*1, by, 24);
		private var salaryF:BasicTextField = new BasicTextField(col(2), row(3), "", bx*1, by, 24);
		private var iqF:BasicTextField = new BasicTextField(col(1), row(4), "", bx, by, 24);
		private var schoolCostF:BasicTextField = new BasicTextField(col(2), row(4), "", bx, by, 24);
		private var weightF:BasicTextField = new BasicTextField(col(1), row(2), "", bx, by, 24);
		private var hungerF:BasicTextField = new BasicTextField(col(2), row(6), "", bx*3, by, 24);
		private var chatF:FancyChatField = new FancyChatField(col(-4), row(8), "", bx*4, by*3, 16);
		private var nameF:FancyTextField = new FancyTextField(col(0), row(0), "", bx * 5, by, 24);
		private var titleF:FancyTextField = new FancyTextField(col(0), row(1), "", bx * 5, by, 24);
		private var timeF:BasicTextField = new BasicTextField(col(0), row(2), "", bx, by, 20);
		private var sexLevelF:BasicTextField = new BasicTextField(col(1), row(6), "", bx*3, by, 24);
		private var sexCostF:BasicTextField = new BasicTextField(col(3), row(5), "", bx, by, 24);
		private var hornyF:BasicTextField = new BasicTextField(col(1), row(5), "", bx*2, by, 20);
		private var siliconePriceF:BasicTextField = new BasicTextField(col(0), row(10), "", bx*1, by, 24);
		private var buttExpansionPriceF:BasicTextField = new BasicTextField(col(1), row(10), "", bx*1, by, 24);
		
		private var shopF:BasicTextField = new BasicTextField(col(0), row(7), "Shop", bx*5, by, 24);
		private var itemF:BasicTextField = new BasicTextField(col(1), row(7), "Item", bx, by, 24);
		private var priceF:BasicTextField = new BasicTextField(col(1), row(8), "Price", bx, by, 24);
		private var hypnosisPriceF:BasicTextField = new BasicTextField(col(2), row(10), "", bx, by, 24);
		private var stockingsPriceF:BasicTextField = new BasicTextField(col(4), row(10), "", bx, by, 24);
		
		
		
		private var protectB:BasicCheckbox;
		
		public function OfficeWorld(startMoney:Number=-1) 
		{
			model = new Model(startMoney);
			cam = new SelfCam(model);
			
			add(new BasicButton(col(0), row(3), "Work (Q)", bx, by, work, 20, null, Key.Q));
			add(new BasicButton(col(0), row(4), "Study (W)", bx, by, study, 20, null, Key.W));
			add(new BasicButton(col(0), row(5), "Fuck (E)", bx, by * 2, sex, 20, null, Key.E));
			
			add(new BasicButton(col(0), row(8), "Silicone Injection (A)", bx*1, by*2, silicone, 18, null, Key.A));
			add(new BasicButton(col(1), row(8), "Ass Growth Potion (S)", bx*1, by*2, buttExpansion, 18, null, Key.S));
			add(new BasicButton(col(2), row(8), "Hypnosis Session (D)", bx*1, by*2, hypnosis, 18, null, Key.D));
			add(new BasicButton(col(4), row(8), "Lifetime supply of stockings", bx * 1, by * 2, buyStockings, 18, null));
			
			add(new BasicButton(col(4), row(6), "(T)oggle stockings", bx*1, by, toggleStockings, 18, null, Key.T));
			//add(new BasicButton(col(0), row(6), "Eat (F)", bx, by, model.eat, 20));
			add(new BasicButton(col(4), row(2), "Restart", bx, 40, restart, 20));
			add(new BasicButton(col(4), row(2.6), "Switch unit system", bx, by, toggleImperial, 16));
			
			protectB = new BasicCheckbox(512, 200, "Use Protection", 250, 50, model.setIsProtected, null, true);
			//add(protectB);
			
			
			add(cam);
			add(moneyF);
			add(iqF);
			add(chatF);
			add(nameF);
			add(titleF);
			add(timeF);
			//add(hungerF);
			add(salaryF);
			add(weightF);
			add(sexLevelF);
			add(sexCostF);
			add(hornyF);
			add(shopF);
			//add(itemF);
			//add(priceF);
			add(siliconePriceF);
			add(buttExpansionPriceF);
			add(schoolCostF);
			add(stockingsPriceF);
			add(hypnosisPriceF);
			
			updateText();
			
		}
		
		private function updateText():void
		{
			moneyF.setText(model.getMoneyString());
			iqF.setText(model.getIqString());
			nameF.setText(model.getNameString());
			titleF.setText(model.getTitleString());
			chatF.setText(model.getMessage());
			timeF.setText(model.getTimeString());
			hungerF.setText(model.getHungerString());
			salaryF.setText(model.getSalaryString());
			weightF.setText(model.getWeightString());
			sexLevelF.setText(model.getSexLevelString());
			sexCostF.setText(model.getSexMoneyChangeString());
			hornyF.setText(model.getHornyString());
			siliconePriceF.setText(model.getSiliconePriceString());
			buttExpansionPriceF.setText(model.getButtExpansionPriceString());
			schoolCostF.setText(model.getSchoolCostString());
			stockingsPriceF.setText(model.getStockingsPriceString());
			hypnosisPriceF.setText(model.getHypnosisPriceString());
		}
		
		override public function update():void 
		{
			Input.mouseCursor = MouseCursor.AUTO;
			super.update();
			
		}
		
		private function work():void
		{
			model.work();
			cam.setSeqCompletion();
			updateText();
		}
		
		private function study():void
		{
			model.study();
			cam.setSeqCompletion();
			updateText();
		}
		
		private function sex():void
		{
			model.sex();
			cam.setSeqCompletion();
			updateText();
		}
		
		private function silicone():void
		{
			model.silicone();
			cam.setSeqCompletion();
			updateText();
		}
		
		private function buttExpansion():void
		{
			model.buttExpansion();
			cam.setSeqCompletion();
			updateText();
		}
		
		private function hypnosis():void
		{
			model.hypnosis();
			cam.setSeqCompletion();
			updateText();
		}
		
		private function buyStockings():void
		{
			model.buyStockings();
			cam.setSeqCompletion();
			updateText();
		}
		
		private function toggleStockings():void
		{
			model.toggleStockings();
			cam.setSeqCompletion();
			updateText();
		}
		
		private function restart():void
		{
			model.reset();
			cam.setSeqCompletion();
			updateText();
			protectB.setChecked(true);
		}
		
		private function toggleImperial():void
		{
			model.toggleImperial();
			cam.setSeqCompletion();
			updateText();
		}
		
		private function row(rowNr:Number):int
		{
			return row0 + by * rowNr;
		}
		
		private function col(colNr:Number):int
		{
			return col0 + bx * colNr;
		}
		
	}

}