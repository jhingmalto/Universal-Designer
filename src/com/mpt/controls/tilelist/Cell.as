package com.mpt.controls.tilelist 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import org.svgweb.core.SVGNode;
	import org.svgweb.nodes.SVGSVGNode;
	
	import org.svgweb.core.SVGViewer;
	import org.svgweb.events.SVGEvent;
	/**
	 * ...
	 * @author mykhel
	 */
	public class Cell extends Sprite
	{
		
		private var _up:Sprite = new Sprite();
		private var _down:Sprite = new Sprite();
		private var _over:Sprite = new Sprite();
		//private var hit:Sprite;
		
		private var _data:Object = new Object();
		
		private var _content:Sprite = new Sprite();
		
		private var _isEnable:Boolean = true;
		private var _isSvg:Boolean = false;
		private var _hasContent:Boolean = false;
		
		public function Cell() 
		{
			_up.graphics.beginFill(0xffffff);
			_up.graphics.lineStyle(1, 0x333333, .5);
			_up.graphics.drawRect(0, 0, style.width, style.height);
			addChild(_up);
			
			_down.graphics.beginFill(0xff);
			_down.graphics.lineStyle(1, 0x333333, .5);
			_down.graphics.drawRect(0, 0, style.width, style.height);
			_down.visible = false;
			addChild(_down);
			
			addChild(_content);
			
			_over.graphics.beginFill(0x0080FF, .5);
			_over.graphics.lineStyle(1, 0x333333, .5);
			_over.graphics.drawRect(0, 0, style.width, style.height);
			_over.visible = false;
			addChild(_over);
			
			this.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			this.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			
			buttonMode = true;
		}
		
		private function onMouseDown(e:MouseEvent):void 
		{
			down.visible = true;
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		
		private function onMouseUp(e:MouseEvent):void 
		{
			if(_isEnable)down.visible = false;
			over.visible = false;
			stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		
		private function onMouseOut(e:MouseEvent):void 
		{
			over.visible = false;
			this.removeEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
		}
		
		private function onMouseOver(e:MouseEvent):void 
		{
			over.visible = true;
			this.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
		}
		
		private var _svg:SVGViewer;
		public function addSvgToContent($svg:SVGViewer):void 
		{
			_isSvg = true;
			_svg = $svg;
			_svg.svgRoot.addEventListener(SVGEvent.SVGLoad, svgLoadComplete);
			
		}
		
		private function svgLoadComplete(e:SVGEvent):void 
		{
			_svg.svgRoot.removeEventListener(SVGEvent.SVGLoad, svgLoadComplete);
			
			
			if (_svg.width > _svg.height) {
				_svg.width = _style.width * .8;
				_svg.scaleY = _svg.scaleX;
			} else {
				_svg.height = _style.height * .8;
				_svg.scaleX = _svg.scaleY;
			}
			
			_svg.x = _style.width / 2 - _svg.width / 2;
			_svg.y = _style.height / 2 - _svg.height / 2;
			_content.addChild(_svg);
			
		}
		
		public function get bitmap():Bitmap 
		{
			if(_isSvg) {
				var bmpData:BitmapData = new BitmapData(_svg.getRect(_svg).width, _svg.getRect(_svg).height, true, 0);
				bmpData.draw(_svg, null, null, null, null, true);
				var bmp:Bitmap = new Bitmap(bmpData, "always", true);
			} else {
				bmp = _content.getChildAt(0) as Bitmap;
			}
			
			
			return bmp;
		}
		
		public function addImageToContent(bmp:Bitmap):void 
		{
			var bmpData:BitmapData = new BitmapData(bmp.width, bmp.height, true, 0);
			bmpData.draw(bmp, null, null, null, null, true);
			var bmp:Bitmap = new Bitmap(bmpData, "always", true);
			
			bmp.width = _style.width * .8;
			bmp.height = _style.height * .8;
			bmp.x = _style.width / 2 - bmp.width / 2;
			bmp.y = _style.height / 2 - bmp.height / 2;
			_content.addChild(bmp);
		}
		
		
		public function get content():Sprite { return _content; }
		public function set content(value:Sprite):void 
		{
			_content = value;
		}
		
		
		private var _style:Object = { x:0, y:0, width:100, height:100 };
		public function get style():Object { return _style; }
		public function set style(value:Object):void 
		{
			_style = value;
			var colorUp:uint = (value.colorUp ? value.colorUp : 0xffffff);
			var colorDown:uint = (value.colorDown ? value.colorDown : 0xff);
			var colorOver:uint = (value.colorOver ? value.colorOver : 0x0080ff);
			
			_up.graphics.clear();
			_up.graphics.beginFill(colorUp);
			_up.graphics.lineStyle(1, 0x333333, .5);
			_up.graphics.drawRect(0, 0, value.width, value.height);
			
			_down.graphics.clear();
			_down.graphics.beginFill(colorDown);
			_down.graphics.lineStyle(1, 0x333333, .5);
			_down.graphics.drawRect(0, 0, value.width, value.height);
			
			_over.graphics.clear();
			_over.graphics.beginFill(colorOver, .5);
			_over.graphics.lineStyle(2, 0);
			_over.graphics.drawRect(0, 0, value.width, value.height);
		}
		
		public function get up():Sprite { return _up; }
		public function set up(value:Sprite):void 
		{
			_up = value;
		}
		
		public function get down():Sprite { return _down; }
		public function set down(value:Sprite):void 
		{
			_down = value;
		}
		
		public function get over():Sprite { return _over; }
		public function set over(value:Sprite):void 
		{
			_over = value;
		}
		
		public function get data():Object { return _data; }
		public function set data(value:Object):void 
		{
			_data = value;
		}
		
		public function get isEnable():Boolean { return _isEnable; }
		public function set isEnable(value:Boolean):void 
		{
			_isEnable = value;
			_down.visible = !value
		}
		
		
		public function get hasContent():Boolean { return _hasContent; }
		public function set hasContent(value:Boolean):void 
		{
			_hasContent = value;
		}
		
	}

}