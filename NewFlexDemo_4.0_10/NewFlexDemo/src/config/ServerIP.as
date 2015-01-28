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
		public var GPSURL:String="";
		public var TerrainURL:String="";
		public var RasterURL:String="";
		public var BasicURL:String="";
		
		private var app:Object;
		public function mapConfig1(application:Object):void
		{  
			var service:HTTPService = new HTTPService();   
			service.url = "../Flex4Demo/xml/config.xml";   
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
			this.GPSURL=event.result.MapURLConfig.config.GPSURL;
			this.TerrainURL=event.result.MapURLConfig.config.TerrainURL;
			this.RasterURL=event.result.MapURLConfig.config.RasterURL;
			this.BasicURL=event.result.MapURLConfig.config.BasicURL;
			
			this.app.dispatchEvent(new ReadURLEvent(ReadURLEvent.READ_COMPLETE));
		}
	}
}