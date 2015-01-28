package components.contour
{
	import Mapgis7.WebService.BasLib.Rect;

	/**
	 * 离散数据网格化参数类
	 * @author liuruoli
	 */
	public class MeshingParam
	{
		/**
		 * 点简单要素类URL
		 */
		public var SfClsURL:String;
		/**
		 * Z值所在的字段名称
		 */
		public var FieldName:String;
		/**
		 * 生成的影像X方向网格数。只输出X方向网格数，计算时Y方向网格密度会自动与X方向保持一致。
		 */
		public var XCellNum:int=200;
		/**
		 * 生成的栅格数据集逻辑范围，如果为NULL则使用点简单要素类的逻辑范围。
		 */
		public var Bound:Rect;
		
		/**
		 *  离散数据网格化参数类
		 */
		public function MeshingParam()
		{
			
		}
	}	
}