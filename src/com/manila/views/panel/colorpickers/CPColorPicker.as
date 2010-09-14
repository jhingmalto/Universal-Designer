package com.manila.views.panel.colorpickers
{
	import com.manila.controllers.TabViewController;
	import com.manila.models.ThemeManagerModel;
	import com.mpt.controls.tilelist.CPCell;
	import com.mpt.display.mButton;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	/**
	 * ...
	 * @author mykhel
	 */
	public class CPColorPicker extends MovieClip
	{
		protected var _themeManager:ThemeManagerModel = ThemeManagerModel.getInstance();
		protected var _tabViewController:TabViewController = TabViewController.getInstance();
		
		
		protected var _customColors:Array;
		
		protected var _cells:Array;
		
		protected var _cpColors:Array = [
           0xfffffe, 0x000001, 0x3E3E3E, 0x818181, 0xc0c0c0, 0xA30012, 0xC1272C, 0xFF0000, 0xEB381B, 0xE4947E,
		   0xEC731F, 0xF7921E, 0xF3B824, 0xFBED20, 0xFAF49F, 0x5E9271, 0x009245, 0x39B549, 0x52BE1C, 0xA4CF9E,
		   0x2428F6, 0x006FBB, 0x3EB8B1, 0x29ABE1, 0x75D0F6, 0x1B1363, 0x2D3092, 0x662C91, 0x92278F, 0x9E005D,
		   0xEC1E79, 0xE99EC2, 0xF7AAFC, 0x853422, 0x754B23, 0xC59C6C, 0xC59C6C, 0xF3C58E, 0x8A842D, 0xB1B778
		];
		
		private var _label:TextField;
		
		private var _selectedColor:uint;

		public function CPColorPicker():void
		{
			var tf:TextFormat = new TextFormat("Arial", 16, 0x676767, true);
			
			_label = new TextField();
			_label.text = "Label";
			_label.selectable = false;
			_label.defaultTextFormat = tf;
			_label.setTextFormat(tf);
			_label.autoSize = "left";
			
			addChild(_label)
			
			
			_cells = new Array();
			_customColors = new Array();
			
			var _cell:CPCell;
			for (var i:int = 0; i < _cpColors.length; i++) 
			{
				var cx:Number = Math.floor(i % 10) * 25 + 5;
				var cy:Number = Math.floor(i / 10) * 25 + 25;
				
				
				_cell = new CPCell();
				_cell.style = { x:0, y:0, width:20, height:20, colorUp:_cpColors[i], colorOver:0xffffff };
				
				_cell.x = cx;
				_cell.y = cy;
				
				_cells.push(_cell);
				addChild(_cell);
				_cell.data.hasColor = true;
				
				_cell.addEventListener(MouseEvent.MOUSE_DOWN, onCellMouseDown);
			}
			
			for (i = 1; i < 10; i++) 
			{
				cx = Math.floor(i % 10) * 25 + 5;
				cy = Math.floor(i / 10) * 25 + 25 + 100;
				
				_cell = new CPCell();
				_cell.style = { x:0, y:0, width:20, height:20, colorUp:0xffffff, colorOver:0xffffff };
				
				_cell.x = cx;
				_cell.y = cy;
				
				_customColors.push(_cell);
				addChild(_cell);
				_cell.data.hasColor = false;
				
				_cell.addEventListener(MouseEvent.MOUSE_DOWN, onCellMouseDown);
			}
			
			graphics.beginFill(0xffffff);
			graphics.lineStyle(1, 0xBCB8B7, 1, true);
			graphics.drawRoundRect(0, 20, this.width + 10, this.height + 10 - 25, 10, 10);
			
			var cpRainbow:mButton = new mButton();
			cpRainbow.up.addChild(_themeManager.cpRainbowUp);
			cpRainbow.x = 5;
			cpRainbow.y = 125;
			addChild(cpRainbow);
			
			cpRainbow.addEventListener(MouseEvent.MOUSE_DOWN, onRainbowDown);
			
			
		}
		
		
		private function onRainbowDown(e:MouseEvent):void 
		{
			_tabViewController.tabMenu.panelHolder.spectrumPanel.show();
			_tabViewController.currentColorPicker = this;
			
			
		}
		
		private function onCellMouseDown(e:MouseEvent):void 
		{
			if (!e.currentTarget.data.hasColor) return;
			
			for (var i:int = 0; i < _cells.length; i++) 
			{
				_cells[i].isEnable = true;
			}
			
			for (i = 0; i < _customColors.length; i++) 
			{
				_customColors[i].isEnable = true;
			}
			
			e.currentTarget.isEnable = false;
			
			_selectedColor = e.currentTarget.color;
			
			dispatchEvent(new Event("cpChangeColor"));
		}
		
		
		public function addCustomColor(u:uint):void 
		{
			
			for (var i:int = 8; i > 0; i--) 
			{
				_customColors[i].color = _customColors[i - 1].color;
				if (_customColors[i].color != 0xffffff)_customColors[i].data.hasColor = true;
			}
			
			var cpCell:CPCell = _customColors[0];
			cpCell.color = u;
			cpCell.data.hasColor = true;
			
			
			for (i = 0; i < _cells.length; i++) 
			{
				_cells[i].isEnable = true;
			}
			
			for (i = 0; i < _customColors.length; i++) 
			{
				_customColors[i].isEnable = true;
			}
			
			cpCell.isEnable = false;
			
			
			_selectedColor = u;
			dispatchEvent(new Event("cpChangeColor"));
		}
		
		
		public function get customColors():Array { return _customColors; }
		public function set customColors(value:Array):void 
		{
			_customColors = value;
		}
		
		public function get label():String { return _label.text; }
		public function set label(value:String):void 
		{
			_label.text = value;
		}
		
		public function get selectedColor():uint { return _selectedColor; }
		
		
	}

}