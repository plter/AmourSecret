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

package com.example.myapp.pages;

import com.example.myapp.pages.validators.UserValidators;
import externals.starlette.responses.Response;
import top.yunp.cms4py.framework.web.http.Context;
import top.yunp.cms4py.framework.web.routing.Page;
import top.yunp.cms4py.framework.logger.Logger;

@:build(hxasync.AsyncMacro.build())
class MyAsList extends Page {
    public function new() {}

    @async override function execute(context:Context):Response {
        UserValidators.checkLoginStatus(context);

        var as_list = @await context.useCursor(@async c -> {
            var list = @await c.select(context.db.as_list_with_details.self_userid == context.session.userid);
            for (l in list) {
                l.paired = (@await c.count(
                    (cast(context.db.as_list.self_userid == l.target_userid)) &
                    (cast(context.db.as_list.target_userid == l.self_userid)) &
                    (cast(context.db.as_list.school_id == l.school_id))
                )) > 0;
            }

            return list;
        });

        Logger.info(as_list);
        return context.render("my_as_list.jinja2", {title: "我的暗恋单", as_list:as_list});
    }
}
