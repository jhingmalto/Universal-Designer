package com.manila.controllers
{
	import com.manila.models.TabViewModel;
	import com.manila.views.designer.Design;
	import com.manila.views.MainCanvas;
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import org.svgweb.core.SVGNode;
	import org.svgweb.core.SVGViewer;
	import org.svgweb.nodes.SVGSVGNode;

	/**
	 * Public functions used for design.
	 * @method:
	 * activeDesign 		- read only
	 * changeBorderWidth
	 * changeBorder
	 * changeShapeFill
	 * changeShapeFillStyle	
	 * changeTextFill
	 * changeTextFont
	 * changeGlypartsFill 	- for single color only
	 * @author mykhel
	 */
	public class  DesignViewController
	{
		private static  var _instance:DesignViewController;
		public function DesignViewController (singletonEnforcer:SingletonEnforcer):void 
		public static function getInstance():DesignViewController {
			if (_instance == null) {
				_instance = new DesignViewController(new SingletonEnforcer());
			}
			return _instance;
		}
		
		/**
		 * Return the current active design
		 */
		public function get activeDesign():Design { 
			var _mainCanvasController:MainCanvasViewController = MainCanvasViewController.getInstance();
			if (_mainCanvasController.getCanvasDesignerByName("back").visible)
			{
				return _mainCanvasController.getCanvasDesignerByName("back").design;
			}
			return _mainCanvasController.getCanvasDesignerByName("front").design;
		}
		
		
		/**
		 * Change the border/stroke width of single/group shapes.
		 * @param	u - width
		 */
		public function changeBorderWidth(u:uint):void 
		{
			if (!activeDesign.tool.target) return;
			
			// for group select
			var shapesAndSvgs:Array = GroupSelector.getInstance().shapesAndSvgs;
			for (var i:int = 0; i < shapesAndSvgs.length; i++) 
			{
				var _targetNode:SVGNode = SVGNode(shapesAndSvgs[i].svg);
				if (_targetNode.name == "shapes") 
				{
					var newXML:XML = _targetNode.xml;
					newXML.@["cpbv:stroke-width"] = u;
					newXML.@["cpbv:stroke-opacity"] = u;
					newXML.@["stroke-width"] = u;
					newXML.@["stroke-opacity"] = u;
					_targetNode.xml = newXML;
					
					newXML = null;
				}
			}
			
			// for single select
			if (shapesAndSvgs.length == 0 && SVGNode(activeDesign.tool.target).name == "shapes") 
			{
				_targetNode = SVGNode(activeDesign.tool.target);
				newXML = _targetNode.xml;
				newXML.@["cpbv:stroke-width"] = u;
				newXML.@["cpbv:stroke-opacity"] = u;
				newXML.@["stroke-width"] = u;
				newXML.@["stroke-opacity"] = u;
				_targetNode.xml = newXML;
				
				newXML = null;
			}
			
		}
		
		/**
		 * Change the border/stroke color of single/group shapes.
		 * @param	u - border/stroke color
		 */
		public function changeBorder(u:uint):void 
		{
			if (!activeDesign.tool.target) return;
			
			// for group select
			var shapesAndSvgs:Array = GroupSelector.getInstance().shapesAndSvgs;
			for (var i:int = 0; i < shapesAndSvgs.length; i++) 
			{
				var _targetNode:SVGNode = SVGNode(shapesAndSvgs[i].svg);
				if (_targetNode.name == "shapes")
				{
					var newXML:XML = _targetNode.xml;
					newXML.@["cpbv:stroke-color"] = u;
					newXML.@["stroke"] = "#" + u.toString(16);
					newXML.@["stroke-color"] = u;
					_targetNode.xml = newXML;
					
					newXML = null;
				}
			}
			
			// for single select
			if (shapesAndSvgs.length == 0 && SVGNode(activeDesign.tool.target).name == "shapes")
			{
				_targetNode = SVGNode(activeDesign.tool.target);
				newXML = _targetNode.xml;
				newXML.@["cpbv:stroke-color"] = u;
				newXML.@["stroke"] = "#" + u.toString(16);
				newXML.@["stroke-color"] = u;
				_targetNode.xml = newXML;
				
				newXML = null;
			}
			
		}
		
		/**
		 * Change the fill color of single/group shapes.
		 * @param	u
		 */
		public function changeShapeFill(u:uint):void 
		{
			if (!activeDesign.tool.target) return;
			
			// for group select
			var shapesAndSvgs:Array = GroupSelector.getInstance().shapesAndSvgs;
			for (var i:int = 0; i < shapesAndSvgs.length; i++) 
			{
				var _targetNode:SVGNode = SVGNode(shapesAndSvgs[i].svg);
				if (_targetNode.name == "shapes")
				{
					var newXML:XML = _targetNode.xml;
					newXML.@["cpbv:fill-color"] = u;
					newXML.@["fill"] = "#" + u.toString(16); 
					newXML.@["fill-color"] = u;
					_targetNode.xml = newXML;
					
					newXML = null;
				}
			}
			
			// for single select
			if (shapesAndSvgs.length == 0 && SVGNode(activeDesign.tool.target).name == "shapes")
			{
				_targetNode = SVGNode(activeDesign.tool.target);
				newXML = _targetNode.xml;
				newXML.@["cpbv:fill-color"] = u;
				newXML.@["fill"] = "#" + u.toString(16); 
				newXML.@["fill-color"] = u;
				_targetNode.xml = newXML;
				
				newXML = null;
			}
			
		}
		
		
		/**
		 * Change the fill style of single/group shapes.
		 * @param	s - "none" or "solid"
		 */
		public function changeShapeFillStyle(s:String):void 
		{
			if (!activeDesign.tool.target) return;
			
			// for group select
			var shapesAndSvgs:Array = GroupSelector.getInstance().shapesAndSvgs;
			for (var i:int = 0; i < shapesAndSvgs.length; i++) 
			{
				var _targetNode:SVGNode = SVGNode(shapesAndSvgs[i].svg);
				if (_targetNode.name == "shapes")
				{
					var newXML:XML = _targetNode.xml;
					newXML.@["cpbv:fill-style"] = s;
					newXML.@["cpbv:fill-opacity"] = (s == "solid" ? 1 : 0);
					newXML.@["fill-style"] = s;
					newXML.@["fill-opacity"] = (s == "solid" ? 1 : 0);
					_targetNode.xml = newXML;
					
					newXML = null;
				}
			}
			
			// for single select
			if (shapesAndSvgs.length == 0 && SVGNode(activeDesign.tool.target).name == "shapes")
			{
				_targetNode = SVGNode(activeDesign.tool.target);
				newXML = _targetNode.xml;
				newXML.@["cpbv:fill-style"] = 2;
				newXML.@["cpbv:fill-opacity"] = (s == "solid" ? 1 : 0);
				newXML.@["fill-style"] = s;
				newXML.@["fill-opacity"] = (s == "solid" ? 1 : 0);
				_targetNode.xml = newXML;
				
				newXML = null;
			}
			
		}
		
		public function changeTextFill(u:uint):void 
		{
			if (!activeDesign.tool.target) return;
			
			// for group select
			var shapesAndSvgs:Array = GroupSelector.getInstance().shapesAndSvgs;
			for (var i:int = 0; i < shapesAndSvgs.length; i++) 
			{
				var _targetNode:SVGNode = SVGNode(shapesAndSvgs[i].svg);
				if (_targetNode.name == "text")
				{
					var newXML:XML = _targetNode.xml;
					newXML.@["cpbv:text-color"] = u;
					newXML.@["fill"] = "#" + u.toString(16); 
					_targetNode.xml = newXML;
					
					newXML = null;
				}
			}
			
			// for single select
			if (shapesAndSvgs.length == 0 && SVGNode(activeDesign.tool.target).name == "text")
			{
				_targetNode = SVGNode(activeDesign.tool.target);
				newXML = _targetNode.xml;
				newXML.@["cpbv:text-color"] = u;
				newXML.@["fill"] = "#" + u.toString(16); 
				_targetNode.xml = newXML;
				
				newXML = null;
			}
			
		}
		
		public function changeTextFont(s:String):void 
		{
			if (!activeDesign.tool.target) return;
			
			// for group select
			var shapesAndSvgs:Array = GroupSelector.getInstance().shapesAndSvgs;
			for (var i:int = 0; i < shapesAndSvgs.length; i++) 
			{
				var _targetNode:SVGNode = SVGNode(shapesAndSvgs[i].svg);
				if (_targetNode.name == "text")
				{
					var newXML:XML = _targetNode.xml;
					newXML.@["cpbv:text-face"] = s;
					newXML.@["font-family"] = s;
					_targetNode.xml = newXML;
					
					newXML = null;
				}
			}
			
			// for single select
			if (shapesAndSvgs.length == 0 && SVGNode(activeDesign.tool.target).name == "text")
			{
				_targetNode = SVGNode(activeDesign.tool.target);
				newXML = _targetNode.xml;
				newXML.@["cpbv:text-face"] = s;
				newXML.@["font-family"] = s;
				_targetNode.xml = newXML;
				
				newXML = null;
			}
			
		}
		
		public function changeGlyphartsFill(u:uint):void 
		{
			if (!activeDesign.tool.target) return;
			
			// for group select
			var shapesAndSvgs:Array = GroupSelector.getInstance().shapesAndSvgs;
			for (var i:int = 0; i < shapesAndSvgs.length; i++) 
			{
				var _targetNode:SVGNode = SVGNode(shapesAndSvgs[i].svg);
				if (_targetNode.name == "glyhpart")
				{
					var newXML:XML = _targetNode.xml;
					newXML.@["cpbv:fill-color"] = u;
					newXML.@["fill"] = "#" + u.toString(16); 
					newXML.@["fill-color"] = u;
					_targetNode.xml = newXML;
					
					newXML = null;
				}
			}
			
			// for single select
			if (shapesAndSvgs.length == 0 && SVGNode(activeDesign.tool.target).name == "glyhpart")
			{
				_targetNode = SVGNode(activeDesign.tool.target);
				newXML = _targetNode.xml;
				newXML.@["cpbv:fill-color"] = u;
				newXML.@["fill"] = "#" + u.toString(16); 
				newXML.@["fill-color"] = u;
				_targetNode.xml = newXML;
				
				newXML = null;
			}
			/*
			if (activeDesign.tool.target.name == "glyhpart") return;
			var _targetNode:SVGNode = SVGNode(activeDesign.tool.target);
			var newXML:XML = _targetNode.xml;
			newXML.@["cpbv:fill-color"] = u;
			newXML.@["fill"] = "#" + u.toString(16); 
			newXML.@["fill-color"] = u;
			
			
			_targetNode.xml = newXML;
			
			newXML = null;*/
		}
		
		
		/**
		 * Convert image to SVGViewer.
		 * Use to add svg image in designers.
		 * @param	imgLink
		 * @param	$w
		 * @param	$h
		 * @return 	SVGViewer
		 */
		public function imageToSVG(imgLink:String, $w:Number, $h:Number):SVGViewer 
		{
			var xml:XML = new XML('<svg:svg cpbv:version="1.0" cpbv:libraryIds="" width="' + $w + '" height="' + $h + '" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:cc="http://web.resource.org/cc/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:svg="http://www.w3.org/2000/svg" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:cpbv="http://www.cafepress.com/splash">' +
   '<svg:g cpbv:editable="NaN" cpbv:true-width="30" cpbv:true-height="30" cpbv:library-id="" cpbv:image-name="'+imgLink+'">' +
   '<svg:image width="' + $w + '" x="0" height="' + $h +'" y="0" transform="translate(0,0) rotate(0)" xlink:href="'+imgLink+'"/>' +
  '</svg:g></svg:svg>');
 
			var svgNode:SVGViewer = new SVGViewer();
			svgNode.xml = xml;
			
			return svgNode;
		}
		
		
		
		
		
	}

}

class SingletonEnforcer { }