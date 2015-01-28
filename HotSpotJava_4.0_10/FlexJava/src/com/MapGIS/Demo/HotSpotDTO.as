package com.MapGIS.Demo
{
	[Bindable]
	[RemoteClass(alias="com.MapGIS.Demo.HotSpotDTO")]
	public class HotSpotDTO
	{
		
		private var _id:int;
		
		private var _name:String;
		
		private var _gridCode:String; 
		
		private var _coord:String;
		
		private var _centerX:String;
		
		private var _centerY:String;
		
		private var _lev:int;
		
		private var _pnum:int;
		
		private var _paddress:String;
		
		
		public function get paddress():String
		{
			return _paddress;
		}

		public function set paddress(value:String):void
		{
			_paddress = value;
		}

		public function get pnum():int
		{
			return _pnum;
		}

		public function set pnum(value:int):void
		{
			_pnum = value;
		}

		public function get lev():int
		{
			return _lev;
		}

		public function set lev(value:int):void
		{
			_lev = value;
		}

		public function get centerY():String
		{
			return _centerY;
		}

		public function set centerY(value:String):void
		{
			_centerY = value;
		}

		public function get centerX():String
		{
			return _centerX;
		}

		public function set centerX(value:String):void
		{
			_centerX = value;
		}

		public function get coord():String
		{
			return _coord;
		}

		public function set coord(value:String):void
		{
			_coord = value;
		}

		public function get gridCode():String
		{
			return _gridCode;
		}

		public function set gridCode(value:String):void
		{
			_gridCode = value;
		}

		public function get name():String
		{
			return _name;
		}

		public function set name(value:String):void
		{
			_name = value;
		}

		public function get id():int
		{
			return _id;
		}

		public function set id(value:int):void
		{
			_id = value;
		}
		public function HotSpotDTO()
		{
			
		}
	}
}