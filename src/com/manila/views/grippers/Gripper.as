package com.manila.views.grippers
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;

	/**
	* ...
	 * @author mykhel
	 */
	public class  Gripper extends Sprite
	{
		
		private var _rotator:Rotator;
		private var _scaler:Scaler;
		
		private var _border:Sprite;
		
		private var _target:*
		
		public function Gripper ():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			_border = new Sprite();
			addChild(_border);
			
			_rotator = new Rotator();
			addChild(_rotator);
			_rotator.addEventListener("onRotate", onRotate);
			
			_scaler = new Scaler();
			addChild(_scaler);
			
			
			visible = false;
			
		}
		
		private function onRotate(e:Event):void 
		{
			
			var dx:Number = _target.x + _target.getBounds(_target).x * _target.scaleX;
			var dy:Number = _target.y + _target.getBounds(_target).y * _target.scaleY;
			//var w:Number = _target.svgRoot.width;
			//var h:Number = _target.svgRoot.height;
			
			var rw:Number = _target.getBounds(_target).width / 2 * _target.scaleX;
			var rh:Number = _target.getBounds(_target).height / 2 * _target.scaleY;
			var r:Number = Math.sqrt(rw * rw + rh * rh);
			
			
			//_rotator.x = dx + rw + Math.cos((value.rotation - 135) * Math.PI / 180) * r;
			//_rotator.y = dy + rh + Math.sin((value.rotation - 135) * Math.PI / 180) * r;
			
			_scaler.x = dx + rw + Math.cos((_target.rotation + 45) * Math.PI / 180) * r;
			_scaler.y = dy + rh + Math.sin((_target.rotation + 45) * Math.PI / 180) * r;
			
			drawBorder();
		}
		
		private function drawBorder():void 
		{
			var dx:Number = _target.x + _target.getBounds(_target).x * _target.scaleX;
			var dy:Number = _target.y + _target.getBounds(_target).y * _target.scaleY;
			var rw:Number = _target.getBounds(_target).width / 2 * _target.scaleX;
			var rh:Number = _target.getBounds(_target).height / 2 * _target.scaleY;
			var r:Number = Math.sqrt(rw * rw + rh * rh);
			
			graphics.clear();
			graphics.lineStyle(2, 0, .5, true, "none", null,null,0);
			graphics.moveTo(dx + rw + Math.cos((_target.rotation - 135) * Math.PI / 180) * (r+3),
							dy + rh + Math.sin((_target.rotation - 135) * Math.PI / 180) * (r+3));
			graphics.lineTo(dx + rw + Math.cos((_target.rotation - 45) * Math.PI / 180) * (r+3),
							dy + rh + Math.sin((_target.rotation - 45) * Math.PI / 180) * (r+3));
			graphics.lineTo(dx + rw + Math.cos((_target.rotation + 45) * Math.PI / 180) * (r+3),
							dy + rh + Math.sin((_target.rotation + 45) * Math.PI / 180) * (r+3));
			graphics.lineTo(dx + rw + Math.cos((_target.rotation + 135) * Math.PI / 180) * (r+3),
							dy + rh + Math.sin((_target.rotation + 135) * Math.PI / 180) * (r+3));
			graphics.lineTo(dx + rw + Math.cos((_target.rotation - 135) * Math.PI / 180) * (r+3),
							dy + rh + Math.sin((_target.rotation - 135) * Math.PI / 180) * (r+3));
			
		}
		
		public function get rotator():Rotator { return _rotator; }
		public function set rotator(value:Rotator):void 
		{
			_rotator = value;
		}
		
		public function get scaler():Scaler { return _scaler; }
		public function set scaler(value:Scaler):void 
		{
			_scaler = value;
		}
		
		public function get target():* { return _target; }
		public function set target(value:*):void 
		{
			_target = value;
			
			var dx:Number = value.x + value.getRect(value).x * _target.scaleX;
			var dy:Number = value.y + value.getRect(value).y * _target.scaleY;
			
			var rw:Number = value.getRect(value).width / 2 * value.scaleX;
			var rh:Number = value.getRect(value).height / 2 * value.scaleY;
			var r:Number = Math.sqrt(rw * rw + rh * rh);
			
			//Debug.log(value.scaleX);
			
			_rotator.x = dx + rw + Math.cos((value.rotation - 135) * Math.PI / 180) * r;
			_rotator.y = dy + rh + Math.sin((value.rotation - 135) * Math.PI / 180) * r;
			
			_scaler.x = dx + rw + Math.cos((value.rotation + 45) * Math.PI / 180) * r;
			_scaler.y = dy + rh + Math.sin((value.rotation + 45) * Math.PI / 180) * r;
			
			visible = true;
			_rotator.target = value;
			_scaler.target = value;
			
			
			//graphics.clear();
			//graphics.lineStyle(1);
			//graphics.drawRect(_rotator.x - 1, _rotator.y - 1, w, h);
			//graphics.moveTo(_rotator.x , _rotator.y );
			/*graphics.moveTo(dx + rw + Math.cos((value.rotation - 135) * Math.PI / 180) * (r+5),
							dy + rh + Math.sin((value.rotation - 135) * Math.PI / 180) * (r+5));
			graphics.lineTo(dx + rw + Math.cos((value.rotation - 45) * Math.PI / 180) * (r+5),
							dy + rh + Math.sin((value.rotation - 45) * Math.PI / 180) * (r+5));
			graphics.lineTo(dx + rw + Math.cos((value.rotation + 45) * Math.PI / 180) * (r+4),
							dy + rh + Math.sin((value.rotation + 45) * Math.PI / 180) * (r+4));
			graphics.lineTo(dx + rw + Math.cos((value.rotation + 135) * Math.PI / 180) * (r+4),
							dy + rh + Math.sin((value.rotation + 135) * Math.PI / 180) * (r+4));
			graphics.lineTo(dx + rw + Math.cos((value.rotation - 135) * Math.PI / 180) * (r+5),
							dy + rh + Math.sin((value.rotation - 135) * Math.PI / 180) * (r+5));
			*/
			//this.graphics.lineStyle(1);
			//this.graphics.drawRect(-w/2, -h/2, w , h );
			//this.x = _rotator.x - 1 ;
			//this.y = _rotator.y - 1 ;
			
			drawBorder();
		}
		
		public function get border():Sprite { return _border; }
		public function set border(value:Sprite):void 
		{
			_border = value;
		}
	}

}