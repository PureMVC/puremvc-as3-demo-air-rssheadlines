/*
 PureMVC AS3 Demo – AIR RSS Headlines 
 Copyright (c) 2007 Simon Bailey <simon.bailey@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
package org.puremvc.as3.demos.air.rssheadlines.controller
{
	import org.puremvc.as3.demos.air.rssheadlines.model.ServiceProxy;
	
	import org.puremvc.interfaces.ICommand;
	import org.puremvc.interfaces.INotification;
	import org.puremvc.patterns.command.SimpleCommand;

	public class ChangeFeedCommand extends SimpleCommand implements ICommand
	{
		
		override public function execute( note:INotification ):void
		{	
     		var serviceProxy:ServiceProxy = facade.retrieveProxy( ServiceProxy.NAME ) as ServiceProxy;
     		var url:String = note.getBody() as String;
     		
     		serviceProxy.setURL( url );
		}
	}
}