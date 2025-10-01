/*
@author https://yunp.top
 */
package com.example.myapp.apis.business;
import top.yunp.cms4py.framework.web.routing.apis.actions.Action;
import top.yunp.cms4py.framework.web.http.Context;
import com.example.myapp.apis.exceptions.RequiresLoign;
import com.example.myapp.apis.exceptions.ParametersError;
import externals.pymysql.err.MySQLError;

@:build(hxasync.AsyncMacro.build())
class As extends Action {
    public function new() {
        super();
    }

    @async override function doAction(context:Context):Dynamic {
        var form = @await context.request.form();
        var as_user_id = form.get("as_user_id");
        var school_id = form.get("school_id");

        if (as_user_id == null || school_id == null) {
            throw new ParametersError();
        }

        if (context.session.userid == null) {
            throw new RequiresLoign();
        }

        try {
            @await context.useCursor(@async c -> {
                @await c.insert(context.db.as_list, {
                    self_userid:context.session.userid,
                    target_userid:as_user_id,
                    school_id:school_id
                });
            });
        } catch (e:MySQLError) {

        }
        return Action.createOkResult();
    }
}
