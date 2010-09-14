﻿package com.utils{
	import flash.events.*;
	import flash.display.Sprite;
	import flash.display.Shape;
	import flash.utils.Timer;

	public class CircleSlicePreloader extends Sprite {
		private var timer:Timer;
		private var slices:int;
		private var radius:int;

		public function CircleSlicePreloader(slices:int = 12, radius:int = 6, colors:uint = 0xffffff) {
			super();
			this.slices = slices;
			this.radius = radius;
			draw(colors);
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		private function onAddedToStage(event:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			timer = new Timer(65);
			timer.addEventListener(TimerEvent.TIMER, onTimer, false, 0, true);
			timer.start();
		}
		private function onRemovedFromStage(event:Event):void {
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			timer.reset();
			timer.removeEventListener(TimerEvent.TIMER, onTimer);
			timer = null;
		}
		private function onTimer(event:TimerEvent):void {
			rotation = (rotation + (360 / slices)) % 360;
		}
		private function draw(colors:uint = 0xffffff):void {
			var i:int = slices;
			var degrees:int = 360 / slices;
			while (i--) {
				var slice:Shape = getSlice(colors);
				slice.alpha = Math.max(0.2, 1 - (0.1 * i));
				var radianAngle:Number = (degrees * i) * Math.PI / 180;
				slice.rotation = -degrees * i;
				slice.x = Math.sin(radianAngle) * radius;
				slice.y = Math.cos(radianAngle) * radius;
				addChild(slice);
			}
		}
		private function getSlice(colors:uint = 0xffffff):Shape {
			var slice:Shape = new Shape();
			slice.graphics.beginFill(colors);
			slice.graphics.drawRoundRect(-1, 0, 2, 6, 12, 12);
			slice.graphics.endFill();
			return slice;
		}
	}
}