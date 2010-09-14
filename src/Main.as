package 
{
	import com.manila.models.FlashVarsModel;
	import flash.system.Capabilities;
	import flash.system.LoaderContext;
	import flash.system.Security;

	import flash.display.Sprite;
	import flash.events.Event;
	
	import com.manila.views.MainCanvas
	import com.manila.models.ProductModel;
	
	/**
	 * ...
	 * @author mykhel
	 */
	public class Main extends Sprite 
	{
		
		private var mainCanvas:MainCanvas;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
			
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			var obj:Object;
			var swfPath:String = loaderInfo.url.substr(0, loaderInfo.url.lastIndexOf("/Designer.swf")) + "/";
			//if (Capabilities.playerType == "ActiveX" || Capabilities.playerType == "PlugIn") { // local host testing
			if (loaderInfo.url.indexOf("localhost") == -1) { // swf/localhost testing
				obj = {
					userToken: "5404d8f9-29a0-44ea-a3f1-da9d66055603",
					apiUrl: "http://api.make.dev",
					contentUrl: "http://groups.cafepress.com/",
					uploadUrl: "http://hap1.make.dev:8080",
					appKey: "7wxvnkpsdpmpxvbw94dwe83h",
					imagingUrl: "http://citrine.make.dev:8080",
					uploadFolder: "CP-CustomProductUploads",
					saveFolder: "CP-CustomProductDesigns",
					designerVersion: "addashop",
					logEnabled: "true",
					assetsDefaultSearch: "featured", 
					assetsDefaultCategories: "Graphics,Holidays,Mascots,Animals,Music,Military,Sports,Travel,Religion,Events,Featured",
					assetsURL: "http://174.129.214.250",
					assetsChannel: "cp-make",
					
					merchId: "70", 
					merchName: "short_sleeve", 
					merchColor: "0x00FF00"
				}
			} else { // browser testing
				obj = {
					userToken: root.loaderInfo.parameters.userToken,
					apiUrl: root.loaderInfo.parameters.apiUrl,
					contentUrl: root.loaderInfo.parameters.contentUrl,
					uploadUrl: root.loaderInfo.parameters.uploadUrl,
					appKey: root.loaderInfo.parameters.appKey,
					imagingUrl: root.loaderInfo.parameters.imagingUrl,
					uploadFolder: root.loaderInfo.parameters.uploadFolder,
					saveFolder: root.loaderInfo.parameters.saveFolder,
					designerVersion: root.loaderInfo.parameters.designerVersion,
					logEnabled: root.loaderInfo.parameters.logEnabled,
					assetsDefaultSearch: root.loaderInfo.parameters.assetsDefaultSearch, 
					assetsDefaultCategories: root.loaderInfo.parameters.assetsDefaultCategories,
					assetsURL: root.loaderInfo.parameters.assetsURL,
					assetsChannel: root.loaderInfo.parameters.assetsChannel,
					
					merchId: root.loaderInfo.parameters.merchId, 
					merchName: root.loaderInfo.parameters.merchName, 
					merchColor: root.loaderInfo.parameters.merchColor
				}
			}
			
			Security.allowDomain("*");
			//Security.loadPolicyFile(_crossdomainURL);
			
			
			FlashVarsModel.parseData(obj);
			
			//ProductModel.parsedProduct = { front:"short_sleeve", back:"short_sleeve" };
			
			mainCanvas = new MainCanvas(this);
			addChild(mainCanvas);
			
		}
		
	}
	
}