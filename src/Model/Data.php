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
        if (!$this->saveObject($objectURI, "repo://".$category)) { //category uri, because the data object type!
            //There is a problem! the error will be in $this->getError();
            return false;
        }
        return true;
    }


    /**
     * Returns the category group data;
     *
     * @param $dataURI
     */
    public function getData( $dataURI , $inCategory = "" ){

        //2. load the category;
        $data       = $this->loadObjectByURI( $dataURI );

        //We need to have loaded an object;
        if(empty($data->getObjectType())) return [];

        //Get the category definition, the data type is the URI of the category
        $category   = $this->container->createInstance( Category::class );
        $category   = $category->loadObjectByURI( $data->getPropertyValue("data_category") );


        //print_R($category->getPropertyData());

        //Build the category form;
        $existingField = [];
        $existingForm      = json_decode( $category->getPropertyValue("category_form"), true );
        $existingReduce    = function( $field ) use ( &$existingReduce, &$existingField ) {

            $key = "data_{$field['type']}_{$field['uri']}";
            $existingField[ $key ] = $field;

            //modifier fields;
            if($field['type'] == "location"){
                $existingField[ $key."_lat" ] = null;
                $existingField[ $key."_lng" ] = null;
            }

            if($field['type'] == "datetime"){
                $existingField[ $key."_year" ] = null;
                $existingField[ $key."_month" ] = null;
                $existingField[ $key."_day" ] = null;
                $existingField[ $key."_hour" ] = null;
                $existingField[ $key."_min" ] = null;
                $existingField[ $key."_sec" ] = null;
            }

            return $key;

        };


        $dataFields   =  array_map( $existingReduce , (array)$existingForm );
        //$displayFields=  array_merge( ["object_uri"], $dataFields );

        //Get the category Data;
        $results = $this->getObjectsList( $data->getObjectType(), array_keys($existingField) , $data->getObjectURI() );
        $row     = current( $results->fetchAll() );
        $user    = $this->container->createInstance( User::class );


        array_filter( $row , function( &$item, $key ) use ( &$row, &$existingField , $user ) {

            if( array_key_exists( $key, $existingField )){

                $defintion = $existingField[$key];

                if(isset($defintion['authority']) && $user->isMemberOfAuthorityGroup( $defintion['authority'] , true)) {

                    $existingField[$key]["value"] = $item;
                    $existingField[$key]["template"] = "data/display/".$defintion['type'];

                    //datetime modifiers
                    if($defintion['type'] == "datetime"){
                        $existingField[$key]["value"] = date(
                            "Y-m-d H:i:s",
                            mktime($row[$key."_hour"],$row[$key."_min"],$row[$key."_sec"],$row[$key."_month"],$row[$key."_day"],$row[$key."_year"])
                        );
                        unset($row[$key."_year"],$row[$key."_month"],$row[$key."_day"],$row[$key."_hour"],$row[$key."_min"],$row[$key."_sec"]);
                    }


                    //location modifiers
                    if($defintion['type'] == "location"){

                        $existingField[$key]["lat"] = $row[$key."_lat"];
                        $existingField[$key]["lng"] = $row[$key."_lng"];

                        unset($row[$key."_lat"]);
                        unset($row[$key."_lng"]);

                    }

                    if(in_array($defintion['type'], ["dropdown", "fileupload"]) ||
                        ( $defintion['type'] == "multichoice" && $defintion["multiselect"] == 1 ) ){

                        $existingField[$key]["value"] = json_decode( $item , true );
                    }

                    //Some fields are not needed;
                    if(isset($existingField[$key]["choices"])){
                        unset($existingField[$key]["choices"]);
                    }

                    $row[$key] = $existingField[$key];

                    //return $existingField[$key];
                    return true;

                }else{
                    unset($row[$key]);
                }
            }else{
                unset($row[$key]);
            }
        }, ARRAY_FILTER_USE_BOTH);

        return $row;

    }



}