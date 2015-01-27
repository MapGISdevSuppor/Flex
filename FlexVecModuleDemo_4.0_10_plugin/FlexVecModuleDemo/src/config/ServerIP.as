package config
{
	import mx.managers.BrowserManager;
	import mx.managers.IBrowserManager;
	import mx.rpc.events.FaultEvent;
	import mx.utils.URLUtil;
	
	public class ServerIP
	{
		import mx.rpc.http.HTTPService;
		import utilEvent.ReadURLEvent;
		import flash.events.Event;
		import flash.net.URLLoader;
		import flash.net.URLRequest;
		import mx.rpc.events.ResultEvent;
		import mx.rpc.events.FaultEvent;
		import mx.controls.Alert;
		public var HDFName:String="";
		public var MapDocName:String="";
		public var XMinMap:Number=0;
		public var XMaxMap:Number=0;
		public var YMinMap:Number=0;
		public var YMaxMap:Number=0;
		
		public var SXMinMap:Number=0;
		public var SXMaxMap:Number=0;
		public var SYMinMap:Number=0;
		public var SYMaxMap:Number=0;
		
		public var LevelNum:Number=0;
		public var InitShowLevel:Number=0;
		public var RestoreCenterX:Number=0;
		public var RestoreCenterY:Number=0;
		
		public var vectorURL:String="";
		
		private var bm:IBrowserManager;
		private var serverIP:String="127.0.0.1";
		private var serverPort:String="6163";
		private var serverLastURL:String="/igs/rest/ims/relayhandler";
		
		private var app:Object;
		public function mapConfig1(application:Object):void
		{  
			
			bm=BrowserManager.getInstance();
			bm.init();
			var url:String = bm.url;
			if(URLUtil.getServerName(url)!=""&&URLUtil.getServerName(url)!=null){
				serverIP = URLUtil.getServerName(url);
			}
			vectorURL="http://"+serverIP+":"+serverPort+serverLastURL;
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
			this.MapDocName=event.result.MapURLConfig.config.MapDocName;
			this.XMinMap=parseFloat(event.result.MapURLConfig.config.XMinMap);
			this.XMaxMap=parseFloat(event.result.MapURLConfig.config.XMaxMap);
			this.YMinMap=parseFloat(event.result.MapURLConfig.config.YMinMap);
			this.YMaxMap=parseFloat(event.result.MapURLConfig.config.YMaxMap);
			this.SXMinMap=parseFloat(event.result.MapURLConfig.config.SXMinMap)
			this.SXMaxMap=parseFloat(event.result.MapURLConfig.config.SXMaxMap);
			this.SYMinMap=parseFloat(event.result.MapURLConfig.config.SYMinMap);
			this.SYMaxMap=parseFloat(event.result.MapURLConfig.config.SYMaxMap);	
			this.LevelNum=parseInt(event.result.MapURLConfig.config.LevelNum);
			this.InitShowLevel=parseInt(event.result.MapURLConfig.config.InitShowLevel);
			this.RestoreCenterX=parseFloat(event.result.MapURLConfig.config.RestoreCenterX);
			this.RestoreCenterY=parseFloat(event.result.MapURLConfig.config.RestoreCenterY);
			this.app.dispatchEvent(new ReadURLEvent(ReadURLEvent.READ_COMPLETE));
		}
	}
}