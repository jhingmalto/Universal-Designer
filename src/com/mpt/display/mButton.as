package com.mpt.display 
{
	import flash.display.GradientType;
	import flash.display.MovieClip;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.text.TextField;
	import flash.text.TextFormat;
	/**
	 * ...
	 * @author mykhel
	 */
	public class mButton extends MovieClip
	{
		private var _up:Sprite = new Sprite();
		private var _down:Sprite = new Sprite();
		private var _over:Sprite = new Sprite();
		private var _label:TextField = new TextField();
		
		
		public function mButton() 
		{
			addChild(up);
			
			addChild(over);
			over.visible = false;
			
			addChild(down);
			down.visible = false;
			
			var tf:TextFormat = new TextFormat("Arial", 16, 0xffffff, true);
			
			addChild(_label);
			_label.text = "";
			_label.selectable = false;
			_label.autoSize = "left";
			_label.setTextFormat(tf);
			_label.defaultTextFormat = tf;
			_label.mouseEnabled = false;
			
			tf = null;
			
			
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
			down.visible = false;
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
		
		//private var _label:String = "Button";
		public function get label():String { return _label.text; }
		public function set label(value:String):void 
		{
			_label.text = value;
			
		}
		
		
		private var _style:Object = { x:0, y:0, width:100, height:25 };
		public function get style():Object { return _style; }
		public function set style(value:Object):void 
		{
			_style = value;
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
		
		private var _sizeStyle:Object = new Object();
		private var _colorUpStyle:Array = new Array();
		private var _colorOverStyle:Array = new Array();
		private var _colorDownStyle:Array = new Array();
		private var _lineStyle:Object = new Object();
		
		public function setStyle(value:Object):void 
		{
			
			_sizeStyle.width = (value.width ? value.width : 100);
			
			_sizeStyle.height = (value.height ? value.height : 100);
			
			_lineStyle.border = value.border
			if (value.border && !value.graphics) 
			{
				_lineStyle.color = (value.borderColor ? value.borderColor : 0);
			}
			
			if (value.up && !value.graphics) {
				_colorUpStyle = value.up;
				updateUpStyle()
			}
			
			if (value.over && !value.graphics) {
				_colorOverStyle = value.over;
				updateOverStyle();
			}
			
			if (value.down && !value.graphics) {
				_colorDownStyle = value.down;
				updateDownStyle();
			}
			
			if (value.fontColor && !value.graphics) 
			{
				var tf:TextFormat = _label.getTextFormat();
				tf.color = value.fontColor;
				
				_label.setTextFormat(tf);
				_label.defaultTextFormat = tf;
			}
			
			
		}
		
		private function updateUpStyle():void 
		{
			var $w:Number = _sizeStyle.width;
			var $h:Number = _sizeStyle.height;
			
			var fillType:String =  GradientType.LINEAR;
			var colors:Array = _colorUpStyle;
			var alphas:Array = new Array();
			var ratios:Array = new Array();
			ratios.push(0);
			for (var i:int = 0; i < colors.length; i++) 
			{
				alphas.push(1);
				if (i != 0 && i != colors.length - 1) ratios.push(int(0xff / colors.length - 1));
			}
			ratios.push(255);
			var matr:Matrix = new Matrix();
			matr.createGradientBox($w, $h, 90 * Math.PI/180, 0, 0);
			var spreadMethod:String = SpreadMethod.PAD;
			
			
			_up.graphics.clear();
			if(_lineStyle.border)_up.graphics.lineStyle(1, _lineStyle.color, 1, true);
			_up.graphics.beginGradientFill(fillType, colors, alphas, ratios, matr, spreadMethod);
			_up.graphics.drawRoundRect(0, 0, $w, $h, $h, $h);
			
			
			_label.x = _up.width / 2 - _label.width/2;
			_label.y = _up.height / 2 - _label.height/2;
			
			
			fillType = "";
			colors = null;
			alphas = null;
			ratios = null;
			matr = null;
			spreadMethod = "";
			
		}
		
		
		private function updateOverStyle():void 
		{
			var $w:Number = _sizeStyle.width;
			var $h:Number = _sizeStyle.height;
			
			var fillType:String =  GradientType.LINEAR;
			var colors:Array = _colorOverStyle;
			var alphas:Array = new Array();
			var ratios:Array = new Array();
			ratios.push(0);
			for (var i:int = 0; i < colors.length; i++) 
			{
				alphas.push(1);
				if (i != 0 && i != colors.length - 1) ratios.push(int(0xff / colors.length - 1));
			}
			ratios.push(255);
			var matr:Matrix = new Matrix();
			matr.createGradientBox($w, $h, 90 * Math.PI/180, 0, 0);
			var spreadMethod:String = SpreadMethod.PAD;
			
			
			_over.graphics.clear();
			if(_lineStyle.border)_over.graphics.lineStyle(1, _lineStyle.color, 1, true);
			_over.graphics.beginGradientFill(fillType, colors, alphas, ratios, matr, spreadMethod);
			_over.graphics.drawRoundRect(0, 0, $w, $h, $h, $h);
			
			
			_label.x = _up.width / 2 - _label.width / 2;
			_label.y = _up.height / 2 - _label.height / 2;
			
			
			fillType = "";
			colors = null;
			alphas = null;
			ratios = null;
			matr = null;
			spreadMethod = "";
			
		}
		
		private function updateDownStyle():void 
		{
			var $w:Number = _sizeStyle.width;
			var $h:Number = _sizeStyle.height;
			
			var fillType:String =  GradientType.LINEAR;
			var colors:Array = _colorDownStyle;
			var alphas:Array = new Array();
			var ratios:Array = new Array();
			ratios.push(0);
			for (var i:int = 0; i < colors.length; i++) 
			{
				alphas.push(1);
				if (i != 0 && i != colors.length - 1) ratios.push(int(0xff / colors.length - 1));
			}
			ratios.push(255);
			var matr:Matrix = new Matrix();
			matr.createGradientBox($w, $h, 90 * Math.PI/180, 0, 0);
			var spreadMethod:String = SpreadMethod.PAD;
			
			
			_down.graphics.clear();
			if(_lineStyle.border)_down.graphics.lineStyle(1, _lineStyle.color, 1, true);
			_down.graphics.beginGradientFill(fillType, colors, alphas, ratios, matr, spreadMethod);
			_down.graphics.drawRoundRect(0, 0, $w, $h, $h, $h);
			
			
			_label.x = _up.width / 2 - _label.width / 2;
			_label.y = _up.height / 2 - _label.height / 2;
			
			
			fillType = "";
			colors = null;
			alphas = null;
			ratios = null;
			matr = null;
			spreadMethod = "";
			
		}
		
		
	}

}