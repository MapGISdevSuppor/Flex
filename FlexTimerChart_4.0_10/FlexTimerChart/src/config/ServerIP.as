package config
{
	import mx.rpc.events.FaultEvent;
	
	public class ServerIP
	{
		import mx.rpc.http.HTTPService;
		import utilEvent.ReadURLEvent;
		import flash.events.Event;
		import flash.net.URLLoader;
		import flash.net.URLRequest;
		import mx.rpc.events.ResultEvent;
		import mx.rpc.events.FaultEvent;
		public var vectorURL:String="";
		public var TileURL:String="";
		private var app:Object;
		public function mapConfig1(application:Object):void
		{  
			var service:HTTPService = new HTTPService();   
			service.url = "../TimerChart/xml/config.xml";   
			service.send();
			service.addEventListener(ResultEvent.RESULT, resultHandler);  
			service.addEventListener(FaultEvent.FAULT,fail)
			this.app = application;
		}
		public function fail(event:FaultEvent):void
		{
			var obj:Object=event.fault.content;
		}
		private function resultHandler(event:ResultEvent):void
		{
			this.vectorURL=event.result.MapURLConfig.config.VectorUrl;
			this.TileURL=event.result.MapURLConfig.config.TileURL;
			this.app.dispatchEvent(new ReadURLEvent(ReadURLEvent.READ_COMPLETE));
		}
	}
}