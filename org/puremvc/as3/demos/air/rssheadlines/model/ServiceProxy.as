/*
 PureMVC AS3 Demo – AIR RSS Headlines 
 Copyright (c) 2007 Simon Bailey <simon.bailey@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
package org.puremvc.as3.demos.air.rssheadlines.model
{
	import org.puremvc.as3.demos.air.rssheadlines.ApplicationFacade;
	import org.puremvc.as3.demos.air.rssheadlines.model.vo.FeedVO;
	
	import flash.events.*;
	import flash.net.*;
	import flash.utils.*;
	
	import mx.collections.ArrayCollection;
	
	import org.puremvc.interfaces.IProxy;
	import org.puremvc.patterns.proxy.Proxy;
	import org.puremvc.interfaces.INotification;
	

	public class ServiceProxy extends Proxy implements IProxy
	{	
		public static const NAME:String = "ServiceProxy";
		
		private var urlLoader:URLLoader;
		private var urlRequest:URLRequest;
		private var ticker:Timer;
		private var article_number:uint;
		private var change_feed:Boolean = false;
		
		// Adjust starting values accordingly
		// private var url:String = "http://www.nutrixinteractive.com/blog/wp-rdf.php";
		private var url:String = "http://weblogs.macromedia.com/mxna/xml/rss.cfm";
		// Duration 1000 = 1 second
		public var duration:uint = 2000;
		
		public function ServiceProxy()
		{
			super( NAME, new ArrayCollection );
			
			getRSS();
		}
		
		public function getRSS():void
		{	
			if( change_feed != false)
			{
				data = new ArrayCollection();
			}
			
			urlRequest = new URLRequest();
			urlRequest.url = url + "?&nocache=" + getTimer();
			
			urlLoader = new URLLoader();
			urlLoader.addEventListener( Event.COMPLETE, onComplete );
			urlLoader.addEventListener( IOErrorEvent.IO_ERROR, onIOError );
			urlLoader.addEventListener( SecurityErrorEvent.SECURITY_ERROR, onSecurityError );
			urlLoader.addEventListener( HTTPStatusEvent.HTTP_STATUS, onStatus );
			
			urlLoader.load( urlRequest );

		}
		
		// Return data property cast to proper type
		public function get feedContent():ArrayCollection
		{			
			return data as ArrayCollection;
		}
		
		private function onComplete( event:Event ):void
		{
			article_number = 0;
			
			change_feed = false;
			
			var resultXML:XML = XML( urlLoader.data );
			trace(resultXML);
			var rss:Namespace = new Namespace("http://purl.org/rss/1.0/");
	       
		        for each(var item:XML in resultXML..rss::item)
		        {
		        	var feedArticle:FeedVO = new FeedVO();
		        	
		        	feedArticle.subject = item..rss::title;
		        	feedArticle.articlebody = item..rss::description;
		        	feedArticle.articlelink = item..rss::link;
		        	
		        	feedContent.addItem( feedArticle );
		        }
		    sendNotification( ApplicationFacade.XML_DATA );
		    createTimer();
  		}
  		
  		public function setDuration( _duration:uint ):void
  		{
  			duration = Math.floor( _duration*1000 );
  			
  			resetTimer();
  		}
  		
  		public function setURL( _url:String ):void
  		{
  			url = _url;
  			change_feed = true;
  			resetTimer();
  			getRSS();
  		}
  		
  		public function createTimer():void
		{	
			ticker = new Timer( duration );
            ticker.addEventListener( TimerEvent.TIMER, onTick );
            startTimer();
		}
		
		public function startTimer():void
		{   
            ticker.start();
		}
		
		public function pauseTimer():void
		{
			ticker.stop();
		}
		
		public function resetTimer():void
		{
			pauseTimer();
			ticker.reset();
			ticker.removeEventListener( TimerEvent.TIMER, onTick );
			
			if( change_feed != true)
			{
				createTimer();
			}
		}
		
		private function onTick( e:TimerEvent ):void
		{	
			if( article_number != (feedContent.length)-1 )
			{
				article_number++;
			} else
			{
				article_number = 0;
			}

			var feedArticle:FeedVO = feedContent.getItemAt( article_number ) as FeedVO;
			sendNotification( ApplicationFacade.DATA, feedArticle );
			
		}
		
		private function onIOError( event:IOErrorEvent ):void
		{
			sendNotification( ApplicationFacade.ERROR, event.text );
		}
		
		private function onSecurityError( event:SecurityErrorEvent ):void
		{       
            sendNotification( ApplicationFacade.ERROR, event.text );
        }

		private function onStatus( event:HTTPStatusEvent ):void
		{
			if(event.status != 0)
			{
				trace(event.status);
			}
		}

	}
}