package com.manila.models 
{
	import com.manila.controllers.TabViewController;
	import com.manila.views.panel.GraphicsPanel;
	import com.manila.views.panel.PanelHolder;
	import com.manila.views.panel.ShapesPanel;
	import com.manila.views.panel.TextsPanel;
	/**
	 * ...
	 * @author mykhel
	 */
	public class TabViewModel
	{
		
		private var _currentTextColor:uint = 0;
		private var _currentGlyphsColor:uint = 0;
		
		private var _strokeWidth:Number = 2;
		private var _strokeColor:uint = 14833445;
		
		private var _fillColor:uint = 5152484;
		private var _fillStyle:String = "solid";
		
		private var _fontFamily:String = "Alepholon";
		private var _fontColor:uint = 0x999999;
		private var _fontSize:Number = 11;
		private var _fontScale:Number = 2.5;
		
		private var _defaultSearch:String = "featured";
		
		private var _shapesList:Array = new Array();
		private var _svgSearchResults:Array;
		
		private var _glyphartColor:uint = 0;
		
		
		private static  var _instance:TabViewModel;
		public function TabViewModel (singletonEnforcer:SingletonEnforcer):void 
		public static function getInstance():TabViewModel {
			if (_instance == null) {
				_instance = new TabViewModel(new SingletonEnforcer());
			}
			return _instance;
		}
		
		
		
		
		public function get currentTextColor():uint { return _currentTextColor; }
		public function set currentTextColor(value:uint):void 
		{
			_currentTextColor = value;
		}
		
		public function get currentGlyphsColor():uint { return _currentGlyphsColor; }
		public function set currentGlyphsColor(value:uint):void 
		{
			_currentGlyphsColor = value;
		}
		
		public function get strokeWidth():Number { return _strokeWidth; }
		public function set strokeWidth(value:Number):void 
		{
			_strokeWidth = value;
		}
		
		public function get strokeColor():uint { return _strokeColor; }
		public function set strokeColor(value:uint):void 
		{
			_strokeColor = value;
		}
		
		public function get fillColor():uint { return _fillColor; }
		public function set fillColor(value:uint):void 
		{
			_fillColor = value;
		}
		
		public function get fillStyle():String { return _fillStyle; }
		public function set fillStyle(value:String):void 
		{
			_fillStyle = value;
		}
		
		public function get fontFamily():String { return _fontFamily; }
		public function set fontFamily(value:String):void 
		{
			_fontFamily = value;
		}
		
		public function get fontColor():uint { return _fontColor; }
		public function set fontColor(value:uint):void 
		{
			_fontColor = value;
		}
		
		public function get fontSize():Number { return _fontSize; }
		public function set fontSize(value:Number):void 
		{
			_fontSize = value;
		}
		
		public function get fontScale():Number { return _fontScale; }
		public function set fontScale(value:Number):void 
		{
			_fontScale = value;
		}
		
		public function get defaultSearch():String { return _defaultSearch; }
		public function set defaultSearch(value:String):void 
		{
			_defaultSearch = value;
		}
		
		
		public function get graphcisPanel():GraphicsPanel { return TabViewController.getInstance().tabMenu.graphcisPanel; }
		
		public function get textsPanel():TextsPanel { return TabViewController.getInstance().tabMenu.textsPanel; }
		
		public function get shapesPanel():ShapesPanel { return TabViewController.getInstance().tabMenu.shapesPanel; }
		
		public function get panelHolder():PanelHolder { return TabViewController.getInstance().tabMenu.panelHolder; }
		
		
		public function get svgSearchResults():Array { return _svgSearchResults; }
		public function set svgSearchResults(value:Array):void 
		{
			_svgSearchResults = value;
		}
		
		public function get glyphartColor():uint { return _glyphartColor; }
		public function set glyphartColor(value:uint):void 
		{
			_glyphartColor = value;
		}
		
		public function get shapesList():Array { return _shapesList; }
		public function set shapesList(value:Array):void 
		{
			_shapesList = value;
		}
		
	}

}


class SingletonEnforcer { }