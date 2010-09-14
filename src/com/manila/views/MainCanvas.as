package com.manila.views
{
	import com.manila.controllers.AppController;
	import com.manila.controllers.MainCanvasViewController;
	import com.manila.controllers.TabViewController;
	import com.manila.models.FlashVarsModel;
	import com.manila.models.ProductModel;
	import com.manila.models.ThemeManagerModel;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import fonts.Alepholon;

	/**
	* ...
	 * @author mykhel
	 */
	public class  MainCanvas extends MovieClip
	{
		// button cancel, done, trash, preview
		protected var _mainMenu:MainMenuView; 
		
		// product, design
		protected var _designerCanvas:DesignerCanvasView; 
		
		// tabs
		protected var _tabMenu:TabMenuView;
		
		// getinstances
		protected var _mainCanvasController:MainCanvasViewController;
		protected var _tabController:TabViewController;
		
		protected var _flashVars:FlashVarsModel = FlashVarsModel.getInstance();
		
		//private var _designers:Array = new Array();
		private var _hasBack:Boolean = false;
		private var _hasFront:Boolean = false;
		//private var _merchName:String;
		//private var _merchColor:uint;
		
		
		public function MainCanvas ($main:Main):void 
		{
			
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
			
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			MainCanvasViewController.getInstance().mainCanvas = this;
			
			AppController.getInstance().createProductsMerchId(_flashVars.data.merchId, merchLoadComplete);
		}
		
		
		// callback listener if product created with merchandise id  
		private function merchLoadComplete():void 
		{
			var xml:XML = MainCanvasViewController.getInstance().merchandiseXML as XML;
			
			if (xml.mediaConfiguration.@isEditable[0].toLowerCase() == "true") {
				_hasBack = true;
			}
			if (xml.mediaConfiguration.@isEditable[1].toLowerCase() == "true") {
				_hasFront = true;
			}
			
			
			// create main menu instance
			_mainMenu = new MainMenuView();
			_mainMenu.hasBack = _hasBack;
			
			var _designerCanvasList:Array = MainCanvasViewController.getInstance().designerCanvasList;
			
			if (_hasBack) {
				// create DesignerCanvasView instance for front if product has back
				_designerCanvas = new DesignerCanvasView();
				_designerCanvas.sideName == "front";
				_designerCanvas.name = "front";
				_designerCanvasList.push( { canvas:_designerCanvas, sideName:"front" } );
				
				
				// create DesignerCanvasView instance for back if product has back
				_designerCanvas = new DesignerCanvasView();
				_designerCanvas.sideName == "back";
				_designerCanvas.name = "back";
				_designerCanvas.visible = false;
				_designerCanvasList.push( { canvas:_designerCanvas, sideName:"back" } );
			} else {
				// create DesignerCanvasView instance for front if product has no back
				_designerCanvas = new DesignerCanvasView();
				_designerCanvas.sideName == "front";
				_designerCanvas.name = "front";
				_designerCanvasList.push( { canvas:_designerCanvas, sideName:"front" } );
			}
			
			// create tab menu instance
			_tabMenu = new TabMenuView();
			
			
			// loading theme xml.
			ThemeManagerModel.getInstance().loadTheme("assets/theme/default.xml");
			
			
			// setting tab menu
			//TabViewController.getInstance().tabMenu = _tabMenu;
			
			
			addEventListener("themeLoadComplete", themeLoadComplete);
			
		}
		
		
		private function themeLoadComplete(e:Event):void 
		{
			var _mainCanvasController:MainCanvasViewController = MainCanvasViewController.getInstance();
			if (_hasBack)
			{
				_mainCanvasController.populate(this, [_mainCanvasController.getCanvasDesignerByName("front"), _mainCanvasController.getCanvasDesignerByName("back"), _tabMenu, _mainMenu]);
			}
			else
			{
				_mainCanvasController.populate(this, [_mainCanvasController.getCanvasDesignerByName("front"), _tabMenu, _mainMenu]);
			}
			
			var obj:Object = {
				hasBack:_hasBack,
				hasFront:_hasFront,
				merchName:_flashVars.data.merchName,
				merchColor:_flashVars.data.merchColor
			};
			
			_mainCanvasController.loadProductMerch(obj);
			
			_mainCanvasController.move(_tabMenu, stage.stageWidth - _tabMenu.width - _mainCanvasController.PADDING, 50);
			
			stage.addEventListener(Event.RESIZE, onresize);
			
		}
		
		
		private function onresize(e:Event):void 
		{
			var _mainCanvasController:MainCanvasViewController = MainCanvasViewController.getInstance();
			
			_mainMenu.callResize(stage);
			TabViewController.getInstance().callResize(stage);
			
			if (_mainCanvasController.getCanvasDesignerByName("front")) _mainCanvasController.getCanvasDesignerByName("front").callResize(stage);
			if (_mainCanvasController.getCanvasDesignerByName("back")) _mainCanvasController.getCanvasDesignerByName("back").callResize(stage);
		}
		
		
		
		
	}

}