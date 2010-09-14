package com.manila.models
{

	/**
	* ...
	 * @author mykhel
	 */
	public class  ProductModel
	{
		public function ProductModel ():void 
		
		private static var _currentProduct:Object;
		static public function get currentProduct():Object { return _currentProduct; }
		static public function set currentProduct(value:Object):void 
		{
			_currentProduct = value;
		}
		
		/*
		 * frontPosition
		 * front
		 * {front:"name", frontPosition:1}
		 * 
		 * backPosition
		 * back
		 * {back:"name", backPosition:2}
		 * 
		 * {front:"name", frontPosition:1, back:"", backPosition:2}
		 * */
		private static var _parsedProduct:Object;
		static public function get parsedProduct():Object { return _parsedProduct; }
		static public function set parsedProduct(value:Object):void 
		{
			_parsedProduct = value;
		}
		
	}

}