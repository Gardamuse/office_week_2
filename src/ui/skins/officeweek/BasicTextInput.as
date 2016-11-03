package ui.skins.officeweek 
{
	import com.greensock.TweenLite;
	import flash.display.BitmapData;
	import flash.filters.BevelFilter;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	import flash.geom.Matrix;
	import flash.text.engine.TextLineMirrorRegion;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextLineMetrics;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Stamp;
	import ui.TextInput;
	
	public class BasicTextInput extends TextInput 
	{
		protected var t:TextField;
		protected var tf:TextFormat;
		
		protected var textBitmap:BitmapData;
		
		protected var bgBmp:BitmapData;
		protected var bgStamp:Stamp;
		
		public var topColor:uint = 0x6ACFFF;
		public var bottomColor:uint = 0x005F8C;
		public var borderColor:uint = 0x00456A;
		
		protected var cursor:Stamp;
		
		public function BasicTextInput(x:Number=0, y:Number=0, text:String="", multiline:Boolean=false, width:Number=150, height:Number=30) 
		{
			super(x, y, text, multiline, width, height);
			
			textBitmap = new BitmapData(width, height, true, 0);
			
			createTextfield(text);
			
			bgBmp = new BitmapData(width + 20, height + 20, true, 0);
			bgStamp = new Stamp(bgBmp);
			
			drawBg(width, height);
			
			cursor = new Stamp(new BitmapData(2, 25, false, 0xFFFFFF));
			cursor.visible = false;
			moveCursor();
			
			graphic = new Stamp(textBitmap, 7, 5);
		}
		
		protected function drawBg(width:Number, height:Number):void
		{
			g.clear();
			var gradientMatrix:Matrix = new Matrix();
			gradientMatrix.createGradientBox(width, height, 270 * FP.RAD, 0, 0);
			g.beginGradientFill("linear", [topColor, bottomColor], [1, 1], [0, 255], gradientMatrix);
			g.drawRoundRect(0, 0, width, height, 20);
			g.endFill();
			
			sprite.filters = [new BevelFilter(10, 225, 0xFFFFFF, 1, 0x000000, 0.5, 6, 6, 0.5, 3), new GlowFilter(borderColor, 0.6, 2, 2, 6, 2),
				new DropShadowFilter(8, 45, 0, 0.8, 10, 10, 1, 3)];
			
			_m.tx = 5;
			_m.ty = 5;
			bgBmp.draw(sprite, _m);
		}
		private var _m:Matrix = new Matrix;
		
		protected function createTextfield(text:String):void
		{
			tf = new TextFormat("Comfortaa", 20, 0xFFFFFF);
			
			t = new TextField();
			t.defaultTextFormat = tf;
			t.embedFonts = true;
			t.width = width;
			t.height = height;
			t.text = text;
			t.multiline = this.multiline;
			t.wordWrap = this.multiline;
			
			textBitmap.draw(t);
		}
		
		override protected function onFocus(focused:Boolean):void 
		{
			super.onFocus(focused);
			
			if (focused)
			{
				TweenLite.to(this, 0.25, { hexColors: { topColor: 0xFF8C66, bottomColor: 0xDD0500, borderColor: 0x550000 }, onUpdate: updateGraphic } );
			}
			else
			{
				TweenLite.to(this, 0.25, { hexColors: { topColor: 0x6ACFFF, bottomColor: 0x005F8C, borderColor: 0x00456A }, onUpdate: updateGraphic } );
			}
			
			cursor.visible = focused;
		}
		
		override public function render():void 
		{
			renderGraphic(bgStamp);
			
			super.render();
			
			renderGraphic(cursor);
		}
		
		override protected function changeText():void 
		{
			super.changeText();
			
			if (t)
			{
				t.text = _text;
				updateTextfield();
			}
		}
		
		protected function updateGraphic():void
		{
			bgBmp.fillRect(bgBmp.rect, 0);
			drawBg(width, height);
		}
		
		protected function updateTextfield():void
		{
			textBitmap.fillRect(textBitmap.rect, 0);
			textBitmap.draw(t);
			
			moveCursor();
		}
		
		protected function moveCursor():void
		{
			var lastChar:TextLineMetrics = t.getLineMetrics(t.numLines - 1);
			cursor.x = lastChar.width + 10;
			cursor.y = lastChar.height * (t.numLines - 1) + 8;
		}
	}

}