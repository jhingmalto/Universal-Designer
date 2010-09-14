package com.manila.views.panel.graphicstab 
{
	import com.manila.controllers.AppController;
	import com.manila.controllers.DesignViewController;
	import com.manila.controllers.MainCanvasViewController;
	import com.manila.controllers.TabViewController;
	import com.manila.models.TabViewModel;
	import com.manila.models.ThemeManagerModel;
	import com.manila.views.designer.Design;
	import com.manila.views.MainCanvas;
	import com.mpt.controls.tilelist.Cell;
	import com.mpt.display.mButton;
	import com.mpt.display.mScrollBar;
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import org.svgweb.core.SVGViewer;
	/**
	 * ...
	 * @author mykhel
	 */
	public class UploadsPanel extends MovieClip
	{
		protected var _mainCanvas:MainCanvas;
		protected var _themeManager:ThemeManagerModel;
		
		private var _library:mScrollBar;
		
		private var _uploadBtn:mButton;
		private var _viewUploadedBtn:mButton;
		private var _isActive:Boolean;
		private var _yourUploadsLabel:TextField;
		private var _uploadsProgress:UploadsProgress;
		
		
		
		public function UploadsPanel() 
		{
			_mainCanvas = MainCanvasViewController.getInstance().mainCanvas;
			_themeManager = ThemeManagerModel.getInstance();
			
			_uploadBtn = new mButton();
			_uploadBtn.label = "Upload an image"
			_uploadBtn.setStyle( {
				width:230,
				height:35,
				border:_themeManager.btnColors2.border,
				borderColor:_themeManager.btnColors2.borderColor,
				fontColor:_themeManager.btnColors2.fontColor,
				up:[_themeManager.btnColors2.up, _themeManager.btnColors2.upGradient],
				down:[_themeManager.btnColors2.down, _themeManager.btnColors2.downGradient],
				over:[_themeManager.btnColors2.over, _themeManager.btnColors2.overGradient]
			});
			_uploadBtn.x = 10;
			_uploadBtn.y = 10;
			addChild(_uploadBtn);
			
			_viewUploadedBtn = new mButton();
			_viewUploadedBtn.label = "View Uploaded Image"
			_viewUploadedBtn.setStyle( {
				width:230,
				height:35,
				border:_themeManager.btnColors2.border,
				borderColor:_themeManager.btnColors2.borderColor,
				fontColor:_themeManager.btnColors2.fontColor,
				up:[_themeManager.btnColors2.up, _themeManager.btnColors2.upGradient],
				down:[_themeManager.btnColors2.down, _themeManager.btnColors2.downGradient],
				over:[_themeManager.btnColors2.over, _themeManager.btnColors2.overGradient]
			});
			_viewUploadedBtn.x = 10;
			_viewUploadedBtn.y = 10;
			_viewUploadedBtn.visible = false;
			addChild(_viewUploadedBtn);
			_viewUploadedBtn.addEventListener(MouseEvent.MOUSE_DOWN, initClick);
			
			
			var tf:TextFormat = new TextFormat("Arial", 16, 0x676767, true);
			_yourUploadsLabel = new TextField();
			_yourUploadsLabel.text = "Your Uploads";
			_yourUploadsLabel.selectable = false;
			_yourUploadsLabel.autoSize = "left";
			_yourUploadsLabel.setTextFormat(tf);
			_yourUploadsLabel.x = _uploadBtn.x;
			_yourUploadsLabel.y = _uploadBtn.y + _uploadBtn.height + 5;
			_yourUploadsLabel.visible = false;
			addChild(_yourUploadsLabel);
			
			
			_uploadsProgress = new UploadsProgress();
			_uploadsProgress.x = _yourUploadsLabel.x + _yourUploadsLabel.width + 10;
			_uploadsProgress.y = _yourUploadsLabel.y + 8;
			addChild(_uploadsProgress);
			_uploadsProgress.visible = false;
			
			TabViewController.getInstance().uploadsProgress = _uploadsProgress;
			
			_uploadBtn.addEventListener(MouseEvent.MOUSE_DOWN, initClick);
			
		}
		
		private function onViewUploaded(e:MouseEvent):void 
		{
			//showLibrary();
			//_viewUploadedBtn.removeEventListener(MouseEvent.MOUSE_DOWN, onViewUploaded);
			//_viewUploadedBtn.removeEventListener(MouseEvent.MOUSE_DOWN, onViewUploaded);
			AppController.getInstance().browseBox();
			
			showLibrary();
		}
		
		private function initClick(e:MouseEvent):void 
		{
			_uploadBtn.removeEventListener(MouseEvent.MOUSE_DOWN, initClick);
			_viewUploadedBtn.removeEventListener(MouseEvent.MOUSE_DOWN, initClick);
			
			_library = new mScrollBar(stage);
			_library.setStyle( { knobUp:[_themeManager.btnColors1.up, _themeManager.btnColors1.upGradient, _themeManager.btnColors1.up], 
				knobOver:[_themeManager.btnColors1.over, _themeManager.btnColors1.overGradient], 
				topUp:[_themeManager.btnColors1.up], 
				topOver:[_themeManager.btnColors1.over], 
				bottomUp:[_themeManager.btnColors1.up], 
				bottomOver:[_themeManager.btnColors1.over]
			});
			_library.y = _yourUploadsLabel.y + _yourUploadsLabel.height + 10;
			addChild(_library);
			
			
			_uploadBtn.addEventListener(MouseEvent.MOUSE_DOWN, onViewUploaded);
			_viewUploadedBtn.addEventListener(MouseEvent.MOUSE_DOWN, onViewUploaded);
			
			AppController.getInstance().browseBox();
			
			showLibrary();
		}
		
		public function showLibrary():void 
		{
			_viewUploadedBtn.visible = false;
			if (!_library) return;
			var rect:Rectangle = new Rectangle(0, 0, 265, Math.floor((pictureListItems.length) / 4) * 60 + 60);
			
			_yourUploadsLabel.visible = true;
			_library.visible = true;
			//_library.isActive = true;
			_uploadsProgress.visible = false;
			
			
			_library.setRect(rect);
			
			dispatchEvent(new Event("onUploadsOpen"));
			
			rect = null;
		}
		
		public function hideLibrary():void 
		{
			_viewUploadedBtn.visible = true;
			if (!_library) return;
			_yourUploadsLabel.visible = false;
			_library.visible = false;
			_library.isActive = false;
		}
		
		private var pictureListItems:Array = new Array();
		public function addUploadedImage(img:Bitmap, imgLink:String):void 
		{
			_uploadsProgress.visible = false;
			
			var cx:Number = Math.floor((pictureListItems.length) % 4) * 60;
			var cy:Number = Math.floor((pictureListItems.length) / 4) * 60;
			
			var _cell:Cell = new Cell();
			_cell.style = { x:0, y:0, width:60, height:60 };
			
			_library.content.addChild(_cell);
			
			var _svg:SVGViewer = DesignViewController.getInstance().imageToSVG(imgLink, img.width, img.height);
			
			
			_cell.data.svgViewer = _svg;
			
			_cell.addImageToContent(img);
			
			_cell.addEventListener(MouseEvent.MOUSE_DOWN, mousedown, false, 0, true);
			
			_cell.x = cx;
			_cell.y = cy;
			
			pictureListItems.push(_svg);
			
			
			// add image to the active designer canvas
			
			// dragged new svg object.
			newSVG = new SVGViewer();
			
			// update the xml of dragged newSVG
			var newXML:XML = SVGViewer(_cell.data.svgViewer).xml;
			
			newSVG.xml = newXML;
			newSVG.x = _mainCanvas.mouseX - newSVG.svgRoot.width/2;
			newSVG.y = _mainCanvas.mouseY - newSVG.svgRoot.height/2;
			newSVG.visible = false;
			
			_mainCanvas.addChild(newSVG);
			
			//if (newSVG.visible) {
				var obj:Object = {
					x:activeDesign.width / 2,
					y:activeDesign.height / 2,
					width:newSVG.width,
					height:newSVG.height,
					
					name:"image"
				}
				activeDesign.addItem(newSVG, obj);
			//} 
			
			newSVG.parent.removeChild(newSVG);
			newSVG = null;
		}
		
		private var bmp:Bitmap;
		private var newSVG:SVGViewer;
		
		private function mousedown(e:MouseEvent):void 
		{
			
			// current target is cell. get bitmap on content.
			var target:Bitmap = e.currentTarget.bitmap;
			
			// dragged small bmp object.
			bmp = new Bitmap(target.bitmapData.clone(), "always", true);
			
			// resize bmp to smaller.
			if (bmp.width > bmp.height) {
				bmp.scaleX = bmp.scaleY = 30 / bmp.width;
			} else {
				bmp.scaleX = bmp.scaleY = 30 / bmp.height;
			}
			bmp.x = _mainCanvas.mouseX - bmp.width/2;
			bmp.y = _mainCanvas.mouseY - bmp.height / 2;
			
			_mainCanvas.addChild(bmp);
			
			
			// dragged new svg object.
			newSVG = new SVGViewer();
			
			// update the xml of dragged newSVG
			var newXML:XML = SVGViewer(e.currentTarget.data.svgViewer).xml;
			
			newSVG.xml = newXML;
			newSVG.x = _mainCanvas.mouseX - newSVG.svgRoot.width/2;
			newSVG.y = _mainCanvas.mouseY - newSVG.svgRoot.height/2;
			newSVG.visible = false;
			
			_mainCanvas.addChild(newSVG);
			
			
			stage.addEventListener(MouseEvent.MOUSE_UP, s_mouseup, false, 0, true);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, s_mousemove, false, 0, true);
			
			newXML = null;
		}
		
		
		private function s_mousemove(e:MouseEvent):void 
		{
			bmp.x = _mainCanvas.mouseX - bmp.width/2;
			bmp.y = _mainCanvas.mouseY - bmp.height/2;
			
			newSVG.x = _mainCanvas.mouseX - newSVG.svgRoot.width/2;
			newSVG.y = _mainCanvas.mouseY - newSVG.svgRoot.height/2;
			
			if(activeDesign.hitTestPoint(_mainCanvas.mouseX, _mainCanvas.mouseY, true)) {
				newSVG.visible = true;
				bmp.visible = false;
			} else {
				newSVG.visible = false
				bmp.visible = true;
			}
		}
		
		private function s_mouseup(e:MouseEvent):void 
		{
			stage.removeEventListener(MouseEvent.MOUSE_UP, s_mouseup);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, s_mousemove);
			
			
			if (newSVG.visible) {
				var obj:Object = {
					x:activeDesign.mouseX,
					y:activeDesign.mouseY,
					width:newSVG.width,
					height:newSVG.height,
					
					name:"image"
				}
				activeDesign.addItem(newSVG, obj);
			} 
			
			
			newSVG.parent.removeChild(newSVG);
			newSVG = null;
			
			
			
			bmp.bitmapData.dispose();
			bmp = null;
			
		}
		
		
		public function get isActive():Boolean { return _isActive; }
		public function set isActive(value:Boolean):void 
		{
			_isActive = value;
		}
		
		
		protected function get activeDesign():Design { return DesignViewController.getInstance().activeDesign; }
		
	}

}