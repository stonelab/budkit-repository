<?xml version="1.0" encoding="utf-8"?>
<tpl:layout name="page-homepage" extends="index" xmlns:tpl="http://budkit.org/tpl">
    <tpl:remove path="//div[@role='side']"/>
    <tpl:remove path="//div[@role='aside']"/>
    <tpl:replace path="//div[@role='main']">
        <div class="container-main">
            <div class="container-navigation lg">
                <tpl:import name="navigation"/>
            </div>
            <div class="container-block">
                <div class="hero">
                    <div class="container">
                        <div class="row page-content">
                            <div class="rw-welcome unit-2 white text-center">
                                <img src="/theme/assets/img/how-it-works.png" class="mtm mbm" />
                                <div class="row mtm mbl">
                                    <div class="col-md-3">
                                        <img src="http://www.refugees-welcome.net/wp-content/uploads/2014/02/so-funktioniert-fluechtlinge-willkommen-1.png" />
                                        <p class="mtl plm prm">
                                            You sign up with details of your (shared) flat or house. We simply need some information on your housing situation for a best possible match.
                                        </p>
                                    </div>
                                    <div class="col-md-3">
                                        <img src="http://www.refugees-welcome.net/wp-content/uploads/2014/02/so-funktioniert-fluechtlinge-willkommen-2.png" />
                                        <p class="mtl plm prm">
                                            Through a refugee organisation, or via our local 'buddies' we will put you in touch with a person who fled to your city.
                                        </p>
                                    </div>
                                    <div class="col-md-3">
                                        <img src="http://www.refugees-welcome.net/wp-content/uploads/2014/02/so-funktioniert-fluechtlinge-willkommen-3.png" />
                                        <p class="mtl plm prm">
                                            We may be able to help you find ways to finance the rent<sup>*</sup>. This may be very dependent on the legal status of the refugee or asylum seeker
                                        </p>
                                    </div>
                                    <div class="col-md-3">
                                        <img src="http://www.refugees-welcome.net/wp-content/uploads/2014/02/so-funktioniert-fluechtlinge-willkommen-4.png" />
                                        <p class="mtl plm prm">
                                            Your new flatmate will move in! Of course we will continue to support you in anyway possible, especially via our growing network of local reps
                                        </p>
                                    </div>
                                </div>
                                <div class="mtl mbm">
                                    <div class="btn-group">
                                        <a href="/listing/add" class="btn btn-lg btn-embossed btn-warning mrm">Sign-up to Host a refugee</a>
                                        <a href="/listing/add" class="btn btn-lg btn-embossed btn-warning mrm">Are you a refugee?</a>
                                        <a href="#" class="btn btn-lg btn-embossed btn-default mrm">Become a local buddy</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="container marketing mtl">

                    <div class="testimonial">
                        <blockquote>
                            We facilitate the housing of refugees who make it to the United Kingdom in private, shared accommodation offered by people just like you.
                        </blockquote>
                        <p class="author"><a href="#">Find out more...</a></p>
                    </div>

                    <hr class="featurette-divider" />

                    <div class="row featurette">
                        <div class="col-md-1"><i class="ionicons icon ion-alert mtl ion-ios-medical-outline"></i></div>
                        <div class="col-md-5">
                            <h2 class="featurette-heading">Help first. Politics later</h2>
                            <p class="lead">Are you unhappy with the current narrative on the refugee crisis and the lack of government engagement with the issue? Join us in helping refugees who have made it to Britain settle in a free room in yours or a neighbours available shared flat?</p>

                        </div>
                        <div class="col-md-1"><i class="ionicons icon ion-alert mtl ion-ios-medical-outline"></i></div>
                        <div class="col-md-5">
                            <h2 class="featurette-heading">No Stigma or Prejudice</h2>
                            <p class="lead">We are convinced that refugees should not be stigmatized and excluded by being housed in mass accommodations. Instead, we should offer them a warm welcome. We believe we can establish a more humane culture of welcoming refugees</p>

                        </div>
                    </div>

                    <hr class="featurette-divider" />
                    <div class="page-header marketing-title">
                        <h1>Get Involved</h1>
                        <p>Here are three key ways in which you can help us help them</p>
                    </div>
                    <div class="row services text-center">
                        <div class="col-xs-12 col-md-4">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div class="the-service">
                                        <h1>Host</h1>
                                    </div>
                                    <table class="table table-striped text-center">
                                        <tbody><tr>
                                            <td>Host a refugee or asylum seeker</td>
                                        </tr>
                                        <tr>
                                            <td>Support refugee integration</td>
                                        </tr>
                                        <tr>
                                            <td>Promote cultural exchange</td>
                                        </tr>
                                        <tr>
                                            <td>Join a growing network of hosts</td>
                                        </tr>
                                        <tr>
                                            <td>Weekly Reports</td>
                                        </tr>
                                        </tbody></table>
                                </div>
                                <div class="panel-footer">
                                    <a href="/budkit-old/#" class="btn btn-primary btn-lg" role="button">Become a Host</a>
                                </div>
                            </div>
                        </div>
                        <div class="col-xs-12 col-md-4">
                            <div class="panel panel-success">

                                <div class="panel-body">
                                    <div class="the-service">
                                        <h1>Facilitate</h1>
                                    </div>
                                    <table class="table table-striped text-center">
                                        <tbody><tr>
                                            <td>Represent us locally in your area</td>
                                        </tr>
                                        <tr>
                                            <td>Facilitate host/refugees meet-ups</td>
                                        </tr>
                                        <tr>
                                            <td>Relay information to host &amp; refugee</td>
                                        </tr>
                                        <tr>
                                            <td>Provide feedback to the team</td>
                                        </tr>
                                        <tr>
                                            <td>Weekly Reports</td>
                                        </tr>
                                        </tbody></table>
                                </div>
                                <div class="panel-footer">
                                    <a href="/budkit-old/#" class="btn btn-primary btn-lg" role="button">Become a Buddy</a>
                                </div>
                            </div>
                        </div>
                        <div class="col-xs-12 col-md-4">
                            <div class="panel panel-info">
                                <div class="panel-body">
                                    <div class="the-service">
                                        <h1>Donate</h1>
                                    </div>
                                    <table class="table table-striped text-center">
                                        <tbody><tr>
                                            <td>Support us financially</td>
                                        </tr>
                                        <tr>
                                            <td>Donate to other charities</td>
                                        </tr>
                                        <tr>
                                            <td>Support a host finance rent</td>
                                        </tr>
                                        <tr>
                                            <td>Help a facilitator cover costs</td>
                                        </tr>
                                        <tr>
                                            <td>Spread the word</td>
                                        </tr>
                                        </tbody></table>
                                </div>
                                <div class="panel-footer">
                                    <a href="/budkit-old/#" class="btn btn-primary btn-lg" role="button">Donate</a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <hr class="featurette-divider" />
                </div>
                <tpl:import name="foot"/>
                <script data-main="/theme/assets/js/main">
                    <![CDATA[
                    require(['config'], function(){
                        require(['autobahn'], function(autobahn){
                            var connection = new autobahn.Connection({
                                url: 'ws://0.0.0.0:8080',
                                realm: 'pubsub',
                                onchallenge: function(session, method, extra){
                                    console.log("challenge session", session);
                                    console.log("challenge method", method);
                                    console.log("challenge extra", extra );
                                    return "jasgwegsdfs"; //should return a token, maybe the sessionId
                                },
                                authmethods: ['budkit_cms']
                            });
                            connection.onopen = function (session) {

                                //subscribe to a topic
                                function onevent(args) {
                                    console.log("Someone published this to 'com.example.hello': ", args[0]);
                                }

                                session.subscribe('admin.pages', onevent).then(
                                    function (subscription) {
                                        console.log("subscription info", subscription);
                                    },
                                    function (error) {
                                        console.log("subscription error", error);
                                    }
                                );
                            };
                            connection.open();
                        });
                    });
                    ]]>
                </script>
            </div>
        </div>
    </tpl:replace>
</tpl:layout>

