/*
 PureMVC AS3 Demo – AIR RSS Headlines 
 Copyright (c) 2007 Simon Bailey <simon.bailey@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
package org.puremvc.as3.demos.air.rssheadlines.view
{
	import org.puremvc.as3.demos.air.rssheadlines.ApplicationFacade;
	import org.puremvc.as3.demos.air.rssheadlines.model.ServiceProxy;
	import org.puremvc.as3.demos.air.rssheadlines.model.vo.FeedVO;
	import org.puremvc.as3.demos.air.rssheadlines.view.components.Viewer;
	
	import flash.utils.Timer;
	
	import org.puremvc.interfaces.IMediator;
	import org.puremvc.interfaces.INotification;
	import org.puremvc.patterns.mediator.Mediator;

	public class ViewerMediator extends Mediator implements IMediator
	{
		public static const NAME:String = 'ViewerMediator';
		
		public var article_number:int;
		
		private var serviceProxy:ServiceProxy;
		private var feedTimer:Timer;
		
		public function ViewerMediator( viewComponent:Object )
		{
			super( viewComponent );
		}
		
		override public function getMediatorName():String
		{
			return NAME;
		}
		
		public function get viewer():Viewer
		{
			return viewComponent as Viewer;
		}
		
		override public function listNotificationInterests():Array
		{
			return [
					ApplicationFacade.DATA
				   ];
		}
		
		override public function handleNotification( note:INotification ):void
		{
			switch ( note.getName() )
			{
				case ApplicationFacade.DATA:
					viewer.feedArticle = note.getBody() as FeedVO;
					break;
			}
		}
	}
}