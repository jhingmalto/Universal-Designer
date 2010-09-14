package com.manila.views.panel.graphicstab 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author mykhel
	 */
	public class UploadsProgress extends MovieClip
	{
		private var _bg:Sprite = new Sprite();
		private var _progress:Sprite = new Sprite();
		
		public function UploadsProgress() 
		{
			_bg.graphics.beginFill(0xffffff);
			_bg.graphics.lineStyle(2)
			_bg.graphics.drawRect(0, 0, 100, 8);
			addChild(_bg);
			
			_progress.graphics.beginFill(0xff);
			_progress.graphics.drawRect(0, 0, 100, 8);
			_progress.scaleX = .01;
			addChild(_progress);
		}
		
		public function get progress():Number 
		{
			return _progress.scaleX;
		}
		public function set progress(value:Number):void 
		{
			_progress.scaleX = value;
		}
		
	}

}