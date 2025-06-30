# output "vpc-name" {
#    value = google_compute_network.vpc.name
#  }

# output "vpc-id" {
#    value = google_compute_network.vpc.id
#  }
 
# output "sub-net-name" {
#    value = google_compute_subnetwork.subnet.name
# }

# output "sub-net-id" {
#    value = google_compute_subnetwork.subnet.id
#  }

output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_ids" {
  value = [for s in aws_subnet.public : s.id]
}