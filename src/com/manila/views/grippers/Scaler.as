package com.manila.views.grippers 
{
	import com.manila.controllers.DesignViewController;
	import com.manila.views.designer.Design;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	/**
	 * ...
	 * @author mykhel
	 */
	public class Scaler extends Sprite
	{
		
		private var _target:*;
		
		private var _design:Design;
		
		public function Scaler() 
		{
			_design = DesignViewController.getInstance().design;
			
			graphics.beginFill(0xff, .2);
			graphics.drawRect( -10, -10, 20, 20);
			
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		}
		
		
		private var targetInitX:Number;
		private var targetInitY:Number;
		private var targetInitW:Number;
		private var targetInitH:Number;
		private var initDist:Number;
		//private var initDistX:Number;
		//private var initDistY:Number;
		private var initX:Number;
		private var initY:Number;
		private var initAngle:Number;
		private function onMouseDown(e:Event):void 
		{
			if (!target) return;
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			
			//this.startDrag(false);
			targetInitX = _target.x;
			targetInitY = _target.y;
			
			targetInitW = _target.getRect(_target).width * _target.scaleX;
			targetInitH = _target.getRect(_target).height * _target.scaleY;
			
			//targetInitW = Math.cos(_target.rotation * Math.PI / 180) * Point.distance(new Point(this.x, this.y), new Point(targetInitX, targetInitY));
			//targetInitH = Math.sin(_target.rotation * Math.PI / 180) * Point.distance(new Point(this.x, this.y), new Point(targetInitX, targetInitY));
			
			//Debug.log(targetInitW,targetInitH)
			
			initX = this.mouseX;
			initY = this.mouseY;
			initAngle = _target.rotation;
			
			var rw:Number = _target.getRect(_target).width / 2;
			var rh:Number = _target.getRect(_target).height / 2;
			var r:Number = Math.sqrt(rw * rw + rh * rh);
			
			//initDistX = rw;
			//initDistY = rh;
			initDist = r;
		}
		
		private function onMouseUp(e:Event):void 
		{
			stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			//this.stopDrag();
		}
		
		private function onMouseMove(e:MouseEvent):void 
		{
			// ratio proportion
			// relative to mouse x,y
			//var dx:Number = _design.mouseX - _design.gripper.x - initX;
			//var dy:Number = _design.mouseY - _design.gripper.y - initY;
			//var ang:Number = (_target.rotation + 45) * Math.PI / 180;
			//
			//var rw:Number = dx - targetInitX;
			//var rh:Number = dy - targetInitY;
			//var r:Number = Math.sqrt(rw * rw + rh * rh);
			//
			//this.x = targetInitX + Math.cos(ang) * r;
			//this.y = targetInitY + Math.sin(ang) * r;
			//
			//_target.scaleX = _target.scaleY = r / initDist;
			
			
			
			
			var dx:Number = _design.mouseX - _design.gripper.x - initX;
			var dy:Number = _design.mouseY - _design.gripper.y - initY;
			//var ang:Number = (_target.rotation + 45) * Math.PI / 180;
			var ang:Number = Math.atan2(dy - targetInitY, dx - targetInitX);
			
			var rw:Number = dx - targetInitX;
			var rh:Number = dy - targetInitY;
			var r:Number = Math.sqrt(rw * rw + rh * rh);
			
			this.x = dx;
			this.y = dy;
			//this.x = targetInitX + Math.cos(ang) * r;
			//this.y = targetInitY + Math.sin(ang) * r;
			
			_target.width = rw * 2;
			_target.height = rh * 2;
			
			//Debug.log(rw, targetInitW);
			
		}
		
		public function get target():* { return _target; }
		public function set target(value:*):void 
		{
			_target = value;
		}
		
	}

}