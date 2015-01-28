package components.contour
{
	import Mapgis7.WebService.BasLib.Rect;

	/**
	 * 平面等值线追踪参数，不能为空，为ContourParam类型对象JSON序列化后的字符串
	 * @author liuruoli
	 */
	public class ContourParam
	{
		/**
		 * 是否进行光滑线处理；如果为true则配合SmoothGrade使用
		 */
		public var IsSmoothLine:Boolean=false;
		/**
		 * 线光滑程度。 0/1/2分别代表“低/中/高”，仅在IsSmoothLine为true时生效
		 */
		public var SmoothGrade:int=1;
		/**
		 * 是否生成区
		 */
		public var IsMakeReg:Boolean=false;
		/**
		 * 是否生成注记
		 */
		public var IsMakeNote:Boolean=false;
		/**
		 * 是否输出示坡线
		 */
		public var IsMakeSLin:Boolean=false;
		/**
		 * 生成的地图范围的设置方法。0/1/2/3分表表示“自动检测设置/原始数据范围/数据投影变换/用户自定义”
		 */
		public var MapWay:int=1;
		/**
		 * 制图宽度，仅在MapWay=3的情况下有效
		 */
		public var FrameWidth:Number=1.0;
		/**
		 * 制图高度，仅在MapWay=3的情况下有效
		 */
		public var FrameHeight:Number=1.0;
		/**
		 * 是否绘制色阶。如果绘制，则必须同时指定生成线、区、注记层，任何一个图层都不能忽略生成，才可见色阶输出效果
		 */
		public var IsDrawColorScl:Boolean=false;
		/**
		 * 线图层是否保存边界
		 */
		public var IsSaveEdge:Boolean=false;
		/**
		 * 注记生成参数，如果NULL则取默认值。只有在IsMakeNote为true时该参数才能发挥作用。
		 */
		public var NoteParam:ContourNoteParam=new ContourNoteParam();
		/**
		 * 示坡线参数，如果为NULL则取默认值。只有在IsMakeSLin为true时该参数参能发挥作用。
		 */
		public var SlopLineParam:SlopLineParams=new SlopLineParams();
		/**
		 * 等值线层参数，不能为NULL。
		 */
		public var ZValues:Array=new Array();
		
		/**
		 *平面等值线追踪参数，不能为空，为ContourParam类型对象JSON序列化后的字符串
		 */
		public function ContourParam()
		{
			
		}
	}	
}