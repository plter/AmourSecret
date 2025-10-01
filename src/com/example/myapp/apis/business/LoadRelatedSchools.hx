/*
@author https://yunp.top
 */
package com.example.myapp.apis.business;

import com.example.myapp.apis.exceptions.RequiresLoign;
import top.yunp.cms4py.framework.web.http.Context;
import top.yunp.cms4py.framework.web.routing.apis.actions.Action;

@:build(hxasync.AsyncMacro.build())
class LoadRelatedSchools extends Action {
	public function new() {
		super();
	}

	@async override public function doAction(context:Context):Dynamic {
		if (context.session.userid == null) {
			throw new RequiresLoign();
		}

		var schools = @await context.useCursor(@async cursor -> {
			return @await cursor.select(context.db.user_related_school.user_id == context.session.userid);
		});

		trace(schools);

		return Action.createOkResult(schools);
	}
}
