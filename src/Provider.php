<?php

namespace Budkit\Repository;

use Budkit\Application\Support\Service;
use Budkit\Cms\Model\User;
use Budkit\Dependency\Container;
use Budkit\Repository\Model\Category;
use Route;

class Provider implements Service
{

    protected $application;


    public function __construct(Container $application)
    {
        $this->application = $application;
    }

    public static function  getPackageDir()
    {
        return __DIR__ . "/";
    }

    public function onRegister()
    {

        $config = $this->application->config;

        if ($config->get("setup.database.installed")) {

            //Extend the dashboardmenu
            $this->application->observer->attach([$this, "extendDashboardMenu"], "Layout.onCompile.menu.data");
        }

        //Check has permission
        $this->application->observer->attach([$this, "onLoadPostExtensions"], "Layout.load.post.extensions");

        //Manage stories
        $this->application->observer->attach([$this, "onPreparePostStory"], "Story.onPrepareStory");

        //load home page vars
        //$this->application->observer->attach([$this, "onHomePageLoad"], "Page.onHomePage");
        $this->application->observer->attach([$this, "onSinglePostLoad"], "Post.onPost");

        //Register a few more listeners
        //$this->application->observer->attach([$this, "onLoadPageTemplateDefinition"], "Layout.onLoad.page.template.definitions");
        $this->application->observer->attach([$this, "onLoadPostTemplateDefinition"], "Layout.onLoad.post.template.definitions");

        //Add Roues
        ////Grouping routes under a prefix;
        //
//        Route::attach("/admin/repository", Controller\Admin::class, function ($route) {
//            $route->setTokens(array(
//                'id' => '(\d+[a-zA-Z0-9]{9})?',
//                'format' => '(\.[^/]+)?',
//                'group'=> '([a-z]+)?'
//
//            ));
//            //subroutes
//            $route->add('{format}', 'index');
//
//            $route->attach('{/id}', Controller\Category::class, function ($route) {
//
//                $route->add('{format}', 'index');
//                $route->add('/add{format}', 'add');
//                $route->add('/edit{format}', "edit");
//                $route->addGet('/{group}{format}', "manage");
//                $route->addDelete('/delete{format}', 'delete');
//                $route->addPatch('/update{format}', 'update');
//
//            });
//        });

        Route::attach('/repository', Controller\Category::class, function ($route) {
            //The order of the token array should be the
            //the order of the params loaded;
            $route->setTokens(array(
                'repo' => '(\d+[a-zA-Z0-9]{9})?', //category id
                'id' => '(\d+[a-zA-Z0-9]{9})?', //item id
                'format' => '(\.[^/]+)?'
            ));

            $route->add('{format}', 'index')->setPermissionHandler("view", "canViewDataCategory");;

            $route->attach('{/id}', Controller\Category::class, function ($route) {

                $route->add('{format}', 'read')->setPermissionHandler("view", "canViewDataCategory");
                $route->add('/add{format}', 'add');
                $route->add('/edit{format}', "edit");
                $route->addGet('/{group}{format}', "manage");
                $route->addDelete('/delete{format}', 'delete');
                $route->addPatch('/update{format}', 'update');

            });
            
            //$route->setAction(Controller\Admin\Settings\Permissions::class);
//            $route->addGet('{format}', 'index')->setPermissionHandler("view", "canViewDataCategory");
//            $route->addGet('{/repo}{format}', 'read')->setPermissionHandler("view", "canViewDataCategory");

        });

        Route::attach("/data", Controller\Data::class, function ($route) {

            //The order of the token array should be the
            //the order of the params loaded;
            $route->setTokens(array(
                'repo' => '(\d+[a-zA-Z0-9]{9})?', //category id
                'id' => '(\d+[a-zA-Z0-9]{9})?', //item id
                'format' => '(\.[^/]+)?'
            ));
            //subroutes
            //$route->add('/explore{format}', "explore");
            $route->add('/{id}{format}', 'view')->setPermissionHandler("view", "canViewDataItem"); //show a particular listing
            $route->add('/{id}/edit{format}', "edit");
            $route->add('/{repo}/add{format}', "add")->setPermissionHandler("view", "canViewAdd");

            //storing an item in the repository;
            $route
                ->addPost('/{repo}/put{format}', 'create')
                ->setRequiredPermission("execute")
                ->setPermissionHandler("execute", "canExecuteCreate");

        });




    }

    public function onSinglePostLoad($event){

        //it is passed as a result, because it can be modified;
        $post   = $event->getResult();

        //If we are displaying a repository item?
        if (preg_match("/^repo:\/\/(\\d+[a-zA-Z0-9]{9})/", $post['object_type'], $matches)) {

            $repo = $this->application->createInstance(Model\Data::class);

            $post['media_data'] = $repo->getData( $post['object_uri'] );

            $post['media_template'] = "posts/post-single-repo";
            $post['media_title'] = "Host";

        }

        $event->setResult( $post );

    }


    public function onLoadPostTemplateDefinition($event)
    {

        //push your template name to the end of the template list;
        $templates = (array)$event->getResult(); //loads an array of already existing templates
        $templates[] = [
            "name" => "posts/post-single-repo",
            "source" => $this->getPackageDir() . "layouts" . DS
        ];

        $event->setResult($templates);
    }



    public function extendDashboardMenu($event)
    {

        $menuId = $event->getData("uid");
        $menuItems = (array)$event->getResult();

        //We only process the usermenu;
        if ($menuId !== "dashboardmenu") return;

        //check for a user here is unnecessary as permissions are checked by Menu\Tpl
        //$user = $this->application->createInstance( User::class );
        //$menuUser = $user->getCurrentUser();
//        foreach ($menuItems as $id => $menuItem) {
//            if ($menuItem["menu_url"] == "/admin/settings/configuration") {
                array_unshift($menuItems, array(
                        "menu_title" => "Explore",
                        "menu_url" => "/repository",
                    )
                );
//                array_push($menuItems, array(
//                        "menu_title" => "Repositories",
//                        "menu_url" => "/admin/repository",
//                    )
//                );
//                $menuItem['children'] = array_merge($menuItem['children'], [array(
//                    "menu_title" => "Repository",
//                    "menu_url" => "/admin/repository",
//                )]);
//                $menuItems[$id] = $menuItem;
//                break;
//            }
//        }
        return $event->setResult($menuItems);
    }

    public function onLoadPostExtensions($event)
    {

//        $extensions = (array)$event->getResult();
//        $extensions[] = [
//            "title" => "New Listing",
//            "link" => "/repository/add"
//        ];
//
//        $event->setResult($extensions);

    }


    public function onPreparePostStory($event){

        $story  = $event->getData();
        $graph  = $event->getResult();

        $repository = $this->application->createInstance( Category::class );
        //print_R($story);

        //if this is just a posted story;
        if($story->getName() == "addedtorepository"){

            $object = $story->getTail()->getData();

            $category = $repository->loadObjectByURI($object['data_category'], ['category_name', 'media_title'])->getPropertyData();

            $story->setData( $story->getTail()->getData() );

            //The stream_item_type key is super important
            //Without it the stream has no idea of knowing how to display its content
            //and the edge is actually removed from the stream;
            //story_type e.g posts/post-story
            //story_figure = [title , description, items = [ [type, cover, caption], [type, cover, caption] ] ]
            //story_object_prefix = [verb] e.g posted, added
            //story_object = [prefix, type, url] e.g host
            //story_target
            //so the story reads, "media_owner, story_action,  story_object ([to] story-target)"

            $story->addData("story_object", ['prefix'=>" added a new ", "type"=>$category['category_name'], "url"=>"/data/".$object['object_uri']] );
            //$story->addData("story_target", ['prefix'=>" to ", "type"=>"", "url"=>""] );

            $story->addData("story_type", "posts/post-story");
        }

        // print_R($graph);
    }

//    public function onHomePageLoad($event){
//
//        $data = $event->getData();
//
//        //print_r($data);
//        //Lets load some vars!
//        if($data['media_template'] == "directory-homepage"){
//
//            $category = $this->application->createInstance( Model\Category::class );
//
//            //$page = $page->defineValueGroup("page");
//            $categories = $category->getAllMedia("category");
//
//            $this->application->response->setParameter("categories", $categories);
//            //$this->application->response->addAlert(t("Howdy :)"), "warning");
//
//        }
//
//    }
//
//    public function onLoadPageTemplateDefinition($event)
//    {
//
//        //push your template name to the end of the template list;
//        $templates = (array)$event->getResult(); //loads an array of already existing templates
//        $templates[] = [
//            "name" => "directory-homepage",
//            "source" => $this->getPackageDir() . "layouts" . DS
//        ];
//
//        $event->setResult($templates);
//    }


    public function definition()
    {
        return ["app.register" => "onRegister"];
    }
}