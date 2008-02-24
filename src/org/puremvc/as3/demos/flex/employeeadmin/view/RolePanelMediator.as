/*
 PureMVC AS3 Demo - Flex Employee Admin 
 Copyright (c) 2007-08 Clifford Hall <clifford.hall@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
package org.puremvc.as3.demos.flex.employeeadmin.view
{
	import flash.events.Event;
	import mx.collections.ArrayCollection;

	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	import org.puremvc.as3.patterns.observer.Notification;

	import org.puremvc.as3.demos.flex.employeeadmin.ApplicationFacade;
	import org.puremvc.as3.demos.flex.employeeadmin.model.vo.UserVO;
	import org.puremvc.as3.demos.flex.employeeadmin.model.RoleProxy;
	import org.puremvc.as3.demos.flex.employeeadmin.model.vo.RoleVO;
	import org.puremvc.as3.demos.flex.employeeadmin.model.enum.RoleEnum;
	import org.puremvc.as3.demos.flex.employeeadmin.view.components.RolePanel;

	public class RolePanelMediator extends Mediator implements IMediator
	{
		private var roleProxy:RoleProxy;		
		
		public static const NAME:String = 'RolePanelMediator';

		public function RolePanelMediator( viewComponent:Object )
		{
			super( NAME, viewComponent );
			
			rolePanel.addEventListener( RolePanel.ADD, onAddRole );
			rolePanel.addEventListener( RolePanel.REMOVE, onRemoveRole );

			roleProxy = facade.retrieveProxy( RoleProxy.NAME ) as RoleProxy;
				
		}
		
		private function get rolePanel():RolePanel
		{
			return viewComponent as RolePanel;
		}
		
		private function onAddRole( event:Event ):void
		{
			roleProxy.addRoleToUser( rolePanel.user, rolePanel.selectedRole );
		}
		
		private function onRemoveRole( event:Event ):void
		{
			roleProxy.removeRoleFromUser( rolePanel.user, rolePanel.selectedRole );
		}
		
		override public function listNotificationInterests():Array
		{
			return [
					ApplicationFacade.NEW_USER,
					ApplicationFacade.USER_ADDED,
					ApplicationFacade.USER_UPDATED,
					ApplicationFacade.USER_DELETED,
					ApplicationFacade.CANCEL_SELECTED,
					ApplicationFacade.USER_SELECTED,
					ApplicationFacade.ADD_ROLE_RESULT
				   ];
		}
		
		override public function handleNotification( note:INotification ):void
		{

			switch ( note.getName() )
			{
				case ApplicationFacade.NEW_USER:
					clearForm();
					break;
					
				case ApplicationFacade.USER_ADDED:
					rolePanel.user = note.getBody() as UserVO;
					var roleVO:RoleVO = new RoleVO ( rolePanel.user.username );
					roleProxy.addItem( roleVO );
					clearForm();
					break;
					
				case ApplicationFacade.USER_UPDATED:
					clearForm();
					break;
					
				case ApplicationFacade.USER_DELETED:
					clearForm();
					break;
					
				case ApplicationFacade.CANCEL_SELECTED:
					clearForm();
					break;
					
				case ApplicationFacade.USER_SELECTED:
					rolePanel.user = note.getBody() as UserVO;
					rolePanel.userRoles = roleProxy.getUserRoles( rolePanel.user.username );
					rolePanel.roleCombo.selectedItem = RoleEnum.NONE_SELECTED;
					break;
					
				case ApplicationFacade.ADD_ROLE_RESULT:
					rolePanel.userRoles = null;
					rolePanel.userRoles = roleProxy.getUserRoles( rolePanel.user.username );
					break;
					
			}
		}
		
		private function clearForm():void
		{		
			rolePanel.user = null;
			rolePanel.userRoles = null;
			rolePanel.roleCombo.selectedItem = RoleEnum.NONE_SELECTED;
		}

	}
}