package zdims.util
{
	import Mapgis7.WebService.BasLib.*;
	import flash.events.*;
	import flash.net.*;
	import zdims.interfaces.*;
	
	public class SpacialAnalyse2 extends Object
	{
		private var _iVector:IVector;
		
		public function SpacialAnalyse2(vectorLayer:IVector)
		{
			this._iVector = vectorLayer;
			return;
		}// end function
		
		public function clipByPolygon(obj:CClipByPolygon, callBack:Function) : void
		{
			this._iVector.call(obj, "ClipByPolygon", callBack);
			return;
		}// end function
		
		public function onClipByPolygon(event:Event) : String
		{
			return this._iVector.getResultObject(event, "String", "") as String;
		}// end function
		
		public function getAnalyseResult(uid:String, callBack:Function) : void
		{
			this._iVector.call(uid, "GetAnalyseResult", callBack);
			return;
		}// end function
		
		public function onGetAnalyseResult(event:Event) : String
		{
			return this._iVector.getResultObject(event, "String", "") as String;
		}// end function
		
		public function netAnalyse(obj:CNetAnalyse, callBack:Function) : void
		{
			this._iVector.call(obj, "NetAnalyse", callBack);
			return;
		}// end function
		
		public function onNetAnalyse(event:Event) : CPathAnalyzeResult
		{
			return this._iVector.getResultObject(event, "CPathAnalyzeResult") as CPathAnalyzeResult;
		}// end function
		
		public function projectDots(obj:CProjectDots, callBack:Function) : void
		{
			this._iVector.call(obj, "ProjectDots", callBack);
			return;
		}// end function
		
		public function onProjectDots(event:Event) : CGetProjectDots
		{
			return this._iVector.getResultObject(event, "CGetProjectDots") as CGetProjectDots;
		}// end function
		
		public function pntRegRelationAnalyse(obj:CPntRegRelationAnalyse, callBack:Function) : void
		{
			this._iVector.call(obj, "PntRegRelationAnalyse", callBack);
			return;
		}// end function
		
		public function linRegRelationAnalyse(obj:CLinRegRelationAnalyse, callBack:Function) : void
		{
			this._iVector.call(obj, "LinRegRelationAnalyse", callBack);
			return;
		}// end function
		
		public function regionRelationAnalyse(obj:CRegionRelationAnalyse, callBack:Function) : void
		{
			this._iVector.call(obj, "RegionRelationAnalyse", callBack);
			return;
		}// end function
		
		public function onRegionRelationAnalyse(event:Event) : String
		{
			var _loc_2:* = URLLoader(event.target).data;
			if (_loc_2.indexOf("Unknown") > 0)
			{
				return "Unknown";
			}
			if (_loc_2.indexOf("Intersect") > 0)
			{
				return "Intersect";
			}
			if (_loc_2.indexOf("Disjoin") > 0)
			{
				return "Disjoin";
			}
			if (_loc_2.indexOf("Include") > 0)
			{
				return "Include";
			}
			if (_loc_2.indexOf("Adjacent") > 0)
			{
				return "Adjacent";
			}
			return _loc_2;
		}// end function
		
		public function getGdbServerList(callBack:Function) : void
		{
			this._iVector.call("", "GetGdbServerList", callBack);
			return;
		}// end function
		
		public function onGetGdbServerList(event:Event) : CGetListName
		{
			return this._iVector.getResultObject(event, "CGetListName") as CGetListName;
		}// end function
		
		public function getGdbList(obj:CGetGdbList, callBack:Function) : void
		{
			this._iVector.call(obj, "GetGdbList", callBack);
			return;
		}// end function
		
		public function onGetGdbList(event:Event) : CGetListName
		{
			return this._iVector.getResultObject(event, "CGetListName") as CGetListName;
		}// end function
		
		public function getXClsList(obj:CGetXClsList, callBack:Function) : void
		{
			this._iVector.call(obj, "GetXClsList", callBack);
			return;
		}// end function
		
		public function onGetXClsList(event:Event) : CGetListName
		{
			return this._iVector.getResultObject(event, "CGetListName") as CGetListName;
		}// end function
		
		public function overlayByLayer(obj:COverlayByLayer, callBack:Function) : void
		{
			this._iVector.call(obj, "OverlayByLayer", callBack);
			return;
		}// end function
		
		public function onOverlayByLayer(event:Event) : String
		{
			return this._iVector.getResultObject(event, "String", "") as String;
		}// end function
		
		public function bufferByGeometry(obj:CBufferByGeometry, callBack:Function) : void
		{
			this._iVector.call(obj, "BufferByGeometry", callBack);
			return;
		}// end function
		
		public function onBufferByGeometry(event:Event) : COperResult
		{
			return this._iVector.getResultObject(event, "COperResult") as COperResult;
		}// end function
		
	}
}