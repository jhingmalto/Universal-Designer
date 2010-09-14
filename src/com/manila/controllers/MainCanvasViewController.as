package com.manila.controllers 
{
	import com.manila.models.FlashVarsModel;
	import com.manila.views.designer.Design;
	import com.manila.views.designer.Product;
	import com.manila.views.DesignerCanvasView;
	import com.manila.views.MainCanvas;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.ColorTransform;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import com.manila.models.ProductModel;
	/**
	 * ...
	 * @author mykhel
	 */
	public class MainCanvasViewController
	{
		private var _mainCanvas:MainCanvas;
		
		private var _designerCanvasList:Array = new Array();
		
		public var PADDING:Number = 10;
		
		private var _hasBack:Boolean = false;
		private var _hasFront:Boolean = false;
		private var _merchName:String;
		private var _merchColor:uint;
		private var _merchandiseXML:XML;
		
		private static  var _instance:MainCanvasViewController;
		public function MainCanvasViewController(singletonEnforcer:SingletonEnforcer):void
		public static function getInstance():MainCanvasViewController {
			if (_instance == null) _instance = new MainCanvasViewController(new SingletonEnforcer()); 
			return _instance;
		}
		
		
		/**
		 * Auto addchild the children of array in parent movieclip
		 * @param	parent
		 * @param	children
		 */
		public function populate(parent:MovieClip, children:Array):void 
		{
			for (var i:int = 0; i < children.length; i++) 
			{
				MovieClip(parent).addChild(children[i]);
			}
		}
		
		
		/**
		 * Load the merch.xml, use to load the products SWF.
		 * @param	obj
		 */
		public function loadProductMerch(obj:Object):void 
		{
			_hasBack = obj.hasBack;
			_hasFront = obj.hasFront;
			_merchName = obj.merchName;
			_merchColor = uint(FlashVarsModel.getInstance().data.merchColor);
			
			var url:URLRequest = new URLRequest("assets/merch.xml");
			var loader:URLLoader = new URLLoader(url);
			loader.addEventListener(Event.COMPLETE, merchLoadComplete);
			
			url = null;
		}
		private function merchLoadComplete(e:Event):void 
		{
			var merchXML:XML = XML(e.currentTarget.data);
			for (var i:int = 0; i < merchXML.merch.length(); i++) 
			{
				if (_hasFront && _merchName == merchXML.merch.@name[i] && merchXML.merch.@side[i] == "front") {
					var swf:URLRequest = new URLRequest(merchXML.merch.@src[i]);
					var loader:Loader = new Loader();
					loader.load(swf);
					loader.contentLoaderInfo.addEventListener(Event.COMPLETE, frontComplete);
					
					swf = null;
				}
				if (_hasBack && _merchName == merchXML.merch.@name[i] && merchXML.merch.@side[i] == "back") {
					swf = new URLRequest(merchXML.merch.@src[i]);
					loader = new Loader();
					loader.load(swf);
					loader.contentLoaderInfo.addEventListener(Event.COMPLETE, backComplete);
					
					swf = null;
				}
			}
			
			e.currentTarget.removeEventListener(Event.COMPLETE, merchLoadComplete);
			merchXML = null;
		}
		private function frontComplete(e:Event):void 
		{
			var mc:MovieClip = e.currentTarget.content;
			var colorTransform:ColorTransform  =  mc.transform.colorTransform;
			colorTransform.color = _merchColor; 
			mc.getChildAt(0).transform.colorTransform = colorTransform;
			
			getCanvasDesignerByName("front").product.addItem(mc);
			e.currentTarget.removeEventListener(Event.COMPLETE, frontComplete);
			
			
			colorTransform = null;
		}
		private function backComplete(e:Event):void 
		{
			var mc:MovieClip = e.currentTarget.content;
			var colorTransform:ColorTransform  =  mc.transform.colorTransform;
			colorTransform.color = _merchColor; 
			mc.getChildAt(0).transform.colorTransform = colorTransform;
			
			getCanvasDesignerByName("back").product.addItem(mc);
			e.currentTarget.removeEventListener(Event.COMPLETE, backComplete);
			
			colorTransform = null;
		}
		
		
		/**
		 * Get the canvas designer by name. use "front" or "back"
		 * @param	name
		 * @return	DesignerCanvasView
		 */
		public function getCanvasDesignerByName(name:String):DesignerCanvasView 
		{
			for (var i:int = 0; i < _designerCanvasList.length; i++) 
			{
				if (name == _designerCanvasList[i].sideName) 
				{
					return _designerCanvasList[i].canvas;
				}
			}
			return _designerCanvasList[0].canvas;
		}
		
		/**
		 * Get the active product. 
		 * @return	Product 
		 */
		public function get activeProduct():Product
		{
			if (getCanvasDesignerByName("back").visible) return getCanvasDesignerByName("back").product;
			return getCanvasDesignerByName("front").product;
		}
		
		/**
		 * Move the parent (MovieClip) in $x, $y position
		 * @param	parent
		 * @param	$x
		 * @param	$y
		 */
		public function move(parent:MovieClip, $x:Number, $y:Number):void 
		{
			parent.x = $x;
			parent.y = $y;
		}
		
		/**
		 * Get/set MainCanvas.
		 * @return MainCanvas
		 */
		public function get mainCanvas():MainCanvas { return _mainCanvas; }
		public function set mainCanvas(value:MainCanvas):void 
		{
			_mainCanvas = value;
		}
		
		/**
		 * Get/set designer canvas list
		 * @return Array
		 */
		public function get designerCanvasList():Array { return _designerCanvasList; }
		public function set designerCanvasList(value:Array):void 
		{
			_designerCanvasList = value;
		}
		
		/**
		 * Get if the loaded product has back. default is false.
		 */
		public function get hasBack():Boolean { return _hasBack; }
		
		
		/**
		 * Get/set merchadise xml
		 */
		public function get merchandiseXML():XML { return _merchandiseXML; }
		public function set merchandiseXML(value:XML):void 
		{
			_merchandiseXML = value;
		}
		
		
	}

}

class SingletonEnforcer { }
