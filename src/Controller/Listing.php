<?php

namespace Budkit\Repository\Controller;

use Budkit\Repository\Provider;
use Budkit\Repository\Model;
use Budkit\Cms\Helper\Controller;
use Budkit\Cms\Helper\Menu;
use Budkit\Dependency\Container as Application;

class Listing extends Controller {

    public function __construct(Application $application, Menu $menu) {

        parent::__construct($application, $menu);

        $this->view->appendLayoutSearchPath( Provider::getPackageDir()."layouts/");

    }

    public function index($format = 'html') {
        //echo "Browsing in {$format} format";

        //echo "Searching... directory";
        //print_r( $this->application->config );
        $this->view->setData("title", "Listings");
        //$this->view->setData("page", ["body"=>["class"=>"container-block"]]);

        $this->view->addData("action", ["title"=>"Add Listing","link"=>"/repository/add", "class"=>"btn-primary"]);

        //add the google map script
        //$this->view->addData("scripts",["src"=>"//maps.googleapis.com/maps/api/js?key=AIzaSyBZrzwMucdDb547ZrUkWrhkIChoNJfAC88&amp;libraries=places"]);

        //$this->config->get("setup.database.host");
        //$this->config->get("content.posts.list-length");

        //$this->view->addToBlock("navbar-button", 'import://repository/navbar-button');

        //Tell the view where to find additional layouts
        $this->view->addToBlock("main", 'import://repository/listings');
        $this->view->setLayout('directory/dashboard');

    }


    public function read($id, $format = 'html') {
        echo "Reading {$id} in {$format} format";
    }

    public function edit($id = 'new', $format = 'html') {
        echo "Editing {$id} in {$format} format";
    }

    public function add($uri, $format = 'html') {

        $this->view->setData("title", "Add new");

        //1. check this uer has permission to execute /page/create
        $this->checkPermission("execute");

        //2. load the page;
        $category = $this->application->createInstance(Model\Category::class);

        if(!empty($uri)) {
            $category = $category->loadObjectByURI($uri);

            if (empty($category->getObjectId())) {
                throw new ErrorNotFoundException("The requested category does not exist");
                return false;
            }

            //print_R($page->getPropertyData());
            //$parser  = new \Parsedown::instance();
            $editing = $category->getPropertyData();


            //we need to decode the form;
            $editing["category_form"] = json_decode($editing["category_form"], true);

            $this->view->setData("category", $editing);
            $this->view->setData("method", "update");
            $this->view->setData("object_uri", $uri);

        }
        $this->view->setData("csrftoken", $this->application->session->getCSRFToken());

        $this->view->setLayout('directory/new');
    }

    public function delete() {
        echo "Delete...";
    }

    public function create() {
        echo "Creating...";
    }

    public function update() {
        echo "Updating...";
    }

    public function replace() {
        echo "Replacing...";
    }

    public function options() {
        echo "Options...";
    }
}