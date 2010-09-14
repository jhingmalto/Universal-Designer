package com.manila.views
{
	import com.manila.controllers.AppController;
	import com.manila.controllers.DesignViewController;
	import com.manila.controllers.MainMenuController;
	import com.manila.models.ThemeManagerModel;
	import com.mpt.display.mButton;
	import flash.display.MovieClip;
	import com.manila.controllers.MainCanvasViewController;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;

	/**
	* ...
	 * @author mykhel
	 */
	public class  MainMenuView extends MovieClip
	{
		protected var _mainCanvasController:MainCanvasViewController;
		protected var _themeManager:ThemeManagerModel;
		protected var _mainMenuController:MainMenuController;
		
		private var _doneBtn:mButton;
		private var _cancelBtn:mButton;
		private var _clearBtn:mButton;
		private var _backBtn:mButton;
		private var _frontBtn:mButton;
		private var _previewBtn:mButton;
		private var _trashBtn:mButton;
		
		private var _hasBack:Boolean;
		
		public function MainMenuView ():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			_mainCanvasController = MainCanvasViewController.getInstance();
			_themeManager = ThemeManagerModel.getInstance();
			_mainMenuController = MainMenuController.getInstance();
			_mainMenuController.mainMenu = this;
			
			
			
			_doneBtn = new mButton();
			_doneBtn.up.addChild(_themeManager.doneBtnUp);
			_doneBtn.over.addChild(_themeManager.doneBtnOver);
			_doneBtn.down.addChild(_themeManager.doneBtnDown);
			//_mainCanvasController.move(_doneBtn, stage.stageWidth - _doneBtn.width - _padding, _padding);
			//addChild(_doneBtn);
			
			_cancelBtn = new mButton();
			_cancelBtn.up.addChild(_themeManager.cancelBtnUp);
			_cancelBtn.over.addChild(_themeManager.cancelBtnOver);
			_cancelBtn.down.addChild(_themeManager.cancelBtnDown);
			//_mainCanvasController.move(_cancelBtn, _doneBtn.x - _cancelBtn.width - _padding, _padding);
			//addChild(_cancelBtn);
			
			_clearBtn = new mButton();
			_clearBtn.up.addChild(_themeManager.clearBtnUp);
			_clearBtn.over.addChild(_themeManager.clearBtnOver);
			_clearBtn.down.addChild(_themeManager.clearBtnDown);
			//_mainCanvasController.move(_clearBtn, _cancelBtn.x - _clearBtn.width - _padding, _padding);
			//addChild(_clearBtn);
			
			_backBtn = new mButton();
			_backBtn.up.addChild(_themeManager.viewbackBtnUp);
			_backBtn.over.addChild(_themeManager.viewbackBtnOver);
			_backBtn.down.addChild(_themeManager.viewbackBtnDown);
			//_mainCanvasController.move(_backBtn, _padding, _padding);
			//addChild(_backBtn);
			
			_frontBtn = new mButton();
			_frontBtn.up.addChild(_themeManager.viewfrontBtnUp);
			_frontBtn.over.addChild(_themeManager.viewfrontBtnOver);
			_frontBtn.down.addChild(_themeManager.viewfrontBtnDown);
			_frontBtn.visible = false;
			//_mainCanvasController.move(_frontBtn, _padding, _padding);
			//addChild(_frontBtn);
			
			_previewBtn = new mButton();
			_previewBtn.up.addChild(_themeManager.previewBtnUp);
			_previewBtn.over.addChild(_themeManager.previewBtnOver);
			_previewBtn.down.addChild(_themeManager.previewBtnDown);
			//_mainCanvasController.move(_previewBtn, _padding, _backBtn.y + _backBtn.height + _padding);
			//addChild(_previewBtn);
			
			_trashBtn = new mButton();
			_trashBtn.up.addChild(_themeManager.trashBtnUp);
			_trashBtn.over.addChild(_themeManager.trashBtnOver);
			_trashBtn.down.addChild(_themeManager.trashBtnDown);
			//_mainCanvasController.move(_trashBtn, _padding, stage.stageHeight - _trashBtn.height - _padding);
			//addChild(_trashBtn);
			
			resetPositions();
			_mainCanvasController.populate(this, [_doneBtn, _cancelBtn, _clearBtn, _backBtn, _frontBtn, _previewBtn,_trashBtn]);
			_mainMenuController.initListeners();
		}
		
		private function resetPositions():void 
		{
			var _padding:Number = _mainCanvasController.PADDING;
			_mainCanvasController.move(_doneBtn, stage.stageWidth - _doneBtn.width - _padding, _padding);
			_mainCanvasController.move(_cancelBtn, _doneBtn.x - _cancelBtn.width - _padding, _padding);
			_mainCanvasController.move(_clearBtn, _cancelBtn.x - _clearBtn.width - _padding, _padding);
			if(hasBack) {
				_mainCanvasController.move(_backBtn, _padding, _padding);
				_mainCanvasController.move(_frontBtn, _padding, _padding);
				_mainCanvasController.move(_previewBtn, _padding, _backBtn.y + _backBtn.height + _padding);
				_mainCanvasController.move(_trashBtn, _padding, stage.stageHeight - _trashBtn.height - _padding);
			} else {
				_backBtn.visible = _frontBtn.visible = false;
				_mainCanvasController.move(_previewBtn, _padding, _padding);
				_mainCanvasController.move(_trashBtn, _padding, stage.stageHeight - _trashBtn.height - _padding);
			}
			
		}
		
		
		public function callResize(stage:Object):void 
		{
			if (stage.stageWidth > 1100 && stage.stageHeight > 600) {
				var _padding:Number = _mainCanvasController.PADDING;
				_mainCanvasController.move(_doneBtn, stage.stageWidth - _doneBtn.width - _padding, _padding);
				_mainCanvasController.move(_cancelBtn, _doneBtn.x - _cancelBtn.width - _padding, _padding);
				_mainCanvasController.move(_clearBtn, _cancelBtn.x - _clearBtn.width - _padding, _padding);
				_mainCanvasController.move(_trashBtn, _padding, stage.stageHeight - _trashBtn.height - _padding);
			}
		}
		
		public function get doneBtn():mButton { return _doneBtn; }
		public function set doneBtn(value:mButton):void 
		{
			_doneBtn = value;
		}
		
		public function get cancelBtn():mButton { return _cancelBtn; }
		public function set cancelBtn(value:mButton):void 
		{
			_cancelBtn = value;
		}
		
		public function get clearBtn():mButton { return _clearBtn; }
		public function set clearBtn(value:mButton):void 
		{
			_clearBtn = value;
		}
		
		public function get backBtn():mButton { return _backBtn; }
		public function set backBtn(value:mButton):void 
		{
			_backBtn = value;
		}
		
		public function get previewBtn():mButton { return _previewBtn; }
		public function set previewBtn(value:mButton):void 
		{
			_previewBtn = value;
		}
		
		public function get trashBtn():mButton { return _trashBtn; }
		public function set trashBtn(value:mButton):void 
		{
			_trashBtn = value;
		}
		
		public function get frontBtn():mButton { return _frontBtn; }
		public function set frontBtn(value:mButton):void 
		{
			_frontBtn = value;
		}
		
		public function get hasBack():Boolean { return _hasBack; }
		
		public function set hasBack(value:Boolean):void 
		{
			_hasBack = value;
		}
	}

}