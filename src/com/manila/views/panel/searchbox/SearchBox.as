package com.manila.views.panel.searchbox 
{
	import com.manila.controllers.AppController;
	import com.manila.controllers.MainCanvasViewController;
	import com.manila.models.TabViewModel;
	import com.manila.models.ThemeManagerModel;
	import com.mpt.display.mButton;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	/**
	 * ...
	 * @author mykhel
	 */
	public class SearchBox extends MovieClip
	{
		protected var _mainCanvasController:MainCanvasViewController;
		protected var _app:AppController;
		protected var _tabModel:TabViewModel;
		protected var _themeManager:ThemeManagerModel;
		
		private var _label:TextField;
		private var _input:TextField;
		private var _inputBorder:Sprite;
		private var _searchBtn:mButton;
		
		private var _searchValue:String;
		
		public function SearchBox():void
		{
			_mainCanvasController = MainCanvasViewController.getInstance();
			_app = AppController.getInstance();
			_tabModel = TabViewModel.getInstance();
			_themeManager = ThemeManagerModel.getInstance();
			
			
			var tf:TextFormat = new TextFormat("Arial", 16, 0x666666, true);
			
			_label = new TextField();
			_label.text = "Clipart";
			_label.selectable = false;
			_label.autoSize = "left";
			_label.setTextFormat(tf);
			
			_input = new TextField();
			_input.text = "";
			_input.type = TextFieldType.INPUT;
			_input.width = 120;
			_input.height = 22;
			_input.setTextFormat(tf);
			_input.defaultTextFormat = tf;
			_input.x = _label.width + 10;
			
			
			_inputBorder = new Sprite();
			_inputBorder.graphics.lineStyle(2, 0x666759);
			_inputBorder.graphics.drawRoundRect(0, 0, _input.width, _input.height, 8, 8);
			_inputBorder.x = _input.x;
			
			
			_searchBtn = new mButton();
			_searchBtn.label = "Search"
			_searchBtn.setStyle( {
				width:70,
				height:25,
				up:[_themeManager.btnColors1.up, _themeManager.btnColors1.upGradient],
				down:[_themeManager.btnColors1.down],
				over:[_themeManager.btnColors1.up, _themeManager.btnColors1.upGradient]
			});
			_searchBtn.x = _input.x + _input.width + 10;
			_searchBtn.addEventListener(MouseEvent.MOUSE_DOWN, onSearchMouseDown);
			
			
			_mainCanvasController.populate(this, [_label, _input, _inputBorder, _searchBtn]);
			
		}
		
		private function onSearchMouseDown(e:MouseEvent):void 
		{
			dispatchEvent(new Event("onSearchQuerry"));
		}
		
		
		public function defaultSearch(callBackFunction:Function):void 
		{
			_app.searchGlyphs(_tabModel.defaultSearch, callBackFunction);
		}
		
		public function searchQuerry(search:String, callBackFunction:Function):void 
		{
			_app.searchGlyphs(search, callBackFunction);
		}
		
		
		
		public function get searchValue():String { return _input.text; }
		public function set searchValue(value:String):void 
		{
			_searchValue = value;
			_input.text = "" + value;
		}
		
	}

}