package com.example.myapp.pages;

import externals.starlette.responses.PlainTextResponse;
import externals.starlette.responses.Response;
import top.yunp.cms4py.framework.db.PCursor;
import top.yunp.cms4py.framework.web.http.Context;
import top.yunp.cms4py.framework.web.routing.CursorPage;
import top.yunp.cms4py.framework.logger.Logger;

@:build(hxasync.AsyncMacro.build())
class School extends CursorPage {
    public function new() {
        super();
    }

    @async public function cexecute(context:Context, cursor:PCursor):Response {
        var school_id = context.path_params.get("id");
        var school = (@await cursor.selectOne(context.db.school.id == school_id)) ?? return new PlainTextResponse("School not found", 404);

        var students = @await cursor.select(context.db.user_related_school.school_id == school_id);

        return context.render("school.jinja2", {title: "院校详情", school: school, students:students});
    }
}
