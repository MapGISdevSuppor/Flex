package components {
	
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextLineMetrics;
	
	import mx.controls.Image;
	import mx.controls.Text;
	import mx.core.IMXMLObject;
	import mx.core.UIComponent;

	public class Node extends UIComponent {
		
		[Embed(source="../assets/node.PNG")]
		public static const nodeClass : Class;
		
		private var image : Image;
		private var text : Text;
		
		private var _nodeName : String;
		
		private var rollOver : Boolean;
		
		public function Node() {
			addEventListener(MouseEvent.ROLL_OVER,function(e : Event) : void {
				rollOver = true;
				invalidateDisplayList();
			});
			addEventListener(MouseEvent.ROLL_OUT,function(e : Event) : void {
				rollOver = false;
				invalidateDisplayList();
			});
		}
		
		override protected function createChildren():void {
			image = new Image();
			image.source = nodeClass;
			addChild(image);
			image.validateNow();
			// adding the label:
			text = new Text();
			//text.truncateToFit = true;
			text.selectable = true;
			addChild(text);
		}
		
		public function get nodeName() : String {
			return _nodeName;
		}
		
		public function set nodeName(nodeName : String) : void {
			_nodeName = nodeName;
			invalidateProperties();
		}
		
		override protected function commitProperties():void {
			super.commitProperties();
			text.text = _nodeName;
		}
		
		override protected function measure():void {
			super.measure();
//			text.text = _nodeName;
//			var metrics : TextLineMetrics = measureText(_nodeName);
//			text.width = metrics.width+10;
//			text.setActualSize(metrics.width+10,metrics.height+5);
//			var bitmapData : BitmapData = image.content["bitmapData"] as BitmapData;
//			measuredWidth = bitmapData.width;
//			measuredHeight = bitmapData.height;
//			setActualSize(measuredWidth,measuredHeight);
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void {
			super.updateDisplayList(unscaledWidth,unscaledHeight);
			graphics.clear();
			var bitmapData : BitmapData = image.content["bitmapData"] as BitmapData;
			graphics.beginBitmapFill(bitmapData);
			graphics.drawRect(0,0,bitmapData.width,bitmapData.height);
			graphics.endFill();
			graphics.beginFill(0xff0000,.3);
			graphics.drawRoundRect(-3,-3,bitmapData.width+6,bitmapData.height+6,10,10);
			graphics.drawRoundRect(0,0,bitmapData.width,bitmapData.height,10,10);
			graphics.endFill();
			// moving the label at the center:
			text.move(bitmapData.width/2-text.width/2,bitmapData.height/2-text.height/2);
			if(rollOver) {
				graphics.beginFill(0x0000ff,.2);
				graphics.drawRoundRect(-10,-10,bitmapData.width+20,bitmapData.height+20,10,10);
				graphics.drawRoundRect(-3,-3,bitmapData.width+6,bitmapData.height+6,10,10);
				graphics.endFill();
			} 
		}
	}
}