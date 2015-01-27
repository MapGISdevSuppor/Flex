package myControls
{
	import flash.geom.Point;
	
	import mx.core.UIComponent;
	import mx.core.UIComponentGlobals;
	
	import zdims.map.Tile;
	import zdims.map.TileLayerBase;
	import zdims.othermap.GoogleLayerType;
	import zdims.util.RectBound;
	
	/**
	 * 谷歌瓦片图层 
	 * @author zhaoqianjun
	 * 
	 */	
	[IconFile("images/GoogleMap.gif")]
	public class MyGoogleTile extends TileLayerBase
	{
		///**
		//*google 取图的URL 
		//*/		
		//protected var googleDataUrl:String="http://mt1.google.com/vt/lyrs=m@132&hl=zh-CN";
		/**
		 * Google图层的类型: 基本地图、地形图、影像图、道路网和地名数据  
		 * 默认情况为基本地图
		 */				
		protected var glLayerType:String = GoogleLayerType.BasicMap;
		//		/**
		//		 * Google数据服务器地址,基本地图可以设为"http://mt0.google.com/vt/lyrs=m@132&hl=zh-CN"、"http://mt1.google.com/vt/lyrs=m@132&hl=zh-CN"、
		//		 *  "http://mt2.google.com/vt/lyrs=m@132&hl=zh-CN"、"http://mt3.google.com/vt/lyrs=m@132&hl=zh-CN"
		//		 *  影像数据 http://mt2.google.cn/vt/lyrs=s@76
		//		 *  道路网和地名数据  http://mt1.google.cn/vt/imgtp=png32&lyrs=h@142
		//		 *  地形数据 http://mt1.google.com/vt/lyrs=t@126,r@142
		//		 *
		//		 */
		/**
		 * Google数据服务器地址 
		 */		
		protected var googleDataSvr:Array = [];// new  Array();
		/**
		 * Google数据服务器地址(包含 基本地图、地形数据、影像数据、道路网和地名数据)
		 * @return 
		 * 
		 */		 
		public function get googleDataSvrArr():Array
		{
			return googleDataSvr;
		}
		/**
		 * Google数据服务器地址(包含 基本地图、地形数据、影像数据、道路网和地名数据)  
		 * @param value
		 * 
		 */		
		public function set googleDataSvrArr(value:Array):void
		{
			googleDataSvr=value;
		}
		/**
		 * MapGIS 瓦片数据第0级在Google地图的级数
		 */
		[Inspectable(category="MapGisIMS")]
		public var startLevel:int = 0;//11;
		/**
		 * MapGIS 瓦片数据第0级在Google地图的行号
		 */
		[Inspectable(category="MapGisIMS")]
		public var originalRow:int = 0;//841;
		/**
		 * MapGIS 瓦片数据第0级在google地图的列号
		 */
		[Inspectable(category="MapGisIMS")]
		public var originalColumn:int =0;//1674;
		/**
		 * 获取google地图的类型
		 * @return 
		 */	
		[Inspectable(category="MapGisIMS")]	
		public function get googleLayerType():String
		{
			return glLayerType;
		}
		/**
		 * 获取当前图层名称 
		 * 
		 */		
		public function get googleLayerName():String{
			switch(glLayerType)
			{
				case GoogleLayerType.BasicMap: //基本地图
					return "谷歌基本地图";
				case GoogleLayerType.TerrainMap://地形图
					return "谷歌地形图";
				case GoogleLayerType.RasterMap://遥感图 
					return "谷歌遥感图 ";
				case GoogleLayerType.RoadMap://道路及地名数据
					return "谷歌道路及地名数据";
				default:
					return "谷歌基本地图";
			}
		}
		/**
		 * 设置googel地图的类型
		 * @return 
		 */	
		[Inspectable(category="MapGisIMS", defaultValue="basicmap",enumeration="basicmap,terrainmap,rastermap,roadmap",format="String")]
		public function set googleLayerType(value:String):void
		{
			if("basicmapterrainmaprastermaproadmap".indexOf(value)>-1)
			{
				glLayerType=value;
				switch(value.toLowerCase())
				{
					case GoogleLayerType.BasicMap: //基本地图
						_serverAddress = googleDataSvr[0]
						break;
					case GoogleLayerType.TerrainMap://地形图
						_serverAddress = googleDataSvr[1]
						break;
					case GoogleLayerType.RasterMap://遥感图 
						_serverAddress = googleDataSvr[2]
						break;
					case GoogleLayerType.RoadMap://道路及地名数据
						_serverAddress = googleDataSvr[3]
						break;
					default:
						_serverAddress = googleDataSvr[0]
						break;
				}
			}
		}
		[Inspectable(category="MapGisIMS")]
		/**
		 * googel地图的地址,默认值为谷歌基础地图地址。（注意：该值一般是固定的，之需要设置 “googleLayerType”googel地图的类型既可以自动设置）
		 * @param value googel地图的地址
		 * 
		 */			
		public override function set serverAddress(value:String):void
		{
			_serverAddress=value;
		}
		[Inspectable(category="MapGisIMS")]
		/**
		 * googel地图的地址,默认值为谷歌基础地图地址。（注意：该值一般是固定的，之需要设置 “googleLayerType”googel地图的类型既可以自动设置） 
		 * @return googel地图的地址
		 * 
		 */			 
		public override function get serverAddress():String
		{
			return _serverAddress;
		}
		/**
		 * 谷歌瓦片图层构造函数 
		 * 
		 */		
		public function GoogleTileLayer()
		{
			_autoGetMapInfo=true;
			_serverAddress ="http://mt1.google.com/vt/lyrs=m@132&hl=zh-CN";
			if(UIComponentGlobals.designMode)
			{
				this.width=100;
				this.height=100;
			}
			else
			{
				//保存google地图的URL，依次为基本地图、地形图、遥感图、道路及地名数据
				googleDataSvr.push( "http://mt1.google.cn/vt/lyrs=m@162050476&hl=zh-CN&gl=cn",//"http://mt1.google.com/vt/lyrs=m@132&hl=zh-CN",
					"http://mt3.google.cn/vt/lyrs=t@128,r@170000000&hl=zh-CN&gl=cn",//"http://mt3.google.com/vt/lyrs=t@128,r@170000000",//"http://mt0.google.com/vt/lyrs=t@128,r@170000000",//"http://mt2.google.com/vt/lyrs=t@128,r@170000000",
					"http://mt3.google.cn/vt/lyrs=s@101&hl=zh-CN&gl=cn",//"http://mt1.google.cn/vt/lyrs=s@94&hl=zh-CN&gl=cn",//"http://mt2.google.cn/vt/lyrs=s@84",/*"http://mt2.google.cn/vt/lyrs=s@76",*/
					"http://mt1.google.cn/vt/imgtp=png32&lyrs=h@162000000&hl=zh-CN&gl=cn");//"http://mt1.google.cn/vt/imgtp=png32&lyrs=h@142");
			}
		}
		/**
		 * 拷贝一个本图层的副本
		 * @param enableCopySysUIData 为“true”时拷贝图层数据，为“false”不拷贝
		 * @param enableCopyUserCfgData 为“true”时拷贝图层配置信息，为“false”不拷贝
		 * @return 返回该该图层副本对象
		 * 
		 */		
		public override function clone(enableCopySysUIData:Boolean=true,enableCopyUserCfgData:Boolean=false):UIComponent
		{
			var tLayer:MyGoogleTile=new MyGoogleTile();
			if(enableCopyUserCfgData)
			{				
				tLayer.startLevel=this.startLevel;
				tLayer.originalRow=this.originalRow;
				tLayer.originalColumn=this.originalColumn;
				tLayer.googleLayerType=this.googleLayerType;
				
				tLayer.mapViewBound=this.mapViewBound;
				tLayer.viewBeginLevel=this.viewBeginLevel;
				tLayer.viewEndLevel=this.viewEndLevel;
				tLayer.serverAddress=this.serverAddress;
				tLayer._tileSize=this._tileSize;
			}
			if(enableCopySysUIData)
			{	
				tLayer._tileContainer.fillTiles(this._curRowTileCount, this._curCellTileCount, this._curMapLevel, this._tileContainer.getTile(0,0).rowNo, this._tileContainer.getTile(0,0).cellNo);
			}			
			return tLayer;
		}
		/**
		 * 初始化地图图层（该方法一般内部自动调用，一般不对外使用 ） 
		 * 
		 */		
		public override function init():void
		{
			if(map&&(_autoGetMapInfo||!map.isLawfulMapBound))
			{
				var rect:RectBound=getTileBounds(originalColumn,originalRow,startLevel,_tileSize);
				map.xMinMap=rect.xMin;
				map.yMinMap=rect.yMin;
				map.xMaxMap=rect.xMax;
				map.yMaxMap=rect.yMax;
				if (map.levelNum == 0)
					map.levelNum = 20;
				map.resetParameter();
				map.autoGetMapInfoCallback(this);
			}
			else
				restore();
		}
		/**
		 * 获取一个谷歌瓦片图的下载地址
		 * @param tile 瓦片对象
		 * @return 瓦片地址（如果不用填充图请返回“null”或者"",如果该瓦片的行列号是不合法的请返回“blankImageSrc”中的默认图）
		 * 
		 */		
		public override function getTileImgUrl(tile:Tile):String
		{
			if (!this._display || !this._enableFillImg)
			{
				return null;
			}
			//			if ((tile.rowNo < 0) || (tile.rowNo >= this._rowTileCount) || (tile.cellNo < 0) || (tile.cellNo >= this._rowTileCount))
			//			{
			//				return this.blankImageSrc;
			//			}
			return calculateGoogleTitleUrl(tile.rowNo,tile.cellNo,tile.level);
		}
		/**
		 * 计算谷歌瓦片图的url地址
		 * @param svrAddress url地址
		 * @param row 行哈
		 * @param col 列号
		 * @param lvl 级数
		 * @return 瓦片图的完整url地址
		 * 
		 */		
		protected function calculateGoogleTitleUrl(row:int,col:int,lvl:int):String
		{
			//计算google数据的行列号
			if (lvl == 0)
			{
				lvl = startLevel;
				row =originalRow - row;
				col = originalColumn + col;
			}
			else
			{
				row = originalRow * Math.pow(2, lvl) + (Math.pow(2, lvl) - 1 - row); //行号
				col =originalColumn * Math.pow(2, lvl) + col;//列号
				lvl =  startLevel +lvl;//级数
			}
			var rowNum:int = Math.pow(2,lvl);
			if(lvl>this.viewEndLevel||lvl<this.viewBeginLevel) 
			{
				return this._blankImageSrc;
			}
			else if((row<0)||(row>=rowNum)||(col<0)||(col>=rowNum))
			{
				return this._blankImageSrc;
			}
			else
			{
				return _serverAddress+"&x=" + col.toString() + "&y=" + row.toString() + "&z=" + lvl.toString() + "&s=Galileo";
			}
		}
		private static var perimeter:Number = 40075016.685578488;//2 * Math.PI * 6378137;
		private static var originShift:Number = 20037508.342789244;//2 * Math.PI * 6378137 / 2.0;
		/**
		 * 获取指定级数下一个像素代表的实际长度 
		 * @param level 级数
		 * @param tileSize 瓦片尺寸
		 * @return 一个像素代表的实际长度 
		 * 
		 */		
		public static function getResolution(level:int,tileSize:int=256):Number
		{
			var initialResolution:Number = 2 * Math.PI * 6378137 / tileSize;
			return initialResolution / Math.pow(2,level);
		}
		/**
		 * 计算指定级数下一个长度单位代表的像素个数 
		 * @param level 级数
		 * @param tileSize 瓦片尺寸
		 * @return 一个像素代表的实际长度  
		 * 
		 */		
		public static function getScale(level:int,tileSize:int=256):Number
		{
			return Math.pow(2, level) * tileSize / perimeter;
		}
		/**
		 * 根据行列号获取该瓦片Web墨卡托坐标系的范围 
		 * @param col 列号
		 * @param row 行号
		 * @param level 级数
		 * @param tileSize 瓦片尺寸
		 * @return 范围
		 * 
		 */		
		public static function getTileBounds(col:int,row:int,level:int,tileSize:int=256):RectBound
		{
			row=Math.pow(2,level)-1-row;
			var minPnt:Point = pixelsToMercator(col * tileSize, row * tileSize,level,tileSize);
			var maxPnt:Point = pixelsToMercator((col+1) * tileSize, (row+1) * tileSize,level,tileSize);
			return new RectBound(minPnt.x,minPnt.y,maxPnt.x,maxPnt.y);
		}
		/**
		 * 根据行列号获取该瓦片经纬度坐标系的范围 
		 * @param col 列号
		 * @param row 行号
		 * @param level 级数
		 * @param tileSize 瓦片尺寸
		 * @return 范围
		 * 
		 */			
		public static function getTileLatLonBounds(col:int,row:int,level:int,tileSize:int=256):RectBound
		{
			row=Math.pow(2,level)-1-row;
			var bounds:RectBound = getTileBounds(col,row,level,tileSize);
			var minPnt:Point = mercatorToLatLon(bounds.xMin,bounds.yMin);
			var maxPnt:Point = mercatorToLatLon(bounds.xMax,bounds.yMax);
			return new RectBound(minPnt.x,minPnt.y,maxPnt.x,maxPnt.y);
		}
		/**
		 * 获取经纬度坐标所在瓦片行列值   
		 * @param lon 经度
		 * @param lat 纬度
		 * @param level 级数
		 * @param tileSize 瓦片尺寸
		 * @return 转换后行列值
		 * 
		 */		
		public static function lonLatToTile(lon:Number,lat:Number,level:int,tileSize:int=256):Point	
		{
			var pnt:Point = lonLatToMercator(lon,lat);
			return mercatorToTile(pnt.x,pnt.y,level,tileSize);
		}
		/**
		 * 获取Web墨卡托坐标所在瓦片行列值   
		 * @param mx x轴坐标
		 * @param my y轴坐标
		 * @param level 级数
		 * @param tileSize 瓦片尺寸
		 * @return 转换后行列值
		 * 
		 */		
		public static function mercatorToTile(mx:Number,my:Number,level:int,tileSize:int=256):Point	
		{
			var pnt:Point=mercatorToPixels(mx,my,level,tileSize);
			return pixelsToTile(pnt.x,pnt.y,level,tileSize);			
		}
		/**
		 * 获取地图像素坐标所在瓦片行列值  
		 * @param px x轴坐标
		 * @param py y轴坐标
		 * @param level 级数
		 * @param tileSize 瓦片尺寸
		 * @return 转换后行列值
		 * 
		 */		
		public static function pixelsToTile(px:Number,py:Number,level:int,tileSize:int=256):Point
		{
			//			var row:int=Math.ceil(py / tileSize) - 1;
			//			row=Math.pow(2,level)-1-row;
			return new Point(Math.ceil(px / tileSize) - 1,Math.pow(2,level) - Math.ceil(py / tileSize));
		}
		/**
		 * 指定级数下地图像素坐标转Web墨卡托坐标 
		 * @param px x轴坐标
		 * @param py y轴坐标
		 * @param level 级数
		 * @param tileSize 瓦片尺寸
		 * @return 转换后坐标
		 * 
		 */		
		public static function pixelsToMercator(px:Number,py:Number,level:int,tileSize:int=256):Point
		{
			var res:Number = getResolution(level,tileSize);
			return new Point( px * res - originShift, py * res - originShift);
		}
		/**
		 * Web墨卡托坐标转指定级数下地图像素坐标 
		 * @param mx x轴坐标
		 * @param my x轴坐标
		 * @param level 级数
		 * @param tileSize 瓦片尺寸
		 * @return 转换后坐标
		 * 
		 */		
		public static function mercatorToPixels(mx:Number,my:Number,level:int,tileSize:int=256):Point
		{
			var res:Number = getResolution(level,tileSize);
			return new Point(Math.round((mx + originShift) / res) ,Math.round((my + originShift) / res));
		}
		/**
		 * 经纬度坐标转Web墨卡托坐标 
		 * @param lon 经度
		 * @param lat 纬度
		 * @return 转换后坐标
		 * 
		 */		
		public static function lonLatToMercator(lon:Number,lat:Number):Point	
		{
			var x:Number = lon * originShift / 180.0;
			var y:Number = Math.log(Math.tan((90 + lat) * Math.PI / 360.0)) / (Math.PI / 180.0);
			y = y * originShift / 180.0;
			return new Point(x,y) ;
		}
		/**
		 * Web墨卡托坐标转经纬度坐标  
		 * @param mx x轴坐标
		 * @param my y轴坐标
		 * @return  转换后坐标
		 * 
		 */		
		public static function mercatorToLatLon(mx:Number,my:Number):Point	
		{
			var lon:Number = (mx / originShift) * 180.0;
			var lat:Number = (my / originShift) * 180.0;
			lat = 180 / Math.PI * (2 * Math.atan(Math.exp(lat * Math.PI / 180.0)) - Math.PI / 2.0);
			return new Point(lon,lat);
		}
	}
}