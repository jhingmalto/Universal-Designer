package com.manila.models 
{
	import com.manila.controllers.MainCanvasViewController;
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	/**
	 * ...
	 * @author mykhel
	 */
	public class ThemeManagerModel
	{
		
		private var _mainCanvas:MainCanvasViewController;
		
		private var _graphicsTabUp:Sprite = new Sprite();
		private var _graphicsTabDown:Sprite = new Sprite();
		private var _graphicsTabOver:Sprite = new Sprite();
		
		private var _shapesTabUp:Sprite = new Sprite();
		private var _shapesTabDown:Sprite = new Sprite();
		private var _shapesTabOver:Sprite = new Sprite();
		
		private var _textsTabUp:Sprite = new Sprite();
		private var _textsTabDown:Sprite = new Sprite();
		private var _textsTabOver:Sprite = new Sprite();
		
		private var _doneBtnUp:Sprite = new Sprite();
		private var _doneBtnDown:Sprite = new Sprite();
		private var _doneBtnOver:Sprite = new Sprite();
		
		private var _cancelBtnUp:Sprite = new Sprite();
		private var _cancelBtnDown:Sprite = new Sprite();
		private var _cancelBtnOver:Sprite = new Sprite();
		
		private var _previewBtnUp:Sprite = new Sprite();
		private var _previewBtnDown:Sprite = new Sprite();
		private var _previewBtnOver:Sprite = new Sprite();
		
		private var _viewbackBtnUp:Sprite = new Sprite();
		private var _viewbackBtnDown:Sprite = new Sprite();
		private var _viewbackBtnOver:Sprite = new Sprite();
		
		private var _viewfrontBtnUp:Sprite = new Sprite();
		private var _viewfrontBtnDown:Sprite = new Sprite();
		private var _viewfrontBtnOver:Sprite = new Sprite();
		
		private var _trashBtnUp:Sprite = new Sprite();
		private var _trashBtnDown:Sprite = new Sprite();
		private var _trashBtnOver:Sprite = new Sprite();
		
		private var _clearBtnUp:Sprite = new Sprite();
		private var _clearBtnDown:Sprite = new Sprite();
		private var _clearBtnOver:Sprite = new Sprite();
		
		private var _scrollUpUp:Sprite = new Sprite();
		private var _scrollUpDown:Sprite = new Sprite();
		private var _scrollUpOver:Sprite = new Sprite();
		
		private var _scrollDownUp:Sprite = new Sprite();
		private var _scrollDownDown:Sprite = new Sprite();
		private var _scrollDownOver:Sprite = new Sprite();
		
		private var _scrollScrollUp:Sprite = new Sprite();
		private var _scrollScrollDown:Sprite = new Sprite();
		private var _scrollScrollOver:Sprite = new Sprite();
		
		private var _uploadBtnUp:Sprite = new Sprite();
		private var _uploadBtnDown:Sprite = new Sprite();
		private var _uploadBtnOver:Sprite = new Sprite();
		
		private var _addGraphicsBtnUp:Sprite = new Sprite();
		private var _addGraphicsBtnDown:Sprite = new Sprite();
		private var _addGraphicsBtnOver:Sprite = new Sprite();
		
		private var _cpFrameUp:Sprite = new Sprite();
		private var _cpFrameDown:Sprite = new Sprite();
		private var _cpFrameOver:Sprite = new Sprite();
		
		private var _cpRainbowUp:Sprite = new Sprite();
		private var _cpRainbowDown:Sprite = new Sprite();
		private var _cpRainbowOver:Sprite = new Sprite();
		
		private var _border0Up:Sprite = new Sprite();
		private var _border0Down:Sprite = new Sprite();
		private var _border0Over:Sprite = new Sprite();
		
		private var _border1Up:Sprite = new Sprite();
		private var _border1Down:Sprite = new Sprite();
		private var _border1Over:Sprite = new Sprite();
		
		private var _border2Up:Sprite = new Sprite();
		private var _border2Down:Sprite = new Sprite();
		private var _border2Over:Sprite = new Sprite();
		
		private var _border3Up:Sprite = new Sprite();
		private var _border3Down:Sprite = new Sprite();
		private var _border3Over:Sprite = new Sprite();
		
		private var _border4Up:Sprite = new Sprite();
		private var _border4Down:Sprite = new Sprite();
		private var _border4Over:Sprite = new Sprite();
		
		private var _fillNoneUp:Sprite = new Sprite();
		private var _fillNoneDown:Sprite = new Sprite();
		private var _fillNoneOver:Sprite = new Sprite();
		
		private var _fillSolidUp:Sprite = new Sprite();
		private var _fillSolidDown:Sprite = new Sprite();
		private var _fillSolidOver:Sprite = new Sprite();
		
		private var _upC1:uint;
		private var _upC2:uint;
		private var _overC1:uint;
		private var _overC2:uint;
		
		private var _btnColor1Up:uint;
		private var _btnColor1UpGradient:uint;
		private var _btnColor1Over:uint;
		private var _btnColor1OverGradient:uint;
		
		private var _btnColors1:Object;
		private var _btnColors2:Object;
		
		private static  var _instance:ThemeManagerModel;
		
		public function ThemeManagerModel(singletonEnforcer:SingletonEnforcer):void 
		{
			_mainCanvas = MainCanvasViewController.getInstance();
		}
		
		public static function getInstance():ThemeManagerModel {
			if (_instance == null) {
				_instance = new ThemeManagerModel(new SingletonEnforcer());
			}
			return _instance;
		}
		
		public function loadTheme(url:String):void 
		{
			var urlrequest:URLRequest = new URLRequest(url);
			var loader:URLLoader = new URLLoader();
			loader.load(urlrequest);
			loader.addEventListener(Event.COMPLETE, themeLoadComplete);
			
			urlrequest = null;
		}
		
		private function themeLoadComplete(e:Event):void 
		{
			e.currentTarget.removeEventListener(Event.COMPLETE, themeLoadComplete);
			
			var xml:XML = new XML(e.currentTarget.data);
			var item:XMLList = xml.item;
			len = item.length();
			
			for (var i:int = 0; i < len; i++) 
			{
				switch (item.@name[i].toString()) 
				{
					case "tab_graphics": {
						loadImageAt(_graphicsTabUp, item.@up[i]);
						loadImageAt(_graphicsTabDown, item.@down[i]);
						loadImageAt(_graphicsTabOver, item.@over[i]);
						break;
					}
					case "tab_shapes": {
						loadImageAt(_shapesTabUp, item.@up[i]);
						loadImageAt(_shapesTabDown, item.@down[i]);
						loadImageAt(_shapesTabOver, item.@over[i]);
						break;
					}
					case "tab_texts": {
						loadImageAt(_textsTabUp, item.@up[i]);
						loadImageAt(_textsTabDown, item.@down[i]);
						loadImageAt(_textsTabOver, item.@over[i]);
						break;
					}
					case "btn_done": {
						loadImageAt(_doneBtnUp, item.@up[i]);
						loadImageAt(_doneBtnDown, item.@down[i]);
						loadImageAt(_doneBtnOver, item.@over[i]);
						break;
					}
					case "btn_cancel": {
						loadImageAt(_cancelBtnUp, item.@up[i]);
						loadImageAt(_cancelBtnDown, item.@down[i]);
						loadImageAt(_cancelBtnOver, item.@over[i]);
						break;
					}
					case "btn_preview": {
						loadImageAt(_previewBtnUp, item.@up[i]);
						loadImageAt(_previewBtnDown, item.@down[i]);
						loadImageAt(_previewBtnOver, item.@over[i]);
						break;
					}
					case "btn_viewback": {
						loadImageAt(_viewbackBtnUp, item.@up[i]);
						loadImageAt(_viewbackBtnDown, item.@down[i]);
						loadImageAt(_viewbackBtnOver, item.@over[i]);
						break;
					}
					case "btn_viewfront": {
						loadImageAt(_viewfrontBtnUp, item.@up[i]);
						loadImageAt(_viewfrontBtnDown, item.@down[i]);
						loadImageAt(_viewfrontBtnOver, item.@over[i]);
						break;
					}
					case "btn_trash": {
						loadImageAt(_trashBtnUp, item.@up[i]);
						loadImageAt(_trashBtnDown, item.@down[i]);
						loadImageAt(_trashBtnOver, item.@over[i]);
						break;
					}
					case "btn_clear": {
						loadImageAt(_clearBtnUp, item.@up[i]);
						loadImageAt(_clearBtnDown, item.@down[i]);
						loadImageAt(_clearBtnOver, item.@over[i]);
						break;
					}
					case "scroll_up": {
						loadImageAt(_scrollUpUp, item.@up[i]);
						loadImageAt(_scrollUpDown, item.@down[i]);
						loadImageAt(_scrollUpOver, item.@over[i]);
						break;
					}
					case "scroll_down": {
						loadImageAt(_scrollDownUp, item.@up[i]);
						loadImageAt(_scrollDownDown, item.@down[i]);
						loadImageAt(_scrollDownOver, item.@over[i]);
						break;
					}
					case "scroll_scroll": {
						loadImageAt(_scrollScrollUp, item.@up[i]);
						loadImageAt(_scrollScrollDown, item.@down[i]);
						loadImageAt(_scrollScrollOver, item.@over[i]);
						break;
					}
					case "btn_add_graphics": {
						loadImageAt(_addGraphicsBtnUp, item.@up[i]);
						loadImageAt(_addGraphicsBtnDown, item.@down[i]);
						loadImageAt(_addGraphicsBtnOver, item.@over[i]);
						break;
					}
					case "btn_upload": {
						loadImageAt(_uploadBtnUp, item.@up[i]);
						loadImageAt(_uploadBtnDown, item.@down[i]);
						loadImageAt(_uploadBtnOver, item.@over[i]);
						break;
					}
					case "cp_rainbow": {
						loadImageAt(_cpRainbowUp, item.@up[i]);
						loadImageAt(_cpRainbowDown, item.@down[i]);
						loadImageAt(_cpRainbowOver, item.@over[i]);
						break;
					}
					case "cp_frame": {
						loadImageAt(_cpFrameUp, item.@up[i]);
						loadImageAt(_cpFrameDown, item.@down[i]);
						loadImageAt(_cpFrameOver, item.@over[i]);
						break;
					}
					case "border_0": {
						loadImageAt(_border0Up, item.@up[i]);
						loadImageAt(_border0Down, item.@down[i]);
						loadImageAt(_border0Over, item.@over[i]);
						break;
					}
					case "border_1": {
						loadImageAt(_border1Up, item.@up[i]);
						loadImageAt(_border1Down, item.@down[i]);
						loadImageAt(_border1Over, item.@over[i]);
						break;
					}
					case "border_2": {
						loadImageAt(_border2Up, item.@up[i]);
						loadImageAt(_border2Down, item.@down[i]);
						loadImageAt(_border2Over, item.@over[i]);
						break;
					}
					case "border_3": {
						loadImageAt(_border3Up, item.@up[i]);
						loadImageAt(_border3Down, item.@down[i]);
						loadImageAt(_border3Over, item.@over[i]);
						break;
					}
					case "border_4": {
						loadImageAt(_border4Up, item.@up[i]);
						loadImageAt(_border4Down, item.@down[i]);
						loadImageAt(_border4Over, item.@over[i]);
						break;
					}
					case "fill_none": {
						loadImageAt(_fillNoneUp, item.@up[i]);
						loadImageAt(_fillNoneDown, item.@down[i]);
						loadImageAt(_fillNoneOver, item.@over[i]);
						break;
					}
					case "fill_solid": {
						loadImageAt(_fillSolidUp, item.@up[i]);
						loadImageAt(_fillSolidDown, item.@down[i]);
						loadImageAt(_fillSolidOver, item.@over[i]);
						break;
					}
					case "buttonsColor1": {
						_btnColors1 = {
							border:(item[i].border == "0" ? false : true),
							borderColor:uint(item[i].@borderColor),
							fontColor:uint(item[i].@fontColor),
							up:uint(item[i].@up),
							upGradient:uint(item[i].@upGradient),
							over:uint(item[i].@over),
							overGradient:uint(item[i].@overGradient),
							down:uint(item[i].@down),
							downGradient:uint(item[i].@downGradient)
						}
						break;
					}
					case "buttonsColor2": {
						_btnColors2 = {
							border:(item[i] == "0" ? false : true),
							borderColor:uint(item[i].@borderColor),
							fontColor:uint(item[i].@fontColor),
							up:uint(item[i].@up),
							upGradient:uint(item[i].@upGradient),
							over:uint(item[i].@over),
							overGradient:uint(item[i].@overGradient),
							down:uint(item[i].@down),
							downGradient:uint(item[i].@downGradient)
						}
						break;
					}
				}
			}
			
			xml = null;
			item = null;
		}
		
		private var loadCtr:uint = 9;
		private var len:uint = 0;
		private function loadImageAt(mc:Sprite, url:String):void 
		{
			var urlrequest:URLRequest = new URLRequest("assets/theme/" + url);
			var loader:Loader = new Loader();
			
			if(url != "") {
				loader.load(urlrequest);
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, imageComplete);
				function imageComplete(e:Event):void 
				{
					e.currentTarget.removeEventListener(Event.COMPLETE, imageComplete);
					
					mc.addChild(e.currentTarget.content);
					loadCtr++;
					if (loadCtr >= len * 3) _mainCanvas.mainCanvas.dispatchEvent(new Event("themeLoadComplete"));
					
					loader = null;
				}
			} else {
				loadCtr ++
			}
				
			urlrequest = null;
			loader = null;
		}
		
		public function get graphicsTabUp():Bitmap { return new Bitmap((_graphicsTabUp.getChildAt(0) as Bitmap).bitmapData); }
		
		public function get graphicsTabDown():Bitmap { return new Bitmap((_graphicsTabDown.getChildAt(0) as Bitmap).bitmapData); }
		
		public function get graphicsTabOver():Bitmap { return new Bitmap((_graphicsTabOver.getChildAt(0) as Bitmap).bitmapData); }
		
		public function get shapesTabUp():Bitmap { return new Bitmap((_shapesTabUp.getChildAt(0) as Bitmap).bitmapData); }
		
		public function get shapesTabDown():Bitmap { return new Bitmap((_shapesTabDown.getChildAt(0) as Bitmap).bitmapData); }
		
		public function get shapesTabOver():Bitmap { return new Bitmap((_shapesTabOver.getChildAt(0) as Bitmap).bitmapData); }
		
		public function get textsTabUp():Bitmap { return new Bitmap((_textsTabUp.getChildAt(0) as Bitmap).bitmapData); }
		
		public function get textsTabDown():Bitmap { return new Bitmap((_textsTabDown.getChildAt(0) as Bitmap).bitmapData); }
		
		public function get textsTabOver():Bitmap { return new Bitmap((_textsTabOver.getChildAt(0) as Bitmap).bitmapData); }
		
		public function get doneBtnUp():Bitmap { return new Bitmap((_doneBtnUp.getChildAt(0) as Bitmap).bitmapData); }
		
		public function get doneBtnDown():Bitmap { return new Bitmap((_doneBtnDown.getChildAt(0) as Bitmap).bitmapData); }
		
		public function get doneBtnOver():Bitmap { return new Bitmap((_doneBtnOver.getChildAt(0) as Bitmap).bitmapData); }
		
		public function get cancelBtnUp():Bitmap { return new Bitmap((_cancelBtnUp.getChildAt(0) as Bitmap).bitmapData); }
		
		public function get cancelBtnDown():Bitmap { return new Bitmap((_cancelBtnDown.getChildAt(0) as Bitmap).bitmapData); }
		
		public function get cancelBtnOver():Bitmap { return new Bitmap((_cancelBtnOver.getChildAt(0) as Bitmap).bitmapData); }
		
		public function get previewBtnUp():Bitmap { return new Bitmap((_previewBtnUp.getChildAt(0) as Bitmap).bitmapData); }
		
		public function get previewBtnDown():Bitmap { return new Bitmap((_previewBtnDown.getChildAt(0) as Bitmap).bitmapData); }
		
		public function get previewBtnOver():Bitmap { return new Bitmap((_previewBtnOver.getChildAt(0) as Bitmap).bitmapData); }
		
		public function get viewbackBtnUp():Bitmap { return new Bitmap((_viewbackBtnUp.getChildAt(0) as Bitmap).bitmapData); }
		
		public function get viewbackBtnDown():Bitmap { return new Bitmap((_viewbackBtnDown.getChildAt(0) as Bitmap).bitmapData); }
		
		public function get viewbackBtnOver():Bitmap { return new Bitmap((_viewbackBtnOver.getChildAt(0) as Bitmap).bitmapData); }
		
		public function get trashBtnUp():Bitmap { return new Bitmap((_trashBtnUp.getChildAt(0) as Bitmap).bitmapData); }
		
		public function get trashBtnDown():Bitmap { return new Bitmap((_trashBtnDown.getChildAt(0) as Bitmap).bitmapData); }
		
		public function get trashBtnOver():Bitmap { return new Bitmap((_trashBtnOver.getChildAt(0) as Bitmap).bitmapData); }
		
		public function get clearBtnUp():Bitmap { return new Bitmap((_clearBtnUp.getChildAt(0) as Bitmap).bitmapData); }
		
		public function get clearBtnDown():Bitmap { return new Bitmap((_clearBtnDown.getChildAt(0) as Bitmap).bitmapData); }
		
		public function get clearBtnOver():Bitmap { return new Bitmap((_clearBtnOver.getChildAt(0) as Bitmap).bitmapData); }
		
		public function get scrollUpUp():Bitmap { return new Bitmap((_scrollUpUp.getChildAt(0) as Bitmap).bitmapData); }
		
		public function get scrollUpDown():Bitmap { return new Bitmap((_scrollUpDown.getChildAt(0) as Bitmap).bitmapData); }
		
		public function get scrollUpOver():Bitmap { return new Bitmap((_scrollUpOver.getChildAt(0) as Bitmap).bitmapData); }
		
		public function get scrollDownUp():Bitmap { return new Bitmap((_scrollDownUp.getChildAt(0) as Bitmap).bitmapData); }
		
		public function get scrollDownDown():Bitmap { return new Bitmap((_scrollDownDown.getChildAt(0) as Bitmap).bitmapData); }
		
		public function get scrollDownOver():Bitmap { return new Bitmap((_scrollDownOver.getChildAt(0) as Bitmap).bitmapData); }
		
		public function get scrollScrollUp():Bitmap { return new Bitmap((_scrollScrollUp.getChildAt(0) as Bitmap).bitmapData); }
		
		public function get scrollScrollDown():Bitmap { return new Bitmap((_scrollScrollDown.getChildAt(0) as Bitmap).bitmapData); }
		
		public function get scrollScrollOver():Bitmap { return new Bitmap((_scrollScrollOver.getChildAt(0) as Bitmap).bitmapData); }
		
		public function get uploadBtnUp():Bitmap { return new Bitmap((_uploadBtnUp.getChildAt(0) as Bitmap).bitmapData); }
		
		public function get uploadBtnDown():Bitmap { return new Bitmap((_uploadBtnDown.getChildAt(0) as Bitmap).bitmapData); }
		
		public function get uploadBtnOver():Bitmap { return new Bitmap((_uploadBtnOver.getChildAt(0) as Bitmap).bitmapData); }
		
		public function get addGraphicsBtnUp():Bitmap { return new Bitmap((_addGraphicsBtnUp.getChildAt(0) as Bitmap).bitmapData); }
		
		public function get addGraphicsBtnDown():Bitmap { return new Bitmap((_addGraphicsBtnDown.getChildAt(0) as Bitmap).bitmapData); }
		
		public function get addGraphicsBtnOver():Bitmap { return new Bitmap((_addGraphicsBtnOver.getChildAt(0) as Bitmap).bitmapData); }
		
		public function get viewfrontBtnUp():Bitmap { return new Bitmap((_viewfrontBtnUp.getChildAt(0) as Bitmap).bitmapData); }
		
		public function get viewfrontBtnDown():Bitmap { return new Bitmap((_viewfrontBtnDown.getChildAt(0) as Bitmap).bitmapData); }
		
		public function get viewfrontBtnOver():Bitmap { return new Bitmap((_viewfrontBtnOver.getChildAt(0) as Bitmap).bitmapData); }
		
		public function get cpFrameUp():Bitmap { return new Bitmap((_cpFrameUp.getChildAt(0) as Bitmap).bitmapData); }
		
		public function get cpFrameDown():Bitmap { return new Bitmap((_cpFrameDown.getChildAt(0) as Bitmap).bitmapData); }
		
		public function get cpFrameOver():Bitmap { return new Bitmap((_cpFrameOver.getChildAt(0) as Bitmap).bitmapData); }
		
		public function get cpRainbowUp():Bitmap { return new Bitmap((_cpRainbowUp.getChildAt(0) as Bitmap).bitmapData); }
		
		public function get cpRainbowDown():Bitmap { return new Bitmap((_cpRainbowDown.getChildAt(0) as Bitmap).bitmapData); }
		
		public function get cpRainbowOver():Bitmap { return new Bitmap((_cpRainbowOver.getChildAt(0) as Bitmap).bitmapData); }
		
		public function get border0Up():Bitmap { return new Bitmap((_border0Up.getChildAt(0) as Bitmap).bitmapData); }
		
		public function get border0Down():Bitmap { return new Bitmap((_border0Down.getChildAt(0) as Bitmap).bitmapData); }
		
		public function get border0Over():Bitmap { return new Bitmap((_border0Over.getChildAt(0) as Bitmap).bitmapData); }
		
		
		public function get border1Up():Bitmap { return new Bitmap((_border1Up.getChildAt(0) as Bitmap).bitmapData); }
		
		public function get border1Down():Bitmap { return new Bitmap((_border1Down.getChildAt(0) as Bitmap).bitmapData); }
		
		public function get border1Over():Bitmap { return new Bitmap((_border1Over.getChildAt(0) as Bitmap).bitmapData); }
		
		
		public function get border2Up():Bitmap { return new Bitmap((_border2Up.getChildAt(0) as Bitmap).bitmapData); }
		
		public function get border2Down():Bitmap { return new Bitmap((_border2Down.getChildAt(0) as Bitmap).bitmapData); }
		
		public function get border2Over():Bitmap { return new Bitmap((_border2Over.getChildAt(0) as Bitmap).bitmapData); }
		
		
		public function get border3Up():Bitmap { return new Bitmap((_border3Up.getChildAt(0) as Bitmap).bitmapData); }
		
		public function get border3Down():Bitmap { return new Bitmap((_border3Down.getChildAt(0) as Bitmap).bitmapData); }
		
		public function get border3Over():Bitmap { return new Bitmap((_border3Over.getChildAt(0) as Bitmap).bitmapData); }
		
		
		public function get border4Up():Bitmap { return new Bitmap((_border4Up.getChildAt(0) as Bitmap).bitmapData); }
		
		public function get border4Down():Bitmap { return new Bitmap((_border4Down.getChildAt(0) as Bitmap).bitmapData); }
		
		public function get border4Over():Bitmap { return new Bitmap((_border4Over.getChildAt(0) as Bitmap).bitmapData); }
		
		
		public function get fillNoneUp():Bitmap { return new Bitmap((_fillNoneUp.getChildAt(0) as Bitmap).bitmapData); }
		
		public function get fillNoneDown():Bitmap { return new Bitmap((_fillNoneDown.getChildAt(0) as Bitmap).bitmapData); }
		
		public function get fillNoneOver():Bitmap { return new Bitmap((_fillNoneOver.getChildAt(0) as Bitmap).bitmapData); }
		
		public function get fillSolidUp():Bitmap { return new Bitmap((_fillSolidUp.getChildAt(0) as Bitmap).bitmapData); }
		
		public function get fillSolidDown():Bitmap { return new Bitmap((_fillSolidDown.getChildAt(0) as Bitmap).bitmapData); }
		
		public function get fillSolidOver():Bitmap { return new Bitmap((_fillSolidOver.getChildAt(0) as Bitmap).bitmapData); }
		
		public function get upC1():uint { return _upC1; }
		
		public function get upC2():uint { return _upC2; }
		
		public function get overC1():uint { return _overC1; }
		
		public function get overC2():uint { return _overC2; }
		
		
		public function get btnColors1():Object { return _btnColors1; }
		
		public function get btnColors2():Object { return _btnColors2; }
		
		
		
	}

}

class SingletonEnforcer { }