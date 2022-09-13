Connect-AzAccount

Set-AzContext -SubscriptionId ""

$vmssName = ""

$rgName = ""

$protectedSettings = @{
    
}
    
$publicSettings = @{ 
    
}

$vmss = Get-AzVmss `
    -ResourceGroupName $rgName `
    -VMScaleSetName $vmssName

Add-AzVmssExtension -VirtualMachineScaleSet $vmss `
    -Name "" `
    -Publisher "" `
    -Type "" `
    -TypeHandlerVersion "" `
    -AutoUpgradeMinorVersion $true `
    -Setting $publicSettings `
    -ProtectedSetting $protectedSettings

Update-AzVmss `
    -ResourceGroupName $rgName `
    -Name $vmssName `
    -VirtualMachineScaleSet $vmss