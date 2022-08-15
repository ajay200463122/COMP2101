Param ([Parameter (Mandatory=$false)][switch]$System,
       [Parameter (Mandatory=$false)][switch]$Disks,
       [Parameter (Mandatory=$false)][switch]$Network )


if($System) {
	hardware_description
	os_information 
	processor_information 
	ram_information 
	video_information
}
elseif($Disks) {
	physical_disk_information
}
elseif($Network) {
	network_adapter_information
}
else {
	hardware_description
	os_information 
	processor_information 
	ram_information 
	physical_disk_information 
	network_adapter_information 
	video_information
}