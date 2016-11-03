package 
{
	import flash.geom.Matrix;
	
	public class Model 
	{
		private var money:Number;
		private var _iq:Number;
		private var gotPregnant:int; //The time model got pregnant. 0 if not pregnant.
		private var isProtected:Boolean;
		private var time:Number;
		private var hunger:Number;
		private var weight:Number;
		private var breastsMass:Number;
		private var buttMass:Number;
		private var timesFucked:Number;
		private var _sexLevel:Number;
		private var _horny:Number;
		private var currentMessage:String = "";
		private var _hasStockings:Boolean = false;
		private var hypnosisLevel:Number;
		private var useImperialSystem:Boolean = false;
		public var stockingsEquipped:Boolean = false;
		private var randomTurn:Number;
		private var hornyStreak:Number;
		
		//Price constants
		private static const siliconePrice:Number = 500;
		private static const buttExpansionPrice:Number = 350;
		public static const hypnosisPrice:Number = 250;
		public static const stockingsPrice:Number = 4000;
		
		private var minimumHorny:Number = 0.1;
		private var pregnancyLastsFor: Number = 40;
		public var devMode:Boolean = false;
		private const moneyScale:Number = 2.1;
		private var _employeeHornynessFactorMaxDays:Number = 800;
		
		
		public var title:Vector.<String> = new <String> 
		["Office Fuckdoll", "Hump Associate", "Secretitty", "\"Sex Counselor\"", "Office Bimbo", "Office Bombshell", "Coffee Girl", "Service Maid",
		"Assistant Secretary", "Assistant", "Receptionist", "Secretary", "Junior Accountant", "Senior Accountant", "Sales Representative",
		"Group Supervisor", "Section Officer", "Department Manager", "Vice Executive Officer", "Bimnocorp Chief Executive Officer"];
		
		public var name:Vector.<String> = new < String > 
		["Tits", "Titti", "Kitti", "Kitty", "Katy",
		"Kathy", "Katharine", "Katheryn", "Catheryn", "Catheryn d'Euvraux"];
		
		public var hungerString:Vector.<String> = new < String >
		["Starving", "Very hungry", "Hungry", "Not hungry", "Satisfied", "Bloated", "Fully stuffed"];
		
		public var sexLevelString:Vector.<String> = new < String >
		["Novice", "Learner", "Bed Girl", "Sexually Aspiring", "Bedroom Pleaser", "Woman of the Night",
		"Miss Sensual", "Mistress of Seduction", "Lady of Pleasure", "Queen of the Sheets", "Succubus Empress"];
		
		public var hornyString:Vector.<String> = new < String >
		["Not quite satisfied", "Slightly horny", "Horny", "Horny as fuck", "Begging to be fucked"];
		
		public var chat:Vector.<String> = new < String >
		["*Tihiii* Could someone fuck me pleeeease? *Giggle* I'm like soo horny!",
		"Fucking is so fun! *Giggle* I really wish somone could just bend me over a table right now!",
		"I'm soo gonna go shopping this weekend!",
		"I met this super cute guy the other day, he even asked me out for a date on friday night! I'm so happy!",
		"One of the accountants asked me out for a date today. Did he really think he got a chance?",
		"Stock value is on the rise... no hickups in business and all employees in check. Wonderful!"];
		
		
		public function Model(startMoney:Number=-1) 
		{
			reset(startMoney);
		}
		
		public function reset(startMoney:Number = 220):void {
			if (startMoney == -1) startMoney = 220;
			money = startMoney;
			iq = 130;
			isProtected = true;
			time = 1;
			gotPregnant = 0;
			hunger = 0;
			weight = 60;
			breastsMass = 0;
			buttMass = 0;
			timesFucked = 0;
			horny = 0;
			hypnosisLevel = 0;
			hornyStreak = 0;
			randomTurn = Math.random();
			currentMessage = "As " + getNameString() + " arrives to the office she is given a warm welcome by all her new colleagues!";
			_hasStockings = false;
			stockingsEquipped = false;
			calculateWeight();
			
		}
		public function update():void 
		{
			time += 1;
			if (time-gotPregnant == pregnancyLastsFor) {
				gotPregnant = 0;
			}
			calculateWeight();
			horny += getDeltaHornyness();
			randomTurn = Math.random();
		}
		
		private function getDeltaHornyness():Number {
			return 0.01 * getBimbonessCompletion() + 0.05 * getBreastsCompletion() + 0.05 * getButtCompletion() + 0.22 * employeeHornynessFactor + 0.005 + hypnosisLevel;
		}
		
		//Input methods
		public function work():void
		{
			money += salary();
			currentMessage = getNameString() + " goes to work";
			if (horny == 1) { 
				currentMessage += " but she is so horny she gets nothing done so she don't earn any money at all, and most of her colleagues notice her not-so-disguised moans."
				if (getBimbonessCompletion() > 0.7) {
					currentMessage += " The only relief is during lunch when she takes one of them with her to the bathroom for a quickie. It's good, but not enough for sure."
					timesFucked++;
				}
			} else if (horny > 0.7) { 
				currentMessage += " but she is so horny she gets very little done and earn just " + getSalaryString() + ". Some of her colleagues seem to be notice how turned on she is, too."
				if (getBimbonessCompletion() > 0.4) {
					currentMessage += " Atleast, when the day is over, one of them comes over and asks her if she'd like to come over for a glass of wine. She gladly accepts."
					timesFucked++;
				}
			} else {
				currentMessage += " and earns " + getSalaryString() + ".";
			}
			update();
		}
		
		public function study():void
		{
			if ( (money >= schoolMoneyChange()) || devMode)
			{
				money -= schoolMoneyChange();
				var iqGained:Number = 0.05 + 5 * (1 - getBimbonessCompletion());
				
				currentMessage = getNameString() + " starts to study";
				if (iq < 60) { 
					currentMessage += " but she would much rather go have sex, and her hands become less and less occupied with writing or holding a book, and more and more occupied rubbing her pussy, making her hornier for every minute."
					currentMessage += " She manages to gain " + int(100 * (iqGained)) / 100 + " IQ before her concentration runs out completely and she has to go find someone to fuck her.";
					horny += getDeltaHornyness() / 2;
				} else if (iq < 70) { 
					currentMessage += " but it's difficult for her to concentrate and her hands always seem to eventually end up fingering herself or groping her boobs."
					currentMessage += " She gains " + int(100 * (iqGained)) / 100 + " IQ before she is way too horny to study any more.";
					horny += getDeltaHornyness() / 3;
				} else if (iq < 85) { 
					currentMessage += " but her head feels clouded by a light pink and she would much rather go shopping for some new underwear, or find someone to have a bit of fun with, rather than to study all day."
					currentMessage += " After gaining " + int(100 * (iqGained)) / 100 + " IQ she finally gives in and go to do something more fun...";
					horny += getDeltaHornyness() / 5;
				} else if (iq < 105) { 
					currentMessage += " but she feels quite a bit lightheaded and can't really concentrate very hard."
					currentMessage += " She gains " + int(100 * (iqGained)) / 100 + " IQ and then decides do something else for the rest of the day. Maybe relax a bit, or go shopping for some new clothes.";
					horny += getDeltaHornyness() / 10;
				} else if (iq < 120) { 
					currentMessage += " and she learns quite a few things that will definitely prove useful to climb the ladders a few steps."
					currentMessage += " She gains " + int(100 * (iqGained)) / 100 + " IQ and then decides to be done for the day.";
					employeeHornynessFactorMaxDays -= 1;
				} else if (iq < 130) { 
					currentMessage += " and she learns quite a few things that will definitely prove useful to climb the ladders a few steps."
					currentMessage += " She gains " + int(100 * (iqGained)) / 100 + " IQ and then decides to be done for the day.";
					employeeHornynessFactorMaxDays -= 5;
				} else if (iq < 140) { 
					currentMessage += ". Reading up on the latest corporate management tactics through means of intozid cancellation, and adding a few comments to the articles herself"
					currentMessage += " she gains " + int(100 * (iqGained)) / 100 + " IQ before eventually going to bed.";
					employeeHornynessFactorMaxDays -= 8;
				} else if (iq < 180) { 
					currentMessage += ". Reading up on the latest corporate management tactics through means of intozid cancellation, and adding a few comments to the articles herself"
					currentMessage += " she gains " + int(100 * (iqGained)) / 100 + " IQ before eventually going to bed.";
					employeeHornynessFactorMaxDays -= 10;
				} else {
					currentMessage += " and gains " + int(100 * (iqGained)) / 100 + " IQ.";
				}
				iq += iqGained;
				update();
			}
		}
		
		public function sex():void
		{
			if (horny > minimumHorny) {
				iq -= (1 + horny * iq/40);
				currentMessage = getNameString() + " has sex";
				var oldHorny:Number = horny;
				horny -= (0.2 + horny / 2);
				money += sexMoney;
				var newHorny:Number = horny + getDeltaHornyness();
				
				if (randomTurn < oldHorny && oldHorny > 0.95) {
					iq -= iq/50;
					currentMessage += " and her orgasm sends waves of pleasure through her body so strong that she briefly even forgets how to speak.";
				} else if (randomTurn < oldHorny) {
					iq -= iq/75;
					currentMessage += " and as she orgasms, a thin, thin mist seems to enter her mind and she starts to feel slightly lightheaded. But she kinda likes it, the feeling is quite relaxing.";
				} else if (newHorny < minimumHorny) {
					currentMessage += ". She starts to feel satisfied.";
				} else if (newHorny > minimumHorny && newHorny <= 0.3) {
					currentMessage += ". But she is still not satisfied!";
				} else if (newHorny > 0.3) {
					currentMessage += ". But she is still so horny!";
				}
				
				timesFucked++;
				if (newHorny > 0.5) {
					hornyStreak++;
				} else {
					hornyStreak = 0;
				}
				
				if (sexLevel > 0.95) {
					currentMessage = getNameString() + " has sex, and pleasure is plentiful for all, because she who can call herself the " + getSexLevelString() + ", is the master of lust.";
				} else if (iq < 60 && sexLevel > 0.95) {
					currentMessage = getNameString() + " has sex, and pleasure is plentiful for all, because she who can call herself the " + getSexLevelString() + 
														", is the master of lust. And lust is the master of her.";
				}
				
				if (hornyStreak == 7) {
					currentMessage = "As waves of pleasure began to overtake " + getNameString() + " yet again, she had a split-second of insight: She was always horny." + 
					" This thought felt strange to her, and yet, so natural. She loved being horny! She loved being fucked senseless both day and night!" + 
					" Suddenly the insight was gone and she let out a scream of pleasure as she came.";
				}
				
				if (!isProtected && gotPregnant == 0) {
					gotPregnant = time;
					currentMessage = getNameString() + " have sex and get pregnant at day " + gotPregnant;
				}
				update();
			} else {
				currentMessage = getNameString() + " is already satisfied enough and don't want to have sex.";
			}
			
			
		}
		
		public function eat():void
		{
			addToHunger(0.5);
		}
		
		public function silicone():void
		{
			if ( (money >= siliconePrice && breastsMass < maxBreastsMass && getBreastsCompletion() < 1.0) || devMode)
			{
				money -= siliconePrice;
				addToBreastsMass(0.05);
				currentMessage = "While the silicone flows into her chest she feels her breasts growing in both size and weight." +
				" When the procedure is over she does feel a bit more sexy.";
				update();
			} else if (money < siliconePrice) {
				currentMessage = getNameString() + " can't afford to buy a silicone injection.";
				if (randomTurn > 0.05 && iq < 120 && breastsMass < maxBreastsMass) {
					currentMessage += " But outside the clinic a man in an overcoat offers her an injection for cheaper. She only have to pay what she can afford!" + 
					" She follows the man to a much smaller, somewhat rundown clinic in the old industrial area, and she recieves her silicone injection." +
					" As her breasts expand, she starts to feel slightly lightheaded, and pretty horny.";
					iq -= 1;
					money = 0;
					horny += 0.2;
					addToBreastsMass(0.05);
					update();
				}
			} else if (getBreastsCompletion() >= 1.0) {
				currentMessage = getNameString() + " can't take any more silicone injections, her breasts are already so big that it would have no effect!";
			} else {
				currentMessage = "The doctor advices her to not take another silicone injection right now. She is smart enough to listen to him.";
			}
		}
		
		public function buttExpansion():void
		{
			if ( (money >= buttExpansionPrice && buttMass < maxButtMass && getButtCompletion() < 1.0) || devMode)
			{
				money -= buttExpansionPrice;
				addToButtMass(0.05);
				currentMessage = getNameString() + " drinks the potion and is overwhelmed by the growing sensation in her ass. It stops suddenly" + 
				" but she can feel a bit more flesh now resting around her hips. It feels good.";
				update();
			} else if (money < buttExpansionPrice) {
				currentMessage = getNameString() + " can't afford an ass growth potion right now.";
				if (randomTurn > 0.70 && buttMass < maxButtMass && money > buttExpansionPrice/4) {
					currentMessage += " Instead she buys some chocolate cake for " + buttExpansionPrice/4 + "$. In the evening she eats all off it by herself. Afterward she feels really full, and sooo good.";
					money -= buttExpansionPrice / 4;
					addToButtMass(0.0125);
					update();
				}
			} else if (getButtCompletion() >= 1.0) {
				currentMessage = getNameString() + " can't drink anymore of these potions, her ass is already so big that it would have no effect!";
			}else {
				currentMessage = getNameString() + " don't want her ass to grow any larger, she's not that dumb.";
			}
		}
		
		public function hypnosis():void
		{
			if (money > hypnosisPrice && iq < 120) {
				money -= hypnosisPrice;
				hypnosisLevel += 0.002;
				currentMessage = getNameString() + " lays back in the chair at the hypnotists, letting his voice carry her away." + 
												" As all her stress diminishes, waves of pleasure arise within her, and she cums several times." +
												" When the session is over she feels strangely, although quite pleasantly, relaxed.";
				update();
				horny = getBimbonessCompletion()/2 - 0.3;
			} else if (money < hypnosisPrice){
				currentMessage = getNameString() + " can't afford to go to the hypnotist right now.";
				if (randomTurn > 0.8) {
					currentMessage += " She instead spends the afternoon looking for hypnotization videos on the internet." +
					" Eventually she finds one with a very smooth mans voice in the background. As she listens to him the world around her seems to fade away." +
					" Waking up, she finds herself laying naked on her bed, feeling a bit dizzy, but quite relaxed too.";
					hypnosisLevel += 0.004;
					iq -= 1;
					update();
					horny = getBimbonessCompletion()/2 - 0.3;
				}
			} else {
				currentMessage = getNameString() + " is too busy to go to some hypnotist. Despite, she is quite certain one couldn't help her much anyways.";
			}
		}
		
		public function buyStockings():void
		{
			if (money > stockingsPrice && _hasStockings == false) {
				money -= stockingsPrice;
				_hasStockings = true;
				currentMessage = getNameString() + " buys a lifetime supply of stockings! She will never have to buy stockings again.";
			} else if (money < stockingsPrice) {
				currentMessage = getNameString() + " can't afford to buy a lifetime supply of stockings.";
			} else if (_hasStockings == true) {
				currentMessage = getNameString() + " already has a LIFETIME supply of stockings. She certainly won't need any more.";
			}
		}
		
		public function toggleStockings():void
		{
			if (_hasStockings) {
				if (stockingsEquipped == false) {
					currentMessage = getNameString() + " puts on some stockings. The material feels smooth against her skin.";
				} else if (stockingsEquipped == true) {
					currentMessage = getNameString() + " takes off her stockings. She sighs as she lets her legs feel the air again."
				}
				stockingsEquipped = !stockingsEquipped;
			} else {
				currentMessage = getNameString() + " thinks of putting on some stockings. Sadly she doesn't own any.";
			}
		}
		
		public function toggleImperial():void
		{
			if (useImperialSystem == true) { 
				useImperialSystem = false; 
			} else {
				useImperialSystem = true;
			}
		}
		
		public function setIsProtected(isProtected:Boolean):void
		{
			this.isProtected = isProtected;
		}
		
		//Calculation methods
		public function salary():Number 
		{
			if (iq > 60) { return (Math.pow(iq - 60, 2) / 20)*(1-horny)}
			else { return 0;}
		}
		
		public function schoolMoneyChange():Number 
		{
			var sCost:Number;
			if (iq > 105) { return (100 + (Math.pow(iq - 105, 4) / 5000)) }
			else {
				return 100;
			}
		}
		
		private function calculateWeight():void
		{
			//addToBreastsMass(0.05*hunger);
			//addToButtMass(0.05 * hunger);
			//addToHunger(-0.05);
			weight = 50+getBreastsCompletion()*20+getButtCompletion()*20+getBellyCompletion()*20;
		}
		
		private function addToHunger(value:Number):void 
		{
			hunger += value;
			if (hunger > 1.0) hunger = 1.0;
			if (hunger < -1.0) hunger = -1.0;
		}
		
		private function addToBreastsMass(value:Number):void
		{
			breastsMass += value;
			if (breastsMass > maxBreastsMass) breastsMass = maxBreastsMass;
			if (breastsMass < 0.0) breastsMass = 0.0;
		}
		
		private function addToButtMass(value:Number):void
		{
			buttMass += value;
			if (buttMass > maxButtMass) buttMass = maxButtMass;
			if (buttMass < 0.0) buttMass = 0.0;
		}
		
		private function get maxBreastsMass():Number
		{
			return 0.2 + getBimbonessCompletion() / 6;
		}
		
		private function get maxButtMass():Number
		{
			return 0.2 + getBimbonessCompletion() / 6;
		}
		
		private function set iq(value:Number):void
		{
			if (value > 170){ _iq = 170;}
			else if (value < 50) { _iq = 50; }
			else _iq = value;
			
		}
		
		private function get iq():Number
		{
			return _iq;
		}
		
		private function get sexMoney():Number
		{
			var value:Number = sexLevel * 300 - 0.4 * 150;
			if (_hasStockings) value = value * 1.2;
			if (value < 0) value = 0;
			return value;
		}
		
		//Get methods
		public function getBimbonessCompletion():Number {
			var comp:Number = 1.0 - ((iq-50) / 100.0); //(iq - lowestAllowedIQ) / (highestIQ-lowestAllowedIQ)
			if (comp > 1.0) { comp = 1.0; }
			else if (comp < 0.0) { comp = 0.0; }
			return comp;
		}
		
		public function getBreastsCompletion():Number {
			var comp:Number = breastsMass*1.3 + getBimbonessCompletion()/1.3;
			if (comp > 1.0) { comp = 1.0; }
			else if (comp < 0.0) { comp = 0.0; }
			return comp;
		}
		
		public function getButtCompletion():Number {
			var comp:Number = buttMass*1.2 + getBimbonessCompletion()/1.3;
			
			if (comp > 1.0) { comp = 1.0; }
			if (comp < 0.0) { comp = 0.0; }
			return comp;
		}
		
		public function getBellyCompletion():Number {
			var comp:Number = 1.0 - iq / 130.0;
			if (comp > 1.0) { comp = 1.0; }
			else if (comp < 0.0) { comp = 0.0; }
			return 0;
		}
		
		public function getHairCompletion():Number {
			var comp:Number = 1.0 - iq / 130.0;
			if (comp > 1.0) { comp = 1.0; }
			else if (comp < 0.0) { comp = 0.0; }
			return getBimbonessCompletion();
		}
		
		/*public function getPregCompletion():Number {
			var comp:Number; 
			if (gotPregnant == 0) return 0;
			
			comp = (time-gotPregnant) / pregnancyLastsFor;
			if (comp > 1.0) { comp = 1.0; }
			else if (comp < 0.0) { comp = 0.0; }
			return comp;
		}*/
		
		public function get sexLevel():Number
		{
			_sexLevel = timesFucked / 140.0;
			if (_sexLevel > 1) _sexLevel = 1;
			if (_sexLevel < 0) _sexLevel = 0;
			return _sexLevel;
		}
		
		private function set horny(value:Number):void
		{
			_horny = value;
			if (value > 1) _horny = 1;
			if (value < 0) _horny = 0;
		}
		
		private function get horny():Number
		{
			return _horny;
		}
		
		private function get employeeHornynessFactor():Number
		{
			var value:Number = time / employeeHornynessFactorMaxDays;
			if (value > 1) value = 1;
			return value;
		}
		
		private function set employeeHornynessFactorMaxDays(value:Number):void
		{
			if (value < 1) {
				_employeeHornynessFactorMaxDays = 1;
			} else {
				_employeeHornynessFactorMaxDays = value;
			}
		}
		
		private function get employeeHornynessFactorMaxDays():Number
		{
			return _employeeHornynessFactorMaxDays;
		}
		
		//Get String methods
		public function getMoneyString():String
		{
			return (Math.round(money * moneyScale).toString() + "$");
		}
		
		public function getIqString():String
		{
			return Math.round(iq).toString() + " IQ";
		}
		
		public function getNameString():String
		{
			return name[(name.length-1)-Math.round(getBimbonessCompletion() * (name.length - 1))];
		}
		
		public function getTitleString():String
		{
			return title[(title.length-1)-Math.round(getBimbonessCompletion() * (title.length - 1))];
		}
		
		public function getChatString():String
		{
			return chat[(chat.length-1)-Math.round(getBimbonessCompletion() * (chat.length - 1))];
		}
		
		public function getTimeString():String
		{
			return "Day: " + time.toString();
		}
		
		public function getHungerString():String
		{
			return hungerString[Math.round(((hunger + 1) / 2) * (hungerString.length - 1))];
		}
		
		public function getWeightString():String
		{
			if (useImperialSystem) {
				return Math.round(weight*2.20462) + " lbs";
			} else {
				return Math.round(weight) + " kg";
			}
		}
		
		public function getSexLevelString():String
		{
			var string:String;
			
			string = sexLevelString[Math.round(sexLevel * (sexLevelString.length - 1))];
			
			if (timesFucked == 0) string = "Virgin";
			
			return string;
		}
		
		public function getSexMoneyChangeString():String
		{
			var string:String = Math.round(sexMoney*moneyScale).toString() +"$";
			return string;
		}
		
		public function getHornyString():String
		{
			var string:String = hornyString[Math.round((horny-minimumHorny) * (hornyString.length - 1+minimumHorny))];
			if (horny < minimumHorny) string = "Satisfied";
			return string;
		}
		
		public function getSiliconePriceString():String
		{
			var string:String = (Math.round(siliconePrice*moneyScale)).toString() + "$";
			return string;
		}
		
		public function getButtExpansionPriceString():String
		{
			var string:String = (Math.round(buttExpansionPrice * moneyScale)).toString() + "$";
			return string;
		}
		
		public function getMessage():String
		{
			return currentMessage;
		}
		
		public function getSalaryString():String
		{
			var string:String = (Math.round(salary() * moneyScale)).toString() + "$";
			return string;
		}
		
		public function getSchoolCostString():String
		{
			var string:String = (Math.round(-schoolMoneyChange() * moneyScale)).toString() + "$";
			return string;
		}
		
		public function getStockingsPriceString():String
		{
			var string:String = (Math.round(stockingsPrice * moneyScale)).toString() + "$";
			return string;
		}
		
		public function getHypnosisPriceString():String
		{
			var string:String = (Math.round(hypnosisPrice * moneyScale)).toString() + "$";
			return string;
		}
	}

}