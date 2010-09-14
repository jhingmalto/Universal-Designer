package com.manila.views.art
{
	import com.core.iArt;
	import com.manila.models.TabViewModel;
	import com.mpt.controls.tilelist.Cell;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import org.svgweb.core.SVGViewer;
	import org.svgweb.events.SVGEvent;
	
	/**
	 * ...
	 * @author mykhel
	 */
	public class GlyphArt implements iArt
	{
		
		protected var _svgViewer:SVGViewer = new SVGViewer();
		protected var _cell:Cell;
		
		public function GlyphArt():void {}
		
		/* INTERFACE com.core.iArt */
		
		public function loadSvgAt(cell:Cell, urlSvg:String):void
		{
			_cell = cell;
			_cell.hasContent = true;
			
			var url:URLRequest = new URLRequest(urlSvg);
			var loader:URLLoader = new URLLoader();
			loader.load(url);
			loader.addEventListener(Event.COMPLETE, svgLoadCompleted);
			
			url = null;
		}
		
		protected function svgLoadCompleted(e:Event):void 
		{
			e.currentTarget.removeEventListener(Event.COMPLETE, svgLoadCompleted);
			
			var target:* = e.currentTarget;
			var _tabModel:TabViewModel = TabViewModel.getInstance();
			
			var newXML:XML = new XML(target.data);
			var nodes:XMLList = XMLList(newXML).children();
			
			nodes.@["cpbv:x"] = 0;
			nodes.@["cpbv:y"] = 0;
			nodes.@["cpbv:width"] = 100;
			nodes.@["cpbv:height"] = 100;
			nodes.@["cpbv:rotation"] = 0;
			nodes.@["transform"] = "matrix(1,0,0,1,0,0)";
			
			
			_svgViewer.xml = newXML;
			_cell.addEventListener(Event.ENTER_FRAME, enterframes);
			
			nodes = null;
		}
		protected function enterframes(e:Event):void 
		{
			if (_svgViewer.width > 0) {
				_svgViewer.removeEventListener(Event.ENTER_FRAME, enterframes);
				//_cell.addContent(_svgViewer);
				_cell.addSvgToContent(_svgViewer);
				_cell.data.svgViewer = _svgViewer;
				//_svgViewer.dispatchEvent(new Event("svgLoadComplete"));
			}
		}
		
		
		
		
		
		
		public function get svgViewer():SVGViewer { return _svgViewer; }
		public function set svgViewer(value:SVGViewer):void 
		{
			_svgViewer = value;
		}
		
		
		public function get cell():Cell { return _cell; }
		public function set cell(value:Cell):void 
		{
			_cell = value;
		}
	}

}