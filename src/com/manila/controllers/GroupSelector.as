package com.manila.controllers 
{
	import com.manila.views.designer.Design;
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import org.senocular.TransformTool;
	import org.svgweb.core.SVGNode;
	/**
	 * ...
	 * @author mykhel
	 */
	public class GroupSelector
	{
		private var _container:Sprite = new Sprite();
		private var _children:Array = new Array();
		private var _shapesAndSvgs:Array = new Array();
		
		private static  var _instance:GroupSelector;
		public function GroupSelector (singletonEnforcer:SingletonEnforcer):void 
		
		public static function getInstance():GroupSelector {
			if (_instance == null) {
				_instance = new GroupSelector(new SingletonEnforcer());
			}
			return _instance;
		}
		
		public function getInvertedMatrixAt(_activeDesign:Design):Matrix 
		{
			var _designMatrix:Matrix = _activeDesign.transform.concatenatedMatrix.clone();
			var _invertedDesignMatrix:Matrix = _designMatrix.clone();
			_invertedDesignMatrix.invert();
			return _invertedDesignMatrix;
		}
		
		public function select(_tool:TransformTool, _activeDesign:Design):void 
		{
			_tool.target = null;
			_shapesAndSvgs = new Array();
			
			
			var invertedMatrix:Matrix = getInvertedMatrixAt(_activeDesign);
			
			for (var i:int = 0; i < _children.length; i++) 
			{
				var item:* = _children[i];
				var bounds:Rectangle = item.getRect(item);
				
				
				var shp:Shape = new Shape();
				shp.graphics.beginFill(0, .5);
				shp.graphics.drawRect(bounds.x, bounds.y, bounds.width, bounds.height);
				
				
				
				var temp_matrix:Matrix = _children[i].transform.concatenatedMatrix.clone();
				temp_matrix.concat(invertedMatrix);
				
				shp.transform.matrix = temp_matrix.clone();
				
				_container.addChild(shp);
				
				_shapesAndSvgs.push( { shape:shp, svg:_children[i] } );
				
				bounds = null;
				temp_matrix = null;
				
			}
			_tool.target = _container;
			_tool.registration = _tool.boundsCenter;
			
			//_tool.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown, false, 0, true);
			//_tool.stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp , false, 0, true);
			
			invertedMatrix = null;
		}
		
		public function deslect(_tool:TransformTool, svg:SVGNode):void 
		{
			_tool.target = null;
			for (var i:int = 0; i < _shapesAndSvgs.length; i++) 
			{
				var containersShp:Shape = _shapesAndSvgs[i].shape;
				containersShp.scaleX = containersShp.scaleY = 1;
				if (svg == _shapesAndSvgs[i].svg)
				{
					_children.splice(i, 1);
					_shapesAndSvgs[i].shape.parent.removeChild(_shapesAndSvgs[i].shape);
					_shapesAndSvgs.splice(i, 1);
				}
			}
			_tool.target = _container;
			_tool.registration = _tool.boundsCenter;
			
		}
		public function deslectAll(_tool:TransformTool):void 
		{
			_tool.target = null;
			_children = new Array();
			_shapesAndSvgs = new Array();
			
		}
		
		private function onKeyUp(e:KeyboardEvent):void 
		{
			for (var i:int = 0; i < _shapesAndSvgs.length; i++) 
			{
				var containersShp:Shape = _shapesAndSvgs[i].shape;
				containersShp.scaleX = containersShp.scaleY = 1;
			}
		}
		
		private function onKeyDown(e:KeyboardEvent):void 
		{
			for (var i:int = 0; i < _shapesAndSvgs.length; i++) 
			{
				var containersShp:Shape = _shapesAndSvgs[i].shape;
				containersShp.scaleX = containersShp.scaleY = 0;
			}
		}
		
		public function cleanContainer():void 
		{
			while(_container.numChildren > 0) _container.removeChildAt(0);
			_container.transform.matrix = new Matrix();
		}
		
		
		public function get container():Sprite { return _container; }
		public function set container(value:Sprite):void 
		{
			_container = value;
		}
		
		public function get children():Array { return _children; }
		public function set children(value:Array):void 
		{
			_children = value;
		}
		
		public function get shapesAndSvgs():Array { return _shapesAndSvgs; }
		public function set shapesAndSvgs(value:Array):void 
		{
			_shapesAndSvgs = value;
		}
		
		
		
		
	}

}


class SingletonEnforcer { }