/*
 PureMVC AS3 Demo – AIR RSS Headlines 
 Copyright (c) 2007 Simon Bailey <simon.bailey@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
package org.puremvc.as3.demos.air.rssheadlines.controller
{
	import org.puremvc.as3.demos.air.rssheadlines.model.ServiceProxy;
	import org.puremvc.as3.demos.air.rssheadlines.view.RSSWrapperMediator;
	
	import org.puremvc.interfaces.ICommand;
	import org.puremvc.interfaces.INotification;
	import org.puremvc.patterns.command.SimpleCommand;

	public class StartupCommand extends SimpleCommand implements ICommand
	{
		/**
		 * Register the Proxies and Mediators.
		 * 
		 * Get the View Components for the Mediators from the app,
		 * which passed a reference to itself on the notification.
		 */
		 override public function execute( note:INotification ):void
		 {
		 	
		 	var app:Demo_AS3_AIR_RSSHeadlines = note.getBody() as Demo_AS3_AIR_RSSHeadlines;
		 	
		 	facade.registerProxy( new ServiceProxy() );
			
			facade.registerMediator( new RSSWrapperMediator( app.rssWrapper ) );
		 }
	}
}