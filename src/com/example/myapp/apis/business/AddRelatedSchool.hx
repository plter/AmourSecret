/*
 * MIT License
 *
 * Copyright (c) 2025 https://yunp.top
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of
 * this software and associated documentation files (the "Software"), to deal in
 * the Software without restriction, including without limitation the rights to use,
 * copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the
 * Software, and to permit persons to whom the Software is furnished to do so,
 * subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
 * FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
 * COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN
 * AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH
 * THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

package com.example.myapp.apis.business;

import top.yunp.cms4py.framework.web.http.Context;
import top.yunp.cms4py.framework.web.routing.apis.actions.Action;
import com.example.myapp.apis.exceptions.RequiresLoign;
import com.example.myapp.apis.exceptions.ParametersError;

@:build(hxasync.AsyncMacro.build())
class AddRelatedSchool extends Action {
    public function new() {
        super();
    }

    @async override function doAction(context:Context):Dynamic {

        var form = @await context.request.form();
        var schoolId = form.get("school_id");

        if (schoolId == null) {
            throw new ParametersError();
        }

        if (context.session.userid == null) {
            throw new RequiresLoign();
        }

        var result:Dynamic = null;

        @await context.useCursor(@async c -> {
            var query:Dynamic = (cast (context.db.user_school_relation.school_id == schoolId)) & (cast (context.db.user_school_relation.user_id == context.session.userid));
            if (@await c.isempty(query)) {
                @await c.insert(
                    context.db.user_school_relation,
                    {school_id:schoolId, user_id:context.session.userid}
                );
            }
        });

        if (result == null) {
            result = Action.createOkResult();
        }
        return result;
    }
}
