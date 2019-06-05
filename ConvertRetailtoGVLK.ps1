param (
  [Parameter(Mandatory=$true, Position=0, HelpMessage='ConvertRetailtoGVLK.ps1 -Key la-clef-windows')][string]$Key = $( Read-Host "Entrez la clef GVLK: ")
)

#Requires -RunAsAdministrator
<#

.SYNOPSIS
  Pour convertir une version de windows de RETAIL vers GVLK	

.DESCRIPTION
  Dans un Powershell en mode admin, éxecuter le script.

.PARAMETER <Parameter_Name>
  

.INPUTS
  Key = clef GVLK de l'OS à convertir
   
.OUTPUTS
  convert.log à la racine du script.
  
.EXAMPLE
  ConvertRetailtoGVLK.ps1 -Key la-clef-windows
  
.NOTES
  Version:        1.3.2
  Author:         tiphergane / meoowrwa
  Creation Date:  29/05/2019
  Purpose/Change:   Add comment in the script (all good code is commented FFS)
                    Add Transcript to log the magic and make the param magic work
                    Fix an error with the slmgr calls
                    Add key request as parameter
                    Initial script development
#>

# Démarre le log du script.
Start-Transcript -Path .\convert.log

#region fonction
function RemoveKey {
# Supprime la clef précédement installée
cscript C:\Windows\System32\slmgr.vbs //nologo -upk
}

function ConvertKey {
# On change pour la clef donnée en argument ou demandée à l'execution
cscript C:\Windows\System32\slmgr.vbs //nologo -ipk $Key
}

function Activate {
# Active Windows auprès du serveur KMS
cscript C:\Windows\System32\slmgr.vbs //nologo -ato
}
#endregion fonction

Write-Warning "suppression de l'ancienne clef"
RemoveKey
Write-Warning "Conversion de la version de Windows ©"
ConvertKey
Write-Warning "Activation sur le KMS"
Activate
Write-host "Bonne journée"
Stop-Transcript
#Être con c'est comme être mort, c'est douloureux pour les autres.