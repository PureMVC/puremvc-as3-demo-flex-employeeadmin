/*
 PureMVC AS3 Demo - Flex Employee Admin 
 Copyright (c) 2007-10 Clifford Hall <clifford.hall@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
package org.puremvc.as3.demos.flex.employeeadmin.view
{
	import flash.events.Event;

	import org.puremvc.as3.demos.flex.employeeadmin.ApplicationFacade;
	import org.puremvc.as3.demos.flex.employeeadmin.model.UserProxy;
	import org.puremvc.as3.demos.flex.employeeadmin.model.vo.UserVO;
	import org.puremvc.as3.demos.flex.employeeadmin.view.components.UserForm;

	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;

	public class UserFormMediator extends Mediator
	{
		private var userProxy:UserProxy;
		
		public static const NAME:String = 'UserFormMediator';

		public function UserFormMediator( viewComponent:UserForm )
		{
			super( NAME, viewComponent );
		}
		
		override public function onRegister():void
		{
			userForm.addEventListener( UserForm.ADD, onAdd );
			userForm.addEventListener( UserForm.UPDATE, onUpdate );
			userForm.addEventListener( UserForm.CANCEL, onCancel );

			userProxy = UserProxy( facade.retrieveProxy( UserProxy.NAME ) );
		}
		
		override public function listNotificationInterests():Array
		{
			return [
					ApplicationFacade.NEW_USER,
					ApplicationFacade.USER_DELETED,
					ApplicationFacade.USER_SELECTED
					
				   ];
		}
		
		override public function handleNotification( note:INotification ):void
		{
			switch ( note.getName() )
			{
				case ApplicationFacade.NEW_USER:
					userForm.setUser( UserVO( note.getBody() ), UserForm.MODE_ADD );
					break;
					
				case ApplicationFacade.USER_DELETED:
					userForm.reset();
					break;
					
				case ApplicationFacade.USER_SELECTED:
					userForm.setUser( UserVO( note.getBody() ), UserForm.MODE_EDIT );
					break;
					
			}
		}

		private function onAdd( event:Event ):void
		{
			userProxy.addItem( userForm.user );
			sendNotification( ApplicationFacade.USER_ADDED, userForm.user );
			userForm.reset();
		}
		
		private function onUpdate( event:Event ):void
		{
			userProxy.updateItem( userForm.user );
			sendNotification(  ApplicationFacade.USER_UPDATED, userForm.user );
			userForm.reset();
		}
		
		private function onCancel( event:Event ):void
		{
			sendNotification( ApplicationFacade.CANCEL_SELECTED );
			userForm.reset();
		}
				
		private function get userForm ():UserForm
		{
			return viewComponent as UserForm;
		}
		
	}
}