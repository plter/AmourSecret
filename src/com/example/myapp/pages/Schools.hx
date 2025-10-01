package com.example.myapp.pages;

import externals.starlette.responses.Response;
import top.yunp.cms4py.framework.db.PCursor;
import top.yunp.cms4py.framework.web.http.Context;
import top.yunp.cms4py.framework.web.routing.CursorPage;

@:build(hxasync.AsyncMacro.build())
class Schools extends CursorPage {
    public function new() {
        super();
    }

    @async public function cexecute(context:Context, cursor:PCursor):Response {
        var schools = @await cursor.select(context.db.school.id > 0);
        return context.render("schools.html", {title: "院校列表", schools:schools});
    }
}
