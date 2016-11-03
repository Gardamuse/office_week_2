package ui.skins.officeweek
{
	import com.greensock.TweenLite;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.filters.BevelFilter;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	import flash.geom.Matrix;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Stamp;
	import net.flashpunk.masks.Pixelmask;
	import ui.Checkbox;
	
	public class BasicCheckbox extends Checkbox
	{
		protected var glare:Stamp;
		protected var label:Stamp;
		
		protected var check:Image = new Image(Assets.CHECK);
		
		protected var buttonBmp:BitmapData;
		
		public var topColor:uint = 0x1a446b;
		public var glowColor:uint = 0xFFFFFF;
		public var glowColor2:uint = 0x000000;
		public var borderColor:uint = 0x718dab;
		
		public function BasicCheckbox(x:Number = 0, y:Number = 0, text:String = "", width:Number = 200, height:Number = 50, callback:Function = null, params:Object = null, checked:Boolean = false)
		{
			//we need width to always be larger or the same as height, because of the check square.
			if (height > width) width = height;
			
			super(x, y, text, width, height, callback, params, checked);
			
			buttonBmp = new BitmapData(width + 20, height + 20, true, 0);
			drawButton(buttonBmp, width, height);
			
			//drawGlare();
			drawLabel(text);
			
			check = new Image(Assets.CHECK);
			check.smooth = true;
			check.scale = height / check.width;
			check.alpha = checked ? 1 : 0;
			
			graphic = new Stamp(buttonBmp, -5, -5);
			
			drawMask();
		}
		
		protected function drawMask():void
		{
			//the mask is basically the check square + a square the size of the text.
			sprite.mask = null;
			
			g.clear();
			g.beginFill(0x000000);
			g.drawRoundRect(0, 0, height, height, 20);
			g.endFill();
			g.beginFill(0);
			g.drawRect(height, label.y + 5, label.width + 5, label.height - 5);
			g.endFill();
			
			var bd:BitmapData = new BitmapData(width, height, true, 0);
			bd.draw(sprite);
			
			mask = new Pixelmask(bd);
		}
		
		protected function drawLabel(text:String):void
		{
			var t:TextField = new TextField();
			
			var tf:TextFormat = new TextFormat("Mytype", 20, 0xFFFFFF);
			
			t.defaultTextFormat = tf;
			t.width = width - height - 5; //take text position into account
			t.height = height;
			t.embedFonts = true;
			t.wordWrap = true; //if our checkbox widht is smaller than the text, the text adapts.
			t.text = text;
			t.filters = [new GlowFilter(0x333333, 0.6, 6, 6, 4, 2)];
			
			label = drawStamp(t.textWidth + 10, t.textHeight + 10, 5, 5, t);
			label.y = (height - t.textHeight) * 0.5 - 8;
			label.x = height + 5;
		}
		
		protected function drawGlare():void
		{
			//the same method from blue button, but instead of taking width into account, we use the height for the width of the rectangle,
			//this way we make it a square. it will be the check square.
			var mask:Sprite = new Sprite;
			mask.graphics.copyFrom(g);
			
			sprite.filters = [];
			g.clear();
			g.beginFill(0xFFFFFF, 0.25);
			g.drawEllipse(-height * 0.25, -height * 0.6, height * 1.5, height);
			sprite.mask = mask;
			
			glare = drawStamp(width, height * 0.4);
		}
		
		protected function drawButton(bitmap:BitmapData, width:Number, height:Number):void
		{
			//the same method from blue button, but instead of taking width into account, we use the height for the width of the rectangle,
			//this way we make it a square. it will be the check square.
			g.clear();
			var gradientMatrix:Matrix = new Matrix();
			gradientMatrix.createGradientBox(width, height, 270 * FP.RAD, 0, 0);
			g.beginFill(topColor);
			g.drawRect(0, 0, height, height);
			g.endFill();
			
			g.lineStyle(8, borderColor);
			g.drawRect(4, 4, height-8, height-8);
			
			g.lineStyle(0, 0x000000);
			g.drawRect(0, 0, height-1, height-1);
			
			sprite.filters = [new GlowFilter(glowColor, .3, 64, 64, 1, 2, true), new GlowFilter(glowColor2, .4, 32, 32, 2, 2, true)];
			
			_m.tx = 5;
			_m.ty = 5;
			bitmap.draw(sprite, _m);
		}
		
		override protected function changeState(state:int = 0):void 
		{
			if (state == lastState) return;
			
			var duration:Number = 0.15;
			if (lastState == DOWN) duration = 0.15;
			
			switch(state)
			{
				case NORMAL:
					TweenLite.to(this, duration, { hexColors: { topColor: 0x1a446b, borderColor: 0x718dab }, onUpdate: updateGraphic } );
					break;
				case HOVER:
					TweenLite.to(this, duration, { hexColors: { topColor: 0x173c5d, borderColor: 0x5b718a }, onUpdate: updateGraphic } );
					break;
				case DOWN:
					//TweenLite.to(this, 0.1, { hexColors: { topColor: 0x5B5B5B, borderColor: 0x151515 }, onUpdate: updateGraphic } );
					break;
			}
			
			super.changeState(state);
		}
		
		override protected function changeCheck():void 
		{
			super.changeCheck();
			
			if (_checked)
			{
				TweenLite.to(check, 0.15, { alpha: 1 } );
			}
			else
			{
				TweenLite.to(check, 0.15, { alpha: 0 } );
			}
		}
		
		protected function updateGraphic():void
		{
			buttonBmp.fillRect(buttonBmp.rect, 0);
			drawButton(buttonBmp, width, height);
		}
		
		override public function render():void
		{
			super.render();
			
			renderGraphic(glare);
			
			if (check.alpha > 0) renderGraphic(check);
			
			renderGraphic(label);
		}
		
		private var _m:Matrix = new Matrix;
	}
}