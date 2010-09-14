package com.manila.views.art
{

	import com.core.iArt;
	import com.mpt.controls.tilelist.Cell;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import org.svgweb.core.SVGViewer;
	//import org.svgweb.SVGViewerFlash;
	
	/**
	* ...
	 * @author mykhel
	 */
	public class  TextArt implements iArt
	{
		
		protected var _svgViewer:SVGViewer = new SVGViewer();
		protected var _cell:Cell;
		protected var _imageViewer:Sprite = new Sprite();
		
		public function TextArt ():void { }
		
		/* INTERFACE com.core.iArt */	
		
		public function loadSvgAt(cell:Cell, urlSvg:String):void {}
		
		public function loadImage(urlImage:String, id:uint):void
		{
			var url:URLRequest = new URLRequest(urlImage);
			var loader:Loader = new Loader();
			loader.load(url);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadImageComplete);
			
			url = null;
			
			function loadImageComplete(e:Event):void 
			{
				e.currentTarget.removeEventListener(Event.COMPLETE, loadImageComplete);
				
				_imageViewer.addChild(e.currentTarget.content);
				_imageViewer.dispatchEvent(new Event("imageLoadComplete"));
			}
			
		}
		
		public function get svgViewer():SVGViewer { return _svgViewer; }
		public function set svgViewer(value:SVGViewer):void 
		{
			_svgViewer = value;
		}
		
		public function get imageViewer():Sprite { return _imageViewer; }
		public function set imageViewer(value:Sprite):void 
		{
			_imageViewer = value;
		}
		
		public function get cell():Cell { return _cell; }
		public function set cell(value:Cell):void 
		{
			_cell = value;
		}
		
	}

}