package com.mpt.display.tab 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	/**
	 * ...
	 * @author mykhel
	 */
	public class TabButton extends MovieClip
	{
		
		private var _up:Sprite = new Sprite();
		private var _down:Sprite = new Sprite();
		private var _over:Sprite = new Sprite();
		
		private var _isSelected:Boolean = false;
		
		public function TabButton() 
		{
			
			addChild(up);
			
			addChild(over);
			over.visible = false;
			
			addChild(down);
			down.visible = false;
			
			
			this.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			this.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			
			buttonMode = true;
		}
		
		private function onMouseDown(e:MouseEvent):void 
		{
			_isSelected = true;
			over.visible = false;
			down.visible = true;
			this.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		
		private function onMouseUp(e:MouseEvent):void 
		{
			//down.visible = false;
			over.visible = false;
			dispatchEvent(new Event("onChanged"));
			this.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		
		private function onMouseOut(e:MouseEvent):void 
		{
			if (!_isSelected) over.visible = false;
			this.removeEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
		}
		
		private function onMouseOver(e:MouseEvent):void 
		{
			if (!_isSelected) over.visible = true;
			this.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
		}
		
		
		private var _style:Object = { x:0, y:0, width:1, height:1 };
		public function get style():Object { return _style; }
		public function set style(value:Object):void 
		{
			_style = value;
		}
		
		private var _id:uint = 0;
		public function get id():uint { return _id; }
		public function set id(value:uint):void 
		{
			_id = value;
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
		
		public function get isSelected():Boolean { return _isSelected; }
		
		public function set isSelected(value:Boolean):void 
		{
			_isSelected = value;
			down.visible = value;
			over.visible = false;
			up.visible = true;
		}
		
		
		
		public function setStyle($style:Object):void 
		{
			for (var name:String in $style) 
			{
				_style[name] = $style[name];
			}
		}
		
	}

}