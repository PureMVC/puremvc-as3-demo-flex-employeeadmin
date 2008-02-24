/*
 PureMVC AS3 Demo - Flex Employee Admin 
 Copyright (c) 2007-08 Clifford Hall <clifford.hall@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
package org.puremvc.as3.demos.flex.employeeadmin.controller
{
	import mx.controls.Alert;

	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	import org.puremvc.as3.patterns.observer.Notification;

	import org.puremvc.as3.demos.flex.employeeadmin.ApplicationFacade;
	import org.puremvc.as3.demos.flex.employeeadmin.model.UserProxy;
	import org.puremvc.as3.demos.flex.employeeadmin.model.UserProxy;
	import org.puremvc.as3.demos.flex.employeeadmin.model.RoleProxy;
	import org.puremvc.as3.demos.flex.employeeadmin.model.vo.UserVO;

	public class DeleteUserCommand extends SimpleCommand implements ICommand
	{
		
		// retrieve the user and role proxies and delete the user
		// and his roles. then send the USER_DELETED notification
		override public function execute( notification:INotification ):void
		{
			var user:UserVO = notification.getBody() as UserVO;
			var userProxy:UserProxy = facade.retrieveProxy( UserProxy.NAME ) as UserProxy;
			var roleProxy:RoleProxy = facade.retrieveProxy( RoleProxy.NAME ) as RoleProxy;
			userProxy.deleteItem( user );		
			roleProxy.deleteItem( user );
			sendNotification( ApplicationFacade.USER_DELETED );
			
		}
		
	}
}