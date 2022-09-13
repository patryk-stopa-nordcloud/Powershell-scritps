$vNetName = "EUD_VDI-WEU-VNET01"
$NetResourceGroupName = "EUD_VDI-WEU-NETWORK-RG01"
$VMResourceGroupName = "EUD_VDI-WEU-MS-STANDARD-USERS-GI-RG01"
$VMName = "EUAZ1MSEUTI41"
$NICName = "EUAZ1MSEUTI41-nic"
$Location = "West Europe"
$VirtualNetwork = Get-AzVirtualNetwork -Name $vNetName -ResourceGroupName $NetResourceGroupName
$NIC = New-AzNetworkInterface -Name $NICName -ResourceGroupName $VMResourceGroupName -Location $Location -SubnetId $VirtualNetwork.Subnets[2].Id
$VirtualMachine = New-AzVMConfig -VMName $VMName -VMSize Standard_B2s
$VirtualMachine = Set-AzVMOperatingSystem -VM $VirtualMachine -Windows -ComputerName $VMName -Credential $credential -ProvisionVMAgent -EnableAutoUpdate
$VirtualMachine = Add-AzVMNetworkInterface -VM $VirtualMachine -Id $NIC.Id
$VirtualMachine = Set-AzVMSourceImage -VM $VirtualMachine -PublisherName 'MicrosoftWindowsServer' -Offer 'WindowsServer' -Skus '2012-R2-Datacenter' -Version latest
New-AzVM -ResourceGroupName $VMResourceGroupName -Location $Location -VM $VirtualMachine -Verbose