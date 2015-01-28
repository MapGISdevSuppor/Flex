package config
{
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	import utilEvent.ReadURLEvent;

	public class mapConfig
	{
		public var tileURL:String="";
		public var vectorURL:String="";
		public var terrainURL:String="";
		public var basicURL:String="";
		public var roadURL:String="";
		public var rasterURL:String="";
		public var isoimgURL:String="";
		
		private var app:Object;
		public function mapConfig1(application:Object):void
		{
			var service:HTTPService=new HTTPService();
			service.url="../bin-debug/xml/config.xml";
			service.send();
			service.addEventListener(ResultEvent.RESULT,onResult);
			service.addEventListener(FaultEvent.FAULT,onFault);
			this.app=application;
		}
		
		private function onResult(e:ResultEvent):void
		{
			this.vectorURL=e.result.MapURLConfig.config.VectorUrl;
			this.tileURL=e.result.MapURLConfig.config.tileUrl;
			this.terrainURL=e.result.MapURLConfig.config.TerrainUrl;
			this.basicURL=e.result.MapURLConfig.config.BasicUrl;
			this.roadURL=e.result.MapURLConfig.config.RoadUrl;
			this.rasterURL=e.result.MapURLConfig.config.RasterUrl;
			this.isoimgURL=e.result.MapURLConfig.config.isoimgUrl;
			this.app.dispatchEvent(new ReadURLEvent(ReadURLEvent.READ_COMPLETE));
		}
		
		private function onFault(e:FaultEvent):void
		{
			var fault:Object=e.fault.content;
		}
	}
}