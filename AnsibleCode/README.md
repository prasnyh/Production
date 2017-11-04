================================================
HAProxy and Nginx Playbook Reference Manual v1.0
================================================

Environment: Dev and Production
Ansible version: 2.3.1.0
OS Version: CentOS 6.X
Cloud platform: AWS
HAProxy Version: 1.5.18
Nginx Version: 1.12.1
Selinux mode: enforcing

Please refer host information for ansible in hosts file which located in /etc/ansible/hosts. There are two groups created "lbservers" and "webservers" respectively.

gedevlb01 - 192.168.x.x [lbservers]
gedevweb01 - 192.168.x.x [webservers]
gedevweb02 - 192.168.x.x [webservers]

Deploy the site by,

ansible-playbook -i hosts site.yml

site.yml file which contains aforementioned groups with roles which will execute the specified tasks. Once it is executed, haproxy will be installed/configured. Loadbalance service will listen on port 80. Nginx installation and hosting will also take place. Nginx web service listens on port 8085 on both the nodes gedevweb01 and gedevweb02. Both are part of webpool backend[app] which sits behind loadbalancer and handles actual web requests. 

Frontend HAProxy receives web traffic on port 80 and forward it to webpool on port 8085 for processing. 
Loadbalance algorithm(roundrobin) used with upstream checks along with "fall" and "rise" as response validation.

Script "prepareURLredir.sh" located in "/etc/ansible/roles/webservers/files" has been setup to do preparatory work such as directory/file creation and setting up permission for web service.

Virtual host configured with configuration file name as "www.webexample.com.conf" with Directories /defrootpage as well as /listing. /defrootpage will reflect contents of /var/www/local.html.
"/listing" - setup made for directory listing(autoindex used here).
"/*" - forward to https://kubernetes.io site. This has been accomplished using rewrite rule.
"/appredir" - forward to localhost:5500(for local application) This has been accomplished using rewrite rule.

Try the URL access by,
http://gedevlb01/defrootpage/


Production ready Configuration and Tuning
=========================================

HAproxy production settings maintained by removing "stats" URL etc.,
For Nginx, removed default settings and configured virtual host with directories. Sysctl parameter "net.core.somaxconn" set to 4096 to handle more number of requests. "backlog parameter also added" in the template.

Facts variable "ansible_processor_count" used to taking into account when it comes to connection volumes. Alternate option is to set "auto".

Service Persistency
===================

chkconfig enabled for haproxy, nginx for this purpose.

Selinux
=======

You may be getting "403-Forbidden Error" when you enforcing selinux mode. Fix it by,
chcon -R -t httpd_sys_content_t /var/www

