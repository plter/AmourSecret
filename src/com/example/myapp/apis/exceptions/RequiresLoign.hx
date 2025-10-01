package com.example.myapp.apis.exceptions;
import top.yunp.cms4py.framework.web.exceptions.APIException;
import top.yunp.cms4py.framework.web.routing.apis.actions.Action;
class RequiresLoign extends APIException {
    public function new() {
        super(Action.createResult(ResultCode.CODE_REQUIRES_LOGIN, "Requires login"));
    }
}
