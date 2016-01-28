<?php

namespace Budkit\Repository\Controller;

use Budkit\Cms\Controller\Post;
use Budkit\Repository\Provider;
use Budkit\Repository\Model;
use Budkit\Cms\Helper\Menu;
use Budkit\Dependency\Container as Application;

class Data extends Post {

    public function __construct(Application $application, Menu $menu) {

        parent::__construct($application, $menu);

        $this->view->appendLayoutSearchPath( Provider::getPackageDir()."layouts/");

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

            $this->view->setData("last_step", strval(count($editing["category_form"]) + 1) );
            $this->view->setData("category", $editing);
            $this->view->setData("method", "update");
            $this->view->setData("object_uri", $uri);


        }

        $this->view->setData("csrftoken", $this->application->session->getCSRFToken());

        $this->view->setLayout('directory/form');
    }


    public function create($incategory, $format = 'html') {

        //1. check this uer has permission to execute /page/create
        $this->checkPermission("execute");

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
            $data->bindPropertyDataFromForm( $data , $form );

            //print_R($category->getPropertyValue("category_form"));
            //print_R($data->getPropertyData());
            //
            //$this->response->addAlert(t('Please provide at least a Name, Username, E-mail and Password'), "error");

           if(!$data->save( $incategory ) ){

               $this->response->addAlert(t('You data was not saved to the repository'), "error");

               throw new ErrorNotFoundException("Could not save data to the {$category->getPropertyValue("category_name")} repository");
               return false;
           }


            $this->response->addAlert(t('Your data has been saved successfully'), "success");

            //@TODO trigger on Repository.onNewData event

            //bind the data to the form;
            //$category = $this->bindFormData($category);
        }


        $dispatcher->returnToReferrer();
    }

}