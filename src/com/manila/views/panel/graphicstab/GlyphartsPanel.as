package com.manila.views.panel.graphicstab 
{
	import com.manila.controllers.DesignViewController;
	import com.manila.controllers.MainCanvasViewController;
	import com.manila.models.TabViewModel;
	import com.manila.models.ThemeManagerModel;
	import com.manila.views.art.GlyphArt;
	import com.manila.views.designer.Design;
	import com.manila.views.MainCanvas;
	import com.manila.views.panel.colorpickers.CPColorPicker;
	import com.manila.views.panel.searchbox.SearchBox;
	import com.mpt.controls.tilelist.Cell;
	import com.mpt.display.mButton;
	import com.mpt.display.mScrollBar;
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import org.svgweb.core.SVGViewer;
	/**
	 * ...
	 * @author mykhel
	 */
	public class GlyphartsPanel extends MovieClip
	{
		protected var _mainCanvasController:MainCanvasViewController;
		protected var _mainCanvas:MainCanvas;
		protected var _tabModel:TabViewModel;
		protected var _designController:DesignViewController;
		protected var _themeManager:ThemeManagerModel;
		
		private var _addGraphicsBtn:mButton;
		
		private var _library:mScrollBar;
		
		private var _fillCP:CPColorPicker;
		
		private var _searchBox:SearchBox;
		private var _isSearchQuerryStop:Boolean = false;
		
		
		public function GlyphartsPanel():void 
		{
			_mainCanvasController = MainCanvasViewController.getInstance();
			_mainCanvas = _mainCanvasController.mainCanvas;
			_tabModel = TabViewModel.getInstance();
			_designController = DesignViewController.getInstance();
			_themeManager = ThemeManagerModel.getInstance();
			
			
			//_addGraphicsBtn = new mButton();
			//_addGraphicsBtn.up.addChild(_themeManager.addGraphicsBtnUp);
			//_addGraphicsBtn.over.addChild(_themeManager.addGraphicsBtnUp);
			//_addGraphicsBtn.down.addChild(_themeManager.addGraphicsBtnUp);
			//addChild(_addGraphicsBtn);
			
			_addGraphicsBtn = new mButton();
			_addGraphicsBtn.label = "Add professional graphics"
			_addGraphicsBtn.setStyle( {
				width:230,
				height:35,
				border:_themeManager.btnColors2.border,
				borderColor:_themeManager.btnColors2.borderColor,
				fontColor:_themeManager.btnColors2.fontColor,
				up:[_themeManager.btnColors2.up, _themeManager.btnColors2.upGradient],
				down:[_themeManager.btnColors2.down, _themeManager.btnColors2.downGradient],
				over:[_themeManager.btnColors2.over, _themeManager.btnColors2.overGradient]
			});
			_addGraphicsBtn.x = 10;
			addChild(_addGraphicsBtn);
			
			
			_searchBox = new SearchBox();
			_searchBox.visible = false;
			addChild(_searchBox);
			_searchBox.addEventListener("onSearchQuerry", onSearchQuerry);
			
			
			
			_addGraphicsBtn.addEventListener(MouseEvent.MOUSE_DOWN, initClick);
		}
		
		private function fillChangeColor(e:Event):void 
		{
			var u:uint = e.currentTarget.selectedColor;
			_tabModel.glyphartColor = u;
			
			_designController.changeGlyphartsFill(u);
		}
		
		private function onSearchQuerry(e:Event):void 
		{
			stopQuerry();
			
			_isSearchQuerryStop = false;
			_searchBox.searchQuerry(_searchBox.searchValue, onSearchComplete);
		}
		
		private function initClick(e:MouseEvent):void 
		{
			_addGraphicsBtn.removeEventListener(MouseEvent.MOUSE_DOWN, initClick);
			
			
			
			_library = new mScrollBar(stage);
			_library.setStyle( { knobUp:[_themeManager.btnColors1.up, _themeManager.btnColors1.upGradient, _themeManager.btnColors1.up], 
				knobOver:[_themeManager.btnColors1.over, _themeManager.btnColors1.overGradient], 
				topUp:[_themeManager.btnColors1.up], 
				topOver:[_themeManager.btnColors1.over], 
				bottomUp:[_themeManager.btnColors1.up], 
				bottomOver:[_themeManager.btnColors1.over]
			});
			_library.y = _addGraphicsBtn.y + _addGraphicsBtn.height + 10;
			
			addChild(_library);
			
			
			// add shapes fill color picker
			_fillCP = new CPColorPicker();
			_fillCP.x = 0;
			_fillCP.y = 350;
			_fillCP.label = "Fill Single Color";
			_fillCP.visible = true;
			addChild(_fillCP);
			_fillCP.addEventListener("cpChangeColor", fillChangeColor);
			
			
			
			
			showLibrary();
			
			_searchBox.searchValue = "featured";
			
			
			_addGraphicsBtn.addEventListener(MouseEvent.MOUSE_DOWN, onAddGraphicsBtnClick);
		}
		
		private function onAddGraphicsBtnClick(e:MouseEvent):void 
		{
			showLibrary();
			
		}
		
		public function showLibrary():void 
		{
			var rect:Rectangle = new Rectangle(0, 0, 265, 300);
			
			_searchBox.visible = true;
			_library.visible = true;
			_addGraphicsBtn.visible = false;
			_fillCP.visible = true;
			
			_isSearchQuerryStop = false;
			_searchBox.defaultSearch(onSearchComplete);
			
			_library.setRect(rect);
			
			dispatchEvent(new Event("onGlyphartsOpen"));
			
			rect = null;
		}
		
		public function hideLibrary():void 
		{
			if (!_library) return;
			_searchBox.visible = false;
			_library.visible = false;
			_addGraphicsBtn.visible = true;
			_fillCP.visible = false;
			
		}
		
		
		private var listItems:Array = new Array();
		private function onSearchComplete():void
		{
			listItems = new Array();
			
			for (var i:int = 0; i < _tabModel.svgSearchResults.length; i++) 
			{
				
				var cx:Number = Math.floor((listItems.length) % 4) * 60;
				var cy:Number = Math.floor((listItems.length) / 4) * 60;
				
				var _cell:Cell = new Cell();
				_cell.x = cx;
				_cell.y = cy;
				_cell.scaleX = _cell.scaleY = .6;
				_cell.data.stringID = _tabModel.svgSearchResults[i];
				_cell.addEventListener(MouseEvent.MOUSE_DOWN, mousedown, false, 0, true);
				_cell.addEventListener(Event.ENTER_FRAME, checkOnDemand);
				
				_library.content.addChild(_cell);
				
				
				listItems.push(_cell);
				
				//var shapeArt:GlyphArt = new GlyphArt();
				//shapeArt.loadSvgAt(_cell, _tabModel.svgSearchResults[i]);
				
				if (listItems.length == 24) {
					_library.isActive = true;
				}
				
				
				if (listItems.length <= 24) {
					
					var glyphArt:GlyphArt = new GlyphArt();
					glyphArt.loadSvgAt(_cell, _tabModel.svgSearchResults[i]);
				}
			}
			
		}
		
		private function checkOnDemand(e:Event):void 
		{
			if(e.currentTarget.hasContent) e.currentTarget.removeEventListener(Event.ENTER_FRAME, checkOnDemand);
			if (Cell(e.currentTarget).hitTestObject(_library.masker)) {
				for (var i:int = 0; i < _tabModel.svgSearchResults.length; i++) 
				{
					if(e.currentTarget.data.stringID == _tabModel.svgSearchResults[i]) {
						var glyphArt:GlyphArt = new GlyphArt();
						glyphArt.loadSvgAt(e.currentTarget as Cell, _tabModel.svgSearchResults[i]);
						break;
					}
				}
			}  
		}
		
		
		private function stopQuerry():void 
		{
			for (var i:int = 0; i < listItems.length; i++) 
			{
				listItems[i].data.svgViewer = null;
				listItems[i].parent.removeChild(listItems[i]);
				listItems[i] = null;
			}
			
			_library.isActive = false;
			_isSearchQuerryStop = true;
		}
		
		private var bmp:Bitmap;
		private var newSVG:SVGViewer;
		private function mousedown(e:MouseEvent):void 
		{
			
			// current target is cell. get bitmap on content.
			var target:Bitmap = e.currentTarget.bitmap;
			
			// dragged small bmp object.
			bmp = new Bitmap(target.bitmapData.clone(), "always", true);
			
			// resize bmp to smaller.
			if (bmp.width > bmp.height) {
				bmp.scaleX = bmp.scaleY = 30 / bmp.width;
			} else {
				bmp.scaleX = bmp.scaleY = 30 / bmp.height;
			}
			bmp.x = _mainCanvas.mouseX - bmp.width/2;
			bmp.y = _mainCanvas.mouseY - bmp.height / 2;
			
			_mainCanvas.addChild(bmp);
			
			
			// dragged new svg object.
			newSVG = new SVGViewer();
			
			// update the xml of dragged newSVG
			// relatively to the color of _tabModel
			var newXML:XML = SVGViewer(e.currentTarget.data.svgViewer).xml;
			var nodes:XMLList = XMLList(newXML).children();
			//nodes.@["stroke-width"] = _tabModel.strokeWidth;
			//nodes.@["stroke-color"] = _tabModel.strokeColor;
			//nodes.@["fill-style"] = _tabModel.fillStyle;
			//nodes.@["fill-color"] = _tabModel.fillColor;
			//nodes.@["fill"] = "#" + _tabModel.fillColor.toString(16);
			//nodes.@["stroke"] = "#" + _tabModel.strokeColor.toString(16);
			
			newSVG.xml = newXML;
			newSVG.x = _mainCanvas.mouseX - newSVG.svgRoot.width/2;
			newSVG.y = _mainCanvas.mouseY - newSVG.svgRoot.height/2;
			newSVG.visible = false;
			
			_mainCanvas.addChild(newSVG);
			
			
			stage.addEventListener(MouseEvent.MOUSE_UP, s_mouseup, false, 0, true);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, s_mousemove, false, 0, true);
			
			newXML = null;
			nodes = null;
		}
		
		
		private function s_mousemove(e:MouseEvent):void 
		{
			bmp.x = _mainCanvas.mouseX - bmp.width/2;
			bmp.y = _mainCanvas.mouseY - bmp.height/2;
			
			newSVG.x = _mainCanvas.mouseX - newSVG.svgRoot.width/2;
			newSVG.y = _mainCanvas.mouseY - newSVG.svgRoot.height/2;
			
			if(activeDesign.hitTestPoint(_mainCanvas.mouseX, _mainCanvas.mouseY, true)) {
				newSVG.visible = true;
				bmp.visible = false;
			} else {
				newSVG.visible = false
				bmp.visible = true;
			}
		}
		
		private function s_mouseup(e:MouseEvent):void 
		{
			stage.removeEventListener(MouseEvent.MOUSE_UP, s_mouseup);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, s_mousemove);
			
			
			if (newSVG.visible) {
				var obj:Object = {
					x:activeDesign.mouseX,
					y:activeDesign.mouseY,
					width:newSVG.width,
					height:newSVG.height,
					
					name:"glyhpart"
				}
				activeDesign.addItem(newSVG, obj);
			} 
			
			
			newSVG.parent.removeChild(newSVG);
			newSVG = null;
			
			
			
			bmp.bitmapData.dispose();
			bmp = null;
			
		}
		
		protected function get activeDesign():Design { return _designController.activeDesign; }
		
		
	}

}