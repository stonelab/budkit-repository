<?php

namespace Budkit\Repository;

use Budkit\Application\Support\Service;
use Budkit\Cms\Model\User;
use Budkit\Dependency\Container;
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
        //Register a few more listeners
        $this->application->observer->attach([$this, "onLoadPageTemplateDefinition"], "Layout.onLoad.page.template.definitions");

        //Check has permission
        $this->application->observer->attach([$this, "onLoadPostExtensions"], "Layout.load.post.extensions");

        //Add Roues
        ////Grouping routes under a prefix;
        //
        Route::attach("/admin/repository", Controller\Admin::class, function ($route) {
            $route->setTokens(array(
                'id' => '(\d+[a-zA-Z0-9]{9})?',
                'format' => '(\.[^/]+)?'
            ));
            //subroutes
            $route->add('{format}', 'index');

            $route->attach('/category', Controller\Category::class, function ($route) {

                //$route->setAction(Controller\Admin\Settings\Permissions::class);
                $route->addGet('{format}', 'index');
                $route->add('{format}', 'index');
                $route->add('/add{format}', 'add');
                $route->add('{/id}{format}', "view");
                $route->add('{/id}/edit{format}', "edit");
                $route->addDelete('/{id}/delete{format}', 'delete');
                $route->addPatch('/{id}/update{format}', 'update');

            });
        });

        Route::attach("/repository", Controller\Listing::class, function ($route) {
            $route->setTokens(array(
                'id' => '(\d+[a-zA-Z0-9]{9})?', //category id
                'item' => '(\d+[a-zA-Z0-9]{9})?', //category id
                'format' => '(\.[^/]+)?'
            ));
            //subroutes
            $route->add('{/item}{format}', 'index'); //show a particular listing
            $route->add('{/item}/view{format}', "view");
            $route->add('{/item}/edit{format}', "edit");
            $route->add('{/id}/add{format}', "add");

            $route->attach('/category', Controller\Category::class, function ($route) {
                //$route->setAction(Controller\Admin\Settings\Permissions::class);
                $route->addGet('{/id}{format}', 'index');
                $route->addGet('{/id}/view{format}', "view");

            });
        });

        $config = $this->application->config;

        if ($config->get("setup.database.installed")) {

            //Extend the dashboardmenu
            $this->application->observer->attach([$this, "extendUserMenu"], "Layout.onCompile.menu.data");
        }
    }

    public function extendUserMenu($event)
    {

        $menuId = $event->getData("uid");
        $user = $this->application->createInstance(User::class);

        //We only process the usermenu;
        if ($menuId !== "dashboardmenu") return;

        //check for a user here is unnecessary as permissions are checked by Menu\Tpl
        $menuItems = (array)$event->getResult();
        $menuUser = $user->getCurrentUser();

        if ($menuUser->isAuthenticated()) {
            array_push($menuItems, array(
                    "menu_title" => "Repository",
                    "menu_url" => "/admin/repository",
                )
            );
            $event->setResult($menuItems);
        }

    }

    public function onLoadPostExtensions($event)
    {

        $extensions = (array)$event->getResult();
        $extensions[] = [
            "title" => "New Listing",
            "link" => "/repository/add"
        ];

        $event->setResult($extensions);

    }

    public function onLoadPageTemplateDefinition($event)
    {

        //push your template name to the end of the template list;
        $templates = (array)$event->getResult(); //loads an array of already existing templates
        $templates[] = [
            "name" => "directory-homepage",
            "source" => $this->getPackageDir() . "layouts" . DS
        ];

        $event->setResult($templates);
    }


    public function definition()
    {
        return ["app.register" => "onRegister"];
    }
}