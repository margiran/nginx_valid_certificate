#!/usr/bin/env python3

from mmap import PROT_READ
from diagrams import Diagram
from diagrams import Cluster, Diagram, Edge
from diagrams.custom import Custom
from diagrams.aws.compute import EC2 
from diagrams.onprem.network import Nginx
from diagrams.aws.network    import Route53
from diagrams.onprem.compute import Server

with Diagram("Nginx valid certificate", show=False):
    client = Server("Client")
    lets = Server("Lets encrypt")
    # dns = Route53("Route53")
    # internet = Internet("internet")
    with Cluster("VPC"):
        with Cluster("SubNet"):
            nginx = Nginx("Nginx") 
            dns = Route53("Route53")


            client >> nginx
            nginx >> lets
            nginx >> dns
