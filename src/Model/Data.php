<?php

namespace Budkit\Repository\Model;


use Budkit\Cms\Model\Media\Collection;
use Budkit\Datastore\Database;
use Budkit\Cms\Model\Media\Content;
use Budkit\Datastore\Model\Entity;
use Budkit\Dependency\Container;
use Budkit\Cms\Model\User;

class Data extends Content
{

    public function __construct(Database $database, Collection $collection, Container $application, User $user)
    {
        parent::__construct($database, $collection, $application, $user);

        $this->collection   = $collection;
        $this->input        = $application->input;
        $this->user         = $user->getCurrentUser();

        //"label"=>"","datatype"=>"","charsize"=>"" , "default"=>"", "index"=>TRUE, "allowempty"=>FALSE
        $this->extendPropertyModel(array(
            "data_category" => array("Category", "varchar", 50),
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

    public function bindPropertyDataFromForm(Entity &$repository, array $form = [])
    {
        $inputModel = $this->getPropertyModel();
        $input = $this->input;

        foreach ($inputModel as $property => $definition):

            if(isset($_POST[$property]) && is_array($_POST[$property])){
                $value = json_encode( $input->getArray($property, [], "post"));
            }else{
                $value = $input->getString($property, "", "post");
            }

            //@TODO validate value based on property type!


            if (!empty($value)):
                $repository->setPropertyValue($property, $value);
            endif;
        endforeach;


        $repository->setPropertyValue("media_owner", $this->user->getPropertyValue("user_name_id"));


        return $repository;
    }

    /**
     * Adds a new media object to the database
     *
     * @return boolean Returns true on save, or false on failure
     */
    public function save($category, $objectURI = null)
    {
        //load the
        //@TODO determine the user has permission to post or store this object;
        $this->setPropertyValue("data_owner", $this->user->getPropertyValue("user_name_id"));
        $this->setPropertyValue("data_category", $category);

        //Determine the target
        if (!$this->saveObject($objectURI, $category)) { //category uri, because the data object type!
            //There is a problem! the error will be in $this->getError();
            return false;
        }
        return true;
    }
}