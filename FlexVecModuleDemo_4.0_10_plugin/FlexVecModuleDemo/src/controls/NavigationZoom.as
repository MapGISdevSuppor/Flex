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
	
	public class NavigationZoom extends Sprite
	{	
		[Embed(source="NavigationZoom_ZoomInIcon.png")]		
		private var zoomInIcon:Class;	
			
		[Embed(source="NavigationZoom_ZoomOutIcon.png")]		
		private var zoomOutIcon:Class;	
		private var tooltip:TextField;
		private var scrollTrack:ScrollTrack;
		
		private var beginLevel:int = 0;
		private var endLevel:int = 0;
		private var enableSliderSegment:Boolean;
		private var sliderCallback:Function,zoomInCallback:Function,zoomOutCallback:Function;
		
		public function NavigationZoom(beginLevel:int,endLevel:int,enableSliderSegment:Boolean,
									   sliderCallback:Function,zoomInCallback:Function,zoomOutCallback:Function)
		{
			this.beginLevel=beginLevel;
			this.endLevel=endLevel;
			this.enableSliderSegment=enableSliderSegment;
			this.sliderCallback=sliderCallback;
			this.zoomInCallback=zoomInCallback;
			this.zoomOutCallback=zoomOutCallback;
			this.addEventListener(Event.ADDED,onAdded);				
		}
		
		public function setSliderPosition(level:int):void{
			if(enableSliderSegment && scrollTrack!=null)
			{
				scrollTrack.setSliderPosition(level);
			}
		}
		public function get level():int{
			return scrollTrack.level;
		}
		private function onAdded(e:Event):void
		{
			this.removeEventListener(Event.ADDED,onAdded);
			
			if(tooltip==null)
			{
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
			var img:BitmapAsset = BitmapAsset(new zoomInIcon());
			this.addChildAt(img,0);
			var h:int=img.height;
			var zoomInSprite:Sprite =new Sprite();
			zoomInSprite.x=3
			zoomInSprite.y=5;
			onOut(zoomInSprite,12,12);
			if(zoomInCallback!=null)
				zoomInSprite.addEventListener(MouseEvent.MOUSE_DOWN,function(e:MouseEvent):void{	
					if(enableSliderSegment)
					{
						var l:int = scrollTrack.level+1;
						if(scrollTrack!=null)
							scrollTrack.setSliderPosition(l);
						if(l>=beginLevel && l<=endLevel)
							zoomInCallback();
					}
					else
						zoomInCallback();
				});
			zoomInSprite.addEventListener(MouseEvent.MOUSE_OVER,function(e:MouseEvent):void{
				tooltip.x = e.currentTarget["x"] + e.localX + 10;
				tooltip.y = e.currentTarget["y"] + e.localY + 10;
				displayHint("放大一级");
				onOver(e.currentTarget as Sprite,12,12);
			});
			zoomInSprite.addEventListener(MouseEvent.MOUSE_OUT,function(e:MouseEvent):void{
				tooltip.visible = false;
				onOut(e.currentTarget as Sprite,12,12);
			});
			this.addChild(zoomInSprite);	
			
			if(enableSliderSegment)
			{
				createScrollTrack(beginLevel,endLevel,sliderCallback,h);
				h+=scrollTrack.height;
			}
			
			img= BitmapAsset(new zoomOutIcon());
			this.addChildAt(img,0).y = h;	
			var zoomOutSprite:Sprite =new Sprite();
			zoomOutSprite.x=3
			zoomOutSprite.y=h+8;
			onOut(zoomOutSprite,12,12);
			if(zoomOutCallback!=null)
				zoomOutSprite.addEventListener(MouseEvent.MOUSE_DOWN,function(e:MouseEvent):void{
					if(enableSliderSegment)
					{
						var l:int = scrollTrack.level-1;
						if(scrollTrack!=null)
							scrollTrack.setSliderPosition(l);
						if(l>=beginLevel && l<=endLevel)
							zoomOutCallback();
					}
					else
						zoomOutCallback();
				});
			zoomOutSprite.addEventListener(MouseEvent.MOUSE_OVER,function(e:MouseEvent):void{
				tooltip.x = e.currentTarget["x"] + e.localX + 10;
				tooltip.y = e.currentTarget["y"] + e.localY + 10;
				displayHint("缩小一级");
				onOver(e.currentTarget as Sprite,12,12);
			});
			zoomOutSprite.addEventListener(MouseEvent.MOUSE_OUT,function(e:MouseEvent):void{
				tooltip.visible = false;
				onOut(e.currentTarget as Sprite,12,12);
			});
			this.addChild(zoomOutSprite);
			
			if(enableSliderSegment)
			{
				var sprite:Sprite = new Sprite();
				sprite.x=7;
				sprite.y=h;
				sprite.graphics.lineStyle(1, Color.WHITE, Alpha.UNSEEN, false, "normal", "square", "miter");
				sprite.graphics.beginFill(Color.BLUE, Alpha.PERCENT_40);
				sprite.graphics.drawRect(0, 0, 4, 5);
				sprite.graphics.endFill();
				this.addChild(sprite);
			}
			
		}
		protected function createScrollTrack(beginLevel:int,endLevel:int,sliderCallback:Function,top:int):void
		{
			if(scrollTrack == null)
			{
				scrollTrack = new ScrollTrack(beginLevel,endLevel,sliderCallback);
				this.addChildAt(scrollTrack,0);
				scrollTrack.y=top;
			}
		}
		private function onOver(btnSprite:Sprite,width:int,height:int):void{
			btnSprite.graphics.clear();
			btnSprite.graphics.lineStyle(1, Color.WHITE, Alpha.UNSEEN, false, "normal", "square", "miter");
			btnSprite.graphics.beginFill(Color.BLUE, Alpha.PERCENT_20);
			btnSprite.graphics.drawRect(0, 0, width, height);
			btnSprite.graphics.endFill();
		}
		private function onOut(btnSprite:Sprite,width:int,height:int):void{
			btnSprite.graphics.clear();
			btnSprite.graphics.lineStyle(1, Color.WHITE, Alpha.UNSEEN, false, "normal", "square", "miter");
			btnSprite.graphics.beginFill(Color.WHITE, Alpha.UNSEEN);
			btnSprite.graphics.drawRect(0, 0, width, height);
			btnSprite.graphics.endFill();
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