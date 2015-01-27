// ActionScript file
package myEvent
{
	import flash.events.Event;
	
	public class myMinEvent extends Event
	{
		
		public static const MIN:String = "min";
		public var detail:int;
		
		public function myMinEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false ,detail:int = -2)
		{
			super(type, bubbles, cancelable);
			this.detail = detail;
		}
		
		override public function clone():Event
		{
			return new myMinEvent(type, bubbles, cancelable, detail);
		}
	}
}