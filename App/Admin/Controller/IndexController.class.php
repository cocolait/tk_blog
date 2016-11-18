<?php
namespace Admin\Controller;
use \Common\Model\AuthGroupAccessModel;
class IndexController extends AdminBaseController {
    public function index(){
        $model = new AuthGroupAccessModel();
        $this->assign('groupName',$model->getGroupName($_SESSION['admin_user']['uid']));
        $this->display();
    }
}