package zdims.drawing
{
	import flash.events.ContextMenuEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	
	import mx.core.UIComponent;
	
	import zdims.util.UIComponentEx;

	/**
	 * 折线 
	 * @author zhaoqianjun
	 * 
	 */	
	public class IMSPolyline extends GraphicsBase
	{
		//-----------------------------------------------------------------内部成员--------------------------------------------------------------
		/**
		 * 存储坐标数组 
		 */		
		protected var _pntArr:Vector.<Point>=new Vector.<Point>();//
		/**
		 * 实际绘图坐标 
		 */		
		protected var _gPntArr:Vector.<Point>=new Vector.<Point>();//
		/**
		 * 辅助绘图对象 
		 */		
		protected var _tmpLine:UIComponent=new UIComponent();
		//-----------------------------------------------------------------------------------------------------------------------------------
		//-----------------------------------------------------------------属性--------------------------------------------------------------
		/**
		 * 获取绘图坐标数组
		 * @return 绘图坐标数组
		 * 
		 */		
		public override function get points():Vector.<Point>
		{
			return _pntArr;
		}
		/**
		 * 设置绘图坐标数组 
		 * @param value 绘图坐标数组 
		 * 
		 */		
		public override function set points(value:Vector.<Point>):void
		{
			if(value!=null)
			{
				_pntArr = value;
			}
		}
		/**
		 * 获取绘制图形类型，值为DrawingType枚举类型。
		 * @return 绘制图形类型(值为DrawingType枚举类型) 
		 * 
		 */		
		public override function get drawingType():int
		{			
			return DrawingType.Polyline;
		}
		//-----------------------------------------------------------------------------------------------------------------------------------
		/**
		 * 折线类构造函数 
		 * @param coordinateType 坐标系类型，默认是“CoordinateType.Screen”
		 * 
		 */		
		public function IMSPolyline(coordinateType:int=CoordinateType.Screen)
		{
			super(coordinateType);
			_shape.addChild(_tmpLine);
			lineStyle(2,0xFF0000);
		}
		//-------------------------------------------------------------------公有方法----------------------------------------------------------------
		/**
		 * 清除绘制折线
		 * 
		 */
		public override function clear():void
		{
			if(_shape!=null)
			{
				_shape.graphics.clear();
				_tmpLine.graphics.clear();
			}
			_pntArr=new Vector.<Point>();
			_gPntArr=new Vector.<Point>();
			super.clear();
		}
		/**
		 * 绘制折线
		 * @param value 绘图数组默认值为“null”将根据内部坐标数组绘图，如果值不为“null”将会根据该坐标数组绘图。
		 * 
		 */		
		public override function draw(pntArr:Vector.<Point>=null):void
		{ 
			if(this._graphicsLayer==null||_shape==null||mapContainer==null)
				return;
			if(pntArr!=null)
				_pntArr=pntArr;
			if(_pntArr!=null&&_pntArr.length>1)
			{
				_gPntArr=new Vector.<Point>();
				var pnt1:Point;
				var x:Number=0,y:Number=0;
				this.beginSetStyle();
				if (_coordinateType == CoordinateType.Logic)
				{				
					pnt1 = mapContainer.logicToScreen(_pntArr[0].x, _pntArr[0].y);
					x=pnt1.x-_graphicsLayer.x;
					y=pnt1.y-_graphicsLayer.y;
					_shape.graphics.moveTo(x,y);
					_gPntArr.push(new Point(x,y));
					updateEditMark(0);
					for (var i:int = 1; i < _pntArr.length; i++)
					{
						pnt1 = mapContainer.logicToScreen(_pntArr[i].x, _pntArr[i].y);
						x=pnt1.x-_graphicsLayer.x;
						y=pnt1.y-_graphicsLayer.y;
						_shape.graphics.lineTo(x,y);
						_gPntArr.push(new Point(x,y));
						updateEditMark(i);
					}
				}

				else
				{
					x=_pntArr[0].x-_graphicsLayer.x;
					y=_pntArr[0].y-_graphicsLayer.y;
					_shape.graphics.moveTo(x,y);
					_gPntArr.push(new Point(x,y));
					updateEditMark(0);
					for (var j:int = 1; j < _pntArr.length; j++)
					{
						x=_pntArr[j].x-_graphicsLayer.x;
						y=_pntArr[j].y-_graphicsLayer.y;
						_shape.graphics.lineTo(x,y);
						_gPntArr.push(new Point(x,y));
						updateEditMark(j);
					}
				}
				this.endSetStyle();
			}
			else
				_shape.graphics.clear();
		}
		/**
		 * 添加点，一般用于零时随手绘制图形。
		 * @param pnt 点坐标
		 * 
		 */	
		public override function addPoint(pnt:Point):void
		{
			if(_shape!=null&&this._graphicsLayer!=null)
			{
				_tmpLine.graphics.clear();
				_pntArr.push(pnt);
				this.beginSetStyle();
				var x:Number=_pntArr[0].x;//-_graphicsLayer.x;
				var y:Number=_pntArr[0].y;//-_graphicsLayer.y;
				_shape.graphics.moveTo(x,y);
				for (var j:int = 1; j < _pntArr.length; j++)
				{
					x=_pntArr[j].x;//-_graphicsLayer.x;
					y=_pntArr[j].y;//-_graphicsLayer.y;
					_shape.graphics.lineTo(x,y);
				}
				this.endSetStyle();
			}
		}
		/**
		 * 更新图形末尾点，一般用于零时随手绘制图形。
		 * @param pnt 点坐标
		 * 
		 */	
		public override function updateEndPnt(pnt:Point):void
		{
			if(_shape!=null&&this._graphicsLayer!=null)
			{		
				_tmpLine.graphics.clear();
				if(pnt!=null&&_pntArr.length>0)
				{					
					_tmpLine.graphics.lineStyle(_lineStyle.thickness+1,0x669999,0.5);
					_tmpLine.graphics.moveTo(_pntArr[_pntArr.length-1].x/*-_graphicsLayer.x*/,_pntArr[_pntArr.length-1].y/*-_graphicsLayer.y*/);
					_tmpLine.graphics.lineTo(pnt.x/*-_graphicsLayer.x*/,pnt.y/*-_graphicsLayer.y*/);
				}
			}
		}
		//-----------------------------------------------------------------------------------------------------------------------------------
		//--------------------------------------------------------------------内部方法---------------------------------------------------------------
		/**
		 * 创建第一种类型的编辑Mark 
		 * @return 第一种类型的编辑Mark对象
		 * 
		 */		
		protected override function creatEditMark1():UIComponentEx
		{
			var rect:UIComponentEx=super.creatEditMark1();
			if(rect.contextMenu==null)
			{
				var menu:ContextMenu=new ContextMenu();
				menu.hideBuiltInItems();
				if(this._shape.contextMenu!=null)
				{
					for(var i:int=0;i<_shape.contextMenu.customItems.length;i++)
						menu.customItems.push(_shape.contextMenu.customItems[i]);
				}
				var item:ContextMenuItem=new ContextMenuItem("删除该点",true);
				item.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,delPnt_ContextMenuItem);
				menu.customItems.push(item);
				rect.contextMenu=menu;
			}
			return rect;
		}
		/**
		 * 更新编辑mark 
		 * @param i 点在数组中的索引
		 * 
		 */		
		protected function updateEditMark(i:int):void
		{
			if (_enableEdit && i >= 0)
			{
				getEditMark1ByIndex(i).x=_gPntArr[i].x - editRadius;
				getEditMark1ByIndex(i).y=_gPntArr[i].y - editRadius;
				if(i > 0&&_pntArr.length>1)
				{
					getEditMark2ByIndex(i - 1).x=(_gPntArr[i].x + _gPntArr[i - 1].x) / 2 - editRadius;
					getEditMark2ByIndex(i - 1).y=(_gPntArr[i].y + _gPntArr[i - 1].y) / 2 - editRadius;
				}
			}
		}
		/**
		 * 第一种编辑的mark鼠标按下事件响应回调 
		 * @param e 事件的数据源
		 * 
		 */		
		protected override function onEditMark1MouseDown(e:MouseEvent):void
		{
			super.onEditMark1MouseDown(e);
			mapContainer.addEventListener(MouseEvent.MOUSE_UP,onEditMark1MouseUp);
		}
		/**
		 * 地图容器鼠标移动事件回调
		 * @param e 事件的数据源
		 * 
		 */		
		protected override function onEditMark1MouseMove(e:MouseEvent):void
		{
			if(_isMouseDown&&_mouseDownShape!=null)
			{
				var pnt:Point=new Point(mapContainer.contentMouseX,mapContainer.contentMouseY);
				_mouseDownShape.x=_tmpLeft + pnt.x - _mouseDownPnt.x;
				_mouseDownShape.y=_tmpTop + pnt.y - _mouseDownPnt.y;
				
				if (_curEditMarkIndex >= 0)
				{
					var flg:Boolean=false;
					_tmpLine.graphics.clear();
					_tmpLine.graphics.lineStyle(_lineStyle.thickness+1,0x669999,0.5);
					if(_curEditMarkIndex-1>=0)
					{
						_tmpLine.graphics.moveTo(_gPntArr[_curEditMarkIndex-1].x,_gPntArr[_curEditMarkIndex-1].y);
						flg=true;
						
						getEditMark2ByIndex(_curEditMarkIndex-1).x=(_mouseDownShape.x+editRadius+_gPntArr[_curEditMarkIndex-1].x)*0.5-editRadius;
						getEditMark2ByIndex(_curEditMarkIndex-1).y=(_mouseDownShape.y+editRadius+_gPntArr[_curEditMarkIndex-1].y)*0.5-editRadius;
					}
					if(!flg)
						_tmpLine.graphics.moveTo(_mouseDownShape.x+editRadius,_mouseDownShape.y+editRadius);
					else
						_tmpLine.graphics.lineTo(_mouseDownShape.x+editRadius,_mouseDownShape.y+editRadius);
					if(_curEditMarkIndex+1<_pntArr.length)
					{
						_tmpLine.graphics.lineTo(_gPntArr[_curEditMarkIndex+1].x,_gPntArr[_curEditMarkIndex+1].y);
						
						getEditMark2ByIndex(_curEditMarkIndex).x=(_mouseDownShape.x+editRadius+_gPntArr[_curEditMarkIndex+1].x)*0.5-editRadius;
						getEditMark2ByIndex(_curEditMarkIndex).y=(_mouseDownShape.y+editRadius+_gPntArr[_curEditMarkIndex+1].y)*0.5-editRadius;
					}
				}
				if (editMark1DragInCallback != null)
					editMark1DragInCallback(_curEditMarkIndex, _mouseDownShape, _editMark1List, this);
			}
		}
		/**
		 * 第一种编辑的mark鼠标弹起事件响应回调  
		 * @param e 事件的数据源
		 * 
		 */		
		protected override function onEditMark1MouseUp(e:MouseEvent):void
		{
			if (_isMouseDown&&_curEditMarkIndex >= 0)
			{
				_tmpLine.graphics.clear();
				var pnt:Point=new Point(mapContainer.contentMouseX,mapContainer.contentMouseY);
				_gPntArr[_curEditMarkIndex]=new Point(pnt.x-_graphicsLayer.x,pnt.y-_graphicsLayer.y);
				if (_coordinateType == CoordinateType.Logic)
				{
					pnt = mapContainer.screenToLogic(pnt.x, pnt.y);
				}
				_pntArr[_curEditMarkIndex]=pnt;
				
				this.beginSetStyle();
				_shape.graphics.moveTo(_gPntArr[0].x,_gPntArr[0].y);
				for (var j:int = 1; j < _gPntArr.length; j++)
				{
					_shape.graphics.lineTo(_gPntArr[j].x,_gPntArr[j].y);
				}
				this.endSetStyle();				
			}
			super.onEditMark1MouseUp(e);
			mapContainer.removeEventListener(MouseEvent.MOUSE_UP,onEditMark1MouseUp);
		}
		/**
		 * 第二种编辑的mark鼠标按下事件响应回调 
		 * @param e 事件的数据源
		 * 
		 */		
		protected override function onEditMark2MouseDown(e:MouseEvent):void
		{
			super.onEditMark2MouseDown(e);
			mapContainer.addEventListener(MouseEvent.MOUSE_UP,onEditMark2MouseUp);
		}
		/**
		 * 地图容器鼠标移动事件回调
		 * @param e 事件的数据源
		 * 
		 */		
		protected override function onEditMark2MouseMove(e:MouseEvent):void
		{
			if(_isMouseDown&&_mouseDownShape!=null)
			{
				var pnt:Point=new Point(mapContainer.contentMouseX,mapContainer.contentMouseY);
				_mouseDownShape.x=_tmpLeft + pnt.x - _mouseDownPnt.x;
				_mouseDownShape.y=_tmpTop + pnt.y - _mouseDownPnt.y;
				
				if (_curEditMarkIndex >= 0&&_curEditMarkIndex+1<_pntArr.length)
				{
					var flg:Boolean=false;
					_tmpLine.graphics.clear();
					_tmpLine.graphics.lineStyle(_lineStyle.thickness+1,0x669999,0.5);					
					_tmpLine.graphics.moveTo(_gPntArr[_curEditMarkIndex].x,_gPntArr[_curEditMarkIndex].y);
					_tmpLine.graphics.lineTo(_mouseDownShape.x+editRadius,_mouseDownShape.y+editRadius);
					_tmpLine.graphics.lineTo(_gPntArr[_curEditMarkIndex+1].x,_gPntArr[_curEditMarkIndex+1].y);
					
				}
				if (editMark2DragInCallback != null)
					editMark2DragInCallback(_curEditMarkIndex, _mouseDownShape, _editMark2List, this);
			}
		}
		/**
		 * 第二种编辑的mark鼠标弹起事件响应回调  
		 * @param e 事件的数据源
		 * 
		 */		
		protected override function onEditMark2MouseUp(e:MouseEvent):void
		{
			if (_isMouseDown&&_curEditMarkIndex >= 0)
			{
				_tmpLine.graphics.clear();
				var pnt:Point=new Point(mapContainer.contentMouseX,mapContainer.contentMouseY);
				_gPntArr.splice(_curEditMarkIndex+1,0,new Point(pnt.x-_graphicsLayer.x,pnt.y-_graphicsLayer.y));
				if (_coordinateType == CoordinateType.Logic)
				{
					pnt = mapContainer.screenToLogic(pnt.x, pnt.y);
				}
				_pntArr.splice(_curEditMarkIndex+1,0,pnt);
				
				
				this.beginSetStyle();
				_shape.graphics.moveTo(_gPntArr[0].x,_gPntArr[0].y);
				updateEditMark(0);
				for (var j:int = 1; j < _gPntArr.length; j++)
				{
					_shape.graphics.lineTo(_gPntArr[j].x,_gPntArr[j].y);
					updateEditMark(j);
				}
				this.endSetStyle();				
			}
			super.onEditMark2MouseUp(e);
			mapContainer.removeEventListener(MouseEvent.MOUSE_UP,onEditMark2MouseUp);
		}
		/**
		 * 右键删除点回调 
		 * @param e 事件的数据源
		 * 
		 */		
		protected function delPnt_ContextMenuItem(e:ContextMenuEvent):void
		{
			if(e.contextMenuOwner is UIComponentEx)
			{
				var mark1:UIComponentEx=e.contextMenuOwner as UIComponentEx;
				delMark1ByIndex(_editMark1List.indexOf(mark1));
			}
		}
		/**
		 * 根据索引删除第一种标注 
		 * @param idx 索引
		 */		
		protected function delMark1ByIndex(idx:int):void
		{
			if(idx>=0&&idx<_editMark1List.length)
			{
				_editMark1List[idx].removeEventListener(MouseEvent.MOUSE_DOWN,onEditMark1MouseDown);
				_shape.removeChild(_editMark1List[idx]);				
				_gPntArr.splice(idx,1);
				_pntArr.splice(idx,1);					
				_editMark1List.splice(idx,1);
				
				if(idx>=0&&idx<_editMark2List.length)
				{
					_editMark2List[idx].removeEventListener(MouseEvent.MOUSE_DOWN,onEditMark2MouseDown);
					_shape.removeChild(_editMark2List[idx]);
					_editMark2List.splice(idx,1);
				}
				else if(idx>0&&idx==_editMark1List.length)//-1)
				{
					idx--;
					_editMark2List[idx].removeEventListener(MouseEvent.MOUSE_DOWN,onEditMark2MouseDown);
					_shape.removeChild(_editMark2List[idx]);
					_editMark2List.splice(idx,1);
				}
				
//				if(_editMark1List.length==1)//删除最后一个Mark
//				{
//					_editMark1List[0].removeEventListener(MouseEvent.MOUSE_DOWN,onEditMark1MouseDown);
//					_shape.removeChild(_editMark1List[0]);	
//					_gPntArr=new Vector.<Point>();
//					_pntArr=new Vector.<Point>();
//					_editMark1List=new Vector.<UIComponentEx>();
//				}
				this.draw();
			}
		}
		//-----------------------------------------------------------------------------------------------------------------------------------
	}
}