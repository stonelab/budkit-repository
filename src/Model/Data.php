<?php

namespace Budkit\Repository\Model;


use Budkit\Cms\Model\Media\Collection;
use Budkit\Datastore\Database;
use Budkit\Datastore\Model\Entity;
use Budkit\Dependency\Container;
use Budkit\Cms\Model\User;

class Data extends Entity
{

    public function __construct(Database $database, Collection $collection, Container $application, User $user)
    {
        parent::__construct($database, $application);

        $this->collection   = $collection;
        $this->input        = $application->input;
        $this->user         = $user->getCurrentUser();

        //"label"=>"","datatype"=>"","charsize"=>"" , "default"=>"", "index"=>TRUE, "allowempty"=>FALSE
        $this->definePropertyModel(array(
            "data_category" => array("Category", "varchar", 50),
            "data_owner" => array("Created by", "varchar", 50),
        ), "media");

        $this->defineValueGroup("media");
        $this->setListOrderBy(array("o.object_updated_on"), "DESC");

        //Pagination
        $currentpage = $application->input->getInt("page", "1", "attribute");
        $this->setState("currentpage", (int) $currentpage);
    }


    public function extendPropertyModelWithFields(array $fields){

        $properties = [];

        foreach($fields as $field){
            $properties["data_".$field["type"]."_".$field["uri"]] = [
                    "data_".$field["type"]."_".$field["uri"], "varchar", "10000" //@TODO will need to be more restrictive with types
            ];
        }

        $this->extendPropertyModel( $properties , "media");
    }

    public function bindPropertyDataFromForm()
    {
        $inputModel = $this->getPropertyModel();
        $input = $this->input;

        print_R($inputModel);

        // print_R($_POST);
        foreach ($inputModel as $property => $definition):
            $value = $input->getString($property, "", "post");
            echo $value;
            if (!empty($value)):
                $this->setPropertyValue($property, $value);
            endif;
        endforeach;

        print_R($this->getPropertyData());

        return $this;
    }

    /**
     * Adds a new media object to the database
     * @return boolean Returns true on save, or false on failure
     */
    public function store($category, $objectURI = null)
    {
        //load the
        //@TODO determine the user has permission to post or store this object;
        $this->setPropertyValue("data_owner", $this->user->getPropertyValue("user_name_id"));
        $this->setPropertyValue("data_category", $category);

        //Determine the target
        if (!$this->saveObject($objectURI, $this->getObjectType())) {
            //There is a problem! the error will be in $this->getError();
            return false;
        }
        return true;
    }
}