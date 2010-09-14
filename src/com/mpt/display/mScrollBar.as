package com.mpt.display 
{
	import flash.display.GradientType;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author mykhel
	 */
	public class mScrollBar extends Sprite
	{
		
		private var _content:Sprite = new Sprite();
		private var _masker:Sprite = new Sprite();
		private var _downBtn:Sprite = new Sprite();
		private var _upBtn:Sprite = new Sprite();
		private var _knobBtn:Sprite = new Sprite();
		
		private var _stage:Stage;
		private var _isScrollUp:Boolean;
		private var _isScrollDown:Boolean;
		private var _isKnobDown:Boolean;
		
		private var _isActive:Boolean = false;
		
		public function mScrollBar(stage:Stage):void
		{
			//_content = new Sprite();
			//_content.graphics.beginFill(0xeeeeee);
			//_content.graphics.drawRect(0, 0, 100, 50);
			addChild(_content);
			
			//_masker.graphics.beginFill(0);
			//_masker.graphics.drawRect(0, 0, 100, 300);
			addChild(_masker);
			
			_content.mask = _masker;
			
			//_knobBtn.graphics.beginFill(0);
			//_knobBtn.graphics.drawRect(0, 0, 20, 20);
			_knobBtn.visible = false;
			addChild(_knobBtn);
			_knobBtn.addEventListener(MouseEvent.MOUSE_DOWN, knobBtnClick);
			
			//_downBtn.graphics.beginFill(0);
			//_downBtn.graphics.moveTo(0, 0);
			//_downBtn.graphics.lineTo(14, 0);
			//_downBtn.graphics.lineTo(7, 10);
			//_downBtn.graphics.lineTo(0, 0);
			_downBtn.visible = false;
			addChild(_downBtn);
			_downBtn.addEventListener(MouseEvent.MOUSE_DOWN, downBtnClick);
			
			//_upBtn.graphics.beginFill(0);
			//_upBtn.graphics.moveTo(7, 0);
			//_upBtn.graphics.lineTo(14, 10);
			//_upBtn.graphics.lineTo(0, 10);
			//_upBtn.graphics.lineTo(7, 0);
			_upBtn.visible = false;
			addChild(_upBtn);
			_upBtn.addEventListener(MouseEvent.MOUSE_DOWN, upBtnClick);
			
			_stage = stage;
		}
		
		private function knobBtnClick(e:MouseEvent):void 
		{
			_isKnobDown = true;
			_knobBtn.startDrag(false, new Rectangle(_knobBtn.x, _upBtn.y + _upBtn.height, 0, _downBtn.y - _knobBtn.height - _upBtn.height));
			stage.addEventListener(MouseEvent.MOUSE_UP, s_mouseUp);
		}
		
		private function upBtnClick(e:MouseEvent):void 
		{
			_isScrollUp = true;
			stage.addEventListener(MouseEvent.MOUSE_UP, s_mouseUp);
		}
		
		
		private function downBtnClick(e:MouseEvent):void 
		{
			_isScrollDown = true;
			stage.addEventListener(MouseEvent.MOUSE_UP, s_mouseUp);
		}
		
		private function s_mouseUp(e:MouseEvent):void 
		{
			_isScrollUp = false;
			_isScrollDown = false;
			_isKnobDown = false;
			_knobBtn.stopDrag();
			stage.removeEventListener(MouseEvent.MOUSE_UP, s_mouseUp);
			
		}
		
		private function s_enterframe(e:Event):void 
		{
			if (!_isActive) return;
			
			var stepper:Number = (_masker.height) / _knobBtn.height;
			var isVisible:Boolean = (_knobBtn.height >= _masker.height - _upBtn.height - _downBtn.height - stepper ? false : true);
			
			_knobBtn.visible = isVisible;
			_upBtn.visible = isVisible;
			_downBtn.visible = isVisible;
			
			
			if (_isScrollUp && _knobBtn.y > _upBtn.y + _upBtn.height) {
				_knobBtn.y -=2;
			}
			else if (_isScrollDown && _knobBtn.y + _knobBtn.height < _downBtn.y ) {
				_knobBtn.y +=2;
			}
			
			_content.y = -(_knobBtn.y - _upBtn.height) * stepper;
			
			
			resizeKnob(_masker.height * ((_masker.height - _upBtn.height - _downBtn.height) / (_content.height)));
		}
		
		private function resizeKnob(n:Number):void 
		{
			var fillType:String = GradientType.LINEAR;
			var colors:Array = _knobStyle;
			var alphas:Array = new Array();
			//var ratios:Array = [0x00, 127, 0xFF];
			var ratios:Array = new Array();
			ratios.push(0);
			for (var i:int = 0; i < colors.length; i++) 
			{
				alphas.push(1);
				if (i != 0 && i != colors.length - 1) ratios.push(int(0xff / colors.length - 1));
			}
			ratios.push(255);
			var matr:Matrix = new Matrix();
			matr.createGradientBox(15, 15, 0, 0, 0);
			var spreadMethod:String = SpreadMethod.PAD;
				
			_knobBtn.graphics.clear();
			_knobBtn.graphics.beginGradientFill(fillType, colors, alphas, ratios, matr, spreadMethod);
			_knobBtn.graphics.drawRoundRect(0, 0, 15, n, 15, 15);
			
			
			_upBtn.x = _knobBtn.x + _knobBtn.width / 2 - _downBtn.width / 2;
			_downBtn.x = _knobBtn.x + _knobBtn.width / 2 - _downBtn.width / 2;
			
			fillType = "";
			colors = null;
			alphas = null;
			ratios = null;
			matr = null;
			spreadMethod = "";
			
			
		}
		
		public function setRect(rect:Rectangle):void 
		{
			
			_masker.graphics.clear();
			_masker.graphics.beginFill(0xeeeeee);
			_masker.graphics.drawRoundRect(rect.x, rect.y, rect.width, rect.height, 20, 20);
			//Debug.log(_masker.height);
			
			//_knobBtn.x = _downBtn.x + _downBtn.width / 2 - _knobBtn.width / 2;
			_knobBtn.x = _masker.width - _downBtn.width - 5;
			_knobBtn.y = _upBtn.y + _upBtn.height;
			
			
			_upBtn.x = _knobBtn.x + _knobBtn.width / 2 - _downBtn.width / 2;
			_upBtn.y = 0;
			
			
			_downBtn.x = _knobBtn.x + _knobBtn.width / 2 - _downBtn.width / 2;
			_downBtn.y = _masker.height - _downBtn.height;
			
			
			
			this.addEventListener(Event.ENTER_FRAME, s_enterframe);
			
			graphics.clear();
			graphics.lineStyle(1, 0x999999, 1, true, "none");
			graphics.beginFill(0xeeeeee);
			graphics.drawRoundRect(rect.x - 1, rect.y - 1, rect.width + 2, rect.height + 2, 20, 20);
			
			
			
		}
		
		public function setStyle(value:Object):void 
		{
			if (value.knobUp) {
				_knobStyle = value.knobUp;
			}
			
			if (value.topUp) {
				_upStyle = value.topUp;
				
				_upBtn.graphics.clear();
				_upBtn.graphics.beginFill(_upStyle[0]);
				_upBtn.graphics.moveTo(7, 0);
				_upBtn.graphics.lineTo(14, 10);
				_upBtn.graphics.lineTo(0, 10);
				_upBtn.graphics.lineTo(7, 0);
				
			}
			
			if (value.bottomUp) {
				_downStyle = value.bottomUp;
				
				_downBtn.graphics.clear();
				_downBtn.graphics.beginFill(_downStyle[0]);
				_downBtn.graphics.moveTo(0, 0);
				_downBtn.graphics.lineTo(14, 0);
				_downBtn.graphics.lineTo(7, 10);
				_downBtn.graphics.lineTo(0, 0);
				
			}
		}
		
		private var _knobStyle:Array = new Array();
		private var _upStyle:Array = new Array();
		private var _downStyle:Array = new Array();
		
		
		public function get content():Sprite { return _content; }
		public function set content(value:Sprite):void 
		{
			_content = value;
		}
		
		public function get downBtn():Sprite { return _downBtn; }
		public function set downBtn(value:Sprite):void 
		{
			_downBtn = value;
		}
		
		public function get upBtn():Sprite { return _upBtn; }
		public function set upBtn(value:Sprite):void 
		{
			_upBtn = value;
		}
		
		
		public function get knobBtn():Sprite { return _knobBtn; }
		public function set knobBtn(value:Sprite):void 
		{
			_knobBtn = value;
		}
		
		public function get isActive():Boolean { return _isActive; }
		public function set isActive(value:Boolean):void 
		{
			_isActive = value;
			
			_knobBtn.visible = value;
			_upBtn.visible = value;
			_downBtn.visible = value;
		}
		
		public function get masker():Sprite { return _masker; }
		
		
		
	}

}