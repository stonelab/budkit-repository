<?php

namespace Budkit\Repository\Model;


use Budkit\Cms\Model\Media\Attachment;
use Budkit\Cms\Model\Media\Collection;
use Budkit\Datastore\Database;
use Budkit\Cms\Model\Media\Content;
use Budkit\Datastore\Model\Entity;
use Budkit\Dependency\Container;
use Budkit\Cms\Model\User;

class Data extends Content
{

    //Validate by type;
    protected $validators = [];


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
                "data_".$field["type"]."_".$field["uri"], "varchar", "10000"
            ];

            //Location, and date times have 'extra hidden fields'
            switch($field["type"]){
                case "location":
                    $properties["data_".$field["type"]."_".$field["uri"]."_lat"] = [
                        "data_".$field["type"]."_".$field["uri"]."_lat", "varchar", "10"
                    ];
                    $properties["data_".$field["type"]."_".$field["uri"]."_lng"] = [
                        "data_".$field["type"]."_".$field["uri"]."_lng", "varchar", "10"
                    ];
                    break;
                case "datetime":
                    $properties["data_".$field["type"]."_".$field["uri"]."_year"] = [
                        "data_".$field["type"]."_".$field["uri"]."_year", "smallint", 10
                    ];
                    $properties["data_".$field["type"]."_".$field["uri"]."_month"] = [
                        "data_".$field["type"]."_".$field["uri"]."_month", "smallint", 10
                    ];
                    $properties["data_".$field["type"]."_".$field["uri"]."_day"] = [
                        "data_".$field["type"]."_".$field["uri"]."_day", "smallint", 10
                    ];
                    $properties["data_".$field["type"]."_".$field["uri"]."_hour"] = [
                        "data_".$field["type"]."_".$field["uri"]."_hour", "smallint", 10
                    ];
                    $properties["data_".$field["type"]."_".$field["uri"]."_min"] = [
                        "data_".$field["type"]."_".$field["uri"]."_min", "smallint", 10
                    ];
                    break;

                default : //do nothing;
                    break;
            }
        }

        $this->extendPropertyModel( $properties , "media");
    }

    private function groupFilesArray( Array $files ){

            $result = array();
            foreach($files as $key1 => $value1)
                foreach($value1 as $key2 => $value2)
                    $result[$key2][$key1] = $value2;
            return $result;

    }

    public function bindPropertyDataFromForm(Entity &$repository, array $form = [], User $owner = null)
    {
        $inputModel = $this->getPropertyModel();
        $input = $this->input;
        $owner = empty($owner)? $this->user : $owner;

        $post  = $input->data('post');
        $files = $input->data('files') ;

        //@TODO look inside files array
        // If there are files paired to a key matching the property model array
        // and owner is not empty?, upload the files to the owners page,
        // then pair the files uris an a json encode array to the property model;

        foreach ($files as $property => $file){

            //If the file input field is a defined form field?
            if(isset($inputModel[$property])  && !empty($owner)){

                if(is_array($file) && !empty($file)){

                    $uploads = [];

                    //group the property files array if multiple files are uploaded
                    $attachments = $this->groupFilesArray( $file  );

                    foreach($attachments as $attachment){

                        $entity = $this->container->createInstance( Attachment::class );
                        $entity->setOwnerNameId( $owner->getPropertyValue("user_name_id") );

                        if( !( $saved = $entity->save( $attachment ) ) ){
                            throw new \Exception("Could not upload the requested file");
                            return false;
                        }

                        $uploads[] = $entity->getLastSavedObjectUri();
                    }

                    //save the uploaded files as array;
                    $repository->setPropertyValue( $property , json_encode($uploads));

                }
            }
        }

        //Set additional property details;
        foreach ($inputModel as $property => $definition):

            //This post hack, is so we can collect array data e.g from multiselect;
            if(isset($post[$property]) && is_array($post[$property])){
                $value = json_encode( $input->getArray($property, [], "post"));
            }else{
                $value = $input->getString($property, "", "post");
            }

            //@TIME property;

            //@TODO validate value based on property type!
            if (!empty($value)):
                $repository->setPropertyValue($property, $value);
            endif;

        endforeach;

        //Who owns this data?
        $repository->setPropertyValue("media_owner", $owner->getPropertyValue("user_name_id") );


        //print_r($repository->getPropertyData()); die;


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