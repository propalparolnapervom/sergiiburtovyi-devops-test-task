<?php echo file_get_contents("header.html"); ?>
<h2>Step 1: Build AMI</h2>
<h4>So the final aim is to have a WebServer running on AWS cloud, available via LoadBalancer, with DB on its backend.</h4>
<h4>Seems like LAMP (Linux, Apache, MySQL, PHP) meets basic requirements.</h4>
<h4>One option to make it running on the AWS Cloud is to build an AMI with LAMP stack installed.</h4>
<h4>Thus, the following was done to create such AMI:</h4>
<h4>&nbsp;&nbsp;&nbsp;- <a href="https://www.packer.io/">Packer</a> was used as a tool to create customized AMI;</h4>
<h4>&nbsp;&nbsp;&nbsp;- <a href="https://www.ansible.com/">Ansible</a> was used by Packer as a tool to manage AMI configuration (install Apache, MySQL and PHP, for instance);</h4>
<h4>&nbsp;&nbsp;&nbsp;- <a href="https://github.com/aelsabbahy/goss/">Goss</a> was used by Packer as a tool to test AMI configuration (for example, to check that specified packages were installed and prosesses were started successfully);</h4>
<?php echo file_get_contents("footer.html"); ?>