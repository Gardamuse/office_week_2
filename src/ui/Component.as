package ui 
{
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Stamp;
	
	public class Component extends Entity 
	{
		protected var sprite:Sprite;
		protected var g:Graphics;
		
		public function Component(x:Number = 0, y:Number = 0) 
		{
			super(x, y);
			
			sprite = new Sprite;
			g = sprite.graphics;
			
			_m = new Matrix();
		}
		
		private var _m:Matrix;
		
		protected function drawStamp(width:Number, height:Number, offsetX:Number = 0, offsetY:Number = 0, sprite:DisplayObject = null):Stamp
		{	
			return new Stamp(drawBitmap(width, height, offsetX, offsetY, sprite), -offsetX, -offsetY);
		}
		
		protected function drawImage(width:Number, height:Number, offsetX:Number = 0, offsetY:Number = 0, sprite:DisplayObject = null):Image
		{
			var img:Image = new Image(drawBitmap(width, height, offsetX, offsetY, sprite));
			img.x = -offsetX;
			img.y = -offsetY;
			return img;
		}
		
		protected function drawBitmap(width:Number, height:Number, offsetX:Number = 0, offsetY:Number = 0, sprite:DisplayObject = null):BitmapData
		{
			if (sprite == null) sprite = this.sprite;
			
			var bd:BitmapData = new BitmapData(width, height, true, 0);
			_m.tx = offsetX;
			_m.ty = offsetY;
			bd.draw(sprite, _m);
			
			return bd
		}
		
		protected function renderGraphic(graphic:Graphic):void
		{
			if (graphic && graphic.visible)
			{
				if (graphic.relative)
				{
					_point.x = x;
					_point.y = y;
				}
				else _point.x = _point.y = 0;
				_camera.x = world ? world.camera.x : FP.camera.x;
				_camera.y = world ? world.camera.y : FP.camera.y;
				graphic.render(renderTarget ? renderTarget : FP.buffer, _point, _camera);
			}
		}
		protected var _point:Point = FP.point;
		protected var _camera:Point = FP.point2;
	}
}