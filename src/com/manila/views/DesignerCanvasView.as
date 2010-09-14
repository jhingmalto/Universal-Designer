package com.manila.views
{
	import com.manila.controllers.GroupSelector;
	import com.manila.controllers.MainCanvasViewController;
	import com.manila.controllers.TabViewController;
	import com.manila.views.designer.Design;
	import com.manila.views.designer.Product;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;

	/**
	* ...
	 * @author mykhel
	 */
	public class  DesignerCanvasView extends MovieClip
	{
		protected var _product:Product;
		protected var _design:Design;
		protected var _mainCanvasController:MainCanvasViewController;
		protected var _tabController:TabViewController;
		
		private var _minimumStageWidth:Number = 650;
		private var _minimumStageHeight:Number = 480;
		private var _xoffsetPercent:Number = 0.295;
		private var _yoffsetPercent:Number = 0.13;
		private var _xoffsetDesignAbsolute:Number = 340.2;
		private var _yoffsetDesignAbsolute:Number = 171.52;
		private var _designWidth:Number = 380;
		private var _designHeight:Number = 380;
		private var _shirtScale:Number = 2.4;
		private var _designRegionScale:Number = 0.7163;
		//private var _designRegionScale:Number = 1;
		
		private var _sideName:String;
		
		
		public function DesignerCanvasView():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			_mainCanvasController = MainCanvasViewController.getInstance();
			_tabController = TabViewController.getInstance();
			
			_product = new Product();
			_product.name = this.name;
			
			_design = new Design(_designWidth, _designHeight);
			_design.name = this.name;
			
			_product.addEventListener("productLoadComplete", productLoadComplete);
			
		}
		
		private function productLoadComplete(e:Event):void 
		{
			_product.removeEventListener("productLoadComplete", productLoadComplete);
			
			_mainCanvasController.populate(this, [_product]);
			_mainCanvasController.populate(_product, [_design]);
			
			
			
			_design.x =  _xoffsetDesignAbsolute  
			_design.y = _yoffsetDesignAbsolute 
			
			
			_product.x =- (_design.x + _design.width / 2);
			_product.y = -(_design.y + _design.height / 2);
			
			
			this.x = _tabController.tabMenu.x / 2
			this.y = stage.stageHeight / 2
			
			
			this.scaleX = 1.0;
			this.scaleY = 1.0;
			
			
			//var container:Sprite = GroupSelector.getInstance().container;
			//container.x = _design.x;
			//container.y = _design.y;
			//addChild(container);
			
			
			
		}
		
		
		public function callResize(stage:Object):void 
		{
			
			if (stage.stageWidth > 1100 && stage.stageHeight > 600) {
				this.x = _tabController.tabMenu.x / 2
				this.y = stage.stageHeight / 2
				if(_tabController.tabMenu.x > stage.stageHeight ) {
					this.scaleX = this.scaleY = stage.stageHeight * 1.3 / 700;
				}
			}
			return
			if ( stage.stageHeight > 600 && this.scaleX <= 1.3) { 
				this.width = _tabController.tabMenu.x * 1.2;
				if(this.scaleX > 1.3) this.scaleX = 1.3
				this.scaleY = this.scaleX;
			}
			else if (stage.stageWidth > 1100) { 
				_mainCanvasController.move(this, _tabController.tabMenu.x / 2, 0)
				x -= this.getBounds(this.parent).width / 2 + _xoffsetDesignAbsolute * _xoffsetPercent;
				y -= _yoffsetDesignAbsolute * _yoffsetPercent * this.scaleY;
			}
		}
		
		public function get product():Product { return _product; }
		public function set product(value:Product):void 
		{
			_product = value;
		}
		
		public function get design():Design { return _design; }
		public function set design(value:Design):void 
		{
			_design = value;
		}
		
		public function get designWidth():Number { return _designWidth; }
		public function set designWidth(value:Number):void 
		{
			_designWidth = value;
		}
		
		public function get designHeight():Number { return _designHeight; }
		public function set designHeight(value:Number):void 
		{
			_designHeight = value;
		}
		
		public function get xoffsetDesignAbsolute():Number { return _xoffsetDesignAbsolute; }
		public function set xoffsetDesignAbsolute(value:Number):void 
		{
			_xoffsetDesignAbsolute = value;
		}
		
		public function get yoffsetDesignAbsolute():Number { return _yoffsetDesignAbsolute; }
		public function set yoffsetDesignAbsolute(value:Number):void 
		{
			_yoffsetDesignAbsolute = value;
		}
		
		public function get shirtScale():Number { return _shirtScale; }
		public function set shirtScale(value:Number):void 
		{
			_shirtScale = value;
		}
		
		public function get yoffsetPercent():Number { return _yoffsetPercent; }
		public function set yoffsetPercent(value:Number):void 
		{
			_yoffsetPercent = value;
		}
		
		public function get xoffsetPercent():Number { return _xoffsetPercent; }
		public function set xoffsetPercent(value:Number):void 
		{
			_xoffsetPercent = value;
		}
		
		public function get minimumStageWidth():Number { return _minimumStageWidth; }
		public function set minimumStageWidth(value:Number):void 
		{
			_minimumStageWidth = value;
		}
		
		public function get minimumStageHeight():Number { return _minimumStageHeight; }
		public function set minimumStageHeight(value:Number):void 
		{
			_minimumStageHeight = value;
		}
		
		public function get designRegionScale():Number { return _designRegionScale; }
		public function set designRegionScale(value:Number):void 
		{
			_designRegionScale = value;
		}
		
		public function get sideName():String { return _sideName; }
		public function set sideName(value:String):void 
		{
			_sideName = value;
		}
		
		
	}

}