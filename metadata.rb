maintainer       "Escape Studios"
maintainer_email "dev@escapestudios.com"
license          "MIT"
description      "Installs/Configures New Relic"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.3.7"

supports "ubuntu"
supports "debian"
supports "centos"
supports "redhat"
supports "fedora"

depends "python"

recipe 'newrelic::default',"Set up New Relic and install the system monitor"
recipe 'newrelic::install',"Set up APT to allow New Relic packages to be installed."
recipe 'newrelic::php-agent',"Set up New Relic PHP agent."
recipe 'newrelic::python-agent',"Set up New Relic Python agent."
recipe 'newrelic::server-monitor',"Set up New Relic Server (system) monitoring only"

all_recipes = ['newrelic::default', 'newrelic::install', 'newrelic::php-agent', 'newrelic::python-agent',
	'newrelic::server-monitor']

attribute 'newrelic/license_key',
	:display_name => "New Relic License Key",
	:description => "New Relic license key to use. See the Account Settings page in the New Relic dashboard.",
	:required => "required",
	:recipes => all_recipes

attribute 'newrelic/app_name',
	:display_name => "New Relic Application Name",
	:description => "Application name to report to New Relic",
	:required => "required",
	:recipes => ['newrelic::php-agent', 'newrelic::python-agent']

attribute 'newrelic/auto_instrumentation',
	:display_name => "Enable New Relic Instrumentation",
	:description => "Turns on automatic instrumentation for Real User Monitoring. This has vague privacy implications...",
	:required => "recommended",
	:choice => ['true', 'false'],
	:recipes => ['newrelic::php-agent', 'newrelic::python-agent'],
	:default => 'true'
