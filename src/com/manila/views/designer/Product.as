package com.manila.views.designer
{
	import flash.display.MovieClip;
	import flash.events.Event;

	/**
	* ...
	 * @author mykhel
	 */
	public class  Product extends MovieClip
	{
		public function Product ():void 
		
		
		public function addItem(mc:MovieClip):void 
		{
			addChild(mc);
			dispatchEvent(new Event("productLoadComplete"));
		}
		
	}

}