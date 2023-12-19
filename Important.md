
## How to choose your AWS region?

1. Compliance (data governance and legal requirements)
2. Proximity (reduce latency)
3. Available services (not all services are available in every region)
4. Pricing (sometimes pricing may differ from region to region)

## Classic ports to know
------------------------------------------

22 = SSH (Secure Shell) - log into a linux instance

21 = FTP (File Transfer Protocol) - upload files into a file share

22 = SFTP (Secure File Transfer Protocol) - upload files using SSH

80 = HTTP - access unsecured websites

443 = HTTPS- access secured websites

3389 = RDP (Remote Desktop Protocol) - log into a windows instance

**Whenever we download something, like a key to connect to an EC2 it comes with permissions 0644 which
is too open, we need to change it to something like 0400**


## AWS Availability Zones
- Minimum 3, max 6 per region.


# ~~~~ AWS IAM Identity and Access Management Global ~~~~

Creating an account creates a root account, which shouldn't be used, we should create users instead.

* Users can be created and can be grouped
* Groups only contain users not other groups
* Users can belong to multiple groups

A Policy is a JSON document and this can define permissions, these permissions which are in the JSON document can be assigned to users and groups. **Least privileged principle -> Do not give a user more permissions than it needs**

### MFA Multiple Factor Authentication

MFA = password you know + security device you own

Options (Must know)
* Virtual MFA device
    - Google Authenticator
    - Authy
* Universal 2nd Factor (U2F) Security Key
    - YubiKey Yubico (3rd Party)
* Harware Key Fob MFA Device
    - Provided by Gemalto (3rd Party)
* Hardware Key Fob MFA Device for AWS GovCloud (US)
    - Provided by SurePassID (3rd Party)

### IAM Roles for services
Roles are for a short period of time and are intended to be used by some AWS services that will need for perform actions on your behalf. Each instance can be attached to one role and each role may contain multiple permitions or a single permition.

Common role services
* EC2
* Lambdas

___Never enter your IAM keys (access keys) into an EC2 instance, instead use IAM roles___

### IAM Security Tools

**IAM Credentials Report (account-level)**\
A report that lists all your account's users and the status of their various credentials.

**IAM Access Advisor (user-level)**\
Shows the service permissions granted to a user and when those services were last accessed.


# ~~~~ EC2 ~~~~

### AWS Budget
Not a service, is a small monitor for your expenses, you can explore/track the cost of every service and add a threshold alarm for a certain ammount wasted.


### AWS EC2 Elastic compute cloud

Infraestructure as a service, EC2 is the most popular AWS offering providing a "rental" of virtual machines which can be connected to multiple other AWS services.

**Operating Systems**: Linux, Windows, Mac OS

### EC2 User Data

Commonly a data script in order to launch commands when machine starts, this script will only ber run once at start

It is used to automate boot tasks such as:
* Installing updates
* Installing software
* Downloading any file
* Any other thing

The EC2 User Data script runs with the root user.


### EC2 INSTANCE TYPES

AWS naming convention:

                            m5.2xlarge

M: Instance class\
5: Generation (AWS instance types are improved over the time)\
2xlarge: Size within the instance class

* General Purpose

    General purpose instances provide a balance of compute, memory and networking resources, and can be used for a variety of diverse workloads. 
    These instances are ideal for applications that use these resources in equal proportions such as web servers and code repositories. 

    Use Cases

    **Developing, building, testing, and signing iOS, iPadOS, macOS, WatchOS, and tvOS applications on the Xcode IDE**



* Compute Optimized (C)

    Compute Optimized instances are ideal for compute bound applications that benefit from high performance processors.
    Instances belonging to this family are well suited for batch processing workloads, media transcoding, 
    high performance web servers, high performance computing (HPC), scientific modeling, dedicated gaming servers and ad server engines, machine learning inference and other compute intensive applications.

    Use Cases

    **High performance computing (HPC), batch processing, ad serving, video encoding, gaming, scientific modelling, distributed analytics, and CPU-based machine learning inference.**

* Memory Optimized (R)

    Memory optimized instances are designed to deliver fast performance for workloads that process large data sets in memory (RAM).

    Use Cases

    **Memory-intensive applications such as open-source databases, in-memory caches, and real time big data analytics**

* Accelerated Computing

    Accelerated computing instances use hardware accelerators, or co-processors, to perform functions, such as floating point number calculations, graphics processing, or data pattern matching,
    more efficiently than is possible in software running on CPUs.

    Use Cases

    **Machine learning, high performance computing, computational fluid dynamics, computational finance, seismic analysis, speech recognition, autonomous vehicles, and drug discovery.**

* Storage Optimized (I, D, H1)

    Storage optimized instances are designed for workloads that require high, sequential read and write access to very large data sets on local storage.
    They are optimized to deliver tens of thousands of low-latency, random I/O operations per second (IOPS) to applications.

    Use Cases

    **NoSQL databases (e.g. Cassandra, MongoDB, Redis), in-memory databases (e.g. Aerospike), scale-out transactional databases, data warehousing, Elasticsearch, analytics workloads.**


### AWS Security groups

Firewall that controls the traffic that is allowed into or out of EC2 instances
* Only contain allow rules
* Rules can reference by IP or by Security group
* Access to ports
* Set inbound rules
* Set outbound rules

**Good to know**

* Can be attached to multiple instances
* Locked down to region
* Does live outsided the EC2 - if traffic is blocket, instance will never see it
* Maintain one security group for SSH access
* If application is not accessible (time out), it's a security group issue
* If application gives connection refused error, it's an application error or it's not launched


### EC2 Instance purchasing options

* EC2 On-Demand Instances

    Short workloads, predictable pricing, EC2 On Demand, pay what you use:

    Linux, Windows - billing per second, after the first minute
    All other operating systems - billing per hour
    Has the highest cost but no upfront payment
    No long-term commitment
    ___Recommended for short-term and un-interrupted workloads where you can't predict the      application's behaviour___

* EC2 Reserved Instances(MINIMUN 1 year)

    ___"+" means discount amount more "+" means more discount___

    Long workloads.

    Up to 75% discount compared to On-Demand.

    Reservation period: 1 year = +discount | 3 years = +++discount.

    Purchasing options: no upfront | partial upfront (monthly) = + | All upfront(single payment beforprovison) = +++.

    Reserve a specific instance type.

    Can buy or sell Reserved instances in the marketplace

    ___Recommended for steady-state usage application (Databases).___

    * Convertible Reserverd Instances: 
        * Long workloads with flexible instances
        * Can change the EC2 instance type
        * Can change instance family, operating system, scope and tenancy
        * Up to 66% discount
    * Scheduled Reserved Instances:
        * Launch within time window you reserve
        * When you require a fraction of day / week / month
        * Still commitment over 1 to 3 years


* EC2 Saving plans

    Get a discount based on long-term usage (up to 72% same as Reserved instances)

    Commit to a certain type of usage ($10/hour for 1 or 3 years)

    Locked to a specific instance family and AWS Region (e.g. M5 in us-east-1)

    * Flexible accross
        * Instance size (e.g. m5.xlarge, m5.2xlarge)
        * Operating system
        * Tenancy (Host, Dedicated, Default)



* EC2 Spot Instances
    Short worloads, cheap, can lose instances(less reliable).

    Can get a discount of up to 90% compared to On-Demand

    Instances that you can "lose" at any point of time if your max price is less than the current spot price

    The MOST cost-efficient instances in AWS

    * Useful for workloads that are resilient to failure
        * Batch jobs
        * Data analysis
        * Image processing
        * Any distributed workloads
        * Workloads with a flexible start and end time

    ___NOT SUITABLE FOR CRITICAL JOBS OR DATABASES**___
 
* EC2 Dedicated hosts

    Book an entire physical server, controls instance placement.

    Physical server with EC2 instance capacity full dedicated for your use. Can be helpful to address COMPLIANCE REQUIREMENTS

    Use it with your EXISTING SERVER-BOUND SOFTWARE LICENSES

    Allocated for your account for 1 to 3 years

    Most expensive option

    Useful for software that have complicated licensing model (Bring your own license - BYOL)

    Companies that have strong compliance needs


* EC2 Dedicated instances

    Just like a soft version of dedicated hosts with a Per-Instance billing.

    Instances running on hardware that's dedicated to you

    May share hardware with other instances in same account

    No control over instance placement (can move hardware after Stop / Start)

* EC2 Dedicated instances

    Just like a soft version of dedicated hosts with a Per-Instance billing.

    Instances running on hardware that's dedicated to you
    
    May share hardware with other instances in same account

    No control over instance placement (can move hardware after Stop / Start)

* EC2 Capacity Reservations

    Reserve On-Demand instances capacity in an specific AZ for any duration

    Always have access to EC2 capacity when you need it

    No time commitment, no billing discounts

    Charged at On-Demand rate even if instance is not in use

### ECS Instance storage section

**EC2 Instance storage EBS (Elastic Block store)**

An EBS volume is a network drive you can attach to instances while these are running allowing to persit data even after terminatation.

* EBS volumes can only be mounted to one instance at a time
* Bound to specific AZ (Availability zone)
* Network drive, it uses the network to communicate to the instance, which can cause latency
* Can be detached and attached to a new instance easily
* Multiple EBS can be attached to a single instance

Delete on termination attribute
* By default, root EBS is deleted (attribute enabled)
* By default, any other EBS attached is not deleted (attribute disabled)
* Controls the EBS behaviour when an EC2 instance terminates
* Can create snapshots and move from regions and availability zones

**EBS Snapshot**

Make a backup (snapshot) of EBS volume at any point in time, it is not necessary to detach volume to create a snapshot, but, it is recommended.

Can copy snapshots across AZ or Region.

**EBS Features**

EBS Snapshot Archive
* Move snapshot to an "archive tier" which is 75% cheaper
* Takes 24 to 72 hours for restoring the archive

Recycle Bin for EBS Snapshots
* Setup rules to retain deleted snapshots in order to recover them after accidental deletion
* Specify retention (from 1 day to 1 year)

Fast Snapshot restore (FSR)
* Force full initialization of snapshot to have no latency on first use (pretty expensive)

**EBS volume types**

* gp2 / gp3 (SSD) General purposse SSD volumes that balances price and performance for a wide variety of workloads
* io1 / io2 (SSD) Highest-Performance SSD volume for mission-critical low-latency or high-throughput workloads
* st1 (HDD) Low cost HDD volume designed for frequently accessed, throughput-intensive workloads
* st2 (HDD) Lowest cost HDD volume designed for less frequently accessed workloads

Only gp2/gp3 and io1/io2 can be used as boot volumes

General Purpose SSD
* Cost effective storage, low-latency (gp3)
* Up to 16,000 IOPS to 1000 Mib/s indpendently (gp3)
* gp3 can set any IOPS
* gp2 older version and cannot set IOPS since these are predefined

Provisioned IOPS (PIOPS) SSD
* Applications that need more than 16,000 IOPS
* Great for database workloads
* Max 64,000 IOPS (io2) needs nitro
* Can increase PIOPS independently from storage size

Hard Disk Drives (HDD)
* Cannot be a boot volume
* Storage from 125 GiB to 16 TiB
* Throughput optimized HDD (st1)
* Cold HDD (sc1) data infrequently accessed
    * Low cost
    * max IOPS 250


https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ebs-volume-types.html (we just need to understand when to use each type)

**EBS Multi Attach**

Limited to a single AZ
* Up to 16 instances at a time (nice to know)

___NOTE: we can attach multiple EC2 instances to a single EBS volume only if we use a io1/io2 family, with multi-attach___


**AWS AMI**

Custom AMI (Amazon Machine Image), is a customization of an EC2 Instance , you add your own software and customization, operating system, monitoring, faster boot etc, software is pre-packaged,  these are built for specific regions however these can be replciated in different regions.

* Can launch AMIs from amazon, AWS provides
* Create your own AMI
* Can use AMI from the marketplace

**EC2 Instance store**

EBS volumes are network drives with good but limited performances.

EC2 instance store on the other hand is a hard-disk (physical), if we need high-performance hardware disk then EC2 instance store is a better option.

Some characteristics of EC2 instance store.

* Better I/O performance
* EC2 instance store lost their storage if stopped (if we stop the EC2 instance data is loss, Ephimeral)
* Good for buffer / cache / scratch data / temporary content
* Risk of data loss if hardware fails
* Backups and Replication are your responsibility
* For long term storage EBS is a better option

**EFS Elastic file system**

* Managed NFS (network file system) that can be mounted on many EC2
* EFS works with EC2 instances in multi-AZ
* Highly available and scalable , expensive (up to 3x gp2), pay per use

Use cases:

* Content management, web serving, data sharing , Wordpress
* Uses NFSv4.1 protocol <<<<<
* Uses security group to control access to EFS
* Compatible with Linux based AMI (not windows)
* Encryption at rest using KMS
* POSIX file system (Linux)
* File system scales automatically, pay per use, no capacity plan 

EFS - Performance & Storage classes

* EFS Scale
    * 1000s of concurrent NFS client
    * Grow to Petabyte-scale network file system, automatically
* Performance mode
    * General purpose (default): latency-sensitive use cases (web server, CMS, etc)
    * Max I/O - higher latency, highly parallel (big data, media procesing)

* Througput mode
    * Bursting: (1TB = 50Mib/s)
    * Provisioned: set your througput regardless of storage size, ex 1GiB/s 1 TB storage
    * Elastic: automatically scales throughput up or down based on workloads

* Storage Tiers (lifecycle management feature - move file after N days)
    * Standard: for frequently accessed files
    * Infrequent access (EFS-IA): cost to retrieve files, lower price to store

* Availability and durability
    * Standard: Multi-AZ, great for prod
    * One Zone: One AZ, great for dev, backup enabled, by default compatible with IA infrequent access over 90% in cost savings.

# ~~~~ AWS FUNDAMENTALS ELB + ASG ~~~~
### ELB elastic load balancer

AWS has 4 kinds of managed Load Balancers

* **Classic Load Balancer (v1 - old generation) - 2009 -- Supports HTTP, HTTPS, TCP  -> DEPRECATED AND NOT MENTIONED IN THE EXAM**
    * Health checks are TCP, HTTP, HTTPS
    * Fixed Hostname

* **Applcation Load Balancer ALB (v2 - new generation) - 2016 -- Supports HTTP, HTTPS, TCP, WebScoket**

    * Only layer 7 (HTTP, HTTPS)
    * Load balancing to multiple HTTP applications across machines
    * Load balancing multiple applications on the same machine (ex: containers)
    * Support for HTTP/2 and websocket
    * Supprot redirects from http to https

    * GOOD for microservices and container based applications like Docker and Amazon ECS
    * Has a port mapping feature to redirect to a dynamic port in ECS
    * In comparison we'd need multiple classic load balancer per application
    * ALB can route to muiltiple target groups
    * Health checks are at a target group level
    * Static hostname

    Target groups
     * EC2 instances (can be managed by an auto scaling group) - HTTP
     * ECS (managed by ECS itself) - HTTP
     * Lambda functions
     * IP Addresses - must be private

    Good to Know
     * Fixed hostname
     * The application servers don't see the IP of the client directly
        * The true IP of the client is inserted in the header X-Forwarded-For
        * Cna get port X-Forwarded-Port and protocol X-Forwarded-Proto
    
* **Network Load Balancer (v2 - new generation) - 2017 -- Supports TCP, TLS (Secure TCP), UDP**

    * Only layer 4 (TCP, UDP)
    * Handle millions of requests per seconds, really high performance
    * Less latency ~100 ms vs 400 ms for ALB
    * NLB has one static IP per AZ, and supports assigning ELASTIC IP (helpuf for whitelisting)
    * NLB are used for extreme performance
    * NLB supports HTTP, HTTPS and TCP health checks

* **Gateway Load Balancer 2020 - GWLB**
    * Operates at layer 3 (Network layer) - IP protocol
    * Firwealls, intrusion detection and prevention systems
    * Single entry and single exit
    * Geneve protocol 6081

    This is useful when you want to inspect requests and send them to a different target group to be analyzed (network level, we can drop the request here) and then sent the request to the destination, for the application will be seamless.

**Sticky sessions**

it is possible to implement stickiness with loadbalancers therefore the same client is always redirected to the same instance behind the load balancer. (Only works for Application and network load balancers).

The cookie used for stickiness has an expiration date we can control.
** NLB works without cookies

* Application based cookie
    * Custom cookie
        * Generated by the target
        * Can include any custom attributes
        * Cookie name must be specified for each target group
        * Do not use AWSALB, AWSALBAPP or AWSALBTG (reserved names for use by the ELB)
    * Application cookie
        * Generated by the load balancer
        * Cookie name AWSALBAPP
* Duration based cookie
    * Cookie generated by ELB
    * Cookie name AWSALB for ALB AWSELB for CLB

**Cross Zone balancing**

AWS ELB can distribute balance between AZ, for example having 10 instances, 2 in AZ 1 and 8 in AZ2 ELB with Cross zone load balancing will distribute evenly across all registered instances in all AZ regardless of AZ, it means that 10% will be distributed to each instance in all AZ.

If we do not have cross zone balancing we will be directing 25% to each instance in AZ 1 (we have 2 instances there), and 6.25% to each instance in AZ 2 (we have 8 instances there).

* Application Load balancer
    * Enabled by default (can be disabled at target group level)
    * No charges for inter AZ data
* Network load balancer & Gateway load balancer
    * Disabled by default
    * Pay charges for inter AZ if enabled

**SSL Certificates**

* Can manage certificates using AWS ACM (AWS certificate manager)
* Can create and upload own certificates
* Clients can use SNI (Server name indication) to specify the hostname they reach
* Can specify a security policy to support older versions

* SNI (Server name indication)
    * Solves the problem of loading multiple SSL certificates into one server
    * The server will find the correct sertificate for each domain
    * Only works for ALB and NLB, Cloudfront
    * Does not work for CLB (Classic load balancer, older generation)

**Connection draining setting**

* Feature naming
    * Connection draining for CLB
    * Deregistration Delay for ALB & NLB

* Time to complete inflight requests while the instance is de-registering or unhealthy
* Stops sending requests to the EC2 instance which is de-registering
* Between 1 to 3600 seconds (Default 300 seconds)
* Can be desabled (set to 0 seconds)
* Set to a low value if requests are short

**Auto Scaling Groups**

ASG are free, you only pay for the EC2 instances that may be created.

* Scale out, add EC2 instances to match increased load
* Sale in, remove EC2 instances to match decreased load
* Ensure we have a minimum and maximum number of EC2 instances running
* Automatically register new EC2 instances to a load balancer
* Re-create an EC2 instance in case of a previous one is terminated

    ___Auto scaling group attributes___

    A launch template to configure new EC2 instances that will be scaled out
    * AMI + Instance type
    * EC2 User data
    * EBS volumes
    * Security groups
    * SSH Key Pair
    * IAM Roles for EC2 instances
    * Network + Subnets information
    * Load balancer information

    Min size / Max size / Initial capacity / Scaling policies

    It is possible to scale ASG based on cloudwatch alarms, these alarms can Monitor a metric or multiple metrics in order to decide to either scale out or scale in, one metric could be CPU or Memory used.

    ___Dynamic Scaling policies___

    * Target Tracking scaling
        * Most simple and easy to set-up
        * Example: I want average CPU usage of 40%
    * Simple Step Scaling
        * When cloud watch alarm is triggered (Example: CPU > 70%) then add 2 units
        * When cloud watch alarm is triggered (Example: CPU <> 30%) then remove 1
    * Scheduled Actions
        * Anticipate a scaling based on known usage patterns
        * Example: increase the minimum capacity to 10 at 5pm on fridays

    ___Predicting scaling___

    Continously forecast load and schedule scaling ahead, with machine learning.

    ___Scaling cooldown___

    After scaling happens there is a cooldown metric (default 300 seconds), during this time ASG will not launch or terminate instances to allow metrics to stabilize.

    ___Instance Refresh___

    whenever we update the launch template new EC2 instance will appear while old EC2 instances using the old launch template will be terminated 

    Not all instances will be terminated, we can set a minimum healthy percentage in order to avoid deleting all current instances.

    Specify warm-up (how long until new instances are ready to use)

Good metrics to scale on.

* CPU Utilization
* Request count per target: make sure the ammount of requests per EC2 is stable
* Average network in/out (if application is network bound)
* Any custom metric


# ~~~~ AWS RDS ~~~~

RDS is a managed service:
* Automated provisioning, OS patching
* Continuous backups and restore to specific timestamp (Point in time restore)
* Read replicas for improved read performance
* Multi AZ setup for DR (Distaster recovery)
* Maintenance windows for updates
* Scaling capability (vertical and horizontal)
* Store backed by EBS (gp2 or io1)
* Cannot ssh into instances

**RDS storage auto scaling**

* Helps to increase storage on RDS DB instance dynamically
* When RDS detects you are running out of storage it scales automatically
* Avoid manually scaling database
* You have to set maximum storage threshold (Maximum limit for DB storage)
* Automatically modify storage if: 
    * Free storage is less than 10% allocated
    * Low-storage at least 5 minutes
    * 6 hours have passed since last modification
* Useful for applications with unpredictable workload
* Supports all RDS database engines (Maria DB, MySQL, PostgreSQL, SQL Server, Oracle)

**RDS Read replicas for read scalability**

* Can scale up to 15 read replicas
* Within AZ, Cross AZ, or Cross region
* Replication is ASYNC so reads are eventually consistent
* Replicas can be promoted to their own DB
* Applications must update the connection string to leverage read replicas
* Read replicas are used for select statements

There is a replication fee if read reaplicas are in a different region, for example us-east-1a -> eu-west-1b , this replication will have a cost, whereas replication in the same region is free, for example us-east-1a -> us-west-1a

**RDS Multi AZ (Distaster recovery)**

* SYNC replication
* Increate availability
* Failover in case of loss of AZ, loss of network, instance or storage failure
* No manual intervention in apps
* Not used for scaling
* Used for failure in any AZ

___Read replicas can be setup as Multi AZ for distaster recovery___

From single AZ to Multi AZ

* Zero downtime operation (no need to stop DB)
* Just click to modify
* This happens internally:
    * A snapshot is taken
    * A new DB is restored from the snapshot in a new AZ
    * Sync is established between the two databases

**Amazon Aurora**
* Propietary technology from AWS (not open sourced)
* Postgres and MySQL are both supported as Aurora DB
* Aurora is cloud optimized and claims 5x performance improvement over MySQL on RDS and 3x the performance of PostgreSQL on RDS
* Aurora can have up to 15 replicas and the replication process is faster than MySQL
* Failover in Aurora is instantaneous, it's HA active
* Aurora cost more than RDS (20% more) - but is more efficient
* 6 copies of data across 3 AZ:
    * 4 copies out of 6 needed for writes
    * 3 copies out of 6 needed for reads
    * Self healing with peer-to-peer application
    * Storage is stripped accross 100s of volumes
* One Aurora instance takes writes (master)
* Automated failover for master in less than 30 seconds
* Master + up 15 Aurora read replicas
* Support for cross region replication
* Shared storage Auto expanding from 10 GB to 128 TB
* Backtracking: Restore data at any point of time without using backups

**RDS and Aurora security**
* At-Rest encryption:
    * Database master and replicas encryption using AWS KMS - must be defined at launch time
    * If the master is not encrypted, the read replicas cannot be encrypted
    * To encrypt an un-encrypted database, go through a DB snapshot and restore as encrypted
* In-flight encryption:
    * TLS-Ready by default, use the AWS TLS root certificates client-side
* IAM authentication:
    * Roles to connect to the db from any other AWS service
* Security groups:
    * Control network access to RDS / Aurora
* No SSH available:
    * Except on RDS custom
* Audit logs can be enabled:
    * Sent to Cloudwatch for longer retention

___Writer endpoint, writes (master)___

___Reader endpoint, reads, connection load balancer (when you have 2 or more read replicas)___

**Amazon RDS proxy**

Service meant to reduce the connection burden to RDS (for example when we have many connections opening and closing fast, such as many lambda functions conected to a single db)

* Allow apps to pool and share DB connections established with the database
* Serverless, autoscaling , highly available
* Reduced RDS and Aurora failover by 66%
* Supports all SQL databases in RDS + Aurora
* Enforce IAM authentication for DB, securely store credentials in AWS secrets manager
* RDS is never publicly accessible (must be accessed from VPC)

**Amazon ElasticCache Overview**

* Same kind of service as RDS to get manager Relational Databases
* Elastic cache is to get managed Redis or Memcached
* AWS takes care of maintenance / patching , optimizations, setup, configuration, monitoring, failure recover y backups
* Using Elastic cache involves heavy application changes
* Maximum read replicas for ElasticCache redis cluster with cluster-mode disabled, 5

**Amazon MemoryDB for Redis**

Is a service backed up by a Redis db, this time redis is being used as a memory DB

* Redis-compatible, durable, in-memory database service
* Ultra-fast performance, with over 160 million requests per second
* Durable in-memory data storage with Multi AZ transactional log
* Scale seamlessly from 10s GBs to 100s TBs of storage
* Use cases: web and mobile apps, online gaming, data streaming

# ~~~~ AWS Route 53 (DNS) ~~~~

A highly available, scalable, fully managed and Authoritative DNS, Authoritative = the customer can update the DNS records

* Route 53 is also a Domain Registrar
* Ability to check the health of your resources
* The only AWS services which provides 100% availability SLA
* 53 is a reference to traditional DNS port

**Records**

How you want to route traffic for a domain

Each record contains:
* Domain/Subdomain Name - e.g. example.com
* Record Type - e.g. A or AAAA
* Value -  e.g. 12.34.56.78
* Routing policy - how route 53 respond to queries
* TTL - ammount ammount of time the record cached at DNS Resolver

Route 53 support the following DNS record types:
* (must known) A/AAAA/CNAME/NS
* (advanced) CAA/DS/MX/NAPTR/PTR/SOA/TXT/SPF/SRV


Recort types:
* A - maps a hostaname to IPv4
* AAAA - maps a hostaname to IPv6
* CNAME - maps a hostaname to another hostname
    * The target domain which must have an A or AAAA record
    * Can't create a CNAME record for the top node of a DNS namespace (Zone apex)
    * Example: cannot create example.com but can create for www.example.com
* NS - Name servers for the Hosted Zone
    * Control how traffic is routed for a domain


___Alias Records___

These are similar to CNAME record types:
* Maps a hostname to an AWS resource
* An extension of DNS functionality
* Automatically recognized changes in the resource's IP addresses
* Unlike CNAME, it can be used for the top node of a DNS namespace (Zone Apex) for e.g. example.com
* Alias record is always of type A/AAAA for AWS resources (IPv4/IPv6)
* Cannot set TTL
* Cannot set an ALIAS for an EC2 DNS name

**Hosted Zones**

A container for records that define how to route traffic to a domain and its subdomains

* Public -> Contains records that specify how to route trasffic on the Internet (public domain names)

* Private -> Contain records that specify how you route traffic within one or more VPCs (private domain names)

* Pay $0.50 per month per hosted zone

* Duration minimum 1 year (13 USD)

**Routing policies**

Differences between Route 53 policies and ELB

ELB distributes traffic among Multiple Availability Zone but not to multiple Regions. Route 53 can distribute traffic among multiple Regions. In short, ELBs are intended to load balance across EC2 instances in a single region whereas DNS load-balancing (Route53) is intended to help balance traffic across regions.

Both Route 53 and ELB perform health check and route traffic to only healthy resources. Route 53 weighted routing has health checks and removes unhealthy targets from its list. However, DNS is cached so unhealthy targets will still be in the visitors cache for some time. On the other hand, ELB is not cached and will remove unhealthy targets from the target group immediately.

* Define how Route 53 responds to DNS queries
* It's not the same as Load balancer routing which routes traffic
* DNS does not route any traffic, it only responds to the DNS queries

Route 53 Supports the following Routing policies:
* Simple
* Weighted
* Failover
* Latency based
* Geolocation
* Multi-value answer
* Geoproximity (using Route 53 traffic flow feature)


___Health checks (not a policy type)___

* Http health checks are only for public resources
* Monitor endpoint
* Health checks are integrated with Cloud watch metrics (helpful for private resources)

Endpoint -> About 15 global health checkers will check the endpoint health, health checks are only passed with 2xx and 3xx responses.

Calculated Health checks -> Combine the results of multiple health checks into a single health check, we can use AND, OR or NOT, we can monitor up to 256 child health checks.

Private -> Use health checks to monitor cloudwatch alarms into your private VPC.

___Simple___

* Typically, route traffic to a single resource
* Can specify multiple values in the same record
* If multiple values are returned, a random one is chosen by the client
* When alias is enabled, specify only one AWS resource
* Can't be associated with Healt Checks

___Weighted___

* Control the % of the requests tha go to each specific resource
* Assign each record a relative weight
* DNS records must have the same name and type
* Can be associated with health checks
* Use cases: load balancing between regions, testing, etc
* Assing a weight of 0 to a record to stop sending traffic to a resource
* If all records have weight of 0, then all records will be returned equally

___Latency based___

* Redirect to the resource that has the least latency close to us
* Helpful when latency is top priority
* Latency is based on traffic between users and AWS regions
* Germany users can be directed to US if that is the lowest latency
* Can be associated with health Checks (Has a failover capability)

___Failover(Active-passive)___

* There is one instance that is the active, main instance
* If main instance fails, the second instance will take its place until the main instance is healthy again

___Geolocation___

* Different from Latency-based
* This routing is based on user location
* Specify location by continent, country, or by US state
* Should create a "Default" record (in case there is no match on location)
* Use cases: website localization, restrict content distribution, load balancing
* Can be associated with health checks

___Geoproximity___

* Route traffic to your resources based on the geographic location of users and resources
* Ability to shift more traffic to resources based on defined bias
* To change the size of the geographic region, specify a bias value:
    * To expand (1 to 99) - more traffic to the resource
    * To Shrink (-1 to -99) - less traffic to the resource

* Resources can be:
    * AWS resources (specify AWS region)
    * Non-AWS resources (specify Latitude and Longitude)
* Must use Route 53 traffic flow to use this feature


___IP-based___

* Routing based on clients' IP addresses
* You provide a list of CIDRs for your clients and the corresponding endpoints/locations (user-IP-to-endpoint mappings)
* Use cases: Optimize performance, reduce network cost
* Route end users from a particular ISP to a specific endpoint

___Multi Value___

* Use when routing traffic to multiple resources
* Route 53 return multiple value/resources
* Can be associates with Health Checks
* Up to 8 healthy records are returned for each Multi-Value query
* not a substitute for having an ELB

# ~~~~ AWS VPC ~~~~

* Private network to deploy resources (regional resources)
* Subnets allow you to partition your network inside your VPC (Availability zone resource)
* Public subnet is a subnet that is accessible from the internet
* Private subnet is a subnet that is not accessible from the internet
* To define access between subnets we use Route Tables

We have a default VPC per region and one public subnet per AZ with our AWS account.

**Internet gateway and NAT Gateways**

Public subnets have access to the internet through internet gateways, it helps our VPC instances connect with the internet, Public subnets have a route to the internet gateway.

NAT gateway (AWS managed) and NAT instances (self-managed) allows your instances in your private subnets to access the internet while remaining private

IGW -> NAT -> private subnet

**Network ACL and Security Groups**

* NACL (Network ACL)
    * A firwewall which controls traffic from and to the subnet
    * Can have allow and Deny rules
    * Are attached to the subnet level
    * Rules only include IP addresses

* Security groups
    * A firewall which controls traffic to and from an ENI / an EC2 instance
    * Can have only ALLOW rules
    * Rules include IP addresses and other security groups

**VPC flow logs**

Capture information about IP traffic going to your interfaces:
* VPC flow logs
* Subnet flow logs
* Elastic network interface flow logs

Helps to monitor and troubleshoot connectivity issues, captures network information from managed AWS interfaces -> ELB, ElasticCache, RDS, Aurora, etc.

VPC flow logs can go to S3, CloudWatch logs, and Kinesis data firehouse

**VPC Peering**

* Connects two VPC privately using AWS network
* Make them behave as if they were in the same network
* Must not have overlapping CIDR (IP address range)
* VPC Peering connection is not transitive (must be established for each VPC that need to communicate with one another)

**VPC Endpoints**

* Allow to connect to AWS services using a private network instead of the public www network
* This give you enhanced security and lower latency to access AWS services
* VPC endpoint gateway: S3 & DynamoDB
* VPC endpoint interface: the rest


# ~~~~ AWS S3 introduction ~~~~

* Backup and storage
* Distaster recovery
* Archive
* Hybrid cloud storage
* Host applications
* Media hosting
* Data lakes and big data analytics
* Software delivery
* Static websites

**Buckets**

AWS S3 allows people to store objects (files) in "Buckets" (directories) each bucket must have a globally unique name (accross all regions all accounts)

* AWS S3 buckets are defined at the region level
* S3 looks like a global service but buckets are created in a region
* Naming convention
    * No uppercase, No underscore
    * 3-63 characters long
    * Not an IP
    * Must start with lowercase letter or number
    * Must not start with prefix xn--
    * Must not end with suffix -s3alias

**Objects**

Object values are the content of the body

* Max object size is 5TB
* If uploading more than 5GB must use "Multi-part upload"
* Objects (files) have a key
* The key is the FULL path:
    * s3://my-bucket/my_file.txt
    * s3://my-bucket/my_folder1/another_folder/my_file.txt
* The key is composed of **prefix** + object name
    * s3://my-bucket/**my_folder1/another_folder**/my_file.txt

**S3 security**

* User-based
    * IAM Policies- which API calls should be allowed for a specific user from IAM

* Resource-based
    * Bucket policies - bucket wide rules from the s3 console - allow cross account
    * Object Access Control List (ACL) - finer grain (can be disabled)
    * Bucket Access Control List (ACL) - less common (can be disabled)

An IAM principal can access an S3 object if:
* The user IAM permissions ALLOW it OR the resource policy ALLOWS it and there is not explicit DENY

* Encryption: Encrypt objects in AWS S3 using encryption keys

There is no concept of directories within buckets but UI can trick us.

**S3 Versioning**

* You can version files in AWS S3
* IT is enabled at the bucket level
* Same key overwrite will change the version: 1,2,3
* It is a best practice to version buckets:
    * Protect against unintended deletes (ability to restore a version)
    * Easy roll back to previous version

Any file that is not versioned prior to enabling versioning will have "null" version.
Suspending versioning does not delete previous versions.

**AWS S3 Replication**

* Must enable versioning in source and destination buckets
* Cross-Region Replication (CRR)
* Same-Region Replication (SRR)
* Buckets can be in different AWS accounts
* Copying is asynchronous
* Must give proper IAM permissions to S3

Use cases:
* CRR - compliance, lower latency access, replication across accounts
* SRR - log aggregation, live replication between production and test accounts

After replication is enabled, only new objects are replicated, we can replicate existing objects using S3 batch replication.

For Delete operations, we can replicate delete markers from source to target and deletions with a version ID are not replicated (avoiding malicious deletes)

Lastly there is no chaining of replication - If bucket 1 has replication into bucket 2, which has replication on bucket 3, then, objects created in bucket 1 are not replicated to bucket 3.

**AWS S3 Storage classes**

___General Purpose___

* 99.99% Availability
* Used for frequently accessed data
* Low latency and high throughput
* Sustain 2 concurrent facility failures
* Use cases: Big data analytics, mobile and gaming applications, content distribution...

___Infrequent access___

* For data that is less frequently accessed but requires rapid access when needed
* Lower cost than S3 standard
* AWS S3 IA (S3 Standard-IA)
    * 99.9% Availability
    * Use cases: Disaster recovery, backups

* AWS S3 One Zone-Infrequent Acess (S3 One Zone-IA)
    * High Durability (99.999999%) in a single AZ, data lost when AZ is destroyed
    * 99.95% availability
    * Use cases: Storing secondary backup copies of on-premise data, or data you can recreate

___Glacier Storage Classes___

* Low-cost object storage meant for achiving / backup
* Price: price for storage + object retrival cost

* S3 Glacier Instant retrieval
    * Millisecond retrival, great for data accessed once a quarter
    * Minimum storage duration of 90 days
* S3 Glacier Flexible retrival (formerly Amazon S3 glacier)
    * Expedited (1 to 5 minutes), standar (3 to 5 hours), Bulkd (5 to 12 hours) - free
    * Minimum storage duration of 90 days
* S3 Glacier Deep archive
    * Standar (12 hours), Bulk (48) Hours, meant for long term storage

___Intelligent-Tiering___

* Small monthly monitoring and auto tiering fee
* Moves objects automatically between access tier based on usage
* There are no retrieval charges in S3 intelligent tiering

* Frequent access tier: default tier
* Infrequent access tier: objects not accessed for 30 days
* Archive instant access tier: objects not accessed for 90 days
* Archive access tier: configurable from 90 to 700+ days
* Deep Archive access tier: from 180 to 700+ days

# ~~~~ AWS CLI, SDK, IAM Roles and Policies ~~~~

* AWS EC2 Instance metadata (IMDS) is a powerful but one of the least known features to developers
* Allows AWS EC2 isntances to "learn about themselves" without using an IAM Role for that purpose
* You can retrieve the IAM Role name from the metadata, but you CANNOT retrieve the IAM Policy
* Metadata = Info about the EC2 instance
* Userdata = launch script of the EC2 instance


IMDSv2 vs IMDSv1

IMDSv2 is a more secure way to access the metadata information since it requires an auth token.

**MFA with CLI**

* To use MFA with the CLI, we must create a temporary session
* To do so, we must run the STS GetSessionToken API call

* aws sts get-session-token --serial-number arn-of-the-mfa-device --token-code code-from-token --duration-seconds 3600

**AWS Limits (Quotas)**

API Rate Limits
* DescribeInstances API for EC2 has a limit of 100 calls per seconds
* GetOjbect on S3 has a limit of 5500 GET per second prefix
* For intermittent errors: implement Exponential backoff
* For Consistent errors: request an API throttling limit increase

Service quotas (service limits)
* Running on-demand standar instances: 1152 vCPU
* You can request a service limit increace by opening a ticket

Exponential backoff
* Getting a ThrotthlingException intermittently
* Retry mechanism already included in AWS SDK API calls
* Must implement yourself if using AWS API directly
    * Only implement retries on 5xx codes

**AWS CLI Credentials provider chain**

The CLI will look for credentials in this order

1. Command line options - --region, --output, --profile
2. Environment variables - AWS_ACCESS_KEY, AWS_SECRET_ACCESS_KEY, AWS_SESSION_TOKEN
3. CLI credentials file - aws configure
4. CLI Configuration file - aws configure
5. Container credentials - for ECS tasks
6. Instance profile credentials - for EC2 Instance profiles

Java SDK for example will look for credentials in this order

1. Java system properties - aws.accessKeyId and aws.secretKey
2. Environment variables - AWS_ACCESS_KEY, AWS_SECRET_ACCESS_KEY, AWS_SESSION_TOKENre
3. The default credentials profiles file - shared by many SDK
4. Amazon ECS Container credentials - for ECS containers
5. Instance profile credentials - for EC2 Instance profiles

# ~~~~ AWS Advanced S3 ~~~~

**Lifecycle rules**

* Transition actions - configure objects to transition to another storage class
    * Move objects to Standar IA class 60 days after creation
    * Move to glacier for archiving after 6 months

* Expiration actions - configure objects to expire (delete) after some time
    * Access log files can be set to delete after 365 days
    * Can be used to delete old versions of files (if versioning is enabled)
    * Can be used to delete incomplete Multi-Part uploads

Rules can be created for a certain prefix (example: s3://mybucket/mp3/*)
Rules can be created for certain objects tags (example: Department finance)

**Storage class analysis**

* Helps to decide when to transition objects to right storage class
* Recommendations for standard and standard IA
    * Does not work for One-Zone IA and glacier
* Report is updated daily
* 24 to 48 to start seeing data analysis

**S3 Event notifications**

* S3:ObjectCreated, S3:ObjectRemoved
* S3:ObjectRestore, S3:Replications...

* Object name filtering possible (*.jpg)
* Use case: generate thumbnails of images uploaded to s3
* Create as many S3 events as desired
* S3 events typically deliver events in seconds but can sometimes take longer than a minute

In order so send notifications we need to set up IAM permissions for example

* SNS:Publish
* SQS:SendMessage
* lambda:InvokeFunction

All events end up in AWS EventBridge for further processing and this service can send over 18 AWS services as destinations.

With AWS EventBridge we have:

* Advanced filtering options - with JSON rules (metadata, object size, name...)
* Multiple destinations - ex Step Functions, Kinesis streams / Firehose
* Archive, replay events, reliable delivery


**S3 Baseline Performance**

* Amazon S3 automatically scales to high requests rates, latency 100-200 ms
* Application can achieve at least 3500 PUT/COPY/POST/DELETE or 5500 GET/HEAD requests per prefix in a bucket
* There are no limit of prefixes in a bucket

___S3 Performance___

Multi-part upload:

* Recommended for files > 100mb, must use for files > 5gb
* Can help paralelize uploads by spliting the file into multiple parts and uploading them in parallel

S3 Transfer acceleration (upload speed):

* Increase the transfer speed by transferring file to AWS edge location which will forward the data to the S3 bucket in the target region
* Compatible with multipart uploads

Transferring the file from USA to edge location is public and fast, however, transferring the file from USA's Edge location to S3 bucket in Australia is faster since it used a private network in AWS.

File in USA ---> Edge Location USA ---> S3 bucket AUSTRALIA

S3 Byte-range fetches (Download speed):

* Paralelize GETs by requesting specific byte ranges 
* Better resiliance in case of failures
* This works the same way as Multipart the difference is that this is a download action instead.
* Can be used to retrieve only partial data (For example head of a file)

___S3 Select & Glacier Select___

* Retrieve less data using SQL by performing server-side filtering
* Can filter by rows and columns
* Less network transfer, less CPU cost client-side

___S3 User-Defined Object Metadata & S3 Object Tags___

* S3 User-Defined Object metadata
    * When uploading objects you can assign metadata
    * Name-value (key-value) pairs
    * User-defined metadata must begin with "x-amz-meta"
    * Amazon S3 stores used-defined metadata keys in lowercase
    * Metadata can be retrieved while retrieving the object
* S3 Object Tags
    * Key-value pairs for Objects in Amazon S3
    * Useful for fine grained permissions (Only access specific objects with specific tags)
    * Useful for analytics (S3 objects grouped by tags)

* Cannot search by metadata or object tags
* Instead save metadata and tags in an Index in a SQL database such as MySQL or DynamoDB and search for it.

# ~~~~ AWS S3 Security ~~~~

**S3 Object encryption**

You can encrypt objets in S3 buckets using one of 4 methods:

* Server-Side Encryption (SSE)
    * Server-Side Encryption with Amazon S3-Managed-Keys (SSE-S3) - Enabled by default
        * Encrypts S3 objects using keys handled, managed and owned by AWS
    * Server-side Encryption with Amazon KMS in AWS KMS (SSE-KMS) 
        * Leverage AWS key management services to manage encryption keys
    * Server-side Encryption with Customer provided keys (SSE-C)
        * When you want to manage your own encryption keys
* Client-Seide Encryption

___Server-Side Encryption with Amazon S3-Managed-Keys (SSE-S3)___

* Encryption using keys handled by AWS
* Object is encrypted in the server (AWS)
* Encryption type is AES-256
* Must set header "x-amz-server-side-encryption":"AES256"
* Enabled by default by new buckets and objects

___Server-side Encryption with Amazon KMS in AWS KMS (SSE-KMS)___

* Encrytion using KMS
* KMS Advantages: control + audit keys usage using CloudTrail
* Object is encrypted in the server
* Must set header "x-amz-server-side-encryption":"aws:kms"

Limitations:

* May impact the KMS limits
* When uploading objects it calls GenerateDataKey KMS API
* When dowloading calls decrypt KMS API
* Counts towards the KMS quota per second
* Can increase quota using Service Quotas Console

___Server-side Encryption with Customer provided keys (SSE-C)___

* Fully managed by by customer outside AWS
* Amazon S3 does not store the encryption key provided
* HTTPS must be used
* Encryption key must be provided in HTTP header for every HTTP request

___Client-Seide Encryption___

* Use client libraries such as Amazon S3 Client-side encryption library
* Clients must encrypt data before sending to Amazon S3
* Clients must decrypt data when retrieving from Amazon S3
* Customer fully manages keys and encryption cicle

**Encryption in transit (TLS/SSL)**

AWS S3 Exposes two endpoints:
* HTTP - not encrypted
* HTTPS - Encrypted

HTTPS is recomended and mandatory for SSE-C.

**S3 Access logs**

* For audit purpose we can log access to S3 buckets
* Any request made to S3 from any account, authorized or denied will be logged into another S3 bucket
* This data can be analyzed and it must be in the same AWS region

**S3 Pre-Signed URLs**

Generate pre-signed URLs using S3 console, AWS CLI or SDK

* URL Expiration
    * S3 Console - 1 min up to 720
    * AWS CLI - in seconds up to 168 hours
* Users given a pre-signed URL for the GET/PUT

**S3 Access points**

Simplify security management for S3 buckets, Each access point has:

* Its own DNS name (Internet origin or VPC orign)
* An access point policy (similar to bucket policy) - manage security at scale

Example:

* Finance Team --> Finance team Access point --> S3 bucket /Finance prefix
* Sales Team --> Sales team Access point --> S3 bucket /Sales prefix
* Analytics Team --> Analytics team Access point --> S3 bucket /Analytics prefix


___VPC Origin___

* Can enable access point to be accessible only from within the VPC
* You must create VPC Endpoint to access the access point , Gateway or Interface Endpoint
* The VPC Endpoint Policy must allow access to the target bucket and Access Point


**S3 Object lambda**

* Use AWS Lambda functions to change the object before it is retrieved by the caller application
* Only one S3 bucket is needed on top of we create S3 Access point and S3 Object Lambda Access.

S3 --> S3 object lambda (convert data) --> response


# ~~~~ AWS Cloud Front ~~~~

Cloud Front is the CDN (Content delivery network) for AWS.

* Cloud Front uses Edge location to deliver content
* It functions like a cache for S3 bucket contents, it saves content in the nearest Edge Location
* Cloud front can be used as an Ingress to upload to S3

**CloudFront caching**

* The cache lives at each EdgeLocation 
* CloudFront Identifies each object in the cache using the Cache Key 
* You want to maximize the cache hit ratio to minimize request to the origin
* Can Invalidate part of the cache using CreateInvalidation API

CloudFront cache key:

* A unique identifier for every object in the cache
* By default consists of hostname + resource portion of the URL
* Can add other elements , Headers, cookies, query strings to the cache key using CloudFront Cache policies

**Cache Policy**

* Cache based on:
    * HTTP headers: None - whitelist
    * Cookies - None - Whitelist
    * Query string - None - whitelist - Include All-Except All
* Control the TTL, can be set by the origin using the cache control header, Expires header
* Create your own policy or use predefined Managed policies

**Cache Invalidations**

* In case S3 object is updated, CloudFront does not know it until TTL has expired (acts like cache for the content)
* We can force an entire or partial cache refresh by performing a CloudFront Invalidation
* We can invalidate all files (*) or a specific path (/images/*)

**Cache Behaviour**

* Configure different settings for a given URL path pattern
* Example: one specific cache behaviour to images/*.jpg files on your origin web server
* Route to different kind of origins/origin groups based on the content type or path pattern
    * /images/*
    * /api/*
    * /* (default cache behaviour)
* When adding additional cache behaviours the Default cache behaviour is always the last to be processed and is always /*


**CloudFront Geo Restriction**

* You can restrict who can access your distribution
    * AllowList: Allow your users to access your content only if they are in one of the countries on a list of a approved countries
    * BlockList: Prevent your users from accessing your content if they are in one of the countries on a list of banned countries
* The country is determined using 3rd party Geo-IP Database
* Use case: Copyright Laws to control access to content

**CloudFront Signed URL/Signed cookies**

* You want to distribute paid shared content to premium users over the world
* We can used CloudFront signed URL / Cookie, We attach a policy with:
    * Includes URL expiration
    * Includes IP ranges to access data from
    * Trusted Signers (which AWS accounts can create signer URLs)
* How long the URL be valid for:
    * Shared content (movie, music): make it short (few minutes)
    * Private content (private to the user): can make last it for years

* Signed URL: access to individual files (one Signed URL per file)
* Signed Cookies: access to multiple files (one signed cookie for many files)

CloudFront Signed URL vs S3 Pre-Signed URL

CloudFront
* Allow access to path no matter the origin, S3, EC2 etc
* Account wide key-pair, only the root can manage it
* Can filter by IP, path, date, expiration
* Can leverage caching features

S3 Pre-Signed URL
* Issue a request as the person who pre-signed the URL
* Uses the IAM key of the signing IAM principal
* Limited lifetime


**CloudFront Multiple Origin**

* To route to different kind of origins based on the content type
* Based on pattern:
    * /images/* ----> EC2
    * /api/* -------> Application Load Balancer
    * /* -----------> S3 bucket

**CloudFront Origin Groups**

* To increase high-availability and do failover
* Origin Group: one primary and one secondary origin
* If the primary origin fails, the second one is used

**CloudFront Field Level Encryption**

* Protect user sensitive information through application stack
* Adds an additional layer of security along with HTTPS
* Sensitive information encrypted at the edge close to user
* Uses asymmetric encryption
* Usage:
    * Specify set of fields in POST requests that you want to be encrypted (up to 10 fields)
    * Specify the public key to encrypt them

**CloudFront Real time logs**

* Get real-time requests received by CloudFront sent to Kinesis Data Streams
* Monitor, analyze and take actions based on content delivery performance
* Allows to choose:
    * Sampling rate - percentage of requets for which you want to receive
    * Specific fields and specific cache behaviours (path patterns)

# ~~~~ AWS ECS, ECR and Fargate ~~~~

**ECS - EC2 Launch Type**

* ECS = Elastic container service
* Launch docker containers on AWS = Launch ECS Tasks on ECS Clusters
* EC2 LaunchType -> you must provision & maintain the infrastructure (the EC2 instances)
* Each EC2 instance must run the ECS agent to register in the ECS cluster
* AWS takes care of starting/stopping containers

**ECS - Fargate Launch Type**

* Launch Docker containers on AWS
* You do not need to provision the infrastructure
* It's all serverless
* You just create task definitions
* AWS just runs ECS tasks for you based on the CPU/RAM needed
* To scale, just increase the number of tasks

**ECS - IAM roles for ECS**

* EC2 instance profile (EC2 Launch Type only)
    * Used by the ECS agent
    * Makes API calls to ECS service
    * Send container logs to CloudWatch logs
    * Pull Docker image from ECR
    * Reference sensitive data in Secrets manager or SSM parameter store

* ECS Task Role
    * Allows each task to have a specific role
    * Use different roles for the different ECS services you run
    * Task role is defined in the task definition

**ECS - ELB Integrations**

ECS can be integrated with any ELB type.

**ECS - Data volumes EFS**

* Mount EFS file systems onto ECS tasks
* Works for both EC2 and Fargate Launch types
* Task running in any AZ will share the same data in the EFS file system
* Fargate + EFS = Serverless
* Amazon S3 cannot be mounted as a file system

**ECS Service auto scaling**

* Automatically increase/decreasse the desired number of ECS tasks
* Amazon ECS Auto Scaling uses AWS application auto scaling
    * ECS service Average CPU utilization
    * ECS service Average memory utilization - Scale on RAM
    * ALB requests count per target - metrinc coming from the ALB 

* Target tracking - scale based on target value for a specific CloudWatch metric
* Step Scaling - scale based on a specified CloudWatch Alarm
* Scheduled Scaling - scale based on a specified date/time (predictable changes)

* ECS service auto scaling (task level) != EC2 Auto scaling (EC2 instance level)
* Fargate auto caling is much easier to setup (serverless)

**ECS Launch Type - Auto scaling EC2 instances**

* Accommodate ECS service scaling by adding underlying EC2 instances
* Auto scaling group scaling
    * Scale ASG based on CPU utilization
    * Add EC2 instances over time
* ECS cluster capacity provider (Prefered for EC2 launch type)
    * Used to automatically provision and scale the infrastructure for your ECS tasks
    * Capacity provider paired with an auto scaling group
    * Add EC2 instances when you are missing capacity (CPU, RAM)

**ECS Rolling updates**

* When updating a service from v1 to v2, we can control how many tasks can be started and stopped and in which order
* Can set Max and minimum healthy tasks such as Kubernetes RollOut Updates

**ECS Task Definitions**

* Task defninitions are metadata in JSON form to tell ECS how to run a Docker container
* It contains crucial information such as:
    * Image Name
    * Port Binding for Container and Host
    * Memory and CPU required
    * Environment variables
    * Netowkring information
    * IAM Role
    * Logging configuration (ex Cloudwatch)
* Can define up to 10 containers in a Task Definition

**ECS Load Balancing (EC2 Launch Type)**

* We get a Dynamic Host port mapping if you define only the container port in the task definition
* The ALB finds the right port on your EC2 instances
* Must allow on the EC2 instance's security group any port from the ALB's security group

**ECS Load Balancing (Fargate)**

* Each task has a unique private IP
* Only define the container port (host port is not applicable)
* Example
    * ECS ENI security group
        * Allow port 80 from the ALB
    * ALB Security group
        * Allow port 80/443 from web

**ECS Roles**

* One IAM Role per Task Definition

**ECS Environment Variables**

* Environment Variaable
    * Harcoded - e.g. URLs
    * SSM Parameter store - sensitive variables (e.g. API Keys, shared configs)
    * Secrets Manager - sensitive variables (e.g. DB passwords)
* Environment Files (bulk) - AWS S3

**ECS Data Volumes (bind mounts)**

* Share data between multiple containers in the same Task Definition
* Works for both EC2 and fargate tasks
* EC2 Tasks - Using EC2 instance storage
    * Data are tied to the lifecycle of the EC2 instance
* Fargate tasks - using ephimeral storage
    * Data are tied to the containers(s) using them
    * 20 GiB - 200 GiB (default 20 GiB)

* Use cases:
    * Share ephemeral data between multiple containers
    * Sidecar container pattern, where the sidecar container used to send metrics logs to other destinations (separation of concerns)


**ECS Task Placement (EC2 Launch Type only)**

* When a task of type EC2 is launched, ECS must determine where to place it, with the contrains of CPU, memory and available port
* Similarly, when a service scales in, ECS needs to determine which task to terminate
* To assist with this, you can define a task placement strategy and task placement constraints

**ECS Task Placement process**

* Task placement strategies are best effort
* When amazon ECS places tasks , it uses the following process to select container instances:
    * Identify the instances that satisfy the CPU, memory and port requirements in the task definition
    * Identify the instances that satisfy the task placement constraints
    * Identify the instances that satisfy the task placement strategies
    * Select the instances for task placement

**ECS Task Placement process**

___Binpack___

* Place tasks based on the least available amount of CPU or memory
* This minimizes the number of instances in use (cost savings)

___Random___

* Place the task randomnly in EC2 instances

___Spread___

* Place the task evenly based on the specified value
* Example: instanceId, attribute: ecs.availability-zone

**ECS Task Placement constraints**

* distinctInstance: place each task on a different container instance
* memberOf: places task on instances that satisfy an expression
    * Place tasks on instance type t2

**ECR**

Elastic container registry

* Store and manage Docker images on AWS
* Private and Public repository (Amazon ECR public gallery)
* Fully integreated wiht ECS, backed by AWS S3
* Access controlled through IAM (permission errors => policy)
* Supports image vulnerability scanning, versioning, image tags, image lifecycle


**Copilot**

* CLI tool to build, release and operate production-ready containerized apps
* Run your apps on AppRunner, ECS and fargate
* Helps you focus on building apps rather than setting up infrastructure
* Provisions all required infrastructure for containerized apps (ECS, VPC, ELB, ECR...)
* Automated deployments with one command using CodePipeline
* Deploy to multiple environments
* Troubleshooting, logs, health status, etc...

**EKS**

* Amazon EKS = Amazon Elastic Kubernetes service
* it is a way to launch managed Kubernetes Clusters on AWS
* Kubernetes is an open-source system for automatic deployment, scaling and management of containerized applications
* its an alternative to ECS
* EKS supports EC2 if you want to deploy worker nodes or fargate to deploy serverless containers
* Use case: if you company is already using Kubenetes on-premises or in another cloud and wants to migrate to AWS using kubernetes
* Can be used by any cloud

**EKS Node Types**

___Managed Node groups___

* Creates and manages nodes for you
* Nodes are part of an ASG managed by EKS
* Supports on-demand or spot instances

___Self managed nodes___

* Nodes created by you and registered to the EKS cluster and managed by an ASG
* You can use prebuilt AMI - Amazon EKS optimized AMI
* Supports On-demand or spot instances

___AWS Fargate___

* No maintenance required; no nodes managed

**EKS Data volumes**

* Need to specify storageclass manifest on EKS cluster
* Leverages a container storage interface compliant driver
* Support for:
    * Amazon EBS
    * Amazon EFS with fargate
    * Amazon FSx for Lustre
    * Amazon ESx for NetApp ONTAP


# ~~~~ AWS Elastic Beanstalk ~~~~

Elastic Beanstalk is a developer centric view of deploying an application on AWS

* It used all the component's we've seen before: EC2, ASG, ELB, RDS
* Managed service
    * Automatically handles capacity provisioning loadbalancing, scaling, application health monitoring, instance configuration....
    * Just the application code is the responsibility of the developer
* We still have full control over the configuration
* Beanstalk is free but you pay for the underlying instances

**Elastic Beanstalk components**

* Application: collection of Elastic Beanstalk components (environments, versions, configurations...)
* Application version: an iteration of your application code
* Environment
    * Collection of AWS resources running an application version (only one application version at a time)
    * Tiers: Webserver environment tier & Worker Environment Tier
    * You can create multiple environments (dev, test, prod...)

___Webserver tier___

It works as a common web server where applications are deployed under ELB

___Worker tier___

It works behind SQS queues, once a message is under a SQS queue, workers process this information

* Scales based on the number of SQS messages
* Can push messages to SQS queue from another Web server tier

**Elastic Beanstalk Deployment modes**

* All at once (deploy all in one go) - fastest, but instances aren't available to serve for a little bit (downtime)
* Rolling - update a few instances at a time, and then move onto the next bucket once the first bucket is healthy
* Rolling with additional batches - same as rolling but spins up new instances to move the batch (old application still available)
* Immutable - spins up new instances in a new ASG, deploys version to these instances, and then swaps all the instances when everything is healthy
* Blue green - create a new environment and switch over when ready
* Traffic splitting - canary testing, sends a small % of traffic to the new deployment

* Single instances -> good for dev, test
* High Availability with Load Balancer -> good for prod


**Elastic Beanstalk Lifecycle policy**

* Elastic Beanstalk can store at most 1000 application versions
* If you don't remove old versions you won't be able to deploy anymore
* To phase out old application versions, use a lifecycle policy
    * Based on time (old versions are removed)
    * Based on space (when you have too many versions)
* Versions that are currently used won't be deleted
* Option not to delete the source bundle in S3 to prevent data loss

**Elastic Beanstalk Extensions**

* A zip file containing our code must be deployed to Elastic Beanstalk
* All the parameters set in the UI can be configured with code using files
* Requirements:
    * in the .ebextensions/ directory in the root of source code
    * YAML / JSON format
    * .config extensions (example: logging.config)
    * Able to modify some default settings using: option_settings
    * Ability to add resources such as RDS, ElastiCache, DynamoDB, etc
* Resources managed by .ebextensions get deleted if the environment goes away

**Elastic Beanstalk Under the hood**

* Elastic beanstalk uses/relies on CloudFormation
* CloudFormation is used to provision other AWS Services
* Use case: you can define CloudFormation resources in your .ebextensions to provision ElastiCache, S3 bucket, anything...

**Elastic Beanstalk Cloning**

* Clone an environment with the exact same configuration
* Useful for deploying a "test" version of your application
* All resources and configuration are preserved:
    * Load balancer type and config
    * RDS Database type (data is not preserved)
    * Environment variables
* After cloning an environment you can change settings


**Elastic Beanstalk Migration: Load Balancer**

* After creating an ElasticBeanstalk environment, you cannot change the Elastic Load Balancer Type (only configuration)
* To migrate:
    * Create a new environment with the same configuration except LB
    * Deploy application onto the new environment
    * perform a CNAME swap or Route53 update

**Elastic Beanstalk RDS**

* RDS can be provisioned with Beanstalk, which is great for dev/test
* This is not great for prod as the database lifecycle is tied to the Beanstalk environment lifecycle
* The best for prod is to separately create an RDS database and provide our EB application with the connection string

___Decouple RDS___

1. Create a snapshot of RDS DB as safeguard
2. Go to the RDS console and protect the RDS database from deletion
3. Create a new Elastic Beanstalk environment without RDS, point your application to existing RDS
4. Perform a CNAME swap (blue/green) or Route 53 update, confirm it works
5. Terminate the old environment (RDS won't be deleted)
6. Delete CloudFormation stack (in DELETE_FAILED state)


# ~~~~ AWS CloudFormation ~~~~

CloudFormation is a delarative way of outlining your AWS infrastructure, for any resources (most of them are supported), it works as infrastructure as code

* Templates have to be uploaded in S3 and then referenced in CloudFormation
* To update a template, we can't edit previous ones. We have to re upload a new version of the template to AWS
* Stacks are identified by a name
* Deleting a stack deletes every single artifcact that was created by CloudFormation


___Deploying Templates___

* Manual Way:
    * Editing templates in the CloudFormation Designer
    * Using the console to input parameters, etc
* Automated way:
    * Editing templates in a YAML file
    * Using the AWS CLI (Command Line interface) to deploy the templates
    * Recommended way when you fully want to automate your workflow

**CloudFormation Resources**

* Resources are the core of your CloudFormation template (MANDATORY)
* They represent the different AWS components that will be created and configured
* Resources are declared and can reference each other
* AWS figures out creation, updates and deletes resources for us
* There are over 224 types of resources
* Resource types identifiers are of the form:
    * AWS::aws-product-name::data-type-name
* Cannot create code generation in the CloudFormation Template (non-dynamic)

**CloudFormation Parameters**

* Parameters are a way to provide inputs to your AWS CloudFormation template
* They're important to know about if:
    * You want to reuse your templates accross the company
    * Some inputs can not be determined ahead of time
* Parameters are extremely powerful, controlled and can prevent errors from happening in your templates thanks to types

___Referencing a parameter___

* The Fn::Ref function can be leveraged to reference parameters
* Parameteres can be used anywhere in a template
* The shorthand for this in YAML is !Ref
* The function can also reference other elements within the template like resources

**CloudFormation Mappings**

* Mappings are fixed variables within your CloudFormation Template
* They are very handy to differentiate between different environments (dev vs prod), regions (AWS regions), AMI types, etc
* All the values are hardcoded within the template
* Mappings are great when you know in advance all the values that can be deduced from variables such as:
    * Region
    * Availability zone
    * AWS Account
    * Environment

___Accessing Mapping values___

* We use Fn::FindInMap to return a named value from a specific key
* !FindInMap [ MapName, TopLevelKey, SecondLevelKey]

```yaml
Mappings:
    RegionMap:
        us-east-1:
            "32": "ami-123456"
            "64": "ami-7890"
        us-west-1:
            "32": "ami-abcde"
            "64": "ami-fghij"
```
* Example -> !FindInMap [ RegionMap, !Ref "AWS::Region", 32], imagine if we are in us-east-1 then we know what this value will be


**CloudFormation Outputs**

* The Outputs section declares optional outputs values that we can import into other stacks(if exported)
* Can also view the outputs in the AWS Console or using the AWS CLI
* Best way to perform collaboration cross stack, as you let expert handle their own part of the stack
* You can't delete a CloudFormation Stack if its outputs are being referenced by another CloudFormation Stack

___Cross Stack Reference___

* We then create a second template that leverages that security group
* For this we use the Fn::ImportValue function
* You can't delete the underlying stack until all the references are deleted too.

**CloudFormation Conditions**

* Conditions are used to control the creation of resources or outputs based on a condition
* Conditions can be wathever you want to be
* Each condition can reference another condition, parameter value or mapping

**CloudFormation Intrinsic functions**

* The Fn:Ref function can be leveraged to reference
    * Parameters -> returns the value of the parameter
    * Resources -> Returns the physical ID of the underlying resource
    * Shorthand !Ref


* The Fn:GettAtt returns attributes thata re attached to any resource created
    * To know the attributes of the resources we can look at documentation
    * Example -> !GetAtt EC2Instance.AvailabilityZone


* The Fn:Join, joins values with a delimiter
    * Example -> !Join [":", [a, b, c]] -> a:b:c


* Fn:Sub or !Sub as a shorthand is used to substitute variables from a text, its a very handy function that will allow you to fully customize your templates
* For eample combining Fn:Sub  with references or AWS Pseudo variables

**CloudFormation Rollbacks**

* Stack Creation fails:
     * Default: everything rolls back (gets deleted), we can look at the log
     * Option to disable rollback and troubleshoot what happened
* Stack Update fails:
    * The stack automatically rollsback to the previous known working state
    * Ability to see in the log what happened and error messages


**CloudFormation ChangeSets**

* When you update a stack you need to known what changes before it happens for greater confidence
* Change sets won't say if the update will be successful

**CloudFormation CrossStack|NestedStack**

* Cross Stacks:
    * Helpful when stacks have different lifecycles
    * Use outpits export and Fn::ImportValue
    * When you need to pass export values to many stacks

* Nested Stacks
    * Helpful when components must be re-used
    * Ex: re-use how to properlyconfigure an Application load balancer
    * Nested stack is only important to the higher level stack

**CloudFormation StackSets**

* Create, update or delete stacks across multiple accounts and regions with a single operation
* Administrator account to create StackSets
* Trusted accounts to create, update, delete stack instances from stacksets
* When you update a stack set, all associated stacks instances are updated throughout all accounts and regions


**CloudFormation Stack policies**

* During a CloudFormation stack update all update actions are allowed on all resources
* A stack policy is a JSON document that defines the updatre actions that are allowed on specific resources during stack updates
* Protect resources from unintentiontal updates
* When you set a stack policy, all resources in the stacka re protected by default
* Specify an explicit ALLOW for the resources you want to be allowed to be updated

# ~~~~ AWS SQS, SNS and Kinesis ~~~~

**Amazon SQS Standard queue**

* Oldest offering
* Fully managed service, used to decouple applications
* Attributes:
    * Unlimited throughput, unlimited number of messages in queue
    * Default retention of messages: 4 days, max 14 days
    * Low latency < 10ms on publish and receive
    * Limitation of 256Kb per message sent
* Can have duplicate messages (at least once delivery, occasionally)
* Can have out of order messages(best effort ordering)

**Amazon SQS Producing messages**

* Produces to SQS using the SDK(SendMessage API)
* The mesage is persisted in SQS until a consumer delets it
* Message retention: 4 days up to 14 days

**Amazon SQS Consuming**

* Consumers can run on EC2, local servers or AWS lambda
* Poll SQS for messages, receive up to 10 messages at a time
* Process the messages
* Delete the messages using the DeleteMessage API

**Amazon SQS Multiple EC2 instances as consumers**

* Consumers receive and process messages in parallel
* At least once delivery
* Best effort message ordering
* Consumers delete messages after processing them
* We can scale consumers horizontally to improve throughtput of the processing

**Amazon SQS Security**

* Encryption:
    * In-flight encryption using HTTPS API
    * At rest encryption using KMS keys
    * Client-side encryption if the client wants to perform encryption/decryption itself
* Access Controls: IAM policies to regulate access to the SQS API
* SQS access policies
    * Similar to S3 bucket policies
    * Useful for cross-account access to SQS queues
    * Useful for allowing other services to write to an SQS queue

**Amazon SQS Message visibility timeout**

* After a message is polled by a consumer, it becomes invisible to other consumers
* By default, the "message visibility timeout" is 30 seconds
* That means the message has 30 seconds to be processed
* After the message visibility timeout is over, the message is visible in SQS
* If a message is not processed withing the visibility timeout, it will be processed twice
* A consumer could call the ChangeMessageVisibility API to get more time
* If visibility timeout is high and consumer crashes, re-processing will take time
* If visibility timeout is too low we may get duplicates

**Amazon SQS Dead letter queue DLQ**

* If a consumer fails to process a message withing the same Visibility Timeout the message becomes visible again in the queue
* We can set a threshold of how many times a message can go back to the queue
* After the MaximumReceives threshold is exceeded, the message goes back into a dead letter queue DLQ
* DLQ of a FIFO queue must also be a FIFO queue
* DLQ of a Standar queue must also be a standard queue
* Make sure to process the messages in the DLQ before they expire
    * Good to set a retention of 14 days in the DLQ

**Amazon SQS DLQ Redrive to source**

* Feature to help consume messages in the DLQ to understand what is wrong with them
* When our code is fixed, we can redrive the messages from the DLQ back into the source queue (or any other queue) in batches without writing custom code

**Amazon SQS Delay queue**

* Delay a message so consumers don't see it immediately up to 15 minutes
* Default is 0 second, message is available right away
* Can set a default at queue level
* Can override the default on send using the DelaySeconds parameter

**Amazon SQS Long polling**

* When a consumer requests messages from the queue, it can optionally wait for messages to arrive if there are none in the queue
* This is called LongPolling
* LongPolling decreases the number of API calls made to SQS while increasing the efficiency and latency of your application
* The wait time can be between 1 sec to 20 sec
* Long Polling is preferable to Short polling
* Long Polling can be enable at the queue level or at the API level using ReceiveMessageWaitTimeSeconds

**Amazon SQS Extended Client**

* Message size limit is 256KB, how to send large messages?
* Using the SQS extended client -> java library
* Uses S3 behind the scenes

**Amazon SQS Must Know API**

* CreateQueue (Message retention period), Delete queue
* PurgeQueue: Delete all the messages in queue
* SendMessage (DelaySeconds), receive message, delete message
* MaxNumberOfMessages: default 1, max 10, for receiveMessage API
* ReceiveMessageWaitTimeSeconds: Long polling
* ChangeMessageVisibility: change the message timeout

* Batch APIS for sendMessage, DeleteMessage, ChangeMessageVisibility, helps to decrease costs

**Amazon SQS FIFO Queue**

* FIFO = First In First Out
* Limited throughput: 300 msg/s without batching, 3000 msg/s with batching
* Exactly-once send capability, removing duplicates
* Messages are processed in order by the consumer

**Amazon SQS FIFO Deduplication**

* De-duplication interval is 5 minutes
* Two de-duplication methods
    * Content-based deduplication: will do a SHA-256 has of the message body
    * Explicitly provide a Message Deduplication ID

**Amazon SQS Message Grouping**

* If you specify the same value of MessageGroupID in an SQS FIFO queue, you can only have one consumer, and all the messages are in order
* To get ordering at he level of a subset of messages, specify different values for MessageGroupID
    * Messages that share a common Message Group ID will be in order within the group
    * Each Group ID can have a different consumer
    * Ordering accross groups is not guaranteeed

**Amazon SNS**

* The event producer only sends message to one SNS topic
* As many event receivers (subscriptions) as we want to listen to the SNS topic notifications
* Each subscriber to the topic will get all the messages (note: new feature  to filter messages)
* Up to 12,500,000 subscriptions per topic
* 100,000 topics limit

**Amazon SNS security**

* Encryption
    * In-flight encryption using HTTPS API
    * At-rest encryption using KMS keys
    * Client-side encryption if the client wants to perform encryption/decryption itself
* Access controls: IAM policies to regulate access to the SNS API
* SNS Access Policies (similar to S3 buckets)
    * Useful for cross-account access to SNS topics
    * Useful for allowing other services to write to an SNS topic

**Amazon SNS+SQS fan out**

* Push once in SNS, receive in all SQS queues that are subscribers
* Fully decoupled, no data loss
* SQS allows for: data persistence, delayed processing and retries of work
* Ability to add more SQS subscribers over time
* Make sure your SQS queue access policy allow for SNS to write
* Cross-region delivery: works with SQS queues in other regions
* If you want to send the same S3 event to many SQS queues, use fan-out

**Amazon SNS FIFO Topic**

* FIFO = First in first out ordering
* Similar features as SQS FIFO:
    * Ordering by message group ID
    * Deduplication using a deduplication ID or content based deduplication
* Can only have SQS FIFO queues as subscribers
* Limited throughput, same as SQS

**Amazon SNS Message filtering**

* JSON policy used to filter messages sent to SNS topic's subscriptions
* If as subscription doesn't have a filter polic, it receives every message

**Amazon Kinesis**

Service which makes it easy to collect, process and analyze streaming data in real-time, can ingest real time data such as: Application logs, Metrics, Website clickstreams, IOT, telemetry.

* Kinesis Data streams: capture, process and store data streams
* Kinesis Data firehose: load data streams into AWS data stores
* Kinesis Data analytics: analyze data streams with SQL or Apache Flink
* Kinesis Video streams: capture, process and store video streams

**Amazon Kinesis Data streams**

* Made of multiple shards
* Produces produce a Record
    * Partition key -> Determine which shard will the record go to
    * Data blob -> Value itself
* Send records at a speed of 1MB/sec or 1000 msg/sec per shard

* Consumes a record
    * Partition key
    * Sequence no.
    * Data blob
    * 2MB/sec (shared) per shard all consumers or 2MB/sec (enhanced) per shard per consumer

* Retention between 1 to 365 days
* Ability to reprocess data (replay)
* Once data is inserted in Kinesis, it can't be deleted (immutability)
* Data that shares the same partition goes to the same shard (ordering)
* Producers: AWS SKD, Kinesis produces Library, Kinesis Agent
* Consumers:
    * Write your own: Kinesis Client Library, AWS SDK
    * Managed: AWS Lambda, Kinesis Data Firehose, Kinesis Data Analytics

**Amazon Kinesis Capacity modes**

* Provisioned mode:
    * You choose the number of shards provisioned, scale manually or using API
    * Each shard gets 1MB/s in (or 1000 records per second)
    * Each shard gets 2MB/s out (classic or enhanced fan-out consumer)
    * You pay per shard provisioned per hour
* On-demand mode:
    * No need to provision or manage the capacity
    * Default Capacity provisioned (4 MB/s in or 4000 records per second)
    * Scales automatically based on observer throughput peak during the last 30 days
    * Pay per stream per hour & data in/out per GB

**Amazon Kinesis Data streams security**

* control access / authorization using IAM policies
* Encryption in flight using HTTPS endpoints
* Encryption at rest using KMS
* You can implement encryption/decryption of data on client side (harder)
* VPC endpoints available for kinesis to access within VPC
* Monitor API calls using CloudTrail

**Amazon Kinesis Producers**

* Puts data records into data streams
* Data record consists of:
    * Sequence number (unique per partition-key within shard)
    * Partition key (must specify while put records into stream)
    * Data blob (up to 1 MB)
* Producers:
    * AWS SDK: simple producer
    * Kinesis producer library (KPL): C++, Java, batch, compression, retries
    * Kinesis Agent: monitor log files
* Write throughput: 1MB/Sec or 1000 records/sec per shard
* PutRecord API (API to send data into Kinesis)
* Use batching with PutRecords API to reduce costs & increase throughput

    ___Accessing Mapping values___

    ProvisionedThroughputExceeded happens when we exceed either 1 MB/sec or 1000 records/sec per shard

    Solution:
    * Use highly distributed partition key
    * Retries with exponential backoff
    * Increase shards (scaling) -> shard splitting


**Amazon Kinesis Consumers**

Get data records from data streams and process them

* AWS Lambda
* Kinesis Data Analytics
* Kinessi Data Firehose
* Custom consumer (AWS SDK) -- Classic or Enhanced Fan-Out
* Kinesis Client Library (KCL): library to simplify reading from data stream

    ___Custom Consumer Shared(Classic) Fan-Out Consumer - pull___

    * Low number of consuming applications
    * Read throughput 2MB/sec per shard across all consumers (if we have 6 consumers then 2/6 MB is the ammount per consumer)
    * Max 5 GerRecords API calls/sec
    * Latency ~200ms
    * Minimal cost
    * Consumers poll data from Kinesis using GetRecords API call
    * Returns up to 10 MB (then throttle for 5 seconds) or up to 10000 records

    ___Custom Consumer Enhanced Fan-Out Consumer - push___

    * Multiple consuming applications for the same stream
    * 2 MB/sec per consumer per shard
    * Latency ~70ms
    * Higher cost
    * Kinesis pushes data to consumers over HTTP/2 (Subscribe to Shard API)
    * Soft limit of 5 consumer applications (KCL) per data stream (default), can be increased by putting a ticket into AWS

    ___Custom Consumer AWS Lambda___

    * Supports classic and Enhanced fan-out consumers
    * Read records in batches
    * Can configure batch size and batch window
    * If error occurs, Lambda retries until succeeds or data expired
    * Can process up to 10 batches per shard simultaneously


**Amazon Kinesis Client Library**

* Java library that helps record from a Kinesis data stream with distributed application sharing the read workload
* Each shard is to be read by only one KCL instance
    * 4 shards = max 4 KCL instances
    * 6 shards = max 6 KCL instances

* Progress is checkpointed into DynamoDB (needs IAM access)
* Track other workers and share the work amongs shards using DynamoDB
* KCL can run on EC2, Elastic Beanstalk and on-premises
* Records are read in order at the shard level
* Versions:
    * KCL 1.x (supports shared consumer)
    * KCL 2.x (supports ahred and enhanced fan-out consumer)

**Amazon Kinesis Operations**

* Following kinesis operations_

    ___Shard Splitting___

    * Used to increase the stream capacity (1MB/s data in per shard)
    * Used to divide a "hot shard"
    * The old shard is closed and will be deleted once the data is expired
    * No automating scaling (manually increase/decrease capacity)
    * Can't split into more than two shards in a single operation

    ___Merging Shards___

    * Decrease the stram capacity and save costs
    * Can be used to group two shards with low traffic (cold shards)
    * Old shards are closed and will be deleted once the data is expired
    * Can't merge more than two shards in a single operation


**Amazon Kinesis Data Firehose**

Fully managed service, no administration, automating scaling, serverless

* Pay for data going through Firehouse
* Near Real time
    * 60 seconds latency minimum for non full batches
    * Or minimum 1 MB of data at a time

* Supports many data formats, conversions, tranformations, compression
* Supports custom data transformations using AWS Lambda
* Can send failed or all data to a backup S3 bucket
* Custom destination using HTTP Endpoints

Destinations of data firehose
* Amazon S3
* Amazon Redshift (Copy through S3) From S3 to redshift
* Amazon OpenSearch

Can also send to 3rd party partners
* MongoDB
* Datadog
* Splunk

* Custom destination using HTTP Endpoints


* Does not have data storage like AWS Kinesis data streams
* Automatic scaling
* Does not support replay capability

**Amazon Kinesis Data Analytics for SQL applications**

Real-time analytics on Kinesis Data Streams & firehose using SQL

* Add reference data from Amazon S3 to ernich streaming data
* Fully managed, no servers to provision
* Automatic scaling
* Pay for actual consumption rate
* Output:
    * Kinesis data streams: create streams out of the real-time analytics queries
    * Kinesis data firehose: send analytics query results to destinations

Sources
* Kinesis data streams
* Kinesis data firehose

Destinations
* Kinesis data streams
* Kinesis data firehose


**Amazon Kinesis Data Analytics for Flink**

Renamed to Amazon managed service for apache flink

Read from
* Kinesis data streams
* Amazon MSK

* Use flink to process and analyze streaming data
* Run it on managed cluster on AWS
    * provisioning compute resources, parallel computation, automatic scaling
    * application backups
    * Use any apache Flink programming features
    * Flink does not read from firehose (use Kinesis Analytics for SQL instead)


# ~~~~ AWS Monitoring and Audit, Cloudwatch, X-ray and CloudTrail ~~~~

**AWS Cloudwatch Metrics**

* Provides metrics for every service in AWS
* Metric is variable to monitor (cpu utilization, Networking, etc ...)
* Metrics belong to namespaces
* Dimension is an attribute of a metric (instance id, environment, etc...)
* Up to 30 dimensions per metric
* Metrics have timestamps
* Can create CloudWatch dashboards from metrics

    ___EC2 detailed monitoring___

    * EC2 instance metrics have metrics every 5 minutes
    * With detailed monitoring you can get data every 1 minute (for a cost)
    * Use datailed monitoring if you want tos cale faster for your ASG
    * AWS free tier allos us to have 10 detailed monitoring metrics
    * EC2 memory usage is by default not pushed (must be pushed from inside the instance as a custom metric)

**AWS Cloudwatch custom Metrics**

* Possibility to define and send your own custom metrics to CloudWatch
* Example: memory (RAM) usage, disk space, number of logged in users...
* Use API call PutMetricData
* Ability to use dimentions (attributes) to segment metrics
    * insence.id
    * Environment.name
* Metric resoluton (StorageResolution API parameter - two possible value):
    * Standard: 1 minute
    * Higher resolution: 1/5/10/30 seconds - Higher cost
* Important: Accepts metric data points two weeks in the past and two hours in the future (make sure to configure your EC2 instance time correctly)
* No errors will be triggered from Cloudwatch from past or future hours

**AWS Cloudwatch Logs**

* Log groups: arbitrary name, usually representing an application
* Log stream: instances within application / log files / containers
* Can define log expiration policies (never expire, 1 day to 10 years)

* CloudWatch can send logs to:
    * Amazon S3 (exports)
    * Kinesis data streams
    * Kinesis data firehose
    * AWS Lambda
    * OpenSearch

* Logs are encrypted by default
* Can setup KMS-based encryption with your own keys

Sources:
* SDK, Cloudwatch logs agent, cloudwatch unified agent
* Elasticbeanstalk: collection of logs from application
* ECS: collection from containers
* AWS lambda: collection from function logs
* VPC flow logs: VPC specific logs
* API Gateway
* CloudTrail based on filter
* Route53: Log DNS queries


* Log data can take up to 12 hours to become available to export
* The API call is CreateExportTask
* Not near-real time or real-time, use log suscriptions instead

    ___Cloudwatch log insights___

    * Search and analye log data store in cloudwatch logs
    * Provides a purpose built query language
        * Automatically discovers fields from AWS services and JSON log events
        * Fetch desired event fields, filter based on conditions, calculate aggregate statistics, sort events, limit number of events
        * Can save queries and add them to CloudWatch Dashboards
    * Can query multiple log groups in different AWS accounts
    * its a query engine, not a real-time engine

    ___Cloudwatch log subscriptions___

    * Get a a real-time log events from CloudWatch logs for processing and analysis
    * Send to Kinesis Data Srtams, Firehose or lambda
    * Suscription filter - filter which logs are events delivered to your destination


**AWS Cloudwatch Logs For EC2**

* By default no logs from EC22 will go to Cloud Watch
* Need to run a Cloudwatch agent on EC2 to push the log files you want
* Make sure IAM permissions are correct
* The cloudwatch log agent acn be setup on-premises too

    ___Cloudwatch log agent___
    * Old version of the agent
    * Can only send to Cloudwatch logs

    ___Cloudwatch  unified agent___
    * Collect additional system-level metrics such as RAM, processes, etc...
    * Collect logs to send to CloudWatch logs
    * Centralized configuration using SSM parameter store

    * CPU (active, guest, idle, system, user, steal)
    * Disk metrics (free, used, total), Disk IO (writes, reads, bytes, iops)
    * RAM (free, inactive, used, total, cached)
    * Netstat ( number of TCP and UDP connections, net packets, bytes)
    * Processes (total, dead, bloqued, idle, running, sleep)
    * Swap space (free, used, used %)

    * Reminder: out-of-the box metrics for EC2 - disk, CPU, network (high level)


**AWS Cloudwatch Logs Metric filter**

* Cloudwatch logs can use filter expressions
    * Can be used to trigger alarms
* Filters do not retroactively filter data, Filters only publish the metric data points for events that happen after the filter was created
* Ability to specify up to 3 dimensions for the metric filter

**AWS Cloudwatch Alarms**

* Alarms are used to trigger notifications for any metric
* Various options (sampling, %, max, min, etc...)
* Alarm states:
    * OK
    * INSUFFICIENT_DATA
    * ALARM
* Period:
    * Length of time in seconds to evaluate
    * High resolutuon custom metrics: 10, 30, 60 secs

    ___Alarm targets___
    * Stop,terminate, reboot and recover an EC2 instance
    * Trigger auto scaling action
    * Send notifications to SNS (from which you can do pretty much anything)

___Composite Alarms___

* Cloudwatch alarms are on a single metric
* Composite alarms are monitoring the states of multiple other alarms
* AND OR conditions
* Helpful to reduce "alarm noise" by creating complex composite alarms

___EC2 instance recovery___

* Status check:
    * Instance status = check the EC2 VM
    * System status = check the underlying hardware
* Recovery: Same private public elastic IP, metadata, placement group


**AWS Cloudwatch Synthetics canary**

* Configurable script that monitor your APIs, URLs, websites
* Reproduce what your customers do programmatically to find issues before customers are impacted
* Checks the availability and latency of your endpoints and can store load time data and screenshots of the UI
* Integration with CloudWatch Alarms
* Scripts written in Node.js or Python
* Programmatic access to a hheadless google chrome browser
* Can run once or on a regular schedule

Blueprints:
* Heartbeat Monitor - load URL, store screenshot and an HTTP archive file
* API Canary - test basic read and write functions of REST APIs
* Broken link Checker - check all links inside the URL you are testing
* Visual Monitoring - compare a screenshot taken during a canary run with a baseline screenshot
* Canary recorder - used with clouwatch synthetics recorder (record your actions on a website and automatically generates a script for that)
* GUI workflow builder - verifies that actions can be taken like a login form

**AWS Cloudwatch Event Bridge**

* Schedule: Cron jobs (scheduled scripts)
* Event pattern: Event rules to react to a service doing something
    * Sign In event -> SNS notification
* Trigger lambda functions, send SQS/SNS messages...

Sources:
* EC2 instance: start instance
* CodeBuild: Failed build
* S3: upload object
* Schedule: Cron every 4 hours
* ...

Destinations:
* Lambdas
* AWS Batch
* ECS task
* SQS
* SNS
* Kinesis data streams
* Codebuild
* ...

Previous example is the Default Event Bus, however, event bridge has something called "Partner event bus", therefore we can react to changes happening outside AWS from these SAAS partners.

Custom Event bus also applies here which are notifications from custom applications.

* Event buses can be accessed by other AWS accounts using Resource-based poilicies
* You can archive events(all/filter) sent to an event bus (indefinitely or set period)
* Ability to replay archived events


___EventBridge Schema registry___

* EventBridge can analyze the events in your bus and infer the schema
* The Schema Registry allows you to generate code for your application that will know in advace how data is structured in the event bus
* Schema can be versioned

___EventBridge Resource-based policy___
* Manage permissions for a specific Event Bus
* Example: allow/deny events from another AWS account or AWS region
* Use case: aggregate all events from your AWS organization in a single AWS account or AWS region

**AWS X-Ray**

Visual analysis for our applications

* AWS Lambda
* Elastic Beanstalk
* ECS
* ELB
* API Gateway
* EC2 instances or any application server

X-Ray leverages tracing
* Tracing is an end to end way to follow a request
* Each component dealing with the request adds its own trace
* Tracing is made of segments
* Annotations can be added to traces to provide extra-information
* Ability to trace:
    * Every request
    * Sample request (as a % for example or a rate per minute)
* X-Ray security:
    * IAM for authorization
    * KMS for encryption at rest

How to enable?

1. Must import the AWS X-Ray SDK
    * Very little code modification needed
    * The application SDK will then capture
        * Calls to AWS services
        * HTTP/HTTPS requests
        * Database calls
        * Queue calls (SQS)
2. Install the X-Ray daemon or enable X-Ray AWS integration
    * X-Ray daemon works as a low level UDP packet interceptor
    * AWS Lambda /other AWS services already run the X-Ray daemon
    * Each application must have the IAM rights to write data to X-Ray

AWS X-Ray Troubleshooting
* If X-Ray is not working on EC2
    * Ensure the EC2 IAM Role has the proper permissions
    * Ensure the EC2 instance is running the X-Ray daemon
* To enable on AWS Lambda:
    * Ensure it has an IAM execution role with proper policy
    * Ensure X-Ray is imported in the code
    * Enable Lambda X-Ray active tracing

**AWS X-Ray instrumentation**

Means the measure of product's performance, diagnos errors, and to write trace information
* To instrument your application code you use X-Ray SDK

**AWS X-Ray Concepts**

* Segments: each application / service will send them
* Subsegments: if you need more details in your segment
* Trace: segments collected together to form an end to end trace
* Sampling: decrease the amount of requests sent to X-Ray to reduce cost
* Annotations: Key value pairs used to index and use with filters
* Metadata: Key value pair, not indexed, not used for searching

* The X-Ray daemong / agent has a config to send traces cross account:
    * make sure the IAM permissions are correct - the agent will assume the role
    * This allows to have central account for all your application tracing

**AWS X-Ray Sampling rules**

* With sampling rules, you control the amount of data that you record
* You can modify sampling rules without chaning your code

* By default the X-Ray SDK records the first request each second, and five percent of any additional requests
* One requests per second is the reservoir which ensures that at least one trace is recorded each second as long as the service is serving requests

* Five percent is the rate at which additional requests beyond the reservoir size are sampled

**AWS X-Ray APIs used by daemon**

* PutTraceSegments
* PutTelemetryRecords
* GetSamplingRules

* GetServiceGraph
* BatchGetTraces
* GetTraceSummaries
* GetTraceGraph

**AWS X-Ray ECS**

In order to connect to X-Ray from ECS we need to map the port 0 to 2000 and then add the environment variable "AWS_XRAY_DAEMON_ADDRESS" with the value of the name , in this case "xray-daemon:2000" and lastly we need to link the application to it.
```json
{
    "portMappings" : [
        "hostPort": 0,
        "containerPort": 2000,
        "protocol": "udp"
    ],

    "links": [
        "xray-daemon"
    ]
}
```

**AWS Distro for OpenTelemetry**

* Secure, production ready AWS-supported distribution of the open source project open telemetry
* Provides a single set of APIs, libraries, agents and collector services
* Collects distributed traces and metrics from your apps
* Collects metadata from your AWS resources and services
* Collects traces without changing code
* Send traces and metrics to multiple AWS services and partner solutions
* Migrate from X-Ray to AWS Distro for telemetry if you want to standardize with open-source APIs from telemetry or send traces to multiple destinations simultaneously


**AWS Cloud Trail**

* Provides governance, compliance and audit for AWS account
* CloudTrail is enabled by default
* Get history of events / API calls made within the AWS account
    * Console
    * SDK
    * CLI
    * AWS services

* Can put logs from CloudTrail into CloudWatch logs or S3
* Can be applied to all regions or single region
* If a resource is deleted, check cloud trail


** _TCP is layer 4_.

** _HTTP and HTTPS are layer 7_


