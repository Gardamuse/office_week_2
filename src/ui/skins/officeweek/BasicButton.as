package ui.skins.officeweek 
{
	import com.greensock.TweenLite;
	import flash.display.BitmapData;
	import flash.display.Shader;
	import flash.display.Sprite;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	import flash.geom.Matrix;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Stamp;
	import net.flashpunk.masks.Pixelmask;
	import net.flashpunk.Sfx;
	import ui.Button;
	
	public class BasicButton extends Button 
	{	
		protected var glare:Stamp;
		protected var label:Stamp;
		
		protected var buttonBmp:BitmapData;
		protected var buttonGraphic:Stamp;
		
		public var topColor:uint = 0x1a446b;
		public var glowColor:uint = 0xFFFFFF;
		public var glowColor2:uint = 0x000000;
		public var borderColor:uint = 0x718dab;
		
		public var fontSize:int;
		
		public function BasicButton(x:Number=0, y:Number=0, text:String="", width:Number=150, height:Number=50, callback:Function=null, fontSize:int=16, params:Object=null, keyConstant:int = 1) 
		{
			super(x, y, text, width, height, callback, params, keyConstant);
			
			this.fontSize = fontSize;
			buttonBmp = new BitmapData(width, height, true, 0);
			drawButton(buttonBmp, width, height, topColor, glowColor, borderColor);
			
			buttonGraphic = new Stamp(buttonBmp, 0, 0);
			graphic = buttonGraphic;
			
			drawLabel(text);
			
			drawMask();
		}
		
		protected function drawMask():void
		{
			g.clear();
			g.beginFill(0x000000);
			g.drawRoundRect(0, 0, width, height, 20);
			g.endFill();
			
			var bd:BitmapData = new BitmapData(width, height, true, 0);
			bd.draw(sprite);
			
			mask = new Pixelmask(bd);
		}
		
		protected function drawGlare():void
		{
			var mask:Sprite = new Sprite;
			mask.graphics.copyFrom(g);
			
			sprite.filters = [];
			g.clear();
			g.beginFill(0xFFFFFF, 0.25);
			g.drawEllipse( -width * 0.25, -height * 0.6, width * 1.5, height);
			sprite.mask = mask;
			
			glare = drawStamp(width, height * 0.4);
		}
		
		protected function drawLabel(text:String):void
		{
			var t:TextField = new TextField();
			
			var tf:TextFormat = new TextFormat("Mytype", fontSize, 0xFFFFFF);
			tf.align = "center";
			
			t.defaultTextFormat = tf;
			t.width = width;
			t.height = height;
			t.embedFonts = true;
			t.wordWrap = true;
			t.text = text;
			t.filters = [new GlowFilter(0x6ACFFF, 0.0, 7, 7, 2, 3)];
			
			label = drawStamp(width + 10, t.textHeight + 10, 5, 5, t);
			label.y = (height - t.textHeight) * 0.5 - 8;
		}
		
		protected function drawButton(bitmap:BitmapData, width:Number, height:Number, topColor:uint, glowColor:uint, borderColor:uint):void
		{
			g.clear();
			var gradientMatrix:Matrix = new Matrix();
			gradientMatrix.createGradientBox(width, height, 270 * FP.RAD, 0, 0);
			g.beginFill(topColor);
			g.drawRect(0, 0, width, height);
			g.endFill();
			
			g.lineStyle(16, borderColor);
			g.drawRect(0, 0, width, height);
			
			g.lineStyle(0, 0x000000);
			g.drawRect(0, 0, width-1, height-1);
			
			sprite.filters = [new GlowFilter(glowColor, .3, 64, 64, 1, 2, true), new GlowFilter(glowColor2, .4, 32, 32, 2, 2, true)];
			
			_m.tx = 0;
			_m.ty = 0;
			bitmap.draw(sprite, _m);
		}
		private var _m:Matrix = new Matrix;
		
		override public function render():void 
		{
			super.render();
			
			renderGraphic(glare);
			renderGraphic(label);
		}
		
		override protected function changeState(state:int = 0):void 
		{
			if (state == lastState) return;
			
			var duration:Number = 0.15;
			if (lastState == DOWN) duration = 0.0;
			
			switch(state)
			{
				case NORMAL:
					TweenLite.to(this, duration, { hexColors: { topColor: 0x1a446b, glowColor: 0xFFFFFF, borderColor: 0x718dab }, onUpdate: updateGraphic } );
					//if (lastState == HOVER) new Sfx(Assets.OUT).play();
					break;
				case HOVER:
					TweenLite.to(this, duration, { hexColors: { topColor: 0x173c5d, glowColor: 0x000000, borderColor: 0x5b718a }, onUpdate: updateGraphic } );
					//if (lastState == NORMAL) new Sfx(Assets.OVER).play();
					break;
				case DOWN:
					TweenLite.to(this, 0.0, { hexColors: { topColor: 0x102e48, glowColor: 0x000000, borderColor: 0x8c700e}, onUpdate: updateGraphic } );
					//new Sfx(Assets.CLICK).play();
					break;
			}
			
			super.changeState(state);
		}
		
		protected function updateGraphic():void
		{
			buttonBmp.fillRect(buttonBmp.rect, 0);
			drawButton(buttonBmp, width, height, topColor, glowColor, borderColor);
		}
	}
}