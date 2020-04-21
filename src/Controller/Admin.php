<?php

namespace Budkit\Repository\Controller;

use Budkit\Repository\Provider;
use Budkit\Repository\Model;
use Budkit\Cms\Helper\Menu;
use Budkit\Cms\Controller\Admin as CMSAdmin;
use Budkit\Dependency\Container as Application;

class Admin extends CMSAdmin
{

    public function __construct(Application $application, Menu $menu)
    {

        parent::__construct($application, $menu);

        //
        $this->view->appendLayoutSearchPath(Provider::getPackageDir() . "layouts/");

    }

    public function index($format = 'html')
    {
        //echo "Browsing in {$format} format";

        $this->view->setData("title", "Repositories");
        $this->view->setLayout("member/dashboard");

        //checks for a higher permission here, because there are links
        //to admin level actions
        $this->checkPermission("execute");

        $category = $this->application->createInstance(Model\Category::class);

        //$page = $page->defineValueGroup("page");
        $categories = $category->getAllMedia("category");
        $this->view->setData("categories", $categories);

        $pagination = $category->getPagination();

        if ($pagination) {
            $this->view->setData("pagination", $pagination);
        }

        $this->view->addData("action", ["title" => "Add Category", "link" => "/admin/repository/add", "class" => "btn-primary"]);

        $this->view->addToBlock("main", 'import://category/category-list');

    }


    public function read($id, $format = 'html')
    {
        echo "Reading {$id} in {$format} format";
    }

    public function edit($id = 'new', $format = 'html')
    {
        echo "Editing {$id} in {$format} format";
    }

    public function add()
    {

        $this->view->setLayout('directory/new');
    }

    public function delete()
    {
        echo "Delete...";
    }

    public function create()
    {
        echo "Creating...";
    }

    public function update()
    {
        echo "Updating...";
    }

    public function replace()
    {
        echo "Replacing...";
    }

    public function options()
    {
        echo "Options...";
    }
}