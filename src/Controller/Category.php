<?php

namespace Budkit\Repository\Controller;

use Budkit\Cms\Model\Authority;
use Budkit\Repository\Provider;
use Budkit\Repository\Model;
use Budkit\Cms\Controller\Admin as CMSAdmin;
use Budkit\Cms\Helper\Menu;
use Budkit\Cms\Model\User;
use Budkit\Dependency\Container;
use Budkit\Datastore\Model\Entity;
use Budkit\Cms\Helper\ErrorNotFoundException;


class Category extends CMSAdmin
{
    public function __construct(Container $application, Menu $menu, User $user) {

        parent::__construct($application, $menu);

        $this->view->appendLayoutSearchPath(  Provider::getPackageDir()."layouts/");
        $this->user = $user->getCurrentUser();

    }


    public function index($format = "html")
    {
        return;
    }


    public function read($uri, $format = 'html')
    {

        //1. If ID is null, we are creating;
        if (empty($uri) ) {
            throw new ErrorNotFoundException("Cannot browse an undefined category");
            return false;
        }

        //1. Do not check view permission as this is already checked in provider
        //You can set a custom permission checker, by add a ->setPermissionCallback to the route definition
        //$this->checkPermission("view");

        //2. load the page;
        //2. load the page;
        $category = $this->application->createInstance(Model\Category::class);
        $category = $category->loadObjectByURI( $uri );


        if (empty($category->getObjectId()) ) {
            throw new ErrorNotFoundException("The requested category does not exist");
            return false;
        }

        //echo "Searching... directory";
        //print_r( $this->application->config );
        $this->view->setData("title", $category->getPropertyValue("Category_name"). " repository" );
        //$this->view->setData("page", ["body"=>["class"=>"container-block"]]);

        //$this->view->addData("action", ["title"=>"Add Listing","link"=>"/repository/add", "class"=>"btn-primary"]);

        //add the google map script

        //$this->config->get("setup.database.host");
        //$this->config->get("content.posts.list-length");

        //$this->view->addToBlock("navbar-button", 'import://repository/navbar-button');

        //Tell the view where to find additional layouts
        $this->view->addToBlock("main", 'import://posts/post-map');
        $this->view->setLayout('posts/post-dashboard');


    }

    protected function loadCategoryData( $uri ){

        //2. load the category;
        $category = $this->application->createInstance(Model\Category::class);
        $categorydata = $category->getCategoryData( $uri );


//        print_R($dataFields);
//        print_R($categorydata);

        $this->view->setData("categorydata", $categorydata );
    }


    public function manage($uri, $group, $format='html'){

        //1. If ID is null, we are creating;
        if(empty($uri)) {
            throw new \Exception("Category URI not defined");
            return false;
        }

        //Load data managers;
        switch($group){
            case 'data':
                $this->loadCategoryData( $uri );
                break;
            default:
                break;
        }


        $this->view->setData("group", $group);

        return $this->edit($uri, $format , $group );

    }

    public function edit($uri, $format = 'html', $form = 'form')
    {
        //1. If ID is null, we are creating;
        if(empty($uri)) return $this->create();

        //If updating send to update
        if ($this->application->input->methodIs("PATCH")) {
            return $this->update($uri, $format);
        }

        //1. check this uer has permission to execute /page/create
        $this->checkPermission("execute");

        //2. load the page;
        $category = $this->application->createInstance(Model\Category::class);
        $category = $category->loadObjectByURI($uri);

        if (empty($category->getObjectId()) ) {
            throw new ErrorNotFoundException("The requested category does not exist");
            return false;
        }

        //print_R($page->getPropertyData());
        //$parser  = new \Parsedown::instance();
        $editing = $category->getPropertyData();

        //we need to decode the form;
        $editing["category_form"] = json_decode($editing["category_form"], true);

        //3. Get the authorities list
        $authorities = $this->application->createInstance( Authority::class );

        //print_R($authorities);

        //4. Set Properties
        $this->view->setData("authorities", $authorities->getAuthorities(), true);

        $this->view->setData("editing", $editing);
        $this->view->setData("sbstate", "minimized");
        $this->view->setData("method", "update");
        $this->view->setData("object_uri", $uri);
        $this->view->setData("csrftoken", $this->application->session->getCSRFToken());


        $this->view->addData("action", ["title"=>"Preview","link"=>"/data/{$uri}/add", "class"=>"btn-primary"]);

        $this->view->addToBlock("form", 'import://category/category-'.$form );

        $this->prepareLayoutWithTitle("category/category-editor", $category->getPropertyValue("media_title"). "");

    }

    public function canViewDataCategory($uri, $format=''){

        //Check if the current user can view this data;
        return true;
    }

    private function prepareLayoutWithTitle($layout, $title){

        $this->view->addToBlock("main", "import://".$layout );

        $this->view->setData("title", $title );
        $this->view->setLayout("member/dashboard");


        $this->application->observer->attach([$this, "extendAdminMenu"], "Layout.onCompile.menu.data");

    }


    public function extendAdminMenu($event)
    {

        $menuId = $event->getData("uid");
        $menuItems = (array)$event->getResult();

        if (preg_match("/^repoadmin:(\\d+[a-zA-Z0-9]{9})/", $menuId, $matches)) {

            $repoid = $matches[1];

            $menuItems = array_merge($menuItems, [
                    array(
                        "menu_title" => "Entity",
                        "menu_url" => "/admin/repository/{$repoid}/edit",
                    ),
                    array(
                        "menu_title" => "Attributes",
                        "menu_url" => "/admin/repository/{$repoid}/fields",
                    ),
                    array(
                        "menu_title" => "Values",
                        "menu_url" => "/admin/repository/{$repoid}/data",
                    ),
                    array(
                        "menu_title" => "Relations",
                        "menu_url" => "/admin/repository/{$repoid}/logic",
                    ),
                    array(
                        "menu_title" => "Analysis",
                        "menu_url" => "/admin/repository/{$repoid}/analysis",
                    ),
                    array(
                        "menu_title" => "Permissions",
                        "menu_url" => "/admin/repository/{$repoid}/permissions",
                    ),
                    array(
                        "menu_title" => "Notifications",
                        "menu_url" => "/admin/repository/{$repoid}/notifications",
                    )
                ]
            );


            return $event->setResult($menuItems);

        }
    }

    public function add()
    {

        //$this->view->setData("object_id", 0);

        //3. Get the authorities list
        $authorities = $this->application->createInstance( Authority::class );

        //print_R($authorities);

        //4. Set Properties
        $this->view->setData("authorities", $authorities->getAuthorities());
        $this->view->setData("csrftoken", $this->application->session->getCSRFToken());

        //$this->view->addToBlock("form", 'import://category/category-form' );

        $this->prepareLayoutWithTitle("category/category-new", "New repository");

    }

    public function delete()
    {
        echo "Deleting Category";
    }

    public function create()
    {

        //1. check this uer has permission to execute /page/create
        $this->checkPermission("execute");

        //2. create a blank page and redirect to edit;
        $category = $this->application->createInstance( Model\Category::class);
        //$page = $page->defineValueGroup("page");

        //3. Any input data?
        $input      = $this->application->input;
        $dispatcher = $this->application->dispatcher;

        if ($input->methodIs("POST")) { //because we are updating;

            $category = $this->bindFormData($category);

            //@TODO process form data;

            if (!$category->store()) {
                // throw new Exception("could not create the page");
                $this->response->addAlert("Category could not be created", "error");
                $dispatcher->returnToReferrer();

            }

            $this->response->addAlert("{$category->getPropertyValue("media_title")} category was created", "success");

            return $dispatcher->redirect("/admin/repository/{$category->getLastSavedObjectURI()}/edit");
        }


    }

    public function update($uri, $format = 'html')
    {

        //1. check this uer has permission to execute /page/create
        $this->checkPermission("execute");

        //2. are we patching or updating an existing?
        $input = $this->application->input;
        $dispatcher = $this->application->dispatcher;

        //$user = new User($this->application, $this->application->database, $this->application->session);

        if ($input->methodIs("PATCH")) { //because we are updating;

            //3. load the page;
            $category = $this->application->createInstance(Model\Category::class);
            $category = $category->loadObjectByURI($uri);

            //tell the form that we are using a proxy of the media table
            $category->defineValueGroup("media");

            //4. Is this a valid page?
            if ($category->getObjectId()) { //if we have a page;

                //Checks if the current user is the owner of this page or has special permissions to edit pages
                if ($category->getPropertyValue("media_owner") == $this->user->getPropertyValue("user_name_id") || $this->checkPermission( "special", "/admin/repository")) {

                    //if we have form data!

                    $category = $this->bindFormData($category); //binds input data;

                    //$category->setPropertyValue("media_published", Time::stamp())

                    if ($category->saveObject($category->getObjectURI(), $category->getObjectType(), $category->getObjectId())) {

                        $this->response->addAlert(t("Your category content has been updated successfully"), "success");

                        //Redirect to dashboard or to last url?
                        return $dispatcher->returnToReferrer();

                    }
                }
            }
        }

        $this->response->addAlert(t("The category content was not updated"), "warning");

        //Redirect to dashboard or to last url?
        return $dispatcher->returnToReferrer();
    }

    public function replace()
    {
        echo "Replacing...";
    }

    public function options()
    {
        echo "Options...";
    }



    private function bindFormData(Entity $category)
    {

        $inputModel = $category->getPropertyModel();
        $input = $this->application->input;

        // print_R($_POST);
        foreach ($inputModel as $property => $definition):
            $allowHtml = in_array($property, ['category_welcome', 'category_thankyou'])? true : false;
            $value = $input->getString($property, "", "post" , $allowHtml);
            if (!empty($value)):
                $category->setPropertyValue($property, $value);
            endif;
        endforeach;

        //update the order;
        $existingForm      = json_decode( $category->getPropertyValue("category_form"), true );
        $existingReduce    = function( $field ) use ( &$existingReduce ) {

            return "data_{$field['type']}_{$field['uri']}";

        };
        $existingFields    = array_map( $existingReduce , (array)$existingForm );


        $form = (array) $input->getArray("category_form", "", "post");

        //If we form fields to update, if not just skip this part
        //Also prevents fields from being deleted when the configure form is saved;
        if(!empty($form)) {

            //Store fields as per order;
            foreach ($form as $k => $field) {
                //because we are using timestamps to group on newly added elements
                //if(!isset($field['existing']) ) {
                unset($form[$k]);
                //}

                $end = end($field);
                $end["type"] = key($field);
                $end['order'] = $field['order'];

                //Field unique identifiers  are important for tracking data;
                $end["uri"] = empty($field["uri"]) ? getRandomString(10) : $field["uri"];

                //no empty choices;
                $choiceTypes = ["picturechoice", "multichoice"];

                if (in_array($end["type"], $choiceTypes)) {
                    $choices = $end["choice"];

                    foreach ((array)$choices as $c => $choice) {
                        if (empty($choice)) {
                            unset($choices[$c]);
                        }
                    }

                    $end["choice"] = $choices;
                }

                $form[$field['order']] = $end;


                //if this field is existing remove from the
                //existingfields array, and prevent its data from being dropped;
                if (($key = array_search("data_{$end['type']}_{$end['uri']}", $existingFields)) !== false) {
                    unset($existingFields[$key]);
                }
            }

            ksort($form);

            if (!empty($existingFields)) {
                $category->deleteProperties($existingFields);
            }

            //json encode form data;
            $category->setPropertyValue("category_form", json_encode($form));

        }

        return $category;

    }

}
