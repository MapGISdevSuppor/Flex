package components.contour
{
	/**
	 * 注记参数类
	 * @author liuruoli
	 */
	public class ContourNoteParam
	{
		/**
		 * 注记是否剪断线(true/false 剪断/不剪断)
		 */
		public var IsClipLine:Boolean=true;
		/**
		 * 是否输出轴向标尺
		 */
		public var isXYScaleOut:Boolean=false;
		/**
		 * 注记方向(1/2/3:斜坡上方/斜坡下方/图幅上方)
		 */
		public var NoteDirection:int=1;
		/**
		 * 注记等值线线宽
		 */
		public var LineWidth:Number=0.05;
		/**
		 * 注记的最大倾角
		 */
		public var MaxAngle:Number=90.0;
		/**
		 * 注记间最小允许距离
		 */
		public var MinDist:Number=10.0;
		/**
		 * 数值是否取绝对值
		 */
		public var IsAbs:Boolean=false;
		/**
		 * 数值是否采用千位分隔符
		 */
		public var IsComma:Boolean=false;
		/**
		 * 注记数值的小数位数
		 */
		public var DigitNum:Number=0;
		/**
		 * 数据格式 （0/1/2: 定点/科学/通常）
		 */
		public var FormatNo:int=0;
		/**
		 * 取对数标志（0/1/2: 未取对数/10为底/自然对数）
		 */
		public var LogFlag:int=0;
		/**
		 * 注记前缀
		 */
		public var Prefix:String="";
		/**
		 * 注记后缀
		 */
		public var Suffix:String="";
		/**
		 * 注记颜色号
		 */
		public var ColorNo:int=0;
		/**
		 * 注记尺寸
		 */
		public var FixSize:Number=0.01;
		/**
		 * 注记字体号
		 */
		public var FontNo:int=0;
		/**
		 * 注记参数类
		 */
		public function ContourNoteParam()
		{
			
		}
	}	
}