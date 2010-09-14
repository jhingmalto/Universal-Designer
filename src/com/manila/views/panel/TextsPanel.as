package com.manila.views.panel 
{
	import com.manila.controllers.DesignViewController;
	import com.manila.controllers.MainCanvasViewController;
	import com.manila.controllers.TabViewController;
	import com.manila.models.TabViewModel;
	import com.manila.models.ThemeManagerModel;
	import com.manila.views.art.ShapeArt;
	import com.manila.views.art.TextArt;
	import com.manila.views.designer.Design;
	import com.manila.views.panel.colorpickers.CPColorPicker;
	import com.mpt.controls.tilelist.Cell;
	import com.mpt.display.mScrollBar;
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	
	import org.svgweb.core.SVGViewer;
	import org.svgweb.events.SVGEvent;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author mykhel
	 */
	public class TextsPanel extends MovieClip
	{
		
		protected var _mainCanvasController:MainCanvasViewController;
		protected var _designController:DesignViewController;
		protected var _themeManager:ThemeManagerModel;
		protected var _tabModel:TabViewModel;
		protected var _tabController:TabViewController;
		
		private var _label:TextField;
		
		private var _cell:Cell;
		private var _library:mScrollBar;
		
		public var _isLibraryLoad:Boolean = false;
		private var _isActive:Boolean = false;
		
		private var _inputText:TextField;
		
		private var _selectedFont:String = "Alepholon";
		
		private var _fillCP:CPColorPicker;
		
		public function TextsPanel(w:Number) 
		{
			_mainCanvasController = MainCanvasViewController.getInstance();
			_designController = DesignViewController.getInstance();
			_themeManager = ThemeManagerModel.getInstance();
			_tabModel = TabViewModel.getInstance();
			_tabController = TabViewController.getInstance();
			
			var tf:TextFormat = new TextFormat("Arial", 16, 0x676767, true);
			
			_inputText = new TextField();
			_inputText.x = 10;
			_inputText.y = 10;
			_inputText.width = 265;
			_inputText.height = 21;
			_inputText.border = true
			_inputText.borderColor = 0;
			_inputText.type = TextFieldType.INPUT;
			_inputText.setTextFormat(tf);
			_inputText.defaultTextFormat = tf;
			_inputText.multiline = true
			_inputText.addEventListener(Event.CHANGE, onInputChange);
			_inputText.addEventListener(KeyboardEvent.KEY_UP, onInputKeyup);
			
			
			_label = new TextField();
			_label.text = "Font";
			_label.selectable = false;
			_label.autoSize = "left";
			_label.setTextFormat(tf);
			_label.x = 10;
			_label.y = _inputText.y + _inputText.height + 10;
			
			
			_library = new mScrollBar(stage);
			_library.setStyle( { knobUp:[_themeManager.btnColors1.up, _themeManager.btnColors1.upGradient, _themeManager.btnColors1.up], 
				knobOver:[_themeManager.btnColors1.over, _themeManager.btnColors1.overGradient], 
				topUp:[_themeManager.btnColors1.up], 
				topOver:[_themeManager.btnColors1.over], 
				bottomUp:[_themeManager.btnColors1.up], 
				bottomOver:[_themeManager.btnColors1.over]
			});
			_library.x = _label.x;
			_library.y = _label.y + _label.height;
			_library.setRect(new Rectangle(0, 0, 265, 280));
			
			
			// fill color picker
			_fillCP = new CPColorPicker();
			_fillCP.x = 10;
			_fillCP.y = _library.y + _library.height + 20;
			_fillCP.label = "Fill";
			
			
			_mainCanvasController.populate(this, [_inputText, _label, _library, _fillCP]);
			
			
			_fillCP.addEventListener("cpChangeColor", fillChangeColor);
			
		}
		
		private function onInputKeyup(e:KeyboardEvent):void 
		{
			if (e.charCode == 13) {
				if (_inputText.height < 63)
				{
					_inputText.height += 21;
					_label.y = _inputText.y + _inputText.height + 10;
					_library.y = _label.y + _label.height;
					_fillCP.y = _library.y + _library.masker.height + 20;
				}
				if (e.shiftKey) {
					
				}
			}
		}
		
		private function fillChangeColor(e:Event):void 
		{
			var u:uint = e.currentTarget.selectedColor;
			_tabModel.fontColor = u;
			
			_designController.changeTextFill(u);
		}
		
		private var newSVG:SVGViewer;
		private var isChangingText:Boolean = false;
		private function onInputChange(e:Event):void 
		{
			if(!isChangingText) {
				newSVG = new SVGViewer();
			} else 
			{
				activeDesign.editText(_inputText.text);
				return;
			}
			
			if(newSVG) {
			var textsXML:XML = XML('<svg version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" '+
	' width="100px" height="100px" viewBox="0 0 100 100" enable-background="new 0 0 100 100" xml:space="preserve">' +

  '<g ' +
'rotation = "0" '+
'editable = "all"'+
'space = "preserve" >'+

'<text text-anchor="middle" leading-spaces="0" ends-with-newline="0" >' +_inputText.text + '</text></g>'+

'</svg>');
			//textsXML.g.text = _inputText.text
			newSVG.xml = textsXML;
			
			var obj:Object = {
				x:190,
				y:190,
				width:_inputText.getCharBoundaries(0).width,
				height:_inputText.getCharBoundaries(0).height,
				scaleX:2.5,
				scaleY:2.5,
				font:_selectedFont,
				fontSize:11,
				fontColor:0xccff,
				text:_inputText.text,
				
				name:"text"
			}
			
			activeDesign.addText(newSVG, obj);
			
			}
			isChangingText = true;
		}
		
		private function newSVGFont():void 
		{
			
		}
		
		public function loadLibrary(name:String):void 
		{
			if (_isLibraryLoad) return;
			_isLibraryLoad = true;
			//var url:URLRequest = new URLRequest("assets/library/" + name + ".xml");
			var url:URLRequest = new URLRequest("assets/library/fonts.xml");
			var loader:URLLoader = new URLLoader();
			loader.load(url);
			loader.addEventListener(Event.COMPLETE, onLibLoadComplete);
		}
		
		protected function get activeDesign():Design
		{
			return _designController.activeDesign;
		}
		
		private var listItems:Array = new Array();
		private var _fontCellLists:Array = new Array();
		private function onLibLoadComplete(e:Event):void 
		{
			var xml:XML = new XML(e.currentTarget.data);
			for (var i:int = 0; i < xml.font.length(); i++) 
			{
				
				var textArt:TextArt = new TextArt();
				textArt.loadImage(xml.font.@src[i], i);
				textArt.imageViewer.addEventListener("imageLoadComplete", imageLoadComplete);
				
				
				function imageLoadComplete(e:Event):void 
				{
					e.currentTarget.removeEventListener("imageLoadComplete", imageLoadComplete);
					
					_cell = new Cell();
					_cell.style = { x:0, y:0, width:240, height:28 };
					
					_cell.addEventListener(MouseEvent.MOUSE_DOWN, mousedown, false, 0, true);
					_cell.y = listItems.length * 28;
					
					// get font name of the sprite from svgviewer
					var fname:String = e.currentTarget.getChildAt(0).toString().split(" ")[1].split("]")[0];
					var tf:TextFormat = new TextFormat(fname, 16);
					var textField:TextField = new TextField();
					textField.embedFonts = true;
					textField.text = fname;
					textField.setTextFormat(tf);
					textField.autoSize = "left";
					textField.setTextFormat(tf);
					textField.selectable = false;
					
					// set name of the cell for sorting...
					_cell.name = fname;
					_cell.content.addChild(textField);
					_cell.data.fontName = fname;
					_fontCellLists.push(_cell);
					
					// set cell enable false, if you want the cell to be selected...
					if (fname == _selectedFont) _cell.isEnable = false;
					
					_library.content.addChild(_cell);
					
					listItems.push(_cell);
					_tabController.sortFontArr(listItems);
					
					tf = null;
				}
				
			}
		}
		
		private function mousedown(e:Event):void 
		{
			var $target:Cell = e.currentTarget as Cell;
			stage.addEventListener(MouseEvent.MOUSE_UP, s_mouseup, false, 0, true);
			
			for (var i:int = 0; i < _fontCellLists.length; i++) 
			{
				_fontCellLists[i].isEnable = true;
			}
			
			$target.isEnable = false;
			
			var s:String = $target.data.fontName;
			_designController.changeTextFont(s);
			
			
			// update the xml of dragged newSVG
			// relatively to the color of _tabModel
			//var newXML:XML = SVGViewer($target.data.svgViewer).xml;
			//var nodes:XMLList = XMLList(newXML).children();
			//nodes.@["stroke-width"] = _tabModel.strokeWidth;
			//nodes.@["stroke-color"] = _tabModel.strokeColor;
			//nodes.@["fill-style"] = _tabModel.fillStyle;
			//nodes.@["fill-color"] = _tabModel.fillColor;
			//nodes.@["fill"] = "#" + _tabModel.fillColor.toString(16);
			//nodes.@["stroke"] = "#" + _tabModel.strokeColor.toString(16);
			
		}
		
		
		private function s_mouseup(e:MouseEvent):void 
		{
			stage.removeEventListener(MouseEvent.MOUSE_UP, s_mouseup);
			
		}
		
		public function get isActive():Boolean { return _isActive; }
		public function set isActive(value:Boolean):void 
		{
			_isActive = value;
			_library.isActive = value;
		}
		
		public function get selectedFont():String { return _selectedFont; }
		
		public function set selectedFont(value:String):void 
		{
			_selectedFont = value;
		}
	}

}