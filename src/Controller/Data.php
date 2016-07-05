<?php

namespace Budkit\Repository\Controller;

use Budkit\Cms\Controller\Post;
use Budkit\Cms\Model\Story;
use Budkit\Cms\Model\User;
use Budkit\Repository\Provider;
use Budkit\Repository\Model;
use Budkit\Cms\Helper\Menu;
use Budkit\Dependency\Container as Application;

class Data extends Post {

    public function __construct(Application $application, Menu $menu, User $user) {

        parent::__construct($application, $menu);

        $this->user = $user->getCurrentUser();
        $this->view->appendLayoutSearchPath( Provider::getPackageDir()."layouts/");

    }

    public function canViewDataItem($uri, $format=''){

        //Check if the current user can view this data;
        return true;
    }


    public function explore(){
        
    }


    public function view( $id, $format = 'html')
    {
       parent::read($id, $format);
    }

    public function canViewAdd($uri, $format=''){

        //1. If ID is null, we are creating;
        if (empty($uri) ) {
            throw new ErrorNotFoundException("Cannot add data to an undefined category");
            return false;
        }

        //2. load the page;
        $category = $this->application->createInstance(Model\Category::class);

        if(!empty($uri)) {
            $category = $category->loadObjectByURI($uri);

            if (empty($category->getObjectId())) {
                throw new ErrorNotFoundException("The requested category does not exist");
                return false;
            }

            //Check if the user is a memberOfTheAuthority group allowed to submit to this category;
            if($this->user->isMemberOfAuthorityGroup( $category->getPropertyValue("category_submit_permission"))){
                return true;
            }
        }

        return false;

    }

    public function add($uri, $format = 'html') {

        $this->view->setData("title", "Add new");

        //1. check this uer has permission to execute /page/create
        //$this->checkPermission("execute"); will use a custom canViewAddFor() method to check for permission

        //2. load the page;
        $category       = $this->application->createInstance(Model\Category::class);
        $signupfields   = $category->getSignUpFormFields();

        //throw new \Exception("Just say hi");

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

            //if user is not logged in, preprend user login form;
            if(!$this->user->getCurrentUser()->isAuthenticated()){
                //add the signup fields tothe form;
                $form = [];
                $fields = $signupfields + $editing["category_form"];

                $index = 1;
                foreach( $fields as $k=>$field){

                    $field["order"] = (string)$index;
                    $form[] = $field;
                    $index++;
                }

                //print_r($form);

                $editing["category_form"] = $form;
                $this->view->setData("signup_warning", true);
            }

            $this->view->setData("last_step", strval(count($editing["category_form"]) + 1) );
            $this->view->setData("category", $editing);
            $this->view->setData("method", "update");
            $this->view->setData("object_uri", $uri);


        }

        $this->view->setData("csrftoken", $this->application->session->getCSRFToken());

        $this->view->setLayout('data/form');
    }


    //permission call checker for add method;
    public function canExecuteCreate($uri, $format = 'html' ){


        //1. If ID is null, we are creating;
        if (empty($uri) ) {
            throw new ErrorNotFoundException("Cannot add data to an undefined category");
            return false;
        }

        //2. load the page;
        $category = $this->application->createInstance(Model\Category::class);

        if(!empty($uri)) {
            $category = $category->loadObjectByURI($uri);

            if (empty($category->getObjectId())) {
                throw new ErrorNotFoundException("The requested category does not exist");
                return false;
            }


            //if user is not authenticated!
            if(!$this->user->isAuthenticated()){

                //print_R($this->application->input->data("post"));

                //create the user;
                $data = [
                    //2. Prevalidate passwords and other stuff;
                    "user_first_name" => $this->application->input->getString("data_shorttext_user_first_name", "", "post", FALSE, array()),
                    "user_last_name" => $this->application->input->getString("data_shorttext_user_last_name", "", "post", FALSE, array()),
                    "user_name_id" => $this->application->input->getString("data_shorttext_user_name_id", "", "post", FALSE, array()),
                    "user_gender" => $this->application->input->getString("data_multichoice_user_gender", "", "post", FALSE, array()),
                    "user_password" => $this->application->input->getString("data_password_user_password", "", "post", FALSE, array()),
                    "user_password_2" => $this->application->input->getString("data_password_user_password_2", "", "post", FALSE, array()),
                    "user_email" => $this->application->input->getString("data_email_user_email", "", "post", FALSE, array())
                ];


                //print_R($data);die;

                if( ($this->user = $this->user->createUserWithValidatedData( $data) ) == false) {
                    $this->response->addAlert(t('An account could not be created for the data you just submitted. You data was not saved to the repository'), "error");
                    return false;
                }

                return true;
            }

            //Check if the user is a memberOfTheAuthority group allowed to submit to this category;
            if($this->user->isMemberOfAuthorityGroup( $category->getPropertyValue("category_submit_permission"))){
                return true;
            }
        }

        return false;

    }

    public function create($incategory, $format = 'html') {

        //1. check this uer has permission to execute /page/create
        //$this->checkPermission("execute");

        //3. Any input data?
        $input      = $this->application->input;
        $dispatcher = $this->application->dispatcher;

        if ($input->methodIs("POST")) { //because we are updating;

            //2. Load the data category
            $category = $this->application->createInstance(Model\Category::class);
            $category = $category->loadObjectByURI($incategory);

            if (empty($category->getObjectId())) {
                throw new ErrorNotFoundException("The requested category does not exist");
                return false;
            }

            //extend the data model based on the category form;
            $data = $this->application->createInstance(Model\Data::class);
            $form = json_decode( $category->getPropertyValue("category_form") ,  true);

            $data->extendPropertyModelWithFields( $form );

            $data->bindPropertyDataFromForm( $data , $form , $this->user );

            //print_R($category->getPropertyValue("category_form"));
            //$this->response->addAlert(t('Please provide at least a Name, Username, E-mail and Password'), "error");

           if(!$data->save( $incategory ) ){

               $this->response->addAlert(t('You data was not saved to the repository'), "error");

               throw new ErrorNotFoundException("Could not save data to the {$category->getPropertyValue("category_name")} repository");
               return false;
           }else{

               //Now create a new user story
               $post  = $data->loadObjectByURI( $data->getLastSavedObjectURI() );
               $story = $this->application->createInstance( Story::class );

               if( !$story->create( $this->user, "addedtorepository", $post ) ){

                   $this->response->addAlert("Your post was submitted, but an error occurred whilst adding it to the timeline", "warning");

               }

           }

            $this->response->addAlert(t('Your data has been saved successfully'), "success");

            //@TODO trigger on Repository.onNewData event

            //bind the data to the form;
            //$category = $this->bindFormData($category);
        }


        $dispatcher->returnToReferrer();
    }

}