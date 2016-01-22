<?php

namespace Budkit\Repository\Model;


use Budkit\Cms\Model\Media\Collection;
use Budkit\Cms\Model\Media\Content;
use Budkit\Datastore\Database;
use Budkit\Dependency\Container;
use Budkit\Cms\Model\User;

class Category extends Content
{


    public function __construct(Database $database, Collection $collection, Container $application, User $user)
    {

        $this->encryptor = $application->encrypt;
        $this->config = $application->config;
        $this->database = $database;

        parent::__construct($database, $collection, $application, $user);

        $this->extendPropertyModel(
            array(
                "category_name" => array("Category Name", "mediumtext", 50),
                "category_icon" => array("Category icon", "mediumtext", 50),
                "category_welcome" => array("Category Welcome Message", "mediumtext", 1000),
                "category_thankyou" => array("Category Thank you Message", "mediumtext", 1000),
                "category_colour" => array("Category Colour", "mediumtext", 50),
                "category_form_progressbar_type" => array("Category Progressbar Type", "smallint", 10, 1),
                "category_form" => array("Category form", "varchar", 2000),
            ), "category"
        );

        //We want to store category content in media group;
        $this->defineValueGroup("media");

        //Pagination
        $currentpage = $application->input->getInt("page", "1", "attribute");
        $this->setState("currentpage", (int)$currentpage);

    }

}