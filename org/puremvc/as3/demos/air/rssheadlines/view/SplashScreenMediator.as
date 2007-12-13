/*
 PureMVC AS3 Demo – AIR RSS Headlines 
 Copyright (c) 2007 Simon Bailey <simon.bailey@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
package org.puremvc.as3.demos.air.rssheadlines.view
{
	import org.puremvc.as3.demos.air.rssheadlines.view.components.SplashScreen;
	
	import org.puremvc.interfaces.IMediator;
	import org.puremvc.patterns.mediator.Mediator;

	public class SplashScreenMediator extends Mediator implements IMediator
	{
		
		public static var NAME:String = "SplashScreenMediator";
		
		public function SplashScreenMediator( viewComponent:Object )
		{
			super( viewComponent );
		}
		
		override public function getMediatorName():String
		{
			return NAME;
		}
		
		public function get splashScreen():SplashScreen
		{
			return viewComponent as SplashScreen;
		}
	}
}