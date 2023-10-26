<!-- (C) Copyright 2020-2023 Hewlett Packard Enterprise Development LP -->
# Obtaining available resources in the physical infrastructure

This is an example of querying the physical infrastructure to obtain information on the available compute,
networks and storage resources available and currently under control.

To run the example:
* Authenticate against a portal using steeld login
* Update `variables.tf` OR provide overrides on the command line
* Run with a command similar to
```
terraform apply \
    -var ="location=USA:Texas:AUSL2"
```

After running `terraform apply` a list of details resources will be emitted in json format.

## Example Output
```
images = [
  {
    "category" = "Linux"
    "flavor" = "CoreOS"
    "id" = "cea233f1-6ee4-4b20-b357-8e4bded6d371"
    "version" = "2135.6.0"
  },
  {
    "category" = "Linux"
    "flavor" = "CoreOS"
    "id" = "3895453f-6cb3-4e91-9b56-e6618c5088f6"
    "version" = "1800.6.0"
  },
]
locations = [
  {
    "country" = "USA"
    "data_center" = "AUSL2"
    "id" = "b3b64a26-fdb2-4d4d-9f8d-5096cbb662a6"
    "location" = "USA:Texas:AUSL2"
    "region" = "Texas"
  },
  {
    "country" = "USA"
    "data_center" = "AUSL3"
    "id" = "d2faae30-85f9-4c57-8a2d-3118c30968b8"
    "location" = "USA:Texas:AUSL3"
    "region" = "Texas"
  },
]
machine-sizes = [
  {
    "description" = ""
    "id" = "944e7b2c-a181-4aa2-afcc-35480b07caa4"
    "location" = "USA:Texas:AUSL2"
    "location_id" = "b3b64a26-fdb2-4d4d-9f8d-5096cbb662a6"
    "name" = "Any"
    "quantity" = 8
  },
  {
    "description" = ""
    "id" = "310a1a29-eb7b-411e-b3a0-a20c200bcf16"
    "location" = ""
    "location_id" = ""
    "name" = "Large System"
    "quantity" = 0
  },
]
networks = [
  {
    "host_use" = "Required"
    "id" = "17d3dcae-2744-436f-943d-2d926791264f"
    "kind" = "Shared"
    "location" = "USA:Texas:AUSL2"
    "location_id" = "b3b64a26-fdb2-4d4d-9f8d-5096cbb662a6"
    "name" = "Public"
  },
  {
    "host_use" = "Default"
    "id" = "6722c4a8-9323-4b85-aec9-b99b21bb4af6"
    "kind" = "Private"
    "location" = "USA:Texas:AUSL2"
    "location_id" = "b3b64a26-fdb2-4d4d-9f8d-5096cbb662a6"
    "name" = "Private"
  },
  {
    "host_use" = "Default"
    "id" = "de801a55-df0c-440e-9f9f-74691aae459a"
    "kind" = "Shared"
    "location" = "USA:Texas:AUSL2"
    "location_id" = "b3b64a26-fdb2-4d4d-9f8d-5096cbb662a6"
    "name" = "Storage"
  },
]
ssh-keys = [
  {
    "id" = "153e2a2e-a85a-11e6-b9b7-000c29be8584"
    "name" = "User1 - Linux"
  },
  {
    "id" = "23341abc-a85a-11e6-aa13-000c29be8584"
    "name" = "User2 - Macbook"
  },
]
volumes = [
  {
    "description" = "volume for home"
    "flavor" = "Fast"
    "flavor_id" = "fe2f751e-ef4c-4d60-afb4-f2c87059ed41"
    "id" = "ac8571e9-9948-41d6-a6ad-d39a4c5ceec3"
    "location" = "USA:Texas:AUSL2"
    "location_id" = "b3b64a26-fdb2-4d4d-9f8d-5096cbb662a6"
    "name" = "v1"
    "size" = 0
    "storage_pool" = "Storage_Pool_NVMe"
    "storage_pool_id" = "8cd530bb-9ac2-4e28-9a6d-b7a695940e46"
    "volume_collection" = "AustinCollection"
    "volume_collection_id" = "d5a63736-a03f-4779-8a08-0b3763f86704"
  },
]
storage-pools = [
  {
    "capacity" = 8172
    "id" = "8cd530bb-9ac2-4e28-9a6d-b7a695940e46"
    "location" = "USA:Texas:AUSL2"
    "location_id" = "b3b64a26-fdb2-4d4d-9f8d-5096cbb662a6"
    "name" = "Storage_Pool_NVMe"
  },
  {
    "capacity" = 12288
    "id" = "1a10d988-3ac7-4e4e-9af8-19c0235d1f41"
    "location" = "USA:Texas:AUSL2"
    "location_id" = "b3b64a26-fdb2-4d4d-9f8d-5096cbb662a6"
    "name" = "Storage_Pool_FLASH"
  },
]
"VolumeCollections": [
  {
    "ID": "d5a63736-a03f-4779-8a08-0b3763f86704",
    "Name": "abtest",
    "LocationID": "c8b3c5a7-f81d-453a-af3a-1e6d78291bd5",
    "Description": ""
  },
  {
    "ID": "dd253c2a-defb-41c7-b23d-f9a937c37da0",
    "Name": "abose-tf-test",
    "LocationID": "c8b3c5a7-f81d-453a-af3a-1e6d78291bd5",
    "Description": ""
  }
]
```

### Argument Reference

The available_resources block takes no arguments.


### Attribute Reference

In addition to the arguments listed above, the following attributes are returned to the user:

- `images` - List of available OS images.
   - `category` - The OS categoty, e.g. "linux".
   - `flavor` - The OS flavor, e.g. "ubuntu".
   - `version` - The available OS versions
- `locations` - A list of all available locations where hosts can be provisioned.
   - `country` - The country element of the location, e.g. "USA".
   - `region` - The region element of the location, e.g. "Texas".
   - `data_center` - The data-center element of the location, e.g. "LR4".
   - `location` - The location in country:region:data_center format.
- `networks` - List of networks IDs.
  - `name` - The name of the network, e.g. "Public".
  - `location` - The location of the network in country:region:data_center format.
  - `kind` - The kind of network, e.g. "Shared".
  - `host_use` - The requirement of a host to use this network, e.g. "Required" or "Optional"
- `machine_sizes` - Liat of available machine sizes.
  - `name` - The name of the machine size, e.g. "large".
  - `location` - The location of this size of machine in country:region:data_center format.
  - `quantity` - The number of provisionable machines of this type, e.g. 10.
- `volumes` - List of existing, unattached iSCSI volumes.
  - `name` - The name of the volume.
  - `description` - (Optional) Some descriptive text that helps describe the volume and purpose.
  - `size` - The size of the volume (GiB).
  - `flavor` - The flavor of volume.
  - `storage_pool` - The name of the storage pool.
  - `storage_pool_id` - Unique ID of the storage pool.
  - `volume_collection_id` - Unique ID of the volume collection.
- `volume_flavors` - List of availale volume flavors.
  - `name` - The name of the volume flavor, e.g. "Default".
  - `description` - (Optional) Some descriptive text that helps describe the volume flavor.
- `storage_pools` - List of storage pools.
  - `name` - The name of the storage pool.
  - `location` - The location of the storage pool in country:region:data_center format.
  - `location_id` - Unique ID of the location.
  - `capacity` - The available capacity of the pool (GiB).
- `volume_collections` - List of volume collections.
  - `name` - The name of the volume collection.
  - `location_id` - Unique ID of the location.
  - `description` - The description text that helps describe the volume collection.

