package config
{
	import mx.controls.Alert;
	import mx.managers.BrowserManager;
	import mx.managers.IBrowserManager;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	import mx.utils.URLUtil;
	
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
		public var webUrl:String="";
		public var vecdocName="";
		/**
		 * 等值线分析结果数据库名称
		 */
		public var contourAnalyseGdbName:String="IMSWEBGISGDB";
		
		private var bm:IBrowserManager;
		private var serverIP:String="127.0.0.1";
		private var serverPort:String="6163";
		private var serverP:String="";
		private var serverurl:String="";
		private var serverLastURL:String="/igs/rest/ims/relayhandler";
		
		private var app:Object;
		public function mapConfig1(application:Object):void
		{
			bm=BrowserManager.getInstance();
			bm.init();
			var url:String=bm.url;
			if(URLUtil.getServerName(url)!=""&&URLUtil.getServerName(url)!=null){
				serverIP = URLUtil.getServerName(url);
				serverP=URLUtil.getPort(url).toString();//获取端口号
				trace(serverP);
			}
			this.vectorURL="http://"+serverIP+":"+serverPort+serverLastURL;
			this.tileURL="http://"+serverIP+":"+serverPort+serverLastURL;
			
			//纵生式开发，直接将应用发布到网站总目录下的请求地址
//			if(serverP!=null&&serverP!="")
//				this.webUrl="http://"+serverIP+":"+serverP+"/Service1.asmx";
//			else
//				this.webUrl="http://"+serverIP+"/Service1.asmx";
			
			
			var service:HTTPService=new HTTPService();
			
			service.url="xml/config.xml";
			service.send();
			service.addEventListener(ResultEvent.RESULT,onResult);
			service.addEventListener(FaultEvent.FAULT,onFault);
			this.app=application;
		}
		
		private function onResult(e:ResultEvent):void
		{
			this.terrainURL=e.result.MapURLConfig.config.TerrainUrl;
			this.basicURL=e.result.MapURLConfig.config.BasicUrl;
			this.roadURL=e.result.MapURLConfig.config.RoadUrl;
			this.rasterURL=e.result.MapURLConfig.config.RasterUrl;
			this.isoimgURL=e.result.MapURLConfig.config.isoimgUrl;
			this.vecdocName=e.result.MapURLConfig.config.VectMapdocName;
			this.contourAnalyseGdbName=e.result.MapURLConfig.config.GDBName;
			//传统开发，传统发布，将其发布到默认网站下时的地址（其中，介于localhost和Service1之间的为发布时网站的别名）
			this.webUrl=e.result.MapURLConfig.config.webURL;
			this.app.dispatchEvent(new ReadURLEvent(ReadURLEvent.READ_COMPLETE));
		}
		
		private function onFault(e:FaultEvent):void
		{
			var fault:Object=e.fault.content;
		}
	}
}