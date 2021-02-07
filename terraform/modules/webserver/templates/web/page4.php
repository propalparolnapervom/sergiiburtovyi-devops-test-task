<?php echo file_get_contents("header.html"); ?>
<h2>Further improvements</h2>
<h4>While this test task was made with the least effort needed to make it running in its current form, at least following steps might be considered as a next levels of improvements:</h4>
<h4>&nbsp;&nbsp;&nbsp;- create custom VPC and subnets (as a minimum, default subnets provide servers with Public IP, which is not what you want when the principle of least privilege/access is in use. SecutiryGroup controlls all access, tho);</h4>
<h4>&nbsp;&nbsp;&nbsp;- add DNS name, pointing to LB;</h4>
<h4>&nbsp;&nbsp;&nbsp;- make it available via HTTPS by adding a certificates, terminating on LB;</h4>
<h4>&nbsp;&nbsp;&nbsp;- make it available via HTTPS only, by redirecting a traffic from port 80 (if any) to port 443;</h4>
<h4>&nbsp;&nbsp;&nbsp;- add bastion to access EC2 instance via SSH;</h4>
<h4>&nbsp;&nbsp;&nbsp;- place Web and DB part of the WebServer on separate EC2 instances;</h4>
<h4>&nbsp;&nbsp;&nbsp;- put TF state file to some shared place (s3 bucket, for example);</h4>
<h4>&nbsp;&nbsp;&nbsp;- encrypt files with sensitive data in the WebServer git repository.</h4>
<?php echo file_get_contents("footer.html"); ?>