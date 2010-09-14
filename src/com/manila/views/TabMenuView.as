package com.manila.views
{
	import com.manila.controllers.DesignViewController;
	import com.manila.controllers.MainCanvasViewController;
	import com.manila.controllers.TabViewController;
	import com.manila.models.ThemeManagerModel;
	import com.manila.views.panel.GraphicsPanel;
	import com.manila.views.panel.PanelHolder;
	import com.manila.views.panel.ShapesPanel;
	import com.manila.views.panel.TextsPanel;
	import com.mpt.controls.tilelist.Cell;
	import com.mpt.display.mScrollBar;
	import com.mpt.display.mTab;
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;

	/**
	* ...
	 * @author mykhel
	 */
	public class  TabMenuView extends MovieClip
	{
		
		private var _tab:mTab;
		private var _graphcisPanel:GraphicsPanel = null
		private var _textsPanel:TextsPanel = null
		private var _shapesPanel:ShapesPanel = null
		private var _panelHolder:PanelHolder;
		
		//private var 
		
		public function TabMenuView ():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			var _themeManager:ThemeManagerModel = ThemeManagerModel.getInstance();
			
			TabViewController.getInstance().tabMenu = this;
			
			
			_tab = new mTab();
			_tab.addItem({name:"Graphics", up:_themeManager.graphicsTabUp, over:_themeManager.graphicsTabOver, down:_themeManager.graphicsTabDown});
			_tab.addItem({name:"Texts", up:_themeManager.textsTabUp, over:_themeManager.textsTabOver, down:_themeManager.textsTabDown});
			_tab.addItem({name:"Shapes", up:_themeManager.shapesTabUp, over:_themeManager.shapesTabOver, down:_themeManager.shapesTabDown});
			addChild(_tab);
			
			
			TabViewController.getInstance().initListeners();
			
			
			_graphcisPanel = new GraphicsPanel(_tab.width);
			_textsPanel = new TextsPanel(_tab.width);
			_shapesPanel = new ShapesPanel();
			
			
			_panelHolder = new PanelHolder();
			_panelHolder.setStyle( { 
				x:0,
				y:71,
				width:_tab.width,
				stageHeight:stage.stageHeight,
				color:0xE4E3D1
			} );
			addChild(_panelHolder);
			
			
			
			MainCanvasViewController.getInstance().populate(_panelHolder, [_graphcisPanel, _textsPanel, _shapesPanel]);
			
			
			_tab.selectedItem = 1;
			_textsPanel.loadLibrary("texts");
		}
		
		
		
		public function get graphcisPanel():GraphicsPanel { return _graphcisPanel; }
		
		public function get textsPanel():TextsPanel { return _textsPanel; }
		
		public function get shapesPanel():ShapesPanel { return _shapesPanel; }
		
		public function get tab():mTab { return _tab; }
		
		public function get panelHolder():PanelHolder { return _panelHolder; }
	}

}