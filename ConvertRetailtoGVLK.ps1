#Requires -RunAsAdministrator
<#

.SYNOPSIS
  Pour convertir une version de windows de RETAIL vers GVLK	

.DESCRIPTION
  Dans un Powershell en mode admin, éxecuter le script.

.PARAMETER <Parameter_Name>
  Key = clef GVLK de l'OS à convertir

.INPUTS
  nada
   
.OUTPUTS
  nada.

.NOTES
  Version:        1.3
  Author:         tiphergane / meoowrwa
  Creation Date:  29/05/2019
  Purpose/Change:   Add Transcript to log the magic
                    Fix an error with the slmgr calls
                    Add key request as parameter
					Initial script development
#>

Start-Transcript -Path .\convert.log
param (
	[Parameter(Mandatory=$true, Position=0)][string]$Key = $( Read-Host "Entrez la clef GVLK: ")
)

function RemoveKey {

cscript C:\Windows\System32\slmgr.vbs -upk
}

function ConvertKey {

cscript C:\Windows\System32\slmgr.vbs -ipk $Key
}

function Activate {

cscript C:\Windows\System32\slmgr.vbs -ato
}

Write-Warning "suppression de l'ancienne clef"
RemoveKey
Write-Warning "Conversion de la version de Windows ©"
ConvertKey
Write-Warning "Activation sur le KMS"
Activate
Write-host "Bonne journée"
Stop-Transcript
#Être con c'est comme être mort, c'est douloureux pour les autres.