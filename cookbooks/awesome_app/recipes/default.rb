#
# Cookbook Name:: awesome_app
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
# Make sure the apt cache is up to date with the following Recipe
include_recipe "apt"

# #!/usr/bin/python
# # -*- coding: utf-8 -*-
# from subprocess import Popen
# import os, sys, getpass, binascii
#
# # The following script assumes that apache2, mysql, and unzip have been installed.
package "apache2" do
  action :install
end

package "mysql-server" do
  action :install
end

package "unzip" do
  action :install
end

package "libapache2-mod-wsgi" do
  action :install
end

package "python-pip" do
  action :install
end

package "python-mysqldb" do
  action :install
end

package "expect" do
  action :install
end
# # 1. wget https://github.com/colincam/Awesome-Appliance-Repair/archive/master.zip
# # 2. unzip master.zip
# # 3. cd into Awesome-Appliance-Repair
# # 4. sudo mv AAR to /var/www/
# # 5. sudo su root
# # 6. run script: python AARinstall.py
# # 7. manually execute: apachectl graceful
#
# if __name__ == '__main__':
#     root_dbpswd = getpass.getpass('enter the mysql root user password: ')
#
#     Popen(['chown', '-R', 'www-data:www-data', '/var/www/AAR'], shell=False).wait()
#
remote_file "/tmp/master.zip" do
  source "https://github.com/colincam/Awesome-Appliance-Repair/archive/master.zip"
  mode "0755"
  not_if { File.exists?("/tmp/master.zip") }
end

execute "unzip_master_file" do
  command "unzip master.zip"
  cwd "/tmp"
  not_if { File.exists?("/tmp/Awesome-Appliance-Repair-master/AARinstall.py") }
end

execute "mv_AAR_folder" do
  command "mv AAR /var/www/"
  cwd "/tmp/Awesome-Appliance-Repair-master"
  not_if { File.exists?("/var/www/AAR") }
end

execute "chown_data-www" do
  command "chown -R www-data:www-data /var/www/AAR"
  user "root"
end

# # apt-get the stuff we need
#     proc = Popen([
#         'apt-get', 'install', '-y',
#         'libapache2-mod-wsgi',
#         'python-pip',
#         'python-mysqldb'], shell=False)
#     proc.wait()
#
# # pip install flask
#     Popen(['pip', 'install', 'flask'], shell=False).wait()
#
python_pip "Flask"

# # Generate the apache config file in sites-enabled
#     Popen(['apachectl', 'stop'], shell=False).wait()
#
#     pth = '/etc/apache2/sites-enabled/'
#     for f in os.listdir(pth):
#         os.remove(pth + f)
#
#     f = open('/etc/apache2/sites-enabled/AAR-apache.conf', 'w')
#     f.write("""
#     <VirtualHost *:80>
#       ServerName /
#       WSGIDaemonProcess /AAR user=www-data group=www-data threads=5
#       WSGIProcessGroup /AAR
#       WSGIScriptAlias / /var/www/AAR/awesomeapp.wsgi
#
#       <Directory /var/www/AAR>
#         WSGIApplicationGroup %{GLOBAL}
#         WSGIScriptReloading On
#         Order deny,allow
#         Allow from all
#       </Directory>
#
#       CustomLog ${APACHE_LOG_DIR}/access.log combined
#       ServerAdmin ops@example.com
#     </VirtualHost>
#     """)
#     f.close()
#

template "/etc/apache2/sites-enabled/AAR-apache.conf" do
  source "AAR-apache.conf.erb"
  mode "0644"
  not_if { File.exists?("/etc/apache2/sites-enabled/AAR-apache.conf") }
end

# # Generate AAR_config.py with secrets
#     f = open('/var/www/AAR/AAR_config.py', 'w')
#     appdbpw = binascii.b2a_base64(os.urandom(6)).strip('\n')
#     secretkey = binascii.b2a_base64(os.urandom(12)).strip('\n')
#
#     conn_args_string = """CONNECTION_ARGS = {"host":"localhost", "user":"aarapp", "passwd":"%s", "db":"AARdb"}\n\n""" % appdbpw
#
#     secret_key_string = """SECRET_KEY = "%s"\n\n""" % secretkey
#
#     database_values_string = """DB_VALUES = [(3,'Maytag','Washer', None, 'pending', "outflow hoses leak"),(4,'GE','Refrigerator', '2013-11-01', 'completed', "Ices up; won't defrost"), (5,'Alessi','Teapot', None, 'pending', "explodes"), (6,'Amana','Range', '2013-11-02', 'completed', "oven heats unevenly"), (7,'Whirlpool','Refrigerator', '2013-11-03', 'pending', "Makes a rattling noise"), (8,'GE','Microwave', '2013-11-04', 'pending', "Sparks and smokes when I put forks in it"), (9,'Maytag','Drier', None, 'pending', "Never heats up"), (10,'Amana','Refrigerator', '2013-11-05', 'pending', "Temperature too low, can't adjust."), (11,'Samsung','Washer', None, 'pending', "Doesn't get my bear suit white"), (12,'Frigidaire','Refrigerator', '2013-11-06', 'completed', "Has a bad smell I can't get rid of."), (13,'In-Sink-Erator','Dispose-all', None, 'pending', "blades broken"), (14,'KitchenAid','Mixer', '2013-11-07', 'completed', "Blows my fuses"), (15,'Moulinex','Juicer', None, 'pending', "Won't start"), (16,'Viking','Range', '2013-11-08', 'completed', "Gas leak"), (17,'Aga','Range', None, 'pending', "burner cover is cracked"), (18,'Jennaire','Cooktop', '2013-11-09', 'completed', "Glass cracked"), (19,'Wolfe','Stove', None, 'pending', "Burners are uneven"), (20,'LG','Dehumidifier', '2013-11-10', 'pending', "Ices up when external temp is around freezing"), (21,'DeLonghi','Oil Space Heater', None, 'pending', "Smells bad"), (22,'Kenmore','Refrigerator', '2013-11-11', 'pending', "excessive vibration"), (23,'Maytag','Washer/Drier', None, 'pending', "outflow hoses leak"), (24,'GE','Refrigerator', '2013-11-12', 'pending', "Refrigerator light is defective"), (25,'Kenmore','Washer', None, 'pending', "Unbalanced spin cycle"), (26,'Cookmore','Outdoor Grill', '2013-11-13', 'pending', "Smoker box is stuck"), (27,'Kenmore','Water heater', None, 'pending', "Can't adjust temperature"), (28,'Sanyo','Minifridge', '2013-11-14', 'pending', "Makes a lot of noise"), (29,'Bosch','Dishwasher', None, 'pending', "leaves spots on my glasses"), (30,'Whirlpool','Trash Compactor', '2013-11-15', 'pending', "leaking hydraulic fluid")]
#     """
#
#     f.write(conn_args_string + secret_key_string + database_values_string)
#     f.close()
#
# # Create DB, user, and permissions
#     import MySQLdb
#     db = MySQLdb.connect(host='localhost', user='root', passwd=root_dbpswd)
#     sql_script = open('make_AARdb.sql', 'r').read()
#
#     cur = db.cursor()
#     cur.execute(sql_script)
#     cur.close()
#
#     cur = db.cursor()
#     cur.execute('use AARdb')
#     cur.execute("CREATE USER 'aarapp'@'localhost' IDENTIFIED BY %s", (appdbpw,))
#     cur.execute("GRANT CREATE,INSERT,DELETE,UPDATE,SELECT on AARdb.* to aarapp@localhost")
#     cur.close()
#     db.close()#
mysql2_chef_gem 'default' do
  action :install
end

execute 'seed_AARdb_database' do
  command "mysql -h 127.0.0.1 -u root < /tmp/Awesome-Appliance-Repair-master/make_AARdb.sql"
  not_if  "mysql -h 127.0.0.1 -u root -D AARdb -e 'describe customer;'"
end

mysql_database_user 'aarapp' do
  connection(
    :host => '127.0.0.1',
    :username => 'root',
    :password => ''
  )
  password 'super_secret'
  database_name 'AARdb'
  privileges [:create, :insert, :delete, :update, :select]
  action [:create, :grant]
end

template "/var/www/AAR/AAR_config.py" do
  source "AAR_config.py.erb"
  mode "0644"
  not_if { File.exists?("/var/www/AAR/AAR_config.py") }
end

execute "disable_default_apache2_site" do
  command "a2dissite default"
  cwd "/etc/apache2/sites-enabled"
  only_if { File.exists?("/etc/apache2/sites-enabled/000-default") }
  notifies :restart, "service[apache2]"
end

service "apache2" do
  action [:enable, :start]
end

# # Time for an ugly short-cut hack to just execute the Python installer script!
# bash "modify_root_password" do
#     user "root"
#     cwd "/tmp/Awesome-Appliance-Repair-master"
#     code <<-EOH
#     /usr/bin/expect -c 'spawn /usr/bin/python /tmp/Awesome-Appliance-Repair-master/AARinstall.py
#     expect "enter the mysql root user password: "
#     send "\r"
#     expect eof'
#     EOH
#     notifies :restart, "service[apache2]"
# end
