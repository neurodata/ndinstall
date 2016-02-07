# NDinstall

This is a chef cookbook to install the current Ndio server branch of the NeuroData Project. Default password and user settings should be edited in the default.rb file prior to running. Currently the recipe works on systems using the bash shell (Red Hat, Debian, etc.).

# Installation Instructions

If you do not have a chef server, set up a chef server and workstation configuration using [these instructions.](https://www.digitalocean.com/community/tutorials/how-to-set-up-a-chef-12-configuration-management-system-on-ubuntu-14-04-servers) On your workstation clone the repository into your cookbooks folder and add the recipe to your configuration. Change the default user name and password configuration in default.rb file to your personal configuration. Upload the recipe to your chef server, bootstrap into your desired node and run the installation script. 
