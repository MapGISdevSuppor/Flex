package MyParam
{
	import Mapgis7.WebService.BasLib.*;
	public class OverlayBySelectParam
	{
		// 摘要:
		//     图层类型
		public var ClsType:String;
		//
		// 摘要:
		//     要素类1所在的GDB信息
		public var GdbInfo1:CGdbInfo;
		//
		// 摘要:
		//     要素类2所在GDB信息
		public var GdbInfo2:CGdbInfo;
		//
		// 摘要:
		//     是否重算面积周长
		public var IsReCalculate:Boolean;
		//
		// 摘要:
		//     要素类1的名称
		public var LayerName1:String;
		//
		// 摘要:
		//     要素类2名称
		public var LayerName2:String;
		//
		// 摘要:
		//     叠加类型
		public var OverlayType:int;
		//
		// 摘要:
		//     容差半径
		public var Radius:Number;
		//
		// 摘要:
		//     对要素类1查询的参数
		public var SelectParam1:CWebSelectParam;
		//
		// 摘要:
		//     对图层2查询的参数
		public var SelectParam2:CWebSelectParam;
		public function OverlayBySelectParam()
		{
			
		}
	}
}