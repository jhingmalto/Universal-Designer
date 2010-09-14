package com.manila.views.designer
{
	import com.manila.controllers.DesignViewController;
	import com.manila.controllers.GroupSelector;
	import com.manila.models.TabViewModel;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventPhase;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import org.senocular.TransformTool;
	import org.svgweb.core.SVGNode;
	import org.svgweb.core.SVGViewer;
	import org.svgweb.events.SVGEvent;
	import org.svgweb.nodes.SVGFontFaceNode;
	import org.svgweb.nodes.SVGFontNode;
	import org.svgweb.nodes.SVGSVGNode;
	import org.svgweb.nodes.SVGTextNode;

	/**
	* ...
	 * @author mykhel
	 */
	public class  Design extends MovieClip
	{
		
		protected var _tabModel:TabViewModel;
		protected var _groupSelector:GroupSelector;
		
		private var border:Sprite;
		
		private var _svgXML:XML;
		
		private var _svgItems:Array;
		
		private var _svgViewer:SVGViewer;
		
		private var _scale:Number;
		
		private var _tool:TransformTool;
		private var _selectedSVG:SVGNode;
		private var _hasContent:Boolean;
		
		private var _designElements:Array = new Array();
		
		
		public function Design ($w:Number, $h:Number):void 
		{
			//create _tabModel instance
			_tabModel = TabViewModel.getInstance();
			// create _groupSelector instance
			_groupSelector = GroupSelector.getInstance();
			
			
			// create border sprite
			border = new Sprite();
			border.graphics.beginFill(0, 0);
			border.graphics.lineStyle(1, 0, .5);
			border.graphics.drawRect(0 , 0 , $w, $h );
			addChild(border);
			border.addEventListener(MouseEvent.MOUSE_DOWN, deselectAll);
			
			
			//addChild(_groupSelector.container);
			
			// create Designer's svgXML instance
			// this is the svg root of all svg nodes...
			svgXML = new XML()
			svgXML = <svg:svg cpbv:version="1.0" cpbv:libraryIds="" width="380" height="380" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:cc="http://web.resource.org/cc/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:svg="http://www.w3.org/2000/svg" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:cpbv="http://www.cafepress.com/splash" >
			
</svg:svg>;

			// set width and height of svgXML
			svgXML.@width = $w;
			svgXML.@height = $h;
			
			// create _svgItems instance
			_svgItems = new Array();
			
			// create _svgViewer instance with svgRoot svgXML;
			_svgViewer = new SVGViewer();
			_svgViewer.xml = svgXML;
			_svgViewer.x = 0;
			_svgViewer.y = 0;
			addChild(_svgViewer);
			
			// *********************
			// create _tool instance
			// *********************
			// use TransformTool
			_tool = new TransformTool();
			_tool.raiseNewTargets = false;
			//_tool.constrainScale = true;
			_tool.skewEnabled = false;
			addChild(_tool);
			_tool.addEventListener("newTarget", newTarget);
			_tool.addEventListener("controlUp", controlUp);
			//_tool.addEventListener("transformTool", transformTool);
			//_tool.addEventListener("controlPreference", controlPreference);
			_tool.addEventListener("controlMove", controlMove);
			//_tool.addEventListener("controlDown", controlDown);
			
			
		}
		
		
		private function newTarget(e:Event):void 
		{
			if (!_tool.target) _groupSelector.cleanContainer(); 
		}
		private function controlUp(e:Event):void 
		{
			controlMove(null);
			for (var i:int = 0; i < _groupSelector.children.length; i++) 
			{
				var _targetNode:SVGNode = SVGNode(_groupSelector.children[i]);
				var _nodeRect:Rectangle = _targetNode.getRect(_targetNode.parent);
				var newXML:XML = SVGNode(_targetNode).xml;
				
				
				var temp_matrix:Matrix = _targetNode.transform.concatenatedMatrix.clone();
				temp_matrix.concat(_groupSelector.getInvertedMatrixAt(this));
				
				
				var mtrx:Matrix = temp_matrix.clone();
				
				newXML.@["cpbv:x"] = mtrx.tx;
				newXML.@["cpbv:y"] = mtrx.ty;
				newXML.@["cpbv:width"] = _nodeRect.width;
				newXML.@["cpbv:height"] = _nodeRect.height;
				newXML.@["cpbv:rotation"] = _targetNode.rotation;
				newXML.@["transform"] = "matrix(" + mtrx.a + "," + mtrx.b +"," + mtrx.c +"," + mtrx.d + "," + mtrx.tx + "," + mtrx.ty + ")";
				
				
				_targetNode.xml = newXML;
				
				temp_matrix = null;
			} 
			
		}
		private function controlMove(e:Event): void
		{
			for (var i:int = 0; i < _groupSelector.shapesAndSvgs.length; i++) 
			{
				var containersSvg:SVGNode = _groupSelector.shapesAndSvgs[i].svg;
				var containersShp:Shape = _groupSelector.shapesAndSvgs[i].shape;
				var shapesConcatenatedMatrix:Matrix = containersShp.transform.concatenatedMatrix.clone();
				var parent_matrix:Matrix = containersSvg.parent.transform.concatenatedMatrix.clone();
				
				parent_matrix.invert();
				shapesConcatenatedMatrix.concat(parent_matrix);
				containersSvg.transform.matrix = shapesConcatenatedMatrix;
				
				shapesConcatenatedMatrix = null;
				parent_matrix = null;
			}
			
		}
		
		
		private function deselectAll(e:MouseEvent):void 
		{
			_groupSelector.deslectAll(_tool);
			
		}
		
		
		
		public function addItem($svg:SVGViewer, obj:Object):void 
		{
			var $x:Number = obj.x;
			var $y:Number = obj.y;
			
			var xmlNs:Namespace = new Namespace("http://www.w3.org/2000/svg");
			var xml:XML = XML($svg.svgRoot.xml);
			var node:XML = new XML(xml.xmlNs::g);
			
			node.@["cpbv:x"] = $x;
			node.@["cpbv:y"] = obj.y;
			node.@["cpbv:width"] = obj.width;
			node.@["cpbv:height"] = obj.height;
			node.@["cpbv:rotation"] = 0;
			node.@["transform"] = "matrix(1,0,0,1," + (obj.x - obj.width / 2) + "," + (obj.y - obj.height / 2) + ")";
			
			
            /*for each (var childXML:XML in this._xml.children()) {
                //if (childXML.nodeKind() == 'element') {
                    // If we support text values then set them
                    //if (this.hasText()) {
                        if (childXML.localName() == 'path' && childXML.children().length() > 0) {
                            // for the SVGViewerWeb we use a nested
                            // SVGDOMTextNode to store the actual value; this
                            // class is necessary so that we can do text
                            // node detection in the browser and have a unique
                            // GUID per DOM text node
                            text += childXML.children().toString();
                        }
                    //}
//
                    //var newChildNode:SVGNode = this.parseNode(childXML);
                    //if (!newChildNode) {
                        //this.dbg("did not add object!:" + childXML.localName());
                        //continue;
                    //}
                    //SVGNode.addSVGChild(viewBoxSprite, newChildNode);
                //} else if (childXML.nodeKind() == 'text'
                           //&& this.hasText()) {
                    //text = this._xml.text().toString();
                //}  
            }
            */
			
			
			
			var svgNode:SVGNode = $svg.svgRoot.parseNode(node);
			svgNode.addEventListener(MouseEvent.MOUSE_DOWN, svgNodeMouseDown, false, 0, true);
			
			
			_svgViewer.svgRoot.appendSVGChild(svgNode);
			
			svgNode.name = obj.name;
			_designElements.push(svgNode);
			
			xmlNs = null;
			node = null;
			svgNode = null;
		} 
		
		public function addText($svg:SVGViewer, obj:Object):void 
		{
			var $x:Number = obj.x;
			var $y:Number = obj.y;
			
			var xmlNs:Namespace = new Namespace("http://www.w3.org/2000/svg");
			var xml:XML = XML($svg.svgRoot.xml);
			var node:XML = new XML(xml.xmlNs::g);
			node.@["cpbv:x"] = $x;
			node.@["cpbv:y"] = $y; 
			node.@["cpbv:text-scale"] = _tabModel.fontScale;
			node.@["cpbv:text-color"] = _tabModel.fontColor;
			node.@["cpbv:text-face"] = _tabModel.fontFamily;
			node.@["cpbv:font-size"] = _tabModel.fontSize;
			node.@["transform"] = "matrix(" + _tabModel.fontScale + ",0,0," + _tabModel.fontScale + "," + (obj.x - obj.width / 2) + "," + (obj.y - obj.height / 2) + ")";
			node.@["font-size"] = _tabModel.fontSize;
			node.@["font-family"] = _tabModel.fontFamily;
			node.@["fill"] = "#" + _tabModel.fontColor.toString(16);
			
			
			
			var svgNode:SVGNode = $svg.svgRoot.parseNode(node);
			svgNode.addEventListener(MouseEvent.MOUSE_DOWN, svgNodeMouseDown, false, 0, true);
			
			//var svgFont:SVGFontNode = new SVGFontNode(svgNode.svgRoot, node);
			//svgFont.setFontFaceName("Arial");
			
			_svgViewer.svgRoot.appendSVGChild(svgNode);
			
			svgNode.name = "text";
			_designElements.push(svgNode);
			
			
			
			
			_selectedSVG = svgNode;
			
			xmlNs = null;
			node = null;
		}
		
		
		
		public function editText(text:String):void 
		{
			var _targetNode:SVGNode = SVGNode(_selectedSVG);
			var node:XML = SVGNode(_selectedSVG).xml;
			
			var xmlNs:Namespace = Namespace("http://www.w3.org/2000/svg");
			node.xmlNs::text = text;
			
			_targetNode.xml = node;
			
		}
		
		private function svgNodeMouseDown(e:MouseEvent):void 
		{
			var $target:DisplayObject = e.currentTarget as DisplayObject;
			if (e.shiftKey) {
				if (_groupSelector.children.length == 1) {
					addChildAt(_groupSelector.container, getChildIndex(_tool) - 1);
				}
					
				if(_groupSelector.children.indexOf(e.currentTarget) == -1)
				{
					_groupSelector.children.push(e.currentTarget);
					_groupSelector.select(_tool, this);
				} else 
				{
					//_groupSelector.deslect(_tool, e.currentTarget as SVGNode);
				}
			} else {
				_groupSelector.cleanContainer();
				_groupSelector.children = new Array();
				_groupSelector.shapesAndSvgs = new Array();
				
				_groupSelector.children.push(e.currentTarget);
				
				_tool.target = $target;
				
				_tool.registration =_tool.boundsCenter;
				_selectedSVG = SVGNode(e.currentTarget);
				
			}
		}
		
		
		
		public function get svgXML():XML { return _svgXML; }
		public function set svgXML(value:XML):void 
		{
			_svgXML = value;
		}
		
		public function get svgViewer():SVGViewer { return _svgViewer; }
		public function set svgViewer(value:SVGViewer):void 
		{
			_svgViewer = value;
		}
		
		public function get designElements():Array { return _designElements; }
		public function set designElements(value:Array):void 
		{
			_designElements = value;
		}
		
		public function get selectedSVG():SVGNode { return _selectedSVG; }
		public function set selectedSVG(value:SVGNode):void 
		{
			_selectedSVG = value;
		}
		
		public function get tool():TransformTool { return _tool; }
		public function set tool(value:TransformTool):void 
		{
			_tool = value;
		}
		
		public function get hasContent():Boolean { 
			if (svgXML.children().length() > 0) _hasContent = true;
			else _hasContent = false;
			return _hasContent; 
		}
		
		
		
	}

}