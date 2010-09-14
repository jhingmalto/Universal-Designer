package com.manila.views.panel 
{
	import com.manila.controllers.AppController;
	import com.manila.controllers.DesignViewController;
	import com.manila.controllers.MainCanvasViewController;
	import com.manila.models.ThemeManagerModel;
	import com.manila.views.art.ShapeArt;
	import com.manila.views.designer.Design;
	import com.manila.views.MainCanvas;
	import com.manila.views.panel.graphicstab.GlyphartsPanel;
	import com.manila.views.panel.graphicstab.UploadsPanel;
	import flash.events.Event;
	//import com.manila.views.panel.searchbox.SearchBox;
	import flash.display.Bitmap;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import org.svgweb.core.SVGViewer;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author mykhel
	 */
	public class GraphicsPanel extends MovieClip
	{
		
		private var _glypartsPanel:GlyphartsPanel;
		private var _uploadsPanel:UploadsPanel;
		
		
		public var _isPictureLibraryLoad:Boolean = false;
		public var _isGlyphartLibraryLoad:Boolean = false;
		
		
		public function GraphicsPanel(w:Number) 
		{
			_uploadsPanel = new UploadsPanel();
			_uploadsPanel.x = 10;
			_uploadsPanel.y = 10;
			addChild(_uploadsPanel);
			
			
			
			_glypartsPanel = new GlyphartsPanel();
			_glypartsPanel.x = 10;
			_glypartsPanel.y = 60;
			addChild(_glypartsPanel);
			
			_uploadsPanel.addEventListener("onUploadsOpen", onUploadsOpen);
			_glypartsPanel.addEventListener("onGlyphartsOpen", onGlyphartsOpen);
			
		}
		
		private function onUploadsOpen(e:Event):void 
		{
			_glypartsPanel.y = _uploadsPanel.y + _uploadsPanel.height + 10;
			_glypartsPanel.hideLibrary();
		}
		
		private function onGlyphartsOpen(e:Event):void 
		{
			_glypartsPanel.y = 60;
			_uploadsPanel.hideLibrary();
		}
		
		
		
		
		
		public function get uploadsPanel():UploadsPanel { return _uploadsPanel; }
	}

}