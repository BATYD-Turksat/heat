#
# Cookbook Name:: heat
# attributes:: default
#
# Copyright 2013, Rackspace US, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

default["heat"]["db"]["name"] = "heat"
default["heat"]["db"]["username"] = "heat"

default["heat"]["service_tenant_name"] = "service"
default["heat"]["service_user"] = "heat"
default["heat"]["service_role"] = "admin"

default["heat"]["ssl"]["dir"] = "/etc/ssl"
default["heat"]["ssl"]["enabled"] = false
default["heat"]["ssl"]["ca_file"] = nil
default["heat"]["ssl"]["cert_file"] = "heat.pem"
default["heat"]["ssl"]["key_file"] = "heat.key"

# Cloud Watch API
default["heat"]["services"]["cloudwatch_api"]["enabled"] = true
default["heat"]["services"]["cloudwatch_api"]["scheme"] = "http"
default["heat"]["services"]["cloudwatch_api"]["network"] = "public"
default["heat"]["services"]["cloudwatch_api"]["port"] = 8003
default["heat"]["services"]["cloudwatch_api"]["path"] = ""

default["heat"]["services"]["cloudwatch_api"]["backlog"] = 4096
default["heat"]["services"]["cloudwatch_api"]["cert"] = "heat.pem"
default["heat"]["services"]["cloudwatch_api"]["key"] = "heat.key"
default["heat"]["services"]["cloudwatch_api"]["workers"] = 10

# Cloud Formation API
default["heat"]["services"]["cfn_api"]["enabled"] = true
default["heat"]["services"]["cfn_api"]["scheme"] = "http"
default["heat"]["services"]["cfn_api"]["network"] = "public"
default["heat"]["services"]["cfn_api"]["port"] = 8000
default["heat"]["services"]["cfn_api"]["path"] = "/v1/$(tenant_id)s"

default["heat"]["services"]["cfn_api"]["backlog"] = 4096
default["heat"]["services"]["cfn_api"]["cert"] = "heat.pem"
default["heat"]["services"]["cfn_api"]["key"] = "heat.key"
default["heat"]["services"]["cfn_api"]["workers"] = 10

# Heat API
default["heat"]["services"]["base_api"]["enabled"] = true
default["heat"]["services"]["base_api"]["scheme"] = "http"
default["heat"]["services"]["base_api"]["network"] = "public"
default["heat"]["services"]["base_api"]["port"] = 8004
default["heat"]["services"]["base_api"]["path"] = "/v1/$(tenant_id)s"

default["heat"]["services"]["base_api"]["backlog"] = 4096
default["heat"]["services"]["base_api"]["cert"] = "heat.pem"
default["heat"]["services"]["base_api"]["key"] = "heat.key"
default["heat"]["services"]["base_api"]["workers"] = 10

# Internals
default["heat"]["services"]["internal-api"]["scheme"] = "http"
default["heat"]["services"]["internal-api"]["network"] = "management"
default["heat"]["services"]["internal-api"]["path"] = "/v1/$(tenant_id)s"

# Admin
default["heat"]["services"]["admin-api"]["scheme"] = "http"
default["heat"]["services"]["admin-api"]["network"] = "management"
default["heat"]["services"]["admin-api"]["path"] = "/v1/$(tenant_id)s"

default["heat"]["auth_encryption_key"] = "AnyStringWillDoJustFine"
default["heat"]["syslog"]["use"] = false
default["heat"]["syslog"]["facility"] = "LOG_LOCAL3"

default["heat"]["logging"]["debug"] = "false"
default["heat"]["logging"]["verbose"] = "true"

case platform_family
when "rhel"
  default["heat"]["platform"] = {}
when "debian"
  default["heat"]["platform"] = {
    "supporting_packages" => ["heat-common", "python-heat", "python-mysqldb", "python-heatclient"],
    "api_package_list" => ["heat-api"],
    "api_service" => "heat-api",
    "cfn_api_package_list" => ["heat-api-cfn"],
    "cfn_api_service" => "heat-api-cfn",
    "cloudwatch_api_package_list" => ["heat-api-cloudwatch"],
    "cloudwatch_api_service" => "heat-api-cloudwatch",
    "heat_engine_package_list" => ["heat-engine"],
    "heat_engine_service" => "heat-engine",
    "service_bin" => "/usr/sbin/service",
    "package_overrides" => "-o Dpkg::Options:='--force-confold' -o Dpkg::Options:='--force-confdef'"
  }
  default["heat"]["ssl"]["dir"] = "/etc/ssl"
end
