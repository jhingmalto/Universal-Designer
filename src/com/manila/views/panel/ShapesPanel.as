package com.manila.views.panel 
{
	import com.manila.controllers.DesignViewController;
	import com.manila.controllers.MainCanvasViewController;
	import com.manila.models.TabViewModel;
	import com.manila.models.ThemeManagerModel;
	import com.manila.views.art.ShapeArt;
	import com.manila.views.designer.Design;
	import com.manila.views.DesignerCanvasView;
	import com.manila.views.MainCanvas;
	import com.manila.views.panel.colorpickers.CPColorPicker;
	import com.mpt.controls.tilelist.Cell;
	import com.mpt.display.mScrollBar;
	import com.mpt.display.mTab;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import org.svgweb.core.SVGViewer;
	import org.svgweb.events.SVGEvent;
	
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	/**
	 * ...
	 * @author mykhel
	 */
	public class ShapesPanel extends MovieClip
	{
		
		protected var _mainCanvas:MainCanvas;
		protected var _tabModel:TabViewModel;
		protected var _designController:DesignViewController;
		protected var _themeManager:ThemeManagerModel;
		
		/*
		 * library - cell holder
		 * cell - the art holder (svg, shape, jpg)
		 * */
		private var _library:mScrollBar;
		
		private var _isActive:Boolean = false;
		
		public var _isLibraryLoad:Boolean = false;
		
		private var _borderCP:CPColorPicker;
		private var _fillCP:CPColorPicker;
		private var _borderTab:mTab;
		private var _fillTab:mTab;
		
		
		public function ShapesPanel() 
		{
			_mainCanvas = MainCanvasViewController.getInstance().mainCanvas;
			_tabModel = TabViewModel.getInstance();
			_designController = DesignViewController.getInstance();
			_themeManager = ThemeManagerModel.getInstance();
			
			var rect:Rectangle = new Rectangle(0, 0, 265, 180);
			
			// shapes library
			_library = new mScrollBar(stage);
			_library.setStyle( { knobUp:[_themeManager.btnColors1.up, _themeManager.btnColors1.upGradient, _themeManager.btnColors1.up], 
				knobOver:[_themeManager.btnColors1.over, _themeManager.btnColors1.overGradient], 
				topUp:[_themeManager.btnColors1.up], 
				topOver:[_themeManager.btnColors1.over], 
				bottomUp:[_themeManager.btnColors1.up], 
				bottomOver:[_themeManager.btnColors1.over]
			});
			_library.setRect(rect);
			_library.x = 10;
			_library.y = 10;
			
			rect = null;
			
			
			// colorpickers....
			// add border/stroke color picker
			_borderCP = new CPColorPicker();
			_borderCP.x = 10;
			_borderCP.y = _library.y + _library.height + 20
			_borderCP.label = "Border";
			_borderCP.addEventListener("cpChangeColor", borderChangeColor);
			
			// add shapes fill color picker
			_fillCP = new CPColorPicker();
			_fillCP.x = 10;
			_fillCP.y = _borderCP.y + _borderCP.height + 20;
			_fillCP.label = "Fill";
			_fillCP.addEventListener("cpChangeColor", fillChangeColor);
			
			
			// add border/stroke tab...
			_borderTab = new mTab();
			_borderTab.addItem({name:"0", up:_themeManager.border0Up, over:_themeManager.border0Over, down:_themeManager.border0Down});
			_borderTab.addItem({name:"1", up:_themeManager.border1Up, over:_themeManager.border1Over, down:_themeManager.border1Down});
			_borderTab.addItem({name:"2", up:_themeManager.border2Up, over:_themeManager.border2Over, down:_themeManager.border2Down});
			_borderTab.addItem({name:"3", up:_themeManager.border3Up, over:_themeManager.border3Over, down:_themeManager.border3Down});
			_borderTab.addItem({name:"4", up:_themeManager.border4Up, over:_themeManager.border4Over, down:_themeManager.border4Down});
			_borderTab.x = _borderCP.width  - _borderTab.width;
			_borderTab.y = _borderCP.y - 10;
			_borderTab.addEventListener("onChanged", borderChangeStrokeWidth);
			_borderTab.selectedItem = _tabModel.strokeWidth;
			
			// add shapes fill tab...
			_fillTab = new mTab();
			_fillTab.addItem({name:"none", up:_themeManager.fillNoneUp, over:_themeManager.fillNoneOver, down:_themeManager.fillNoneDown});
			_fillTab.addItem({name:"solid", up:_themeManager.fillSolidUp, over:_themeManager.fillSolidOver, down:_themeManager.fillSolidDown});
			_fillTab.x = _fillCP.width  - _fillTab.width;
			_fillTab.y = _fillCP.y - 10;
			_fillTab.addEventListener("onChanged", onFillStyleChange);
			_fillTab.selectedItem = (_tabModel.fillStyle == "solid" ? 1 : 0);
			
			// popuplate children...
			MainCanvasViewController.getInstance().populate(this, [_library, _borderCP, _fillCP, _borderTab, _fillTab]);
		}
		
		private function borderChangeStrokeWidth(e:Event):void 
		{
			var u:uint = e.currentTarget.selectedItem;
			_tabModel.strokeWidth = u;
			
			_designController.changeBorderWidth(u);
		}
		
		private function borderChangeColor(e:Event):void 
		{
			var u:uint = e.currentTarget.selectedColor;
			_tabModel.strokeColor = u;
			
			_designController.changeBorder(u);
		}
		
		private function fillChangeColor(e:Event):void 
		{
			var u:uint = e.currentTarget.selectedColor;
			_tabModel.fillColor = u;
			
			_designController.changeShapeFill(u);
		}
		
		private function onFillStyleChange(e:Event):void 
		{
			var u:uint = e.currentTarget.selectedItem;
			var s:String = (u == 0 ? "none" : "solid");
			_tabModel.fillStyle = s;
			
			_designController.changeShapeFillStyle(s);
		}
		
		public function loadLibrary(name:String):void 
		{
			if (_isLibraryLoad) return;
			_isLibraryLoad = true;
			var url:URLRequest = new URLRequest("assets/library/" + name + ".xml");
			//[6:06:37 PM] jhing.malto: http://174.129.214.250/channels/cp-make/tags/shape.xml
			//var url:URLRequest = new URLRequest("http://174.129.214.250/channels/cp-make/tags/shape.xml");
			var loader:URLLoader = new URLLoader();
			loader.load(url);
			loader.addEventListener(Event.COMPLETE, onLibLoadComplete, false, 0, true);
			
			url = null;
		}
		
		private var listItems:Array = new Array();
		private function onLibLoadComplete(e:Event):void 
		{
			e.currentTarget.removeEventListener(Event.COMPLETE, onLibLoadComplete);
			
			var xml:XML = new XML(e.currentTarget.data);
			for (var i:int = 0; i < xml.shape.length(); i++) 
			{
				var xmlSrc:String = xml.shape.@src[i];
				var cx:Number = Math.floor((listItems.length) % 4) * 60;
				var cy:Number = Math.floor((listItems.length) / 4) * 60;
				
				var _cell:Cell = new Cell();
				_cell.x = cx;
				_cell.y = cy;
				_cell.scaleX = _cell.scaleY = .6;
				_cell.data.stringID = xmlSrc;
				_cell.addEventListener(MouseEvent.MOUSE_DOWN, mousedown, false, 0, true);
				_cell.addEventListener(Event.ENTER_FRAME, checkOnDemand);
				
				_library.content.addChild(_cell);
				
				
				listItems.push(_cell);
				
				var shapeArt:ShapeArt = new ShapeArt();
				shapeArt.loadSvgAt(_cell, xmlSrc);
				
				_tabModel.shapesList.push(xmlSrc);
				
				if (listItems.length == 8) 
				{
					_library.isActive = true;
				}
				
			}
		}
		
		private function checkOnDemand(e:Event):void 
		{
			if(e.currentTarget.hasContent) e.currentTarget.removeEventListener(Event.ENTER_FRAME, checkOnDemand);
			if (Cell(e.currentTarget).hitTestObject(_library.masker)) {
				for (var i:int = 0; i < _tabModel.shapesList.length; i++) 
				{
					if(e.currentTarget.data.stringID == _tabModel.shapesList[i]) {
						var shapeArt:ShapeArt = new ShapeArt();
						shapeArt.loadSvgAt(e.currentTarget as Cell, _tabModel.shapesList[i]);
						break;
					}
				}
			}  
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
			
			// update the xml of dragged SVG
			// relatively to the shapes properties of _tabModel
			var newXML:XML = SVGViewer(e.currentTarget.data.svgViewer).xml;
			var nodes:XMLList = XMLList(newXML).children();
			nodes.@["stroke-width"] = _tabModel.strokeWidth;
			nodes.@["stroke-color"] = _tabModel.strokeColor;
			nodes.@["fill-style"] = _tabModel.fillStyle;
			nodes.@["fill-color"] = _tabModel.fillColor;
			nodes.@["fill"] = "#" + _tabModel.fillColor.toString(16);
			nodes.@["stroke"] = "#" + _tabModel.strokeColor.toString(16);
			
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
					
					name:"shapes"
				}
				activeDesign.addItem(newSVG, obj);
			} 
			
			
			newSVG.parent.removeChild(newSVG);
			newSVG = null;
			
			
			
			bmp.bitmapData.dispose();
			bmp = null;
			
		}
		
		
		public function resize($w:Number, $h:Number):void 
		{
			var rect:Rectangle = new Rectangle(0, 0, 265, $h - 420);
			
			if (_library.content.height >  $h - 420) {
				_library.setRect(rect);
				_borderCP.y = $h - 420 + 30;
				_fillCP.y = _borderCP.y + _borderCP.height + 20;
				_borderTab.y = _borderCP.y - 10;
				_fillTab.y = _fillCP.y - 10;
			}
			
			rect = null;
		}
		
		
		protected function get activeDesign():Design
		{
			return _designController.activeDesign;
		}
		
		
		public function get isActive():Boolean { return _isActive; }
		public function set isActive(value:Boolean):void 
		{
			_isActive = value;
		}
		
	}

}