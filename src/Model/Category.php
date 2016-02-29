<?php

namespace Budkit\Repository\Model;


use Budkit\Cms\Model\Media\Collection;
use Budkit\Cms\Model\Media\Content;
use Budkit\Datastore\Database;
use Budkit\Dependency\Container;
use Budkit\Cms\Model\User;

class Category extends Content
{

    protected $signup = array (

        "first_name"=>array (
            'question' => 'What is your FIRST Name?',
            'required' => '1',
            'placeholder' => 'Click here to enter your first or given name',
            'description' => '',
            'type' => 'shorttext',
            'order' => '1',
            'uri' => 'user_first_name',
        ),
        "last_name"=>array (
            'question' => 'What is your LAST name?',
            'required' => '1',
            'placeholder' => 'Click here to enter your last, surname or family name',
            'description' => '',
            'type' => 'shorttext',
            'order' => '2',
            'uri' => 'user_last_name',
        ),
        "dob"=>array (
            'question' => 'On what date where you born?',
            'required' => '1',
            'range' =>
                array (
                    'start' => '-70',
                    'stop' => '-18', //People signing up must be at least 18 years of age
                ),
            'description' => '',
            'type' => 'datetime',
            'order' => '3',
            'uri' => 'user_dob', //will need to split this into user_dob_day, user_dob_month & user_dob_year
        ),
        "gender"=>array (
            'question' => 'What is your gender?',
            'required' => '1',
            'multiselect' => '0',
            'customchoice' => '0',
            'verticallist' => '1',
            'choice' =>
                array (
                    0 => 'Male',
                    1 => 'Female',
                    2 => 'Other',
                ),
            'description' => '',
            'type' => 'multichoice',
            'order' => '4',
            'uri' => 'user_gender',
        ),
        "email"=>array (
            'question' => 'What is your primary E-mail address?',
            'required' => '1',
            'placeholder' => 'Click here to enter E-mail e.g john.doe@internet.org',
            'description' => 'Please provide a valid email address. We shall send you important information regarding your application. Also note that should this email already match an existing account on our system, your submission will fail. If you are already registered please Log in before submitting this form',
            'type' => 'email',
            'order' => '5',
            'uri' => 'user_email',
        ),
        "user_name_id"=>array (
            'question' => 'Choose a short unique Username Id',
            'required' => '1',
            'placeholder' => 'Click here to enter an alphanumeric username Id to identify your account',
            'description' => '',
            'type' => 'shorttext',
            'order' => '2',
            'uri' => 'user_name_id',
        ),
        "password"=>array (
            'question' => 'Choose a Password',
            'required' => '1',
            'placeholder' => 'Click enter your password',
            'description' => '',
            'type' => 'password',
            'order' => '6',
            'uri' => 'user_password',
        ),
        "password2"=>array (
            'question' => 'Enter this password again',
            'required' => '1',
            'placeholder' => 'Click enter your password again',
            'description' => '',
            'type' => 'password',
            'order' => '7',
            'uri' => 'user_password_2',
        )
    );

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
                "category_submit_permission" => array("Category Submit Permission", "smallint", 10, 1),
                "category_view_permission" => array("Category View Permission", "smallint", 10, 1),
                "category_form" => array("Category form", "varchar", 2000),
            ), "category"
        );

        //We want to store category content in media group;
        $this->defineValueGroup("media");

        //Pagination
        $currentpage = $application->input->getInt("page", "1", "attribute");
        $this->setState("currentpage", (int)$currentpage);

    }

    public function getSignUpFormFields(){
        return $this->signup;
    }
}