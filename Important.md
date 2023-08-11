
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
### EBS elastic load balancer

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

    wheneve we update the launch template new EC2 instance will appear while old EC2 instances using the old launch template will be terminated 

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

** _TCP is layer 4_.

** _HTTP and HTTPS are layer 7_


