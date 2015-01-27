package controls
{
	import flash.display.Sprite;
	
	import utls.Alpha;
	import utls.Color;
	
	public class SliderSegmentSprite extends Sprite
	{
		
		private var sprite:Sprite;
		public function SliderSegmentSprite()
		{
			super();
		}
		/**
		 * 级数 
		 */		
		public var level:int=0;
		
		public function draw():void
		{
			if(sprite==null)
			{
				sprite=new Sprite();
				this.addChild(sprite);
			}
			sprite.graphics.lineStyle(1, Color.WHITE, Alpha.UNSEEN, false, "normal", "square", "miter");
			sprite.graphics.beginFill(Color.BLUE, Alpha.PERCENT_40);
			sprite.graphics.drawRect(7, 0, 4, ScrollTrack.sliderSegmentHeight);
			sprite.graphics.endFill();
		}
		
		public function clear():void
		{
			if(sprite!=null)
				sprite.graphics.clear();
		}
	}
}