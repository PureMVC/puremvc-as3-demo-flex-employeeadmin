/*
 PureMVC AS3 Demo - Flex Employee Admin 
 Copyright (c) 2007-08 Clifford Hall <clifford.hall@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
package org.puremvc.as3.demos.flex.employeeadmin.controller
{
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	import org.puremvc.as3.demos.flex.employeeadmin.model.UserProxy;
	import org.puremvc.as3.demos.flex.employeeadmin.model.RoleProxy;
	import org.puremvc.as3.demos.flex.employeeadmin.ApplicationFacade;
	import org.puremvc.as3.demos.flex.employeeadmin.view.UserFormMediator;
	import org.puremvc.as3.demos.flex.employeeadmin.view.UserListMediator;
	import org.puremvc.as3.demos.flex.employeeadmin.view.RolePanelMediator;

	public class StartupCommand extends SimpleCommand implements ICommand
	{
		/**
		 * Register the Proxies and Mediators.
		 * 
		 * Get the View Components for the Mediators from the app,
		 * which passed a reference to itself on the notification.
		 */
		override public function execute( note:INotification ) : void	
		{
			facade.registerProxy( new UserProxy() );
			facade.registerProxy( new RoleProxy() );
			
			var app:Demo_AS3_Flex_EmployeeAdmin = note.getBody() as Demo_AS3_Flex_EmployeeAdmin;
			facade.registerMediator( new UserFormMediator( app.userForm ) );
			facade.registerMediator( new UserListMediator( app.userList ) );
			facade.registerMediator( new RolePanelMediator( app.rolePanel ) );
		}
	}
}