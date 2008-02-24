/*
 PureMVC AS3 Demo - Flex Employee Admin 
 Copyright (c) 2007-08 Clifford Hall <clifford.hall@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
package org.puremvc.as3.demos.flex.employeeadmin.model
{
	import mx.collections.ArrayCollection;

	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	import org.puremvc.as3.patterns.observer.Notification;

	import org.puremvc.as3.demos.flex.employeeadmin.model.vo.RoleVO;
	import org.puremvc.as3.demos.flex.employeeadmin.model.vo.UserVO;
	import org.puremvc.as3.demos.flex.employeeadmin.model.enum.RoleEnum;
	import org.puremvc.as3.demos.flex.employeeadmin.ApplicationFacade;

	public class RoleProxy extends Proxy implements IProxy
	{
		public static const NAME:String = 'RoleProxy';

		public function RoleProxy( )
		{
			super( NAME, new ArrayCollection );
			
			// generate some test data 
			addItem( new RoleVO( 'lstooge', [ RoleEnum.PAYROLL,
											  RoleEnum.EMP_BENEFITS ] ) );
											       
			addItem( new RoleVO( 'cstooge', [ RoleEnum.ACCT_PAY,
											  RoleEnum.ACCT_RCV,
											  RoleEnum.GEN_LEDGER ] ) );
											       
			addItem( new RoleVO( 'mstooge', [ RoleEnum.INVENTORY,
											  RoleEnum.PRODUCTION,
											  RoleEnum.SALES,
											  RoleEnum.SHIPPING ] ) );
		}
		
		// get the data property cast to the appropriate type
		public function get roles():ArrayCollection
		{
			return data as ArrayCollection;
		}

		// add an item to the data
		public function addItem( item:Object ):void
		{
			roles.addItem( item );
		}
		
		// delete an item from the data 
		public function deleteItem( item:Object ):void
		{
			for ( var i:int=0; i<roles.length; i++) { 
				if ( roles.getItemAt(i).username == item.username ) {
					roles.removeItemAt(i);
					break;
				}
			}	
		}
		
		// determine if the user has a given role
		public function doesUserHaveRole( user:UserVO, role:RoleEnum ):Boolean
		{
			var hasRole:Boolean = false;
			for ( var i:int=0; i<roles.length; i++) { 
				if ( roles.getItemAt(i).username == user.username ) {
					var userRoles:ArrayCollection = roles.getItemAt(i).roles as ArrayCollection;
					for ( var j:int=0; j<userRoles.length; j++ ) {
						if ( RoleEnum( userRoles.getItemAt(j) ).equals( role ) ) {
							hasRole = true;
							break;
						} 
					}
					break;
				}
			}
			return hasRole;
		}

		// add a role to this user
		public function addRoleToUser( user:UserVO, role:RoleEnum ) : void
		{
			var result:Boolean = false;
			if ( ! doesUserHaveRole( user, role ) ) {
				for ( var i:int=0; i<roles.length; i++) { 
					if ( roles.getItemAt(i).username == user.username ) {
						var userRoles:ArrayCollection = roles.getItemAt(i).roles as ArrayCollection;
						userRoles.addItem( role );
						result = true;
						break;
					}
				}
			}
			sendNotification( ApplicationFacade.ADD_ROLE_RESULT, result );
		}

		// remove a role from the user
		public function removeRoleFromUser( user:UserVO, role:RoleEnum ) : void
		{
			if ( doesUserHaveRole( user, role ) ) {
				for ( var i:int=0; i<roles.length; i++) { 
					if ( roles.getItemAt(i).username == user.username ) {
						var userRoles:ArrayCollection = roles.getItemAt(i).roles as ArrayCollection;
						for ( var j:int=0; j<userRoles.length; j++) { 
							if ( RoleEnum( userRoles.getItemAt(j) ).equals( role ) ) {
								userRoles.removeItemAt(j);
								break;
							}
						}
						break;
					}
				}
			}
		}

		// get a user's roles
		public function getUserRoles( username:String ):ArrayCollection
		{
			var userRoles:ArrayCollection = new ArrayCollection();
			for ( var i:int=0; i<roles.length; i++) { 
				if ( roles.getItemAt(i).username == username ) {
					userRoles = roles.getItemAt(i).roles as ArrayCollection;
					break;
				}
			}	
			return userRoles;
		}

	}
}