
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
    * Handle millions of requests per seconds
    * Less latency ~100 ms vs 400 ms for ALB
    * NLB has one static IP per AZ, and supports assigning ELASTIC IP (helpuf for whitelisting)
    * NLB are used for extreme performance

* **Gateway Load Balancer 2020 - GWLB**
    * Operates at layer 3 (Network layer) - IP protocol

It is recomended to use new generation load balancers.

** _TCP is layer 4_.

** _HTTP and HTTPS are layer 7_


