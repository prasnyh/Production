node 'ip-20-0-1-151.ap-south-1.compute.internal' {
  include sshdconfig
  include role::webservers 
  }
node 'ip-10-0-1-89.ap-south-1.compute.internal' {
  include profile::webservers
  include sshdconfig
  }
node 'ip-20-0-1-122.ap-south-1.compute.internal' {
  include lbservers 
  }
