package com.manila.models 
{
	import com.manila.controllers.AppController;
	/**
	 * ...
	 * @author mykhel
	 */
	public class FlashVarsModel
	{
		private var _data:Object;
		
		private static  var _instance:FlashVarsModel;
		
		public function FlashVarsModel (singletonEnforcer:SingletonEnforcer):void 
		
		public static function getInstance():FlashVarsModel {
			if (_instance == null) {
				_instance = new FlashVarsModel(new SingletonEnforcer());
			}
			return _instance;
		}
		
		public static function parseData(obj:Object):void 
		{
			FlashVarsModel.getInstance().data = obj;
			//AppController.getInstance().initRemoteVars(obj.
		}
		
		public function get data():Object { return _data; }
		public function set data(value:Object):void 
		{
			_data = value;
		}
		
		
	}

}

class SingletonEnforcer { }