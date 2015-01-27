package controls
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.AntiAliasType;
	import flash.text.StyleSheet;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	import mx.core.BitmapAsset;
	
	import utls.Alpha;
	import utls.Color;
	
	public class ScrollTrack extends Sprite
	{
		internal static var sliderSegmentHeight:Number=8.0;
			
		[Embed(source="ScrollTrack_ZoomSliderSegment.png")]		
		private var zoomSliderSegment:Class;	
			
		[Embed(source="ScrollTrack_ZoomSlider.png")]		
		private var zoomSlider:Class;	
		
		private var tooltip:TextField;
		private var beginLevel:int = 0;
		private var endLevel:int = 0,curLevel:int=0;
		private var callback:Function;
		private var sliderSegmentSprites:Vector.<SliderSegmentSprite>=new Vector.<SliderSegmentSprite>();
		private var sliderSprite:Sprite;
		private var isMouseDown:Boolean=false;
		private var top:int=0,yDown:int=0,totalHeight:int;
		public function ScrollTrack(beginLevel:int,endLevel:int,callback:Function)
		{
			this.beginLevel = beginLevel;
			this.endLevel = endLevel;
			this.callback = callback;

			this.addEventListener(Event.ADDED,onAdded);			
		}
		public function get level():int{
			return curLevel;
		}
		private function onAdded(e:Event):void
		{
			this.removeEventListener(Event.ADDED,onAdded);
			createControls();			
			
			tooltip=new TextField();
			tooltip.x = 10;
			tooltip.y = 10;
			tooltip.width = 140;
			tooltip.height = 40;
			tooltip.visible = false;
			tooltip.alpha = 0.7;
			tooltip.antiAliasType=AntiAliasType.ADVANCED;
			tooltip.multiline = false;
			tooltip.autoSize = TextFieldAutoSize.LEFT;
			tooltip.wordWrap = false;
			tooltip.background = true;
			tooltip.border = true;
			tooltip.backgroundColor = 0xffffa0;
			var loc2:StyleSheet=new StyleSheet();
			loc2.setStyle("p", {"color":"#000000", "fontFamily":"宋体", "fontSize":12});
			tooltip.styleSheet = loc2;
			this.addChild(tooltip);	
		}
		protected function createControls():void
		{
			if(endLevel >= beginLevel){ 
				var img:BitmapAsset;				
				var h:int=0,n:int=0;
				var sprite:SliderSegmentSprite;
				var len:int = endLevel - beginLevel + 1;
				for(var i:int = len - 1 ; i >= 0  ;i--)
				{
					sprite = new SliderSegmentSprite();
					sprite.level = beginLevel + i;
					img = BitmapAsset(new zoomSliderSegment());
					sprite.addChild(img);					
					this.addChild(sprite);	
					h=sliderSegmentHeight * n++;
					sprite.y= h;	
					sprite.addEventListener(MouseEvent.MOUSE_OVER,onOver);
					sprite.addEventListener(MouseEvent.MOUSE_OUT,onOut);
					sprite.addEventListener(MouseEvent.CLICK,onClick);
					sliderSegmentSprites.push(sprite);
				}
				totalHeight = sliderSegmentHeight * len;
				sliderSprite=new Sprite();
				this.addChild(sliderSprite);
				img = BitmapAsset(new zoomSlider());
				sliderSprite.addChild(img);
				sliderSprite.addEventListener(MouseEvent.MOUSE_OVER,onOver);
				sliderSprite.addEventListener(MouseEvent.MOUSE_OUT,onOut);
				sliderSprite.addEventListener(MouseEvent.MOUSE_DOWN,onDown);
				this.parent.parent.parent.addEventListener(MouseEvent.MOUSE_MOVE,onMove);
				this.parent.parent.parent.addEventListener(MouseEvent.MOUSE_UP,onUp);	
			}
		}
		
		public function setSliderPosition(level:int):void{
			if(level<beginLevel)
				level=beginLevel;
			if(level>endLevel)
				level=endLevel;
			if(curLevel != level)
			{
				curLevel = level;
				sliderSprite.y =(endLevel -  curLevel)* sliderSegmentHeight;
				updateState();
			}
		}
		private function onDown(e:MouseEvent):void{
			isMouseDown=true;
			top = sliderSprite.y;
			yDown = e.stageY;
			e.stopPropagation();
		}
		private function onMove(e:MouseEvent):void{
			if(isMouseDown){
				var y:int = top + e.stageY - yDown;
				if(y<0)
					sliderSprite.y=0;
				else if(y > totalHeight - sliderSegmentHeight)
					sliderSprite.y=totalHeight - sliderSegmentHeight;
				else
					sliderSprite.y=y;
			}
		}
		private function onUp(e:MouseEvent):void{
			if(isMouseDown)
			{
				isMouseDown=false;
				if(e.stageY != yDown)
				{
					var n:int = Math.round(sliderSprite.y/sliderSegmentHeight);
					curLevel = endLevel - n;
					sliderSprite.y = n * sliderSegmentHeight;
					updateState();
					if(callback!=null)
						callback(curLevel);
				}
			}
		}		
		private function onClick(e:MouseEvent):void{
			if(e.currentTarget is SliderSegmentSprite)
			{
				var sprite:SliderSegmentSprite = e.currentTarget as SliderSegmentSprite;
				sliderSprite.y = (endLevel - sprite.level) * sliderSegmentHeight;
				curLevel = sprite.level;
				updateState();
				if(callback!=null)
					callback(curLevel);
			}
		}
		private function updateState():void
		{
			var sprite:SliderSegmentSprite;
			for(var i:int=0,len:int=sliderSegmentSprites.length;i<len;i++)
			{
				sprite=sliderSegmentSprites[i];
				sprite.clear();
				if(sprite.level<=curLevel)
				{
					sprite.draw();
				}
			}
		}
		private function onOver(e:MouseEvent):void{
			tooltip.x = e.currentTarget["x"] + e.localX + 10;
			tooltip.y = e.currentTarget["y"] + e.localY + 10;
			if(e.currentTarget is SliderSegmentSprite)
				displayHint("放置到第"+e.currentTarget["level"]+"级");
			else
				displayHint("拖动放缩");
		}
		private function onOut(e:MouseEvent):void{
			tooltip.visible = false;
		}
		private function displayHint(arg1:String):void
		{
			if (arg1) 
			{
				this.tooltip.htmlText = "<p>" + arg1 + "</p>";
				this.tooltip.width = this.tooltip.textWidth + 5;
				this.tooltip.height = this.tooltip.textHeight + 5;				
				this.tooltip.visible = true;
			}
			else 
			{
				this.tooltip.visible = false;
			}
		}
	}
}