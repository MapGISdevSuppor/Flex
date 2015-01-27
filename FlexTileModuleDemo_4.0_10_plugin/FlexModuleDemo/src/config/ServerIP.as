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
		public var HDFName:String="";
		public var XMinMap:Number=0;
		public var XMaxMap:Number=0;
		public var YMinMap:Number=0;
		public var YMaxMap:Number=0;
		public var LevelNum:Number=0;
		public var InitShowLevel:Number=0;
		public var RestoreCenterX:Number=0;
		public var RestoreCenterY:Number=0;
		
		private var app:Object;
		public function mapConfig1(application:Object):void
		{  
			var service:HTTPService = new HTTPService();   
			service.url = "xml/config.xml";   
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
			this.HDFName=event.result.MapURLConfig.config.HDFName;
			this.XMinMap=parseFloat(event.result.MapURLConfig.config.XMinMap);
			this.XMaxMap=parseFloat(event.result.MapURLConfig.config.XMaxMap);
			this.YMinMap=parseFloat(event.result.MapURLConfig.config.YMinMap);
			this.YMaxMap=parseFloat(event.result.MapURLConfig.config.YMaxMap);
			this.LevelNum=parseInt(event.result.MapURLConfig.config.LevelNum);
			this.InitShowLevel=parseInt(event.result.MapURLConfig.config.InitShowLevel);
			this.RestoreCenterX=parseFloat(event.result.MapURLConfig.config.RestoreCenterX);
			this.RestoreCenterY=parseFloat(event.result.MapURLConfig.config.RestoreCenterY);
			this.app.dispatchEvent(new ReadURLEvent(ReadURLEvent.READ_COMPLETE));
		}
	}
}