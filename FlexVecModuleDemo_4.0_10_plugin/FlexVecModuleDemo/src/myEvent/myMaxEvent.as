// ActionScript file
package myEvent
{
	import flash.events.Event;
	
	public class myMaxEvent extends Event
	{
		public static const MAX:String = "max";
		public var detail:int;
		
		
		public function myMaxEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false ,detail:int = -3)
		{
			super(type, bubbles, cancelable);
			this.detail = detail;
		}
		
		
		override public function clone():Event
		{
			return new myMaxEvent(type, bubbles, cancelable, detail);
		}
		
		
		
	}
}