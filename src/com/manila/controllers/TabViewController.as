package com.manila.controllers
{
	import com.manila.views.panel.colorpickers.CPColorPicker;
	import com.manila.views.panel.GraphicsPanel;
	import com.manila.views.panel.graphicstab.UploadsProgress;
	import com.manila.views.panel.PanelHolder;
	import com.manila.views.panel.ShapesPanel;
	import com.manila.views.panel.TextsPanel;
	import com.manila.views.TabMenuView;
	import flash.events.Event;

	/**
	* ...
	 * @author mykhel
	 */
	public class  TabViewController
	{
		private var _tabMenu:TabMenuView;
		
		private var _currentColorPicker:CPColorPicker;
		
		private var _uploadsProgress:UploadsProgress;
		
		
		private static  var _instance:TabViewController;
		public function TabViewController (singletonEnforcer:SingletonEnforcer):void 
		public static function getInstance():TabViewController {
			if (_instance == null) {
				_instance = new TabViewController(new SingletonEnforcer());
			}
			return _instance;
		}
		
		public function initListeners():void 
		{
			_tabMenu.tab.addEventListener("onChanged", onChanged)
		}
		
		private function onChanged(e:Event):void 
		{
			var _graphcisPanel:GraphicsPanel = tabMenu.graphcisPanel;
			var _shapesPanel:ShapesPanel = tabMenu.shapesPanel;
			var _textsPanel:TextsPanel = tabMenu.textsPanel;
			
			_graphcisPanel.visible = _textsPanel.visible = _shapesPanel.visible = false;
			tabMenu.textsPanel.isActive = tabMenu.shapesPanel.isActive = false;
			
			switch (tabMenu.tab.selectedItem) 
			{
				case 0: {
					_graphcisPanel.visible = true;
					break;
				}
				
				case 1: {
					_textsPanel.visible = true;
					_textsPanel.isActive = true;
					if (!_textsPanel._isLibraryLoad) _textsPanel.loadLibrary("texts");
					break;
				}
				
				case 2: {
					_shapesPanel.visible = true;
					if (!_shapesPanel._isLibraryLoad) _shapesPanel.loadLibrary("shapes");
					break;
				}
			}
		}
		
		public function callResize(stage:Object):void 
		{
			var _mainCanvasController:MainCanvasViewController = MainCanvasViewController.getInstance();
			var _panelHolder:PanelHolder = _tabMenu.panelHolder;
			
			if (stage.stageWidth > 1100 && stage.stageHeight > 600) {
				var _padding:Number = _mainCanvasController.PADDING;
				_mainCanvasController.move(_tabMenu, stage.stageWidth - _tabMenu.tab.width - _mainCanvasController.PADDING, 50);
				
				_panelHolder.resize( {
					color:0xE4E3D1,
					width:_tabMenu.tab.width,
					height:stage.stageHeight
				});
				
				_tabMenu.shapesPanel.resize(_tabMenu.tab.width, stage.stageHeight - _panelHolder.y);
				
			}
			
		}
		
		public function sortFontArr(arr:Array):void 
		{
			arr.sortOn(["name"]);
			for (var i:int = 0; i < arr.length; i++) 
			{
				arr[i].y = i * 28;
			}
		}
		
		public function sortSvgArr(arr:Array):void 
		{
			arr.sortOn(["name"]);
			for (var i:int = 0; i < arr.length; i++) 
			{
				arr[i].y = i * 28;
			}
		}
		
		
		public function get tabMenu():TabMenuView { return _tabMenu; }
		public function set tabMenu(value:TabMenuView):void 
		{
			_tabMenu = value;
		}
		
		public function get currentColorPicker():CPColorPicker { return _currentColorPicker; }
		public function set currentColorPicker(value:CPColorPicker):void 
		{
			_currentColorPicker = value;
		}
		
		public function get uploadsProgress():UploadsProgress { return _uploadsProgress; }
		public function set uploadsProgress(value:UploadsProgress):void 
		{
			_uploadsProgress = value;
		}
		
		
	}

}

class SingletonEnforcer { }