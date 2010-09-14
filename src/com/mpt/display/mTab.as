package com.mpt.display 
{
	import com.mpt.display.tab.TabButton;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author mykhel
	 */
	public class mTab extends MovieClip
	{
		
		private var _tabs:Array;
		private var _selectedItem:uint;
		private var _selectedName:uint;
		
		public function mTab() 
		{
			_tabs = new Array();
		}
		
		public function addItem(data:Object = null):void 
		{
			var _name:String = "" + data.name;
			
			var tabBtn:TabButton = new TabButton();
			//tabBtn.label = "" + _name;
			if (data.up) tabBtn.up.addChild(data.up);
			if (data.down) tabBtn.down.addChild(data.down);
			if (data.over) tabBtn.over.addChild(data.over);
			
			
			addChild(tabBtn);
			tabBtn.addEventListener("onChanged", onChanged);
			
			_tabs.push(tabBtn);
			
			for (var i:int = 0; i < _tabs.length; i++) 
			{
				//_tabs[i].x = i * (_tabs[i].width );
				if (i != 0) _tabs[i].x = (_tabs[i - 1].x + _tabs[i - 1].width);
				else _tabs[i].x = 0;
				tabBtn.id = i;
			}
		}
		
		private function onChanged(e:Event):void 
		{
			/*for (var i:int = 0; i < _tabs.length; i++) 
			{
				if (e.currentTarget != _tabs[i]) {
					_tabs[i].isSelected = false;
				}
			}*/
			selectedItem = e.currentTarget.id;
		}
		
		public function get selectedItem():uint { return _selectedItem; }
		public function set selectedItem(value:uint):void 
		{
			for (var i:int = 0; i < _tabs.length; i++) 
			{
				if (value == i) {
					_tabs[i].isSelected = true;
				} else {
					_tabs[i].isSelected = false;
				}
			}
			_selectedItem = value;
			dispatchEvent(new Event("onChanged"));
		}
		
		/*public function get selectedName():uint { return _selectedName; }
		public function set selectedName(value:uint):void 
		{
			for (var i:int = 0; i < _tabs.length; i++) 
			{
				if (value == i) {
					_tabs[i].isSelected = true;
				} else {
					_tabs[i].isSelected = false;
				}
			}
			_selectedItem = value;
			dispatchEvent(new Event("onChanged"));
		}*/
		
	}

}