package components
{
	import flash.events.MouseEvent;
	
	import mx.controls.Alert;
	import mx.core.UIComponent;
	import mx.events.FlexEvent;
	import mx.managers.PopUpManager;
	
	import zdims.drawing.CoordinateType;
	import components.mymark.IMSMark;
	
	/**
	 *带click事件的标注
	 * @author lidongmei
	 */
	
	public class MyMark extends IMSMark
	{
		public var markcontrol:UIComponent;
		private var coordinatetype:int=CoordinateType.Screen;			
		
		private var markinfo:MarkInfo;
		public var _placename:String;
		private var _xinfo:String;
		private var _yinfo:String;

        

		public function get yinfo():String
		{
			return _yinfo;
		}

		public function set yinfo(value:String):void
		{
			_yinfo = value;
		}

		public function get xinfo():String
		{
			return _xinfo;
		}

		public function set xinfo(value:String):void
		{
			_xinfo = value;
		}

		public function get placename():String
		{
			return _placename;
		}

		public function set placename(value:String):void
		{
			_placename = value;
		}

		private var _onMouseClickCallback:Function=null;
		
		public function MyMark(markControl:UIComponent, coordinateType:int=CoordinateType.Screen)
		{
			super(markControl, coordinateType);
			this.markcontrol=this._markControl;
			this.coordinatetype=coordinateType;
		}
		
		public function onMarkClick(e:MouseEvent):void
		{
			markinfo=new MarkInfo();
			markinfo.addEventListener(FlexEvent.CREATION_COMPLETE,function(e:FlexEvent):void{
			markinfo.x=this.x;
			markinfo.y=this.y;
//			markinfo.Xinfo.text="nihao";
			markinfo.Xinfo.text=String(this.xinfo);
			markinfo.Yinfo.text=String(y);
			markinfo.placeName.text=String(this.placename);
			});
			markinfo.visible=true;
			this.mapContainer.addChild(markinfo);
		}
		
	}
}