
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

___Never enter your IAM keys (access keys) into an EC2 instance, instead use IAM roles___

___EC2 stands for Elascitc Cloud Compute___


# EC2 INSTANCE TYPES

* General Purpose

    General purpose instances provide a balance of compute, memory and networking resources, and can be used for a variety of diverse workloads. 
    These instances are ideal for applications that use these resources in equal proportions such as web servers and code repositories. 

    Use Cases

    **Developing, building, testing, and signing iOS, iPadOS, macOS, WatchOS, and tvOS applications on the Xcode IDE**



* Compute Optimized

    Compute Optimized instances are ideal for compute bound applications that benefit from high performance processors.
    Instances belonging to this family are well suited for batch processing workloads, media transcoding, 
    high performance web servers, high performance computing (HPC), scientific modeling, dedicated gaming servers and ad server engines, machine learning inference and other compute intensive applications.

    Use Cases

    **High performance computing (HPC), batch processing, ad serving, video encoding, gaming, scientific modelling, distributed analytics, and CPU-based machine learning inference.**

* Memory Optimized

    Memory optimized instances are designed to deliver fast performance for workloads that process large data sets in memory.

    Use Cases

    **Memory-intensive applications such as open-source databases, in-memory caches, and real time big data analytics**

* Accelerated Computing

    Accelerated computing instances use hardware accelerators, or co-processors, to perform functions, such as floating point number calculations, graphics processing, or data pattern matching,
    more efficiently than is possible in software running on CPUs.

    Use Cases

    **Machine learning, high performance computing, computational fluid dynamics, computational finance, seismic analysis, speech recognition, autonomous vehicles, and drug discovery.**

* Storage Optimized

    Storage optimized instances are designed for workloads that require high, sequential read and write access to very large data sets on local storage.
    They are optimized to deliver tens of thousands of low-latency, random I/O operations per second (IOPS) to applications.

    Use Cases

    **NoSQL databases (e.g. Cassandra, MongoDB, Redis), in-memory databases (e.g. Aerospike), scale-out transactional databases, data warehousing, Elasticsearch, analytics workloads.**

# EC2 provides different EC2 instance options

 ## **EC2 On-Demand Instances**

Short workloads, predictable pricing, EC2 On Demand, pay what you use:

* Linux - billing per second, after the first minute
* All other operating systems (ex: Windows) - billing per hour
* Has the highest cost but no upfront payment
* No long-term commitment
* ___Recommended for short-term and un-interrupted workloads where you can't predict the      application's behaviour___

## **EC2 Reserved Instances(MINIMUN 1 year)**

___"+" means discount amount more "+" means more discount___

Long workloads.

Up to 75% discount compared to On-Demand.

Reservation period: 1 year = +discount | 3 years = +++discount.

Purchasing options: no upfront | partial upfront (monthly) = + | All upfront(single payment beforprovison) = +++.

Reserve a specific instance type.

___Recommended for steady-state usage applciation (Databases).___

* Convertible Reserverd Instances: 
    * Long workloads with flexible instances
    * Can change the EC2 instance type
    * Up to 54% discount
* Scheduled Reserved Instances:
    * Launch within time windos you reserve
    * When you require a fraction of day / week / month
    * Still commitment over 1 to 3 yeards

## **EC2 Spot Instances**
Short worloads, cheap, can lose instances(less reliable).

* Can get a discount of up to 90% compared to On-Demand
* Instances that you can "lose" at any point of time if your max price is less than the current spot price
* The MOST cost-efficient instances in AWS

* Useful for workloads that are resilient to failure
    * Batch jobs
    * Data analysis
    * Image processing
    * Any distributed workloads
    * Workloads with a flexible start and end time

___NOT SUITABLE FOR CRITICAL JOBS OR DATABASES**___


## **EC2 Dedicated hosts**

Book an entire physical server, controls instance placement.

* Physical server with EC2 instance capacity full dedicated for your use. Can be helpful to address COMPLIANCE REQUIREMENTS
* Use it with your EXISTING SERVER-BOUND SOFTWARE LICENSES

* Allocated for your account for a 3-year period reservation
* More expensive
* Useful for software that have complicated licensing model (Bring your own license - BYOL)
* Companies that have strong compliance needs


## **EC2 Dedicated instances**
Just like a soft version of dedicated hosts with a Per-Instance billing.

* Instances running on hardware that's dedicated to you
* May share hardware with other instances in same account
* No control over instance placement (can move hardware after Stop / Start)

# EC2 Instance storage EBS (Elastic Block store)

**EBS volumes are network drives with limited performance**

Delete on termination attribute
* Controls the EBS behaviour when an EC2 instance terminates
* Can create snapshots and move from regions and availability zones

Custom AMI (Amazon Machine Image), is a customization of an EC2 Instance , you add your own software and customization, operating system, monitoring, faster boot etc, these are built for specific regions however these can be replciated in different regions.

* Can launch AMIs from amazon, AWS provides
* Create your own AMI 

**EBS volume types https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ebs-volume-types.html (we just need to understand when to use each type)**

___NOTE: we can attach multiple EBS instances to a single volume only if we use a io1/io2 family , multi-attach___

# Local EC2 Instance store

EC2 instance store on the other hand is a hard-disk (physical)

Some characteristics of EC2 instance store.

* Better I/O performance
* EC2 instance store lost their storage if stopped (if we stop the EC2 instance data is loss)
* Good for buffer / cache / scratch data / temporary content
* Risk of data loss if hardware fails
* Backups and Replication are your responsibility

# EFS Elastic file system

* Managed NFS (network file system) that can be mounted on many EC2
* EFS works with EC2 isntances in multi-AZ
* Highly available and scalable , expensive (up to 3x gp2), pay per use

Use cases:

* Content management, web serving, data sharing , Wordpress
* USES NFSv4.1 protocol <<<<<
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
    * Bursting(1TB = 50Mib/s)
    * Provisioned: set your througput regardless of storage size, ex 1GiB/s 1 TB storage

* Storage Tiers (lifecycle management feature - move file after N days)
    * Standard : for frequently accessed files
    * Infrequent access: cost to retrieve files, lower price to store 


# EBS elastic load balancer

AWS has 3 kinds of managed Load Balancers

* **Classic Load Balancer (v1 - old generation) - 2009 -- Supports HTTP, HTTPS, TCP**
    * Health checks are TCP or HTTP
    * Fixed Hostname

* **Applcation Load Balancer (v2 - new generation) - 2016 -- Supports HTTP, HTTPS, TCP, WebScoket**

    * Only layer 7 (HTTP, HTTPS)
    * Load balancing to multiple HTTP applications across machines
    * Load balancing multiple applications on the same machine (ex: containers)
    * Support for HTTP/2 and websocket
    * Supprot redirects from http to https

    * GOOD for microservices and containerbased applications like Docker and Amazon ECS
    * Has a port mapping feature to redirect to a dynamic port in ECS
    * In comparison we'd need multiple classic load balancer per application
    * ALB can route to muiltiple target groups
    * Health checks are at a target group level
    * Static hostname

    Target groups
     * EC2 instances (can be managed by an auto scalin group) - HTTP
     * ECS (managed by ECS itself) - HTTP
     * Lambda functions
     * IP Addresses - must be private
    
* **Network Load Balancer (v2 - new generation) - 2017 -- Supports TCP, TLS (Secure TCP), UDP**

    * Only layer 4 (TCP, UDP)
    * Handle millions of requests per seconds
    * Less latency ~100 ms vs 400 ms for ALB
    * NLB has one static IP per AZ, and supports assigning ELASTIC IP (helpuf for whitelisting)
    * NLB are used for extreme performance

** _TCP is layer 4_.

** _HTTP and HTTPS are layer 7_


