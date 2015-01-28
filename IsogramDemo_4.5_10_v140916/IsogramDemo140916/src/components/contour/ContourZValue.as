package components.contour
{
	import Mapgis7.WebService.BasLib.CLineInfo;
	import Mapgis7.WebService.BasLib.CRegionInfo;

	/**
	 * 等值线层参数类，用来描述每一层的信息。
	 * @author liuruoli
	 */
	public class ContourZValue
	{
		/**
		 * 等值线层值，不能为NULL
		 */
		public var ZValue:Number=1.0;
		/**
		 * 等值线参数，为空则取默认值。
		 */
		public var LineInfo:CLineInfo=new CLineInfo();
		/**
		 * 生成区参数，为空则取默认值。
		 */
		public var RegInfo:CRegionInfo=new CRegionInfo();
		/**
		 * 该层是否绘制注记
		 */
		public var IsOutputNote:Boolean=false;
		
		/**
		 * 等值线层参数类，用来描述每一层的信息。
		 * @author liuruoli
		 */
		public function ContourZValue()
		{
			
		}
	}	
}