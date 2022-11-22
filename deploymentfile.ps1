# update variables
# $inputFile = './adf/parameters1.json'
# $outputFile = './adf/parameters.json'


# Replace-Tokens `
#   -InputFile $inputFile `
#   -OutputFile $outputFile `
#   -Tokens @{RG="HackathonChallenge1";NAME="hackathonteam1adf"} `
#   -StartTokenPattern "{{" `
#   -EndTokenPattern "}}"

 
 $resourcelist = 'vnet', 'azsql', 'adf', 'adls', 'databricks', 'vm'
  # $resourcelist = 'peering'
 $resourcegroup = "HackathonChallenge11"
foreach ($resource in $resourcelist) {
  $inputFile  = "./$resource/parameters1.json"
  $outputFile  ="./$resource/parameters.json"
  Replace-Tokens `
  -InputFile $inputFile `
  -OutputFile $outputFile `
  -Tokens @{RG=$resourcegroup;NAME=$resource;TEAMCOUNT="11";VNETADDRESS="10.61.0.0/16";SUBNETADDRESS="10.61.0.0/24";VMCOUNT="1" } `
  -StartTokenPattern "{{" `
  -EndTokenPattern "}}"
}
  

# $resourcelist = 'bastion'
$count = 1
foreach ($resource in $resourcelist) {
  $templateFile = "./$resource/template.json"
  $parameterFile ="./$resource/parameters.json"
  $templateFile
  $parameterFile
New-AzResourceGroupDeployment `
  -Name sandboxenvironment$count `
  -ResourceGroupName $resourcegroup `
  -TemplateFile $templateFile `
  -TemplateParameterFile $parameterFile `
  #-WhatIf

  $count = $count + 1
}


