package com.manila.controllers 
{
	import com.manila.views.designer.Design;
	import com.manila.views.MainMenuView;
	import flash.events.MouseEvent;
	import org.svgweb.core.SVGNode;
	/**
	 * ...
	 * @author mykhel
	 */
	public class MainMenuController
	{
		private var _mainMenu:MainMenuView;
		
		private static  var _instance:MainMenuController;
		public function MainMenuController(singletonEnforcer:SingletonEnforcer) { }
		public static function getInstance():MainMenuController {
			if (_instance == null) {
				_instance = new MainMenuController(new SingletonEnforcer());
			}
			return _instance;
		}
		
		
		/**
		 * Add listeners for DONE, CLEAR, TRASH, BACK, FRONT
		 */
		public function initListeners():void 
		{
			_mainMenu.doneBtn.addEventListener(MouseEvent.MOUSE_DOWN, onDone);
			_mainMenu.clearBtn.addEventListener(MouseEvent.MOUSE_DOWN, onClear);
			_mainMenu.trashBtn.addEventListener(MouseEvent.MOUSE_DOWN, onTrash);
			_mainMenu.backBtn.addEventListener(MouseEvent.MOUSE_DOWN, onBack);
			_mainMenu.frontBtn.addEventListener(MouseEvent.MOUSE_DOWN, onfront);
		}
		
		/**
		 * Hide the back canvas designer
		 * Show the front canvas designer
		 * @param	e
		 */
		private function onfront(e:MouseEvent):void 
		{
			_mainMenu.frontBtn.visible = false;
			_mainMenu.backBtn.visible = true;
			MainCanvasViewController.getInstance().getCanvasDesignerByName("front").visible = true;
			MainCanvasViewController.getInstance().getCanvasDesignerByName("back").visible = false;
			GroupSelector.getInstance().deslectAll(_activeDesign.tool);
		}
		
		/**
		 * Hide the front canvas designer
		 * Show the back canvas designer
		 * @param	e
		 */
		private function onBack(e:MouseEvent):void 
		{
			_mainMenu.frontBtn.visible = true;
			_mainMenu.backBtn.visible = false;
			MainCanvasViewController.getInstance().getCanvasDesignerByName("front").visible = false;
			MainCanvasViewController.getInstance().getCanvasDesignerByName("back").visible = true;
			GroupSelector.getInstance().deslectAll(_activeDesign.tool);
		}
		
		private function onTrash(e:MouseEvent):void 
		{
			if (!_activeDesign.tool.target) return;
			
			var shapesAndSvgs:Array = GroupSelector.getInstance().shapesAndSvgs
			for (var i:int = 0; i < shapesAndSvgs.length; i++) 
			{
				_activeDesign.svgViewer.svgRoot.removeSVGChild(SVGNode(shapesAndSvgs[i].svg));
			}
			
			if (shapesAndSvgs.length == 0) _activeDesign.svgViewer.svgRoot.removeSVGChild(SVGNode(_activeDesign.tool.target));
			
			_activeDesign.tool.target = null;
		}
		
		private function onClear(e:MouseEvent):void 
		{
			for (var i:int = 0; i < _activeDesign.designElements.length; i++) 
			{
				_activeDesign.svgViewer.svgRoot.removeSVGChild(_activeDesign.designElements[i]);
			}
			_activeDesign.tool.target = null;
		}
		
		private function onDone(e:MouseEvent):void 
		{
			//AppController.getInstance().saveDesignFrontOnly("Images", _activeDesign.svgXML);
			//_app.saveDesign("CP-CustomProductDesigns", _activeDesign.svgXML.toString());
			//_app.saveProject();
			AppController.getInstance().saveProject();
		}
		
		public function get mainMenu():MainMenuView { return _mainMenu; }
		public function set mainMenu(value:MainMenuView):void 
		{
			_mainMenu = value;
		}
		
		protected function get _activeDesign():Design 
		{
			return DesignViewController.getInstance().activeDesign; 
		}
		
	}

}


class SingletonEnforcer { }
