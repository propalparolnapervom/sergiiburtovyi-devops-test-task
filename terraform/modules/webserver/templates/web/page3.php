<?php echo file_get_contents("header.html"); ?>
<h2>Step 2: Create infrastructure</h2>
<h4>Once we have AMI available with all software installed and configured, the WebServer infrastructure could be created, based on that AMI.</h4>
<h4><a href="https://www.terraform.io/">Terraform</a> was used as a tool to describe and create a fair minimum of infrastructure needed to run our LAMP AMI in the AWS cloud:</h4>
<h4>&nbsp;&nbsp;&nbsp;- <strong>EC2 Auto Scaling Group</strong> to keep necessary amount of servers running; </h4>
<h4>&nbsp;&nbsp;&nbsp;- <strong>Application Load Balancer</strong> to serve as endpoint of our WebSite (and load balancer, in general); </h4>
<h4>&nbsp;&nbsp;&nbsp;- <strong>EC2 Security Group</strong> to make HTTP traffic on port 80 the only one allowed by default (SSH connection on port 22, direct to the EC2 instance, could be allowed in addition, if needed: please, see appropriate How-To's chapter of README file in root of the repo); </h4>
<h4>&nbsp;&nbsp;&nbsp;- <strong>Virtual Private Cloud</strong> and <strong>Subnets</strong>, default for your AWS Region, were used to keep it simple.</h4>
<?php echo file_get_contents("footer.html"); ?>