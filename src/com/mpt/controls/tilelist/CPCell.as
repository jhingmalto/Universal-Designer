package com.mpt.controls.tilelist 
{
	import com.manila.models.ThemeManagerModel;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author mykhel
	 */
	public class CPCell extends Sprite
	{
		
		private var _up:Sprite = new Sprite();
		private var _down:Sprite = new Sprite();
		private var _over:Sprite = new Sprite();
		//private var hit:Sprite;
		
		private var _data:Object = new Object();
		
		private var _isEnable:Boolean = true;
		
		protected var _themeManager:ThemeManagerModel = ThemeManagerModel.getInstance();
		
		private var _color:uint;
		
		public function CPCell() 
		{
			_up.addChild(_themeManager.cpFrameUp);
			addChild(_up);
			
			_down.addChild(_themeManager.cpFrameOver);
			_down.visible = false;
			addChild(_down);
			
			_over.addChild(_themeManager.cpFrameOver);
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
		
		
		
		
		private var _style:Object = { x:0, y:0, width:20, height:20 };
		public function get style():Object { return _style; }
		public function set style(value:Object):void 
		{
			_style = value;
			var colorUp:uint = (value.colorUp ? value.colorUp : 0xffffff);
			var colorDown:uint = (value.colorDown ? value.colorDown : 0xff);
			var colorOver:uint = (value.colorOver ? value.colorOver : 0x0080ff);
			
			_up.graphics.clear();
			_up.graphics.beginFill(colorUp);
			_up.graphics.drawRoundRect(1, 1, value.width-2, value.height-2, 2, 2);
			
			_color = colorUp;
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
		
		public function get color():uint { return _color; }
		public function set color(value:uint):void 
		{
			_color = value;
			
			_up.graphics.clear();
			_up.graphics.beginFill(value);
			_up.graphics.drawRoundRect(1, 1, _up.width-2, _up.height-2, 2, 2);
			
		}
		
	}

}