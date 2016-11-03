package 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.graphics.Stamp;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	public class SelfCam extends Entity
	{
		
		private var sw:int = 64;
		private var sh:int = 64;
		private const SPRITESHEET_LENGTH:int = 30; //The length of the main animation spritesheets as set in gen_spritesheets.bat
		
		//private var mainBmd:BitmapData = FP.getBitmap(Assets.KATHERINE);
		//private var mainCompletion:Number = 0.0;
		
		private var bimbonessBmd:BitmapData = FP.getBitmap(Assets.BIMBONESS);
		private var breastsBmd:BitmapData = FP.getBitmap(Assets.BREASTS);
		private var buttBmd:BitmapData = FP.getBitmap(Assets.BUTT);
		private var bellyBmd:BitmapData = FP.getBitmap(Assets.BELLY);
		private var hairBmd:BitmapData = FP.getBitmap(Assets.HAIR);
		private var stockingsBmd:BitmapData = FP.getBitmap(Assets.STOCKINGS);
		private var backgroundBmd:BitmapData = FP.getBitmap(Assets.BACKGROUNDS);
		
		private var drawBmd:BitmapData = new BitmapData(sw, sh);
		
		private var pregCompletion:Number = 0.0;
		
		private var model:Model;
		
		private var skinColor:Vector.<uint> = genMultiStepGm(new <uint> [0xf7cd88, 0xd2853c], new <int> [100]);
		private var skinColorDark:Vector.<uint> = genMultiStepGm(new <uint> [0xffe1b46c, 0xc37934], new <int> [100]);
		private var hairColor:Vector.<uint> = genMultiStepGm(new <uint> [0xfff9f6, 0x7c431d, 0xffe596], new <int> [15, 85]);
		private var eyeColor:Vector.<uint> = genMultiStepGm(new <uint> [0x5c6c7c, 0x196bba, 0x3290f9], new <int> [20, 80]);
		private var shirtColor:Vector.<uint> = genMultiStepGm(new <uint> [0x141718, 0x1a7bbb, 0xff007d, 0xff007d], new <int> [40, 50, 10]);
		private var shirtColorDark:Vector.<uint> = genMultiStepGm(new <uint> [0x0d0e0f, 0x1b6ea7, 0xd20067], new <int> [40, 60]);
		private var pantsColor:Vector.<uint> = genMultiStepGm(new <uint> [0x1e1f20, 0x1f526f, 0xff007d, 0xff007d], new <int> [40, 50, 10]);
		private var buttonsColor:Vector.<uint> = genMultiStepGm(new <uint> [0xffcb2f, 0xd6af3a, 0xff007d, 0xff007d], new <int> [40, 50, 10]);
		private var lipsColor:Vector.<uint> = genMultiStepGm(new <uint> [0xf07d7d, 0xf00c7b], new <int> [100]);
		private var bootsColor:Vector.<uint> = genMultiStepGm(new <uint> [0x010101, 0x222222, 0xf00c7b], new <int> [50, 50]);
		private var pantyColor:Vector.<uint> = genMultiStepGm(new <uint> [0xff88dd, 0xff88dd, 0xff00b6], new <int> [50, 50]);
		private var nippleColor:Vector.<uint> = genMultiStepGm(new <uint> [0xfb9d73, 0xa95e16], new <int> [100]);
		private var glassesColor:Vector.<uint> = genMultiStepGm(new <uint> [0x949494, 0x949494], new <int> [100]);
		private var glassesGlassColor:Vector.<uint> = genMultiStepGm(new <uint> [0x84c1d6, 0x84c1d6], new <int> [100]);
		private var scarfColor:Vector.<uint> = genMultiStepGm(new <uint> [0xa10000, 0xa10000], new <int> [100]);
		private var stockingsColor:Vector.<uint> = genMultiStepGm(new <uint> [0xffffff, 0xa5cfea, 0xc098f9, 0xff9ecd], new <int> [40, 20, 40]);
		private var stockingsColorDark:Vector.<uint> = genMultiStepGm(new <uint> [0xffffff, 0x4daae8, 0x8a38ff, 0xff5cac], new <int> [40, 20, 40]);
		
		private var katherineSpr:Spritemap;
		private var imgNr:int = 0;
		
		
		public function SelfCam(model:Model) 
		{
			this.model = model;
			
			setSeqCompletion();
			
			//graphic = new Graphiclist(katherineSpr, katherinePreg);
			//graphic = katherineSpr;

		}
		
		override public function update():void
		{
			super.update();
		}
		
		/** @param comp 0.0 means first image and 1.0 means the last one.*/
		public function setSeqCompletion():void
		{
			/*var frame:int;
			var colorNr:int; //Controls which color is currently set
			var mainComp:Number = model.getMainCompletion();
			frame = Math.round(mainComp * (mainBmd.width / sw));
			colorNr = Math.round(mainComp * (skinColor.length - 1));*/
			
			var bimbonessComp:Number = model.getBimbonessCompletion();
			var bimbonessFrame:int = bimbonessComp * ((bimbonessBmd.width / sw) - (SPRITESHEET_LENGTH+1-12)); //The last number on the line is the frame of the animation where it is 100% complete.
			var breastsComp:Number = model.getBreastsCompletion();
			var breastsFrame:int = breastsComp * ((breastsBmd.width / sw) - (SPRITESHEET_LENGTH+1-27));
			var buttComp:Number = model.getButtCompletion();
			var buttFrame:int = buttComp * ((buttBmd.width / sw) - (SPRITESHEET_LENGTH+1-26));
			var bellyComp:Number = model.getBellyCompletion();
			var bellyFrame:int = bellyComp * ((bellyBmd.width / sw) - (SPRITESHEET_LENGTH+1-1));
			var hairComp:Number = model.getHairCompletion();
			var hairFrame:int = hairComp * ((hairBmd.width / sw) - (SPRITESHEET_LENGTH+1-19));
			var backgroundFrame:int = bimbonessComp * ((backgroundBmd.width / sw) - 1);
			var stockingsFrame:int = 0;
			if (model.stockingsEquipped) stockingsFrame = buttFrame;
			
			var colorNr:int = Math.round(bimbonessComp * (skinColor.length - 1));
			
			//trace("Preg completion: " + pregComp);
			//trace("Main completion: " + mainComp);
			
			drawBmd = new BitmapData(sw, sh, true, 0x00000000);
			drawBmd.threshold(backgroundBmd, new Rectangle(sw * backgroundFrame, 0, sw, sh), new Point(0, 0), "==", 0x00000000, 0xffffffff, 0xffffffff, true);
			
			//mainBmd transformations
			thresholdBmd(bimbonessBmd, bimbonessFrame, colorNr);
			thresholdBmd(breastsBmd, breastsFrame, colorNr);
			thresholdBmd(buttBmd, buttFrame, colorNr);
			thresholdBmd(bellyBmd, bellyFrame, colorNr);
			thresholdBmd(hairBmd, hairFrame, colorNr);
			thresholdBmd(stockingsBmd, stockingsFrame, colorNr);
			if (model.stockingsEquipped) { drawBmd.threshold(bimbonessBmd, new Rectangle(sw * bimbonessFrame, 0, sw, sh), new Point(0, 0), "==", 0xffffaa54, stockingsColor[colorNr]); }
			else { 
			drawBmd.threshold(bimbonessBmd, new Rectangle(sw * bimbonessFrame, 0, sw, sh), new Point(0, 0), "==", 0xffffaa54, skinColor[colorNr]);}
			
			
			katherineSpr = new Spritemap(drawBmd, sw, sh);
			katherineSpr.scale = 8;
			katherineSpr.setFrame(0);
			graphic = katherineSpr;
			
		}
		
		private function thresholdBmd(bmd:BitmapData, frame:int, colorNr:int):void {
			drawBmd.threshold(bmd, new Rectangle(sw*frame, 0, sw, sh), new Point(0, 0), "==", 0xfff0c47d, skinColor[colorNr]);
			drawBmd.threshold(bmd, new Rectangle(sw*frame, 0, sw, sh), new Point(0, 0), "==", 0xffe1b46c, skinColorDark[colorNr]);
			drawBmd.threshold(bmd, new Rectangle(sw*frame, 0, sw, sh), new Point(0, 0), "==", 0xfffff9f6, hairColor[colorNr]);
			drawBmd.threshold(bmd, new Rectangle(sw*frame, 0, sw, sh), new Point(0, 0), "==", 0xff196bba, eyeColor[colorNr]);
			drawBmd.threshold(bmd, new Rectangle(sw*frame, 0, sw, sh), new Point(0, 0), "==", 0xff1a7bbb, shirtColor[colorNr]);
			drawBmd.threshold(bmd, new Rectangle(sw*frame, 0, sw, sh), new Point(0, 0), "==", 0xff1b6ea7, shirtColorDark[colorNr]);
			drawBmd.threshold(bmd, new Rectangle(sw*frame, 0, sw, sh), new Point(0, 0), "==", 0xff1e1f20, pantsColor[colorNr]);
			drawBmd.threshold(bmd, new Rectangle(sw*frame, 0, sw, sh), new Point(0, 0), "==", 0xffd6af3a, buttonsColor[colorNr]);
			drawBmd.threshold(bmd, new Rectangle(sw*frame, 0, sw, sh), new Point(0, 0), "==", 0xfff07d7d, lipsColor[colorNr]);
			drawBmd.threshold(bmd, new Rectangle(sw*frame, 0, sw, sh), new Point(0, 0), "==", 0xff343434, bootsColor[colorNr]);
			drawBmd.threshold(bmd, new Rectangle(sw*frame, 0, sw, sh), new Point(0, 0), "==", 0xffff88dd, pantyColor[colorNr]);
			drawBmd.threshold(bmd, new Rectangle(sw*frame, 0, sw, sh), new Point(0, 0), "==", 0xffa95e16, nippleColor[colorNr]);
			drawBmd.threshold(bmd, new Rectangle(sw*frame, 0, sw, sh), new Point(0, 0), "==", 0xff949494, glassesColor[colorNr]);
			drawBmd.threshold(bmd, new Rectangle(sw*frame, 0, sw, sh), new Point(0, 0), "==", 0xff7aa5b4, glassesGlassColor[colorNr]);
			drawBmd.threshold(bmd, new Rectangle(sw*frame, 0, sw, sh), new Point(0, 0), "==", 0xffa10000, scarfColor[colorNr]);
			drawBmd.threshold(bmd, new Rectangle(sw*frame, 0, sw, sh), new Point(0, 0), "==", 0xffeebbff, stockingsColor[colorNr]);
			drawBmd.threshold(bmd, new Rectangle(sw*frame, 0, sw, sh), new Point(0, 0), "==", 0xffbb22ee, stockingsColorDark[colorNr]);
		}
		
		/** @param colorSteps Vector containing all colors you want to gradient through. Has to have atleast 2 elements.
		 * @param steps Vector containing how many steps you want there to be in the gradient between every colorStep.
		 * Has to have exactly one less element than colorsteps.
		 * */
		private function genMultiStepGm(colorSteps:Vector.<uint>, steps:Vector.<int>):Vector.<uint>
		{
			var vec:Vector.<uint> = new Vector.<uint>;
			for (var i:int = 0; i < (colorSteps.length - 1); i++ ) {
				var cv:Vector.<uint> = genArgbGm(colorSteps[i], colorSteps[i + 1], steps[i]);
				for (var j:int = 0; j < cv.length; j++ ) {
					vec.push(cv[j]);
				}	
			}
			return vec;
		}
		
		private function interpolate(pBegin:uint, pEnd:uint, pStep:int, pMax:int):uint
		{
			if (pBegin < pEnd) {
				return ((pEnd - pBegin) * (pStep / pMax)) + pBegin;
			} else {
				return ((pBegin - pEnd) * (1 - (pStep / pMax))) + pEnd;
			}
		}
		
		/** Generates a vector containing numSteps many ARGB colors including and between colorBegin and colorEnd.
		 * @param colorBegin An RGB color that will be the first in the output Vector.
		 * @param colorEnd And RGB color that will be the last in the output Vector.
		 * @param numsteps How many steps will be taken to generate intermediate colors. This will be the length of the output Vector. 
		 * */
		private function genArgbGm(colorBegin:uint, colorEnd:uint, numSteps:int):Vector.<uint>
		{
		var r0:uint = (colorBegin & 0xff0000) >> 16;
		var g0:uint = (colorBegin & 0x00ff00) >> 8;
		var b0:uint = (colorBegin & 0x0000ff) >> 0;
		
		var r1:uint = (colorEnd & 0xff0000) >> 16;
		var g1:uint = (colorEnd & 0x00ff00) >> 8;
		var b1:uint = (colorEnd & 0x0000ff) >> 0;
		
		var value:uint;
		var vec:Vector.<uint> = new Vector.<uint>;
		
		for (var i:int = 0; i < numSteps; i++) {
			var r:uint = interpolate(r0, r1, i, numSteps);
			var g:uint = interpolate(g0, g1, i, numSteps);
			var b:uint = interpolate(b0, b1, i, numSteps);
			value = (((r << 8) | g) << 8) | b;
			vec.push(0xff000000 + value);
		}
		return vec;
		}
		
		
	}

}