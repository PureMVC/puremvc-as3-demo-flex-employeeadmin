/*
 PureMVC AS3 Demo - Flex Employee Admin 
 Copyright (c) 2007 Clifford Hall <clifford.hall@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
package org.puremvc.as3.demos.flex.employeeadmin.model
{
	import mx.collections.ArrayCollection;

	import org.puremvc.interfaces.IProxy;
	import org.puremvc.patterns.proxy.Proxy;

	import org.puremvc.as3.demos.flex.employeeadmin.model.vo.UserVO;
	import org.puremvc.as3.demos.flex.employeeadmin.model.enum.DeptEnum;

	public class UserProxy extends Proxy implements IProxy
	{
		public static const NAME:String = 'UserProxy';

		public function UserProxy( )
		{
			super( NAME, new ArrayCollection );

			// generate some test data			
			addItem( new UserVO('lstooge','Larry', 'Stooge', "larry@stooges.com", 'ijk456',DeptEnum.ACCT) );
			addItem( new UserVO('cstooge','Curly', 'Stooge', "curly@stooges.com", 'xyz987',DeptEnum.SALES) );
			addItem( new UserVO('mstooge','Moe', 'Stooge', "moe@stooges.com", 'abc123',DeptEnum.PLANT) );
		}

		// return data property cast to proper type
		public function get users():ArrayCollection
		{
			return data as ArrayCollection;
		}

		// add an item to the data	
		public function addItem( item:Object ):void
		{
			users.addItem( item );
		}
				
		// update an item in the data
		public function updateItem( item:Object ):void
		{
			var user:UserVO = item as UserVO;
			for ( var i:int=0; i<users.length; i++ )
			{
				if ( users[i].username == user.username ) {
					users[i] = user;
				}
			}
		}
		
		// delete an item in the data
		public function deleteItem( item:Object ):void
		{
			var user:UserVO = item as UserVO;
			for ( var i:int=0; i<users.length; i++ )
			{
				if ( users[i].username == user.username ) {
					users.removeItemAt(i);
				}
			}
		}
	}
}