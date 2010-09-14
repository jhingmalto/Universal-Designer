package com.core
{
	import com.mpt.controls.tilelist.Cell;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import org.svgweb.core.SVGViewer;

	/**
	* ...
	 * @author mykhel
	 */
	public interface iArt 
	{
		function loadSvgAt(cell:Cell, urlSvg:String):void 
		
		

		function get svgViewer():SVGViewer
		function set svgViewer(value:SVGViewer):void
		
		function get cell():Cell 
		function set cell(value:Cell):void 
		
	}

}