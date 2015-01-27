package controls
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.core.UIComponent;
	import mx.managers.CursorManagerPriority;
	
	import spark.components.Group;
	
	import utls.Alpha;
	
	public class NavigationControl extends UIComponent
	{
		//[Bindable]  		
		[Embed(source="images/handPointerUp.png")]   
		private var handIcon:Class;  
		
		private var navigationPosition:NavigationPosition;
		private var navigationZoom:NavigationZoom;
		public function NavigationControl(navigationPosition:NavigationPosition = null,navigationZoom:NavigationZoom = null)
		{
			this.navigationPosition=navigationPosition;
			this.navigationZoom=navigationZoom;
			this.addEventListener(Event.ADDED,onAdded);	
		}
		
		private function onAdded(e:Event):void
		{
			this.removeEventListener(Event.ADDED,onAdded);
//			this.alpha = Alpha.PERCENT_70;
			var h:int = 0;
			if(navigationPosition!=null)
			{
				this.addChild(navigationPosition);
				h = navigationPosition.height;
			}
			if(navigationZoom!=null)
			{
				this.addChildAt(navigationZoom,0);
				navigationZoom.y=h+6;
				navigationZoom.x=17;
			}
			this.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			this.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
		}
		
		private function onMouseOver(e:MouseEvent):void
		{
			cursorManager.removeCursor(cursorManager.currentCursorID);
			cursorManager.setCursor(handIcon,CursorManagerPriority.HIGH,-6,-1); 
		}
		private function onMouseOut(e:MouseEvent):void
		{
			cursorManager.removeCursor(cursorManager.currentCursorID);
		}
	}
}