package components {
	import mx.core.UIComponent;

	public class Link extends UIComponent {
		
		public var fromNode : Node;
		public var toNode : Node;
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void {
			graphics.clear();
			graphics.lineStyle(4,0x0000ff,.5);
			graphics.moveTo(fromNode.x+fromNode.width/2,fromNode.y+fromNode.height/2);
			graphics.lineTo(toNode.x+toNode.width/2,toNode.y+toNode.height/2);	
		}
	}
}