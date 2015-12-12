<?php

namespace Budkit\Repository\Controller;

use Budkit\Repository\Provider;
use Budkit\Repository\Model;
use Budkit\Cms\Controller\Admin as CMSAdmin;
use Budkit\Cms\Helper\Menu;
use Budkit\Cms\Model\User;
use Budkit\Dependency\Container;
use Budkit\Datastore\Model\Entity;


class Category extends CMSAdmin
{
    public function __construct(Container $application, Menu $menu, User $user) {

        parent::__construct($application, $menu);

        $this->view->appendLayoutSearchPath(  Provider::getPackageDir()."layouts/");
        $this->user = $user->getCurrentUser();

    }


    public function index($format = 'html', $uri = "")
    {
        return $this->read($uri, $format);
    }


    public function read($uri, $format = 'html')
    {

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
        $this->view->addToBlock("main", 'import://directory/listings');
        $this->view->setLayout('directory/dashboard');


    }

    public function edit($uri, $format = 'html')
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

        $this->view->setData("editing", $editing);
        $this->view->setData("method", "update");
        $this->view->setData("object_uri", $uri);
        $this->view->setData("csrftoken", $this->application->session->getCSRFToken());
        $this->view->setData("title", $category->getPropertyValue("media_title"). " category" );
        $this->view->setLayout("categories/editor");

    }


    private function prepareLayoutWithTitle($title){

        $this->view->setData("title", $title );
        $this->view->setLayout("member/dashboard");

    }

    public function add()
    {

        //$this->view->setData("object_id", 0);
        $this->view->setData("title", "New Category");
        $this->view->setLayout("categories/editor");

        $this->view->setData("csrftoken", $this->application->session->getCSRFToken());

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

            return $dispatcher->redirect("/admin/repository/category/{$category->getLastSavedObjectURI()}/edit");
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
                if ($category->getPropertyValue("media_owner") == $this->user->getPropertyValue("user_name_id") || $this->checkPermission( "special", "/admin/repository/category")) {

                    //we will save the content as HTML
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
            $value = $input->getString($property, "", "post");
            if (!empty($value)):
                $category->setPropertyValue($property, $value);
            endif;
        endforeach;

        //update the order;
        $form = (array) $input->getArray("category_form", "", "post");


        //Store fields as per order;
        foreach( $form as $k=>$field){

            $end = end($field);
            $end["type"] = key($field);
            $end['order'] = $field['order'];

            //Field unique identifiers  are important for tracking data;
            $end["uri"] = empty($field["uri"]) ? getRandomString(10) : $field["uri"];

            //no empty choices;
            $choiceTypes = ["picturechoice","multichoice"];

            if(in_array($end["type"], $choiceTypes)){

                $choices = $end["choice"];

                foreach( (array)$choices as $c=>$choice){
                    if(empty($choice)){
                        unset($choices[$c]);
                    }
                }

                $end["choice"] = $choices;
            }

            $form[$field['order']] = $end;

            //because we are using timestamps to group on newly added elements
            if(!isset($field['existing'])) {
                unset($form[$k]);
            }
        }


        ksort($form);

        //json encode form data;
        $category->setPropertyValue("category_form", json_encode($form));

        return $category;

    }

}
