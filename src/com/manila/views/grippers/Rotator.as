package com.manila.views.grippers 
{
	import com.manila.controllers.DesignViewController;
	import com.manila.views.designer.Design;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author mykhel
	 */
	public class Rotator extends Sprite
	{
		
		private var _target:*;
		
		private var _design:Design;
		
		public function Rotator() 
		{
			_design = DesignViewController.getInstance().design;
			
			graphics.beginFill(0xff,.2);
			graphics.drawCircle(0, 0, 10);
			
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			
		}
		
		private function enterframe(e:Event):void 
		{
			var rw:Number = target.svgRoot.width / 2;
			var rh:Number = target.svgRoot.height / 2;
			var r:Number = Math.sqrt(rw * rw + rh * rh);
			
			//x = target.x + rw + Math.cos((target.rotation - 135) * Math.PI / 180) * r;
			//y = target.y + rh + Math.cos((target.rotation - 135) * Math.PI / 180) * r;
		}
		
		private var targetInitX:Number;
		private var targetInitY:Number;
		private var targetInitW:Number;
		private var targetInitH:Number;
		private var targetInitRect:Rectangle;
		private function onMouseDown(e:Event):void 
		{
			if (!target) return;
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			
			targetInitX = _target.x;
			targetInitY = _target.y;
			targetInitW = _target.width;
			targetInitH = _target.height;
			//targetInitRect = _target.getRect(_target);
		}
		
		private function onMouseUp(e:Event):void 
		{
			stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			//this.stopDrag();
		}
		
		
		private function onMouseMove(e:MouseEvent):void 
		{
			
			var dx:Number = _design.mouseX - _design.gripper.x;
			var dy:Number = _design.mouseY - _design.gripper.y;
			var ang:Number = Math.atan2(dy - targetInitY, dx - targetInitX);
			
			var rw:Number = _target.getRect(_target).width / 2 * _target.scaleX;
			var rh:Number = _target.getRect(_target).height / 2 * _target.scaleY;
			var r:Number = Math.sqrt(rw * rw + rh * rh);
			
			this.x = targetInitX + Math.cos(ang) * r;
			this.y = targetInitY + Math.sin(ang) * r;
			
			_target.rotation = ang / Math.PI * 180 + 135;
			dispatchEvent(new Event("onRotate"));
			
		}
		
		public function get target():* { return _target; }
		public function set target(value:*):void 
		{
			_target = value;
		}
		
	}

}