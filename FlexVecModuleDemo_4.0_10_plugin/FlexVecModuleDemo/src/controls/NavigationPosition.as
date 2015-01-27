package controls
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.AntiAliasType;
	import flash.text.StyleSheet;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	import mx.controls.Alert;
	import mx.core.BitmapAsset;
	
	import utls.Alpha;
	import utls.Color;
	
	public class NavigationPosition extends Sprite
	{
		private static const DOWN_RECT:Rectangle=new Rectangle(-8, 8, 16, 16);		
		private static const RIGHT_RECT:Rectangle=new Rectangle(8, -8, 16, 16);		
		private static const UP_RECT:Rectangle=new Rectangle(-8, -24, 16, 16);		
		private static const CENTER_RECT:Rectangle=new Rectangle(-8, -8, 16, 16);				
		private static const LEFT_RECT:Rectangle=new Rectangle(-24, -8, 16, 16);
		private static const ICON_CENTER:Point=new Point(26, 26);
 		
		[Embed(source="NavigationPosition_PositionIcon.png")]		
		private var positionIcon:Class;	
		private var tooltip:TextField;
		private var upCallback:Function;
		private var downCallback:Function;
		private var leftCallback:Function;
		private var rightCallback:Function;
		private var centerCallback:Function;
		public function NavigationPosition(upCallback:Function,downCallback:Function,leftCallback:Function,rightCallback:Function,centerCallback:Function)
		{
			this.upCallback = upCallback;
			this.downCallback = downCallback;
			this.leftCallback = leftCallback;
			this.rightCallback = rightCallback;
			this.centerCallback = centerCallback;
			this.addEventListener(Event.ADDED,onAdded);
		}
		
		protected function createButtons():void
		{
			var img:BitmapAsset = BitmapAsset(new positionIcon());

			this.addChildAt(img,0);
			var btnSprite:Sprite = this.createControlButton(UP_RECT);
			if(upCallback!=null)
				btnSprite.addEventListener(MouseEvent.MOUSE_DOWN,function(e:MouseEvent):void{upCallback();});
			btnSprite.addEventListener(MouseEvent.MOUSE_OVER,function(e:MouseEvent):void{
				tooltip.x = e.currentTarget["x"] + e.localX + 20;
				tooltip.y = e.currentTarget["y"] + e.localY + 20;
				displayHint("向上平移");
				onOver(e.currentTarget as Sprite,UP_RECT);
			});
			btnSprite.addEventListener(MouseEvent.MOUSE_OUT,function(e:MouseEvent):void{
				tooltip.visible = false;
				onOut(e.currentTarget as Sprite,UP_RECT);
			});
			
			btnSprite = this.createControlButton(DOWN_RECT);
			if(downCallback!=null)
				btnSprite.addEventListener(MouseEvent.MOUSE_DOWN,function(e:MouseEvent):void{downCallback();});
			btnSprite.addEventListener(MouseEvent.MOUSE_OVER,function(e:MouseEvent):void{
				tooltip.x = e.currentTarget["x"] + e.localX + 20;
				tooltip.y = e.currentTarget["y"] + e.localY + 20;
				displayHint("向下平移");
				onOver(e.currentTarget as Sprite,DOWN_RECT);
			});
			btnSprite.addEventListener(MouseEvent.MOUSE_OUT,function(e:MouseEvent):void{
				tooltip.visible = false;
				onOut(e.currentTarget as Sprite,DOWN_RECT);
			});
			
			btnSprite = this.createControlButton(RIGHT_RECT);
			if(rightCallback!=null)
				btnSprite.addEventListener(MouseEvent.MOUSE_DOWN,function(e:MouseEvent):void{rightCallback();});
			btnSprite.addEventListener(MouseEvent.MOUSE_OVER,function(e:MouseEvent):void{
				tooltip.x = e.currentTarget["x"] + e.localX + 20;
				tooltip.y = e.currentTarget["y"] + e.localY + 20;
				displayHint("向右平移");
				onOver(e.currentTarget as Sprite,RIGHT_RECT);
			});
			btnSprite.addEventListener(MouseEvent.MOUSE_OUT,function(e:MouseEvent):void{
				tooltip.visible = false;
				onOut(e.currentTarget as Sprite ,RIGHT_RECT);
			});
			
			btnSprite = this.createControlButton(LEFT_RECT);
			if(leftCallback!=null)
				btnSprite.addEventListener(MouseEvent.MOUSE_DOWN,function(e:MouseEvent):void{leftCallback();});
			btnSprite.addEventListener(MouseEvent.MOUSE_OVER,function(e:MouseEvent):void{
				tooltip.x = e.currentTarget["x"] + e.localX + 20;
				tooltip.y = e.currentTarget["y"] + e.localY + 20;
				displayHint("向左平移");
				onOver(e.currentTarget as Sprite,LEFT_RECT);
			});
			btnSprite.addEventListener(MouseEvent.MOUSE_OUT,function(e:MouseEvent):void{
				tooltip.visible = false;
				onOut(e.currentTarget as Sprite,LEFT_RECT);
			});
			
			btnSprite = this.createControlButton(CENTER_RECT);
			if(centerCallback!=null)
				btnSprite.addEventListener(MouseEvent.MOUSE_DOWN,function(e:MouseEvent):void{centerCallback();});
			btnSprite.addEventListener(MouseEvent.MOUSE_OVER,function(e:MouseEvent):void{
				tooltip.x = e.currentTarget["x"] + e.localX + 20;
				tooltip.y = e.currentTarget["y"] + e.localY + 20;
				displayHint("拖动地图");
				onOver(e.currentTarget as Sprite,CENTER_RECT);
			});
			btnSprite.addEventListener(MouseEvent.MOUSE_OUT,function(e:MouseEvent):void{
				tooltip.visible = false;
				onOut(e.currentTarget as Sprite,CENTER_RECT);
			});
		}
		
		private function onOver(btnSprite:Sprite,arg2:Rectangle):void{
			btnSprite.graphics.clear();
			btnSprite.graphics.lineStyle(1, Color.WHITE, Alpha.UNSEEN, false, "normal", "square", "miter");
			btnSprite.graphics.beginFill(Color.BLUE, Alpha.PERCENT_20);
			btnSprite.graphics.drawRect(arg2.left, arg2.top, arg2.width, arg2.height);
			btnSprite.graphics.endFill();
		}
		private function onOut(btnSprite:Sprite,arg2:Rectangle):void{
			btnSprite.graphics.clear();
			btnSprite.graphics.lineStyle(1, Color.WHITE, Alpha.UNSEEN, false, "normal", "square", "miter");
			btnSprite.graphics.beginFill(Color.WHITE, Alpha.UNSEEN);
			btnSprite.graphics.drawRect(arg2.left, arg2.top, arg2.width, arg2.height);
			btnSprite.graphics.endFill();
		}
		
		private function createControlButton(arg2:Rectangle):Sprite
		{
			var btnSprite:Sprite = new Sprite();
			btnSprite.x = ICON_CENTER.x;
			btnSprite.y = ICON_CENTER.y;
			onOut(btnSprite,arg2);
			this.addChild(btnSprite);		
			
			return btnSprite;
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
			createButtons();
		}
	}
}